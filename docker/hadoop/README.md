# Testing on a single host machine, running 3 VMs using Vagrant

Following the docs on https://coreos.com/os/docs/latest/booting-on-vagrant.html
```
git clone https://github.com/coreos/coreos-vagrant.git
cd coreos-vagrant
```
We use the Alpha update channel, which is the current default Vagrant uses, but we need more instances.  In the VagrantFile, change from 1->3
```
$num_instances = 3
```
Then connect to the va


##coreos-01
sudo docker run -d --name zk01 --env ZK_ID=1 --env ZK_SERVERS=r1:2888:3888 -p 2181:2181 -p 2888:2888 -p 3888:3888 zookeeper
sudo docker create --name jornalnode-data aarongdocker/hdfs /bin/true
sudo docker run -d --name jn01 --volumes-from jornalnode-data -e NNODE1_IP=r2 -e NNODE2_IP=r3 -e ZK_IPS=r1:2181 -e JN_IPS=r1:8485 -p 8485:8485 -p 8480:8480 aarongdocker/hdfs journalnode

###coreos-01 after the NNs have started
sudo docker create --name datanode-data aarongdocker/hdfs /bin/true
sudo docker run -it --name dn01 --volumes-from datanode-data -e NNODE1_IP=r2 -e NNODE2_IP=r3 -e ZK_IPS=r1:2181 -e JN_IPS=r1:8485 -p 1004:1004 -p 1006:1006 -p 8022:8022 -p 50010:50010 -p 50020:50020 -p 50075:50075 aarongdocker/hdfs datanode

####coreos-02
sudo docker create --name namenode-data aarongdocker/hdfs /bin/true
sudo docker run -it --name nn01 --volumes-from namenode-data -e NNODE1_IP=r2 -e NNODE2_IP=r3 -e ZK_IPS=r1:2181 -e JN_IPS=r1:8485 --net=host aarongdocker/hdfs active

####coreos-03
sudo docker create --name namenode-data aarongdocker/hdfs /bin/true
sudo docker run -it --name nn01 --volumes-from namenode-data -e NNODE1_IP=r2 -e NNODE2_IP=r3 -e ZK_IPS=r1:2181 -e JN_IPS=r1:8485 --net=host aarongdocker/hdfs standby
