## Data Science Research Architecture, Data Center OS

### Overview

The newest version of the DSRA migrates the system to a Mesos-centric architecture. It provides 
significant distributed processing capabilities out of the box, supporting in the number of 
disparate frameworks. The distributed processing architecture is abstracted for Engineers to 
write their own frameworks in different languages: Java, Python, Ruby, C, and Go. 

![](./docs/architecture-201509160755)

### Future Releases

Mesos also supports deploying applications as Docker containers. Long running processes are
managed by Marathon, which can run containers deployed on DockerHub use their own private Docker registry.

Distributed storage supported in the first software release is HDFS. 

Future releases and updates will focus on adding more software capabilities, to include, but not limited too, the following:

* ElasticSearch
* Kafka
* HBase
* Myriad/Yarn
* Mongo
