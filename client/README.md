# DSRA Client Vagrant VM

Please make sure that vbguest is installed (https://github.com/dotless-de/vagrant-vbguest/).  It helps keep the VirtuaalBoxGuestAdditions up to date, install on the cmd line:
```
vagrant plugin install vagrant-vbguest
```
When starting this on Linux, do not use your distribution's Vagrant package to install vagrant. Install from https://www.vagrantup.com to ensure you're using the latest version of Vagrant. Using old versions of Vagrant will result in errors.

Currently has:
 1. Haddop 2.7.1 with -site files pointing to the DSRA cluster
 2. Kafka 0.9.0.0
 3. Spark 1.6
 3. fleetctl and etcdctl for coreos
 4. libmesos
