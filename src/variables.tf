variable "region"{
type = string
default= var("TF_region")
}

variable "cidr_block"{
type = string
default= var("TF_cidr_block")
}

variable "secret_key"{
type = string
default= var("TF_secret_key")
}

variable "access_key"{
type = string
default= var("TF_access_key")
}
