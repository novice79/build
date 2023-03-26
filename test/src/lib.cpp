


#include "lib.h"

fs::path exe_path(fs::path argv0)
{
    auto path = fs::canonical(fs::path(argv0).remove_filename());
    return fs::absolute(path);
}