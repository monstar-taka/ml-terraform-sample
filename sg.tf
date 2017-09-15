resource "aws_security_group" "ssh-sg" {
  name              = "ssh-sg"
  description       = "ssh-sg"
  vpc_id            = "${aws_vpc.vpc.id}"
  ingress {
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    cidr_blocks     = ["0.0.0.0/0"]
  }
  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }
  tags {
    Name            = "ssh-sg"
  }
}

resource "aws_security_group" "api-elb-sg" {
  name              = "${var.prj_name}-${terraform.env}-api-elb-sg"
  description       = "${var.prj_name}-${terraform.env}-api-elb-sg"
  vpc_id            = "${aws_vpc.vpc.id}"
  ingress {
    from_port       = 443
    to_port         = 443
    protocol        = "tcp"
    cidr_blocks     = ["0.0.0.0/0"]
  }
  ingress {
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    cidr_blocks     = ["0.0.0.0/0"]
  }
  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }
  tags {
    Name            = "${var.prj_name}-${terraform.env}-api-elb-sg"
    env             = "${terraform.env}"
    prj             = "${var.prj_name}"
  }
}

resource "aws_security_group" "mng-elb-sg" {
  name              = "${var.prj_name}-${terraform.env}-mng-elb-sg"
  description       = "${var.prj_name}-${terraform.env}-mng-elb-sg"
  vpc_id            = "${aws_vpc.vpc.id}"
  ingress {
    from_port       = 443
    to_port         = 443
    protocol        = "tcp"
    cidr_blocks     = ["0.0.0.0/0"]
  }
  ingress {
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    cidr_blocks     = ["0.0.0.0/0"]
  }
  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }
  tags {
    Name            = "${var.prj_name}-${terraform.env}-mng-elb-sg"
    env             = "${terraform.env}"
    prj             = "${var.prj_name}"
  }
}

resource "aws_security_group" "api-webapp-sg" {
  name              = "${var.prj_name}-${terraform.env}-api-webapp-sg"
  description       = "${var.prj_name}-${terraform.env}-api-webapp-sg"
  vpc_id            = "${aws_vpc.vpc.id}"
  ingress {
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    security_groups = ["${aws_security_group.ssh-sg.id}"]
  }
  ingress {
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = ["${aws_security_group.api-elb-sg.id}"]
  }
  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }
  tags {
    Name            = "${var.prj_name}-${terraform.env}-api-webapp-sg"
    env             = "${terraform.env}"
    prj             = "${var.prj_name}"
  }
}

resource "aws_security_group" "mng-webapp-sg" {
  name              = "${var.prj_name}-${terraform.env}-mng-webapp-sg"
  description       = "${var.prj_name}-${terraform.env}-mng-webapp-sg"
  vpc_id            = "${aws_vpc.vpc.id}"
  ingress {
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    security_groups = ["${aws_security_group.ssh-sg.id}"]
  }
  ingress {
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = ["${aws_security_group.mng-elb-sg.id}"]
  }
  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }
  tags {
    Name            = "${var.prj_name}-${terraform.env}-mng-webapp-sg"
    env             = "${terraform.env}"
    prj             = "${var.prj_name}"
  }
}

resource "aws_security_group" "db-sg" {
  name              = "${var.prj_name}-${terraform.env}-db-sg"
  description       = "${var.prj_name}-${terraform.env}-db-sg"
  vpc_id            = "${aws_vpc.vpc.id}"
  ingress {
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = ["${aws_security_group.api-webapp-sg.id}"]
  }
  ingress {
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = ["${aws_security_group.mng-webapp-sg.id}"]
  }
  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }
  tags {
    Name            = "${var.prj_name}-${terraform.env}-db-sg"
    env             = "${terraform.env}"
    prj             = "${var.prj_name}"
  }
}

resource "aws_security_group" "redis-sg" {
  name              = "${var.prj_name}-${terraform.env}-redis-sg"
  description       = "${var.prj_name}-${terraform.env}-redis-sg"
  vpc_id            = "${aws_vpc.vpc.id}"
  ingress {
    from_port       = 6379
    to_port         = 6379
    protocol        = "tcp"
    security_groups = ["${aws_security_group.api-webapp-sg.id}"]
  }
  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }
  tags {
    Name            = "${var.prj_name}-${terraform.env}-redis-sg"
    env             = "${terraform.env}"
    prj             = "${var.prj_name}"
  }
}
