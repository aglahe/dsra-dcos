FROM java:8
MAINTAINER Aaron Glahe <aarongmldt@gmail.com>

# Setup env
USER root
ENV JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk-amd64
ENV SCALA_VERSION 2.11
ENV KAFKA_VERSION 0.9.0.0
ENV KAFKA_HOME /opt/kafka
ENV JMX_PORT 9999

# Install Kafka
RUN apt-get update && \
 apt-get install -y wget && \
 rm -rf /var/lib/apt/lists/* && \
 apt-get clean && \
 wget -q -O - http://apache.mirrors.hoobly.com/kafka/"$KAFKA_VERSION"/kafka_"$SCALA_VERSION"-"$KAFKA_VERSION".tgz | tar -xzf - -C /opt && \
 ln -s /opt/kafka_"$SCALA_VERSION"-"$KAFKA_VERSION" /opt/kafka

#Ports
EXPOSE 9092 ${JMX_PORT}

# Location to store data
VOLUME ["/data/kafka"]

# Copy the bootstrap shell
COPY bootstrap.sh /bin/bootstrap.sh
ENTRYPOINT ["/bin/bootstrap.sh"]
