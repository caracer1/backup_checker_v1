#!/bin/bash

#Self Obtaining Script Path for Directory
    SCRIPTPATH="$( cd "$(dirname "$0")" ; pwd -P )"

    scriptfilename=$(basename -- "$0")
#Showing All Path Names and file names:
echo -n "Script name: $scriptfilename"
echo
echo
echo -n "Directory address: $SCRIPTPATH"
echo
echo

lastbackupstatus=$(/usr/bin/log show --style syslog --info --last 1d --predicate 'processImagePath contains "backupd" and subsystem beginswith "com.apple.TimeMachine"' | sed 's/..*o]//' | grep "Backup completed successfully" | tail -1)


SEPType="$(/usr/sbin/system_profiler SPiBridgeDataType | /usr/bin/awk -F: '/Model Name/ { gsub(/.*: /,""); print $0}')"







if [ -z "$lastbackupstatus" ]
then
   echo -n "There is no successful backup found in the last 24 hours"
   echo
   echo -n "Last Backup: "
   tmutil latestbackup | rev | cut -d "/" -f 1 | rev
   echo -n "Destination: "
   tmutil destinationinfo | grep "Name" | awk -F ": " '{print $2}'
   echo

   
      exit 0
      break
   
else

echo -n "$lastbackupstatus"
echo -n "Last Backup: "
tmutil latestbackup | rev | cut -d "/" -f 1 | rev
echo -n "Destination: "
tmutil destinationinfo | grep "Name" | awk -F ": " '{print $2}'

fi
