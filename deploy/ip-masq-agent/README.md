IP Masquerage Agent
===

# Why we need this

Tekton CD requires access to gitlab. But the CIDR for pods are not permitted by firewall. Use ip-masq-agent to masquerade source ip from pod ip to node ip will allow access to gitlab in private network.

```
kubectl create configmap ip-masq-agent \
  --from-file config \
  --namespace kube-system

kubectl apply -f ip-masq-agent.yaml
```
