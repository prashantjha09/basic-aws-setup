terraform {
  backend "s3" {
    key    = "kubernets_setup/terraform.tfstate"
    bucket = "learning-terraform-state-storage"
  }
}
