#!/bin/bash
docker run -d -t -i --restart=always --name=hub -v /opt/file-serve:/opt/file-serve -p 80:80 dsra/file-server /run.sh
