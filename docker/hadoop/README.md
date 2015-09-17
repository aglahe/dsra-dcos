# Testing on a single host machine, running 3 VMs using Vagrant

Following the docs on https://coreos.com/os/docs/latest/booting-on-vagrant.html
```
git clone https://github.com/coreos/coreos-vagrant.git
cd coreos-vagrant
```

We also want to install the vagrant-hostmanager plugin and use it (this will help manage the HOST IPs to find each other)
```
vagrant plugin install vagrant-hostmanager
```
First, update the Vagrant file (around line 79), add these lines, inside the __$num_instances__ loop:
```
config.hostmanager.enabled = true
config.hostmanager.manage_host = true
config.hostmanager.include_offline = true
```
We use the "alpha" update channel, which is the current default Vagrant uses, but we need more instances.  Change the user-data.sample -> user-data and config.rb.sample -> config.rb.  In the config.rb, change from 1->3
```
$num_instances = 3
```





Then connect to the vagrant guest via, where the X is 1,2 or 3:
```
vagrant ssh core-0X
```

##coreos-01
```
sudo docker run -d --name zk --env ZK_ID=1 --env ZK_SERVERS=core-01:2888:3888 -p 2181:2181 -p 2888:2888 -p 3888:3888 zookeeper
sudo docker create --name jornalnode-data aarongdocker/hdfs /bin/true
sudo docker run -d --name jn --volumes-from jornalnode-data -e NNODE1_IP=core-02 -e NNODE2_IP=rcore-03 -e ZK_IPS=core-01:2181 -e JN_IPS=core-01:8485 -p 8485:8485 -p 8480:8480 aarongdocker/hdfs journalnode
```
###coreos-01 after the NNs have started
```
sudo docker create --name datanode-data aarongdocker/hdfs /bin/true
sudo docker run -it --name dn --volumes-from datanode-data -e NNODE1_IP=core-02 -e NNODE2_IP=core-03 -e ZK_IPS=core-01:2181 -e JN_IPS=core-01:8485 -p 1004:1004 -p 1006:1006 -p 8022:8022 -p 50010:50010 -p 50020:50020 -p 50075:50075 aarongdocker/hdfs datanode
```
####coreos-02
```
sudo docker create --name namenode-data aarongdocker/hdfs /bin/true
sudo docker run -it --name nn --volumes-from namenode-data -e NNODE1_IP=core-02 -e NNODE2_IP=core-03 -e ZK_IPS=core-01:2181 -e JN_IPS=core-01:8485 --net=host aarongdocker/hdfs active
```
####coreos-03
```
sudo docker create --name namenode-data aarongdocker/hdfs /bin/true
sudo docker run -it --name nn --volumes-from namenode-data -e NNODE1_IP=core-02 -e NNODE2_IP=core-03 -e ZK_IPS=core-01:2181 -e JN_IPS=core-01:8485 --net=host aarongdocker/hdfs standby
```
