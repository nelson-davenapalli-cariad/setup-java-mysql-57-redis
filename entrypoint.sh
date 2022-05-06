#!/bin/bash

echo ">>> Starting services .... "
root_dir=$(pwd)
/start_services.sh
mysql -u root -h 127.0.0.1 --protocol tcp -e "create user 'test'@'localhost'; create database test; grant ALL PRIVILEGES ON test.* to  'test'@'localhost';"
echo ">>> done "

RETURN_CODE=0
{ # try
    echo "Running command $2 in $1"
    cd $1
    pwd
    whoami
    $2
    echo ">>> Stopping services .... "
    cd $root_dir
    /stop_services.sh
    echo ">>> done "
} || { # catch
    RETURN_CODE=1
}
exit $RETURN_CODE