#!/bin/sh
# launcher.sh
# navigate to home directory, then to this directory, then execute python script, then back home

LOGFILE=/root/pygate/logs/restart.log

writelog() {
  now=`date`
  echo "$now $*" >> $LOGFILE
}


writelog "Starting"
while true ; do
  #check for network connectivity
  wget -q --tries=10 --timeout=99 --spider http://google.com
  if [ $? -eq 0 ]; then
        cd /root/pygate/pyGate
        # pause a little, if we don't then the zwave stack crashes cause it's started too fast. With the delay, everything is ok.
        sleep 1
        sudo python pyGate.py
        writelog "Exited with status $?"
        writelog "Restarting"
  else
        writelog "No network connection, retrying..."
  fi
done
cd /



