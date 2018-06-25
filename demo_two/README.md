# Demo Two
### Configure a remote state so that the state information of Terraform isn't stored on the local computer.

Create an `aws_s3_bucket` resource and configure it as a website endpoint.
Add outputs to Terraform for bucket name and bucket endpoint
Add external terraform state storage block to the `main.tf` file
Use `terraform init` with the s3 bucket details to instruct terraform to use s3 remote state storage
Use `terraform apply` to deploy the bucket, and save the state on s3.