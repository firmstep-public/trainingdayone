init:
	@echo Using aws profile: $(AWS_PROFILE)
	@aws-vault exec $(AWS_PROFILE) -- terraform init -get=true -force-copy=true -backend=true -backend-config="my_backend.tfvars" -backend-config="../backend.tfvars" 
apply:
	@echo Using aws profile: $(AWS_PROFILE)
	@aws-vault exec $(AWS_PROFILE) -- terraform apply -var-file=../terraform.tfvars
destroy:
	@echo Using aws profile: $(AWS_PROFILE)
	@aws-vault exec $(AWS_PROFILE) -- terraform destroy -var-file=../terraform.tfvars
%:
	@echo Using aws profile: $(AWS_PROFILE)
	@aws-vault exec $(AWS_PROFILE) -- terraform $(MAKECMDGOALS)
