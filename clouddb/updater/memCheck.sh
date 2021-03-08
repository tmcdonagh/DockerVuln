#!/bin/bash

while :
do
  memFree=$(cat /proc/meminfo | grep "MemFree" | awk -F: '{ print $2 }')
  memAvailable=$(cat /proc/meminfo | grep "MemAvailable" | awk -F: '{ print $2 }')
  memTotal=$(cat /proc/meminfo | grep "MemTotal" | awk -F: '{ print $2 }')
  time=$(TZ='America/Chicago' date +"%a %b %d %I:%M:%S %p")
  uptime=$(uptime -p | awk '{print $2,$3,$4,$5,$6,$7,$8,$9}')


  # Sends data to mysql db
  echo "INSERT INTO mem (free, available, total, time) VALUES ('$memFree','$memAvailable','$memTotal','$time')" | mysql -utest -ptest -h 172.18.0.2 clouddb
  echo "INSERT INTO uptime (uptime, dateStamp) VALUES ('$uptime','$time')" | mysql -utest -ptest -h 172.18.0.2 clouddb
  
  # Deletes all but the newest 50 entries
  echo "DELETE FROM mem WHERE ID NOT IN ( SELECT ID FROM ( SELECT ID FROM mem ORDER BY ID DESC LIMIT 50 ) del );" | mysql -utest -ptest -h 172.18.0.2 clouddb
  echo "DELETE FROM uptime WHERE ID NOT IN ( SELECT ID FROM ( SELECT ID FROM uptime ORDER BY ID DESC LIMIT 1 ) del );" | mysql -utest -ptest -h 172.18.0.2 clouddb

  # Waits a second to check again
  sleep 1

done
