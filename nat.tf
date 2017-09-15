#--------------------------------------------------------------
# VPC NAT Gateway
#--------------------------------------------------------------
# resource "aws_eip" "dev-eip" {
#     vpc = true
# }
#
# resource "aws_eip" "stg-eip" {
#     vpc = true
# }
#
# resource "aws_eip" "prod-eip-1a" {
#     vpc = true
# }
#
# resource "aws_eip" "prod-eip-1c" {
#     vpc = true
# }

# resource "aws_nat_gateway" "nat-gateway-dev" {
#     allocation_id = "${aws_eip.dev-eip.id}"
#     subnet_id = "${aws_subnet.vpc_subnet_dev_public_1a.id}"
# }
#
# resource "aws_nat_gateway" "nat-gateway-stg" {
#     allocation_id = "${aws_eip.stg-eip.id}"
#     subnet_id = "${aws_subnet.vpc_subnet_stg_public_1a.id}"
# }
#
# resource "aws_nat_gateway" "nat-gateway-prod-1a" {
#     allocation_id = "${aws_eip.prod-eip-1a.id}"
#     subnet_id = "${aws_subnet.vpc_subnet_prod_public_1a.id}"
# }
#
# resource "aws_nat_gateway" "nat-gateway-prod-1a" {
#     allocation_id = "${aws_eip.prod-eip-1a.id}"
#     subnet_id = "${aws_subnet.vpc_subnet_prod_public_1a.id}"
# }
#
# resource "aws_nat_gateway" "nat-gateway-prod-1c" {
#     allocation_id = "${aws_eip.prod-eip-1c.id}"
#     subnet_id = "${aws_subnet.vpc_subnet_prod_public_1c.id}"
# }
