#--------------------------------------------------------------
# Routes Table
#--------------------------------------------------------------
resource "aws_route_table" "public_rt" {
  vpc_id = "${aws_vpc.vpc.id}"
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.igw.id}"
  }
  tags {
    Name = "${var.prj_name}-${terraform.env}-${terraform.env == "dev" ? var.dev_vpc_routetable_public_name : terraform.env == "stg" ? var.stg_vpc_routetable_public_name : var.prod_vpc_routetable_public_name}"
    env = "${terraform.env}"
    prj = "${var.prj_name}"
  }
}

resource "aws_route_table" "private_rt_a" {
  vpc_id = "${aws_vpc.vpc.id}"
  # route {
  #    cidr_block = "0.0.0.0/0"
  #    nat_gateway_id = "${terraform.env == "dev" ? ${aws_nat_gateway.nat-gateway-dev.id} : terraform.env == "stg" ? ${aws_nat_gateway.nat-gateway-stg.id} : ${aws_nat_gateway.nat-gateway-prod-1a.id}}"
  # }
  tags {
    Name = "${var.prj_name}-${terraform.env}-${terraform.env == "dev" ? var.dev_vpc_routetable_private_1a_name : terraform.env == "stg" ? var.stg_vpc_routetable_private_1a_name : var.prod_vpc_routetable_private_1a_name}"
    env = "${terraform.env}"
    prj = "${var.prj_name}"
  }
}

resource "aws_route_table" "private_rt_c" {
  vpc_id = "${aws_vpc.vpc.id}"
  # route {
  #    cidr_block = "0.0.0.0/0"
  #    nat_gateway_id = "${terraform.env == "prod" ? ${aws_nat_gateway.nat-gateway-prod-1c.id}}"
  # }
  tags {
    Name = "${var.prj_name}-${terraform.env}-${terraform.env == "dev" ? var.dev_vpc_routetable_private_1c_name : terraform.env == "stg" ? var.stg_vpc_routetable_private_1c_name : var.prod_vpc_routetable_private_1c_name}"
    env = "${terraform.env}"
    prj = "${var.prj_name}"
  }
}
