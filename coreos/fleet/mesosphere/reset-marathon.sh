#!/bin/bash
fleetctl list-unit-files
fleetctl destroy marathon@{1..2}.service
fleetctl destroy marathon@.service
fleetctl submit marathon\@.service 
fleetctl start marathon@{1..2}.service
fleetctl list-unit-files
