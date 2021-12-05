#!/bin/bash
assert() {
  expected="$1"
  input="$2"

  ROOT=`git rev-parse --show-toplevel`
  $ROOT/build/linux/x86_64/release/ncc "$input" > tmp.s
  cc -o tmp tmp.s
  ./tmp
  actual="$?"

  if [ "$actual" = "$expected" ]; then
    echo "$input => $actual"
  else
    echo "$input => $expected expected, but got $actual"
    exit 1
  fi
}

xmake -b
assert 0 0
assert 42 42

echo OK
