# Desafio 01: Infrastructure-as-code - Terraform

## Requirements

  * Active GCP Account 
  * Configured Service Account with desired roles ( Least Privilege Concept )
  * Enable Compute Engine API and IAM API
  * Export GOOGLE_APPLICATION_CREDENTIALS pointing to Service Account Json File

---

## Terraform Design Pattern

  * File Structure design by Environment

## Input Vars

project_region | type string | Specify which region to create the project

external_ip | type list(string) | IP or IP range allowed to conect via SSH

## Terraform Execution Command

```terraform
terraform plan --chdir=envs/production -var='region=<REGION>' -var='allowed_ssh_cidr=["IP_ADDRESS_OR_RANGE_CIDR"]'
```

## Expected Output

```Bash
Outputs:

vm_external_ip = "public_ip"
```