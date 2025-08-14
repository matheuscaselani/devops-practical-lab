variable "num_instances" {
  description = "Number of instances to create"
  type        = number
  default     = 1
}

variable "region" {
  description = "The GCP grgion desired to create resources"
  type        = string
}

variable "project_id" {
  description = "The GCP Project ID"
  type        = string
  default     = "fabled-mystery-468920-d0"
}

variable "nat_ip" {
  description = "Public ip address"
  default     = null
}

variable "network_tier" {
  description = "Network network_tier"
  default     = "PREMIUM"
}

variable "service_account" {
  default = null
  type = object({
    email  = string,
    scopes = set(string)
  })
  description = "Service account to attach to the instance. See https://www.terraform.io/docs/providers/google/r/compute_instance_template#service_account."
}

variable "subnetwork" {
  description = "The name of the subnetwork create this instance in."
  default     = ""
}

variable "tags" {
  type        = list(string)
  description = "Network tags, provided as a list"
  default     = ["http", "ssh"]
}

variable "allowed_ssh_cidr" {
  description = "CIDR allowed to SSH into"
  type        = list(string)
  default     = []
  validation {
    condition     = alltrue([for c in var.allowed_ssh_cidr : can(cidrnetmask(c))])
    error_message = "must be a valid CIDR."
  }
}