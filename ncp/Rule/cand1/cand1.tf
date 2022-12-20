resource "ncloud_vpc" "vpc" {
  ipv4_cidr_block = "10.1.0.0/16"
}

resource "ncloud_access_control_group" "acg" {
  vpc_no      = ncloud_vpc.vpc.id
  name        = "cand1"
  description = "test"
}

#fail
resource "ncloud_access_control_group_rule" "fail1_1" {
  access_control_group_no = ncloud_access_control_group.acg.id
  inbound {
    protocol    = "TCP"
    ip_block    = "0.0.0.0/0"
    port_range  = "22"
    description = "accept 22 port"
  }
}

resource "ncloud_access_control_group_rule" "fail1_2" {
  access_control_group_no = ncloud_access_control_group.acg.id
  inbound {
    protocol    = "TCP"
    ip_block    = "0.0.0.0/0"
    port_range  = "80"
    description = "accept 80 port"
  }
}

#pass
resource "ncloud_access_control_group_rule" "fail1_2" {
  access_control_group_no = ncloud_access_control_group.acg.id
  inbound {
    protocol    = "TCP"
    ip_block    = "0.0.0.0/0"
    port_range  = "22"
    description = "accept 22 port"
  }
  inbound {
    protocol    = "TCP"
    ip_block    = "0.0.0.0/0"
    port_range  = "80"
    description = "accept 80 port"
  }
}