# Terraform Day One (101)
#### Note: The code supplied in this repository is for speaking to, and verifying the class code against, not for the class to copy and paste from. Who learns from that?

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

## Training Goals for day one
Though this workshop we will learn:
*  Which tools are needed, and how to install them on to our computers
*  How to configure MFA and AWS profiles for Terraform
*  How to use a named profile and assume a security role
*  How to layout a Terraform directory
*  How to create a Terraform template
*  How to add an AWS Provider
*  How to add an S3 bucket
*  The Terraform commands `plan`, `apply`, and `destroy`
*  How Terraform tracks the state of its resources
*  How to set up remote storage for Terraform states
*  How to access the state information of one Terraform template, from another Terraform template.


### NOTE
It is important to note that this tutorial assumes you have your own IAM User that has 
restricted permissions and MFA enabled (Which will use the local AWS profile name of `securityaccount`),
and a second role (and aws profile) that has more elevated permissions to run Terraform with called `terraformrole`. 
This could be within the same AWS Account, or across multiple AWS accounts.
If you haven't got this configured, then [start by doing that.](https://docs.aws.amazon.com/IAM/latest/UserGuide/tutorial_cross-account-with-roles.html)

## Tasks
1.  Install `aws-vault` and `awscli` and `terraform`

    **For Mac via [brew](https://brew.sh/)**
    ```bash
    brew cask install aws-vault
    brew install awscli terraform
    brew upgrade awscli terraform
    ```
    **For Windows via [choco](https://chocolatey.org/docs/installation)**
    ```powershell
    choco install terraform awscli
    Invoke-WebRequest -Uri "https://github.com/99designs/aws-vault/releases/download/v4.2.1/aws-vault-windows-386.exe" -OutFile "$PSScriptRoot/aws-vault-windows-386.exe"
    Start-Process -Filepath "$PSScriptRoot/aws-vault-windows-386.exe"
    ``` 

2.  Set up local credentials
    ```bash
    aws-vault add securityaccount
    ```


3.  On Mac edit `~/.aws/config` or on Windows edit `"%UserProfile%\.aws\config"`and add

    ```bash
    [profile securityaccount]
    region = eu-west-1
    [profile terraformrole]
    output = json
    region = eu-west-1
    role_arn = arn:aws:iam::<ASSUMED_ACCOUNT_ID>:role/TerraformRole
    source_profile = securityaccount
    mfa_serial = arn:aws:iam::<SECURITY_ACCOUNT_ID>:mfa/<AWSIAMUSERNAME>
    ```
    #### NOTE: Make sure you replace the parts with `<variable>` with your actual values.
    *  `ASSUMED_ACCOUNT_ID` is the AWS Account ID of the `terraformrole` that was created for using Terraform.
    *  `SECURITY_ACCOUNT_ID` is the AWS Account ID of the IAM User you use (it's fine for the assumed and security accounts to be the same)
    *  `AWSIAMUSERNAME` is the IAM username that you are using in your AWS security account.
    
    For more details on this setup read the [aws-vault usage guide](https://github.com/99designs/aws-vault/blob/master/USAGE.md).

4.  Test that it works:
    ```bash
    aws-vault exec terraformrole -- aws s3 ls
    ```

5.  Running terraform:
    ```bash
    aws-vault exec terraformrole -- terraform apply
    ```

6.  Create a resource and apply incremental changes until it functions
7.  Create a S3 bucket as a Terraform resource
8.  Check that the bucket exists via AWS Console or AWS CLI
    ```bash
    aws-vault exec terraformrole -- aws s3 ls
    ```
9.  Add outputs to Terraform config for bucket name and bucket endpoint
10.  Add object `index.html` and `error.html` to bucket
11.  Add web access to bucket - example found in demo_two
12.  Add external state storage to config, and init terraform to use s3 remote state - example found in demo_two
13.  Create a new template that uses remote terraform state to find the bucket name
14.  Create a new s3 object that uploads to the same bucket from another template using the discovered bucket name from the remote state.
15.  Terraform linting
     ```bash
      terraform fmt .
     ```
