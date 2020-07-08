Deploy Tekton
===

# Create Kubernetes Cluster

Current version sets need kubernetes version ~= v1.15.9. Check [terraform](terraform) for more information.

Miscs:
- Integrate Rancher
- Integrate Rancher Prometheus

---

# Install Tekton

Install Tekton Pipeline

```
PIPELINE_VERSION=v0.12.0
TRIGGER_VERSION=v0.4.0
DASHBOARD_VERSION=v0.6.0

wget -O deploy/pipeline.yaml https://storage.googleapis.com/tekton-releases/pipeline/previous/$PIPELINE_VERSION/release.yaml
wget -O deploy/triggers.yaml https://storage.googleapis.com/tekton-releases/triggers/previous/$TRIGGER_VERSION/release.yaml
wget -O deploy/dashboard.yaml https://storage.googleapis.com/tekton-releases/dashboard/previous/$DASHBOARD_VERSION/tekton-dashboard-release.yaml
```

Review yamls and apply in order.

```
kubectl apply --filename deploy/pipeline.yaml
kubectl apply --filename deploy/triggers.yaml
kubectl apply --filename deploy/dashboard.yaml
```

Check deployments & test connect

```
kubectl --namespace tekton-pipelines get pods,svc
kubectl --namespace tekton-pipelines port-forward svc/tekton-dashboard 9097:9097

open "https://localhost:9097"
```

---

# Expose service through ingress

Choose one of available ingress controllers.

### Traefik

```
helm repo add traefik https://containous.github.io/traefik-helm-chart
helm repo update
helm --namespace tekton-pipelines install --values deploy/traefik-values.yaml traefik traefik/traefik

kubectl apply --filename deploy/traefik-ingress.yaml
```

### Nginx Ingress Controller

```
helm repo add nginx-stable https://helm.nginx.com/stable
helm repo update
helm install --namespace tekton-pipelines nginx nginx-stable/nginx-ingress

kubectl apply -f deploy/traefik-ingress-route.yaml

open 'http://tekton.chechia.net/'
```

---

# Trouble Shooting

### Master webhook timeout to Private Cluster

Get following error message when apply tekton/crd:

```
Error from server (InternalError): error when creating "catalog/clone-cat/task-git-clone.yaml": Internal error occurred: failed calling webhook "webhook.pipeline.tekton.dev": Post https://tekton-pipelines-webhook.tekton-pipelines.svc:443/defaulting?timeout=30s: net/http: request canceled while waiting for connection (Client.Timeout exceeded while awaiting headers)
```

[Issue from StackOverflow](https://stackoverflow.com/questions/59461747/tekton-on-private-kubernetes-cluster-on-gcp-gke)

Solotion: Add firewall rule

```
name: its-tekton-k8s-allow-master
source: Master address range 192.168.1.0/28
target: Network tags(Inastance Template) gke-its-tekton-k8s-tw-01-cc57ce55-node
port: 8443
```

Potential issue: crd applying still work even after the added firewall is removed. Magic!
