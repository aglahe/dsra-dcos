#!/bin/bash
for containerId in `docker ps -a | grep Exited | grep -Po '^([\d\w])+'`;  
do 
     docker rm -v $containerId
done
~ 
