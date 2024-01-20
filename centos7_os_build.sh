echo "Centos 7 Os build started........"

cd /tmp
git clone https://github.com/NithinSunke/vsphere_linux_os_build.git
cd /tmp
ls
cat  /tmp/vsphere_linux_os_build/config/install_env.sh  > /tmp/CENTOS7_OS_POST_BUILD/install_env.sh


.   /tmp/CENTOS7_OS_POST_BUILD/install_env.sh

echo "installing os packages"
echo "+++++++++++++++++++++++"

sudo sh  /tmp/CENTOS7_OS_POST_BUILD/install_os_packages.sh
sudo systemctl start nfs-server.service
sudo systemctl enable nfs-server.service
sudo systemctl status nfs-server.service

sudo yum -y install iscsi-initiator-utils
sudo systemctl start iscsid
sudo systemctl enable iscsid
sudo systemctl stop firewalld
sudo systemctl disable firewalld
sudo yum clean all

echo "mounting the nfs share"
echo "+++++++++++++++++++++++"

sudo mkdir -p /nfsshare
sudo mount -t nfs 192.168.0.10:/nfsshare /nfsshare
df -kh

echo "192.168.0.10:/nfsshare /nfsshare  nfs 0 0"  >> /etc/fstab

echo "setting the hostnames"
echo "+++++++++++++++++++++++"
sudo sh /tmp/CENTOS7_OS_POST_BUILD/configure_hostname.sh

echo "=========================================================="
echo "server build  ${HOSTNAME}.${DOMAIN_NAME} is completed"
echo "=========================================================="

echo "Centos 7 os build completd........"