#!/bin/bash

fleetctl list-unit-files

fleetctl submit marathon1.service
fleetctl submit marathon2.service

fleetctl submit mesos-slave.service
fleetctl submit mesos-master@.service

fleetctl start mesos-master@{1..3}
fleetctl start mesos-slave.service

fleetctl start marathon1.service
fleetctl start marathon2.service

fleetctl list-unit-files

