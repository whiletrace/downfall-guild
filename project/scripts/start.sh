#!/usr/bin/env bash

# Clone drupal-vm
git clone git@github.com:geerlingguy/drupal-vm.git
cd drupal-vm
git checkout tags/3.1.2 # Change me to update

# Symlink `config.yml` and `drupal.make.yml` from `config/` into `drupal-vm/`
ln -sf ../config/config.yml
ln -sf ../config/drupal.composer.json

# Move back to root of repo
cd ../

# DELETE the D8 folder and kick off Vagrant.
sudo rm -rf project/web/d8
cd drupal-vm
vagrant up --provision

# Back to root
cd ../

# Symlinks
bash ./project/scripts/symlinks.sh

# Copy config
mkdir -p ./project/web/d8/web/sites/default/files/sync
cp ./project/build/dev/d8/modules/custom/df_config/sync/* ./project/web/d8/web/sites/default/files/sync/

# Permissions needed for import/moving around files
chmod -R 777 project/web/d8/web/sites/default
chmod -R 777 project/web/d8/web/sites/default/*

# Build d6
bash ./project/scripts/d6.sh
