provider "aws" {
  access_key     = "AKIAT2WCDBINWMZABGV6"
  secret_key     = "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"
  region         = "eu-west-3"
}

resource "aws_instance" "web" {
  ami           = "ami-087855b6c8b59a9e4"
  instance_type = "t2.micro"

  subnet_id              = "subnet-97c0fdfe"
  vpc_security_group_ids = ["sg-050a4ca5631347b37"]

  tags = {
    "Identity"    = "263473793563"
    "Name"        = "POE"
    "Environment" = "Training"
  }
}

output "public_ip" {
  value = aws_instance.web.public_ip
}

output "public_dns" {
  value = aws_instance.web.public_dns
}
