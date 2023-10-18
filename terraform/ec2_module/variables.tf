variable "vpc_id" {
  description = "VPC ID from the vpc module"
}
variable "subnets" {
  description = "Subnet IDs from the vpc module"
  type        = list(string)
}
