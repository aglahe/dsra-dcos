
FROM ingensi/oracle-jdk:latest

LABEL version=6.0.4
LABEL description="Dockerized version of Joshua MT"
LABEL tag="dsra/joshua:6.0.4"

MAINTAINER Matt Parker <matthew.parker@l-3com.com>

RUN yum install --assumeyes make boost boost-devel gcc-c++ zlib-devel nano ant wget tar
RUN mkdir /opt/tmp
ADD http://cs.jhu.edu/~post/files/joshua-v6.0.4.tgz /opt/

WORKDIR /opt

RUN tar -xf joshua-v6.0.4.tgz
ENV JOSHUA=/opt/joshua-v6.0.4

WORKDIR ${JOSHUA}
RUN ant

