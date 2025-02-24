provider "aws" {
  region = "eu-north-1"  # Updated AWS region
}

# Create VPC
resource "aws_vpc" "main_vpc" {
  cidr_block = "10.0.0.0/16"
}

# Create subnets
resource "aws_subnet" "flask_subnet" {
  vpc_id     = aws_vpc.main_vpc.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "eu-north-1a"
  map_public_ip_on_launch = true
}

resource "aws_subnet" "express_subnet" {
  vpc_id     = aws_vpc.main_vpc.id
  cidr_block = "10.0.2.0/24"
  availability_zone = "eu-north-1b"
  map_public_ip_on_launch = true
}

# Create Security Group for Flask (Backend)
resource "aws_security_group" "flask_sg" {
  name        = "flask-sg"
  description = "Allow inbound traffic to Flask application"
  vpc_id      = aws_vpc.main_vpc.id  # Ensure SG is associated with VPC

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Allow HTTP access from anywhere
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Allow SSH from anywhere (change for tighter security)
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Create Security Group for Express (Frontend)
resource "aws_security_group" "express_sg" {
  name        = "express-sg"
  description = "Allow inbound traffic to Express application"
  vpc_id      = aws_vpc.main_vpc.id  # Ensure SG is associated with VPC

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Allow HTTP access from anywhere
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Allow SSH from anywhere (change for tighter security)
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Create EC2 instance for Flask Backend
resource "aws_instance" "flask_instance" {
  ami             = "ami-09a9858973b288bdd"  # Updated AMI ID
  instance_type   = "t3.micro"  # Updated Instance Type
  subnet_id       = aws_subnet.flask_subnet.id
  vpc_security_group_ids = [aws_security_group.flask_sg.id]  # Use security group ID here

  key_name = "terraform-key-pair"  # Updated Key Pair Name

  user_data = file("./user-data/flask.sh")  # Path to Flask setup script

  tags = {
    Name = "Flask-Backend"
  }
}

# Create EC2 instance for Express Frontend
resource "aws_instance" "express_instance" {
  ami             = "ami-09a9858973b288bdd"  # Updated AMI ID
  instance_type   = "t3.micro"  # Updated Instance Type
  subnet_id       = aws_subnet.express_subnet.id
  vpc_security_group_ids = [aws_security_group.express_sg.id]  # Use security group ID here

  key_name = "terraform-key-pair"  # Updated Key Pair Name

  user_data = file("./user-data/express.sh")  # Path to Express setup script

  tags = {
    Name = "Express-Frontend"
  }
}

# Output the public IPs of the instances
output "flask_public_ip" {
  value = aws_instance.flask_instance.public_ip
}

output "express_public_ip" {
  value = aws_instance.express_instance.public_ip
}