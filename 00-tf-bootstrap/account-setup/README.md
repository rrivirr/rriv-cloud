# Terraform AWS Account Bootstrapping

This directory serves to set up the three AWS accounts for our dev, staging, and prod environments. It was set up in the following way:

1. Log into AWS management account with SSO and copy the access tokens. Export them into your terminal.
2. `cd 00-tf-bootstrap/account-setup`
3. 
  ```
  # Note that these do *not* use the 'tf' alias, that you will create later if you haven't
  terraform init --backend-config=backend.hcl
  terraform apply
  ```

