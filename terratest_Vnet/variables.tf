variable "resource_group_name" {
  type = string
  default = "vnet-rg"
  
}

variable "nsg" {
  type = string
  default = "vnet-nsg"
}

variable "vnet_adress_spaces" {
  type        = string
  default     = "10.0.0.0/16"
}

variable "subnet_adress_prefixes" {
  type = string
  default = "10.0.2.0/24"
}

variable "location" {
  type = string
  default = "WestUS"
}

variable "vnet" {
  type = string
  default = "vnet-eng"
}

variable "subnet-name" {
  type = string
  default = "eng-subnet"
}
variable "postfix" {
  type = string
  default = "test"
}
