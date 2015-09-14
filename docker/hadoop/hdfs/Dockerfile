FROM java:7
MAINTAINER Aaron Glahe <aaron.glahe@gmail.com>

# Setup env
USER root
ENV JAVA_HOME /usr/lib/jvm/java-1.7.0-openjdk-amd64

ENV HADOOP_PREFIX /usr/local/hadoop
ENV HADOOP_COMMON_HOME /usr/local/hadoop
ENV HADOOP_HDFS_HOME /usr/local/hadoop
ENV HADOOP_CONF_DIR /usr/local/hadoop/etc/hadoop

# download hadoop
RUN wget -q -O - http://apache.mirrors.pair.com/hadoop/common/hadoop-2.7.1/hadoop-2.7.1.tar.gz | tar -xzf - -C /usr/local \
 && ln -s /usr/local/hadoop-2.7.1 /usr/local/hadoop \
 && groupadd -r hdfs && useradd -r -g hdfs hdfs \
 && mkdir -p /data/hdfs/nn \
 && mkdir -p /data/hdfs/dn \
 && mkdir -p /data/hdfs/journal

# Copy the Site files up
WORKDIR /usr/local/hadoop
COPY core-site.xml.template etc/hadoop/core-site.xml.template
COPY hdfs-site.xml.template etc/hadoop/hdfs-site.xml.template

# Copy the bootstrap shell
COPY bootstrap.sh /bin/bootstrap.sh

# Have HDFS own everything
RUN chown -R hdfs:hdfs /data/hdfs /usr/local/hadoop-2.7.1

#Ports: Namenode                         DataNode                          Journal Node
EXPOSE 8020 8022 50070 50470 50090 50495 1006 1004 50010 50020 50075 50475 8485 8480

# Location to store data
VOLUME ["/data/hdfs/dn", "/data/hdfs/journal", "/data/hdfs/nn"]

# Entry Point for our
USER hdfs
ENTRYPOINT ["/bin/bootstrap.sh"]
CMD ["bash"]
