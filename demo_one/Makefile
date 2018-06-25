profile := terraformrole
action := plan
init:
	@echo Using aws profile: $(profile)
	@aws-vault exec $(profile) -- terraform init
apply:
	@echo Using aws profile: $(profile)
	@aws-vault exec $(profile) -- terraform apply
destroy:
	@echo Using aws profile: $(profile)
	@aws-vault exec $(profile) -- terraform destroy
%:
	@echo Using aws profile: $(profile)
	@aws-vault exec $(profile) -- terraform $(action)
