FROM java:8
MAINTAINER Aaron Glahe <aarongmldt@gmail.com>

# Setup env
USER root
ENV JAVA_HOME /usr/lib/jvm/java-1.8.0-openjdk-amd64
ENV SCALA_VERSION 2.11
ENV KAFKA_VERSION 0.8.2.2
ENV KAFKA_HOME /opt/kafka

# Install Kafka, Zookeeper and other needed things
RUN apt-get update && \
 apt-get install -y wget && \
 rm -rf /var/lib/apt/lists/* && \
 apt-get clean && \
 wget -q -O - http://mirrors.sonic.net/apache/kafka/"$KAFKA_VERSION"/kafka_"$SCALA_VERSION"-"$KAFKA_VERSION".tgz | tar -xzf - -C /opt && \
 ln -s /opt/kafka_"$SCALA_VERSION"-"$KAFKA_VERSION" /opt/kafka

#Ports
EXPOSE 9092

# Location to store data
VOLUME ["/data/kafka"]

# Copy the bootstrap shell
COPY bootstrap.sh /bin/bootstrap.sh
ENTRYPOINT ["/bin/bootstrap.sh"]
