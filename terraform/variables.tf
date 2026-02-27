variable "aws_region" {
  description = "AWS region to deploy into"
  type        = string
}

variable "project_name" {
  description = "Project name prefix for tagging/naming"
  type        = string
}

variable "ssh_allowed_cidr" {
  description = "CIDR allowed to SSH in (strictly your IP/32)"
  type        = string
}

variable "vpc_cidr" {
  description = "VPC CIDR"
  type        = string
  default     = "10.10.0.0/16"
}

variable "public_subnet_cidr" {
  description = "Public subnet CIDR"
  type        = string
  default     = "10.10.10.0/24"
}

variable "instance_type" {
  description = "EC2 instance type (Free Tier mindset: t3.micro)"
  type        = string
  default     = "t3.micro"
}

variable "root_volume_gb" {
  description = "Root EBS volume size in GB (keep small for Free Tier)"
  type        = number
  default     = 16
}
