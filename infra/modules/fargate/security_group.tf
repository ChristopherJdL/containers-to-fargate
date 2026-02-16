# security.tf

# ALB security Group: Edit to restrict access to the application
resource "aws_security_group" "cf" {
    name        = "cf-security-group"
    description = "controls access to the app"
    vpc_id      = aws_vpc.main.id

    ingress {
        protocol    = "tcp"
        from_port   = var.app_port
        to_port     = var.app_port
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        protocol    = "-1"
        from_port   = 0
        to_port     = 0
        cidr_blocks = ["0.0.0.0/0"]
    }
}