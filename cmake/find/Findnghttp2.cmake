if (HUNTER_STATUS_DEBUG)
  message("[hunter] Custom Findnghttp2 module")
endif()


message("ROOT is: ${NGHTTP2_ROOT}")

# TODO: Support passing build-shared-libs in default.cmake
#if (NOT BUILD_SHARED_LIBS EQUAL ON)
#  message(FATAL_ERROR, "[hunter] nghttp2 does not support building static libraries at this time. ")
#endif()


find_path(NGHTTP2_INCLUDE_DIR
  NAMES
    include/nghttp2/nghttp2.h
    include/nghttp2/asio_http2.h
  HINTS
    "${NGHTTP2_ROOT}"
  PATH_SUFFIXES
    include
)


if(WIN32 AND NOT CYGWIN)
  if(MSVC)
  elseif(MINGW)
  else()
  endif()
else()
  find_library(NGHTTP2_LIBRARY 
     NAMES
        nghttp2
        nghttp2d
     PATH_SUFFIXES
        lib
  ) 
  find_library(NGHTTP2_ASIO_LIBRARY 
     NAMES
        nghttp2_asio
        nghttp2_asiod
     PATH_SUFFIXES
        lib
  )

  mark_as_advanced(NGHTTP2_LIBRARY NGHTTP2_ASIO_LIBRARY)
 
  set(NGHTTP2_LIBRARIES ${NGHTTP2_LIBRARY} ${NGHTTP2_ASIO_LIBRARY})

endif()

mark_as_advanced(NGHTTP2_CLUDE_DIR OPENSSL_LIBRARIES)

# IF FOUND 
###  if(NOT TARGET OpenSSL::SSL AND
###      (EXISTS "${OPENSSL_SSL_LIBRARY}" OR
###        EXISTS "${SSL_EAY_LIBRARY_DEBUG}" OR
###        EXISTS "${SSL_EAY_LIBRARY_RELEASE}")
###      )

add_library(nghttp2::nghttp2 UNKNOWN IMPORTED) 
set_target_properties(nghttp2::nghttp2 PROPERTIES INTERFACE_INCLUDE_DIRECTORIES "${NGHTTP2_INCLUDE_DIR}")
add_library(nghttp2::nghttp2_asio UNKNOWN IMPORTED) 
set_target_properties(nghttp2::nghttp2_asio PROPERTIES INTERFACE_INCLUDE_DIRECTORIES "${NGHTTP2_INCLUDE_DIR}")

if ( EXISTS "${NGHTTP2_LIBRARY}" ) 
    set_target_properties(nghttp2::nghttp2 PROPERTIES 
        #IMPORTED_LINK_INTERFACE_LANGUAGES "C"  #Static Linkage only  "C" or "CXX" 
        IMPORTED_LOCATION "${NGHTTP2_LIBRARY}"
    )
endif()
if ( EXISTS "${NGHTTP2_ASIO_LIBRARY}" ) 
    set_target_properties(nghttp2::nghttp2_asio PROPERTIES 
        #IMPORTED_LINK_INTERFACE_LANGUAGES "C"  #Static Linkage only  "C" or "CXX" 
        IMPORTED_LOCATION "${NGHTTP2_ASIO_LIBRARY}"
    )
endif()

message("ngHTTP2 includes:  ${NGHTTP2_INCLUDE_DIR}")
message("ngHTTP2      :  ${NGHTTP2_LIBRARY}")
message("ngHTTP2 ASIO :  ${NGHTTP2_ASIO_LIBRARY}")
