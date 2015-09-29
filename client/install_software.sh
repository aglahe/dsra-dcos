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
sudo wget -q -O - https://storage.googleapis.com/golang/go1.5.1.linux-amd64.tar.gz | tar -xzf - -C /usr/local
sudo echo "export GOROOT=/usr/local/go" >> /etc/profile.d/go.sh
sudo echo "export PATH=/usr/local/go/bin:\$PATH" >> /etc/profile.d/go.sh

# Get Hadoop, and "install" it
echo "Install Hadoop"
sudo wget -q -O - http://apache.mirrors.pair.com/hadoop/common/hadoop-2.7.1/hadoop-2.7.1.tar.gz | tar -xzf - -C /usr/local
sudo /usr/sbin/groupadd -r hadoop
sudo /usr/sbin/useradd -r -g hadoop hadoop
sudo /bin/chown hadoop.hadoop -R /usr/local/hadoop-2.7.1
sudo /bin/ln -s /usr/local/hadoop-2.7.1 /usr/local/hadoop
sudo echo "export HADOOP_HOME=/usr/local/hadoop" >> /etc/profile.d/hdfs.sh
sudo echo "export PATH=/usr/local/hadoop/bin:\$PATH" >> /etc/profile.d/hdfs.sh

# Get Docker installed
echo "Install Docker"
sudo curl -sSL https://get.docker.com/ | sh

# Now get fleetctl and etcdctl and set them up
echo "Install fleetctl and etcdctl"
sudo apt-get install -y git
sudo git clone https://github.com/coreos/fleet.git /usr/local/fleet
sudo git clone https://github.com/coreos/etcd.git /usr/local/etcd
cd /usr/local/fleet && sudo env "PATH=$PATH:/usr/local/go/bin" /usr/local/fleet/build
cd /usr/local/etcd && sudo env "PATH=$PATH:/usr/local/go/bin" /usr/local/etcd/build
sudo echo "export PATH=/usr/local/etcd/bin:\$PATH" >> /etc/profile.d/etcd.sh
sudo echo "export PATH=/usr/local/fleet/bin:\$PATH" >> /etc/profile.d/fleet.sh

# Get Scala 2.11.7
# sudo wget -q -O - http://www.scala-lang.org/files/archive/scala-2.11.7.tgz | tar -xzf - -C /usr/lib
# sudo ln -s /usr/lib/scala-2.11.7 /usr/lib/scala
# sudo echo "export SCALA_HOME=/usr/lib/scala" >> /etc/profile.d/scala.sh
# sudo echo "export PATH=\$SCALA_HOME/bin:\$PATH" >> /etc/profile.d/scala.sh

# Spark 1.5
echo "Install Spark 1.5"
sudo wget -q -O - http://d3kbcqa49mib13.cloudfront.net/spark-1.5.0-bin-hadoop2.6.tgz | tar -xzf - -C /usr/lib
sudo ln -s /usr/lib/spark-1.5.0-bin-hadoop2.6 /usr/lib/spark
sudo echo "export PATH=/usr/lib/sparl/bin:\$PATH" >> /etc/profile.d/spark.sh

# Get MESOS libs installed
# echo "Install Mesos Libs"
# sudo apt-key adv --keyserver keyserver.ubuntu.com --recv E56151BF
# echo "deb http://repos.mesosphere.com/ubuntu trusty main" | sudo tee /etc/apt/sources.list.d/mesosphere.list
# sudo apt-get -y update
# sudo apt-get -y install mesos
# sudo pip install mesos.cli

# Kafka
echo "Install Kafka"
sudo wget -q -O - https://github.com/apache/kafka/archive/0.8.2.1.tar.gz | tar -xzf - -C /usr/lib
sudo ln -s /usr/lib/kafka-0.8.2.1 /usr/lib/kafka
sudo mkdir -p /var/log/kafka
sudo echo "export PATH=/usr/lib/kafka/bin:\$PATH" >> /etc/profile.d/kafka.sh
