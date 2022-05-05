#!/usr/bin/env bash
set -x

# Shutdown Mysql
service mysql stop

# shutdown Redis
REDIS_PID=$(cat /var/run/redis.pid)
echo "Kill redis with pid: ${REDIS_PID}"
kill ${REDIS_PID}
