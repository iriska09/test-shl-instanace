# provider "aws" {
#   region = "us-west-1"
# }

# resource "aws_instance" "example" {
#   ami           = "ami-03d49b144f3ee2dc4"
#   instance_type = "t2.micro"

#   tags = {
#     Name        = "example-test-instance"
#     Environment = "test"
#   }
# }
provider "aws" {
  region = "us-west-1"
}

resource "aws_instance" "example" {
  ami           = "ami-03d49b144f3ee2dc4"
  instance_type = "t2.micro"
}