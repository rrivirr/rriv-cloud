# Management account(s) terraform

## Overview

This small Terraform directory contains the IaC to build two pieces of infra: 
1. the DNS records for the rriv.org domain
2. the Headscale VPN

## First time setup

You will need a secrets file, just as you do with the other accounts. See the example file. Note that for the dev, staging, and prod do_tokens, they should be scoped very narrowly:

- In each environment DO account, go to API -> Personal Access Token -> Generate New Token
- Call it something like `rriv-management-lb-ips` and give it no expiration.
- Add `loadbalancers: Read`
- It will say something like, in order to use these permissions you must add the following other permissions. Click Add and generate the token.
- Copy the token into the management secrets file.
- Do this for each environment.

Why are we doing this? This gives the management account permission to look in each environment and get the IPs of the various loadbalancers, so it can assign DNS to them accordingly.

## Applying changes

This repo should be applied **only after** Helm has been applied (i.e., run `helmfile apply` from the helm directory). The loadbalancers for each environment need to exist in order for this to work. 

It also must be run **after** the prod Keycloak module. The Keycloak module creates an OIDC client id and secret that headscale needs. You will have to copy-pasta these values into your secrets file outside of this repo.
