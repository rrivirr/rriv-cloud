## Set up TLS

Install external secrets CRDs:
`kubectl apply -f https://raw.githubusercontent.com/external-secrets/external-secrets/main/deploy/crds/bundle.yaml`


Create a DigitalOcean API key via:
```
kubectl create secret generic dev-digitalocean-api-key \
  --from-literal=api-token=<YOUR_DIGITALOCEAN_API_TOKEN> \
  -n cert-manager
```
(To generate the token, log in to DO and generate a new Personal Access Token if you haven't already)