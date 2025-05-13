## Set up TLS

1. Install Ingress Controller:
helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
helm install ingress-nginx ingress-nginx/ingress-nginx -n default --set controller.publishService.enabled=true

2. Install Cert Manager:
kubectl apply -f https://github.com/cert-manager/cert-manager/releases/download/v1.8.0/cert-manager.crds.yaml

3. Apply all the resources in the `network` directory

4. Create a DigitalOcean API key via:
```
kubectl create secret generic digitalocean-api-key \
  --from-literal=api-token=<YOUR_DIGITALOCEAN_API_TOKEN> \
  -n cert-manager
```
(To generate the token, log in to DO and generate a new Personal Access Token if you haven't already)