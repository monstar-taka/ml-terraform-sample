#--------------------------------------------------------------
# VPC
#--------------------------------------------------------------
resource "aws_vpc" "vpc" {
  cidr_block = "${terraform.env == "dev" ? var.dev_vpc_cidr : terraform.env == "stg" ? var.stg_vpc_cidr : var.prod_vpc_cidr}"
  enable_dns_hostnames = true
  tags {
    Name = "${var.prj_name}-${terraform.env}-${var.vpc_name}"
    env = "${terraform.env}"
    prj = "${var.prj_name}"
  }
}
