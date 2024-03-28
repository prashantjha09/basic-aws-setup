module "initial-setup-on-dev" {
    source = "../initial-setup/"
    private_subnet = var.private_subnet
    sg_ingress_rule = var.sg_ingress_rule
    vpc_cidr = var.vpc_cidr
    public_subnet = var.public_subnet
}