#!/bin/bash
fleetctl list-unit-files

fleetctl destroy marathon1.service
fleetctl destroy marathon2.service

fleetctl submit marathon1.service 
fleetctl submit marathon2.service

fleetctl start marathon1.service
fleetctl start marathon2.service

fleetctl list-unit-files
