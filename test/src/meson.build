project(
    'main', 'cpp', 
    version: 'v1.0.0', 
    default_options : ['c_std=c17', 'cpp_std=c++20']
)


thread_dep = dependency('threads')
lib = static_library('mylib', 'lib.cpp')
executable(
    'main', 
    'main.cpp', 
    link_with : lib,
#    link_args : ['-static', '-s'],
    install : true, install_dir : '.'
)