#--------------------------------------------------------------
# Internet Gateway
#--------------------------------------------------------------
resource "aws_internet_gateway" "igw" {
  vpc_id = "${aws_vpc.vpc.id}"
  tags {
    Name = "${var.prj_name}-${terraform.env}-${terraform.env == "dev" ? var.internet_gateway : terraform.env == "stg" ? var.internet_gateway : var.internet_gateway}"
    env = "${terraform.env}"
    prj = "${var.prj_name}"
  }
}
