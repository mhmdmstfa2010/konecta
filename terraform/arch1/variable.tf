variable "ami" {
  description = "AMI ID for the EC2 instance"
  type = string
}
variable "instance_type" {
  description = "Instance type for the EC2 instance"
  type = string
}   
variable "availability_zone" {
  description = "Availability zone for the EC2 instance"
  type = string
}
variable "vpc_cidr_block" {
  description = "VPC CIDR block for the EC2 instance"
  type = string
}
variable "private_subnet_cidr_block" {
  description = "Private subnet CIDR block for the EC2 instance"
  type = string
}
variable "public_subnet_cidr_block" {
  description = "Public subnet CIDR block for the EC2 instance"
  type = string
}
variable "key_name" {
  description = "Key name for the EC2 instance"
  type = string
}