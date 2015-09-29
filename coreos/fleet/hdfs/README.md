The assumption is that Zookeeper cluster is up, double check and make sure the Zookeeper cluster is up.

# Starting for first time
 1. **Submit all the *.service* files**
   * fleetctl submit journalnode.service namenode1.service namenode2.service datanode.service
 2. **Start the journal nodes, confirm they are running on the utility nodes**
   * fleetctl start journalnode.service
 3. **Start namenode1**
   * fleetctl start namenode1.service
   * This should be running on r105u01, which you can check:  http://r105u01.dsra.local:50070
 4. **Start namenode2**
   * fleetctl start namenode2.service
   * This should be running on r105u03, which you can check:  http://r105u03.dsra.local:50070
 5. **Start the datanodes**
   * fleetctl start datanode.service

# Starting an existing cluster
Basically, if the Namenode has already been formated (as well as the Zookeeper Failover), you can just do steps 2-5 above.

# If Zookeeper Fails (e.g. we lose Zookeeper Data containers)
HDFS should be fine, but, we will need to reformat the zookeeper failover znode.  
 1. Start the journal ndoes
 2. Start the namenode1 service
 3. "exec" into the namenode1 container
   * ssh to core@r105u01.dsra.local
   * docker exec -i -t namenode bash
   * In the /usr/local/hadoop DIR run the command: *bin/hdfs zkfc -formatZK*
   * In the /usr/local/hadoop DIR run the command: *sbin/hadoop-daemon.sh start zkfc*
 4. Start namenode2 service
 5. Start the datanode services
   
