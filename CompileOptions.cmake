# Copyright 2014 (C). Alex Robenko. All rights reserved.

macro (_ext_add_option_suf var_name suffix)
    set (${var_name}${suffix} ${${var_name}${suffix}} ${ARGN})
endmacro ()

macro (_ext_add_option_config var_name config)
    if ("${config}" STREQUAL "")
        _ext_add_option_suf (${var_name} "" ${ARGN})
    elseif ("${config}" STREQUAL "Debug")
        _ext_add_option_suf (${var_name} "_DEBUG" ${ARGN})
    elseif ("${config}" STREQUAL "Release")
        _ext_add_option_suf (${var_name} "_RELEASE" ${ARGN})
    elseif ("${config}" STREQUAL "RelWithDebInfo")
        _ext_add_option_suf (${var_name} "_RELWITHDEBINFO" ${ARGN})
    elseif ("${config}" STREQUAL "MinSizeRel")
        _ext_add_option_suf (${var_name} "_MINSIZEREL" ${ARGN})
    endif ()
endmacro ()

macro (_ext_add_option var_name)
    _ext_add_option_config (${var_name} "" ${ARGN})
endmacro ()

macro (ext_add_cxx_flags)
  _ext_add_option ("CMAKE_CXX_FLAGS" ${ARGN})
endmacro ()

macro (ext_add_c_flags)
     _ext_add_option ("CMAKE_C_FLAGS" ${ARGN})
endmacro ()

macro (ext_add_asm_flags)
     _ext_add_option ("CMAKE_ASM_FLAGS" ${ARGN})
endmacro ()

macro (ext_add_c_cxx_flags)
    ext_add_c_flags (${ARGN})
    ext_add_cxx_flags (${ARGN})
endmacro ()

macro (ext_add_asm_c_cxx_flags)
    ext_add_asm_flags (${ARGN})
    ext_add_c_flags (${ARGN})
    ext_add_cxx_flags (${ARGN})
endmacro ()

macro (ext_add_cpp11_support)
    if (CMAKE_COMPILER_IS_GNUCC)
        ext_add_cxx_flags("--std=c++0x")
    endif ()
endmacro ()

macro (ext_disable_exceptions)
    if (CMAKE_COMPILER_IS_GNUCC)
        ext_add_cxx_flags("-fno-exceptions -fno-unwind-tables")
    endif ()
endmacro ()

macro (ext_disable_rtti)
    if (CMAKE_COMPILER_IS_GNUCC)
        ext_add_cxx_flags("-fno-rtti")
    endif ()
endmacro ()

macro (ext_disable_stdlib)
    add_definitions(-DNOSTDLIB)
    if (CMAKE_COMPILER_IS_GNUCC)
        ext_add_c_cxx_flags("-nostdlib")
    endif ()
endmacro ()

