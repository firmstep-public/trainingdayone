# Terraform Day One (101)

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

## Task One - Configure your workstation for using Terraform with AWS Assumed Roles and MFA
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
#### Example of a Terraform resource
This is what a resource that creates an S3 bucket looks like:
```hcl
resource "aws_s3_bucket" "b" {
  bucket_prefix = "new_bucket"
}
```

## [Demo One](./demo_one) - Create a Terraform Template and apply it
1.  Using a Makefile to simplify commands
2.  Create an S3 bucket in a particular region

## [Demo Two](./demo_two) - Create a Terraform Template with outputs and save the state remotely
1.  Use the S3 bucket created in demo_one to store all the remote states
2.  Create a variable file to store the state buckets name, the state key name for `demo_two` and the state region.
3.  Create a Terraform template that creates a new S3 bucket that is configured for hosting static websites
4.  Initialise Terraform with extra variables that describe the remote state bucket, state region and state file name
5.  Apply the Terraform template

## [Demo Three](./demo_three) - Create a Terraform Template the uses outputs from a remote state
1. Create a variable file that stores a key name for `demo_three` but uses the same bucket and region
2. Create some html files that we will add to the S3 bucket created in `demo_two`
3. Create a Terraform template that will upload the html files to a bucket
4. Get the bucket name using the data provider `terraform_remote_state` to retrieve the web bucket name from `demo_two`
5. Use `terraform apply` to upload the files to s3

## [Demo Four](./demo_four) - Destroy the resources we created
1. Destroy demo three, then demo two, then demo one.

## Terraform formatting - to tidy up your code
```bash
terraform fmt .
```
If you use **[Visual Studio Code](https://code.visualstudio.com/download)** as your IDE then you can install the [Terraform Plugin](https://marketplace.visualstudio.com/items?itemName=mauve.terraform) to get syntax highlighting, code completion, and automatic formatting on file save. It works on Mac, Linux, and Windows.
