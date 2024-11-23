# RRIV Cloud
*Kubernetes infrastructure for RRIV's IoT cloud*
RRIV cloud is set up to use Digital Ocean for its Chripstack servers. Its db is a Postgres managed db, also in DO.

## k8s
The k8s files were generated from [this](https://github.com/chirpstack/chirpstack-docker) chirpstack-docker project.

The ingress controller uses nginx and was installed with this helm repo: https://github.com/kubernetes/ingress-nginx
 
```
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v1.12.0-beta.0/deploy/static/provider/cloud/deploy.yaml
```
This creates an `ingress-nginx` namespace where the controller resources live.

## Vault
Vault was created with a helm chart. 
```
helm install vault hashicorp/vault \
  --namespace vault \
  -f vault/override-values.yaml
```

## Postgres
To connect directly, kubectl into the postgres pod, and connect with:
```
psql 



## Metrics Server
Installed with: `kubectl apply -f https://github.com/kubernetes-sigs/metrics-server/releases/latest/download/components.yaml`