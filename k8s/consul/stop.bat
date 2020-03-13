@echo off
kubectl delete svc consul-server-bootstrap
kubectl delete svc consul-server-http
kubectl delete deployment consul-server-bootstrap
kubectl delete deployment consul-server-1 consul-server-2 consul-server-3
kubectl delete deployment consul-agent-1 consul-agent-2 consul-agent-3