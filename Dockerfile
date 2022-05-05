FROM ubuntu:18.04

ENV TERM "dumb"

# Copy scripts into path
ADD ./start_services.sh /usr/local/bin
ADD ./stop_services.sh /usr/local/bin
RUN chmod +x -R /usr/local/bin

# Install Java and mysql
RUN apt-get update -q -y && \
    apt-get upgrade -q -y && \
    apt-get install -q -y \
    openjdk-11-jdk

# Install mysql
ENV DEBIAN_FRONTEND "noninteractive"
RUN apt-get install -y -q software-properties-common && \
    add-apt-repository 'deb http://archive.ubuntu.com/ubuntu trusty universe' && \
    apt-get update -q && \
    apt-get install -q -y libmysqld-dev mysql-server-5.7

# configure mysql
RUN service mysql start  && \
    echo "update user set plugin='mysql_native_password' where User='root';" | mysql -uroot mysql && \
    echo "flush privileges;" | mysql -uroot

# Install Redis
ENV REDIS_ARTIFACT "redis-3.2.3"
WORKDIR /opt/
RUN apt-get install -q -y wget build-essential && \
    wget http://download.redis.io/releases/${REDIS_ARTIFACT}.tar.gz && \
    tar xzf ${REDIS_ARTIFACT}.tar.gz && \
    rm ${REDIS_ARTIFACT}.tar.gz

WORKDIR /opt/${REDIS_ARTIFACT}
RUN make
