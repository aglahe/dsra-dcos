#!/bin/bash
docker run -d -t -i --restart=always --net=host --name=hub -v /opt/file-serve:/opt/file-serve -p 8088:8088 dsra/file-server /run.sh
