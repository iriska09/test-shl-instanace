resource "aws_instance" "example" {
  ami           = "ami-03d49b144f3ee2dc4"
  instance_type = "t2.micro"
  ebs_optimized = false

  # IAM instance profile is not attached
  # iam_instance_profile = aws_iam_instance_profile.example.name

  # No tags provided
  # tags = {
  #   Name        = "example-instance"
  #   Environment = "test"
  # }
}
