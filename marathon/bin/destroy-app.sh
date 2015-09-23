#!/bin/bash 
# 
# usage: bin/destroy-app.sh [APPID]
#
curl -X DELETE -H "Accept: application/json" -H "Content-Type: application/json" 10.105.0.5/v2/apps/$1
