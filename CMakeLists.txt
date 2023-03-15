cmake_minimum_required(VERSION 3.16)
project(player)

set(CMAKE_CXX_STANDARD 14)

# set out direcroty
set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/lib)
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/lib)
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/bin)

# set(FFMPEG_ROOT_DIR ${CMAKE_CURRENT_SOURCE_DIR}/workspace) 
set(FFMPEG_ROOT_DIR /Users/ovidiu.dragoi/my/ffmpeg-build-script/workspace) 

if (NOT "${FFMPEG_ROOT_DIR}" STREQUAL "")
  list(APPEND CMAKE_PREFIX_PATH ${FFMPEG_ROOT_DIR})
endif()

# set ffmpeg develop environment


find_package(SDL2 REQUIRED)
include_directories(player ${SDL2_INCLUDE_DIRS})
include_directories(${CMAKE_SOURCE_DIR}/src)
include_directories(${FFMPEG_ROOT_DIR}/include)

file(GLOB_RECURSE INCLUDES "src/*.h")
file(GLOB_RECURSE SOURCES "src/*.cpp")

find_package(PkgConfig REQUIRED)
pkg_check_modules(AVCODEC		REQUIRED IMPORTED_TARGET libavcodec)
pkg_check_modules(AVFORMAT		REQUIRED IMPORTED_TARGET libavformat)
pkg_check_modules(AVFILTER		REQUIRED IMPORTED_TARGET libavfilter)
pkg_check_modules(AVDEVICE		REQUIRED IMPORTED_TARGET libavdevice)
pkg_check_modules(AVUTIL		REQUIRED IMPORTED_TARGET libavutil)
pkg_check_modules(SWRESAMPLE		REQUIRED IMPORTED_TARGET libswresample)
pkg_check_modules(SWSCALE		REQUIRED IMPORTED_TARGET libswscale)

add_executable(player src/main.cpp ${SOURCES} ${INCLUDES})

target_link_libraries (player ${SDL2_LIBRARIES}  
 PkgConfig::AVCODEC
PkgConfig::AVFORMAT
PkgConfig::AVFILTER
PkgConfig::AVDEVICE
PkgConfig::AVUTIL
PkgConfig::SWRESAMPLE
PkgConfig::SWSCALE)