@echo off
kubectl apply -f consul-svc-k8s.yaml
kubectl apply -f consul-dep-bs-k8s.yaml
kubectl apply -f consul-dep-agent-k8s.yaml
kubectl apply -f consul-dep-server-k8s.yaml
