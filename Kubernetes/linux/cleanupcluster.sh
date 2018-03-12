#!/bin/bash
KUBEPATH="$HOME/kube"
sudo pkill hyperkube
docker ps -a  |  awk '{print $1}' | xargs --no-run-if-empty docker rm -f
sudo rm -rf $KUBEPATH/etcd/datakube
sudo rm -rf $KUBEPATH/log/*
sudo rm -rf ~/.kube
sudorm -rf kube/certs/*.pem
sudorm -rf kube/certs/*.csr
sudorm -rf kube/certs/*.cnf
sudorm -rf kube/certs/*.srl

