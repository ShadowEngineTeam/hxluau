#ifndef HXLUAU_LUA_IMPL_H
#define HXLUAU_LUA_IMPL_H

#include "lua.h"

#include <stddef.h>

#ifdef __cplusplus
extern "C" {
#endif

// Compiles and loads a string via Luau, like luaL_loadstring.
int hxluau_loadstring_wrapper(lua_State* L, const char* s);

// Compiles `source` with the global compile options and loads it into L under
// `chunkname`, applying codegen when enabled. Returns luau_load's status.
int hxluau_load_buffer(lua_State* L, const char* chunkname, const char* source, size_t sourceSize);

// Compiles and loads a file via Luau, like luaL_loadfile.
int hxluau_loadfile_wrapper(lua_State* L, const char* filename);

// Compiles and runs a string, like luaL_dostring.
int hxluau_dostring_wrapper(lua_State* L, const char* str);

// Compiles and runs a file, like luaL_dofile.
int hxluau_dofile_wrapper(lua_State* L, const char* filename);

// Install a custom print as the global 'print'.
void hxluau_register_print(lua_State* L);

// Bytecode cache control
void hxluau_bytecode_cache_clear();
void hxluau_bytecode_cache_set_capacity(int cap);

// VM soft reset. Collects garbage and resets the main thread without destroying the VM.
void hxluau_vm_soft_reset(lua_State* L);

// Enable or disable Luau native codegen (ahead-of-time) for loaded chunks.
// 0 disables, non-zero enables.
void hxluau_enable_codegen(int enable);

// Configure global compile options used by luau_compile
void hxluau_set_compile_options(int optimizationLevel, int debugLevel, int typeInfoLevel);

// Autocompile (hot-counter) control
void hxluau_enable_autocompile(lua_State* L, int enable);
void hxluau_set_autocompile_threshold(int threshold);

// Extended compile option setters
void hxluau_set_compile_coverage(int coverageLevel);
void hxluau_set_compile_vector_lib(const char* lib);
void hxluau_set_compile_vector_type(const char* type);
void hxluau_set_compile_vector_ctor(const char* ctor);
void hxluau_set_compile_mutable_globals(const char* const* mutableGlobals);
void hxluau_set_compile_userdata_types(const char* const* userdataTypes);
void hxluau_set_compile_disabled_builtins(const char* const* disabledBuiltins);

// Codegen counter recording intent (see LuauImpl.cpp for details)
void hxluau_enable_counter_support(int enable);
int hxluau_counter_support_enabled();

// Open the cffi-luau library (wraps extern "C" luaopen_cffi)
int hxluau_open_cffi(lua_State* L);

// Version information (update when vendored Luau library changes)
const char* hxluau_version_string();
const char* hxluau_version_release();
int hxluau_version_num();

#ifdef __cplusplus
}
#endif

#endif // HXLUAU_LUA_IMPL_H