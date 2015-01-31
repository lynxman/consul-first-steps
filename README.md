Vagrant Consul Demo
===================

This Vagrant deployment will create four VMs for you to play with Consul.

VMs
---
consul1 - Consul Server 1
consul2 - Consul Server 2
consul3 - Consul Server 3
web - Web Server (running nginx)

Deployment
----------
The servers use the Ubuntu 14.04.1 LTS official image then on top of that we install:
* Puppet
* Facter
* Hiera
* dnsmasq (have to work around bug https://bugs.launchpad.net/ubuntu/+source/dnsmasq/+bug/1247803)
* consul

In order for these vms to work properly you need to have a working Internet connection.

What to do with this
--------------------
This setup is part of my talk from FOSDEM'15 which you can find [here](http://www.slideshare.net/lynxmanuk/consul-first-steps), use it to
play with Consul.

Here are some examples of what you can do with it:

    vagrant ssh web
    ## COMMANDS
    # Show the internal status of your consul agent
    consul info
    # Show all the members in your consul LAN Gossip
    consul members
    # Show the live info stream
    consul monitor

    ## API CATALOG
    # List of datacenters we have available
    curl -s http://localhost:8500/v1/catalog/datacenters | jq .
    # List of nodes in the local datacenter
    curl -s http://localhost:8500/v1/catalog/nodes | jq .
    # List of services available
    curl -s http://localhost:8500/v1/catalog/services | jq .
    # Look in detail at services
    curl -s http://localhost:8500/v1/catalog/service/web | jq .
    curl -s http://localhost:8500/v1/catalog/service/consul | jq .

    ## API AGENT
    # All the information about the agent
    curl -s http://localhost:8500/v1/agent/self | jq .
    # List of services managed by the agent
    curl -s http://localhost:8500/v1/agent/services | jq .
    # List of checks executed by the agent
    curl -s http://localhost:8500/v1/agent/checks | jq .
