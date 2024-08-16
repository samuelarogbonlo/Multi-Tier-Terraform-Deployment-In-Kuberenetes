# Multi-Tier Terraform Module For A Simple S3 App On Kuberenetes

![Components Infrastructure](https://github.com/user-attachments/assets/aab7f02c-d1be-4dd6-840e-04bfc3265591)

This repository gives details on how you can implement Terraform modules that will create a test infrastructure cluster for a simple S3 App and deploy there as well. The consists of two layers (two Terraform workspaces):

- **Infrastructure**: A local k8s cluster created with kind, a mock of an S3 bucket (with the help of Localstack, and a configuration file placed in the bucket)
- **Deployment**: An nginx-ingress controller that is configured and deployed in the kind cluster, and the simple S3 App that is deployed in the cluster and available locally via an Ingress.

## Requirements
- Docker
- kubectl
- kind
- Terraform
- GNU Make
- bash
- curl
- jq

## Running The Infrastructure
In order to run the infrastructure, you need to refer to the README.md file in the `modules/infrastructure` and `modules/deploy` directory.

## Makefile Details

The main entrypoint to invoke different commands from the test framework:

- **make apply**: Apply both Terraform workspaces, one after another
- **make apply-cluster**: Apply the 01-cluster-create Terraform workspace
- **make apply-deploy**: Apply the 02-app-deploy Terraform workspace
- **make check-todos**: Check all TODOs were addressed
- **make check-tools**: Check all required tools are installed
- **make localstack-start**: Start Localstack locally with all the correct configurations
- **make full-test**: Run the full testing suite
- **make test**: Check that the S3 app works correctly and the Terraform outputs are correct
- **make destroy**: Destroy both Terraform workspaces, one after another
- **make help**: Display this help
- **make localstack-stop**: Stop Localstack

# Collaborators
- [YOUR NAME HERE] - Feel free to contribute to the codebase by resolving any open issues, refactoring, adding new features, writing test cases, or doing anything else to make the project better and helpful to the community. Please feel free to send pull requests.

# Maintainers
[@samuelarogbonlo](https://github.com/samuelarogbonlo)

## License
This project is licensed under the MIT License.
