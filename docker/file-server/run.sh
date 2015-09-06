#!/bin/bash
docker run -d -t -i --restart=always -v /opt/file-serve:/opt/file-serve -p 8080:8080 dsra/file-server /run.sh
