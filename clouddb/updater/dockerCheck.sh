#!/bin/bash
ip="10.0.0.63"
while :
do
  clouddbStatus="Online" # Both clouddb and web have to be working 
  webStatus="Online" # for this screen to show anyway
  plexStatus="Offline"
  nextcloudStatus="Offline"
  grafanaStatus="Offline"
  nc -z -w1 $ip 32400
  if [ $? ==  0 ]
  then
    plexStatus="Online"
  fi
  nc -z -w1 $ip 220
  if [ $? ==  0 ]
  then
    nextcloudStatus="Online"
  fi
  nc -z -w1 $ip 3000
  if [ $? ==  0 ]
  then
    grafanaStatus="Online"
  fi
  time=$(TZ='America/Chicago' date +"%a %b %d %I:%M:%S %p")
  echo "INSERT INTO containers (plexStatus, nextcloudStatus, grafanaStatus, time) VALUES ('$plexStatus','$nextcloudStatus','$grafanaStatus','$time')" | mysql -utest -ptest -h 172.18.0.2 clouddb
  echo "DELETE FROM containers WHERE ID NOT IN ( SELECT ID FROM ( SELECT ID FROM containers ORDER BY ID DESC LIMIT 50 ) del );" | mysql -utest -ptest -h 172.18.0.2 clouddb
  #printf "\n_________________\nweb: $webStatus\nclouddb: $clouddbStatus\nPlex: $plexStatus\nNextCloud: $nextcloudStatus\nGrafana: $grafanaStatus"
  sleep 1

done
