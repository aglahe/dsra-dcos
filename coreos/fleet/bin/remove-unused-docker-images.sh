#!/bin/bash

for item in `docker ps -a | grep Exited | grep -Po '^([\d\w])+'`; 
do
   docker rm -v $item
done
