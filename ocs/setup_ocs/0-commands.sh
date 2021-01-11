for node in {0..2}
do
  oc label nodes worker${node}.kvirt.aliveagain.me cluster.ocs.openshift.io/openshift-storage=''
done
