package hxluau;

/** Placeholder so Luau types can be imported; holds no members. */
#if !cpp
#error 'Luau supports only C++ target platforms.'
#end
class Types {}

/** A Lua interpreter state (`lua_State`) holding the whole execution context. */
@:buildXml('<include name="${haxelib:hxluau}/project/Build.xml" />')
@:include('lua.h')
@:include('lualib.h')
@:include('luacode.h')
@:native('lua_State')
extern class Lua_State {}

/** A C function callable from Lua. Returns the number of results it pushed. */
typedef Lua_CFunction = cpp.Callable<(L:cpp.RawPointer<Lua_State>) -> Int>;

/** Continuation run after a yield, resuming a C function. */
typedef Lua_Continuation = cpp.Callable<(L:cpp.RawPointer<Lua_State>, status:Int) -> Int>;

/** Realloc-style memory allocator. An `nsize` of 0 frees `ptr`. Returns the new block. */
typedef Lua_Alloc = cpp.Callable<(ud:cpp.RawPointer<cpp.Void>, ptr:cpp.RawPointer<cpp.Void>, osize:cpp.SizeT, nsize:cpp.SizeT) -> cpp.RawPointer<cpp.Void>>;

/** Opaque compile-constant handle passed to luacode callbacks. */
typedef Lua_CompileConstant = cpp.RawPointer<cpp.Void>;

/** Returns a type id for a known library member, used during compilation. */
typedef Lua_LibraryMemberTypeCallback = cpp.Callable<(library:cpp.ConstCharStar, member:cpp.ConstCharStar) -> Int>;

/** Fills a constant value for a known library member, used during compilation. */
typedef Lua_LibraryMemberConstantCallback = cpp.Callable<(library:cpp.ConstCharStar, member:cpp.ConstCharStar, constant:cpp.RawPointer<Lua_CompileConstant>) -> Void>;

/**
 * Options for `LuauVM.compile` (mirrors C `lua_CompileOptions`).
 *
 * A fresh struct is all-zero, so set only the fields you need. Passing `null`
 * to the compiler uses its defaults (optimizationLevel 1 and debugLevel 1).
 */
@:buildXml('<include name="${haxelib:hxluau}/project/Build.xml" />')
@:include('luacode.h')
@:unreflective
@:structAccess
@:native('lua_CompileOptions')
extern class Lua_CompileOptions
{
	/** Allocates a new instance. */
	function new():Void;

	/** 0 for none, 1 for baseline (debuggable), 2 for aggressive (inlining). Default 1. */
	var optimizationLevel:Int;

	/** 0 for none, 1 for lines and function names, 2 for local and upvalue names. Default 1. */
	var debugLevel:Int;

	/** 0 for native modules only, 1 for all modules. Default 0. */
	var typeInfoLevel:Int;

	/** 0 for none, 1 for statement, 2 for statement and expression. Default 0. */
	var coverageLevel:Int;

	/** Extra global builtin for constructing vectors, or null. */
	var vectorLib:cpp.ConstCharStar;

	/** Alternative vector constructor name, or null. */
	var vectorCtor:cpp.ConstCharStar;

	/** Alternative vector type name for type tables, or null. */
	var vectorType:cpp.ConstCharStar;

	/** 0 for 32-bit float vector components, 1 for 64-bit double components. Default 0. */
	var vectorPrecision:Int;

	/** Null-terminated list of mutable globals (disables import optimization for their fields), or null. */
	var mutableGlobals:cpp.RawPointer<cpp.RawConstPointer<cpp.Char>>;

	/** Null-terminated list of userdata type names included in type info, or null. */
	var userdataTypes:cpp.RawPointer<cpp.RawConstPointer<cpp.Char>>;

	/** Null-terminated list of library globals with known members, or null. */
	var librariesWithKnownMembers:cpp.RawPointer<cpp.RawConstPointer<cpp.Char>>;

	/** Callback returning a type id for a known library member, or null. */
	var libraryMemberTypeCb:Lua_LibraryMemberTypeCallback;

	/** Callback filling a constant for a known library member, or null. */
	var libraryMemberConstantCb:Lua_LibraryMemberConstantCallback;

	/** Null-terminated list of builtins excluded from fastcall ("name" or "lib.name"), or null. */
	var disabledBuiltins:cpp.RawPointer<cpp.RawConstPointer<cpp.Char>>;
}

/** Lua floating-point number type (`lua_Number`). */
@:buildXml('<include name="${haxelib:hxluau}/project/Build.xml" />')
@:include('lua.h')
@:native('lua_Number')
@:scalar
@:coreType
@:notNull
extern abstract Lua_Number from Float to Float {}

/** Lua integer type (`lua_Integer`). */
@:buildXml('<include name="${haxelib:hxluau}/project/Build.xml" />')
@:include('lua.h')
@:native('lua_Integer')
@:scalar
@:coreType
@:notNull
extern abstract Lua_Integer from Int to Int {}

/** Activation record describing a function or call frame (`lua_Debug`). */
@:buildXml('<include name="${haxelib:hxluau}/project/Build.xml" />')
@:include('lua.h')
@:unreflective
@:structAccess
@:native('lua_Debug')
extern class Lua_Debug
{
	/** Allocates a new instance. */
	function new():Void;

	/** Function name, if known. */
	var name:cpp.ConstCharStar;

	/** Source kind ("Lua", "C", etc.). */
	var what:cpp.ConstCharStar;

	/** Chunk source. */
	var source:cpp.ConstCharStar;

	/** Short, printable source description. */
	var short_src:cpp.ConstCharStar;

	/** Line where the function is defined. */
	var linedefined:Int;

	/** Current line being executed. */
	var currentline:Int;

	/** Globally unique (within the VM) proto id; 0 for C functions. */
	var protoid:Int;

	/** Proto index within its bytecode module; -1 for C functions. */
	var bytecodeid:Int;

	/** Number of upvalues. */
	var nupvals:cpp.UInt8;

	/** Number of parameters. */
	var nparams:cpp.UInt8;

	/** 1 if the function is vararg, 0 otherwise. */
	var isvararg:cpp.Int8;

	/** User pointer for Luau debug callbacks. */
	var userdata:cpp.RawPointer<cpp.Void>;
}

/** Debug hook invoked on specific VM events. */
typedef Lua_Hook = cpp.Callable<(L:cpp.RawPointer<Lua_State>, ar:cpp.RawPointer<Lua_Debug>) -> Void>;

/** Destructor for a userdata type (`lua_Destructor`). */
/** Names a memory category for `Lua.memorydump`. */
typedef Lua_CategoryName = cpp.Callable<(L:cpp.RawPointer<Lua_State>, memcat:cpp.UInt8) -> cpp.ConstCharStar>;

/** Userdata GC-mark callback; only read-only APIs are safe to call from it. */
typedef Lua_UserdataMark = cpp.Callable<(L:cpp.RawPointer<Lua_State>, ud:cpp.RawPointer<cpp.Void>) -> Void>;

/**
 * Marks an embedder reference as reachable during GC.
 *
 * Bound as the opaque C typedef rather than a `cpp.Callable`, because it appears as a
 * parameter of `Lua_EmbedderGc`: emitting `cpp::Function` there would not match the
 * raw function pointer C declares, and the call would not compile.
 */
@:include('lua.h')
@:native('lua_EmbedderMark')
extern class Lua_EmbedderMark {}

/** Embedder GC callback, invoked with the mark function to report live references. */
typedef Lua_EmbedderGc = cpp.Callable<(L:cpp.RawPointer<Lua_State>, markref:Lua_EmbedderMark) -> Void>;

typedef Lua_Destructor = cpp.Callable<(L:cpp.RawPointer<Lua_State>, userdata:cpp.RawPointer<cpp.Void>) -> Void>;

/** Direct-access callback for getting or setting a userdata field. */
typedef Lua_UserdataDirectAccess = cpp.Callable<(L:cpp.RawPointer<Lua_State>, data:cpp.RawPointer<cpp.Void>, atom:Int, cachedslot:cpp.RawPointer<cpp.UInt16>, utag:Int) -> Void>;

/** Direct-access callback for a userdata namecall. */
typedef Lua_UserdataDirectNamecall = cpp.Callable<(L:cpp.RawPointer<Lua_State>, data:cpp.RawPointer<cpp.Void>, atom:Int, cachedslot:cpp.RawPointer<cpp.UInt16>, utag:Int) -> Int>;

/** Direct per-field getter for userdata. */
typedef Lua_UserdataDirectFieldGet = cpp.Callable<(ud:cpp.RawPointer<cpp.Void>, result:cpp.RawPointer<cpp.Void>) -> Void>;

/** Per-function callback for native execution profiling. */
typedef Lua_CounterFunction = cpp.Callable<(context:cpp.RawPointer<cpp.Void>, functionName:cpp.ConstCharStar, linedefined:Int) -> Void>;

/** Per-counter callback for native execution profiling. */
typedef Lua_CounterValue = cpp.Callable<(context:cpp.RawPointer<cpp.Void>, kind:Int, line:Int, hits:cpp.UInt64) -> Void>;

/** Per-function callback for code-coverage reporting. */
typedef Lua_Coverage = cpp.Callable<(context:cpp.RawPointer<cpp.Void>, functionName:cpp.ConstCharStar, linedefined:Int, depth:Int, hits:cpp.RawConstPointer<Int>, size:cpp.SizeT) -> Void>;

/** Working buffer for building Lua strings (`luaL_Buffer`). */
@:buildXml('<include name="${haxelib:hxluau}/project/Build.xml" />')
@:include('lua.h')
@:include('lualib.h')
@:unreflective
@:structAccess
@:native('luaL_Buffer')
extern class LuaL_Buffer
{
	/** Allocates a new instance. */
	function new():Void;

	/** Current write position. */
	var p:cpp.CastCharStar;

	/** End of the current writable segment. */
	var end:cpp.CastCharStar;

	/** Owning Lua state. */
	var L:cpp.RawPointer<Lua_State>;

	/** Internal mutable string storage (opaque). */
	var storage:cpp.RawPointer<cpp.Void>;

	/** First byte of the inline buffer storage. */
	var buffer:cpp.Char;
}

/**
 * VM behavior callbacks (`lua_Callbacks`), shared by all coroutines.
 * Obtain with `Lua.callbacks(L)`.
 *
 * Note that C function-pointer fields cannot be set from Haxe due to ABI
 * differences. Use hxluau helpers instead, such as `Luau.enableAutoCompile`.
 */
@:buildXml('<include name="${haxelib:hxluau}/project/Build.xml" />')
@:include('lua.h')
@:unreflective
@:structAccess
@:native('lua_Callbacks')
extern class Lua_Callbacks
{
	/** User pointer that Luau never overwrites. */
	var userdata:cpp.RawPointer<cpp.Void>;
}

/** One name and function entry for registering a library (`luaL_Reg`). */
@:buildXml('<include name="${haxelib:hxluau}/project/Build.xml" />')
@:include('lua.h')
@:include('lualib.h')
@:unreflective
@:structAccess
@:native('luaL_Reg')
extern class LuaL_Reg
{
	/** Allocates a new instance. */
	function new():Void;

	/** Function name. */
	var name:cpp.ConstCharStar;

	/** The function. */
	var func:Lua_CFunction;
}
