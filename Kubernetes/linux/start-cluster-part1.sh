#!/bin/bash
setenforce 0 && sed -i --follow-symlinks 's/SELINUX=enforcing/SELINUX=disabled/g' /etc/sysconfig/selinux
swapoff -a
##Preparing the Master
yum install curl git build-essential docker conntrack python2.7 nano wget deltarpm -y
systemctl enable docker
systemctl start docker
mkdir ~/kube
mkdir ~/kube/bin
git clone https://github.com/funky81/SDN /tmp/k8s 
cd /tmp/k8s/Kubernetes/linux
chmod -R +x *.sh
chmod +x manifest/generate.py
mv * ~/kube/
##Installing the Linux Binaries
wget -O kubernetes.tar.gz https://github.com/kubernetes/kubernetes/releases/download/v1.9.3/kubernetes.tar.gz
tar -vxzf kubernetes.tar.gz 
cd kubernetes/cluster 
./get-kube-binaries.sh
cd ../server
tar -vxzf kubernetes-server-linux-amd64.tar.gz 
cd kubernetes/server/bin
cp hyperkube kubectl ~/kube/bin/
##Install CNI Plugins
DOWNLOAD_DIR="${HOME}/kube/cni-plugins"
CNI_BIN="/opt/cni/bin/"
mkdir $DOWNLOAD_DIR
cd $DOWNLOAD_DIR
curl -L $(curl -s https://api.github.com/repos/containernetworking/plugins/releases/latest | grep browser_download_url | grep 'amd64.*tgz' | head -n 1 | cut -d '"' -f 4) -o cni-plugins-amd64.tgz
tar -xvzf cni-plugins-amd64.tgz
mkdir -p $CNI_BIN
cp -r * $CNI_BIN
rm -rf $CNI_BIN/*.tgz
ls $CNI_BIN