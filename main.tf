provider "aws" {
  region = "us-west-1"
}

resource "aws_instance" "example" {
  ami           = "ami-03d49b144f3ee2dc4"
  instance_type = "t2.micro"

  tags = {
    Name        = "example-test-instance"
    Environment = "test"
  }
}
# provider "aws" {
#   region = "us-west-1"
# }

# resource "aws_iam_role" "example" {
#   name = "example_role"
#   assume_role_policy = jsonencode({
#     Version = "2012-10-17",
#     Statement = [
#       {
#         Effect = "Allow",
#         Principal = {
#           Service = "ec2.amazonaws.com"
#         },
#         Action = "sts:AssumeRole"
#       }
#     ]
#   })
# }

# resource "aws_iam_role_policy_attachment" "example" {
#   role       = aws_iam_role.example.name
#   policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ReadOnlyAccess"
# }

# resource "aws_instance" "example" {
#   ami                         = "ami-03d49b144f3ee2dc4"
#   instance_type               = "t2.micro"
#   iam_instance_profile        = aws_iam_instance_profile.example.name
#   monitoring                  = true
#   ebs_optimized               = true
#   metadata_options {
#     http_endpoint               = "enabled"
#     http_tokens                 = "required"
#   }

#   root_block_device {
#     encrypted = true
#   }

#   tags = {
#     Name        = "example-instance"
#     Environment = "test"
#   }
# }

# resource "aws_iam_instance_profile" "example" {
#   name = "example_instance_profile"
#   role = aws_iam_role.example.name
# }
