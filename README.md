# homebuild

This repo will encompas everything I use to go from 0 to full-fledged openshift in my home lab.  This is setup for UPI (user provided infrastructure)
due to the need for a "bare metal" type cluster for openshift virtualization.

Existing:
Vmware Vsphere 6.7u3+ - standard switching - Two SAN datastores (one SATA and one SSD)

Steps / tech debt:

1.  Provision Kvirt OCP VMs
    -  3 X Master, 3 x Worker
    -  Working 1/10/2021 - ansible folder
2.  Build/configure bastion server
    - Provision VM WIP
    - Provision OS policies and packages WIP
    - Apply service configs - WIP
    (httpd, firewalld, selinux, haproxy, dnsmasq [dhcp server], tftpserver, syslinux, pxe env)
3.  Generate ignition files for Kvirt cluster
    -  Working 1/10/2021; needs to be ported from bash to ansible
4.  Install Kvirt OCP cluster
    - WIP.  Works manual lever.  Needs better automation
5.  Install Openshift Container Storage
    -  WIP.  Manual lever
    - Install local storage operator - WIP
    - Install openshift container storage operator - WIP
    - Create volumeset - WIP
    - Create storage cluster - WIP
6.  Install Openshift Virtualization
    - WIP Manual lever
    - Configure 2nd worker NIC for layer 2 bridge - WIP
    - Configure bridge selector policy - WIP
    - Configure templates and push to registry - WIP
7.  Provision ACM OCP VMs
    - 3 x master, 3 x worker - WIP
8.  Generate ignition files for ACM cluster
    -  WIP
9.  Install ACM Cluster
    -  WIP
10. Link ACM Cluster OCS operator to external provider from Kvirt OCS cluster for storage
    - WIP

