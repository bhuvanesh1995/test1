vpc_name           = "myvpc"
cidr_block         = "10.0.0.0/16"
availability_zone  = ["us-east-2a", "us-east-2b", "us-east-2c"]
public_cidr_block  = ["10.0.10.0/24", "10.0.20.0/24", "10.0.30.0/24"]
private_cidr_block = ["10.0.50.0/24", "10.0.60.0/24", "10.0.70.0/24"]


instance_type = "t2.micro"
keypair       = "Terraform"
environment   = "prod"