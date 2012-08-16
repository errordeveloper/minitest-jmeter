#!/bin/bash
[ -n "$DEBUGME" ] && set -x

p=0
f=0

step="$0"

FAIL_MSG="\033[1;35m ✘ FAIL\033[1;0m"
PASS_MSG="\033[1;32m ✔ PASS\033[1;0m"
EXIT_MSG="\033[1;35m ✟ EXIT\033[1;0m"
NEXT_MSG="\033[1;32m ➟ NEXT\033[1;0m"

function fail {
  printf "$FAIL_MSG ($step): $T!\n"; ((f++)); return 1;
}

function pass {
  printf "$PASS_MSG ($step): $T.\n"; ((p++)); return 0;
}

function next {
  if [ ! $f = 0 ]
  then printf "$EXIT_MSG ($step): [[$f failed, $p passed]] cannot proceed!\n";
    exit 2;
  else printf "$NEXT_MSG ($step): [[$f failed, $p passed]] will proceed.\n";
    step="$1";
  fi
}

this=$1; shift;

T="should have a test to run"
 (test -n "$this") && pass || fail

next "$this"

source $this $*
