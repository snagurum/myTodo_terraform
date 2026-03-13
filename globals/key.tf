resource "aws_key_pair" "my_ec2_key_pair" {
  key_name   = "admin-key"                   # Name for the key pair in AWS
  public_key = file("~/.ssh/id_ed25519.pub") # Path to your local public key
}