package hxluau;

#if !cpp
#error 'Luau supports only C++ target platforms.'
#end
import hxluau.Types;

/** Luau-specific bytecode compilation, loading, and native codegen (not part of the standard Lua API). */
@:buildXml('<include name="${haxelib:hxluau}/project/Build.xml" />')
@:include('lua.h')
@:include('luacode.h')
@:include('luacodegen.h')
@:include('luajitinliner.h')
@:unreflective
extern class LuauVM
{
	/**
	 * Compiles Lua source into Luau bytecode.
	 *
	 * On failure the buffer holds the encoded error and still loads via `load`,
	 * which then reports it. The buffer is heap-allocated; free it with `free`
	 * (e.g. `cpp.Stdlib.free`).
	 *
	 * @param source Lua source code.
	 * @param size Length of `source`.
	 * @param options Compile options, or null for defaults.
	 * @param bytecodeSize Receives the bytecode length.
	 * @return The bytecode, or null on out-of-memory.
	 */
	@:native('luau_compile')
	static function compile(source:cpp.ConstCharStar, size:cpp.SizeT, options:cpp.RawPointer<Lua_CompileOptions>, bytecodeSize:cpp.Star<cpp.SizeT>):cpp.RawPointer<cpp.Char>;

	/**
	 * Loads precompiled bytecode into the state.
	 * @param L Lua state.
	 * @param chunkname Chunk name (for error and debug messages).
	 * @param bytecode The compiled bytecode.
	 * @param bytecodeSize Length of `bytecode`.
	 * @param env Environment index (0 for default).
	 * @return 0 on success, or an error code.
	 */
	@:native('luau_load')
	static function load(L:cpp.RawPointer<Lua_State>, chunkname:cpp.ConstCharStar, bytecode:cpp.ConstCharStar, bytecodeSize:cpp.SizeT, env:Int):Int;

	/**
	 * Whether native codegen is supported on this platform.
	 * @return 1 if supported, 0 otherwise.
	 */
	@:native('luau_codegen_supported')
	static function codegen_supported():Int;

	/**
	 * Creates a codegen instance bound to the state (check support first).
	 * @param L Lua state.
	 */
	@:native('luau_codegen_create')
	static function codegen_create(L:cpp.RawPointer<Lua_State>):Void;

	/**
	 * Compiles the function at `idx` (and its inner functions) to native code.
	 * @param L Lua state.
	 * @param idx Stack index of the function.
	 */
	@:native('luau_codegen_compile')
	static function codegen_compile(L:cpp.RawPointer<Lua_State>, idx:Int):Void;

	/**
	 * Sets a compile constant to nil.
	 * @param constant The compile constant to set.
	 */
	@:native('luau_set_compile_constant_nil')
	static function compileConstantNil(constant:cpp.RawPointer<Lua_CompileConstant>):Void;

	/**
	 * Sets a compile constant to a boolean.
	 * @param constant The compile constant to set.
	 * @param b The boolean value.
	 */
	@:native('luau_set_compile_constant_boolean')
	static function compileConstantBoolean(constant:cpp.RawPointer<Lua_CompileConstant>, b:Int):Void;

	/**
	 * Sets a compile constant to a number.
	 * @param constant The compile constant to set.
	 * @param n The number value.
	 */
	@:native('luau_set_compile_constant_number')
	static function compileConstantNumber(constant:cpp.RawPointer<Lua_CompileConstant>, n:Lua_Number):Void;

	/**
	 * Sets a compile constant to a 64-bit integer.
	 * @param constant The compile constant to set.
	 * @param l The integer value.
	 */
	@:native('luau_set_compile_constant_integer64')
	static function compileConstantInteger64(constant:cpp.RawPointer<Lua_CompileConstant>, l:haxe.Int64):Void;

	/**
	 * Sets a compile constant to a vector.
	 * @param constant The compile constant to set.
	 * @param x X component.
	 * @param y Y component.
	 * @param z Z component.
	 * @param w W component.
	 */
	@:native('luau_set_compile_constant_vector')
	static function compileConstantVector(constant:cpp.RawPointer<Lua_CompileConstant>, x:Float, y:Float, z:Float, w:Float):Void;

	/**
	 * Sets a compile constant to a vector, taking double-precision components.
	 * @param constant The compile constant to set.
	 * @param x X component.
	 * @param y Y component.
	 * @param z Z component.
	 * @param w W component.
	 */
	@:native('luau_set_compile_constant_vectord')
	static function compileConstantVectord(constant:cpp.RawPointer<Lua_CompileConstant>, x:Float, y:Float, z:Float, w:Float):Void;

	/**
	 * Sets a compile constant to a string.
	 * @param constant The compile constant to set.
	 * @param s The string value.
	 * @param l Length of `s`.
	 */
	@:native('luau_set_compile_constant_string')
	static function compileConstantString(constant:cpp.RawPointer<Lua_CompileConstant>, s:cpp.ConstCharStar, l:cpp.SizeT):Void;

	/**
	 * Enables the JIT inliner for the given state.
	 * @param L Lua state.
	 */
	@:native('luau_enable_jit_inliner')
	static function enable_jit_inliner(L:cpp.RawPointer<Lua_State>):Void;

	/**
	 * Disables the JIT inliner for the given state.
	 * @param L Lua state.
	 */
	@:native('luau_disable_jit_inliner')
	static function disable_jit_inliner(L:cpp.RawPointer<Lua_State>):Void;
}
