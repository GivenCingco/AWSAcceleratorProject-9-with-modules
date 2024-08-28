provider "tls" {
}

resource "tls_private_key" "this" {
  algorithm = "RSA"
}

resource "local_file" "private_key" {
  content  = tls_private_key.this.private_key_pem
  filename = "${path.module}/ec2-key-pair.pem"
}

module "key_pair" {
  source = "terraform-aws-modules/key-pair/aws"

  key_name   = "ec2-key-pair"
  public_key = trimspace(tls_private_key.this.public_key_openssh)
}
