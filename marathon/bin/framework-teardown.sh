#!/usr/bin
echo "frameworkId=$1" | curl -d@- -X POST http://10.105.0.5:5050/master/teardown
