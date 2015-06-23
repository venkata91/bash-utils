#!/bin/bash
function f() {
   #http://askubuntu.com/questions/229446/how-to-pass-results-of-bc-to-a-variable
   s=$(bc -l <<< "l($1)/l(10)")
   #echo "Sleeping for $s secs"
   sleep "$s" 
   echo "$1"
}
while [ -n "$1" ]
do
    f "$1" &
    shift
done
wait
