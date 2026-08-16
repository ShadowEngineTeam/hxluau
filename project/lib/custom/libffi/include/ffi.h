/* -----------------------------------------------------------------*-C-*-
   libffi 3.5.2 - Copyright (c) 2011, 2014, 2019, 2021, 2022, 2024, 2025
                    Anthony Green
                  - Copyright (c) 1996-2003, 2007, 2008 Red Hat, Inc.

   ----------------------------------------------------------------------- */

#ifndef LIBFFI_H
#define LIBFFI_H

#ifdef __cplusplus
extern "C" {
#endif

/* Architecture detection -- must be defined before ffitarget.h */
#if defined(_M_X64) || defined(__x86_64__)
#  if defined(_WIN32)
#    define X86_WIN64
#  else
#    define X86_64
#  endif
#elif defined(_M_IX86) || defined(__i386__)
#  if defined(_WIN32)
#    define X86_WIN32
#  else
#    define X86
#  endif
#elif defined(_M_ARM64) || defined(__aarch64__)
#  define AARCH64
#elif defined(_M_ARM) || defined(__arm__)
#  define ARM
#endif

/* Include arch-specific ffitarget.h directly (avoids circular guard with dispatcher) */
#if defined(X86_WIN64) || defined(X86_64) || defined(X86) || defined(X86_WIN32)
#  include <x86/ffitarget.h>
#elif defined(AARCH64)
#  include <aarch64/ffitarget.h>
#elif defined(ARM)
#  include <arm/ffitarget.h>
#endif

/* FFI type constants (must be outside LIBFFI_ASM guard) */
#define FFI_TYPE_VOID       0
#define FFI_TYPE_INT        1
#define FFI_TYPE_FLOAT      2
#define FFI_TYPE_DOUBLE     3
#define FFI_TYPE_LONGDOUBLE 4
#define FFI_TYPE_UINT8      5
#define FFI_TYPE_SINT8      6
#define FFI_TYPE_UINT16     7
#define FFI_TYPE_SINT16     8
#define FFI_TYPE_UINT32     9
#define FFI_TYPE_SINT32     10
#define FFI_TYPE_UINT64     11
#define FFI_TYPE_SINT64     12
#define FFI_TYPE_STRUCT     13
#define FFI_TYPE_POINTER    14
#define FFI_TYPE_COMPLEX    15
#define FFI_TYPE_UINT128    16
#define FFI_TYPE_SINT128    17
#define FFI_TYPE_VECTOR     18
#define FFI_TYPE_LAST       FFI_TYPE_VECTOR

#ifndef LIBFFI_ASM

#if defined(_MSC_VER) && !defined(__clang__)
#define __attribute__(X)
#endif

#include <stddef.h>
#include <limits.h>

#define FFI_64_BIT_MAX 9223372036854775807

#ifdef LONG_LONG_MAX
# define FFI_LONG_LONG_MAX LONG_LONG_MAX
#else
# ifdef LLONG_MAX
#  define FFI_LONG_LONG_MAX LLONG_MAX
# endif
#endif

typedef struct _ffi_type
{
  size_t size;
  unsigned short alignment;
  unsigned short type;
  struct _ffi_type **elements;
} ffi_type;

#if defined _MSC_VER && !defined(FFI_STATIC_BUILD)
# if defined FFI_BUILDING_DLL
#  define FFI_API __declspec(dllexport)
# else
#  define FFI_API __declspec(dllimport)
# endif
#else
# define FFI_API
#endif

#if defined LIBFFI_HIDE_BASIC_TYPES
# define FFI_EXTERN FFI_API
#else
# define FFI_EXTERN extern FFI_API
#endif

#ifndef LIBFFI_HIDE_BASIC_TYPES
#if SCHAR_MAX == 127
# define ffi_type_uchar                ffi_type_uint8
# define ffi_type_schar                ffi_type_sint8
#else
 #error "char size not supported"
#endif

#if SHRT_MAX == 32767
# define ffi_type_ushort       ffi_type_uint16
# define ffi_type_sshort       ffi_type_sint16
#elif SHRT_MAX == 2147483647
# define ffi_type_ushort       ffi_type_uint32
# define ffi_type_sshort       ffi_type_sint32
#else
 #error "short size not supported"
#endif

#if INT_MAX == 32767
# define ffi_type_uint         ffi_type_uint16
# define ffi_type_sint         ffi_type_sint16
#elif INT_MAX == 2147483647
# define ffi_type_uint         ffi_type_uint32
# define ffi_type_sint         ffi_type_sint32
#elif INT_MAX == 9223372036854775807
# define ffi_type_uint         ffi_type_uint64
# define ffi_type_sint         ffi_type_sint64
#else
 #error "int size not supported"
#endif

#if LONG_MAX == 2147483647
# if FFI_LONG_LONG_MAX != FFI_64_BIT_MAX
 #error "no 64-bit data type supported"
# endif
#elif LONG_MAX != FFI_64_BIT_MAX
 #error "long size not supported"
#endif

#if LONG_MAX == 2147483647
# define ffi_type_ulong        ffi_type_uint32
# define ffi_type_slong        ffi_type_sint32
#elif LONG_MAX == FFI_64_BIT_MAX
# define ffi_type_ulong        ffi_type_uint64
# define ffi_type_slong        ffi_type_sint64
#else
 #error "long size not supported"
#endif

FFI_EXTERN ffi_type ffi_type_void;
FFI_EXTERN ffi_type ffi_type_uint8;
FFI_EXTERN ffi_type ffi_type_sint8;
FFI_EXTERN ffi_type ffi_type_uint16;
FFI_EXTERN ffi_type ffi_type_sint16;
FFI_EXTERN ffi_type ffi_type_uint32;
FFI_EXTERN ffi_type ffi_type_sint32;
FFI_EXTERN ffi_type ffi_type_uint64;
FFI_EXTERN ffi_type ffi_type_sint64;
FFI_EXTERN ffi_type ffi_type_float;
FFI_EXTERN ffi_type ffi_type_double;
FFI_EXTERN ffi_type ffi_type_pointer;
FFI_EXTERN ffi_type ffi_type_longdouble;

#ifdef FFI_TARGET_HAS_COMPLEX_TYPE
FFI_EXTERN ffi_type ffi_type_complex_float;
FFI_EXTERN ffi_type ffi_type_complex_double;
FFI_EXTERN ffi_type ffi_type_complex_longdouble;
#endif

#ifdef FFI_TARGET_HAS_INT128
FFI_EXTERN ffi_type ffi_type_uint128;
FFI_EXTERN ffi_type ffi_type_sint128;
#endif
#endif /* LIBFFI_HIDE_BASIC_TYPES */

typedef enum {
  FFI_OK = 0,
  FFI_BAD_TYPEDEF,
  FFI_BAD_ABI,
  FFI_BAD_ARGTYPE
} ffi_status;

typedef struct {
  ffi_abi abi;
  unsigned nargs;
  ffi_type **arg_types;
  ffi_type *rtype;
  unsigned bytes;
  unsigned flags;
#ifdef FFI_EXTRA_CIF_FIELDS
  FFI_EXTRA_CIF_FIELDS;
#endif
} ffi_cif;

#ifndef FFI_SIZEOF_ARG
# if LONG_MAX == 2147483647
#  define FFI_SIZEOF_ARG        4
# elif LONG_MAX == FFI_64_BIT_MAX
#  define FFI_SIZEOF_ARG        8
# endif
#endif

#ifndef FFI_SIZEOF_JAVA_RAW
#  define FFI_SIZEOF_JAVA_RAW FFI_SIZEOF_ARG
#endif

typedef union {
  ffi_sarg  sint;
  ffi_arg   uint;
  float     flt;
  char      data[FFI_SIZEOF_ARG];
  void*     ptr;
} ffi_raw;

#if FFI_SIZEOF_JAVA_RAW == 4 && FFI_SIZEOF_ARG == 8
typedef union {
  signed int  sint;
  unsigned int  uint;
  float     flt;
  char      data[FFI_SIZEOF_JAVA_RAW];
  void*     ptr;
} ffi_java_raw;
#else
typedef ffi_raw ffi_java_raw;
#endif

FFI_API
void ffi_raw_call (ffi_cif *cif,
           void (*fn)(void),
           void *rvalue,
           ffi_raw *avalue);

FFI_API void ffi_ptrarray_to_raw (ffi_cif *cif, void **args, ffi_raw *raw);
FFI_API void ffi_raw_to_ptrarray (ffi_cif *cif, ffi_raw *raw, void **args);
FFI_API size_t ffi_raw_size (ffi_cif *cif);

#if !FFI_NATIVE_RAW_API
FFI_API
void ffi_java_raw_call (ffi_cif *cif,
            void (*fn)(void),
            void *rvalue,
            ffi_java_raw *avalue) __attribute__((deprecated));
#endif

FFI_API
void ffi_java_ptrarray_to_raw (ffi_cif *cif, void **args, ffi_java_raw *raw) __attribute__((deprecated));
FFI_API
void ffi_java_raw_to_ptrarray (ffi_cif *cif, ffi_java_raw *raw, void **args) __attribute__((deprecated));
FFI_API
size_t ffi_java_raw_size (ffi_cif *cif) __attribute__((deprecated));

#define FFI_VERSION_STRING "3.8.0"
#define FFI_VERSION_NUMBER 30800

#ifndef LIBFFI_ASM
FFI_API const char *ffi_get_version (void);
FFI_API unsigned long ffi_get_version_number (void);
#endif

FFI_API unsigned int ffi_get_default_abi (void);
FFI_API size_t ffi_get_closure_size (void);

#if FFI_CLOSURES

#ifdef _MSC_VER
__declspec(align(8))
#endif
typedef struct {
#if defined(FFI_EXEC_TRAMPOLINE_TABLE) && FFI_EXEC_TRAMPOLINE_TABLE
  void *trampoline_table;
  void *trampoline_table_entry;
#else
  union {
    char tramp[FFI_TRAMPOLINE_SIZE];
    void *ftramp;
  };
#endif
  ffi_cif   *cif;
  void     (*fun)(ffi_cif*,void*,void**,void*);
  void      *user_data;
#if defined(_MSC_VER) && defined(_M_IX86)
  void      *padding;
#endif
} ffi_closure
#ifdef __GNUC__
    __attribute__((aligned (8)))
#endif
    ;

#ifndef __GNUC__
# ifdef __sgi
#  pragma pack 0
# endif
#endif

FFI_API void *ffi_closure_alloc (size_t size, void **code);
FFI_API void ffi_closure_free (void *);

FFI_API ffi_status
ffi_prep_closure (ffi_closure*,
          ffi_cif *,
          void (*fun)(ffi_cif*,void*,void**,void*),
          void *user_data)
#if defined(__GNUC__) && (((__GNUC__ * 100) + __GNUC_MINOR__) >= 405)
  __attribute__((deprecated ("use ffi_prep_closure_loc instead")))
#elif defined(__GNUC__) && __GNUC__ >= 3
  __attribute__((deprecated))
#endif
  ;

FFI_API ffi_status
ffi_prep_closure_loc (ffi_closure*,
              ffi_cif *,
              void (*fun)(ffi_cif*,void*,void**,void*),
              void *user_data,
              void *codeloc);

#ifdef __sgi
# pragma pack 8
#endif
typedef struct {
#if defined(FFI_EXEC_TRAMPOLINE_TABLE) && FFI_EXEC_TRAMPOLINE_TABLE
  void *trampoline_table;
  void *trampoline_table_entry;
#else
  char tramp[FFI_TRAMPOLINE_SIZE];
#endif
  ffi_cif   *cif;

#if !FFI_NATIVE_RAW_API
  void     (*translate_args)(ffi_cif*,void*,void**,void*);
  void      *this_closure;
#endif
  void     (*fun)(ffi_cif*,void*,ffi_raw*,void*);
  void      *user_data;
} ffi_raw_closure;

typedef struct {
#if defined(FFI_EXEC_TRAMPOLINE_TABLE) && FFI_EXEC_TRAMPOLINE_TABLE
  void *trampoline_table;
  void *trampoline_table_entry;
#else
  char tramp[FFI_TRAMPOLINE_SIZE];
#endif
  ffi_cif   *cif;

#if !FFI_NATIVE_RAW_API
  void     (*translate_args)(ffi_cif*,void*,void**,void*);
  void      *this_closure;
#endif
  void     (*fun)(ffi_cif*,void*,ffi_java_raw*,void*);
  void      *user_data;
} ffi_java_raw_closure;

FFI_API ffi_status
ffi_prep_raw_closure (ffi_raw_closure*,
              ffi_cif *cif,
              void (*fun)(ffi_cif*,void*,ffi_raw*,void*),
              void *user_data);

FFI_API ffi_status
ffi_prep_raw_closure_loc (ffi_raw_closure*,
              ffi_cif *cif,
              void (*fun)(ffi_cif*,void*,ffi_raw*,void*),
              void *user_data,
              void *codeloc);

#if !FFI_NATIVE_RAW_API
FFI_API ffi_status
ffi_prep_java_raw_closure (ffi_java_raw_closure*,
                   ffi_cif *cif,
                   void (*fun)(ffi_cif*,void*,ffi_java_raw*,void*),
                   void *user_data) __attribute__((deprecated));

FFI_API ffi_status
ffi_prep_java_raw_closure_loc (ffi_java_raw_closure*,
                   ffi_cif *cif,
                   void (*fun)(ffi_cif*,void*,ffi_java_raw*,void*),
                   void *user_data,
                   void *codeloc) __attribute__((deprecated));
#endif

#endif /* FFI_CLOSURES */

#ifdef FFI_GO_CLOSURES
typedef struct {
  void      *tramp;
  ffi_cif   *cif;
  void     (*fun)(ffi_cif*,void*,void**,void*);
} ffi_go_closure;

FFI_API ffi_status ffi_prep_go_closure (ffi_go_closure*, ffi_cif *,
                void (*fun)(ffi_cif*,void*,void**,void*));
FFI_API void ffi_call_go (ffi_cif *cif, void (*fn)(void), void *rvalue,
              void **avalue, void *closure);
#endif /* FFI_GO_CLOSURES */

FFI_API
ffi_status ffi_prep_cif(ffi_cif *cif,
            ffi_abi abi,
            unsigned int nargs,
            ffi_type *rtype,
            ffi_type **atypes);

FFI_API
ffi_status ffi_prep_cif_var(ffi_cif *cif,
                ffi_abi abi,
                unsigned int nfixedargs,
                unsigned int ntotalargs,
                ffi_type *rtype,
                ffi_type **atypes);

FFI_API
void ffi_call(ffi_cif *cif,
          void (*fn)(void),
          void *rvalue,
          void **avalue);

/* Reusable call plans.

   A plan captures a signature's argument placement once so that repeated
   calls skip the per-call work that ffi_call would otherwise redo.  Build one
   with ffi_call_plan_alloc, invoke it as many times as you like, and release
   it with ffi_call_plan_free.

   The plan is opaque and caller-owned.  The cif must outlive the plan.
   ffi_call_plan_alloc returns NULL only on allocation failure; a signature
   with no fast path is still valid and ffi_call_plan_invoke falls back to
   ffi_call for it.  A plan is immutable once built, so it may be shared and
   invoked concurrently from multiple threads.

   ffi_call_plan_size reports the total number of bytes libffi allocated for a
   plan, so that callers tracking the footprint of long-lived plans do not have
   to guess at the size of an opaque type.  */
typedef struct ffi_call_plan ffi_call_plan;

FFI_API
ffi_call_plan *ffi_call_plan_alloc (ffi_cif *cif);

FFI_API
void ffi_call_plan_invoke (ffi_call_plan *plan,
			   void (*fn)(void),
			   void *rvalue,
			   void **avalue);

FFI_API
void ffi_call_plan_free (ffi_call_plan *plan);

FFI_API
size_t ffi_call_plan_size (ffi_call_plan *plan);

FFI_API
ffi_status ffi_get_struct_offsets (ffi_abi abi, ffi_type *struct_type,
                   size_t *offsets);

#if defined(PA_LINUX) || defined(PA_HPUX)
#define FFI_FN(f) ((void (*)(void))((unsigned int)(f) | 2))
#define FFI_CL(f) ((void *)((unsigned int)(f) & ~3))
#else
#define FFI_FN(f) ((void (*)(void))f)
#define FFI_CL(f) ((void *)(f))
#endif

#endif /* LIBFFI_ASM */

#ifdef __cplusplus
}
#endif

#endif
