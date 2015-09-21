#!/bin/bash
fleetctl list-unit-files

fleetctl destroy marathon.service
fleetctl submit ../mesosphere/marathon.service
fleetctl start marathon.service

fleetctl list-unit-files
