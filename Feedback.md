Please share any feedback with us here (if we missed anything or if you have any suggestions for us to improve)

# Feedback
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
