
# Create Security Groups
resource "aws_security_group" "secgroup" {
  name        = "global-allow-all"
  vpc_id      = "vpc-059e91b00dd4e24c9"

ingress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }
}