#!/bin/bash

#you mut already be logged in with admin rights for this to work!

#patch default route to true for image-registry
oc patch configs.imageregistry.operator.openshift.io/cluster --patch '{"spec":{"defaultRoute":true}}' --type=merge

#set ENV variable
HOST=$(oc get route default-route -n openshift-image-registry --template='{{ .spec.host }}')

#test login with podman
podman login -u $(oc whoami) -p $(oc whoami -t) --tls-verify=false $HOST 

