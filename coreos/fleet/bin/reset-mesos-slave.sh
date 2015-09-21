#!/bin/bash
fleetctl list-unit-files
fleetctl stop mesos-slave.service
fleetctl destroy mesos-slave.service
fleetctl submit ../marathon/mesos-slave.service 
fleetctl start mesos-slave.service
fleetctl list-unit-files
