FROM java:8
MAINTAINER Aaron Glahe <aarongmldt@gmail.com>

# Setup env
USER root
ENV JAVA_HOME /usr/lib/jvm/java-1.8.0-openjdk-amd64
ENV ZK_VERSION 3.4.7

# Download Apache Zookeeper, untar, setup zookeeper user, log/snapshot DIR
RUN wget -q -O - http://apache.mirrors.pair.com/zookeeper/zookeeper-${ZK_VERSION}/zookeeper-${ZK_VERSION}.tar.gz | tar -xzf - -C /opt \
 && ln -s /opt/zookeeper-${ZK_VERSION} /opt/zookeeper \
 && groupadd -r zookeeper && useradd -r -g zookeeper zookeeper \
 && mkdir -p /var/lib/zookeeper

# Configure inital zookeeper settings
WORKDIR /opt/zookeeper
COPY start.sh bin/start.sh
COPY zoo.cfg.template conf/zoo.cfg

# Have zookeeper own everything
RUN chown -R zookeeper:zookeeper /var/lib/zookeeper /opt/zookeeper-${ZK_VERSION}

# Zookeeper client port, peer port, and leader (election) port
EXPOSE 2181 2888 3888

# Save the snapshot/log data outside of Zookepeer
VOLUME ["/var/lib/zookeeper"]

USER zookeeper
ENTRYPOINT ["/opt/zookeeper/bin/start.sh"]
CMD ["/opt/zookeeper/bin/zkServer.sh", "start-foreground"]
