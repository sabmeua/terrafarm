env = development

terraform-plan:
	terraform plan -state=terraform/${env}/terraform.tfstate -var-file=terraform/${env}/terraform.tfvars terraform
terraform-apply:
	terraform apply -state=terraform/${env}/terraform.tfstate -var-file=terraform/${env}/terraform.tfvars terraform
