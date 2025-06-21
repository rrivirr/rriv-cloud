# NATS message queue
https://docs.nats.io/running-a-nats-service/nats-kubernetes

TODO: add credentials to jetstream. See [documentation](https://github.com/nats-io/k8s/blob/main/helm/charts/nack/README.md)

### Requirements:
- Install k8s CRDS: `kubectl apply -f crds.yaml`
- Install NATS helm chart with: `helm install nats nats/nats -f values.yaml`
- Might need to create the PVC manually with the pvc.yml file.
- Modify the consumers in jetstream.yaml as desired. For more info: https://github.com/nats-io/k8s/blob/main/helm/charts/nack/README.md

```
# Run nats-box that includes the NATS management utilities.
kubectl exec -it deploy/nats-box -- /bin/sh -l

# Publish a couple of messages
$ nats req orders.received "order 1"
$ nats req orders.received "order 2"

# Pull first message.
$ nats consumer next mystream my-pull-consumer

# Subscribe to the message stream:
$ nats sub my-push-consumer.orders
```