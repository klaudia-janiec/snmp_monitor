#!/usr/bin/env bash
BOOTSTRAP_USER="bootstrap"
BOOTSTRAP_PASSWD="temp_password"

USER="ask"
USER_PASSWD="my_new_password"

echo -e '### Starting provisioning as Agent:'

echo -e "\n==> snmpd - installation"
apk add net-snmp
apk add net-snmp-tools

echo -e "\n==> snmpd - basic configuration and service start"
mv /home/vagrant/snmpd.conf /etc/snmp -vf 
rc-update add snmpd
rc-service snmpd start

echo -e "\n==> snmpd - user configuration"
echo -e "--> checking if stmpd works fine - equivalent to uname -a"
snmpget -u bootstrap -l authPriv -a MD5 -x DES -A $BOOTSTRAP_PASSWD -X $BOOTSTRAP_PASSWD localhost 1.3.6.1.2.1.1.1.0
echo -e "--> create demo user from bootstrap user"
snmpusm -u bootstrap -l authPriv -a MD5 -x DES -A $BOOTSTRAP_PASSWD -X $BOOTSTRAP_PASSWD localhost create $USER bootstrap
echo -e "--> change credentials for demo user"
snmpusm -u $USER -l authPriv -a MD5 -x DES -A $BOOTSTRAP_PASSWD -X $BOOTSTRAP_PASSWD localhost passwd $BOOTSTRAP_PASSWD $USER_PASSWD
echo -e "--> check if it works by getting snmpd uptime"
snmpget -u $USER -l authPriv -a MD5 -x DES -A $USER_PASSWD -X $USER_PASSWD localhost sysUpTime.0

echo -e "--> removing bootstrap user"
sed -i -e 's/rwuser bootstrap priv/#rwuser bootstrap priv/g' /etc/snmp/snmpd.conf
sed -i -e 's/createUser bootstrap/#createUser bootstrap/g' /etc/snmp/snmpd.conf
rc-service snmpd restart

snmpusm -u $USER -l authPriv -a MD5 -x DES -A $USER_PASSWD -X $USER_PASSWD localhost delete bootstrap

netstat -natup

