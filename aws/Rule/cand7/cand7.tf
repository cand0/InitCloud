resource "aws_iam_server_certificate" "fail" {
  name             = "some_test_cert"
  certificate_body = file("ca-cert.pem")
  private_key      = <<EOF
-----BEGIN PRIVATE KEY-----
MIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQDZgB1F5MN2lyJp
p0AQh802bHZ6h5n1lDal61U4Kl2HB7Veo5cKg+2DQG6S7cbJrxJxnEBSjW/HmLuT
...

-----END PRIVATE KEY-----
EOF
}

resource "aws_iam_server_certificate" "pass" {
  name             = "some_test_cert"
  certificate_body = file("ca-cert.pem")
  private_key      = file("ca-key.pem")
}