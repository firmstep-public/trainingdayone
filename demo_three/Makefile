profile := terraformrole
action := plan
init:
	@echo Using aws profile: $(profile)
	@aws-vault exec $(profile) -- terraform init -get=true -force-copy=true -backend=true -backend-config="my_backend.tfvars" -backend-config="../backend.tfvars" 
apply:
	@echo Using aws profile: $(profile)
	@aws-vault exec $(profile) -- terraform apply -var-file=../terraform.tfvars
destroy:
	@echo Using aws profile: $(profile)
	@aws-vault exec $(profile) -- terraform destroy -var-file=../terraform.tfvars
%:
	@echo Using aws profile: $(profile)
	@aws-vault exec $(profile) -- terraform $(action)
