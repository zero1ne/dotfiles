build() {
  if [[ -z $1 ]]; then
    echo "usage: build [sourcecode]"
  else
    filename=$1
    prefix=$(echo "$1" | awk -F. '{print $1}')
    g++ -std=c++17 $filename -o $prefix.exe
  fi
}

initcc() {
  if [[ -z $1 ]]; then
    echo "usage: init [filename]"
    exit 1
  fi
  filename=$1
  cat <<EoF > $filename
#include <cstdio>
#include <algorithm>
#include <vector>
#include <utility>
using namespace std;

#ifdef DEBUG
#define debug(fmt, args...) fprintf(stderr, "[%s:%d:%s()]: " fmt "\n", \
__FILE__, __LINE__, __func__, ##args)
#else
#define debug(fmt, args...)
#endif

typedef pair<int, int> pii;
typedef long long llint;

int main() {
    return 0;
}
EoF
}

testcc() {
  if [[ -z $1 ]]; then
    echo "usage: build [sourcecode]"
  else
    filename=$1
    debug="-DDEBUG"
    if [[ "$2" = "release" ]]; then
      debug=""
    fi
    prefix=$(echo "$1" | awk -F. '{print $1}')
    rm -f $prefix.out
    rm -f $prefix.log
    g++ -std=c++17 $debug $filename -o $prefix.exe
    ret=$?
    if [[ "$ret" = "0" ]]; then
      ./$prefix.exe < $prefix.in 2> $prefix.log
      echo "Process exited with code $?"
    else
      echo "Build failed with code $ret"
    fi
  fi
}
