# Jenkins EC2 Server

# Data source: always resolves to the latest Amazon Linux 2023 AMI in the
# configured region. Overridden if var.jenkins_ami is explicitly set.
data "aws_ami" "amazon_linux_2023" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-2023.*-x86_64"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }
}

resource "aws_instance" "jenkins_server" {
  # Use the explicit variable value when provided, otherwise fall back to the
  # dynamically resolved Amazon Linux 2023 AMI.
  ami           = coalesce(var.jenkins_ami, data.aws_ami.amazon_linux_2023.id)
  instance_type = var.jenkins_instance_type
  subnet_id     = aws_subnet.public_az_1.id

  vpc_security_group_ids      = [aws_security_group.jenkins_sg.id]
  iam_instance_profile        = aws_iam_instance_profile.jenkins_instance_profile.name
  associate_public_ip_address = true

  root_block_device {
    volume_size           = 50
    volume_type           = "gp3"
    encrypted             = true
    delete_on_termination = true
  }

  tags = {
    Name        = var.jenkins_server_name
    backup      = "true"
    Environment = "deployment"
    terraform   = "true"
  }
}

# IAM Instance Profile for Jenkins
resource "aws_iam_instance_profile" "jenkins_instance_profile" {
  name = "jenkins_instance_profile"
  role = aws_iam_role.jenkins_ec2_role.name
}
