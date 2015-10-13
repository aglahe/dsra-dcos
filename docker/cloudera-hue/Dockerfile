
FROM jamesdbloom/docker-java8-maven

MAINTAINER Matt Parker <matthew.parker@l3-com.com>

RUN apt-get update
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get install -q -y build-essential
RUN apt-get install -q -y libkrb5-dev
RUN apt-get install -q -y libldap2-dev
RUN apt-get install -q -y libgmp3-dev
RUN apt-get install -q -y libmysqlclient-dev
RUN apt-get install -q -y libsasl2-dev
RUN apt-get install -q -y libsasl2-modules-gssapi-mit
RUN apt-get install -q -y libsqlite3-dev
RUN apt-get install -q -y libssl-dev
RUN apt-get install -q -y libtidy-0.99-0
RUN apt-get install -q -y libxml2-dev
RUN apt-get install -q -y libxslt-dev
RUN apt-get install -q -y mysql-server
RUN apt-get install -q -y python-dev
RUN apt-get install -q -y python-setuptools
RUN apt-get install -q -y python-simplejson
RUN ln -s /usr/lib/python2.7/plat-*/_sysconfigdata_nd.py /usr/lib/python2.7/

RUN git clone https://github.com/cloudera/hue.git
WORKDIR hue
RUN git checkout tags/release-3.9.0

RUN make apps

RUN rm -rf .git

EXPOSE 8000

CMD ["build/env/bin/hue","runserver","0.0.0.0:8000"]
