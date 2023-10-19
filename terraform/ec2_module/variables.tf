variable "vpc_id" {
  description = "VPC ID"
  type        = string
  default     = "vpc-01149a8229ad5a78f" # Replace with your VPC ID or leave it as a placeholder
}

variable "subnets" {
  description = "List of Subnet IDs"
  type        = list(string)
  default     = ["subnet-0307c7e5fb79dbd97"] # Replace with your subnet IDs or leave them as placeholders
}