#!/bin/bash

echo "Starting HBASE"
/home/vagrant/start_hbase.sh
echo
if [ $? -ne 0 ]; then
	echo "**ERROR** something went wrong when starting hbase, aborting"
	exit $?
fi

echo "Starting TSDB"
/home/vagrant/start_tsdb.sh
echo
if [ $? -ne 0 ]; then
	echo "**ERROR** something went wrong when starting tsdb, aborting"
	exit $?
fi

echo "Starting TCOLLECTOR"
/home/vagrant/start_tcollector.sh
echo
if [ $? -ne 0 ]; then
	echo "**ERROR** something went wrong when starting tcollector, aborting"
	exit $?
fi