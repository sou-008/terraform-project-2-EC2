# Flask and Express Deployment on Separate EC2 Instances using Terraform

## Project Overview
This project demonstrates how to deploy both a Flask backend and an Express frontend on two separate EC2 instances using Terraform. The goal is to provision two EC2 instances, install the necessary dependencies, and run each application on its own instance:

<br>Flask backend on port 5000
<br>Express frontend on port 3000

## Prerequisites
**Before starting, ensure you have the following:**

1. AWS Account: An AWS account with appropriate permissions to create resources.
2. Terraform: Terraform installed on your local machine. Terraform Installation Guide
3. AWS CLI: The AWS CLI configured with your AWS credentials. AWS CLI Setup Guide
4. SSH Key: An SSH key pair created in the AWS region you're deploying the EC2 instances in (to access the EC2 instances).

## Folder Structure

/terraform-project-2-EC2  
│ ├── main.tf           # Main Terraform configuration  
│ ├── variables.tf      # Terraform variables  
│ ├── outputs.tf        # Terraform outputs  
│ ├── user-data/        # Folder containing user data scripts  
│ │ ├── flask.sh        # User data script for Flask EC2 instance  
│ │ └── express.sh      # User data script for Express EC2 instance  
│ └── README.md         # Project readme  
└── .gitignore          # Git ignore file  


---

## Terraform Configuration Files

### `main.tf` - Terraform Configuration
This file contains the main configuration for provisioning the EC2 instances and other AWS resources. It includes:
- Defining the AWS provider and region.
- Provisioning two EC2 instances (one for Flask and one for Express).
- Attaching security groups to allow inbound traffic for the respective ports (5000 for Flask and 3000 for Express).
- Executing user data scripts to set up Flask and Express apps on the EC2 instances.

### `variables.tf` - Terraform Variables
This file defines all the variables used in the `main.tf` configuration. It is designed for reusability and scalability of the infrastructure code.

### `outputs.tf` - Terraform Outputs
This file outputs the public IP addresses of both EC2 instances, allowing easy access to the Flask and Express applications.

---

## EC2 User Data Scripts

The `user-data/` folder contains two shell scripts used to configure and run the applications on the respective EC2 instances during instance initialization.

### `flask.sh`
This script installs the necessary dependencies for the Flask app (such as Python, pip, Flask) and runs the Flask app on port 5000.

### `express.sh`
This script installs the necessary dependencies for the Express app (such as Node.js, npm, Express) and runs the Express app on port 3000.

---

## Steps to Deploy

### Step 1: Set Up AWS CLI and Terraform
- Install the **AWS CLI** and configure it using `aws configure`.
- Install **Terraform** if you haven't already.
- Ensure your SSH key is available to use for the EC2 instance.

**Initialize Terraform**
Run the following command to initialize the Terraform working directory:
- `terraform init`

**Review the Deployment Plan**
Run the following command to review the Terraform deployment plan:
- `terraform plan`

**Apply the Terraform Configuration**
Run the following command to apply the Terraform configuration and provision the EC2 instances:
- `terraform apply`
Type yes when prompted to confirm the deployment.

**Access the Application**
Once the deployment is complete, Terraform will output the public IP addresses of the EC2 instances. Use these IPs to access your applications:
- Flask Application: http://<Flask-Instance-Public-IP>:5000
- Express Application: http://<Express-Instance-Public-IP>:3000

**Troubleshooting**
- Ensure that your EC2 instance's security group allows inbound traffic on ports 5000 and 3000.
- If you face issues with dependencies, check the application logs or verify if the required packages are installed.
- Ensure your security groups are properly configured for both EC2 instances.

**Clean Up**
To remove the resources created by Terraform:
- `terraform destroy`

This will tear down the EC2 instances and other associated resources.

**Conclusion**
This project demonstrates the deployment of both Flask and Express applications on separate EC2 instances using Terraform. The provided configuration files and scripts ensure that both applications are installed and run on separate ports.