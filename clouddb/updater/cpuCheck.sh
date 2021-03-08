#!/bin/bash

PREV_TOTAL=0
PREV_IDLE=0

while true
do
  # Get the total CPU statistics, discarding the 'cpu ' prefix.
  CPU=(`sed -n 's/^cpu\s//p' /proc/stat`)
  IDLE=${CPU[3]} # Just the idle CPU time.

  # Calculate the total CPU time.
  TOTAL=0
  for VALUE in "${CPU[@]}"; do
    let "TOTAL=$TOTAL+$VALUE"
  done

  # Calculate the CPU usage since we last checked.
  let "DIFF_IDLE=$IDLE-$PREV_IDLE"
  let "DIFF_TOTAL=$TOTAL-$PREV_TOTAL"
  let "DIFF_USAGE=(1000*($DIFF_TOTAL-$DIFF_IDLE)/$DIFF_TOTAL+5)/10"
  #echo -en "\rCPU: $DIFF_USAGE%  \b\b"

  # Sends cpu percentage to mysql database
  time=$(TZ='America/Chicago' date +"%a %b %d %I:%M:%S %p")
  echo "INSERT INTO cpu (perc, time) VALUES ('$DIFF_USAGE','$time')" | mysql -utest -ptest -h 172.18.0.2 clouddb
  echo "DELETE FROM cpu WHERE ID NOT IN ( SELECT ID FROM ( SELECT ID FROM cpu ORDER BY ID DESC LIMIT 50 ) del );" | mysql -utest -ptest -h 172.18.0.2 clouddb

  # Remember the total and idle CPU times for the next check.
  PREV_TOTAL="$TOTAL"
  PREV_IDLE="$IDLE"

  # Wait before checking again.
  sleep 1
done
