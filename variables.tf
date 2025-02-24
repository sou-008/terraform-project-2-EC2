variable "aws_region" {
  default = "eu-north-1"
}

variable "ami_id" {
  default = "ami-09a9858973b288bdd"
}

variable "instance_type" {
  default = "t3.micro"
}

variable "key_pair_name" {
  default = "terraform-key-pair"
}