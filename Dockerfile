FROM debian:wheezy
MAINTAINER cedric.mourizard@gmail.com

# System update
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update -qq 
RUN apt-get dist-upgrade -qqy 
RUN apt-get install -y sudo vim curl gcc openssh-client

# Supervisor Install
RUN apt-get install -y supervisor
RUN mkdir -p /var/log/supervisor
COPY conf/etc/supervisor/supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# PHP & Mongo Install
RUN apt-get -qqy install build-essential
RUN apt-get -qqy install php5-cli php-pear php5-dev
RUN pecl config-set php_ini /etc/php5/cli/php.ini
RUN printf "no\n" | pecl install mongo
COPY conf/etc/php5/mods-available/mongo.ini /etc/php5/mods-available/mongo.ini
RUN php5enmod mongo

# JDK Install
RUN apt-get install -y openjdk-7-jre

# Apache Ant Install
ENV ANT_VERSION 1.9.4
RUN apt-get install -y wget
RUN cd && \
    wget -q http://archive.apache.org/dist/ant/binaries/apache-ant-${ANT_VERSION}-bin.tar.gz && \
    tar -xzf apache-ant-${ANT_VERSION}-bin.tar.gz && \
    mv apache-ant-${ANT_VERSION} /usr/share/java/ant && \
    rm apache-ant-${ANT_VERSION}-bin.tar.gz &&\
    ln -s /usr/share/java/ant/bin/ant /usr/bin/ant
ENV ANT_HOME /usr/share/java/ant
ENV PATH ${PATH}:/opt/ant/bin
RUN /bin/bash -c 'echo -e "export ANT_HOME=/usr/share/java/ant" >> /etc/profile.d/java.sh'
RUN /bin/bash -c 'source /etc/profile.d/java.sh'

# Prepare JMeter environment
RUN mkdir -p /var/jmetersugar
VOLUME /var/jmetersugar

CMD ["/usr/bin/supervisord"]