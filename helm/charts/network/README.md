## Set up TLS

Install external secrets CRDs:
`kubectl apply -f https://raw.githubusercontent.com/external-secrets/external-secrets/main/deploy/crds/bundle.yaml`


Create a DigitalOcean API key by logging in to DO and generate a new Personal Access Token if you haven't already. Use this for the <env>-digitalocean-api-key variable.