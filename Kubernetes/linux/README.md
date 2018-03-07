#Kubernetes Master From Scratch

Guidelines for Centos version 7.4 and kubernetes version 1.9.3

##Preparing the Master
```
yum install curl git build-essential docker conntrack python2.7 nano wget deltarpm -y
```

```
mkdir ~/kube
mkdir ~/kube/bin
git clone https://github.com/funky81/SDN /tmp/k8s 
cd /tmp/k8s/Kubernetes/linux
chmod -R +x *.sh
chmod +x manifest/generate.py
mv * ~/kube/
```

##Installing the Linux Binaries

```
wget -O kubernetes.tar.gz https://github.com/kubernetes/kubernetes/releases/download/v1.9.3/kubernetes.tar.gz
tar -vxzf kubernetes.tar.gz 
cd kubernetes/cluster 
./get-kube-binaries.sh
cd ../server
tar -vxzf kubernetes-server-linux-amd64.tar.gz 
cd kubernetes/server/bin
cp hyperkube kubectl ~/kube/bin/
```

```
PATH="$HOME/kube/bin:$PATH"
```
also add to /root/.bash_profile

##Install CNI Plugins

DOWNLOAD_DIR="${HOME}/kube/cni-plugins"
CNI_BIN="/opt/cni/bin/"
mkdir $DOWNLOAD_DIR
cd $DOWNLOAD_DIR
curl -L $(curl -s https://api.github.com/repos/containernetworking/plugins/releases/latest | grep browser_download_url | grep 'amd64.*tgz' | head -n 1 | cut -d '"' -f 4) -o cni-plugins-amd64.tgz
tar -xvzf cni-plugins-amd64.tgz
sudo mkdir -p $CNI_BIN
sudo cp -r * $CNI_BIN
rm -rf $CNI_BIN/*.tgz
ls $CNI_BIN

##Certificates

```
ip addr show dev ens160
MASTER_IP=192.168.34.71

cd ~/kube/certs
chmod u+x generate-certs.sh
./generate-certs.sh $MASTER_IP

cd ~/kube/manifest
./generate.py $MASTER_IP --cluster-cidr 10.168.0.0/16

cd ~/kube
./configure-kubectl.sh $MASTER_IP

mkdir ~/kube/kubelet
sudo cp ~/.kube/config ~/kube/kubelet/
```

cd ~/kube
./start-kubelet.sh &
./start-kubeproxy.sh 10.168 &


