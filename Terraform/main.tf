module "network" {
  source           = "./network"
  vpc_cidr         = "10.0.0.0/16"
  vpc_name         = "my vpc"
  internet_gateway = "internet gateway"
  nat_gateway      = "nat"
  public_cidr      = "0.0.0.0/0"

  subnet = {
    "public_subnet1"  = { cidr = "10.0.0.0/24", zone = "us-east-1b" },
    "public_subnet2"  = { cidr = "10.0.2.0/24", zone = "us-east-1c" },
    "private_subnet1" = { cidr = "10.0.1.0/24", zone = "us-east-1b" },
    "private_subnet2" = { cidr = "10.0.3.0/24", zone = "us-east-1c" }
  }

  route_table = {
    "public_name"  = "public route table",
    "private_name" = "private route table"
  }

  route = {
    "route1" = { routingTableID = module.network.public_route_table_id, gatewayID = module.network.gateway_id },
    "route2" = { routingTableID = module.network.private_route_table_id, gatewayID = module.network.nat_id }
  }

  subnet_association = {
    "publicSubnet_association1"  = { subnetID = module.network.public_subnet1_id, routingTableID = module.network.public_route_table_id },
    "publicSubnet_association2"  = { subnetID = module.network.public_subnet2_id, routingTableID = module.network.public_route_table_id },
    "privateSubnet_association1" = { subnetID = module.network.private_subnet1_id, routingTableID = module.network.private_route_table_id },
    "privateSubnet_association2" = { subnetID = module.network.private_subnet2_id, routingTableID = module.network.private_route_table_id }
  }
}

module "ec2" {
  source         = "./ec2"
  public_cidr    = "0.0.0.0/0"
  security_group = "ec2 security group"
  vpcID          = module.network.vpc_id
  ec2_type       = "t2.medium"
  ami            = "ami-0557a15b87f6559cf"


  ec2 = {
    "basion-host"        = { subnetID = module.network.public_subnet2_id, publicIP = true },
    "sonarqube-instance" = { subnetID = module.network.private_subnet1_id, publicIP = false },
    "nexus-instance"     = { subnetID = module.network.private_subnet2_id, publicIP = false }
  }

}


module "loadbalancer" {
  source      = "./loadBalancer"
  vpcID       = module.network.vpc_id
  target_type = "instance"


  nexus-id = module.ec2.nexus_ec2_id
  sonar-id = module.ec2.sonarqube_ec2_id

  security_group = "loadBalancer security group"
  public_cidr    = "0.0.0.0/0"
  port80         = 80
  protocol-Http  = "HTTP"


  publicSubnet1  = module.network.public_subnet1_id
  publicSubnet2  = module.network.public_subnet2_id
  privateSubnet1 = module.network.private_subnet1_id
  privateSubnet2 = module.network.private_subnet2_id

  target_group = "target-group"

  load_balancer_type = "application"
  load_balancer_name = "load-balancer"
  ip_address_type    = "ipv4"
  public-subnet-id1  = module.network.public_subnet1_id
  public-subnet-id2  = module.network.public_subnet2_id

  securityID = module.ec2.ec2_sg_id

}

