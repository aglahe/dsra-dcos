#!/bin/bash
docker run -t -i --rm --name=cloudera-hue -p 8000:8000 -p 8020:8020 -p 50070:50070 -p 9999:9999 hub.dsra.local:5000/cloudera/hue:3.9.0
