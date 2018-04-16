Readme on using vagrant
=======================

Installation
------------

Go to [vagrant site](https://www.vagrantup.com/downloads.html) and download **vagrant**, then follow installation instructions.

Usage
-----

In Vagrantfile there are several machines defined:
  - monitor - which have installed SNMP monitoring application
  - agentX  - machine that may be monitored with SNMP protocol, X is a number as many agents may be running.
The number of agent machines can be set by setting AGENTS_NUMBER variable in Vagrantfile.

1. Running machines:
```
$ vagrant up
$ vagrant up MACHINENAME # monitor, agent1...
```

2. CHeck what machines are running
```
$ vagrant status
```

3. SSH into some machine:
```
$ vagrant ssh MACHINENAME
```

4. Machines shutdown from host
```
$ vagrant halt
```

5. Removing machines
```
$ vagrant destroy
```

