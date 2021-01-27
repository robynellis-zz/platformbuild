# Platformbuild

This repo will encompas everything I use to go from 0 to full-fledged openshift in my OCP installs.  This setup is for both assisted bare metal and UPI (user provided infrastructure)due to the need for a "bare metal" type cluster for openshift virtualization.  This also makes heavy use of ACM as I intend to eventually traisition all of my infra automation, policy management, and app installs to it.

Existing on-prem:
Vmware Vsphere 6.7u3+ - standard switching - Two SAN datastores (one SATA and one SSD)

Steps / tech debt:

1.  Provision ACM OCP VMs
    -  3 X Master, 3 x Worker
    -  Working 1/10/2021 - infra folder
2.  Build/configure bastion server
    - Provision VM WIP
    - Provision OS policies and packages WIP
    - Apply service configs - WIP
    - is this still needed with assisted bare-metal???????
    (httpd, firewalld, selinux, haproxy, dnsmasq [dhcp server], tftpserver, syslinux, pxe env)
3.  Generate ignition files for ACM cluster
    -  Working 1/10/2021; needs to be ported from bash to ansible
4.  Install ACM OCP cluster
    - ansible build playbook in infra folder.  copy/edit to your liking
    - working and needs process refinement
5.  Install Openshift Container Storage
    -  WIP.  Manual lever
    - Install local storage operator - WIP
    - Install openshift container storage operator - WIP
    - Create volumeset - WIP
    - Create storage cluster - WIP
6.  Install Corp OCP cluster
7.  perform post-install on corp OCP cluster
8.  Install Openshift container storage on corp OCP cluster
9.  Expose corp OCP cluster on public WAN and configure certificates for ingress
    
10.  Install Openshift Virtualization
    - WIP Manual lever
    - Configure 2nd worker NIC for layer 2 bridge - WIP
    - Configure bridge selector policy - WIP
    - Configure templates and push to registry - WIP

TODO:
Implement CI/CD tool and pipeline type build for these clusters
adapt these clusters to different providers and standardize
onboard rocket chat and balance routes between corp (on-prem) and cloud hosted
implement SSO and extend to cloud envs



