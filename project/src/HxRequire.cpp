// hxcpp precompiled header must be included first
#include "hxcpp.h"

#include "HxRequire.h"

#include "LuauImpl.h"

#include "Luau/FileUtils.h"
#include "Luau/Require.h"
#include "Luau/VfsNavigator.h"

#include "lua.h"
#include "lualib.h"

#include <new>
#include <optional>
#include <unordered_map>
#include <string.h>
#include <string>
#include <string_view>

// The navigation state handed to require-by-string as its opaque context.
//
// `virtualDepth` covers requirers with no file on disk (code loaded from a string).
// Relative requires always navigate to the requirer's parent first, so those chunks
// anchor at `baseDir` pretending to sit one level below it: the first to_parent is
// absorbed here, landing on `baseDir` so that `require("./foo")` finds `baseDir/foo`.
struct HxRequirer
{
    VfsNavigator vfs;
    std::string baseDir;
    int virtualDepth = 0;

    // Host-supplied aliases, consulted only when no configuration file defines
    // the alias. Keys are lowercased, matching Luau's case-insensitive aliases.
    std::unordered_map<std::string, std::string> aliases;
};

// Where hxluau_open_require stashes its requirer, so the alias API can find it again
// from just the state.
static const char* kRequirerRegistryKey = "hxluau.requirer";

static std::string toLower(std::string s)
{
    for (char& c : s)
    {
        if ('A' <= c && c <= 'Z')
            c += 'a' - 'A';
    }
    return s;
}

static luarequire_WriteResult write(std::optional<std::string> contents, char* buffer, size_t bufferSize, size_t* sizeOut)
{
    if (!contents)
        return WRITE_FAILURE;

    size_t nullTerminatedSize = contents->size() + 1;

    if (bufferSize < nullTerminatedSize)
    {
        *sizeOut = nullTerminatedSize;
        return WRITE_BUFFER_TOO_SMALL;
    }

    *sizeOut = nullTerminatedSize;
    memcpy(buffer, contents->c_str(), nullTerminatedSize);
    return WRITE_SUCCESS;
}

static luarequire_NavigateResult convert(NavigationStatus status)
{
    if (status == NavigationStatus::Success)
        return NAVIGATE_SUCCESS;
    else if (status == NavigationStatus::Ambiguous)
        return NAVIGATE_AMBIGUOUS;
    else
        return NAVIGATE_NOT_FOUND;
}

static luarequire_ConfigStatus convert(VfsNavigator::ConfigStatus status)
{
    if (status == VfsNavigator::ConfigStatus::Ambiguous)
        return CONFIG_AMBIGUOUS;
    else if (status == VfsNavigator::ConfigStatus::PresentJson)
        return CONFIG_PRESENT_JSON;
    else if (status == VfsNavigator::ConfigStatus::PresentLuau)
        return CONFIG_PRESENT_LUAU;
    else
        return CONFIG_ABSENT;
}

// Resolves a path against the requirer's base directory, leaving absolute paths alone.
static std::string resolveAgainstBase(const HxRequirer* req, const std::string& path)
{
    if (isAbsolutePath(path))
        return normalizePath(path);

    return normalizePath(joinPaths(req->baseDir, path));
}

static bool is_require_allowed(lua_State* L, void* ctx, const char* requirer_chunkname)
{
    // Unlike the luau CLI, chunks loaded from a string are allowed to require:
    // they resolve relative to the configured base directory.
    return true;
}

static luarequire_NavigateResult reset(lua_State* L, void* ctx, const char* requirer_chunkname)
{
    HxRequirer* req = static_cast<HxRequirer*>(ctx);
    req->virtualDepth = 0;

    std::string chunkname = requirer_chunkname ? requirer_chunkname : "";

    // "@path" is the conventional file chunkname; hxluau's own loaders pass the path
    // unprefixed. "=name" always denotes a synthetic chunk.
    std::string path;
    if (!chunkname.empty() && chunkname[0] == '@')
        path = chunkname.substr(1);
    else if (!chunkname.empty() && chunkname[0] != '=')
        path = chunkname;

    if (!path.empty())
    {
        std::string candidate = resolveAgainstBase(req, path);
        if (isFile(candidate))
            return convert(req->vfs.resetToPath(candidate));
    }

    NavigationStatus status = req->vfs.resetToPath(req->baseDir);
    if (status != NavigationStatus::Success)
        return convert(status);

    req->virtualDepth = 1;
    return NAVIGATE_SUCCESS;
}

static luarequire_NavigateResult jump_to_alias(lua_State* L, void* ctx, const char* path)
{
    HxRequirer* req = static_cast<HxRequirer*>(ctx);
    req->virtualDepth = 0;

    return convert(req->vfs.resetToPath(resolveAgainstBase(req, path)));
}

// Consulted only after the configuration-file search comes up empty, so a mod's
// own .luaurc always takes precedence over host-registered aliases.
static luarequire_NavigateResult to_alias_fallback(lua_State* L, void* ctx, const char* alias_unprefixed)
{
    HxRequirer* req = static_cast<HxRequirer*>(ctx);

    auto it = req->aliases.find(toLower(alias_unprefixed ? alias_unprefixed : ""));
    if (it == req->aliases.end())
        return NAVIGATE_NOT_FOUND;

    req->virtualDepth = 0;
    return convert(req->vfs.resetToPath(resolveAgainstBase(req, it->second)));
}

static luarequire_NavigateResult to_parent(lua_State* L, void* ctx)
{
    HxRequirer* req = static_cast<HxRequirer*>(ctx);

    if (req->virtualDepth > 0)
    {
        req->virtualDepth--;
        return NAVIGATE_SUCCESS;
    }

    return convert(req->vfs.toParent());
}

static luarequire_NavigateResult to_child(lua_State* L, void* ctx, const char* name)
{
    HxRequirer* req = static_cast<HxRequirer*>(ctx);

    // The synthetic anchor stands in for a module, and string chunks have no children.
    if (req->virtualDepth > 0)
        return NAVIGATE_NOT_FOUND;

    return convert(req->vfs.toChild(name));
}

static bool is_module_present(lua_State* L, void* ctx)
{
    HxRequirer* req = static_cast<HxRequirer*>(ctx);

    if (req->virtualDepth > 0)
        return false;

    return isFile(req->vfs.getFilePath());
}

static luarequire_WriteResult get_chunkname(lua_State* L, void* ctx, char* buffer, size_t buffer_size, size_t* size_out)
{
    HxRequirer* req = static_cast<HxRequirer*>(ctx);
    return write("@" + req->vfs.getFilePath(), buffer, buffer_size, size_out);
}

static luarequire_WriteResult get_loadname(lua_State* L, void* ctx, char* buffer, size_t buffer_size, size_t* size_out)
{
    HxRequirer* req = static_cast<HxRequirer*>(ctx);
    return write(req->vfs.getAbsoluteFilePath(), buffer, buffer_size, size_out);
}

static luarequire_WriteResult get_cache_key(lua_State* L, void* ctx, char* buffer, size_t buffer_size, size_t* size_out)
{
    HxRequirer* req = static_cast<HxRequirer*>(ctx);
    return write(req->vfs.getAbsoluteFilePath(), buffer, buffer_size, size_out);
}

static luarequire_ConfigStatus get_config_status(lua_State* L, void* ctx)
{
    HxRequirer* req = static_cast<HxRequirer*>(ctx);

    if (req->virtualDepth > 0)
        return CONFIG_ABSENT;

    return convert(req->vfs.getConfigStatus());
}

static luarequire_WriteResult get_config(lua_State* L, void* ctx, char* buffer, size_t buffer_size, size_t* size_out)
{
    HxRequirer* req = static_cast<HxRequirer*>(ctx);
    return write(req->vfs.getConfig(), buffer, buffer_size, size_out);
}

static int load(lua_State* L, void* ctx, const char* path, const char* chunkname, const char* loadname)
{
    // The module runs on its own thread, isolated from the requirer, created on the
    // main thread so that it does not inherit L's environment.
    lua_State* GL = lua_mainthread(L);
    lua_State* ML = lua_newthread(GL);
    lua_xmove(GL, L, 1);

    luaL_sandboxthread(ML);

    bool hadContents = false;
    int status = LUA_OK;

    // Scoped so the C++ objects are destroyed before any luaL_error longjmp.
    {
        std::optional<std::string> contents = readFile(loadname);
        hadContents = contents.has_value();

        if (contents)
            status = hxluau_load_buffer(ML, chunkname, contents->data(), contents->size());
    }

    if (!hadContents)
        luaL_error(L, "could not read file '%s'", loadname);

    if (status == 0)
    {
        // Modules using `export` need a placeholder up front to short-circuit cycles.
        if (lua_usesexport(ML, -1) != 0)
            luarequire_createplaceholder(L);

        int resumeStatus = lua_resume(ML, L, 0);

        if (resumeStatus == 0)
        {
            if (lua_gettop(ML) != 1)
                luaL_error(L, "module must return a single value");
        }
        else if (resumeStatus == LUA_YIELD)
        {
            luaL_error(L, "module can not yield");
        }
        else if (!lua_isstring(ML, -1))
        {
            luaL_error(L, "unknown error while running module");
        }
        else
        {
            luaL_error(L, "error while running module: %s", lua_tostring(ML, -1));
        }
    }
    else
    {
        // Compile or load failure leaves the message on ML's stack.
        if (lua_isstring(ML, -1))
            luaL_error(L, "error while loading module: %s", lua_tostring(ML, -1));

        luaL_error(L, "unknown error while loading module");
    }

    // Move the module result over to L and drop the module thread.
    lua_xmove(ML, L, 1);
    lua_remove(L, -2);

    return 1;
}

static void requireConfigInit(luarequire_Configuration* config)
{
    if (config == nullptr)
        return;

    config->is_require_allowed = is_require_allowed;
    config->reset = reset;
    config->jump_to_alias = jump_to_alias;
    config->to_alias_fallback = to_alias_fallback;
    config->to_parent = to_parent;
    config->to_child = to_child;
    config->is_module_present = is_module_present;
    config->get_config_status = get_config_status;
    config->get_chunkname = get_chunkname;
    config->get_loadname = get_loadname;
    config->get_cache_key = get_cache_key;
    config->get_config = get_config;
    config->load = load;
}

// Allocated as a registry-anchored userdata so its lifetime matches the state's:
// require-by-string holds the raw pointer for as long as the closure lives.
static HxRequirer* createRequirer(lua_State* L, const char* baseDir)
{
    void* mem = lua_newuserdatadtor(
        L,
        sizeof(HxRequirer),
        [](void* data)
        {
            static_cast<HxRequirer*>(data)->~HxRequirer();
        }
    );

    HxRequirer* req = new (mem) HxRequirer();

    std::string dir = baseDir ? baseDir : "";
    if (dir.empty())
    {
        if (std::optional<std::string> cwd = getCurrentWorkingDirectory())
            dir = *cwd;
        else
            dir = ".";
    }

    req->baseDir = isAbsolutePath(dir) ? normalizePath(dir) : normalizePath(joinPaths(getCurrentWorkingDirectory().value_or("."), dir));

    lua_ref(L, -1);
    lua_pop(L, 1);

    return req;
}

extern "C" {

void hxluau_open_require(lua_State* L, const char* baseDir)
{
    HxRequirer* req = createRequirer(L, baseDir);

    lua_pushlightuserdata(L, req);
    lua_setfield(L, LUA_REGISTRYINDEX, kRequirerRegistryKey);

    luaopen_require(L, requireConfigInit, req);
}

int hxluau_push_require(lua_State* L, const char* baseDir)
{
    return luarequire_pushrequire(L, requireConfigInit, createRequirer(L, baseDir));
}

int hxluau_push_proxyrequire(lua_State* L, const char* baseDir)
{
    return luarequire_pushproxyrequire(L, requireConfigInit, createRequirer(L, baseDir));
}

// Null if require was never opened on this state.
static HxRequirer* primaryRequirer(lua_State* L)
{
    lua_getfield(L, LUA_REGISTRYINDEX, kRequirerRegistryKey);
    HxRequirer* req = static_cast<HxRequirer*>(lua_tolightuserdata(L, -1));
    lua_pop(L, 1);
    return req;
}

int hxluau_require_set_alias(lua_State* L, const char* alias, const char* path)
{
    HxRequirer* req = primaryRequirer(L);
    if (!req || !alias || !path)
        return 0;

    req->aliases[toLower(alias)] = path;
    return 1;
}

int hxluau_require_clear_aliases(lua_State* L)
{
    HxRequirer* req = primaryRequirer(L);
    if (!req)
        return 0;

    req->aliases.clear();
    return 1;
}

int hxluau_require_registermodule(lua_State* L)
{
    return luarequire_registermodule(L);
}

int hxluau_require_clearcacheentry(lua_State* L)
{
    return luarequire_clearcacheentry(L);
}

int hxluau_require_clearcache(lua_State* L)
{
    return luarequire_clearcache(L);
}

} // extern "C"
