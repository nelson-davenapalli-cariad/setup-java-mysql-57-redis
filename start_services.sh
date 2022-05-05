#!/usr/bin/env bash

# Start mysql
service mysql start

# Start Redis
pushd /opt/${REDIS_ARTIFACT}
./src/redis-server --bind 127.0.0.1 &
REDIS_PID=$!
echo ${REDIS_PID} > /var/run/redis.pid
popd
