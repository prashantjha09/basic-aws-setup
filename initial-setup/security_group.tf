locals {
  port=65535
}

resource "aws_security_group" "ec2-sg" {
  name        = "kubernets-sg"
  vpc_id = aws_vpc.kubernets-vpc.id

 // Allow all inbound TCP traffic from the same security group
  ingress {
    from_port        = 0
    to_port          = local.port
    protocol         = "tcp"
    self = true
  }

  dynamic "ingress" {
    for_each = var.sg_ingress_rule
    content {
      from_port   = ingress.value.from_port
      to_port     = ingress.value.to_port
      description = ""
      protocol    = "tcp"
      cidr_blocks = [ingress.value.cidr_block]
    }
  }

  // Allow all outbound TCP traffic to the same security group
  egress {
    from_port        = 0
    to_port          = local.port
    protocol         = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
