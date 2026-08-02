package hxluau;

#if !cpp
#error 'Luau supports only C++ target platforms.'
#end
import hxluau.Types;

/** hxluau helpers for loading and running scripts, the bytecode cache, codegen, and compiler options. */
@:buildXml('<include name="${haxelib:hxluau}/project/Build.xml" />')
@:include('lua.h')
@:include('lualib.h')
@:include('luacode.h')
@:include('LuauImpl.h')
@:unreflective
extern class Luau
{
	/**
	 * Compiles and loads a file, leaving the resulting function on the stack.
	 * @param L Lua state.
	 * @param filename File to load.
	 * @return 0 on success, or an error code.
	 */
	@:native("hxluau_loadfile_wrapper")
	static function loadfile(L:cpp.RawPointer<Lua_State>, filename:cpp.ConstCharStar):Int;

	/**
	 * Compiles and loads a string, leaving the resulting function on the stack.
	 * @param L Lua state.
	 * @param s Source to load.
	 * @return 0 on success, or an error code.
	 */
	@:native("hxluau_loadstring_wrapper")
	static function loadstring(L:cpp.RawPointer<Lua_State>, s:cpp.ConstCharStar):Int;

	/**
	 * Compiles and runs a file.
	 * @param L Lua state.
	 * @param filename File to run.
	 * @return 0 on success, or an error code.
	 */
	@:native("hxluau_dofile_wrapper")
	static function dofile(L:cpp.RawPointer<Lua_State>, filename:cpp.ConstCharStar):Int;

	/**
	 * Compiles and runs a string.
	 * @param L Lua state.
	 * @param str Source to run.
	 * @return 0 on success, or an error code.
	 */
	@:native("hxluau_dostring_wrapper")
	static function dostring(L:cpp.RawPointer<Lua_State>, str:cpp.ConstCharStar):Int;

	/**
	 * Installs hxluau's `print` implementation as the global `print`.
	 * @param L Lua state.
	 */
	@:native("hxluau_register_print")
	static function registerPrint(L:cpp.RawPointer<Lua_State>):Void;

	/** Clears the bytecode cache used by file loads. */
	@:native("hxluau_bytecode_cache_clear")
	static function bytecodeCacheClear():Void;

	/**
	 * Sets the bytecode cache capacity (default 128 entries).
	 * @param cap New capacity, greater than zero.
	 */
	@:native("hxluau_bytecode_cache_set_capacity")
	static function bytecodeCacheSetCapacity(cap:Int):Void;

	/**
	 * Soft-resets the VM by running a full GC and resetting the main thread,
	 * keeping libraries and globals intact.
	 * @param L Lua state.
	 */
	@:native("hxluau_vm_soft_reset")
	static function vmSoftReset(L:cpp.RawPointer<Lua_State>):Void;

	/**
	 * Enables or disables autocompile (AOT-compiling hot functions) for a state.
	 * @param L Lua state.
	 * @param enable 1 to enable, 0 to disable.
	 */
	@:native('hxluau_enable_autocompile')
	static function enableAutoCompile(L:cpp.RawPointer<Lua_State>, enable:Int):Void;

	/**
	 * Sets the hot-call threshold that triggers autocompile.
	 * @param threshold Call count before a function is compiled.
	 */
	@:native('hxluau_set_autocompile_threshold')
	static function setAutoCompileThreshold(threshold:Int):Void;

	/**
	 * Enables or disables native codegen for loaded chunks (where supported).
	 * @param enable 1 to enable, 0 to disable.
	 */
	@:native("hxluau_enable_codegen")
	static function enableCodegen(enable:Int):Void;

	/**
	 * Sets global compiler options.
	 * @param optimizationLevel 0 to 2, where 2 is fastest.
	 * @param debugLevel 0 to 2, where 0 means no debug info.
	 * @param typeInfoLevel 0 or 1, where 1 emits type info for all modules.
	 */
	@:native("hxluau_set_compile_options")
	static function setCompileOptions(optimizationLevel:Int, debugLevel:Int, typeInfoLevel:Int):Void;

	/**
	 * Sets the coverage level for compilation.
	 * @param level 0 for none, 1 for statement, 2 for statement and expression.
	 */
	@:native("hxluau_set_compile_coverage")
	static function setCompileCoverage(level:Int):Void;

	/**
	 * Sets the vector library builtin used by the compiler.
	 * @param lib Library name, or null for the default.
	 */
	@:native("hxluau_set_compile_vector_lib")
	static function setCompileVectorLib(lib:cpp.ConstCharStar):Void;

	/**
	 * Sets the vector type name used in type tables.
	 * @param type Type name, or null for the default "vector".
	 */
	@:native("hxluau_set_compile_vector_type")
	static function setCompileVectorType(type:cpp.ConstCharStar):Void;

	/**
	 * Sets the vector constructor name used by the compiler.
	 * @param ctor Constructor name, or null for the default.
	 */
	@:native("hxluau_set_compile_vector_ctor")
	static function setCompileVectorCtor(ctor:cpp.ConstCharStar):Void;

	/**
	 * Sets the vector component precision used by the compiler's constant folding.
	 * Must match the VM's own LUA_VECTOR_DOUBLE build setting to be meaningful.
	 * @param precision 0 for 32-bit float components, 1 for 64-bit double components.
	 */
	@:native("hxluau_set_compile_vector_precision")
	static function setCompileVectorPrecision(precision:Int):Void;

	/**
	 * Sets the globals treated as mutable (disables import optimization for their fields).
	 * @param globals Null-terminated array of names, or null for none.
	 */
	@:native("hxluau_set_compile_mutable_globals")
	static function setCompileMutableGlobals(globals:cpp.RawPointer<cpp.RawConstPointer<cpp.Char>>):Void;

	/**
	 * Sets the userdata types included in type information.
	 * @param types Null-terminated array of type names, or null for none.
	 */
	@:native("hxluau_set_compile_userdata_types")
	static function setCompileUserdataTypes(types:cpp.RawPointer<cpp.RawConstPointer<cpp.Char>>):Void;

	/**
	 * Sets the builtins excluded from fast-call optimization.
	 * @param builtins Null-terminated array of "name" or "lib.name" entries, or null.
	 */
	@:native("hxluau_set_compile_disabled_builtins")
	static function setCompileDisabledBuiltins(builtins:cpp.RawPointer<cpp.RawConstPointer<cpp.Char>>):Void;

	/**
	 * Enables or disables native codegen counter recording for this process.
	 * Counters track per-block native execution stats (regular and fallback
	 * blocks executed, VM exits taken), read back via `Lua.getcounters`.
	 * @param enable 1 to enable, 0 to disable.
	 */
	@:native("hxluau_enable_counter_support")
	static function enableCounterSupport(enable:Int):Void;

	/**
	 * Whether counter support was enabled via `enableCounterSupport`.
	 * @return 1 if enabled, 0 otherwise.
	 */
	@:native("hxluau_counter_support_enabled")
	static function counterSupportEnabled():Int;

	#if !HXLUAU_DISABLE_FFI
	/**
	 * Opens the cffi library (libffi-based C FFI) into a state.
	 * @param L Lua state.
	 * @return 1 (the cffi table is left on the stack).
	 */
	@:native('hxluau_open_cffi')
	static function openCFFI(L:cpp.RawPointer<Lua_State>):Int;
	#end
}
