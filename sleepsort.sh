#!/bin/bash
function f() {
    x='l("$1")/l(10)' | bc -l
    echo "$x"
    echo "$1"
}
while [ -n "$1" ]
do
    f "$1" &
    shift
done
wait
