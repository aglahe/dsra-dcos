#!/bin/bash
docker run -t -i --rm --name=hue -p 8000:8000 -e CLUSTER_NAME=dsra -e HTTPFS_SERVER=httpfs.marathon.mesos -e HTTPFS_PORT=32000 hub.dsra.local:5000/dsra/hue:3.9.0 start
