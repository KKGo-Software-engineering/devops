# Get Availability Zones
resource "tls_private_key" "key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

# Generate a Private Key and encode it as PEM.
resource "aws_key_pair" "key_pair" {
  key_name   = "key"
  public_key = tls_private_key.key.public_key_openssh

  provisioner "local-exec" {
    command = "echo '${tls_private_key.key.private_key_pem}' > ./key.pem"
  }
}

# create nginx
resource "aws_instance" "node" {
  instance_type          = "t2.micro"
  ami                    = "ami-02ee763250491e04a"
  key_name               = aws_key_pair.key_pair.id
  vpc_security_group_ids = [aws_security_group.secgroup.id]
  subnet_id              = "subnet-0aa074e92c6843434"
  associate_public_ip_address = "true"

  root_block_device {
    volume_size = 10
  }

  connection {
    type        = "ssh"
    host        = self.public_ip
    user        = "ubuntu"
    private_key = tls_private_key.key.private_key_pem
  }
  
  provisioner "remote-exec" {
    inline = [
      "sudo apt update -y",
      "sudo apt install nginx -y",
      "sudo service nginx start"
    ]
  }
}