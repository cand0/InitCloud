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

resource "ncloud_auto_scaling_group" "auto" {
  access_control_group_no_list = ["75570"]
  subnet_no = ncloud_subnet.cand1.subnet_no
  launch_configuration_no = ncloud_launch_configuration.lc.launch_configuration_no
  min_size = 1
  max_size = 1
  server_name_prefix = "test"
}



resource "ncloud_auto_scaling_policy" "fail1_1" {
  adjustment_type_code  = "CHANG"
  auto_scaling_group_no = "${ncloud_auto_scaling_group.auto.id}"
  name                  = "cand1"
  scaling_adjustment    = 0
}
resource "ncloud_auto_scaling_policy" "fail1_2" {
  adjustment_type_code  = "EXACT"
  auto_scaling_group_no = "${ncloud_auto_scaling_group.auto.id}"
  name                  = "cand1"
  scaling_adjustment    = 0
}

resource "ncloud_auto_scaling_policy" "pass1_1" {
  adjustment_type_code  = "CHANG"
  auto_scaling_group_no = "${ncloud_auto_scaling_group.auto.id}"
  name                  = "cand1"
  scaling_adjustment    = 0
}
resource "ncloud_auto_scaling_policy" "pass1_2" {
  adjustment_type_code  = "EXACT"
  auto_scaling_group_no = "${ncloud_auto_scaling_group.auto.id}"
  name                  = "cand2"
  scaling_adjustment    = 0
}
