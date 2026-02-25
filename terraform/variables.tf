variable "aws_region" {
  description = "AWS region to deploy into"
  type        = string
  default     = "eu-central-1"
}

variable "project_name" {
  description = "Project name used for tagging and naming"
  type        = string
  default     = "k8s-platform"
}

variable "ssh_allowed_cidr" {
  description = "CIDR allowed to SSH (you will set this tomorrow to your public IP/32)"
  type        = string
  default     = "0.0.0.0/32"
}
