#pragma once
#include <iostream>
#include <filesystem>
namespace fs = std::filesystem;
fs::path exe_path(fs::path argv0);