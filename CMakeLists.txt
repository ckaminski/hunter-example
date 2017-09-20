cmake_minimum_required(VERSION 3.0)

SET( HUNTER_STATUS_DEBUG ON)

include("cmake/HunterGate.cmake")
HunterGate(
    URL "https://github.com/ckaminski/hunter/archive/nghttp2.zip"
    SHA1 "4edf1dc566c6716b465d2fa44e92958ec9bbe3f0" 
    LOCAL   
)

project(Foo)

hunter_add_package(OpenSSL)
find_package(OpenSSL REQUIRED)

hunter_add_package(Boost COMPONENTS system )
find_package(Boost CONFIG REQUIRED system)

hunter_add_package(nghttp2)
find_package(nghttp2 REQUIRED)

add_executable(foo foo.cpp)
target_link_libraries(foo PUBLIC 
                      nghttp2::nghttp2_asio nghttp2::nghttp2
                      Boost::system
                      OpenSSL::SSL
                     )

message(STATUS "Summary of build options: 

    Install prefix:  ${CMAKE_INSTALL_PREFIX}
    Target system:   ${CMAKE_SYSTEM_NAME}
    Compiler:
      Build type:     ${CMAKE_BUILD_TYPE}
      C compiler:     ${CMAKE_C_COMPILER}
      CFLAGS:         ${CMAKE_C_FLAGS_${_build_type}} ${CMAKE_C_FLAGS}
      C++ compiler:   ${CMAKE_CXX_COMPILER}
      CXXFLAGS:       ${CMAKE_CXX_FLAGS_${_build_type}} ${CMAKE_CXX_FLAGS}
      WARNCFLAGS:     ${WARNCFLAGS}
      CXX1XCXXFLAGS:  ${CXX1XCXXFLAGS}
    Libraries:
      OpenSSL Version.: ${OPENSSL_VERSION}
      OpenSSL ........: ${HAVE_OPENSSL} (LIBS='${OPENSSL_LIBRARIES}')
")


#      ngHttp2.............: ${nghttp2::nghttp2} 
#      ngHttp2 Asio........: ${nghttp2::nghttp2_asio} 
#      OpenSSL.............: ${OpenSSL::SSL}
