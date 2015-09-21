#!/usr/bin/env bash

# install the little things
sudo apt-get update
sudo apt-get upgrade -y
sudo apt-get install -y wget
sudo apt-get install -y git

# Install Java
sudo apt-get install -y openjdk-7-jdk
sudo echo "JAVA_HOME=/usr/lib/jvm/java-1.7.0-openjdk-amd64" >> /etc/environment

# Now install golang
sudo wget -q -O - https://storage.googleapis.com/golang/go1.5.1.linux-amd64.tar.gz | tar -xzf - -C /usr/local
sudo echo "export GOROOT=/usr/local/go" >> /etc/profile.d/go.sh
sudo echo "export PATH=\$GOROOT/bin:\$PATH" >> /etc/profile.d/go.sh

# Get Hadoop, and "install" it
sudo wget -q -O - http://apache.mirrors.pair.com/hadoop/common/hadoop-2.7.1/hadoop-2.7.1.tar.gz | tar -xzf - -C /usr/local
sudo /usr/sbin/groupadd -r hadoop
sudo /usr/sbin/useradd -r -g hadoop hadoop
sudo /bin/chown hadoop.hadoop -R /usr/local/hadoop-2.7.1
sudo /bin/ln -s /usr/local/hadoop-2.7.1 /usr/local/hadoop
sudo echo "export HADOOP_HOME=/usr/local/hadoop:\$PATH" >> /etc/profile.d/hdfs.sh
sudo echo "export PATH=\$HADOOP_HOME/bin:\$PATH" >> /etc/profile.d/hdfs.sh

# Get Docker installed
sudo curl -sSL https://get.docker.com/ | sh

# Now get fleetctl and etcdctl and set them up
sudo git clone https://github.com/coreos/fleet.git /usr/local/fleet
sudo git clone https://github.com/coreos/etcd.git /usr/local/etcd
sudo /bin/bash /etc/profile.d/go.sh
sudo env "PATH=$PATH" /usr/local/fleet/build
sudo env "PATH=$PATH" /usr/local/etcd/build
sudo echo "export PATH=/usr/local/etcd/bin:\$PATH" >> /etc/profile.d/etcd.sh
sudo echo "export PATH=/usr/local/fleet/bin:\$PATH" >> /etc/profile.d/fleet.sh

# Get Scala 2.11.7
sudo wget -q -O - http://www.scala-lang.org/files/archive/scala-2.11.7.tgz | tar -xzf - -C /usr/lib
sudo ln -s /usr/lib/scala-2.11.7 /usr/lib/scala
sudo echo "export SCALA_HOME=/usr/lib/scala" >> /etc/profile.d/scala.sh
sudo echo "export PATH=\$SCALA_HOME/bin:\$PATH" >> /etc/profile.d/scala.sh

# Kafka
sudo wget -q -O - https://github.com/apache/kafka/archive/0.8.2.1.tar.gz | tar -xzf - -C /usr/lib
sudo ln -s /usr/lib/kafka-0.8.2.1 /usr/lib/kafka
sudo mkdir -p /var/log/kafka
sudo echo "export PATH=/usr/lib/kafka/bin:\$PATH" >> /etc/profile.d/kafka.sh

# Get MiniConda
sudo wget https://repo.continuum.io/miniconda/Miniconda-latest-Linux-x86_64.sh
sudo /bin/chmod 755 ./Miniconda-latest-Linux-x86_64.sh
sudo ./Miniconda-latest-Linux-x86_64.sh -b -p /usr/local/anaconda
sudo echo "export PATH=/usr/local/anaconda/bin:\$PATH" >> /etc/profile.d/anaconda.sh
sudo /usr/local/anaconda/bin/conda update --yes --all
sudo /usr/local/anaconda/bin/conda install --yes ipython
sudo /usr/local/anaconda/bin/conda install --yes ipython-notebook
