#!/bin/bash

START=$(date +%s) # Sets initial time for time calc

sudo docker stop web
sudo docker rm web
sudo docker rmi websiteoverview

sudo docker stop clouddb
sudo docker rm clouddb
sudo docker rmi clouddb

#sudo docker stop updater
#sudo docker rm updater
#sudo docker rmi updater

# Start time calc
END=$(date +%s)
totalSeconds=$(($END - $START))
printf "\n" # Makes a gap for readability
if (( $totalSeconds > 60 ))
then
  totalMinutes=$(($totalSeconds/60))
  remainderSeconds=$(($totalSeconds - (60*$totalMinutes)))
  if [ $totalMinutes -eq 1 ]
  then
    echo "Script took $totalMinutes minute and $remainderSeconds seconds to complete"
  else
    echo "Script took $totalMinutes minutes and $remainderSeconds seconds to complete"
  fi
else
  echo "Script took $totalSeconds seconds to complete"
fi
# End time calc
