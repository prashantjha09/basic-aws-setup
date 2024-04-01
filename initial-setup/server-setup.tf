resource "aws_instance" "bastion" {
    ami = "ami-0c7217cdde317cfec"
    instance_type = "t2.nano"
    vpc_security_group_ids = [aws_security_group.ec2-sg.id]
    key_name = "aws-learning-account"
    subnet_id       = aws_subnet.kubernets-public-subnet[0].id
    
    connection {
      type     = "ssh"
      user     = "ubuntu"
      private_key = file("/Users/prashantjha/.ssh/aws-learning-account.pem")
      host     = self.public_ip   
  }
   provisioner "remote-exec" {
   inline = [
    # Updating with the latest command for Amazon Linux machine
     "sudo apt update -y ",
     "sudo apt install nginx -y"
   ]
   on_failure = continue
 }    
}

resource "aws_instance" "master" {
    ami = "ami-0712b30d40de8a338"
    instance_type = "t2.small"
    vpc_security_group_ids = [aws_security_group.ec2-sg.id]
    key_name = "aws-learning-account"
    subnet_id  = aws_subnet.kubernets-private-subnet[0].id

    connection {
      type        = "ssh"
      user        = "ubuntu"  # Update with appropriate username for your AMI
      host        = self.private_ip 
      private_key = file("/Users/prashantjha/.ssh/aws-learning-account.pem")
      bastion_host = aws_instance.bastion.public_ip  # Public IP of the bastion
      bastion_host_key = file("/Users/prashantjha/.ssh/aws-learning-account.pem")
      bastion_port=22
      bastion_user="ubuntu"
    }

    provisioner "remote-exec" {
   inline = [
    # Updating with the latest command for Amazon Linux machine
     "sudo apt update -y ",
    #  "sudo apt-get upgrade -y"
    #  "sudo apt install nginx -y",
    #  "sudo apt  install awscli -y"
   ]
   on_failure = continue
}
    }
