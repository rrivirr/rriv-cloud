# RRIV Cloud
#### *Kubernetes infrastructure for RRIV's IoT cloud*

RRIV cloud is set up to use Digital Ocean for its Chripstack servers. Its db is a Postgres managed db, also in DO.

## k8s
The k8s files were generated from [this](https://github.com/chirpstack/chirpstack-docker) chirpstack-docker project.

## Vault
Hashicorp Vault is installed in a separate k8s cluster. To switch over:
```
kubectl config get-contexts
kubectl config use-context <vault-context-name>
```
This should update the current cluster to be the one containing Vault.

Vault was installed with a helm chart: 
```
helm install vault hashicorp/vault \
  --namespace vault \
  -f vault/dev-install-values.yaml
```
The Vault agent injects secrets into pods that are specified via annotations. For an example of this, look at the Chirpstack deployment file. Secrets are injected into `/vault/secrets/credentials`, then used by the container. This centralizes secrets across cloud resources and keeps them out of plaintext k8s.

The secrets needed by Chirpstack are:
```
POSTGRES_CONN_STRING # Chirpstack's database connection string
PG_INTEGRATION_CONN_STRING # The TimescaleDB database that Chirpstack pipes data into
```

## Metrics Server
Installed with: `kubectl apply -f https://github.com/kubernetes-sigs/metrics-server/releases/latest/download/components.yaml`


## Queue
See README in queue directory.

## Keycloak