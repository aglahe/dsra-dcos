Following the docs on https://coreos.com/os/docs/latest/booting-on-vagrant.html
```
git clone https://github.com/coreos/coreos-vagrant.git
cd coreos-vagrant
```
We use the "alpha" update channel, which is the current default Vagrant uses, but we need more instances.
 1. Save the user-data.sample -> user-data
 2. Save the config.rb.sample -> config.rb.  
 3. In the config.rb, change from 1->3:
```
$num_instances = 3
```

We also then want to make sure that the /etc/hosts file is updated...so we are going to brute force our way.  We need to add the code below, right after the line,
```
config.vm.network :private_network, ip: ip
```
 which is at approximately line 124 in the Vagrant file.  Add the following code below to help update the Hosts file on each VM.
```      
#  Update hosts file
(1..$num_instances).each do|v|
  config.vm.provision "shell" do |s|
    s.inline = "echo $1 $2 >> /etc/hosts"
    s.args = ["172.17.8.#{v+100}", "%s-%02d" % [$instance_name_prefix, v]]
  end
end
```

Then connect to the vagrant guest via, where the X is 1,2 or 3:
```
vagrant ssh core-0X
```

##coreos-01
```
sudo docker run -d --name zk --env ZK_ID=1 --env ZK_SERVERS=core-01:2888:3888 -p 2181:2181 -p 2888:2888 -p 3888:3888 aarongdocker/zookeeper
sudo docker create --name journalnode-data aarongdocker/hdfs /bin/true
sudo docker run -it --name jn --volumes-from journalnode-data -e NNODE1_IP=core-02 -e NNODE2_IP=rcore-03 -e ZK_IPS=core-01:2181 -e JN_IPS=core-01:8485 -p 8485:8485 -p 8480:8480 aarongdocker/hdfs journalnode
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
