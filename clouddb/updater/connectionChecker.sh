#!/bin/bash
time=$(TZ='America/Chicago' date +"%a %b %d %I:%M:%S %p")
connected=true
while :
do
  curl -s --head http://www.google.com/ | head -n 1 | grep "HTTP/1.[01] [23].." > /dev/null
  if [ $? == 1 ]
  then
    if [ $connected == true ]
    then
      time=$(TZ='America/Chicago' date +"%a %b %d %I:%M:%S %p")
      echo "Lost connection at          $(TZ='America/Chicago' date +"%a %b %d %I:%M:%S %p")" >> connectionChecker.log
      connected=false
      echo "INSERT INTO logs (status,time) VALUES ('Lost connection:','$time')"| mysql -utest -ptest -h 172.18.0.2 clouddb
    fi
  else
    if [ $connected == false ]
    then
      time=$(TZ='America/Chicago' date +"%a %b %d %I:%M:%S %p")
      echo "INSERT INTO logs (status,time) VALUES ('Reconnected:','$time')"| mysql -utest -ptest -h 172.18.0.2 clouddb
      echo "Reestablished connection at $(TZ='America/Chicago' date +"%a %b %d %I:%M:%S %p")" >> connectionChecker.log
      connected=true
    fi
  fi
  #echo $(TZ='America/Chicago' date +"%a %b %d %I:%M:%S %p") >> /src/date.txt
  sleep 10
done
