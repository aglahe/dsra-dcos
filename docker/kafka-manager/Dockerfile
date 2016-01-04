FROM hseeberger/scala-sbt
MAINTAINER Aaron Glahe <aarongmldt@gmail.com>

ENV JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk-amd64 \
    KM_VERSION=1.3.0.4 \
    KM_REVISION=1b45af100ee302dfe53f31a9c7a041999fe3d83a

RUN mkdir -p /tmp && \
    cd /tmp && \
    git clone https://github.com/yahoo/kafka-manager && \
    cd /tmp/kafka-manager && \
    git checkout ${KM_REVISION} && \
    sbt clean dist && \
    unzip  -d / ./target/universal/kafka-manager-${KM_VERSION}.zip && \
    rm -fr /tmp/*

EXPOSE 9000
WORKDIR /kafka-manager-${KM_VERSION}
ENTRYPOINT ["./bin/kafka-manager","-Dconfig.file=conf/application.conf"]
