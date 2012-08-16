#!/bin/bash
[ -n "$DEBUGME" ] && set -x

p=0
f=0
s=0

step="$0"

FAIL_MSG="\033[1;35m  ✘ FAIL\033[1;0m"
PASS_MSG="\033[1;32m  ✔ PASS\033[1;0m"
SKIP_MSG="\033[1;34m  ❉ SKIP\033[1;0m"
EXIT_MSG="\033[1;35m  ✟ EXIT\033[1;0m"
NEXT_MSG="\033[1;32m  ➟ NEXT\033[1;0m"
DONE_MSG="\033[1;30m %s DONE\033[1;0m"

function fail {
  printf "$FAIL_MSG ($step): $T!\n"; ((f++)); return 1;
}

function pass {
  printf "$PASS_MSG ($step): $T.\n"; ((p++)); return 0;
}

function skip {
  printf "$SKIP_MSG ($step): $T!\n"; ((s++)); return 0;
}

function next {
  if [ ! $f = 0 ]
  then printf "$EXIT_MSG ($step): [[$f failed, $p passed, $s skipped]] cannot proceed!\n";
    exit 2;
  else printf "$NEXT_MSG ($step): [[$f failed, $p passed, $s skipped]] will proceed.\n";
    step="$1";
  fi
}

this=$1; shift;

T="should have a test to run"
 (test -n "$this") && pass || fail

next "$this"

source $this $*

if [ ! $f = 0 ]
then DONE_WTH=" ✘"
else DONE_WTH=" ✔"
fi
printf "$DONE_MSG ➠ [[$f failed, $p passed, $s skipped]]\n" "$DONE_WTH"
