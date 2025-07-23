# k8s AWS Secret Access Key

**Requirements: `~/.kube/config`**

This module exists to create several k8s resources in the Vault cluster:
1. two secrets containing the AWS access key and secret for the Vault IAM user
2. the Vault root seal key, created in KMS
3. the CA from Let's Encrypt
4. a JWT that is issued to kubernetes so it can use Vault

 These are needed in order to seamlessly create the secrets without manually intervention, from the Terraform outputs of the Vault AWS module. No other k8s resources should be created here - they should be managed via Helm.
