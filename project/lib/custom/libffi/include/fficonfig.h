/* fficonfig.h.
   Platform-specific defines detected at compile time. */

#ifndef FFI_CONFIG_H
#define FFI_CONFIG_H

#define EH_FRAME_FLAGS "a"

/* Use mmap for executable memory (closures) */
#if defined(_WIN32)
#  define HAVE_MMAP 1
#  define HAVE_MMAP_ANON 1
   /* Windows: VirtualAlloc is used instead */
#  undef HAVE_MMAP_DEV_ZERO
#  undef HAVE_MMAP_FILE
#else
#  define HAVE_MMAP 1
#  define HAVE_MMAP_ANON 1
#  define HAVE_MMAP_DEV_ZERO 1
#  define HAVE_MMAP_FILE 1
#endif

#define HAVE_MEMCPY 1
#define HAVE_MKOSTEMP 1
#define STDC_HEADERS 1

#if defined(_WIN64)
#  define SIZEOF_DOUBLE 8
#  define SIZEOF_LONG_DOUBLE 8
#  define SIZEOF_SIZE_T 8
#  define HAVE_LONG_DOUBLE 1
#elif defined(_WIN32)
#  define SIZEOF_DOUBLE 8
#  define SIZEOF_LONG_DOUBLE 8
#  define SIZEOF_SIZE_T 4
#  define HAVE_LONG_DOUBLE 1
#elif defined(__LP64__) || defined(__LP64)
#  define SIZEOF_DOUBLE 8
#  define SIZEOF_LONG_DOUBLE 8
#  define SIZEOF_SIZE_T 8
#  define HAVE_LONG_DOUBLE 1
#else
#  define SIZEOF_DOUBLE 8
#  define SIZEOF_LONG_DOUBLE 8
#  define SIZEOF_SIZE_T 4
#  define HAVE_LONG_DOUBLE 1
#endif

#if defined(__GNUC__) || defined(__clang__)
#  define HAVE_AS_CFI_PSEUDO_OP 1
#  if !defined(_WIN32)
#    define HAVE_HIDDEN_VISIBILITY_ATTRIBUTE 1
#  endif
#  define HAVE_RO_EH_FRAME 1
#endif

#define HAVE_ALLOCA 1
#if !defined(_WIN32) || defined(__MINGW32__)
#  if !defined(__clang__)
#     define HAVE_ALLOCA_H 1
#  endif
#  define HAVE_DLFCN_H 1
#  define HAVE_INTTYPES_H 1
#  define HAVE_MEMORY_H 1
#  define HAVE_STDINT_H 1
#  define HAVE_STRINGS_H 1
#  define HAVE_STRING_H 1
#  define HAVE_SYS_MMAN_H 1
#  define HAVE_SYS_STAT_H 1
#  define HAVE_SYS_TYPES_H 1
#  define HAVE_UNISTD_H 1
#endif

#if defined(HAVE_HIDDEN_VISIBILITY_ATTRIBUTE)
#  ifdef LIBFFI_ASM
#    ifdef __APPLE__
#      define FFI_HIDDEN(name) .private_extern name
#    else
#      define FFI_HIDDEN(name) .hidden name
#    endif
#  else
#    define FFI_HIDDEN __attribute__ ((visibility ("hidden")))
#  endif
#else
#  ifdef LIBFFI_ASM
#    define FFI_HIDDEN(name)
#  else
#    define FFI_HIDDEN
#  endif
#endif

#endif /* FFI_CONFIG_H */
