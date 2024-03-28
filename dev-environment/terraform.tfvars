vpc_cidr="10.0.0.0/16"

public_subnet={
    0:"10.0.0.0/20"
    1:"10.0.16.0/20"
}

private_subnet={
    0:"10.0.32.0/20"
    1:"10.0.48.0/20"
}

sg_ingress_rule =[
    {
        from_port:22, to_port:22, cidr_block:"0.0.0.0/0"
        },
       {
        from_port:80, to_port:80, cidr_block:"0.0.0.0/0"
        }
]
 

