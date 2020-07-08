SHELL := /bin/bash

check:
	kubectl config use-context gke_dabenxiang226_asia-east1_its-tekton-k8s-tw-01

diff-dry-run:
	 cd ..; git --no-pager diff --name-only HEAD master | grep '.yaml' | xargs kubectl apply --server-dry-run -f

dry-run: check
	declare -a dirs=($$(find . -maxdepth 1 -type d -not -path '.' -not -path './resources(alpha)')); \
	echo "$${dirs[@]}"; \
	for dir in "$${dirs[@]}"; do kubectl apply --server-dry-run --filename $${dir}; done

apply: check
	declare -a dirs=($$(find . -maxdepth 1 -type d -not -path '.' -not -path './resources(alpha)')); \
	echo "$${dirs[@]}"; \
	for dir in "$${dirs[@]}"; do kubectl apply --filename $${dir}; done
