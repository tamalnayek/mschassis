Weave Scope lets you monitor and control your containerized microservices applications. By providing a visual map of your Docker Containers, you can see the dependencies and communication links between them.

Scope automatically detects processes, containers, hosts. No kernel modules, no agents, no special libraries, no coding.

curl -L https://cloud.weave.works/launch/k8s/weavescope.yaml

kubectl create -f 'https://cloud.weave.works/launch/k8s/weavescope.yaml'

kubectl port-forward deployment/weave-scope-app 4040:4040 -n weave