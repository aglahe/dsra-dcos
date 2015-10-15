FROM mesosphere/mesos-slave:0.25.0-0.2.70.ubuntu1404
MAINTAINER Matt Parker <matthew.parker@l-3com.com>

# Location to store data
VOLUME ["/tmp/mesos"]

# Adds Spark to each Mesos Master
ADD http://apache.arvixe.com/spark/spark-1.5.1/spark-1.5.1-bin-hadoop2.6.tgz /opt/
WORKDIR /opt
RUN tar -xzf spark-1.5.1-bin-hadoop2.6.tgz
