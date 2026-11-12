if [ -z "$1" ]; then
    echo "Error: \$1 must be an env (dev, staging, prod)" >&2
    exit 1
fi

ENV=$1
kubectl config use-context do-sfo2-rriv-$ENV
kubectl port-forward svc/rriv-openfga 8080:8080 8081:8081
