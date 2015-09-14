#!/bin/bash
docker tag dsra/mesos-master:0.23.0.1 hub.dsra.local:5000/dsra/mesos-master:0.23.0.1

docker push hub.dsra.local:5000/dsra/mesos-master:0.23.0.1
