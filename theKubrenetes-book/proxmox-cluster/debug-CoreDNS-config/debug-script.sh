#!/bin/bash

echo "=== Checking CoreDNS pods ==="
kubectl get pods -n kube-system -l k8s-app=kube-dns

echo -e "\n=== Checking CoreDNS service ==="
kubectl get svc -n kube-system kube-dns

echo -e "\n=== Testing DNS resolution ==="
kubectl run -it --rm debug --image=busybox --restart=Never -- nslookup kubernetes.default.svc.cluster.local

echo -e "\n=== Checking kubelet DNS settings on nodes ==="
kubectl get nodes -o wide

echo -e "\n=== Checking if there are any network policies blocking traffic ==="
kubectl get networkpolicies --all-namespaces

echo -e "\n=== Checking Calico status ==="
kubectl get pods -n kube-system -l k8s-app=calico-node

echo -e "\n=== CoreDNS logs (last 20 lines) ==="
kubectl logs -n kube-system -l k8s-app=kube-dns --tail=20
