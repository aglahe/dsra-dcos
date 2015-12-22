#!/bin/bash

for item in `docker ps -a | grep Exited`; do
   echo $item
done
