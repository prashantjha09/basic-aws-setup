* Initialise :- 
terraform init -backend-config="profile=learning-account" -backend-config="region=us-east-1"

* Plan :-

terraform plan -var="profile=learning-account"

* Apply :-

terraform apply -var="profile=learning-account"
