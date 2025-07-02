# k8s AWS Secret Access Key

**Requirements: `~/.kube/config`**

This module exists to create two k8s resources:
1. a secret containing the AWS access key and secret for the Vault IAM user.
2. the Vault root seal key, created in KMS

 These are needed in order to seamlessly create the secrets without manually intervention, from the Terraform outputs of the Vault AWS module. No other k8s resources should be created here - they should be managed via Helm.
