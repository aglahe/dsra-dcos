#!/usr/bin/env bash

# install the little things
sudo apt-get update
sudo apt-get upgrade -y
sudo apt-get install -y wget

# Install Java
sudo apt-get install -y openjdk-7-jdk
sudo echo "JAVA_HOME=/usr/lib/jvm/java-1.7.0-openjdk-amd64" >> /etc/environment

# Get pip and virtualenv
echo "Install pip, virtualenv, ipython"
sudo wget https://bootstrap.pypa.io/get-pip.py
sudo python get-pip.py
sudo pip install virtualenv
sudo pip install ipython

# Now install golang
echo "Install Go"
sudo wget -q -O - https://storage.googleapis.com/golang/go1.5.3.linux-amd64.tar.gz | tar -xzf - -C //opt
sudo echo "export GOROOT=/opt/go" >> /etc/profile.d/go.sh
sudo echo "export PATH=/opt/go/bin:\$PATH" >> /etc/profile.d/go.sh

# Get Hadoop, and "install" it
echo "Install Hadoop"
sudo wget -q -O - http://apache.mirrors.pair.com/hadoop/common/hadoop-2.7.1/hadoop-2.7.1.tar.gz | tar -xzf - -C /opt
sudo /usr/sbin/groupadd -r hdfs
sudo /usr/sbin/useradd -r -g hdfs hdfs
sudo /usr/sbin/groupadd -r hadoop
sudo /usr/sbin/useradd -r -g hadoop hadoop
sudo /bin/chown hadoop.hadoop -R /opt/hadoop-2.7.1
sudo /bin/ln -s /opt/hadoop-2.7.1 /opt/hadoop
sudo echo "export HADOOP_HOME=/opt/hadoop" >> /etc/profile.d/hdfs.sh
sudo echo "export PATH=/opt/hadoop/bin:\$PATH" >> /etc/profile.d/hdfs.sh

# Get Docker installed
echo "Install Docker"
sudo curl -sSL https://get.docker.com/ | sh

# Now get fleetctl and etcdctl and set them up
echo "Install fleetctl and etcdctl"
sudo apt-get install -y git
sudo git clone https://github.com/coreos/fleet.git /opt/fleet
sudo git clone https://github.com/coreos/etcd.git /opt/etcd
cd /opt/fleet && sudo env "PATH=$PATH:/opt/go/bin" /opt/fleet/build
cd /opt/etcd && sudo env "PATH=$PATH:/opt/go/bin" /opt/etcd/build
sudo echo "export PATH=/opt/etcd/bin:\$PATH" >> /etc/profile.d/etcd.sh
sudo echo "export PATH=/opt/fleet/bin:\$PATH" >> /etc/profile.d/fleet.sh

# Get Scala 2.11.7
# sudo wget -q -O - http://www.scala-lang.org/files/archive/scala-2.11.7.tgz | tar -xzf - -C /usr/lib
# sudo ln -s /usr/lib/scala-2.11.7 /usr/lib/scala
# sudo echo "export SCALA_HOME=/usr/lib/scala" >> /etc/profile.d/scala.sh
# sudo echo "export PATH=\$SCALA_HOME/bin:\$PATH" >> /etc/profile.d/scala.sh

# Spark 1.6
echo "Install Spark 1.6"
sudo wget -q -O - http://d3kbcqa49mib13.cloudfront.net/spark-1.6.0-bin-hadoop2.6.tgz | tar -xzf - -C /opt
sudo ln -s /opt/spark-1.6.0-bin-hadoop2.6 /opt/spark
sudo echo "export PATH=/opt/spark/bin:\$PATH" >> /etc/profile.d/spark.sh

# Get MESOS libs installed
 echo "Install Mesos Libs"
 sudo apt-key adv --keyserver keyserver.ubuntu.com --recv E56151BF
 echo "deb http://repos.mesosphere.com/ubuntu trusty main" | sudo tee /etc/apt/sources.list.d/mesosphere.list
 sudo apt-get -y install mesos

# Kafka
echo "Install Kafka"
sudo wget -q -O - http://apache.arvixe.com/kafka/0.9.0.0/kafka_2.11-0.9.0.0.tgz | tar -xzf - -C /opt
sudo ln -s /opt/kafka_2.11-0.9.0.0 /opt/kafka
sudo mkdir -p /var/log/kafka
sudo echo "export PATH=/opt/kafka/bin:\$PATH" >> /etc/profile.d/kafka.sh

#Mongodb-org
echo "Install Mongodb"
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 7F0CEB10
echo "deb http://repo.mongodb.org/apt/ubuntu trusty/mongodb-org/3.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-3.0.list
sudo apt-get update
sudo apt-get install -y mongodb-org
