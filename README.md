# README
The project is setup in the way that snmp monitor application pulls data about cpu and memory usage form some agents (by hardcoded ip).

The project has configured virtual machines - to run the demonstration you need:  
- install VirtualBox  
- install vagrant  
- navigate to `./vagrant` and issue command `vagrant up` - please note, that it will take few minutes, as provisioning of one of the machines requires compiling the ruby package (there was no binaries available). For more  information abot vagrant usage in project please consult `./vagrant/Readme.md`.
- on host machine open [localhost:8080](localhost:8080) in the browser  

Known issue:
For some reason the javascript code is not served if the application runs in daemon mode. The workaround is:  
- ssh into monitor machine:  
```
host $ cd ./vagrant
host $ vagrant ssh monitor
```
after connecting to monitor machine you need to kill daemon and manually start monitoring web service:
```
monitor $ ps aux
PID   USER     TIME   COMMAND
 2028 vagrant    0:00 {bundle} /home/vagrant/.rbenv/versions/2.5.0/bin/rackup -o 0.0.0.0 -D
monitor $ kill 2028
monitor $ cd snmp_monitor
monitor $ bundle exec rackup -o 0.0.0.0
```

## Stress tests
To observe some values in the monitor application, you may want to start some resource-consuming job on one of machines, e.g.:
```
$ dd if=/dev/zero of=/dev/null
```

## Other info

### How to setup SNMP agents in general
Setup SNMP agent on your computer. If you use Linux you can follow [this article](https://www.digitalocean.com/community/tutorials/how-to-install-and-configure-an-snmp-daemon-and-client-on-ubuntu-14-04).

### How to setup monitor web application manually
Install dependencies:

```bash
$ bundle install
```

Set environment variables:
```bash
$ cp .env.example .env
$ vi .env
```

If you followed mentioned article you should set only your passwords (`AUTH_PASSWORD` and `PRIV_PASSWORD`).

Run application:
```bash
$ rackup
```

Application is available on `9292` port by default.

Go to agents path: `http://localhost:9292/agents/`. You should see information about your system.

### OIDs description
http://oidref.com/

