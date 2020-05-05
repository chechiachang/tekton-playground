tekton-playground
===

# Create Kubernetes Cluster

Current version sets need kubernetes version >= v1.17.0 (ex. current rapid release channel: 1.17.4-gke.10).

```
kind create cluster

terrform plan
```

# Install Tekton

Install Tekton Pipeline

```
PIPELINE_VERSION=v0.12.0

kubectl apply --filename https://storage.googleapis.com/tekton-releases/pipeline/previous/$PIPELINE_VERSION/release.yaml

TRIGGER_VERSION=v0.4.0

kubectl apply --filename https://storage.googleapis.com/tekton-releases/triggers/previous/$TRIGGER_VERSION/release.yaml

DASHBOARD_VERSION=v0.6.0

kubectl apply --filename https://storage.googleapis.com/tekton-releases/dashboard/previous/$DASHBOARD_VERSION/tekton-dashboard-release.yaml
```

```
kubectl --namespace tekton-pipelines get pods,svc
kubectl --namespace tekton-pipelines port-forward svc/tekton-dashboard 9097:9097

open "https://localhost:9097"
```

### Install Traefik

```
helm repo add nginx-stable https://helm.nginx.com/stable
helm update
helm install --namespace tekton-pipelines nginx nginx-stable/nginx-ingress

kubectl apply -f ingress.yaml
```
