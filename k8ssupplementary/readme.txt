Deploying and using kubeless, the Kubernetes Native serverless framework.

With Kubeless you can deploy functions without the need to build containers. These functions can be called via regular HTTP(S) calls or triggered by events submitted to message brokers like Kafka.

Kubeless aims to be an open source FaaS solution to clone the functionalities of AWS Lamdba/Goole Cloud Functions.



kubectl create -f https://github.com/kubeless/kubeless/releases/download/v1.0.0-alpha.8/kubeless-v1.0.0-alpha.8.yaml
