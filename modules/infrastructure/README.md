# Terraform Module  Kind K8S Cluster And An S3 Bucket In Localstack

This repository contains Terraform configurations for setting up and managing infrastructure.

## Requirements
- Terraform v1.0 or later
- AWS CLI or another cloud provider's CLI installed and configured (if applicable)
Notes
- Ensure that your Terraform environment is properly configured with the necessary access to your cloud provider.
- Regularly update your providers to the latest version to avoid potential compatibility issues.

> **Note**
> If you are using Mac M1 Chip then follow the details (here)[https://discuss.hashicorp.com/t/template-v2-2-0-does-not-have-a-package-available-mac-m1/35099/39#:~:text=Please%20follow%20the%20steps%20given%20below,to%20%40AyushKumar55%20for%20the%20help.] to avoid compatibility issues

## Files Overview

- **`cluster.tf`**:
  - Contains the configuration for the Kubernetes cluster, including the creation of nodes, networking, and other cluster-related resources.

- **`outputs.tf`**:
  - Defines the outputs for the Terraform configurations. These outputs provide information about the resources created, such as cluster endpoint, node IDs, etc.

- **`providers.tf`**:
  - Configures the necessary providers for the Terraform project. This includes defining the cloud provider (e.g., AWS, GCP, Azure) and any other required providers like Helm or Kubernetes.

- **`s3.tf`**:
  - Manages the configuration related to S3 buckets, such as creation, access policies, and bucket lifecycle rules. This file is specifically used for managing S3 resources.

- **`variables.tf`**:
  - Declares all the input variables used in the Terraform configurations. These variables allow for customization and reusability of the Terraform code by changing values without modifying the code.



## Contributing
If you'd like to contribute to this Terraform project, please open a pull request or issue with your proposed changes.

## License
This project is licensed under the MIT License.