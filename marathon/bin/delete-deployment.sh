#!/bin/bash 
# 
# usage: bin/destroy-app.sh [DEPLOYMENT_ID]
#
curl -X DELETE -H "Accept: application/json" -H "Content-Type: application/json" 10.105.0.5/v2/deployments/$1
