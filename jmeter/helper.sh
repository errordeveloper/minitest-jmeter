JMETER=${JMETER:-`which jmeter`}
T="executable 'jmeter' should be in the path or defined as 'JMETER' environment variable"
  (test -x "`which $JMETER`") && pass || fail

T="argument should be given with the path to a testplan file"
  (test -n "$1") && pass || fail

for j in $*
do next "running jmeter with '$j'"
  case `basename $j` in
  bsf_basic.jmx)

    STR='1 - javascript: {"a":1,"b":2}'
    T="should ouput \"$STR\" 2 times"
      (test `$JMETER -n $JMETER_FLAGS -t $1 | grep "$STR" -c` = 2) && pass || fail

    STR='^jruby 1.6.7.2'
    T="should output JRuby version string 2 times"
      (test `$JMETER -n $JMETER_FLAGS -t $1 | grep "$STR" -c` = 2) && pass || fail
  ;;
  *)
    T="should write a test for '$j'"
    skip
  ;;
  esac
done
