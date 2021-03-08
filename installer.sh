#!/bin/bash

START=$(date +%s) # Sets initial time for time calc

./webInstaller.sh
cd clouddb
./clouddbInstaller.sh
#cd updater
#./updaterInstaller.sh
#cd ..
./networkCreator.sh
cd ..

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
