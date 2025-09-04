# String Variable
variable "region" {
  description = "AWS region where resources will be deployed"
  type        = string
  default     = "us-east-1"
}

#  Number Variable
variable "instance_count" {
  description = "Number of EC2 instances to create"
  type        = number
  default     = 1
}

# boolean Variable
variable "enable_monitoring" {
  description = "Enable detailed monitoring for EC2"
  type        = bool
  default     = false
}

#  List Variable
variable "availability_zones" {
  description = "List of availability zones to use"
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b"]
}

#  Map Variable
variable "instance_types" {
  description = "Map of instance types for different environments"
  type        = map(string)
  default = {
    dev  = "t2.micro"
    prod = "t3.medium"
  }
}

#  Object Variable
variable "ec2_config" {
  description = "Configuration for EC2 instance"
  type = object(
    {
    ami           = string
    instance_type = string
    key_name      = string
   }
  
  )
  default = {
    ami           = "ami-0c55b159cbfafe1f0"
    instance_type = "t2.micro"
    key_name      = "my-keypair"
  }
}

#  Set Variable (Similar to List but Unordered & Unique)
variable "allowed_ports" {
  description = "Set of allowed inbound ports"
  type        = set(number)
  default     = [22, 80, 443]
}


#  Tuple Variable (List with Mixed Data Types)
variable "server_config" {
  description = "Tuple with mixed types"
  type        = tuple([string, number, bool])
  default     = ["web-server", 2, true]
}
    