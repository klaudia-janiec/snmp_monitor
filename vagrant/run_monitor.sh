#!/usr/bin/env bash

echo -e '### Starting monitoring service'

VAGRANT_HOME=~
SNMP_MONITOR_DIR=$VAGRANT_HOME/snmp_monitor

cd $SNMP_MONITOR_DIR
bundle exec rackup -o 0.0.0.0 -D
