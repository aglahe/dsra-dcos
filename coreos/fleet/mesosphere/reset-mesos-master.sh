#!/bin/bash
fleetctl list-unit-files
fleetctl destroy mesos-master@{1..3}.service
fleetctl destroy mesos-master@.service
fleetctl submit mesos-master\@.service 
fleetctl start mesos-master@{1..3}.service
fleetctl list-unit-files
