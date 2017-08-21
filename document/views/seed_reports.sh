#!/usr/bin/env bash

HERE=`cd \`dirname $0\`; pwd`

MYSQL_HOST=${MYSQL_HOST-"127.0.0.2"}
MYSQL_USER=${MYSQL_USER-"killbill"}
MYSQL_PASSWORD=${MYSQL_PASSWORD-"killbill"}
MYSQL_DATABASE=${MYSQL_DATABASE-"killbill"}

ROWS=$HERE/rows
REPORTS=$HERE/reports
SYSTEM=$HERE/system

function install_ddl() {
    local ddl=$1
    mysql -h$MYSQL_HOST -u$MYSQL_USER -p$MYSQL_PASSWORD $MYSQL_DATABASE -e "source $ddl"
}

install_ddl $ROWS/uengine-analytics-reports.sql

# Install the DDL - the calendar table needs to be first
install_ddl $REPORTS/calendar.sql
for r in `find $REPORTS -type f -name '*.sql' -o -name '*.ddl' -maxdepth 2`; do install_ddl $r; done
for r in `find $SYSTEM -type f -name '*.sql' -o -name '*.ddl' -maxdepth 2`; do install_ddl $r; done