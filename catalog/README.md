Tekton Pipeline Resource
===

# How to Use (SOP)

1. Admin (DevOps) apply generic / reusable resources for entire kubernetes namespace
  - Tasks
  - Pipeline Templates
  - EventTriggers & webhook routing
2. User (Dev) create project specific resources for each project
  - Git resources (alpha)
  - Credentials
  - TaskRuns & PipelineRuns
3. Config webhook from Gitlab server to trigger

---

# User

Dry run before apply
```
make dry-run
```

Apply / Update project resources (ex. Gitlab, Registry)
```
kubectl -n tekton-pipelines apply -f tekton-resources.yaml
```
Apply / Update pipeline
```
kubectl -n tekton-pipelines apply -f pipelines/
```

Create taskruns / pipelineruns & watch
```
kubectl -n tekton-pipelines create -f tekton-pipelinerun-cat-readme.yaml
kubectl -n tekton-pipelines create -f tekton-taskrun-git-clone.yaml

watch tkn -n tekton-pipelines pipelinerun list
watch tkn -n tekton-pipelines taskrun list
```

---

# Admin

Tasks are working units of pipeline.

```
kubectl -n tekton-pipelines apply -f tasks/
```

Add `eventTriggers` to accept webhooks from external services (ex. Gitlab webhook).

```
kubectl -n tekton-pipelines apply -f triggers/role-resources/

# Add more gitlab project by edit gitlab-push-listener.yaml
kubectl -n tekton-pipelines apply -f triggers/gitlab-push-listener.yaml

kubectl -n tekton-pipelines get pods,svc | grep gitlab-listener
```

# Credentials

### [GCP ServiceAccount credential](https://cloud.google.com/kubernetes-engine/docs/tutorials/authenticating-to-cloud-platform)

```
NAMESPACE=tekton-pipelines
SECRET_NAME=gcp-credentials
GCP_CREDENTIAL_JSON_FILE=path/to/my/credential.json

kubectl --namespace ${NAMESPACE} \
  create secret generic ${SECRET_NAME} \
  --from-file=${GCP_CREDENTIAL_JSON_FILE}
```

### Gitlab Access Token

```
ACCESS_TOKEN_BASE64=

cat <<EOF | kubectl apply -f -
apiVersion: v1
kind: Secret
metadata:
  name: gitlab-access-token
  namespace: tekton-pipelines
type: Opaque
data:
  access-token: ${ACCESS_TOKEN_BASE64}
EOF
```
