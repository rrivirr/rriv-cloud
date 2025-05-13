# RRIV Cloud
#### *Kubernetes infrastructure for RRIV's IoT cloud*

RRIV cloud is set up to use Digital Ocean for its Chripstack servers. Its db is a Postgres managed db, also in DO. There are 2 k8s clusters for the environment - one for the project, and one for the Vault secrets.

## Authenticating into DigitalOcean
The first time you authenticate, you will need to set up DigitalOcean's CLI, `doctl`. See DO's documentation for using the package manager of your choice.

Log in to DO on the web. Go to the [API tokens page](https://cloud.digitalocean.com/account/api/tokens) and create a new Personal Access Token. Give it an expiration of 90 days (for security purposes, we don't want to create forever tokens). **Save** the PAT in your personal Proton Pass vault.

With the PAT copied, run `doctl auth init --context rriv-dev` (if you are on the dev environment). Paste in the token.

Now run: `doctl kubernetes cluster list`. You should see the rriv-dev cluster and the vault-dev clusters.
`doctl kubernetes cluster kubeconfig save rriv-dev` (and do the same for the vault cluster if you are going to be working on it at all)


You should now be able to run `kubectl get no` and see the DO droplets.

## Chirpstack k8s
The k8s files were generated from [this](https://github.com/chirpstack/chirpstack-docker) chirpstack-docker project.

## Vault
Hashicorp Vault is installed in a separate k8s cluster. To switch over:
```
kubectl config get-contexts
kubectl config use-context <vault-context-name>
```
This should update the current cluster to be the one containing Vault.


### Details

Vault was installed with a helm chart: 
```
helm install vault hashicorp/vault \
  --namespace vault \
  -f vault/dev-install-values.yaml
```
The Vault agent injects secrets into pods that are specified via annotations. For an example of this, look at the Chirpstack deployment file. Secrets are injected into `/vault/secrets/credentials`, then used by the container. This centralizes secrets across cloud resources and keeps them out of plaintext k8s.

The secrets needed by Chirpstack are:
```
POSTGRES_CONN_STRING        # Chirpstack's database connection string
PG_INTEGRATION_CONN_STRING  # The TimescaleDB database that Chirpstack pipes data into
```

## Metrics Server
Installed with: `kubectl apply -f https://github.com/kubernetes-sigs/metrics-server/releases/latest/download/components.yaml`


## Queue
See README in queue directory.

## Keycloak