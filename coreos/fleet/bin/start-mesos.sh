#!/bin/bash

fleetctl list-unit-files

fleetctl submit ../mesosphere/marathon1.service
fleetctl submit ../mesosphere/marathon2.service

fleetctl submit ../mesosphere/mesos-slave.service
fleetctl submit ../mesosphere/mesos-master@.service

fleetctl start mesos-master@{1..3}
fleetctl start mesos-slave.service

fleetctl start marathon1.service
fleetctl start marathon2.service

fleetctl list-unit-files

