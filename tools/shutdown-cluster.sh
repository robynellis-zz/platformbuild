#!/bin/bash

for ip in $(oc get nodes  -o jsonpath='{.items[*].status.addresses[?(@.type=="InternalIP")].address}')
do
   echo "reboot node $ip"
   ssh -o StrictHostKeyChecking=no core@$ip sudo shutdown -h -t 5
done
