resource "ncloud_launch_configuration" "lc" {
  name = "testcand1"
  server_image_product_code = "SW.VSVR.OS.LNX64.CNTOS.0703.B050"
  server_product_code = "SVR.VSVR.HICPU.C002.M004.NET.SSD.B050.G002"
}

resource "ncloud_subnet" "cand1" {
  vpc_no             = "29455"
  subnet             = "10.0.0.0/24"
  zone               = "KR-2"
  network_acl_no     = "45753"
  subnet_type        = "PUBLIC"
  usage_type         = "GEN"
}


#testcode
resource "ncloud_auto_scaling_group" "fail" {
  access_control_group_no_list = ["75570"]
  subnet_no = ncloud_subnet.cand1.subnet_no
  launch_configuration_no = ncloud_launch_configuration.lc.launch_configuration_no
  min_size = 0
  max_size = 3
  server_name_prefix = "test"
  desired_capacity = "0"
}

resource "ncloud_auto_scaling_group" "pass" {
  access_control_group_no_list = ["75570"]
  subnet_no = ncloud_subnet.cand1.subnet_no
  launch_configuration_no = ncloud_launch_configuration.lc.launch_configuration_no
  min_size = 1
  max_size = 3
  server_name_prefix = "test"
  desired_capacity = "1"
}


