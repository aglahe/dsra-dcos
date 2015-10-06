#!/bin/bash
docker run -d -p 443:443 -v /opt/registry/external:/etc/nginx/external --restart=always --link registry:registry --name nginx-registry-proxy marvambass/nginx-registry-proxy
