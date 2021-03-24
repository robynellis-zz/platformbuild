#!/bin/bash

#this script assumes that you have already installed oc, logged in, and have sudo rights

#install EPEL
yum install https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm
ARCH=$( /bin/arch )
subscription-manager repos --enable "codeready-builder-for-rhel-8-${ARCH}-rpms"

#install certbot
sudo dnf install certbot -y

#make the initial request for a wildcard certificate using a dns01 challenge
#look in templates dir for certbot commands.  Pick your dns provider.
#customize template and run to get your cert.
#I recommend cloudflare.  But YMMV.
certbot certonly --manual --preferred-challenges=dns \
--email=person@domain.com  --agree-tos -d *.apps.cluster.domain.suffix

#create a configmap with the obtained certificates
oc --namespace openshift-ingress create secret tls custom-certs-default \
--cert=tls.crt --key=tls.key
#or use pem files.  whichever work

#Update the IngressController CR to reference the new certificate secret
oc patch --type=merge --namespace openshift-ingress-operator ingresscontrollers/default \
--patch '{"spec":{"defaultCertificate":{"name":"custom-certs-default"}}}'

#Verify the update was effective
oc get --namespace openshift-ingress-operator ingresscontrollers/default \
--output jsonpath='{.spec.defaultCertificate}'

#watch oc get co and wait for all COs to recover from the change
##Once the IngressController CR has been modified, the Ingress Operator updates the Ingress Controller’s 
deployment to use the custom certificate

