#!/bin/bash 
curl -X POST -H "Accept: application/json" -H "Content-Type: application/json" 10.105.0.$1:8080/v2/apps -d @$2
