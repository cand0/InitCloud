#testcode
resource "aws_ec2_serial_console_access" "pass" {
  enabled = true
}

resource "aws_ec2_serial_console_access" "fail1_1" {
  enabled = true
}
resource "aws_ec2_serial_console_access" "fail1_2" {
  enabled = false
}