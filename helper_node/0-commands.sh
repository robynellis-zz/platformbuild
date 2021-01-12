##Install EPEL
sudo dnf install https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm -y

##Install other packages
sudo dnf install tmux httpd dhcp-server tftp-server syslinux haproxy bind bind-utils -y

##Configure firewall rules
sudo firewall-cmd --permanent --add-service={dns,dhcp,http,https,tftp,ftp}
sudo firewall-cmd --permanent --add-port={6443/tcp,22623/tcp,9000/tcp,8080/tcp,69/udp,4011/udp}
sudo firewall-cmd --reload

##Install dnsmasq
dnf install dnsmasq -y
***copy template from my repo***

##Setup PXE boot env
sudo dnf install syslinux tftp-server -y
sudo mkdir -p /var/lib/tftpboot/pxelinux.cfg
sudo curl --output /var/www/html/images/rhcos-4.6.8-x86_64-live-rootfs.x86_64.img https://mirror.openshift.com/pub/openshift-v4/dependencies/rhcos/latest/latest/rhcos-4.6.8-x86_64-live-rootfs.x86_64.img
sudo curl --output /var/www/html/images/rhcos-4.6.8-x86_64-live-initramfs.x86_64.img https://mirror.openshift.com/pub/openshift-v4/dependencies/rhcos/latest/latest/rhcos-4.6.8-x86_64-live-initramfs.x86_64.img
sudo curl --output /var/www/html/images/rhcos-4.6.8-x86_64-live-kernel-x86_64 https://mirror.openshift.com/pub/openshift-v4/dependencies/rhcos/latest/latest/rhcos-4.6.8-x86_64-live-kernel-x86_64
sudo chown apache:apache /var/www/html/images/*
cp -r /usr/share/syslinux/* /var/lib/tftpboot
systemctl enable tftp.socket --now

##Configure Haproxy
***copy template from my repo****
***edit template****
setsebool -P haproxy_connect_any on
systemctl start haproxy

##Install httpd
edit /etc/httpd/conf/httpd.conf and set port to 8080 (learn to use sed for this)
systemctl restart httpd
mkdir -p /var/www/html/ignition
mkdir -p /var/www/html/images

#approve CSRs
export KUBECONFIG=/home/robynellis/ocpbm/auth/kubeconfig
watch oc get csr
for csr in $(oc get csr --no-headers | grep Pending | cut -d " " -f1)
do
  oc adm certificate approve "$csr"
done

for node in {0..2}
do
  oc label nodes storage-${node}.kvirt.aliveagain.me cluster.ocs.openshift.io/openshift-storage=''
done








