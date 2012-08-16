JMETER=${JMETER:-`which jmeter`}
T="executable 'jmeter' should be in the path or defined as 'JMETER' environment variable"
  (test -x "`which $JMETER`") && pass || fail

T="argument should be given with the path to a testplan file"
  (test -n "$1") && pass || fail

next "running jmeter with '$1'"

STR='1 - javascript: {"a":1,"b":2}'
T="should ouput \"$STR\" 10 times"
(test `$JMETER -n $JMETER_FLAGS -t $1 | grep "$STR" -c` = 10) && pass || fail
