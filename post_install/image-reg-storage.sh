#!/bin/bash

## if not using OCS, create PV from storage provider.  Else skip.
oc create -f $TEMPLATEDIR/imageregistry-create-pv.yaml
oc create -f $TEMPLATEDIR/imageregistry-create-pvc.yaml

## if using OCS, just create the PVC and let dynamic provision PV
oc create -f $TEMPLATEDIR/imageregistry-create-pvc-ocs.yaml -n openshift-image-registry

oc edit configs.imageregistry.operator.openshift.io/cluster -o yaml

### fix this JSON ###
oc patch configs.imageregistry.operator.openshift.io cluster --patch '{"spec":{"storage":{"pvc":{"claim": image-registry""}}}}' --type=merge
