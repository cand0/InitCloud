output "vpc_id" {
  value = "${aws_vpc.my_vpc.id}"
}

output "subnet_id" {
  value = "${aws_subnet.my_subnet.id}"
}

output "sg_id" {
  value = "${aws_security_group.test.id}"
}