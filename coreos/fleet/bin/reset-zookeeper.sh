#!/bin/bash
fleetctl list-unit-files
fleetctl destroy zookeeper{1..5}.service
fleetctl submit ../zookeeper/zookeeper*.service 
fleetctl start zookeeper{1..5}.service
fleetctl list-unit-files
