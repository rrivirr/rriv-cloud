## Set up TLS

Install external secrets CRDs:
`kubectl apply -f https://raw.githubusercontent.com/external-secrets/external-secrets/main/deploy/crds/bundle.yaml`


Create a DigitalOcean API key for the certs by logging in to the DO **management account** and generating a new Personal Access Token scoped to `domains` update, create, and delete permissions. Give it `expires: never`. Use this for the <env>-digitalocean-dns-api-key variable in your secrets tfvars file that is outside of this repo.