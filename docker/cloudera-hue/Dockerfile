FROM jamesdbloom/docker-java8-maven
MAINTAINER Matt Parker <matthew.parker@l3-com.com>
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && apt-get install -q -y build-essential libkrb5-dev libldap2-dev \
libgmp3-dev libmysqlclient-dev libsasl2-dev libsasl2-modules-gssapi-mit \
libsqlite3-dev libssl-dev libtidy-0.99-0 libxml2-dev libxslt-dev mysql-server \
python-dev python-setuptools python-simplejson

RUN ln -s /usr/lib/python2.7/plat-*/_sysconfigdata_nd.py /usr/lib/python2.7/

RUN git clone https://github.com/cloudera/hue.git && groupadd -r hue && useradd -r -g hue hue
WORKDIR hue
RUN git checkout tags/release-3.9.0 && make apps && rm -rf .git
RUN chown -R hue:hue /local/git/hue

EXPOSE 8000
