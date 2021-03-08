#!/bin/bash
sleep 10
while :
do
  mysqladmin -utest -ptest -h 172.18.0.2 processlist
  if [ $? -eq 0 ]
  then
    # Exists
    /src/connectionChecker.sh &
    /src/memCheck.sh &
    /src/cpuCheck.sh &
    /src/dockerCheck.sh &
    break
  fi
  sleep 1
done

while : 
do
  sleep 10
done
# cat /proc/meminfo
