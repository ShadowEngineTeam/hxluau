package hxluau;

#if !cpp
#error 'Luau supports only C++ target platforms.'
#end
import hxluau.Types;

/** Lua auxiliary library (the `luaL_` functions) for argument checking, buffers, error helpers, and setup. */
@:buildXml('<include name="${haxelib:hxluau}/project/Build.xml" />')
@:include('lua.h')
@:include('lualib.h')
@:include('luacode.h')
@:include('LuauImpl.h')
@:unreflective
extern class LuaL
{
	/**
	 * Pushes a field from the object's metatable, if present.
	 * @param L Lua state.
	 * @param obj Stack index of the object.
	 * @param e Metafield name.
	 * @return The type of the pushed field, or `Lua.TNIL` if absent.
	 */
	@:native('luaL_getmetafield')
	static function getmetafield(L:cpp.RawPointer<Lua_State>, obj:Int, e:cpp.ConstCharStar):Int;

	/**
	 * Calls a metamethod of the object, if present.
	 * @param L Lua state.
	 * @param obj Stack index of the object.
	 * @param e Metamethod name.
	 * @return 1 if a metamethod was called (result left on the stack), 0 otherwise.
	 */
	@:native('luaL_callmeta')
	static function callmeta(L:cpp.RawPointer<Lua_State>, obj:Int, e:cpp.ConstCharStar):Int;

	/**
	 * Raises an error about an argument. Does not return.
	 * @param L Lua state.
	 * @param numarg Argument index.
	 * @param extramsg Extra message appended to the error.
	 */
	@:native('luaL_argerror')
	static function argerror(L:cpp.RawPointer<Lua_State>, numarg:Int, extramsg:cpp.ConstCharStar):Void;

	/**
	 * Raises a type error for an argument. Does not return.
	 * @param L Lua state.
	 * @param narg Argument index.
	 * @param tname Expected type name.
	 */
	@:native('luaL_typeerrorL')
	static function typeerror(L:cpp.RawPointer<Lua_State>, narg:Int, tname:cpp.ConstCharStar):Void;

	/**
	 * Checks that an argument is a string and returns it.
	 * @param L Lua state.
	 * @param numArg Argument index.
	 * @param l Receives the string length (may be null).
	 * @return The string.
	 */
	@:native('luaL_checklstring')
	static function checklstring(L:cpp.RawPointer<Lua_State>, numArg:Int, l:cpp.Star<cpp.SizeT>):cpp.ConstCharStar;

	/**
	 * Returns a string argument, or `def` if absent or nil.
	 * @param L Lua state.
	 * @param numArg Argument index.
	 * @param def Default string.
	 * @param l Receives the string length (may be null).
	 * @return The string.
	 */
	@:native('luaL_optlstring')
	static function optlstring(L:cpp.RawPointer<Lua_State>, numArg:Int, def:cpp.ConstCharStar, l:cpp.Star<cpp.SizeT>):cpp.ConstCharStar;

	/**
	 * Checks that an argument is a number and returns it.
	 * @param L Lua state.
	 * @param numArg Argument index.
	 * @return The number.
	 */
	@:native('luaL_checknumber')
	static function checknumber(L:cpp.RawPointer<Lua_State>, numArg:Int):Lua_Number;

	/**
	 * Returns a number argument, or `def` if absent or nil.
	 * @param L Lua state.
	 * @param nArg Argument index.
	 * @param def Default number.
	 * @return The number.
	 */
	@:native('luaL_optnumber')
	static function optnumber(L:cpp.RawPointer<Lua_State>, nArg:Int, def:Lua_Number):Lua_Number;

	/**
	 * Checks that an argument is an integer and returns it.
	 * @param L Lua state.
	 * @param numArg Argument index.
	 * @return The integer.
	 */
	@:native('luaL_checkinteger')
	static function checkinteger(L:cpp.RawPointer<Lua_State>, numArg:Int):Lua_Integer;

	/**
	 * Returns an integer argument, or `def` if absent or nil.
	 * @param L Lua state.
	 * @param nArg Argument index.
	 * @param def Default integer.
	 * @return The integer.
	 */
	@:native('luaL_optinteger')
	static function optinteger(L:cpp.RawPointer<Lua_State>, nArg:Int, def:Lua_Integer):Lua_Integer;

	/**
	 * Ensures the stack has room for `sz` more slots, raising an error if not.
	 * @param L Lua state.
	 * @param sz Extra slots required.
	 * @param msg Message used if the error is raised.
	 */
	@:native('luaL_checkstack')
	static function checkstack(L:cpp.RawPointer<Lua_State>, sz:Int, msg:cpp.ConstCharStar):Void;

	/**
	 * Checks that an argument has the given type.
	 * @param L Lua state.
	 * @param narg Argument index.
	 * @param t Expected type (a `Lua.T` value).
	 */
	@:native('luaL_checktype')
	static function checktype(L:cpp.RawPointer<Lua_State>, narg:Int, t:Int):Void;

	/**
	 * Checks that an argument exists (of any type).
	 * @param L Lua state.
	 * @param narg Argument index.
	 */
	@:native('luaL_checkany')
	static function checkany(L:cpp.RawPointer<Lua_State>, narg:Int):Void;

	/**
	 * Creates a named metatable in the registry, or pushes the existing one.
	 * @param L Lua state.
	 * @param tname Metatable name.
	 * @return 1 if newly created, 0 if it already existed.
	 */
	@:native('luaL_newmetatable')
	static function newmetatable(L:cpp.RawPointer<Lua_State>, tname:cpp.ConstCharStar):Int;

	/**
	 * Checks that an argument is userdata with the named metatable.
	 * @param L Lua state.
	 * @param ud Argument index.
	 * @param tname Metatable name.
	 * @return Pointer to the userdata.
	 */
	@:native('luaL_checkudata')
	static function checkudata(L:cpp.RawPointer<Lua_State>, ud:Int, tname:cpp.ConstCharStar):cpp.RawPointer<cpp.Void>;

	/**
	 * Checks whether the argument is a userdata with the given tag and returns its address.
	 * @param L Lua state.
	 * @param ud Argument index.
	 * @param tag Userdata tag.
	 * @return Pointer to the userdata.
	 */
	@:native('luaL_checkudatatagged')
	static function checkudatatagged(L:cpp.RawPointer<Lua_State>, ud:Int, tag:Int):cpp.RawPointer<cpp.Void>;

	/**
	 * Pushes a location string (file and line) for the given call level.
	 * @param L Lua state.
	 * @param lvl Stack level.
	 */
	@:native('luaL_where')
	static function where(L:cpp.RawPointer<Lua_State>, lvl:Int):Void;

	/**
	 * Raises a formatted error. Does not return.
	 * @param L Lua state.
	 * @param fmt Format string.
	 * @param args Format arguments.
	 */
	@:native('luaL_error')
	static function error(L:cpp.RawPointer<Lua_State>, fmt:cpp.ConstCharStar, args:cpp.Rest<cpp.VarArg>):Void;

	/**
	 * Checks a string argument against a list of options.
	 * @param L Lua state.
	 * @param narg Argument index.
	 * @param def Default option, or null to require the argument.
	 * @param lst Null-terminated array of valid options.
	 * @return Index of the matched option.
	 */
	@:native('luaL_checkoption')
	static function checkoption(L:cpp.RawPointer<Lua_State>, narg:Int, def:cpp.ConstCharStar, lst:cpp.RawPointer<cpp.ConstCharStar>):Int;

	/** Reference value meaning "no reference". */
	@:native('LUA_NOREF')
	static var NOREF:Int;

	/** Reference value for nil. */
	@:native('LUA_REFNIL')
	static var LUA_REFNIL:Int;

	/**
	 * Creates a new Lua state with the default allocator.
	 * @return The new state.
	 */
	@:native('luaL_newstate')
	static function newstate():cpp.RawPointer<Lua_State>;

	/**
	 * Finds or creates a nested subtable by dotted name.
	 * @param L Lua state.
	 * @param idx Stack index of the root table.
	 * @param fname Dotted table path.
	 * @param szhint Size hint for created tables.
	 * @return null on success, or the name component that wasn't a table.
	 */
	@:native('luaL_findtable')
	static function findtable(L:cpp.RawPointer<Lua_State>, idx:Int, fname:cpp.ConstCharStar, szhint:Int):cpp.ConstCharStar;

	/**
	 * Pushes a traceback of `L1` onto `L`'s stack.
	 * @param L Lua state receiving the traceback.
	 * @param L1 State to trace.
	 * @param msg Optional message prepended to the traceback.
	 * @param level Stack level to start from.
	 */
	@:native('luaL_traceback')
	static function traceback(L:cpp.RawPointer<Lua_State>, L1:cpp.RawPointer<Lua_State>, msg:cpp.ConstCharStar, level:Int):Void;

	/**
	 * Raises an argument error unless `cond` is true.
	 * @param L Lua state.
	 * @param cond Condition (nonzero passes).
	 * @param numarg Argument index.
	 * @param extramsg Message used if the error is raised.
	 */
	@:native('luaL_argcheck')
	static function argcheck(L:cpp.RawPointer<Lua_State>, cond:Int, numarg:Int, extramsg:cpp.ConstCharStar):Void;

	/**
	 * Raises a type error for the argument unless `cond` is true.
	 * @param L Lua state.
	 * @param cond Condition (nonzero passes).
	 * @param arg Argument index.
	 * @param tname Expected type name.
	 */
	@:native('luaL_argexpected')
	static function argexpected(L:cpp.RawPointer<Lua_State>, cond:Int, arg:Int, tname:cpp.ConstCharStar):Void;

	/**
	 * Checks that an argument is a string and returns it.
	 * @param L Lua state.
	 * @param n Argument index.
	 * @return The string.
	 */
	@:native('luaL_checkstring')
	static function checkstring(L:cpp.RawPointer<Lua_State>, n:Int):cpp.ConstCharStar;

	/**
	 * Returns a string argument, or `d` if absent or nil.
	 * @param L Lua state.
	 * @param n Argument index.
	 * @param d Default string.
	 * @return The string.
	 */
	@:native('luaL_optstring')
	static function optstring(L:cpp.RawPointer<Lua_State>, n:Int, d:cpp.ConstCharStar):cpp.ConstCharStar;

	/**
	 * Returns the type name of the value at the given index.
	 * @param L Lua state.
	 * @param index Stack index.
	 * @return The type name.
	 */
	@:native('luaL_typename')
	static function typename(L:cpp.RawPointer<Lua_State>, index:Int):cpp.ConstCharStar;

	/**
	 * Compiles and runs a file (alias for `Luau.dofile`).
	 * @param L Lua state.
	 * @param filename File to run.
	 * @return 0 on success, or an error code.
	 */
	inline static function dofile(L:cpp.RawPointer<Lua_State>, filename:cpp.ConstCharStar):Int {
		return Luau.dofile(L, filename);
	}

	/**
	 * Compiles and runs a string (alias for `Luau.dostring`).
	 * @param L Lua state.
	 * @param str Source to run.
	 * @return 0 on success, or an error code.
	 */
	inline static function dostring(L:cpp.RawPointer<Lua_State>, str:cpp.ConstCharStar):Int {
		return Luau.dostring(L, str);
	}

	/**
	 * Installs hxluau's `print` as the global `print` (alias for `Luau.registerPrint`).
	 * @param L Lua state.
	 */
	inline static function registerPrint(L:cpp.RawPointer<Lua_State>):Void {
		Luau.registerPrint(L);
	}

	/**
	 * Pushes the registry metatable registered under the given name.
	 * @param L Lua state.
	 * @param tname Metatable name.
	 * @return The type of the pushed value.
	 */
	@:native('luaL_getmetatable')
	static function getmetatable(L:cpp.RawPointer<Lua_State>, tname:cpp.ConstCharStar):Int;

	/**
	 * Appends a character to a buffer.
	 * @param B The buffer.
	 * @param c Character to add.
	 */
	@:native('luaL_addchar')
	static function addchar(B:cpp.RawPointer<LuaL_Buffer>, c:cpp.Char):Void;

	/**
	 * Initializes a buffer.
	 * @param L Lua state.
	 * @param B The buffer.
	 */
	@:native('luaL_buffinit')
	static function buffinit(L:cpp.RawPointer<Lua_State>, B:cpp.RawPointer<LuaL_Buffer>):Void;

	/**
	 * Reserves space in a buffer and returns a writable area.
	 * @param B The buffer.
	 * @param sz Bytes to reserve.
	 * @return Pointer to the reserved area.
	 */
	@:native('luaL_prepbuffsize')
	static function prepbuffsize(B:cpp.RawPointer<LuaL_Buffer>, sz:cpp.SizeT):cpp.CastCharStar;

	/**
	 * Appends a string of the given length to a buffer.
	 * @param B The buffer.
	 * @param s String to add.
	 * @param l Length of `s`.
	 */
	@:native('luaL_addlstring')
	static function addlstring(B:cpp.RawPointer<LuaL_Buffer>, s:cpp.ConstCharStar, l:cpp.SizeT):Void;

	/**
	 * Appends a null-terminated string to a buffer.
	 * @param B The buffer.
	 * @param s String to add.
	 */
	@:native('luaL_addstring')
	static function addstring(B:cpp.RawPointer<LuaL_Buffer>, s:cpp.ConstCharStar):Void;

	/**
	 * Appends the value on top of the stack to a buffer (and pops it).
	 * @param B The buffer.
	 */
	@:native('luaL_addvalue')
	static function addvalue(B:cpp.RawPointer<LuaL_Buffer>):Void;

	/**
	 * Finishes a buffer and pushes the resulting string.
	 * @param B The buffer.
	 */
	@:native('luaL_pushresult')
	static function pushresult(B:cpp.RawPointer<LuaL_Buffer>):Void;

	/**
	 * Opens all standard libraries.
	 * @param L Lua state.
	 */
	@:native('luaL_openlibs')
	static function openlibs(L:cpp.RawPointer<Lua_State>):Void;

	/**
	 * Sandboxes the main state, restricting globals.
	 * @param L Lua state.
	 */
	@:native('luaL_sandbox')
	static function sandbox(L:cpp.RawPointer<Lua_State>):Void;

	/**
	 * Sandboxes a thread state.
	 * @param L Thread state.
	 */
	@:native('luaL_sandboxthread')
	static function sandboxthread(L:cpp.RawPointer<Lua_State>):Void;

	/**
	 * Checks that an argument is a boolean and returns it.
	 * @param L Lua state.
	 * @param narg Argument index.
	 * @return The boolean (0 or 1).
	 */
	@:native('luaL_checkboolean')
	static function checkboolean(L:cpp.RawPointer<Lua_State>, narg:Int):Int;

	/**
	 * Returns a boolean argument, or `def` if absent or nil.
	 * @param L Lua state.
	 * @param narg Argument index.
	 * @param def Default boolean.
	 * @return The boolean (0 or 1).
	 */
	@:native('luaL_optboolean')
	static function optboolean(L:cpp.RawPointer<Lua_State>, narg:Int, def:Int):Int;

	/**
	 * Checks that an argument is a 64-bit integer and returns it.
	 * @param L Lua state.
	 * @param numArg Argument index.
	 * @return The 64-bit integer.
	 */
	@:native('luaL_checkinteger64')
	static function checkinteger64(L:cpp.RawPointer<Lua_State>, numArg:Int):haxe.Int64;

	/**
	 * Returns a 64-bit integer argument, or `def` if absent or nil.
	 * @param L Lua state.
	 * @param nArg Argument index.
	 * @param def Default value.
	 * @return The 64-bit integer.
	 */
	@:native('luaL_optinteger64')
	static function optinteger64(L:cpp.RawPointer<Lua_State>, nArg:Int, def:haxe.Int64):haxe.Int64;

	/**
	 * Checks that an argument is an unsigned integer and returns it.
	 * @param L Lua state.
	 * @param numArg Argument index.
	 * @return The unsigned integer.
	 */
	@:native('luaL_checkunsigned')
	static function checkunsigned(L:cpp.RawPointer<Lua_State>, numArg:Int):UInt;

	/**
	 * Returns an unsigned integer argument, or `def` if absent or nil.
	 * @param L Lua state.
	 * @param numArg Argument index.
	 * @param def Default value.
	 * @return The unsigned integer.
	 */
	@:native('luaL_optunsigned')
	static function optunsigned(L:cpp.RawPointer<Lua_State>, numArg:Int, def:UInt):UInt;

	/**
	 * Checks that an argument is a vector and returns it.
	 * @param L Lua state.
	 * @param narg Argument index.
	 * @return Pointer to 3 (or 4) floats.
	 */
	@:native('luaL_checkvector')
	static function checkvector(L:cpp.RawPointer<Lua_State>, narg:Int):cpp.RawConstPointer<Single>;

	/**
	 * Returns a vector argument, or `def` if absent or nil.
	 * @param L Lua state.
	 * @param narg Argument index.
	 * @param def Default vector.
	 * @return Pointer to 3 (or 4) floats.
	 */
	@:native('luaL_optvector')
	static function optvector(L:cpp.RawPointer<Lua_State>, narg:Int, def:cpp.RawConstPointer<Single>):cpp.RawConstPointer<Single>;

	/**
	 * Checks that an argument is a buffer and returns it.
	 * @param L Lua state.
	 * @param narg Argument index.
	 * @param len Receives the buffer length.
	 * @return Pointer to the buffer data.
	 */
	@:native('luaL_checkbuffer')
	static function checkbuffer(L:cpp.RawPointer<Lua_State>, narg:Int, len:cpp.RawPointer<cpp.SizeT>):cpp.RawPointer<cpp.Void>;

	/**
	 * Converts the value at the given index to a string (using `__tostring` if present).
	 * @param L Lua state.
	 * @param idx Stack index.
	 * @param len Receives the string length.
	 * @return The string.
	 */
	@:native('luaL_tolstring')
	static function tolstring(L:cpp.RawPointer<Lua_State>, idx:Int, len:cpp.RawPointer<cpp.SizeT>):cpp.ConstCharStar;

	/**
	 * Initializes a buffer with an initial size and returns a writable area.
	 * @param L Lua state.
	 * @param B The buffer.
	 * @param size Initial size.
	 * @return Pointer to the buffer data.
	 */
	@:native('luaL_buffinitsize')
	static function buffinitsize(L:cpp.RawPointer<Lua_State>, B:cpp.RawPointer<LuaL_Buffer>, size:cpp.SizeT):cpp.CastCharStar;

	/**
	 * Appends the value at the given stack index to a buffer.
	 * @param B The buffer.
	 * @param idx Stack index of the value to add.
	 */
	@:native('luaL_addvalueany')
	static function addvalueany(B:cpp.RawPointer<LuaL_Buffer>, idx:Int):Void;

	/**
	 * Finishes a buffer of a known size and pushes the resulting string.
	 * @param B The buffer.
	 * @param size Final length of the buffered data.
	 */
	@:native('luaL_pushresultsize')
	static function pushresultsize(B:cpp.RawPointer<LuaL_Buffer>, size:cpp.SizeT):Void;
}
