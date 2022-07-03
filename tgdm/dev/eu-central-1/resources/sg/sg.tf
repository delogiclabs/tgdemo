resource "aws_security_group" "this" {
  name_prefix = var.sg_prefix
  description = "Access to service in cluster"
  vpc_id      = var.vpc_id

  ingress {
    description = "Full access from this security group members"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    self        = true
  }

  ingress {
    description = "Access to Elasticsearch for pritunl(vpn)"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["10.10.1.0/24"]
  }

  ingress {
    description = "Access to Elasticsearch cluster for limited users"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["10.11.1.0/25"]
  }

  egress {
    description      = "Full access for outgoing connections"
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = merge(
    var.tags,
    {
      "Name" = var.sg_prefix
  })
}
