Tekton CD
===

# Docs & SOPs for admins

This document describe basic usage / SOP to use CI/CD on Tekton CD. For more information about pipeline maintainence, check advanced documents:

- [Pipeline Admin Doc](pipeline-admin.md) for those who maitain CI/CD pipeline on Tekton CD (Devs / project leader)
- [Tekton Deploy Doc](deploy) for those who maitain Tekton CD & GKE cluster (Devops / SRE)

# Use Tekton cli

[Install Guide](https://github.com/tektoncd/cli#installing-tkn)

Fetch context from GKE, its-tekton-k8s-tw-01

```
gcloud container clusters get-credentials its-tekton-k8s-tw-01 --zone asia-east1
```

Watch pipeline

```
watch tkn -n tekton-pipelines pipelinerun list
watch tkn -n tekton-pipelines taskrun list
```

Show log

```
tkn -n tekton-pipelines pipelines logs -f
tkn -n tekton-pipelines taskrun logs
```

# Trigger / Rerun pipeline

ex. trigger tekton-playground
```
vim catalog/tekton-playground-pipelinerun.yaml

kubectl apply -f catalog/tekton-playground-pipelinerun.yaml
```

# Dashboard GUI

View / Stop pipeline with GUI.

[tekton.chechia.net](http://tekton.chechia.net/#/pipelineruns)

### Known Issues

Don't rerun pipelineruns from Dashboard. This will fail due to insufficient privillege to create workspace. see [issue #1420](https://github.com/tektoncd/dashboard/issues/1420)
