output "sg_id" {
  value = aws_security_group.ec2-sg.id
}

output "bastion_instance" {
  value = aws_instance.bastion.id
}    

output "master_instance" {
  value = aws_instance.master.id
}    

output "vpc" {
  value = aws_vpc.kubernets-vpc.id
  
}
