tekton-playground
===

Install Tekton Pipeline

```
kubectl apply --filename https://storage.googleapis.com/tekton-releases/pipeline/latest/release.yaml
```

Install Tekton Trigger
```
kubectl apply --filename https://storage.googleapis.com/tekton-releases/triggers/latest/release.yaml
```

Install Tekton Dashboard
```
kubectl apply --filename https://github.com/tektoncd/dashboard/releases/download/v0.6.1/tekton-dashboard-release.yaml
```

```
kubectl --namespace tekton-pipelines get pods,svc
kubectl --namespace tekton-pipelines port-forward svc/tekton-dashboard 9097:9097

open "https://localhost:9097"
```
