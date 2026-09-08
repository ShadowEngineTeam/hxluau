package hxluau;

#if !cpp
#error 'Luau supports only C++ target platforms.'
#end
import hxluau.Luau;
import hxluau.Types;

/** Opens the standard Luau libraries (and the cffi extension) into a state. */
@:buildXml('<include name="${haxelib:hxluau}/project/Build.xml" />')
@:include('lua.h')
@:include('lualib.h')
@:include('LuauImpl.h')
@:unreflective
extern class LuaOpen
{
	/** Global name the `coroutine` library registers under. */
	@:native('::String(LUA_COLIBNAME)')
	static var COLIBNAME(default, null):String;

	/** Global name the `table` library registers under. */
	@:native('::String(LUA_TABLIBNAME)')
	static var TABLIBNAME(default, null):String;

	/** Global name the `os` library registers under. */
	@:native('::String(LUA_OSLIBNAME)')
	static var OSLIBNAME(default, null):String;

	/** Global name the `string` library registers under. */
	@:native('::String(LUA_STRLIBNAME)')
	static var STRLIBNAME(default, null):String;

	/** Global name the `bit32` library registers under. */
	@:native('::String(LUA_BITLIBNAME)')
	static var BITLIBNAME(default, null):String;

	/** Global name the `buffer` library registers under. */
	@:native('::String(LUA_BUFFERLIBNAME)')
	static var BUFFERLIBNAME(default, null):String;

	/** Global name the `utf8` library registers under. */
	@:native('::String(LUA_UTF8LIBNAME)')
	static var UTF8LIBNAME(default, null):String;

	/** Global name the `class` library registers under. */
	@:native('::String(LUA_CLASSLIBNAME)')
	static var CLASSLIBNAME(default, null):String;

	/** Global name the `math` library registers under. */
	@:native('::String(LUA_MATHLIBNAME)')
	static var MATHLIBNAME(default, null):String;

	/** Global name the `debug` library registers under. */
	@:native('::String(LUA_DBLIBNAME)')
	static var DBLIBNAME(default, null):String;

	/** Global name the `vector` library registers under. */
	@:native('::String(LUA_VECLIBNAME)')
	static var VECLIBNAME(default, null):String;

	/** Global name the `integer` library registers under. */
	@:native('::String(LUA_INTLIBNAME)')
	static var INTLIBNAME(default, null):String;

	/**
	 * Opens the `base` library.
	 * @param L Lua state.
	 * @return Number of results pushed.
	 */
	@:native('luaopen_base')
	static function base(L:cpp.RawPointer<Lua_State>):Int;

	/**
	 * Opens the `math` library.
	 * @param L Lua state.
	 * @return Number of results pushed.
	 */
	@:native('luaopen_math')
	static function math(L:cpp.RawPointer<Lua_State>):Int;

	/**
	 * Opens the `string` library.
	 * @param L Lua state.
	 * @return Number of results pushed.
	 */
	@:native('luaopen_string')
	static function string(L:cpp.RawPointer<Lua_State>):Int;

	/**
	 * Opens the `table` library.
	 * @param L Lua state.
	 * @return Number of results pushed.
	 */
	@:native('luaopen_table')
	static function table(L:cpp.RawPointer<Lua_State>):Int;

	/**
	 * Opens the `coroutine` library.
	 * @param L Lua state.
	 * @return Number of results pushed.
	 */
	@:native('luaopen_coroutine')
	static function coroutine(L:cpp.RawPointer<Lua_State>):Int;

	/**
	 * Opens the `bit32` library.
	 * @param L Lua state.
	 * @return Number of results pushed.
	 */
	@:native('luaopen_bit32')
	static function bit32(L:cpp.RawPointer<Lua_State>):Int;

	/**
	 * Opens the `utf8` library.
	 * @param L Lua state.
	 * @return Number of results pushed.
	 */
	@:native('luaopen_utf8')
	static function utf8(L:cpp.RawPointer<Lua_State>):Int;

	/**
	 * Opens the `buffer` library.
	 * @param L Lua state.
	 * @return Number of results pushed.
	 */
	@:native('luaopen_buffer')
	static function buffer(L:cpp.RawPointer<Lua_State>):Int;

	/**
	 * Opens the `class` library.
	 * @param L Lua state.
	 * @return Number of results pushed.
	 */
	@:native('luaopen_class')
	static function classlib(L:cpp.RawPointer<Lua_State>):Int;

	/**
	 * Opens the `os` library.
	 * @param L Lua state.
	 * @return Number of results pushed.
	 */
	@:native('luaopen_os')
	static function os(L:cpp.RawPointer<Lua_State>):Int;

	/**
	 * Opens the `debug` library.
	 * @param L Lua state.
	 * @return Number of results pushed.
	 */
	@:native('luaopen_debug')
	static function debug(L:cpp.RawPointer<Lua_State>):Int;

	/**
	 * Opens the `vector` library.
	 * @param L Lua state.
	 * @return Number of results pushed.
	 */
	@:native('luaopen_vector')
	static function vector(L:cpp.RawPointer<Lua_State>):Int;

	/**
	 * Opens the `integer` library.
	 * @param L Lua state.
	 * @return Number of results pushed.
	 */
	@:native('luaopen_integer')
	static function integer(L:cpp.RawPointer<Lua_State>):Int;

	#if !HXLUAU_DISABLE_FFI
	/**
	 * Opens the cffi library, leaving its module table on the stack.
	 * Register it globally with `Lua.setglobal(vm, "ffi")` (or use `Cffi.register`).
	 * @param L Lua state.
	 * @return 1 (the cffi table is left on the stack).
	 */
	inline static function cffi(L:cpp.RawPointer<Lua_State>):Int
	{
		return Luau.openCFFI(L);
	}
	#end
}
