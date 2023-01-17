//https://developer.hashicorp.com/terraform/tutorials/aws-get-started/aws-build

// list necessary tools, prep for resource
terraform {
  backend "remote" {
    organization = "shimba-is-learning-tf"
    workspaces {
      name = "shimba-new-workspace"
    }
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}

// configures provider, details of necessary tools. still prep for resource
provider "aws" {
  region = "us-west-2"
}

// actual thing you want to deal with
// resource "RESOURCE_TYPE" "RESOURCE_NAME"
// terraform also creates a unique ID by combining these two like so "aws_instance.app_server"
resource "aws_instance" "app_server" {
  ami           = "ami-08d70e59c07c61a3a"
  instance_type = "t2.micro"

  tags = {
    Name = var.instance_name_1
  }
}

// importの際にまずinstanceMadeInConsole用のconfig追加しないと
// コマンド失敗するのでこれ追加
// importした後にtf planの結果見ながら書き換えるので最初は最小限埋めておけばよし
resource "aws_instance" "instanceMadeInConsole" {
  ami           = "ami-08d70e59c07c61a3a"
  instance_type = "t2.micro"

  tags = {
    "Name" = "instanceMadeInConsole"
  }
}
