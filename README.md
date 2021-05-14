# AWS S3 & Cloudfront Terraform Demo

Built as part of a flash talk "Intro to Terraform". The Terraform scripts included will deploy an S3 website bucket, upload the contents of the `public` folder, and deploy a Cloudfront Distribution.

## How to use

Prerequisite is to have Terraform `v0.15.3` or higher installed.

- Clone this repo.
- Go to `terraform` directory.
- Run `terraform init`.
- Run `terraform apply`.
- S3 & Cloudfront URLs will be output.
