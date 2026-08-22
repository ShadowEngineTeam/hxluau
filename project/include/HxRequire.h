#ifndef HXLUAU_REQUIRE_H
#define HXLUAU_REQUIRE_H

#include "lua.h"

#ifdef __cplusplus
extern "C" {
#endif

// Luau ships no `require`: module resolution is left to the host. These entry points
// install Luau's official require-by-string library over a filesystem navigation
// context, giving scripts `require("./module")`, `require("../dir/module")` and
// `@alias/module`, with aliases from .luaurc or .config.luau as in the luau CLI.
//
// `baseDir` is what relative requires resolve against for chunks with no file behind
// them (code loaded with dostring); NULL or empty means the working directory. Chunks
// loaded from a file always resolve relative to that file instead.

// Opens require-by-string and registers it as the global `require`.
void hxluau_open_require(lua_State* L, const char* baseDir);

// Pushes the require closure without registering it globally. Returns 1.
int hxluau_push_require(lua_State* L, const char* baseDir);

// Pushes a "proxyrequire" closure, taking a path and an existing module's chunkname,
// and resolving the path as if required from that module. Returns 1.
int hxluau_push_proxyrequire(lua_State* L, const char* baseDir);

// Resolves `require("@alias/module")` against `path` (relative to baseDir). Consulted
// only when no .luaurc or .config.luau defines the alias, so a script's own config
// always wins. Names are case-insensitive and exclude the leading '@'. Returns 1 on
// success, 0 if require is not open on L.
int hxluau_require_set_alias(lua_State* L, const char* alias, const char* path);

// Removes every host-provided alias from the state.
int hxluau_require_clear_aliases(lua_State* L);

// Registers a preloaded module under an aliased require path, which then always
// returns that result. Expects the path and module table pushed as arguments.
int hxluau_require_registermodule(lua_State* L);

// Clears one require-cache entry, keyed by absolute path, pushed as an argument.
int hxluau_require_clearcacheentry(lua_State* L);

// Clears every entry from the require cache.
int hxluau_require_clearcache(lua_State* L);

#ifdef __cplusplus
}
#endif

#endif // HXLUAU_REQUIRE_H
