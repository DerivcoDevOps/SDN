#!/bin/bash
setenforce 0 && sed -i --follow-symlinks 's/SELINUX=enforcing/SELINUX=disabled/g' /etc/sysconfig/selinux
swapoff -a
## about certs
cd ~/kube/certs
chmod u+x generate-certs.sh
./generate-certs.sh $2
## about manifest
cd ~/kube/manifest
./generate.py $MASTER_IP --cluster-cidr $1.0.0/16
## about kube
cd ~/kube
./configure-kubectl.sh $2
## copy
mkdir ~/kube/kubelet
sudo cp ~/.kube/config ~/kube/kubelet/