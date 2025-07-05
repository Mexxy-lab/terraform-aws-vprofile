resource "aws_security_group" "vprofile-bean-elb-sg" {

    name        = "vprofile-bean-elb-sg"
    description = "Security group for vprofile elasticbeanstalk ELB"
    vpc_id      = module.vpc.vpc_id
    
    ingress {
        from_port   = 80
        to_port     = 80
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
  
}

resource "aws_security_group" "vprofile-bastion-sg" {

    name        = "vprofile-bastion-sg"
    description = "Security group for vprofile bastion host"
    vpc_id      = module.vpc.vpc_id
    
    # Ingress rule to allow SSH access from a specific IP
    ingress {
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        cidr_blocks = [var.MYIP]
    }
    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0. 0.0.0/0"]
    }
}

resource "aws_security_group" "vprofile-prod-sg" {
    
    name        = "vprofile-prod-sg"
    description = "Security group for vprofile production instances"
    vpc_id      = module.vpc.vpc_id
    
    ingress {
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        security_groups = [aws_security_group.vprofile-bastion-sg.id]
    }

    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0/0"]
    }
  
}

resource "aws_security_group" "vprofile-backend-sg" {

    name        = "vprofile-backend-sg"
    description = "Security group for vprofile backend instances- RDS, ActiveMQ, and Elastic Cache"
    vpc_id      = module.vpc.vpc_id
    
    ingress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        security_groups = [aws_security_group.vprofile-prod-sg.id]
    }

    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0/0"]
    }
  
}

resource "aws_security_group_rule" "sec_group_allow_itself" {
    type              = "ingress"
    from_port         = 0
    to_port           = 65535
    description       = "Allow all traffic within the same security group"
    security_group_id = aws_security_group.vprofile-backend-sg.id
    protocol          = "tcp"
    self              = true
    source_security_group_id = aws_security_group.vprofile-backend-sg.id
  
}