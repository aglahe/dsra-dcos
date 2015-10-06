#!/bin/bash
docker run -d -t -i --name docker-registry --restart=always -v /opt/registry/data:/registry/data -e STORAGE_PATH=/registry/data -e SETTINGS_FLAVOR=local -e LOGLEVEL=DEBUG registry
