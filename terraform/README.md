# Desafio 01: Infrastructure-as-code - Terraform

## Requirements

  * Active GCP Account 
  * Configured Service Account with desired roles ( Least Privilege Concept )
  * Enable Compute Engine API and IAM API
  * Export GOOGLE_APPLICATION_CREDENTIALS pointing to Service Account Json File

---

## Terraform Design Pattern

  * File Structure design by Environment

## Modules Used in the Project

| Module Name                             | Official Page                                                                                                                        | Utility                                            |
| --------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------ | --------------------------------------------------                     |
| terraform-google-modules/vm             | [Terraform Registry - Google Module - VM](https://registry.terraform.io/modules/terraform-google-modules/vm/google/latest)           | Used to create vm_template and compute_instance on the GCP                     |
| terraform-google-modules/network/google | [Terraform Registry - Google Module - Network](https://registry.terraform.io/modules/terraform-google-modules/network/google/latest) | Used to create a new VPC, Subnetwork, Ephemeral IP and configure ingress rules |


## Input Vars

| Variable Name    | Type                                 | Example                                                              | Description                                               | Location                                   |
| ---------------- | ------------------------------------ | -------------------------------------------------------------------- | --------------------------------------------------------- | ------------------------------ |
| region           | string                               | us-east1                                                             | Select Region to deploy VM host                                  | runtime via -var or -var-file              |
| allowed_ssh_cidr | list(string)                         | ["0.0.0.0.0/0"]                                                      | Valid CIDR IP or Range allowed to connect into SSH                   | runtime via -var or -var-file              |
| project_id       | string                               | fabled-mystery-468920-d0                                             | Select Region to deploy VM host                                  | *auto.tfvars / variables ( default value ) |
| nat_ip           | --                                   | leave blank for ephemeral IP                                         |  Public IP to connect with internet                                  | left empty                                 |
| tags             | list(string)                         | ["http", "ssh"]                                                      | selected tags to link vm instance                                  | *auto.tfvars / variables ( default value ) |
| service_account  | object{ email=string, scope=string } | service_account_name, https://www.googleapis.com/auth/cloud-platform | service_account to link vm instance                       | *auto.tfvars / variables ( default value ) |
| num_instances    | number                               | 1, 3, 5                                                              | Number of VM instances to deploy                                       | *auto.tfvars / variables ( default value ) |

## Terraform Runtime Commands

```Bash
# Point out Service Account Json File - gcloud auth can also be used as an alternative
export GOOGLE_APPLICATION_CREDENTIALS=<path_to_json_file>

# Sync Modules - Prepare terraform environment
terraform -chdir=./envs/production init

# Check orchestration deployment with Terraform Plan 
terraform -chdir=./envs/production plan -var='region=<REGION>' -var='allowed_ssh_cidr=["IP_ADDRESS_OR_RANGE_CIDR"]'

# Apply terraform if everything is according to Plan
terraform -chdir=./envs/production apply -var='region=<REGION>' -var='allowed_ssh_cidr=["IP_ADDRESS_OR_RANGE_CIDR"]'
```

## Expected Output

| Variable       | Expected stdout |
| -------------- | --------------- |
| vm_external_ip | 0.0.0.0         |

