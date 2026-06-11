# variables for VPC configuration

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "vpc_name" {
  description = "Name for the VPC"
  type        = string
  default     = "project-vpc"
}

# variables for public subnet configuration - 1

variable "public_subnet_az_1_cidr" {
  description = "CIDR block for public subnet in availability zone 1"
  type        = string
  default     = "10.0.1.0/24"
}

variable "public_subnet_az_1_az" {
  description = "Availability zone for public subnet in availability zone 1"
  type        = string
  default     = "us-east-1a"
}

variable "public_subnet_az_1_name" {
  description = "Name for public subnet in availability zone 1"
  type        = string
  default     = "public-subnet-az-1"
}

# variables for public subnet configuration - 2

variable "public_subnet_az_2_cidr" {
  description = "CIDR block for public subnet in availability zone 2"
  type        = string
  default     = "10.0.2.0/24"
}

variable "public_subnet_az_2_az" {
  description = "Availability zone for public subnet in availability zone 2"
  type        = string
  default     = "us-east-1b"
}

variable "public_subnet_az_2_name" {
  description = "Name for public subnet in availability zone 2"
  type        = string
  default     = "public-subnet-az-2"
}

# variables for private subnet configuration - 1

variable "private_subnet_az_1_cidr" {
  description = "CIDR block for private subnet in availability zone 1"
  type        = string
  default     = "10.0.11.0/24"
}

variable "private_subnet_az_1_az" {
  description = "Availability zone for private subnet in availability zone 1"
  type        = string
  default     = "us-east-1a"
}

variable "private_subnet_az_1_name" {
  description = "Name for private subnet in availability zone 1"
  type        = string
  default     = "private-subnet-az-1"
}

# variables for private subnet configuration - 2

variable "private_subnet_az_2_cidr" {
  description = "CIDR block for private subnet in availability zone 2"
  type        = string
  default     = "10.0.12.0/24"
}

variable "private_subnet_az_2_az" {
  description = "Availability zone for private subnet in availability zone 2"
  type        = string
  default     = "us-east-1b"
}

variable "private_subnet_az_2_name" {
  description = "Name for private subnet in availability zone 2"
  type        = string
  default     = "private-subnet-az-2"
}

# variables for private DB subnet configuration - 1

variable "private_db_subnet_az_1_cidr" {
  description = "CIDR block for private DB subnet in availability zone 1"
  type        = string
  default     = "10.0.21.0/24"
}

variable "private_db_subnet_az_1_az" {
  description = "Availability zone for private DB subnet in availability zone 1"
  type        = string
  default     = "us-east-1a"
}

variable "private_db_subnet_az_1_name" {
  description = "Name for private DB subnet in availability zone 1"
  type        = string
  default     = "private-db-subnet-az-1"
}

# variables for private DB subnet configuration - 2

variable "private_db_subnet_az_2_cidr" {
  description = "CIDR block for private DB subnet in availability zone 2"
  type        = string
  default     = "10.0.22.0/24"
}

variable "private_db_subnet_az_2_az" {
  description = "Availability zone for private DB subnet in availability zone 2"
  type        = string
  default     = "us-east-1b"
}

variable "private_db_subnet_az_2_name" {
  description = "Name for private DB subnet in availability zone 2"
  type        = string
  default     = "private-db-subnet-az-2"
}

# variables for Internet Gateway

variable "project_name" {
  description = "Name for the project to be used in tags"
  type        = string
  default     = "my-project-igw"
}



#jenkinns server variables

variable "jenkins_server_name" {
  description = "Name for the Jenkins server"
  type        = string
  default     = "jenkins-server"
}

variable "jenkins_ami" {
  description = "AMI ID for the Jenkins server. Leave null to auto-select latest Amazon Linux 2023."
  type        = string
  default     = null
}

variable "jenkins_instance_type" {
  description = "Instance type for the Jenkins server"
  type        = string
  default     = "t2.2xlarge"
}


#rds variables


variable "db_password" {
  description = "Password for the RDS MySQL instance. Set via TF_VAR_db_password env var or -var flag. Never hardcode."
  type        = string
  sensitive   = true
}


# Domain variables for Route 53
variable "domain_name" {
  description = "The domain name for the hosted zone and ACM certificate"
  type        = string
  default     = "example.com"
}

