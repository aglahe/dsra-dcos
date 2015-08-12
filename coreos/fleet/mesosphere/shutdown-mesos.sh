#!/bin/bash
fleetctl list-unit-files

fleetctl stop marathon@{1..2}
fleetctl stop mesos-slave@{1..11}
fleetctl stop mesos-master@{1..3}

fleetctl destroy marathon@{1..2}
fleetctl destroy mesos-slave@{1..11}
fleetctl destroy mesos-master@{1..3}

fleetctl destroy marathon@.service
fleetctl destroy mesos-slave@.service
fleetctl destroy mesos-master@.service

fleetctl list-unit-files
