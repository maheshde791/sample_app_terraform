# Project wide variable
variable "PROJECT_NAME" {}
# Varibles for the Providers
variable "AWS_ACCESS_KEY" {}
variable "AWS_SECRET_KEY" {}
variable "AWS_REGION" {}

# VPC Variables
variable "VPC_CIDR_BLOCK" {}
variable "VPC_PUBLIC_SUBNET1_CIDR_BLOCK" {}
variable "VPC_PRIVATE_SUBNET1_CIDR_BLOCK" {}

#EC2 Variables
variable "PEM_FILE_BASTIAN" {}
