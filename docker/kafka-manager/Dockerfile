FROM hseeberger/scala-sbt
MAINTAINER Aaron Glahe <aarongmldt@gmail.com>

ENV JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk-amd64 \
    KM_VERSION=1.3.0.7 \
    KM_REVISION=4b57fc9b65e6f9ac88fff4391994fd06bb782663

RUN mkdir -p /tmp && \
    cd /tmp && \
    git clone https://github.com/yahoo/kafka-manager && \
    cd /tmp/kafka-manager && \
    git checkout ${KM_REVISION}

WORKDIR /tmp/kafka-manager
RUN /bin/echo 'scalacOptions ++= Seq("-Xmax-classfile-name", "200")' >> build.sbt
RUN sbt clean dist && \
    unzip  -d / ./target/universal/kafka-manager-${KM_VERSION}.zip && \
    rm -fr /tmp/*

EXPOSE 9000
WORKDIR /kafka-manager-${KM_VERSION}
ENTRYPOINT ["./bin/kafka-manager","-Dconfig.file=conf/application.conf"]
