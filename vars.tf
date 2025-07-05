variable "AWS_REGION" {
  type        = string
  default     = "us-east-2"
  description = "AWS Region for the project"
}

variable "AMI" {
  type = map(any)
  default = {

    us-east-1  = "ami-0d1b5a8c13042c939"
    us-east-2  = "ami-0d1b5a8c13042c934"
    ap-south-1 = "ami-0d1b5a8c13042c937"

  }
  description = "AMI for the EC2 instance - Bastion Host"
}

variable "PRIV_KEY_PATH" {
  type        = string
  default     = "vprofilekey"
  description = "Private Key for Bastion host for logging in"
}

variable "PUB_KEY_PATH" {
  type        = string
  default     = "vprofilekey.pub"
  description = "Public key for Bastion host instance accessing services on host"
}

variable "USERNAME" {
  type        = string
  default     = "ubuntu"
  description = "description"
}

variable "MYIP" {
  type        = string
  default     = "183.83.39.124/32"
  description = "IP address allocation for Bastion host"
}

# Variable for Rabbitmq user. Here we using Activemq an aws service 
variable "rmquser" {
  type        = string
  default     = "rabbit"
  description = "Activemq username for the rabbitmq service"
}

variable "rmqpass" {
  type        = string
  default     = "Gr33n@pple123456"
  description = "Password for the activemq user"
}

# Variable for MySQL service, here we using AWS RDS as a platform as a service 
variable "dbpass" {
  type        = string
  default     = "admin123"
  description = "This is the log in passwd for the RDS service"
}

# Variable for the RDS username or db name. 
variable "dbuser" {
  type        = string
  default     = "admin"
  description = "This is the db user name used to log in to RDS"
}


# This is the table name for the RDS service
variable "dbname" {
  type        = string
  default     = "accounts"
  description = "description"
}

variable "instance_count" {
  type        = number
  default     = 1
  description = "Instance count which tells number of instances to provision"
}

# This is the VPC name variable
variable "VPC_NAME" {
  type        = string
  default     = "vprofile-VPC"
  description = "description"
}

variable "Zone1" {
  type        = string
  default     = "us-east-2a"
  description = "This is variable for the Availability zones"
}

variable "Zone2" {
  type        = string
  default     = "us-east-2b"
  description = "This is variable for the Availability zones"
}

variable "Zone3" {
  type        = string
  default     = "us-east-2c"
  description = "This is variable for the Availability zones"
}

variable "VpcCIDR" {
  type        = string
  default     = "172.21.0.0/16"
  description = "description"
}

variable "PubSub1CIDR" {
  type        = string
  default     = "172.21.1.0/24"
  description = "description"
}

variable "PubSub2CIDR" {
  type        = string
  default     = "172.21.2.0/24"
  description = "description"
}

variable "PubSub3CIDR" {
  type        = string
  default     = "172.21.3.0/24"
  description = "description"
}

variable "PrivSub1CIDR" {
  type        = string
  default     = "172.21.4.0/24"
  description = "description"
}

variable "PrivSub2CIDR" {
  type        = string
  default     = "172.21.5.0/24"
  description = "description"
}

variable "PrivSub3CIDR" {
  type        = string
  default     = "172.21.6.0/24"
  description = "description"
}