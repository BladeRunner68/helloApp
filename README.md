# Sample AWS Cloud Serverless GITOPS Project - helloApp


## Deployment Status

[![Deploy to Development](https://github.com/BladeRunner68/helloApp/actions/workflows/install_api_pr-dev.yml/badge.svg?branch=Dev)](https://github.com/BladeRunner68/helloApp/actions/workflows/install_api_pr-dev.yml)
[![Deploy to Staging](https://github.com/BladeRunner68/helloApp/actions/workflows/install_api_pr-staging.yml/badge.svg)](https://github.com/BladeRunner68/helloApp/actions/workflows/install_api_pr-staging.yml)
[![Deploy to Production](https://github.com/BladeRunner68/helloApp/actions/workflows/install_api_pr-prod.yml/badge.svg)](https://github.com/BladeRunner68/helloApp/actions/workflows/install_api_pr-prod.yml)


## Project Outline

This simple project follows modern gitops/devops architectural design principles for automated (controlled) Cloud ifrastructure build, deploy, test, code check-in.  The project is designed to be used in staged environments (Dev, Staging, Prod (Master) and adopts a Cloud serverless-design pattern.

When run and fully deployed via automation, this project's workflow automatically makes a single authenticated call to a custom HTTPS API endpoint residing on AWS which returns a single "hello" output to the caller. The output of the automated API test report via Newman/Postman is automatically added as a file artifact on the workflow run summary within Github Actions.  

Given the authenticated nature of this API, the developer/tester should use applications such as Postman for any manual testing required due to the nature of the "awsv4" secure call method. 

## Technologies Used 

- Github (Code Repo/Secrets Management/Actions Workflow Engine)
- Terraform (IAC - controlled Cloud infrastructure build/update via full Cloud-based state management)
- AWS (Lambda/API Gateway (HTTP-based)/S3/Cloudwatch/IAM)
- Python (Sample API code)
- Postman/Newman (For automated API testing)
- Nodejs/NPM



## Deployment Guide

### Outline

- Clone this project from Github to your local dev environment (laptop etc)
- Change Terraform control files (backend, root variables to indicate AWS region, environment, S3 bucket name, Lambda runtime memory etc)
- Ensure your AWS IAM user being used for this IAC creation and automation has sufficient rights to create and run resources
- Commit/push any changes back to Github
- Check the required workflow runs successfully within Github Actions

**Github Secrets Setup:**
![Deployment](notes/helloApp%20-%20repo%20secrets.JPG)


**AWS Lambda fully deployed:**
![Deployment](notes/helloApp%20-%20lambda.JPG)


**AWS HTTP API Gateways fully deployed:**
![Deployment](notes/helloApp%20-%20http_gateways.JPG)


**AWS Cloudwatch monitoring groups fully deployed:**
![Deployment](notes/helloApp%20-%20cloudwatch_groups.JPG)


**AWS Terraform remote state management fully deployed:**
![Deployment](notes/helloApp%20-%20remote%20s3%20states.JPG)



### Github Setup


- **Secrets Management** - ensure the AWS_ACCESS_KEY_ID, AWS_SECRET_ACCESS_KEY and REGION secrets from IAM are set up in the [Workflow Repository secrets section](https://docs.github.com/en/actions/security-guides/encrypted-secrets#creating-encrypted-secrets-for-a-repository) 



##### IMPORTANT - Enable Branch Protection

Do not use this code without any kind of [Branch Protection](https://docs.github.com/en/repositories/configuring-branches-and-merges-in-your-repository/defining-the-mergeability-of-pull-requests/about-protected-branches) enabled!

At the very least you should [Require proper status checks before branch merging](https://docs.github.com/en/repositories/configuring-branches-and-merges-in-your-repository/defining-the-mergeability-of-pull-requests/about-protected-branches#require-status-checks-before-merging) enabled and set to "Strict" such that the "Require branches to be up to date before merging" checkbox is checked.

### AWS Setup

- **IAM** - ensure your IAM user has sufficient rights to perform Lambda/API Gateway/IAM policy/Cloudwatch log group creation and use
- **S3** - Prior to running this project for the first time, create an S3 bucket with **private** access and **versioning** enabled for Terraform state management


## TODO/Future Enhancements
- Automated API code deployment/testing via workflow based on S3 bucket API code update
- Automated API user create/use during flow/testing
- Look at using a tool such as Checkov to do static code analysis of the Terraform code
- Use JWT Tokens (Cognito/Oauth2 provider) for authentication


## License

[GNU General Public License v3.0](https://github.com/BladeRunner68/helloApp/blob/master/LICENSE)

