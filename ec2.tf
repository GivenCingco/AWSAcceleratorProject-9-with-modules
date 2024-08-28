module "ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"

  name = "single-instance"

  instance_type          = "t2.micro"
  key_name               = module.key_pair.key_pair_name
  monitoring             = false
  vpc_security_group_ids = [module.web_server_sg.security_group_id]
  subnet_id              = module.vpc.public_subnets[0]
  associate_public_ip_address = true 

    user_data = <<-EOF
              #!/bin/bash
              yum update -y
              yum install -y httpd
              systemctl start httpd
              systemctl enable httpd

              # Get the private IP address of the EC2 instance
              INSTANCE_IP=$(curl http://169.254.169.254/latest/meta-data/local-ipv4)

              # Write the IP address to index.html
              echo "<h1>EC2 Instance IP Address: $INSTANCE_IP</h1>" > /var/www/html/index.html
              EOF

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}