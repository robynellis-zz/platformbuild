#!/bin/bash
cd ~
rm -rf ocpbm
mkdir ocpbm
cp backup/install-config.yaml ocpbm/.
openshift-install create manifests --dir=ocpbm

#####USE SED FOR THIS#####
vim ocpbm/manifests/cluster-scheduler-02-config.yml
#####

openshift-install create ignition-configs --dir=ocpbm
sudo rm -f /var/www/html/ignition/*
sudo cp ocpbm/*.ign /var/www/html/ignition/.
sudo chown apache:apache /var/www/html/ignition/*