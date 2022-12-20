
resource "ncloud_network_acl" "cand1" {
  vpc_no = "29455"
  name = "cand2"
}

#testcode1 same priority
resource "ncloud_network_acl_rule" "fail1_1" {
  network_acl_no = "${ncloud_network_acl.cand1.id}"

  inbound {
    priority    = 100
    protocol    = "TCP"
    rule_action = "ALLOW"
    ip_block    = "0.0.0.0/0"
    port_range  = "22"
  }
}

resource "ncloud_network_acl_rule" "fail1_2" {
  network_acl_no = "${ncloud_network_acl.cand1.id}"

  inbound {
    priority    = 100
    protocol    = "TCP"
    rule_action = "DROP"
    ip_block    = "1.1.1.1/32"
    port_range  = "22"
  }
}

#testcode2 different priority
resource "ncloud_network_acl_rule" "fail2_1" {
  network_acl_no = "${ncloud_network_acl.cand1.id}"

  inbound {
    priority    = 100
    protocol    = "TCP"
    rule_action = "ALLOW"
    ip_block    = "0.0.0.0/0"
    port_range  = "22"
  }
}

resource "ncloud_network_acl_rule" "fail2_2" {
  network_acl_no = "${ncloud_network_acl.cand1.id}"

  inbound {
    priority    = 101
    protocol    = "TCP"
    rule_action = "DROP"
    ip_block    = "1.1.1.1/32"
    port_range  = "25"
  }
}

#pass
resource "ncloud_network_acl_rule" "pass" {
  network_acl_no = "${ncloud_network_acl.cand1.id}"

  inbound {
    priority    = 100
    protocol    = "TCP"
    rule_action = "ALLOW"
    ip_block    = "0.0.0.0/0"
    port_range  = "22"
  }
  inbound {
    priority    = 101
    protocol    = "TCP"
    rule_action = "ALLOW"
    ip_block    = "1.1.1.1/32"
    port_range  = "25"
  }
}




