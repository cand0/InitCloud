variable "access_key" {
}
    
variable "secret_key"{
}

variable "server_name" {
    default = ["cand1", "cand2"]
}

variable "region" {
    default = "KR"
}
variable "zones" {
    default = "KR-2"
}

variable "login_key_name" {
    default = "cand1"
}
variable "auto_scaling_policy_name" {
    type = list
    default = ["increase-policy", "decrease-policy"]
}
variable "scaling_adjustment" {
  type        = list
  default     = ["1", "-1"]
  description = "description"
}

variable subnets {
  type        = list
  default     = ["172.16.30.0/24", "172.16.31.0/24"]
  description = "description"
}
variable subnet_types {
  type        = list
  default     = ["PUBLIC", "PRIVATE"]
  description = "description"
}
variable subnet_names {
  type        = list
  default     = ["terra-dev-pub", "terra-dev-pri"]
  description = "description"
}
variable subnet_usage {
  type        = list
  default     = ["GEN","LOADB"]
  description = "description"
}
variable ni_pi {
  type        = list
  default     = ["172.16.30.6", "172.16.30.7"]
  description = "description"
}
variable nasname {
  type        = string
  default     = "cand2"
  description = "description"
}
variable nasserver {
  type        = string
  default     = "168.254.82.80"
  description = "description"
}

variable "server_image_product_code"{
    default = "SW.VSVR.OS.LNX64.CNTOS.0703.B050"
}
variable "server_product_code" {
    default = "SVR.VSVR.HICPU.C002.M004.NET.HDD.B050.G002"
}
