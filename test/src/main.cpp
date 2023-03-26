#include "lib.h"

using namespace std;
int main(int argc, char *argv[])
{
    cout<< "你好，世界😄\n";
    cout<< "I am stay at: " << exe_path(argv[0]) << endl;
    return 0;
}