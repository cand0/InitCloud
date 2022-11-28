output "vpc_id" {
    value = aws_vpc.vpc_cand1.id
}
output "vpc_cidr" {
    value = "${aws_vpc.vpc_cand1.cidr_block}"
}