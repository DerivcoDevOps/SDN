#Kubernetes Master From Scratch

Guidelines for Centos version 7.4 and kubernetes version 1.9.3

##How to
- Disable firewall by execute `systemctl disable firewalld`
- Execute start-cluster-part1.sh
- add path
- Execute start-cluster-part2.sh with parameters `./start-cluster-part2.sh 10.168 192.168.34.71`
- Execute below

```
cd ~/kube
./start-kubelet.sh 
./start-kubeproxy.sh 10.168 
```
