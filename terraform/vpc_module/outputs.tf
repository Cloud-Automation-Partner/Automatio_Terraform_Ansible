output "vpc_id" {
  value = aws_vpc.terraform_vpc.id
}
output "subnets" {
  value = aws_subnet.subnets[*].id
}
