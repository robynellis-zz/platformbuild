#!/bin/bash


####label your worker nodes
####the example below will label your main 3 workers.  adjust as needed.####
for node in {0..2}
do
  oc label nodes worker${node}.cluster.sample.com cluster.ocs.openshift.io/openshift-storage=''
done

####Install local storage operator

####Install openshift container storage operator

####Configure local-storage 
