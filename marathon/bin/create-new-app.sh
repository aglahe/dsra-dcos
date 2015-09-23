#!/bin/bash 
curl -X POST -H "Accept: application/json" -H "Content-Type: application/json" 10.105.0.5/v2/apps -d @$1
