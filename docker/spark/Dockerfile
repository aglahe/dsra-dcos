FROM mesosphere/mesos:0.23.0-1.0.ubuntu1404

# airdock/oracle-jdk:1.7

MAINTAINER Matt Parker <matthew.parker@l-3com.com>

# LABEL mesos.version="0.23.0"
# LABEL docker.version="1.5"
# LABEL hadoop.version="2.6"
# LABEL description="Spark 1.5 Hadoop 2.6 Docker image for use with DSRA MESOS Cluster" 

# ADD http://apache.arvixe.com/spark/spark-1.5.0/spark-1.5.0-bin-hadoop2.6.tgz /opt

ADD spark-1.5.0-bin-hadoop2.6.tgz /opt
RUN ln -s /opt/spark-1.5.0-bin-hadoop2.6 /opt/spark

ENV SPARK_HOME /opt/spark
ENV PATH $SPARK_HOME/bin:$JAVA_HOME/bin:$PATH

COPY spark-env.sh /opt/spark-1.5.0-bin-hadoop2.6/conf/
RUN chmod 755 /opt/spark-1.5.0-bin-hadoop2.6/conf/spark-env.sh

EXPOSE 4040 

RUN echo $PATH




