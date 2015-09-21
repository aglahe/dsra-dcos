#!/bin/bash
fleetctl stop zookeeper{1..5}.service
fleetctl destroy zookeeper{1..5}.service
