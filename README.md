## This is a Terraform project for the deployment of a Java project - vprofile 

    - This project provisions the VPC network using aws modules 
    - Deploys the application itself to the provisioned network stack 
    - Uses AWS resources as PAAS and SAAS for provisioning rabbitmq, MySQL and Membcache services. (AWS Active mq, AWS RDS and Elastic cache)

## Project Architecture 

![alt text](pictures/image.png)

## Service Architecture 

![alt text](pictures/image1.png)

## Create the terraform files needed to provision the infrastructure 
    - provider.tf, vars.tf, vpc.tf, securitygroups.tf, s3bucket.tf, keypairs.tf, .......
    - Implemented a VPC module, using the AWS module for vpc creation. This provisions 3 private subnets and 3 public subnets 
    - A NAT gateway, with dns support enabled in the VPC. 
    - The resources would be distributed accross 3 AZs for high availability 
    - Run below command to verify the plan and initialize your project 

        ```bash
        terraform init
        ```