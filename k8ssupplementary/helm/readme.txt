Install HELM

choco install kubernetes-helm
OR

curl -fsSL -o helm.gz https://get.helm.sh/helm-v3.1.2-linux-amd64.tar.gz

helm repo add stable https://kubernetes-charts.storage.googleapis.com/
helm search repo stable