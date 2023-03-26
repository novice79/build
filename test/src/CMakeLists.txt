cmake_minimum_required (VERSION 3.21)
project (main)

set(CMAKE_C_STANDARD 23)
set(CMAKE_CXX_STANDARD 23)
set(CMAKE_FIND_LIBRARY_SUFFIXES ".a")
# set(CMAKE_EXE_LINKER_FLAGS  "${CMAKE_EXE_LINKER_FLAGS} -static -s")
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -pthread -fexceptions -frtti")
file(GLOB_RECURSE SOURCE_FILES main.cpp)
add_library (mylib STATIC lib.cpp)
add_executable (${PROJECT_NAME} ${SOURCE_FILES})

target_link_libraries(${PROJECT_NAME} mylib)
install(TARGETS ${PROJECT_NAME} DESTINATION ".")