#!/usr/bin/env bash

echo -e '### Starting provisioning as Monitor:'

echo -e '\n==> Add building software (gcc, make, stdclib (musl), linux headers)'
sudo apk add gcc
sudo apk add make
sudo apk add musl-dev
sudo apk add linux-headers

echo '\n==> Installing git, rbenv, ruby'
VAGRANT_HOME=~
RBENV_ROOT=$VAGRANT_HOME/.rbenv

echo '----> rbenv - installing'
sudo apk add git
sudo apk add curl
git clone https://github.com/rbenv/rbenv.git $RBENV_ROOT
cd $RBENV_ROOT && src/configure && make -C src

echo '----> rbenv - updating PATH'
env | grep PATH
$RBENV_ROOT/bin/rbenv init
echo "export PATH=${RBENV_ROOT}/bin:${RBENV_ROOT}/shims:$PATH" >> $VAGRANT_HOME/.bash_profile
echo "export PATH=${RBENV_ROOT}/bin:${RBENV_ROOT}/shims:$PATH" >> $VAGRANT_HOME/.bashrc
source $VAGRANT_HOME/.bash_profile
env | grep PATH

echo '----> rbenv - installing ruby-build'
mkdir -p $RBENV_ROOT/plugins
git clone https://github.com/rbenv/ruby-build.git $RBENV_ROOT/plugins/ruby-build

echo '----> rbenv - veryfying'
curl -fsSL https://github.com/rbenv/rbenv-installer/raw/master/bin/rbenv-doctor | bash

echo '----> Installing ruby - this may take few minutes as it will build ruby from sources...'
sudo apk add openssl-dev
sudo apk add zlib zlib-dev
sudo apk add readline-dev
sudo apk add gdbm-dev
date
rbenv install 2.5.0
date
rbenv global 2.5.0

echo -e "\n==> Cloning project, installing gems and changing configuration"
SNMP_MONITOR_DIR=$VAGRANT_HOME/snmp_monitor
git clone https://github.com/klaudia-janiec/snmp_monitor.git $SNMP_MONITOR_DIR
cd $SNMP_MONITOR_DIR
gem install bundler
bundle install
mv $VAGRANT_HOME/env $SNMP_MONITOR_DIR/.env 
chown -R vagrant:vagrant $HOME

