variable "region" {
  description = "aws region name"
  type = string
  default = "ap-south-1"
}

variable "project_name" {

  description = "my project name"
  type        = string
  default     = "zomato"
}

variable "project_environment" {

  description = "my project environment"
  type        = string
  default     = "production"
}

variable "ami_id" {
    
  description = "my source ami id"  
  type = string
  default = "ami-0f9708d1cd2cfee41"
}

variable "instance_type" {
  description = "my source instance type"  
  type = string
  default = "t2.micro"
}

locals {
  timestamp  = formatdate("YYYY-MM-DD-HH-mm", timestamp())
  image_name = "${var.project_name}-${var.project_environment}-${local.timestamp}"
}

