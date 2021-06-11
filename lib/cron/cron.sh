#!/bin/bash
. ~/.bash_profile

PIDFILE=/opt/prodapps/db_job/tmp/data.pid
if [ -e $PIDFILE ]
then
	echo "Schedule is already running wait till it completes... Cannot start another process...." &> /opt/prodapps/db_job/cron.log
else 
	ruby /opt/prodapps/db_job/appmain.rb &> /opt/prodapps/db_job/cron.log
fi

