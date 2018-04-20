# README

## SNMP Agents
Setup SNMP agent on your computer. If you use Linux you can follow [this article](https://www.digitalocean.com/community/tutorials/how-to-install-and-configure-an-snmp-daemon-and-client-on-ubuntu-14-04).

## Setup application
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

## OIDs description
http://oidref.com/

## To do:
1) Refactor.

2) Add other information about system (CPU, RAM, disk
space, disk utilization).

3) Add pooling and web sockets to update information every 10(?) seconds.

4) Replace `netsnmp` gem with our implementation.

5) Add possibility to add more agents (keep agent information in database instead of environment variables, add `/agents/new` page to allow registration of new agent).

6) Deploy app to Heroku(?). If we want do that we probably should add authentication.
