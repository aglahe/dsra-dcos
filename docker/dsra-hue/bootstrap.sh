#!/bin/bash

# make sure we have everyrthing
if [ -z $CLUSTER_NAME ] || [ -z $HTTPFS_SERVER ] || [ -z $HTTPFS_PORT ]; then
  echo CLUSTER_NAME, HTTPFS_SERVER, and HTTPFS_PORT needs to be set as environment addresses to be able to run.
  exit;
fi

# Replace all the variables in hue.ini.template
sed "s/CLUSTER_NAME/$CLUSTER_NAME/" /tmp/hue.ini.template \
| sed "s/HTTPFS_SERVER/$HTTPFS_SERVER/" \
| sed "s/HTTPFS_PORT/$HTTPFS_PORT/" \
> /local/git/hue/desktop/conf/pseudo-distributed.ini

# Read the 1st arg, and based upon that, act accordingly
case "$1" in
  start)
    build/env/bin/hue runserver 0.0.0.0:8000
    ;;
  bash)
    /bin/bash
    ;;
  *)
    echo $"Usage: {start|bash}"
    eval $*
esac
