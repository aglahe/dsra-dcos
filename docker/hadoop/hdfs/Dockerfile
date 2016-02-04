FROM java:8
MAINTAINER Aaron Glahe <aarongmldt@gmail.com>

# Setup env
USER root
ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64

ENV HADOOP_USER hdfs

ENV HADOOP_PREFIX /usr/local/hadoop
ENV HADOOP_COMMON_HOME /usr/local/hadoop
ENV HADOOP_HDFS_HOME /usr/local/hadoop
ENV HADOOP_CONF_DIR /usr/local/hadoop/etc/hadoop

# download hadoop
RUN wget -q -O - http://apache.mirrors.pair.com/hadoop/common/hadoop-2.7.1/hadoop-2.7.1.tar.gz | tar -xzf - -C /usr/local \
 && ln -s /usr/local/hadoop-2.7.1 /usr/local/hadoop \
 && mkdir -p /data/hdfs/nn \
 && mkdir -p /data/hdfs/dn \
 && mkdir -p /data/hdfs/journal \
 && groupadd -r hadoop \
 && groupadd -r $HADOOP_USER && useradd -r -g $HADOOP_USER -G hadoop $HADOOP_USER

# Copy the Site files up
WORKDIR /usr/local/hadoop
COPY core-site.xml.template etc/hadoop/core-site.xml.template
COPY hdfs-site.xml.template etc/hadoop/hdfs-site.xml.template

# Setup permissions and ownership (httpfs tomcat conf for 600 permissions)
RUN chown -R $HADOOP_USER:hadoop /data/hdfs /usr/local/hadoop-2.7.1 && chmod -R 775 $HADOOP_CONF_DIR

#Ports: Namenode                         DataNode                          Journal Node WebHDFS
EXPOSE 8020 8022 50070 50470 50090 50495 1006 1004 50010 50020 50075 50475 8485 8480 14000

# Location to store data
VOLUME ["/data/hdfs/dn", "/data/hdfs/journal", "/data/hdfs/nn"]

# Copy the bootstrap shell
COPY bootstrap.sh /bin/bootstrap.sh

# Entry Point for our
USER $HADOOP_USER
ENTRYPOINT ["/bin/bootstrap.sh"]
CMD ["bash"]
