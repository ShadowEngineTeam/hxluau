package hxluau;

#if !cpp
#error 'Luau supports only C++ target platforms.'
#end
import hxluau.Types;

@:buildXml('<include name="${haxelib:hxluau}/project/Build.xml" />')
@:include('lua.h')
@:include('lualib.h')
@:include('HxRequire.h')
@:unreflective
extern class Require
{
	/**
	 * Opens require-by-string and registers it as the global `require`.
	 * @param L Lua state.
	 * @param baseDir Fallback for chunks with no file behind them; null or empty means the working directory.
	 */
	@:native('hxluau_open_require')
	static function open(L:cpp.RawPointer<Lua_State>, baseDir:cpp.ConstCharStar):Void;

	/**
	 * Pushes the require closure without registering it globally.
	 * @param L Lua state.
	 * @param baseDir Fallback for chunks with no file behind them; null or empty means the working directory.
	 * @return 1 (the closure is left on the stack).
	 */
	@:native('hxluau_push_require')
	static function push(L:cpp.RawPointer<Lua_State>, baseDir:cpp.ConstCharStar):Int;

	/**
	 * Pushes a `proxyrequire` closure, resolving a path as if required from the module
	 * named by a given chunkname.
	 * @param L Lua state.
	 * @param baseDir Fallback for chunks with no file behind them; null or empty means the working directory.
	 * @return 1 (the closure is left on the stack).
	 */
	@:native('hxluau_push_proxyrequire')
	static function pushProxy(L:cpp.RawPointer<Lua_State>, baseDir:cpp.ConstCharStar):Int;

	/**
	 * Resolves `require("@alias/module")` against `path`. Fills in only what a script's
	 * own `.luaurc` or `.config.luau` leaves undefined; names are case-insensitive.
	 * @param L Lua state.
	 * @param alias Alias name, without the leading `@`.
	 * @param path Directory or module the alias points at.
	 * @return 1 on success, 0 if `require` has not been opened on this state.
	 */
	@:native('hxluau_require_set_alias')
	static function setAlias(L:cpp.RawPointer<Lua_State>, alias:cpp.ConstCharStar, path:cpp.ConstCharStar):Int;

	/**
	 * Removes every host-provided alias, leaving configuration-file aliases untouched.
	 * @param L Lua state.
	 * @return 1 on success, 0 if `require` has not been opened on this state.
	 */
	@:native('hxluau_require_clear_aliases')
	static function clearAliases(L:cpp.RawPointer<Lua_State>):Int;

	/**
	 * Registers a preloaded module for an aliased path, which then always returns it.
	 * Expects the path and module pushed as arguments, in order.
	 * @param L Lua state.
	 * @return Number of results pushed.
	 */
	@:native('hxluau_require_registermodule')
	static function registerModule(L:cpp.RawPointer<Lua_State>):Int;

	/**
	 * Clears one require-cache entry, keyed by absolute path, pushed as an argument.
	 * @param L Lua state.
	 * @return Number of results pushed.
	 */
	@:native('hxluau_require_clearcacheentry')
	static function clearCacheEntry(L:cpp.RawPointer<Lua_State>):Int;

	/**
	 * Clears the whole require cache, so each module runs again on its next `require`.
	 * @param L Lua state.
	 * @return Number of results pushed.
	 */
	@:native('hxluau_require_clearcache')
	static function clearCache(L:cpp.RawPointer<Lua_State>):Int;
}
