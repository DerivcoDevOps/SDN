#/bin/bash
KUBEPATH="$HOME/kube"
KUBECONFIG="$HOME/.kube/config"
KUBEMANIFEST="$KUBEPATH/manifest"
LOG="$KUBEPATH/kubelet.log"

swapoff -a
setenforce 0 && sed -i --follow-symlinks 's/SELINUX=enforcing/SELINUX=disabled/g' /etc/sysconfig/selinux

./bin/hyperkube kubelet --kubeconfig=$KUBECONFIG \
    --pod-infra-container-image=gcrio.azureedge.net/google_containers/pause-amd64:3.0 \
    --address=0.0.0.0 --allow-privileged=true --enable-server \
    --enable-debugging-handlers \
    --pod-manifest-path=$KUBEMANIFEST \
    --cluster-dns=11.0.0.10 --cluster-domain=cluster.local \
    --node-labels=role=master \
    --hairpin-mode=promiscuous-bridge \
    --container-runtime=docker --v=6 \
    --fail-swap-on=false \
    --network-plugin=kubenet \
    --cgroup-driver=systemd \
    --runtime-cgroups=/systemd/system.slice \
    --kubelet-cgroups=/systemd/system.slice> $LOG 2>&1 &
