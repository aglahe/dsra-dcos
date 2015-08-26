FROM java:7
MAINTAINER Aaron Glahe <aaron.glahe@gmail.com>

# Setup env
USER root
ENV JAVA_HOME /usr/lib/jvm/java-1.7.0-openjdk-amd64

# Download Apache Zookeeper, untar, setup zookeeper user, log/snapshot DIR
RUN wget -q -O - http://apache.mirrors.pair.com/zookeeper/zookeeper-3.4.6/zookeeper-3.4.6.tar.gz | tar -xzf - -C /usr/local \
 && ln -s /usr/local/zookeeper-3.4.6 /usr/local/zookeeper \
 && groupadd -r zookeeper && useradd -r -g zookeeper zookeeper \
 && mkdir -p /var/lib/zookeeper

 # Configure inital zookeeper settings
 WORKDIR /usr/local/zookeeper
 COPY start.sh bin/start.sh

# Have zookeeper own everything
RUN chown -R zookeeper:zookeeper /var/lib/zookeeper /usr/local/zookeeper-3.4.6

# Zookeeper client port
EXPOSE 2181
# Zookeeper peer port
EXPOSE 2888
# Zookeeper leader (election) port
EXPOSE 3888

USER zookeeper
ENTRYPOINT ["/usr/local/zookeeper/bin/start.sh"]
