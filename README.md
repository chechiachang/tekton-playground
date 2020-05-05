tekton-playground
===

# Install

### Create Kubernetes Cluster

Current version sets need kubernetes version >= v1.17.0 (ex. current rapid release channel: 1.17.4-gke.10).

```
kind create cluster

terrform plan
```

### Install Tekton

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

### Install Tekton Cli to local

tkn

### Install Nginx Ingress Controller

```
helm repo add nginx-stable https://helm.nginx.com/stable
helm update
helm install --namespace tekton-pipelines nginx nginx-stable/nginx-ingress

kubectl apply -f ingress.yaml
```

# Use Tekton

[Tutorial](https://github.com/tektoncd/pipeline/blob/master/docs/tutorial.md)

### Define Hello World Task

```
kubectl apply -f hello-world/task.yaml
tkn task list
tkn task describe echo-hello-world
```

Instantiate Task using a TaskRun

```
kubectl apply -f hello-world/task-run.yaml
tkn taskrun list
tkn taskrun describe echo-hello-world-task-run
```

A TaskRun Pod is Completed
```
kubectl get po
```

Note: task / taskRun can be instantiated in default namespace

### Define Git Task

```
kubectl apply -f build-from-git/pipeline-resource-github.yaml
kubectl apply -f build-from-git/pipeline-resource-image.yaml
kubectl apply -f build-from-git/task-build-docker-image.yaml

kubectl create secret generic regcred \
    --from-file=.dockerconfigjson=/Users/david/.docker/config.json \
    --type=kubernetes.io/dockerconfigjson
```
