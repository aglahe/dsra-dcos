FROM hseeberger/scala-sbt
MAINTAINER Aaron Glahe <aarongmldt@gmail.com>

ENV JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk-amd64 \
    KM_VERSION=1.2.9.10 \
    KM_REVISION=14c810dc1066202351142d00fe7c09d2f624a3ad

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
