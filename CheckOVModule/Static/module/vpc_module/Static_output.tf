output "vpc_id" {
    value = aws_vpc.vpc_cand1.id
}

output "private_subnet_cand1_id" {
    value = aws_subnet.subnet_cand1.id
}
