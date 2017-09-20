cmake_minimum_required(VERSION 3.0)

SET( HUNTER_STATUS_DEBUG ON)
set (CMAKE_CXX_STANDARD 11)

include("cmake/HunterGate.cmake")
HunterGate(
    URL "https://github.com/ckaminski/hunter/archive/nghttp2.zip"
    SHA1 "c4a9619bc461659ed3db645a14f0541ebaa8963a" 
    LOCAL   
)

project(Foo)

hunter_add_package(Boost COMPONENTS regex system filesystem)
find_package(Boost CONFIG REQUIRED regex system filesystem)

hunter_add_package(nghttp2)
find_package(nghttp2)

hunter_add_package(OpenSSL)
find_package(OpenSSL)


message("CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH}")

add_executable(foo foo.cpp)
target_link_libraries(foo PUBLIC Boost::regex Boost::system Boost::filesystem 
                                 nghttp2::nghttp2_asio nghttp2::nghttp2
                                 OpenSSL::SSL
                     )


