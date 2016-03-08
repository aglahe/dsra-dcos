FROM mesosphere/mesos-slave:0.27.1-2.0.226.ubuntu1404
MAINTAINER Matt Parker <matthew.parker@l-3com.com>

# Setup env
USER root

# Define commonly used JAVA_HOME variable
ENV JAVA_HOME /usr/lib/jvm/java-7-openjdk-amd64

ENV HADOOP_PREFIX /usr/local/hadoop
ENV HADOOP_COMMON_HOME /usr/local/hadoop
ENV HADOOP_HDFS_HOME /usr/local/hadoop
ENV HADOOP_CONF_DIR /usr/local/hadoop/etc/hadoop

# download wget, java & hadoop and spark
RUN  apt-get -y update && \
 apt-get install -y openjdk-7-jdk wget && \
 wget -q -O - http://apache.mirrors.pair.com/hadoop/common/hadoop-2.7.1/hadoop-2.7.1.tar.gz | tar -xzf - -C /usr/local && \
 wget -q -O - http://d3kbcqa49mib13.cloudfront.net/spark-1.6.0-bin-hadoop2.6.tgz | tar -xzf - -C /usr/local && \
 ln -s /usr/local/hadoop-2.7.1 /usr/local/hadoop && \
 ln -s /usr/local/spark-1.6.0-bin-hadoop2.6 /usr/local/spark

# Copy the Site files up
WORKDIR /usr/local/hadoop
COPY core-site.xml.template etc/hadoop/core-site.xml.template
COPY hdfs-site.xml.template etc/hadoop/hdfs-site.xml.template

# Copy the bootstrap shell
COPY bootstrap.sh /bin/bootstrap.sh

# Location to store data
VOLUME ["/tmp/mesos"]

# Entry Point for our
ENV PATH $PATH:/usr/local/hadoop/bin
ENTRYPOINT ["/bin/bootstrap.sh"]
CMD ["mesos-slave"]
