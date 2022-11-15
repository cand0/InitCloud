resource "ncloud_vpc" "vpc" {
  name            = "vpc"
  ipv4_cidr_block = "10.0.0.0/16"
}
resource "ncloud_subnet" "subnet" {
  vpc_no             = ncloud_vpc.vpc.id
  subnet             = "10.0.1.0/24"
  zone               = "KR-2"
  network_acl_no     = ncloud_vpc.vpc.default_network_acl_no
  subnet_type        = "PRIVATE"
}

resource "ncloud_route_table" "route_table1" {
  vpc_no                = ncloud_vpc.vpc.id
  supported_subnet_type = "PRIVATE"
  name                  = "route-table"
  description           = "for test"
}

resource "ncloud_route_table" "route_table2" {
  vpc_no                = ncloud_vpc.vpc.id
  supported_subnet_type = "PRIVATE"
  name                  = "route-table2"
  description           = "for test2"
}

# testcode
resource "ncloud_route_table_association" "fail1_1" {
  route_table_no        = ncloud_route_table.route_table1.id
  subnet_no             = ncloud_subnet.subnet.id
}

resource "ncloud_route_table_association" "fail1_2" {
  route_table_no        = ncloud_route_table.route_table2.id
  subnet_no             = ncloud_subnet.subnet.id
}

resource "ncloud_route_table_association" "pass" {
  route_table_no        = ncloud_route_table.route_table2.id
  subnet_no             = ncloud_subnet.subnet.id
}