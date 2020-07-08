# Pipeline Modify SOP

 - 1 environment: its-tekton-k8s-tw-01(prod Tekton CD)
 - All yamls on master branch is deploying to prod -> master is protected from git push
 - Self-apply: Tekton apply yamls to it's host GKE

1. Modify on new branch, push
2. Open PR & Review
3. Approve -> CD automatically apply to GKE

# More examples

More examples on official [tutorial](https://github.com/tektoncd/pipeline/blob/master/docs/tutorial.md).
