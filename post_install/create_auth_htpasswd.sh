#!/bin/bash
#Create htpasswd file
touch htpasswd

#add users
htpasswd -Bb htpasswd robynellis #

#create OCP secret
oc --user=admin create secret generic htpasswd \
    --from-file=htpasswd -n openshift-config

#configureOauth

oc replace -f /home/$USER/repos/homebuild/oauth-config-htpasswd.yaml

#configure groups
oc --user=admin adm groups new local-admin
oc --user=admin adm groups add-users local-admin robynellis
oc --user=admin adm policy add-cluster-role-to-group cluster-admin local-admin
oc adm policy add-cluster-role-to-group sudoer local-admin


