# AWS EC2 Instance Creation with Terraform

This project provides a simple Terraform script to create an AWS EC2 instance named `APPSER1`. The script also includes the creation of a security group with basic inbound and outbound rules.

## Prerequisites

Before you begin, ensure you have the following installed:

- [Terraform](https://www.terraform.io/downloads.html) (v0.12 or higher)
- AWS account credentials configured (`~/.aws/credentials`)

## Project Structure

```plaintext
.
├── main.tf            # Core Terraform script
└── variables.tf       # Optional: Variables for customization
