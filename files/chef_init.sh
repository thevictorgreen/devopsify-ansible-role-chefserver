#!/bin/bash

# LOG OUTPUT TO A FILE
exec 3>&1 4>&2
trap 'exec 2>&4 1>&3' 0 1 2 3
exec 1>/root/.chef_automate/log.out 2>&1

if [[ ! -f "/root/.chef_automate/init.cfg" ]]
then
  # Download Latest Version Of Chef Core
  cd /root/.chef_automate && curl -O https://packages.chef.io/files/stable/chef-server/13.1.13/ubuntu/18.04/chef-server-core_13.1.13-1_amd64.deb
  # Install Chef Core
  dpkg -i chef-server-core_13.1.13-1_amd64.deb
  # Idempotentcy
  touch /root/.chef_automate/init.cfg
fi
