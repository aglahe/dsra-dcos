#!/bin/bash
fleetctl list-unit-files

fleetctl stop marathon1.service
fleetctl stop marathon2.service

fleetctl stop mesos-slave@{1..11}
fleetctl stop mesos-master@{1..3}

fleetctl destroy marathon1.service
fleetctl destroy marathon2.service

fleetctl destroy mesos-slave@{1..11}
fleetctl destroy mesos-master@{1..3}

fleetctl destroy mesos-slave@.service
fleetctl destroy mesos-master@.service

fleetctl list-unit-files
