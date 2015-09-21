#!/bin/bash
fleetctl list-unit-files
fleetctl destroy mesos-slave@{1..11}.service
fleetctl destroy mesos-slave@.service
fleetctl submit mesos-slave\@.service 
fleetctl start mesos-slave@{1..11}.service
fleetctl list-unit-files
