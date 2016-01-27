#!/bin/bash
docker exec bamboo su - haproxy -c 'haproxy -c -f {{.}}'

