#!/bin/sh

get_jstack()
{
 pid=$1
 periodicity=$2
 location=$3
 samples=$4

 echo "Get Jstack O/P of $pid pid for every $periodicity secs of $samples samples and write O/P under $location "
 newlocation="$location/$pid"
 echo "Creating new $pid dir under $location to store Jstack output"
 mkdir -p "$newlocation"

 i=1
 while [ "$i" -le "$samples" ]; do
   echo "Getting jstack output of $pid for the $i time"
   jstack "$pid" > "$newlocation/$pid-$i.txt"
   echo "Sleeping for $periodicity" secs
   sleep "$periodicity"
   i=$((i+1))
 done
}

get_jstack "$1" "$2" "$3" "$4"
