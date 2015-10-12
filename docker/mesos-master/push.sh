#!/bin/bash
docker tag dsra/mesos-master:0.24.0-1.0.27.ubuntu1404 hub.dsra.local:5000/dsra/mesos-master:0.24.1-0.2.35.ubuntu1404

docker push hub.dsra.local:5000/dsra/mesos-master:0.24.1-0.2.35.ubuntu1404

