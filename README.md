# Camunda Infrastructure Experience Interview: Coding Challenge

Please refer to the documentation about the challenge: [document](https://docs.google.com/document/d/1Y2urs8QjpTjGHdmul-bO5kg4K_wtj-vBsn5Ipf4g9SI/edit)

## `Makefile`

The main entrypoint to invoke different commands from the test framework:

- **make apply**: Apply both Terraform workspaces, one after another
- **make apply-cluster**: Apply the 01-cluster-create Terraform workspace
- **make apply-deploy**: Apply the 02-app-deploy Terraform workspace
- **make check-todos**: Check all TODOs were addressed
- **make check-tools**: Check all required tools are installed
- **make destroy**: Destroy both Terraform workspaces, one after another
- **make full-test**: Run the full testing suite
- **make help**: Display this help
- **make localstack-start**: Start Localstack locally with all the correct configurations
- **make localstack-stop**: Stop Localstack
- **make test**: Check that the S3 app works correctly and the Terraform outputs are correct

You don't need to change this file.

## `Feedback.md`

- There is an inconsistency in the output hence the need for a change of versions in the `test.sh` file in line 62.

The expected value was `1.8.1` but the version used in the main.tf file was `4.7.1` and it gave avoid the error below:

```bash
[Fri Aug  9 07:20:49 WAT 2024] [TEST] Check the Terraform 02-app-deploy has a correct output: nginx_ingress_app_version
[Fri Aug  9 07:20:49 WAT 2024] --------------------------------------------------
[Fri Aug  9 07:20:49 WAT 2024] [INFO] nginx_ingress_app_version=4.7.1
[Fri Aug  9 07:20:49 WAT 2024] [FAIL] Check for nginx_ingress_app_version did not pass
[Fri Aug  9 07:20:49 WAT 2024] [INFO] Expected: 4.7.1
[Fri Aug  9 07:20:49 WAT 2024] [INFO] Got: 1.8.1
/Library/Developer/CommandLineTools/usr/bin/make destroy || ( /Library/Developer/CommandLineTools/usr/bin/make end-log ; exit 1 )
./scripts/destroy.sh
```

However, after chaning the value of the version to `4.7.1`, the results is shown thus:
```bash
[Fri Aug  9 08:36:47 WAT 2024] [TEST] Check the Terraform 01-cluster-create has a correct output: cluster_endpoint
[Fri Aug  9 08:36:47 WAT 2024] --------------------------------------------------
[Fri Aug  9 08:36:47 WAT 2024] [INFO] Trying to connect to cluster_endpoint: curl https://127.0.0.1:64085 --silent -k
[Fri Aug  9 08:36:47 WAT 2024] [INFO] cluster_endpoint=https://127.0.0.1:64085
[Fri Aug  9 08:36:47 WAT 2024] [PASS] Check for cluster_endpoint passed
[Fri Aug  9 08:36:47 WAT 2024] --------------------------------------------------
[Fri Aug  9 08:36:47 WAT 2024] [TEST] Check the Terraform 02-app-deploy has a correct output: nginx_ingress_app_version
[Fri Aug  9 08:36:47 WAT 2024] --------------------------------------------------
[Fri Aug  9 08:36:47 WAT 2024] [INFO] nginx_ingress_app_version=4.7.1
[Fri Aug  9 08:36:47 WAT 2024] [PASS] Check for nginx_ingress_app_version passed
/Library/Developer/CommandLineTools/usr/bin/make destroy || ( /Library/Developer/CommandLineTools/usr/bin/make end-log ; exit 1 )
./scripts/destroy.sh
```


## `01-cluster-create`

The Terraform workspace to create a kind k8s cluster and an S3 bucket in Localstack.

Relies on the module in `modules/infrastucture`.

You don't need to edit it.

## `02-app-deploy`

The Terraform workspace to deploy an nginx controller and an S3 app into the kind cluster.

Relies on the module in `modules/deploy`.

You don't need to edit it.

## `modules/infrastructure`

The Terraform module to create a kind k8s cluster and an S3 bucket in Localstack.

You need to implement this module.

## `modules/deploy`

The Terraform module to deploy an nginx controller and an S3 app into the kind cluster.

You need to implement this module.

## `scripts`

Auxiliary scripts used by the aforementioned `make` targets.

You don't need to edit these files.

You don't need to run them directly (use the aforementioned `make` targets).
