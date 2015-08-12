#!/bin/bash

fleetctl list-unit-files

fleetctl submit marathon@.service
fleetctl submit mesos-slave@.service
fleetctl submit mesos-master@.service

fleetctl start mesos-master@{1..3}
fleetctl start mesos-slave@{1..11}
fleetctl start marathon@{1..2}

fleetctl list-unit-files

