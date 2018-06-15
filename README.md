# Terraform Day One
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

Test that it works:

```bash
aws-vault exec playground -- aws s3 ls
```

Running terraform:

```bash
aws-vault exec playground -- terraform apply`
```

Set up AWS profile with MFA
Create a provider to use the profile.
Create a resource and apply incremental changes until it functions
Create a S3 bucket
Check that the bucket exists
Add outputs to terraform config for bucket name and bucket endpoint
Add versioning to bucket
Check versioning is on
Add object index.html to bucket
Try and access bucket
Add web access to bucket
Try and access bucket
Add bucket policy
Try and access file
Create a S3 bucket and dynamodb state storage
Update terraform to use s3 remote state
Create a new template that uses remote terraform state to find the bucket name
Create a new s3 object that uploads to the same bucket from another template using the discovered bucket name from the remote state.
Terraform linting
terraform fmt .
