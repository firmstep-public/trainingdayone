bucket_name = "dayone"
web_bucket_name = "web-day-one"
region = "eu-west-1"
state_region = "eu-west-1"
# This is the name of the bucket used for state storage
# You can do this as a one off task (but choose your own bucket name):
#    export AWS_PROFILE=terraformrole
#    aws-vault exec ${AWS_PROFILE} -- aws s3 mb s3://demo-tf-fs-state
state_bucket = "demo-tf-fs-state"
website_key = "jamie.tfstate"