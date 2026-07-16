package hxluau;

#if !cpp
#error 'Luau supports only C++ target platforms.'
#end
import hxluau.Types;

/** Core Lua C API (the `lua_` functions) for the stack, value conversion, tables, calls, GC, and debugging. */
@:buildXml('<include name="${haxelib:hxluau}/project/Build.xml" />')
@:include('lua.h')
@:include('lualib.h')
@:include('luacode.h')
@:include('LuauImpl.h')
@:unreflective
extern class Lua
{
	/** Lua version string. */
	@:native('::String(hxluau_version_string())')
	static var VERSION(default, null):String;

	/** Lua release string. */
	@:native('::String(hxluau_version_release())')
	static var RELEASE(default, null):String;

	/** Numeric Lua version. */
	@:native('hxluau_version_num()')
	static var VERSION_NUM(default, null):Int;

	/** Copyright notice. */
	@:native('::String("Copyright (C) 2019-2022 Roblox Corporation. Copyright (C) 1994-2022 Lua.org, PUC-Rio.")')
	static var COPYRIGHT(default, null):String;

	/** Author credits. */
	@:native('::String("Roblox Corporation. Lua.org, PUC-Rio.")')
	static var AUTHORS(default, null):String;

	/** Pass as `nresults` to keep all return values of a call. */
	@:native('LUA_MULTRET')
	static var MULTRET:Int;

	/** Pseudo-index of the registry. */
	@:native('LUA_REGISTRYINDEX')
	static var REGISTRYINDEX:Int;

	/** Pseudo-index of the environment table. */
	@:native('LUA_ENVIRONINDEX')
	static var ENVIRONINDEX:Int;

	/** Pseudo-index of the globals table. */
	@:native('LUA_GLOBALSINDEX')
	static var GLOBALSINDEX:Int;

	/**
	 * Whether an index is a pseudo-index.
	 * @param i Index to check.
	 * @return 1 if pseudo, 0 otherwise.
	 */
	@:native('lua_ispseudo')
	static function ispseudo(i:Int):Int;

	/**
	 * Pseudo-index of the i-th upvalue of the running C closure.
	 * @param i Upvalue number (1-based).
	 * @return The upvalue pseudo-index.
	 */
	@:native('lua_upvalueindex')
	static function upvalueindex(i:Int):Int;

	/** Status for a successful call. */
	@:native('LUA_OK')
	static var OK:Int;

	/** Status for a yield. */
	@:native('LUA_YIELD')
	static var YIELD:Int;

	/** Status for a runtime error. */
	@:native('LUA_ERRRUN')
	static var ERRRUN:Int;

	/** Status for a syntax error. */
	@:native('LUA_ERRSYNTAX')
	static var ERRSYNTAX:Int;

	/** Status for a memory allocation error. */
	@:native('LUA_ERRMEM')
	static var ERRMEM:Int;

	/** Status for an error in the error handler. */
	@:native('LUA_ERRERR')
	static var ERRERR:Int;

	/** Status for a debug breakpoint yield. */
	@:native('LUA_BREAK')
	static var BREAK:Int;

	/** Type for no value (invalid index). */
	@:native('LUA_TNONE')
	static var TNONE:Int;

	/** Type for nil. */
	@:native('LUA_TNIL')
	static var TNIL:Int;

	/** Type for boolean. */
	@:native('LUA_TBOOLEAN')
	static var TBOOLEAN:Int;

	/** Type for light userdata. */
	@:native('LUA_TLIGHTUSERDATA')
	static var TLIGHTUSERDATA:Int;

	/** Type for number. */
	@:native('LUA_TNUMBER')
	static var TNUMBER:Int;

	/** Type for string. */
	@:native('LUA_TSTRING')
	static var TSTRING:Int;

	/** Type for table. */
	@:native('LUA_TTABLE')
	static var TTABLE:Int;

	/** Type for function. */
	@:native('LUA_TFUNCTION')
	static var TFUNCTION:Int;

	/** Type for userdata. */
	@:native('LUA_TUSERDATA')
	static var TUSERDATA:Int;

	/** Type for thread. */
	@:native('LUA_TTHREAD')
	static var TTHREAD:Int;

	/** Type for 64-bit integer. */
	@:native('LUA_TINTEGER')
	static var TINTEGER:Int;

	/** Type for vector. */
	@:native('LUA_TVECTOR')
	static var TVECTOR:Int;

	/** Type for buffer. */
	@:native('LUA_TBUFFER')
	static var TBUFFER:Int;

	/** Type for class. */
	@:native('LUA_TCLASS')
	static var TCLASS:Int;

	/** Type for object. */
	@:native('LUA_TOBJECT')
	static var TOBJECT:Int;

	/** Minimum stack slots guaranteed to a C function. */
	@:native('LUA_MINSTACK')
	static var MINSTACK:Int;

	/** Size of `short_src`, the textual source description. */
	@:native('LUA_IDSIZE')
	static var IDSIZE:Int;

	/** Max Lua stack slots usable by a single C function. */
	@:native('LUAI_MAXCSTACK')
	static var MAXCSTACK:Int;

	/** Max number of nested Lua calls. */
	@:native('LUAI_MAXCALLS')
	static var MAXCALLS:Int;

	/** Max depth of nested C calls. */
	@:native('LUAI_MAXCCALLS')
	static var MAXCCALLS:Int;

	/** Size of the on-stack buffer used by string operations (`LuaL_Buffer`). */
	@:native('LUA_BUFFERSIZE')
	static var BUFFERSIZE:Int;

	/** Number of valid userdata tags (numbered from 0). */
	@:native('LUA_UTAG_LIMIT')
	static var UTAG_LIMIT:Int;

	/** Number of valid light-userdata tags (numbered from 0). */
	@:native('LUA_LUTAG_LIMIT')
	static var LUTAG_LIMIT:Int;

	/** Number of memory categories (numbered from 0). */
	@:native('LUA_MEMORY_CATEGORIES')
	static var MEMORY_CATEGORIES:Int;

	/** Max captures supported by pattern matching. */
	@:native('LUA_MAXCAPTURES')
	static var MAXCAPTURES:Int;

	/** Float components per vector (3 by default, may be 4). */
	@:native('LUA_VECTOR_SIZE')
	static var VECTOR_SIZE:Int;

	/** Coroutine status when running. */
	@:native('LUA_CORUN')
	static var CORUN:Int;

	/** Coroutine status when suspended (yielded or not started). */
	@:native('LUA_COSUS')
	static var COSUS:Int;

	/** Coroutine status when normal (it resumed another coroutine). */
	@:native('LUA_CONOR')
	static var CONOR:Int;

	/** Coroutine status when finished. */
	@:native('LUA_COFIN')
	static var COFIN:Int;

	/** Coroutine status when finished with an error. */
	@:native('LUA_COERR')
	static var COERR:Int;

	/**
	 * Creates a new Lua state.
	 * @param f Memory allocator.
	 * @param ud User data for the allocator.
	 * @return The new state.
	 */
	@:native('lua_newstate')
	static function newstate(f:Lua_Alloc, ud:cpp.RawPointer<cpp.Void>):cpp.RawPointer<Lua_State>;

	/**
	 * Closes a state and frees its resources.
	 * @param L Lua state.
	 */
	@:native('lua_close')
	static function close(L:cpp.RawPointer<Lua_State>):Void;

	/**
	 * Creates a new thread (coroutine) and pushes it on the stack.
	 * @param L Lua state.
	 * @return The new thread.
	 */
	@:native('lua_newthread')
	static function newthread(L:cpp.RawPointer<Lua_State>):cpp.RawPointer<Lua_State>;

	/**
	 * Returns the top index (number of stack elements).
	 * @param L Lua state.
	 * @return The top index.
	 */
	@:native('lua_gettop')
	static function gettop(L:cpp.RawPointer<Lua_State>):Int;

	/**
	 * Sets the top index, growing or shrinking the stack.
	 * @param L Lua state.
	 * @param idx New top index.
	 */
	@:native('lua_settop')
	static function settop(L:cpp.RawPointer<Lua_State>, idx:Int):Void;

	/**
	 * Pushes a copy of the value at the given index.
	 * @param L Lua state.
	 * @param idx Index to copy.
	 */
	@:native('lua_pushvalue')
	static function pushvalue(L:cpp.RawPointer<Lua_State>, idx:Int):Void;

	/**
	 * Removes the value at the given index, shifting elements down.
	 * @param L Lua state.
	 * @param idx Index to remove.
	 */
	@:native('lua_remove')
	static function remove(L:cpp.RawPointer<Lua_State>, idx:Int):Void;

	/**
	 * Moves the top value into the given index, shifting elements up.
	 * @param L Lua state.
	 * @param idx Target index.
	 */
	@:native('lua_insert')
	static function insert(L:cpp.RawPointer<Lua_State>, idx:Int):Void;

	/**
	 * Pops the top value and writes it to the given index.
	 * @param L Lua state.
	 * @param idx Target index.
	 */
	@:native('lua_replace')
	static function replace(L:cpp.RawPointer<Lua_State>, idx:Int):Void;

	/**
	 * Copies the value at `fromidx` over the value at `toidx`.
	 * @param L Lua state.
	 * @param fromidx Source index.
	 * @param toidx Destination index.
	 */
	inline static function copy(L:cpp.RawPointer<Lua_State>, fromidx:Int, toidx:Int):Void {
		pushvalue(L, fromidx);
		replace(L, toidx);
	}

	/**
	 * Ensures the stack has room for `sz` more slots.
	 * @param L Lua state.
	 * @param sz Extra slots needed.
	 * @return 1 on success, 0 if it can't grow.
	 */
	@:native('lua_checkstack')
	static function checkstack(L:cpp.RawPointer<Lua_State>, sz:Int):Int;

	/**
	 * Moves `n` values between two states sharing the same global state.
	 * @param from Source state.
	 * @param to Destination state.
	 * @param n Number of values to move.
	 */
	@:native('lua_xmove')
	static function xmove(from:cpp.RawPointer<Lua_State>, to:cpp.RawPointer<Lua_State>, n:Int):Void;

	/**
	 * Whether the value is a number or a numeric string.
	 * @param L Lua state.
	 * @param idx Stack index.
	 * @return 1 if numeric, 0 otherwise.
	 */
	@:native('lua_isnumber')
	static function isnumber(L:cpp.RawPointer<Lua_State>, idx:Int):Int;

	/**
	 * Whether the value is a string or a number.
	 * @param L Lua state.
	 * @param idx Stack index.
	 * @return 1 if string-coercible, 0 otherwise.
	 */
	@:native('lua_isstring')
	static function isstring(L:cpp.RawPointer<Lua_State>, idx:Int):Int;

	/**
	 * Whether the value is a C function.
	 * @param L Lua state.
	 * @param idx Stack index.
	 * @return 1 if a C function, 0 otherwise.
	 */
	@:native('lua_iscfunction')
	static function iscfunction(L:cpp.RawPointer<Lua_State>, idx:Int):Int;

	/**
	 * Whether the value is userdata (full or light).
	 * @param L Lua state.
	 * @param idx Stack index.
	 * @return 1 if userdata, 0 otherwise.
	 */
	@:native('lua_isuserdata')
	static function isuserdata(L:cpp.RawPointer<Lua_State>, idx:Int):Int;

	/**
	 * Returns the type of the value at the given index.
	 * @param L Lua state.
	 * @param idx Stack index.
	 * @return A `Lua.T` type code.
	 */
	@:native('lua_type')
	static function type(L:cpp.RawPointer<Lua_State>, idx:Int):Int;

	/**
	 * Returns the name of a type code.
	 * @param L Lua state.
	 * @param tp A `Lua.T` type code.
	 * @return The type name.
	 */
	@:native('lua_typename')
	static function typename(L:cpp.RawPointer<Lua_State>, tp:Int):cpp.ConstCharStar;

	/**
	 * Compares two values for equality, honoring `__eq`.
	 * @param L Lua state.
	 * @param idx1 First index.
	 * @param idx2 Second index.
	 * @return 1 if equal, 0 otherwise.
	 */
	@:native('lua_equal')
	static function equal(L:cpp.RawPointer<Lua_State>, idx1:Int, idx2:Int):Int;

	/**
	 * Compares two values for equality without metamethods.
	 * @param L Lua state.
	 * @param idx1 First index.
	 * @param idx2 Second index.
	 * @return 1 if equal, 0 otherwise.
	 */
	@:native('lua_rawequal')
	static function rawequal(L:cpp.RawPointer<Lua_State>, idx1:Int, idx2:Int):Int;

	/**
	 * Tests `idx1 < idx2`, honoring `__lt`.
	 * @param L Lua state.
	 * @param idx1 First index.
	 * @param idx2 Second index.
	 * @return 1 if less than, 0 otherwise.
	 */
	@:native('lua_lessthan')
	static function lessthan(L:cpp.RawPointer<Lua_State>, idx1:Int, idx2:Int):Int;

	/**
	 * Converts the value to a number (0 if not convertible).
	 * @param L Lua state.
	 * @param idx Stack index.
	 * @return The number.
	 */
	@:native('lua_tonumber')
	static function tonumber(L:cpp.RawPointer<Lua_State>, idx:Int):Lua_Number;

	/**
	 * Converts the value to an integer (0 if not convertible).
	 * @param L Lua state.
	 * @param idx Stack index.
	 * @return The integer.
	 */
	@:native('lua_tointeger')
	static function tointeger(L:cpp.RawPointer<Lua_State>, idx:Int):Lua_Integer;

	/**
	 * Converts the value to an unsigned integer.
	 * @param L Lua state.
	 * @param idx Stack index.
	 * @return The unsigned integer.
	 */
	@:native('lua_tounsigned')
	static function tounsigned(L:cpp.RawPointer<Lua_State>, idx:Int):UInt;

	/**
	 * Converts the value to a boolean (only nil and false are false).
	 * @param L Lua state.
	 * @param idx Stack index.
	 * @return 1 if true, 0 if false.
	 */
	@:native('lua_toboolean')
	static function toboolean(L:cpp.RawPointer<Lua_State>, idx:Int):Int;

	/**
	 * Converts the value to a string, also returning its length.
	 * @param L Lua state.
	 * @param idx Stack index.
	 * @param len Receives the string length.
	 * @return The string.
	 */
	@:native('lua_tolstring')
	static function tolstring(L:cpp.RawPointer<Lua_State>, idx:Int, len:cpp.Star<cpp.SizeT>):cpp.ConstCharStar;

	/**
	 * Returns a string value along with its interned atom id.
	 * @param L Lua state.
	 * @param idx Stack index.
	 * @param atom Receives the atom id.
	 * @return The string.
	 */
	@:native('lua_tostringatom')
	static function tostringatom(L:cpp.RawPointer<Lua_State>, idx:Int, atom:cpp.RawPointer<Int>):cpp.ConstCharStar;

	/**
	 * Returns a string value with its length and interned atom id.
	 * @param L Lua state.
	 * @param idx Stack index.
	 * @param len Receives the string length.
	 * @param atom Receives the atom id.
	 * @return The string.
	 */
	@:native('lua_tolstringatom')
	static function tolstringatom(L:cpp.RawPointer<Lua_State>, idx:Int, len:cpp.RawPointer<cpp.SizeT>, atom:cpp.RawPointer<Int>):cpp.ConstCharStar;

	/**
	 * Returns the current namecall method name and its atom id.
	 * @param L Lua state.
	 * @param atom Receives the atom id.
	 * @return The method name.
	 */
	@:native('lua_namecallatom')
	static function namecallatom(L:cpp.RawPointer<Lua_State>, atom:cpp.RawPointer<Int>):cpp.ConstCharStar;

	/**
	 * Returns the raw length of the value (string length, table border, etc.).
	 * @param L Lua state.
	 * @param idx Stack index.
	 * @return The length.
	 */
	@:native('lua_objlen')
	static function objlen(L:cpp.RawPointer<Lua_State>, idx:Int):cpp.SizeT;

	/**
	 * Returns the value as a C function, or null.
	 * @param L Lua state.
	 * @param idx Stack index.
	 * @return The C function, or null.
	 */
	@:native('lua_tocfunction')
	static function tocfunction(L:cpp.RawPointer<Lua_State>, idx:Int):Lua_CFunction;

	/**
	 * Returns the userdata block pointer, or null.
	 * @param L Lua state.
	 * @param idx Stack index.
	 * @return The pointer, or null.
	 */
	@:native('lua_touserdata')
	static function touserdata(L:cpp.RawPointer<Lua_State>, idx:Int):cpp.RawPointer<cpp.Void>;

	/**
	 * Returns the value as a thread, or null.
	 * @param L Lua state.
	 * @param idx Stack index.
	 * @return The thread, or null.
	 */
	@:native('lua_tothread')
	static function tothread(L:cpp.RawPointer<Lua_State>, idx:Int):cpp.RawPointer<Lua_State>;

	/**
	 * Returns an opaque pointer identifying the value, or null.
	 * @param L Lua state.
	 * @param idx Stack index.
	 * @return The pointer, or null.
	 */
	@:native('lua_topointer')
	static function topointer(L:cpp.RawPointer<Lua_State>, idx:Int):cpp.RawConstPointer<cpp.Void>;

	/**
	 * Pushes nil.
	 * @param L Lua state.
	 */
	@:native('lua_pushnil')
	static function pushnil(L:cpp.RawPointer<Lua_State>):Void;

	/**
	 * Pushes a number.
	 * @param L Lua state.
	 * @param n The number.
	 */
	@:native('lua_pushnumber')
	static function pushnumber(L:cpp.RawPointer<Lua_State>, n:Lua_Number):Void;

	/**
	 * Pushes an integer.
	 * @param L Lua state.
	 * @param n The integer.
	 */
	@:native('lua_pushinteger')
	static function pushinteger(L:cpp.RawPointer<Lua_State>, n:Lua_Integer):Void;

	/**
	 * Pushes a string of the given length (may contain embedded zeros).
	 * @param L Lua state.
	 * @param s The string.
	 * @param len Length of `s`.
	 */
	@:native('lua_pushlstring')
	static function pushlstring(L:cpp.RawPointer<Lua_State>, s:cpp.ConstCharStar, len:cpp.SizeT):Void;

	/**
	 * Pushes a null-terminated string.
	 * @param L Lua state.
	 * @param s The string.
	 */
	@:native('lua_pushstring')
	static function pushstring(L:cpp.RawPointer<Lua_State>, s:cpp.ConstCharStar):Void;

	/**
	 * Pushes a formatted string (va_list variant).
	 * @param L Lua state.
	 * @param s Format string.
	 * @param argp Format arguments.
	 * @return The formatted string.
	 */
	@:native('lua_pushvfstring')
	static function pushvfstring(L:cpp.RawPointer<Lua_State>, s:cpp.ConstCharStar, argp:cpp.VarList):cpp.ConstCharStar;

	/**
	 * Pushes a formatted string.
	 * @param L Lua state.
	 * @param fmt Format string.
	 * @param args Format arguments.
	 * @return The formatted string.
	 */
	@:native('lua_pushfstring')
	static function pushfstring(L:cpp.RawPointer<Lua_State>, fmt:cpp.ConstCharStar, args:cpp.Rest<cpp.VarArg>):cpp.ConstCharStar;

	/**
	 * Pushes a C closure with `n` upvalues (popped from the stack).
	 * @param L Lua state.
	 * @param fn The C function.
	 * @param debugname Name for debugging and profiling.
	 * @param n Number of upvalues.
	 */
	@:native('lua_pushcclosure')
	static function pushcclosure(L:cpp.RawPointer<Lua_State>, fn:Lua_CFunction, debugname:cpp.ConstCharStar, n:Int):Void;

	/**
	 * Pushes a C closure with upvalues and a continuation.
	 * @param L Lua state.
	 * @param fn The C function.
	 * @param debugname Name for debugging and profiling.
	 * @param nup Number of upvalues.
	 * @param cont Continuation, or null.
	 */
	@:native('lua_pushcclosurek')
	static function pushcclosurek(L:cpp.RawPointer<Lua_State>, fn:Lua_CFunction, debugname:cpp.ConstCharStar, nup:Int, cont:Lua_Continuation):Void;

	/**
	 * Pushes a boolean.
	 * @param L Lua state.
	 * @param b 0 for false, nonzero for true.
	 */
	@:native('lua_pushboolean')
	static function pushboolean(L:cpp.RawPointer<Lua_State>, b:Int):Void;

	/**
	 * Pushes a light userdata (a raw pointer).
	 * @param L Lua state.
	 * @param p The pointer.
	 */
	@:native('lua_pushlightuserdata')
	static function pushlightuserdata(L:cpp.RawPointer<Lua_State>, p:cpp.RawPointer<cpp.Void>):Void;

	/**
	 * Pushes the running thread.
	 * @param L Lua state.
	 * @return 1 if it is the main thread, 0 otherwise.
	 */
	@:native('lua_pushthread')
	static function pushthread(L:cpp.RawPointer<Lua_State>):Int;

	/**
	 * Pushes `t[k]` where `t` is at `idx` and `k` is on top; honors `__index`.
	 * @param L Lua state.
	 * @param idx Table index.
	 * @return Type of the resulting value.
	 */
	@:native('lua_gettable')
	static function gettable(L:cpp.RawPointer<Lua_State>, idx:Int):Int;

	/**
	 * Pushes `t[k]` where `t` is at `idx`; honors `__index`.
	 * @param L Lua state.
	 * @param idx Table index.
	 * @param k Field name.
	 * @return Type of the resulting value.
	 */
	@:native('lua_getfield')
	static function getfield(L:cpp.RawPointer<Lua_State>, idx:Int, k:cpp.ConstCharStar):Int;

	/**
	 * Pushes `t[k]` (key on top) without metamethods.
	 * @param L Lua state.
	 * @param idx Table index.
	 * @return Type of the resulting value.
	 */
	@:native('lua_rawget')
	static function rawget(L:cpp.RawPointer<Lua_State>, idx:Int):Int;

	/**
	 * Pushes `t[n]` without metamethods.
	 * @param L Lua state.
	 * @param idx Table index.
	 * @param n Integer key.
	 * @return Type of the resulting value.
	 */
	@:native('lua_rawgeti')
	static function rawgeti(L:cpp.RawPointer<Lua_State>, idx:Int, n:Int):Int;

	/**
	 * Creates and pushes a new table preallocated for the given sizes.
	 * @param L Lua state.
	 * @param narr Expected array elements.
	 * @param nrec Expected hash elements.
	 */
	@:native('lua_createtable')
	static function createtable(L:cpp.RawPointer<Lua_State>, narr:Int, nrec:Int):Void;

	/**
	 * Creates and pushes a userdata block of the given size.
	 * @param L Lua state.
	 * @param size Block size in bytes.
	 * @return Pointer to the block.
	 */
	@:native('lua_newuserdata')
	static function newuserdata(L:cpp.RawPointer<Lua_State>, size:cpp.SizeT):cpp.RawPointer<cpp.Void>;

	/**
	 * Pushes the metatable of the value, if any.
	 * @param L Lua state.
	 * @param objindex Stack index.
	 * @return 1 if a metatable was pushed, 0 otherwise.
	 */
	@:native('lua_getmetatable')
	static function getmetatable(L:cpp.RawPointer<Lua_State>, objindex:Int):Int;

	/**
	 * Does `t[k] = v` (k and v on top), honoring `__newindex`.
	 * @param L Lua state.
	 * @param idx Table index.
	 */
	@:native('lua_settable')
	static function settable(L:cpp.RawPointer<Lua_State>, idx:Int):Void;

	/**
	 * Does `t[k] = v` (v on top), honoring `__newindex`.
	 * @param L Lua state.
	 * @param idx Table index.
	 * @param k Field name.
	 */
	@:native('lua_setfield')
	static function setfield(L:cpp.RawPointer<Lua_State>, idx:Int, k:cpp.ConstCharStar):Void;

	/**
	 * Does `t[k] = v` (k and v on top) without metamethods.
	 * @param L Lua state.
	 * @param idx Table index.
	 */
	@:native('lua_rawset')
	static function rawset(L:cpp.RawPointer<Lua_State>, idx:Int):Void;

	/**
	 * Does `t[n] = v` (v on top) without metamethods.
	 * @param L Lua state.
	 * @param idx Table index.
	 * @param n Integer key.
	 */
	@:native('lua_rawseti')
	static function rawseti(L:cpp.RawPointer<Lua_State>, idx:Int, n:Int):Void;

	/**
	 * Pops a table and sets it as the metatable of the value.
	 * @param L Lua state.
	 * @param objindex Stack index.
	 * @return 1 on success.
	 */
	@:native('lua_setmetatable')
	static function setmetatable(L:cpp.RawPointer<Lua_State>, objindex:Int):Int;

	/**
	 * Creates a registry reference to the value at the given index.
	 * @param L Lua state.
	 * @param t Index of the value to reference.
	 * @return The reference id.
	 */
	@:native('lua_ref')
	static function ref(L:cpp.RawPointer<Lua_State>, t:Int):Int;

	/**
	 * Releases a reference, letting its value be collected.
	 * @param L Lua state.
	 * @param ref Reference id.
	 */
	@:native('lua_unref')
	static function unref(L:cpp.RawPointer<Lua_State>, ref:Int):Void;

	/**
	 * Pushes the value held by a reference (registry rawgeti).
	 * @param L Lua state.
	 * @param ref Reference id (from `ref`).
	 * @return Type of the resulting value.
	 */
	@:native('lua_getref')
	static function getref(L:cpp.RawPointer<Lua_State>, ref:Int):Int;

	/**
	 * Calls a function (function and its arguments on the stack).
	 * @param L Lua state.
	 * @param nargs Number of arguments.
	 * @param nresults Expected results, or `Lua.MULTRET`.
	 */
	@:native('lua_call')
	static function call(L:cpp.RawPointer<Lua_State>, nargs:Int, nresults:Int):Void;

	/**
	 * Calls a function in protected mode.
	 * @param L Lua state.
	 * @param nargs Number of arguments.
	 * @param nresults Expected results, or `Lua.MULTRET`.
	 * @param errfunc Stack index of the message handler, or 0 for none.
	 * @return A status code (`Lua.OK` on success).
	 */
	@:native('lua_pcall')
	static function pcall(L:cpp.RawPointer<Lua_State>, nargs:Int, nresults:Int, errfunc:Int):Int;

	/**
	 * Yields the running coroutine.
	 * @param L Lua state.
	 * @param nresults Number of results to pass back.
	 * @return A status code (use as `return Lua.yield(...)`).
	 */
	@:native('lua_yield')
	static function yield(L:cpp.RawPointer<Lua_State>, nresults:Int):Int;

	/**
	 * Starts or resumes a coroutine.
	 * @param L Coroutine to resume.
	 * @param from Resuming state, or null.
	 * @param nargs Number of arguments passed in.
	 * @return A status code (`Lua.OK` or `Lua.YIELD` on success).
	 */
	@:native('lua_resume')
	static function resume(L:cpp.RawPointer<Lua_State>, from:cpp.RawPointer<Lua_State>, nargs:Int):Int;

	/**
	 * Returns the status of the thread.
	 * @param L Lua state.
	 * @return A status code.
	 */
	@:native('lua_status')
	static function status(L:cpp.RawPointer<Lua_State>):Int;

	/** GC option to stop the collector. */
	@:native('LUA_GCSTOP')
	static var GCSTOP:Int;

	/** GC option to restart the collector. */
	@:native('LUA_GCRESTART')
	static var GCRESTART:Int;

	/** GC option to run a full collection cycle. */
	@:native('LUA_GCCOLLECT')
	static var GCCOLLECT:Int;

	/** GC option to get memory in use, in KB. */
	@:native('LUA_GCCOUNT')
	static var GCCOUNT:Int;

	/** GC option to get the byte remainder of memory in use. */
	@:native('LUA_GCCOUNTB')
	static var GCCOUNTB:Int;

	/** GC option to run one incremental step. */
	@:native('LUA_GCSTEP')
	static var GCSTEP:Int;

	/** GC option to set the step multiplier. */
	@:native('LUA_GCSETSTEPMUL')
	static var GCSETSTEPMUL:Int;

	/** GC option to query whether the collector is running. */
	@:native('LUA_GCISRUNNING')
	static var GCISRUNNING:Int;

	/**
	 * Controls the garbage collector.
	 * @param L Lua state.
	 * @param what A `Lua.GC` option.
	 * @param data Argument for the option.
	 * @return Option-specific result.
	 */
	@:native('lua_gc')
	static function gc(L:cpp.RawPointer<Lua_State>, what:Int, data:Int):Int;

	/** GC option to set the heap goal as a percent of live data. */
	@:native('LUA_GCSETGOAL')
	static var GCSETGOAL:Int;

	/** GC option to set the step size, in KB. */
	@:native('LUA_GCSETSTEPSIZE')
	static var GCSETSTEPSIZE:Int;

	/**
	 * Returns the bytes allocated to a memory category.
	 * @param L Lua state.
	 * @param category Memory category index, starting at 0.
	 * @return Allocated bytes.
	 */
	@:native('lua_totalbytes')
	static function totalbytes(L:cpp.RawPointer<Lua_State>, category:Int):cpp.SizeT;

	/**
	 * Sets the memory category for subsequent allocations.
	 * @param L Lua state.
	 * @param category Memory category.
	 */
	@:native('lua_setmemcat')
	static function setmemcat(L:cpp.RawPointer<Lua_State>, category:Int):Void;

	/**
	 * Sets whether a table is read-only.
	 * @param L Lua state.
	 * @param idx Table index.
	 * @param enabled 1 for read-only, 0 for writable.
	 */
	@:native('lua_setreadonly')
	static function setreadonly(L:cpp.RawPointer<Lua_State>, idx:Int, enabled:Int):Void;

	/**
	 * Whether a table is read-only.
	 * @param L Lua state.
	 * @param idx Table index.
	 * @return 1 if read-only, 0 otherwise.
	 */
	@:native('lua_getreadonly')
	static function getreadonly(L:cpp.RawPointer<Lua_State>, idx:Int):Int;

	/**
	 * Marks a table as a safe environment (enables optimizations).
	 * @param L Lua state.
	 * @param idx Table index.
	 * @param enabled 1 to mark safe, 0 to unmark.
	 */
	@:native('lua_setsafeenv')
	static function setsafeenv(L:cpp.RawPointer<Lua_State>, idx:Int, enabled:Int):Void;

	/**
	 * Pushes a clone of the function at the given index.
	 * @param L Lua state.
	 * @param idx Function index.
	 */
	@:native('lua_clonefunction')
	static function clonefunction(L:cpp.RawPointer<Lua_State>, idx:Int):Void;

	/**
	 * Pushes a clone of the table at the given index.
	 * @param L Lua state.
	 * @param idx Table index.
	 */
	@:native('lua_clonetable')
	static function clonetable(L:cpp.RawPointer<Lua_State>, idx:Int):Void;

	/**
	 * Removes all entries from the table at the given index.
	 * @param L Lua state.
	 * @param idx Table index.
	 */
	@:native('lua_cleartable')
	static function cleartable(L:cpp.RawPointer<Lua_State>, idx:Int):Void;

	/**
	 * Raises the error object on top of the stack. Does not return.
	 * @param L Lua state.
	 */
	@:native('lua_error')
	static function error(L:cpp.RawPointer<Lua_State>):Void;

	/**
	 * Pops a key and pushes the next key and value of the table.
	 * @param L Lua state.
	 * @param idx Table index.
	 * @return 1 if a pair was pushed, 0 when iteration ends.
	 */
	@:native('lua_next')
	static function next(L:cpp.RawPointer<Lua_State>, idx:Int):Int;

	/**
	 * Concatenates the top `n` values, honoring `__concat`.
	 * @param L Lua state.
	 * @param n Number of values to concatenate.
	 */
	@:native('lua_concat')
	static function concat(L:cpp.RawPointer<Lua_State>, n:Int):Void;

	/**
	 * Returns the memory allocator and its user data.
	 * @param L Lua state.
	 * @param ud Receives the allocator user data (may be null).
	 * @return The allocator function.
	 */
	@:native('lua_getallocf')
	static function getallocf(L:cpp.RawPointer<Lua_State>, ud:cpp.RawPointer<cpp.RawPointer<cpp.Void>>):Lua_Alloc;

	/**
	 * Pops `n` values from the stack.
	 * @param L Lua state.
	 * @param n Number of values to pop.
	 */
	@:native('lua_pop')
	static function pop(L:cpp.RawPointer<Lua_State>, n:Int):Void;

	/**
	 * Creates and pushes a new empty table.
	 * @param L Lua state.
	 */
	@:native('lua_newtable')
	static function newtable(L:cpp.RawPointer<Lua_State>):Void;

	/**
	 * Registers an array of functions into a table (or a named global library).
	 * @param L Lua state.
	 * @param name Library name, or null to use the table on top.
	 * @param l Null-terminated array of name and function pairs.
	 */
	@:native('luaL_register')
	static function register(L:cpp.RawPointer<Lua_State>, name:cpp.ConstCharStar, l:cpp.RawConstPointer<LuaL_Reg>):Void;

	/**
	 * Pushes a C function (a closure with no upvalues).
	 * @param L Lua state.
	 * @param fn The C function.
	 * @param debugname Name for debugging and profiling.
	 */
	@:native('lua_pushcfunction')
	static function pushcfunction(L:cpp.RawPointer<Lua_State>, fn:Lua_CFunction, debugname:cpp.ConstCharStar):Void;

	/**
	 * Returns the length of the value (alias for `objlen`).
	 * @param L Lua state.
	 * @param idx Stack index.
	 * @return The length.
	 */
	@:native('lua_strlen')
	static function strlen(L:cpp.RawPointer<Lua_State>, idx:Int):cpp.SizeT;

	/**
	 * Whether the value is a function.
	 * @param L Lua state.
	 * @param n Stack index.
	 * @return 1 if a function, 0 otherwise.
	 */
	@:native('lua_isfunction')
	static function isfunction(L:cpp.RawPointer<Lua_State>, n:Int):Int;

	/**
	 * Whether the value is a table.
	 * @param L Lua state.
	 * @param n Stack index.
	 * @return 1 if a table, 0 otherwise.
	 */
	@:native('lua_istable')
	static function istable(L:cpp.RawPointer<Lua_State>, n:Int):Int;

	/**
	 * Whether the value is light userdata.
	 * @param L Lua state.
	 * @param n Stack index.
	 * @return 1 if light userdata, 0 otherwise.
	 */
	@:native('lua_islightuserdata')
	static function islightuserdata(L:cpp.RawPointer<Lua_State>, n:Int):Int;

	/**
	 * Whether the value is nil.
	 * @param L Lua state.
	 * @param n Stack index.
	 * @return 1 if nil, 0 otherwise.
	 */
	@:native('lua_isnil')
	static function isnil(L:cpp.RawPointer<Lua_State>, n:Int):Int;

	/**
	 * Whether the value is a boolean.
	 * @param L Lua state.
	 * @param n Stack index.
	 * @return 1 if a boolean, 0 otherwise.
	 */
	@:native('lua_isboolean')
	static function isboolean(L:cpp.RawPointer<Lua_State>, n:Int):Int;

	/**
	 * Whether the value is a thread.
	 * @param L Lua state.
	 * @param n Stack index.
	 * @return 1 if a thread, 0 otherwise.
	 */
	@:native('lua_isthread')
	static function isthread(L:cpp.RawPointer<Lua_State>, n:Int):Int;

	/**
	 * Whether the value is a vector.
	 * @param L Lua state.
	 * @param n Stack index.
	 * @return 1 if a vector, 0 otherwise.
	 */
	@:native('lua_isvector')
	static function isvector(L:cpp.RawPointer<Lua_State>, n:Int):Int;

	/**
	 * Whether the value is a buffer.
	 * @param L Lua state.
	 * @param n Stack index.
	 * @return 1 if a buffer, 0 otherwise.
	 */
	@:native('lua_isbuffer')
	static function isbuffer(L:cpp.RawPointer<Lua_State>, n:Int):Int;

	/**
	 * Whether the value is a class.
	 * @param L Lua state.
	 * @param n Stack index.
	 * @return 1 if a class, 0 otherwise.
	 */
	@:native('lua_isclass')
	static function isclass(L:cpp.RawPointer<Lua_State>, n:Int):Int;

	/**
	 * Whether the value is an object.
	 * @param L Lua state.
	 * @param n Stack index.
	 * @return 1 if an object, 0 otherwise.
	 */
	@:native('lua_isobject')
	static function isobject(L:cpp.RawPointer<Lua_State>, n:Int):Int;

	/**
	 * Whether the index holds no value.
	 * @param L Lua state.
	 * @param n Stack index.
	 * @return 1 if none, 0 otherwise.
	 */
	@:native('lua_isnone')
	static function isnone(L:cpp.RawPointer<Lua_State>, n:Int):Int;

	/**
	 * Whether the index holds no value or nil.
	 * @param L Lua state.
	 * @param n Stack index.
	 * @return 1 if none or nil, 0 otherwise.
	 */
	@:native('lua_isnoneornil')
	static function isnoneornil(L:cpp.RawPointer<Lua_State>, n:Int):Int;

	/**
	 * Pushes a literal string.
	 * @param L Lua state.
	 * @param s The string.
	 */
	@:native('lua_pushliteral')
	static function pushliteral(L:cpp.RawPointer<Lua_State>, s:cpp.ConstCharStar):Void;

	/**
	 * Pops the top value and stores it in the global `s`.
	 * @param L Lua state.
	 * @param s Global name.
	 */
	@:native('lua_setglobal')
	static function setglobal(L:cpp.RawPointer<Lua_State>, s:cpp.ConstCharStar):Void;

	/**
	 * Pushes the value of the global `s`.
	 * @param L Lua state.
	 * @param s Global name.
	 * @return Type of the resulting value.
	 */
	@:native('lua_getglobal')
	static function getglobal(L:cpp.RawPointer<Lua_State>, s:cpp.ConstCharStar):Int;

	/**
	 * Converts the value at the given index to a string.
	 * @param L Lua state.
	 * @param i Stack index.
	 * @return The string.
	 */
	@:native('lua_tostring')
	static function tostring(L:cpp.RawPointer<Lua_State>, i:Int):cpp.ConstCharStar;

	/**
	 * Returns the main thread of the state.
	 * @param L Lua state.
	 * @return The main thread.
	 */
	@:native('lua_mainthread')
	static function mainthread(L:cpp.RawPointer<Lua_State>):cpp.RawPointer<Lua_State>;

	/**
	 * Resets a thread, clearing its stack and call info.
	 * @param L Thread to reset.
	 */
	@:native('lua_resetthread')
	static function resetthread(L:cpp.RawPointer<Lua_State>):Void;

	/**
	 * Whether a thread is in the reset state.
	 * @param L Lua state.
	 * @return 1 if reset, 0 otherwise.
	 */
	@:native('lua_isthreadreset')
	static function isthreadreset(L:cpp.RawPointer<Lua_State>):Int;

	/**
	 * Converts any acceptable index to an absolute one.
	 * @param L Lua state.
	 * @param idx Stack index (pseudo-indices allowed).
	 * @return The absolute index.
	 */
	@:native('lua_absindex')
	static function absindex(L:cpp.RawPointer<Lua_State>, idx:Int):Int;

	/**
	 * Grows the stack by `sz` slots without raising an error.
	 * @param L Lua state.
	 * @param sz Extra slots.
	 */
	@:native('lua_rawcheckstack')
	static function rawcheckstack(L:cpp.RawPointer<Lua_State>, sz:Int):Void;

	/**
	 * Pushes a copy of a value from one state onto another.
	 * @param from Source state.
	 * @param to Destination state.
	 * @param idx Index in the source state.
	 */
	@:native('lua_xpush')
	static function xpush(from:cpp.RawPointer<Lua_State>, to:cpp.RawPointer<Lua_State>, idx:Int):Void;

	/**
	 * Calls a C function in protected mode (like pcall, for C).
	 * @param L Lua state.
	 * @param func The C function.
	 * @param ud User data passed to `func`.
	 * @return 0 on success, or an error code.
	 */
	@:native('lua_cpcall')
	static function cpcall(L:cpp.RawPointer<Lua_State>, func:Lua_CFunction, ud:cpp.RawPointer<cpp.Void>):Int;

	/**
	 * Whether the value is a 64-bit integer.
	 * @param L Lua state.
	 * @param idx Stack index.
	 * @return 1 if int64, 0 otherwise.
	 */
	@:native('lua_isinteger64')
	static function isinteger64(L:cpp.RawPointer<Lua_State>, idx:Int):Int;

	/**
	 * Whether the value is a Lua function (not a C function).
	 * @param L Lua state.
	 * @param idx Stack index.
	 * @return 1 if a Lua function, 0 otherwise.
	 */
	@:native('lua_isLfunction')
	static function isLfunction(L:cpp.RawPointer<Lua_State>, idx:Int):Int;

	/**
	 * Converts the value to a number, reporting success.
	 * @param L Lua state.
	 * @param idx Stack index.
	 * @param isnum Receives 1 if the conversion succeeded.
	 * @return The number.
	 */
	@:native('lua_tonumberx')
	static function tonumberx(L:cpp.RawPointer<Lua_State>, idx:Int, isnum:cpp.RawPointer<Int>):Lua_Number;

	/**
	 * Converts the value to an integer, reporting success.
	 * @param L Lua state.
	 * @param idx Stack index.
	 * @param isnum Receives 1 if the conversion succeeded.
	 * @return The integer.
	 */
	@:native('lua_tointegerx')
	static function tointegerx(L:cpp.RawPointer<Lua_State>, idx:Int, isnum:cpp.RawPointer<Int>):Lua_Integer;

	/**
	 * Converts the value to an unsigned integer, reporting success.
	 * @param L Lua state.
	 * @param idx Stack index.
	 * @param isnum Receives 1 if the conversion succeeded.
	 * @return The unsigned integer.
	 */
	@:native('lua_tounsignedx')
	static function tounsignedx(L:cpp.RawPointer<Lua_State>, idx:Int, isnum:cpp.RawPointer<Int>):UInt;

	/**
	 * Returns the value as a vector, or null.
	 * @param L Lua state.
	 * @param idx Stack index.
	 * @return Pointer to 3 (or 4) floats, or null.
	 */
	@:native('lua_tovector')
	static function tovector(L:cpp.RawPointer<Lua_State>, idx:Int):cpp.RawConstPointer<Single>;

	/**
	 * Converts the value to a 64-bit integer.
	 * @param L Lua state.
	 * @param idx Stack index.
	 * @param isinteger Receives 1 if the value was an integer.
	 * @return The 64-bit value.
	 */
	@:native('lua_tointeger64')
	static function tointeger64(L:cpp.RawPointer<Lua_State>, idx:Int, isinteger:cpp.RawPointer<Int>):haxe.Int64;

	/**
	 * Returns the buffer data and its length.
	 * @param L Lua state.
	 * @param idx Stack index.
	 * @param len Receives the buffer length.
	 * @return Pointer to the buffer data.
	 */
	@:native('lua_tobuffer')
	static function tobuffer(L:cpp.RawPointer<Lua_State>, idx:Int, len:cpp.RawPointer<cpp.SizeT>):cpp.RawPointer<cpp.Void>;

	/**
	 * Returns the value as a light-userdata pointer, or null.
	 * @param L Lua state.
	 * @param idx Stack index.
	 * @return The pointer, or null.
	 */
	@:native('lua_tolightuserdata')
	static function tolightuserdata(L:cpp.RawPointer<Lua_State>, idx:Int):cpp.RawPointer<cpp.Void>;

	/**
	 * Pushes a 64-bit integer.
	 * @param L Lua state.
	 * @param n The value.
	 */
	@:native('lua_pushinteger64')
	static function pushinteger64(L:cpp.RawPointer<Lua_State>, n:haxe.Int64):Void;

	/**
	 * Pushes an unsigned integer.
	 * @param L Lua state.
	 * @param n The value.
	 */
	@:native('lua_pushunsigned')
	static function pushunsigned(L:cpp.RawPointer<Lua_State>, n:UInt):Void;

	/**
	 * Pushes a 3-component vector.
	 * @param L Lua state.
	 * @param x X component.
	 * @param y Y component.
	 * @param z Z component.
	 */
	@:native('lua_pushvector')
	static function pushvector(L:cpp.RawPointer<Lua_State>, x:Float, y:Float, z:Float):Void;

	/**
	 * Creates and pushes a buffer of the given size.
	 * @param L Lua state.
	 * @param sz Buffer size in bytes.
	 * @return Pointer to the buffer data.
	 */
	@:native('lua_newbuffer')
	static function newbuffer(L:cpp.RawPointer<Lua_State>, sz:cpp.SizeT):cpp.RawPointer<cpp.Void>;

	/**
	 * Pushes a tagged light userdata.
	 * @param L Lua state.
	 * @param p The pointer.
	 * @param tag Tag id.
	 */
	@:native('lua_pushlightuserdatatagged')
	static function pushlightuserdatatagged(L:cpp.RawPointer<Lua_State>, p:cpp.RawPointer<cpp.Void>, tag:Int):Void;

	/**
	 * Pushes `t[k]` by string key without metamethods.
	 * @param L Lua state.
	 * @param idx Table index.
	 * @param k Field name.
	 * @return Type of the resulting value.
	 */
	@:native('lua_rawgetfield')
	static function rawgetfield(L:cpp.RawPointer<Lua_State>, idx:Int, k:cpp.ConstCharStar):Int;

	/**
	 * Does `t[k] = v` (v on top) by string key without metamethods.
	 * @param L Lua state.
	 * @param idx Table index.
	 * @param k Field name.
	 */
	@:native('lua_rawsetfield')
	static function rawsetfield(L:cpp.RawPointer<Lua_State>, idx:Int, k:cpp.ConstCharStar):Void;

	/**
	 * Pushes the environment table of the value.
	 * @param L Lua state.
	 * @param idx Stack index.
	 */
	@:native('lua_getfenv')
	static function getfenv(L:cpp.RawPointer<Lua_State>, idx:Int):Void;

	/**
	 * Pops a table and sets it as the environment of the value.
	 * @param L Lua state.
	 * @param idx Stack index.
	 * @return 1 on success, 0 on failure.
	 */
	@:native('lua_setfenv')
	static function setfenv(L:cpp.RawPointer<Lua_State>, idx:Int):Int;

	/**
	 * Iterates a table's raw entries, pushing the key and value at each step.
	 * @param L Lua state.
	 * @param idx Table index.
	 * @param iter Current iterator (0 to start).
	 * @return Next iterator value, or -1 when iteration ends.
	 */
	@:native('lua_rawiter')
	static function rawiter(L:cpp.RawPointer<Lua_State>, idx:Int, iter:Int):Int;

	/**
	 * Pushes a table entry keyed by a tagged pointer, without metamethods.
	 * @param L Lua state.
	 * @param idx Table index.
	 * @param p Pointer key.
	 * @param tag Tag id.
	 * @return Type of the resulting value.
	 */
	@:native('lua_rawgetptagged')
	static function rawgetptagged(L:cpp.RawPointer<Lua_State>, idx:Int, p:cpp.RawPointer<cpp.Void>, tag:Int):Int;

	/**
	 * Pushes a table entry keyed by a pointer (tag 0), without metamethods.
	 * @param L Lua state.
	 * @param idx Table index.
	 * @param p Pointer key.
	 * @return Type of the resulting value.
	 */
	@:native('lua_rawgetp')
	static function rawgetp(L:cpp.RawPointer<Lua_State>, idx:Int, p:cpp.RawPointer<cpp.Void>):Int;

	/**
	 * Sets a table entry keyed by a tagged pointer (value on top), without metamethods.
	 * @param L Lua state.
	 * @param idx Table index.
	 * @param p Pointer key.
	 * @param tag Tag id.
	 */
	@:native('lua_rawsetptagged')
	static function rawsetptagged(L:cpp.RawPointer<Lua_State>, idx:Int, p:cpp.RawPointer<cpp.Void>, tag:Int):Void;

	/**
	 * Sets a table entry keyed by a pointer (value on top, tag 0), without metamethods.
	 * @param L Lua state.
	 * @param idx Table index.
	 * @param p Pointer key.
	 */
	@:native('lua_rawsetp')
	static function rawsetp(L:cpp.RawPointer<Lua_State>, idx:Int, p:cpp.RawPointer<cpp.Void>):Void;

	/**
	 * Yields execution for a debug breakpoint.
	 * @param L Lua state.
	 * @return `Lua.YIELD`.
	 */
	@:native('lua_break')
	static function lua_break(L:cpp.RawPointer<Lua_State>):Int;

	/**
	 * Resumes a coroutine to raise an error in it.
	 * @param L Coroutine to resume.
	 * @param from Resuming state.
	 * @return A status code.
	 */
	@:native('lua_resumeerror')
	static function resumeerror(L:cpp.RawPointer<Lua_State>, from:cpp.RawPointer<Lua_State>):Int;

	/**
	 * Whether the current thread can yield.
	 * @param L Lua state.
	 * @return 1 if yieldable, 0 otherwise.
	 */
	@:native('lua_isyieldable')
	static function isyieldable(L:cpp.RawPointer<Lua_State>):Int;

	/**
	 * Returns the thread's user data pointer.
	 * @param L Lua state.
	 * @return The pointer.
	 */
	@:native('lua_getthreaddata')
	static function getthreaddata(L:cpp.RawPointer<Lua_State>):cpp.RawPointer<cpp.Void>;

	/**
	 * Sets the thread's user data pointer.
	 * @param L Lua state.
	 * @param data The pointer.
	 */
	@:native('lua_setthreaddata')
	static function setthreaddata(L:cpp.RawPointer<Lua_State>, data:cpp.RawPointer<cpp.Void>):Void;

	/**
	 * Returns the detailed status of a coroutine.
	 * @param L Lua state.
	 * @param co Coroutine to query.
	 * @return One of `Lua.CORUN`/`COSUS`/`CONOR`/`COFIN`/`COERR`.
	 */
	@:native('lua_costatus')
	static function costatus(L:cpp.RawPointer<Lua_State>, co:cpp.RawPointer<Lua_State>):Int;

	/**
	 * Returns a userdata block only if its tag matches.
	 * @param L Lua state.
	 * @param idx Stack index.
	 * @param tag Expected tag.
	 * @return The block, or null on mismatch.
	 */
	@:native('lua_touserdatatagged')
	static function touserdatatagged(L:cpp.RawPointer<Lua_State>, idx:Int, tag:Int):cpp.RawPointer<cpp.Void>;

	/**
	 * Returns the tag of a userdata.
	 * @param L Lua state.
	 * @param idx Stack index.
	 * @return The tag id.
	 */
	@:native('lua_userdatatag')
	static function userdatatag(L:cpp.RawPointer<Lua_State>, idx:Int):Int;

	/**
	 * Returns a light-userdata pointer only if its tag matches.
	 * @param L Lua state.
	 * @param idx Stack index.
	 * @param tag Expected tag.
	 * @return The pointer, or null on mismatch.
	 */
	@:native('lua_tolightuserdatatagged')
	static function tolightuserdatatagged(L:cpp.RawPointer<Lua_State>, idx:Int, tag:Int):cpp.RawPointer<cpp.Void>;

	/**
	 * Returns the tag of a light userdata.
	 * @param L Lua state.
	 * @param idx Stack index.
	 * @return The tag id.
	 */
	@:native('lua_lightuserdatatag')
	static function lightuserdatatag(L:cpp.RawPointer<Lua_State>, idx:Int):Int;

	/**
	 * Changes the tag of a userdata.
	 * @param L Lua state.
	 * @param idx Stack index.
	 * @param tag New tag id.
	 */
	@:native('lua_setuserdatatag')
	static function setuserdatatag(L:cpp.RawPointer<Lua_State>, idx:Int, tag:Int):Void;

	/**
	 * Associates the metatable on top of the stack with a userdata tag.
	 * @param L Lua state.
	 * @param tag Userdata tag.
	 */
	@:native('lua_setuserdatametatable')
	static function setuserdatametatable(L:cpp.RawPointer<Lua_State>, tag:Int):Void;

	/**
	 * Pushes the metatable associated with a userdata tag.
	 * @param L Lua state.
	 * @param tag Userdata tag.
	 */
	@:native('lua_getuserdatametatable')
	static function getuserdatametatable(L:cpp.RawPointer<Lua_State>, tag:Int):Void;

	/**
	 * Returns the name of a userdata tag - `__type` from the metatable or "userdata" if it is not set.
	 * @param L Lua state.
	 * @param tag Userdata tag.
	 * @return Name of the userdata tag.
	 */
	@:native('lua_getuserdataname')
	static function getuserdataname(L:cpp.RawPointer<Lua_State>, tag:Int):cpp.ConstCharStar;

	/**
	 * Registers direct __index, __newindex, and __namecall handlers for a userdata tag.
	 * @param L Lua state.
	 * @param tag Userdata tag.
	 * @param get Getter, or null.
	 * @param set Setter, or null.
	 * @param namecall Namecall handler, or null.
	 * @return 1 on success, 0 on failure.
	 */
	@:native('lua_registeruserdatadirectaccess')
	static function registeruserdatadirectaccess(L:cpp.RawPointer<Lua_State>, tag:Int, get:Lua_UserdataDirectAccess, set:Lua_UserdataDirectAccess, namecall:Lua_UserdataDirectNamecall):Int;

	/**
	 * Registers a direct getter for a specific field of a userdata tag.
	 * @param L Lua state.
	 * @param tag Userdata tag.
	 * @param field Field name.
	 * @param fn Getter callback.
	 */
	@:native('lua_registeruserdatadirectfieldget')
	static function registeruserdatadirectfieldget(L:cpp.RawPointer<Lua_State>, tag:Int, field:cpp.ConstCharStar, fn:Lua_UserdataDirectFieldGet):Void;

	/**
	 * Writes a number into a direct-field result slot.
	 * @param result Result slot.
	 * @param n The number.
	 */
	@:native('lua_userdatadirectfield_setnumber')
	static function userdatadirectfield_setnumber(result:cpp.RawPointer<cpp.Void>, n:Lua_Number):Void;

	/**
	 * Writes a vector into a direct-field result slot.
	 * @param result Result slot.
	 * @param x X component.
	 * @param y Y component.
	 * @param z Z component.
	 */
	@:native('lua_userdatadirectfield_setvector')
	static function userdatadirectfield_setvector(result:cpp.RawPointer<cpp.Void>, x:Float, y:Float, z:Float):Void;

	/**
	 * Writes a boolean into a direct-field result slot.
	 * @param result Result slot.
	 * @param b The boolean.
	 */
	@:native('lua_userdatadirectfield_setboolean')
	static function userdatadirectfield_setboolean(result:cpp.RawPointer<cpp.Void>, b:Int):Void;

	/**
	 * Writes a 64-bit integer into a direct-field result slot.
	 * @param result Result slot.
	 * @param n The value.
	 */
	@:native('lua_userdatadirectfield_setinteger64')
	static function userdatadirectfield_setinteger64(result:cpp.RawPointer<cpp.Void>, n:haxe.Int64):Void;

	/**
	 * Writes nil into a direct-field result slot.
	 * @param result Result slot.
	 */
	@:native('lua_userdatadirectfield_setnil')
	static function userdatadirectfield_setnil(result:cpp.RawPointer<cpp.Void>):Void;

	/**
	 * Creates and pushes a tagged userdata block.
	 * @param L Lua state.
	 * @param sz Block size.
	 * @param tag Userdata tag.
	 * @return Pointer to the block.
	 */
	@:native('lua_newuserdatatagged')
	static function newuserdatatagged(L:cpp.RawPointer<Lua_State>, sz:cpp.SizeT, tag:Int):cpp.RawPointer<cpp.Void>;

	/**
	 * Creates and pushes a tagged userdata using the tag's registered metatable.
	 * @param L Lua state.
	 * @param sz Block size.
	 * @param tag Userdata tag.
	 * @return Pointer to the block.
	 */
	@:native('lua_newuserdatataggedwithmetatable')
	static function newuserdatataggedwithmetatable(L:cpp.RawPointer<Lua_State>, sz:cpp.SizeT, tag:Int):cpp.RawPointer<cpp.Void>;

	/**
	 * Sets a display name for a light-userdata tag.
	 * @param L Lua state.
	 * @param tag Light-userdata tag.
	 * @param name Display name.
	 */
	@:native('lua_setlightuserdataname')
	static function setlightuserdataname(L:cpp.RawPointer<Lua_State>, tag:Int, name:cpp.ConstCharStar):Void;

	/**
	 * Returns the display name of a light-userdata tag.
	 * @param L Lua state.
	 * @param tag Light-userdata tag.
	 * @return The name.
	 */
	@:native('lua_getlightuserdataname')
	static function getlightuserdataname(L:cpp.RawPointer<Lua_State>, tag:Int):cpp.ConstCharStar;

	/**
	 * Encodes a pointer so it is safe to use as a table key.
	 * @param L Lua state.
	 * @param p Pointer value.
	 * @return The encoded value.
	 */
	@:native('lua_encodepointer')
	static function encodepointer(L:cpp.RawPointer<Lua_State>, p:cpp.SizeT):cpp.SizeT;

	/**
	 * Returns the wall-clock time in seconds (no state needed).
	 * @return The time.
	 */
	@:native('lua_clock')
	static function clock():Lua_Number;

	/**
	 * Returns the VM callbacks struct (interrupt, panic, debug hooks, etc.).
	 * @param L Lua state.
	 * @return The callbacks struct.
	 */
	@:native('lua_callbacks')
	static function callbacks(L:cpp.RawPointer<Lua_State>):cpp.RawPointer<Lua_Callbacks>;

	/**
	 * Returns the current call-stack depth.
	 * @param L Lua state.
	 * @return The depth.
	 */
	@:native('lua_stackdepth')
	static function stackdepth(L:cpp.RawPointer<Lua_State>):Int;

	/**
	 * Fills a debug record for the function at a call level.
	 * @param L Lua state.
	 * @param level Call level (0 is the current function).
	 * @param what Info to retrieve ("n", "s", "l", "u", "a", "f").
	 * @param ar Record to fill.
	 * @return 1 on success, 0 on failure.
	 */
	@:native('lua_getinfo')
	static function getinfo(L:cpp.RawPointer<Lua_State>, level:Int, what:cpp.ConstCharStar, ar:cpp.RawPointer<Lua_Debug>):Int;

	/**
	 * Pushes a function argument from a given call level.
	 * @param L Lua state.
	 * @param level Call level.
	 * @param n Argument index (1-based).
	 * @return Type of the pushed value.
	 */
	@:native('lua_getargument')
	static function getargument(L:cpp.RawPointer<Lua_State>, level:Int, n:Int):Int;

	/**
	 * Pushes a local variable's value and returns its name.
	 * @param L Lua state.
	 * @param level Call level.
	 * @param n Local index.
	 * @return The variable name, or null if out of range.
	 */
	@:native('lua_getlocal')
	static function getlocal(L:cpp.RawPointer<Lua_State>, level:Int, n:Int):cpp.ConstCharStar;

	/**
	 * Sets a local variable from the top of the stack and returns its name.
	 * @param L Lua state.
	 * @param level Call level.
	 * @param n Local index.
	 * @return The variable name, or null if out of range.
	 */
	@:native('lua_setlocal')
	static function setlocal(L:cpp.RawPointer<Lua_State>, level:Int, n:Int):cpp.ConstCharStar;

	/**
	 * Pushes an upvalue's value and returns its name.
	 * @param L Lua state.
	 * @param funcindex Function index.
	 * @param n Upvalue index (1-based).
	 * @return The upvalue name, or null if out of range.
	 */
	@:native('lua_getupvalue')
	static function getupvalue(L:cpp.RawPointer<Lua_State>, funcindex:Int, n:Int):cpp.ConstCharStar;

	/**
	 * Sets an upvalue from the top of the stack and returns its name.
	 * @param L Lua state.
	 * @param funcindex Function index.
	 * @param n Upvalue index (1-based).
	 * @return The upvalue name, or null if out of range.
	 */
	@:native('lua_setupvalue')
	static function setupvalue(L:cpp.RawPointer<Lua_State>, funcindex:Int, n:Int):cpp.ConstCharStar;

	/**
	 * Enables or disables debugger single-stepping.
	 * @param L Lua state.
	 * @param enabled 1 to enable, 0 to disable.
	 */
	@:native('lua_singlestep')
	static function singlestep(L:cpp.RawPointer<Lua_State>, enabled:Int):Void;

	/**
	 * Sets or clears a breakpoint in a function.
	 * @param L Lua state.
	 * @param funcindex Function index.
	 * @param line Line number.
	 * @param enabled 1 to set, 0 to clear.
	 * @return 1 on success, 0 otherwise.
	 */
	@:native('lua_breakpoint')
	static function breakpoint(L:cpp.RawPointer<Lua_State>, funcindex:Int, line:Int, enabled:Int):Int;

	/**
	 * Returns a stack-trace string. Not thread-safe.
	 * @param L Lua state.
	 * @return The trace string.
	 */
	@:native('lua_debugtrace')
	static function debugtrace(L:cpp.RawPointer<Lua_State>):cpp.ConstCharStar;

	/**
	 * Sets the destructor for a userdata tag.
	 * @param L Lua state.
	 * @param tag Userdata tag.
	 * @param dtor Destructor function.
	 */
	@:native('lua_setuserdatadtor')
	static function setuserdatadtor(L:cpp.RawPointer<Lua_State>, tag:Int, dtor:Lua_Destructor):Void;

	/**
	 * Returns the destructor for a userdata tag.
	 * @param L Lua state.
	 * @param tag Userdata tag.
	 * @return The destructor function.
	 */
	@:native('lua_getuserdatadtor')
	static function getuserdatadtor(L:cpp.RawPointer<Lua_State>, tag:Int):Lua_Destructor;

	/**
	 * Creates and pushes a userdata with a custom destructor.
	 * @param L Lua state.
	 * @param sz Block size.
	 * @param dtor Called when the block is collected.
	 * @return Pointer to the block.
	 */
	@:native('lua_newuserdatadtor')
	static function newuserdatadtor(L:cpp.RawPointer<Lua_State>, sz:cpp.SizeT, dtor:cpp.Callable<(raw:cpp.RawPointer<cpp.Void>) -> Void>):cpp.RawPointer<cpp.Void>;

	/**
	 * Reports code-coverage data for a function.
	 * @param L Lua state.
	 * @param funcindex Function index.
	 * @param context User pointer passed to the callback.
	 * @param callback Called for each function with coverage data.
	 */
	@:native('lua_getcoverage')
	static function getcoverage(L:cpp.RawPointer<Lua_State>, funcindex:Int, context:cpp.RawPointer<cpp.Void>, callback:Lua_Coverage):Void;

	/**
	 * Reports native codegen execution counters for a compiled function.
	 * Counter kinds are 1 for a regular block, 2 for a fallback block, and 3 for a VM exit.
	 * @param L Lua state.
	 * @param funcindex Function index.
	 * @param context User pointer passed to both callbacks.
	 * @param functioncb Called once per function in the proto tree.
	 * @param valuecb Called once per counter entry.
	 */
	@:native('lua_getcounters')
	static function getcounters(L:cpp.RawPointer<Lua_State>, funcindex:Int, context:cpp.RawPointer<cpp.Void>, functioncb:Lua_CounterFunction, valuecb:Lua_CounterValue):Void;
}
