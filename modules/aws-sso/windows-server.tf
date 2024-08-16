resource "aws_instance" "windows_server" {
  ami           = "ami-0801eb675a338c853"
  instance_type = var.instance_type
  key_name             = var.key_name

  tags = {
    Name = "windows_ad_server"
  }
}