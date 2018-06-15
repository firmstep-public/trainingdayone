# Terraform Day One
## Overview
Terraform is a tool for provisioning infrastructure. It is a structured templating language that supports many different providers, not just AWS. As well as most resources for each provider. Because Terraform is open source, you can also create your own providers, and resources.
You define the resources you need as code in Terraform templates.

Terraform allows the infrastructure to be defined as code giving three measurable benefits:
*  Reduced Cost
*  Faster Execution
*  Remove Errors and Risks

Which also means that you gain the benefits of code tools such as:
*  Source control
*  Versioning
*  Shared team access
*  Project boards
*  Approval sign off
*  And any other tools you would use for software development governance

## Example Terraform
This is what a resource that creates an S3 bucket looks like:
```hcl
resource "aws_s3_bucket" "b" {
  bucket_prefix = "new_bucket"
}
```

## Training Goals


## Tasks
1.  Install aws-vault and awscli and terraform
    ```bash
    brew cask install aws-vault
    brew install awscli terraform
    brew upgrade awscli terraform
    ```
2.  Set up local credentials
    ```bash
    aws-vault add firmstepauth
    ```


3.  Edit `~/.aws/config` and add
    ```bash
    [profile firmstepauth]
    region = eu-west-1
    [profile playground]
    output = json
    region = eu-west-1
    role_arn = arn:aws:iam::[ACCOUNT_ID]:role/firmstepPlayground
    source_profile = firmstepauth
    mfa_serial = arn:aws:iam::[ACCOUNT_ID]:mfa/myuser
    ```

4.  Test that it works:
    ```bash
    aws-vault exec playground -- aws s3 ls
    ```

5.  Running terraform:
    ```bash
    aws-vault exec playground -- terraform apply`
    ```

6.  Create a resource and apply incremental changes until it functions
7.  Create a S3 bucket
8.  Check that the bucket exists
9.  Add outputs to terraform config for bucket name and bucket endpoint
10.  Add object index.html to bucket
11.  Try and access bucket
12.  Add web access to bucket
14.  Add external state storage to config, and init terraform to use s3 remote state
15.  Create a new template that uses remote terraform state to find the bucket name
16.  Create a new s3 object that uploads to the same bucket from another template using the discovered bucket name from the remote state.
17.  Terraform linting
    ```bash
    terraform fmt .
    ```
