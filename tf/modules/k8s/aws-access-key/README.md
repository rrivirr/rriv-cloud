# k8s AWS Secret Access Key

**Requirements: `~/.kube/config`**

This module exists to create a sole k8s resource: a secret containing the AWS access key and secret for the Vault IAM user. This is needed in order to seamlessly create the secret without manually intervention, from the Terraform output of the Vault AWS module. No other k8s resources should be created here - they should be managed via Helm.
