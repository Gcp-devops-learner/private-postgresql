# Cloud SQL Database Example

This example shows how to create the Private MySQL Cloud SQL database in a shared VPC Network in the host netowrk using the Terraform module.

## Run Terraform

Create resources with terraform:

```bash
terraform init
terraform plan
terraform apply
```

To remove all resources created by terraform:

```bash
terraform destroy
```

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| authorized\_networks | List of mapped public networks authorized to access to the instances. Default - short range of GCP health-checkers IPs | `list(map(string))` | <pre>[<br>  {<br>    "name": "sample-gcp-health-checkers-range",<br>    "value": "130.211.0.0/28"<br>  }<br>]</pre> | no |
| db\_name | The name of the SQL Database instance | `string` | `"example-postgres-private"` | no |
| project\_id | The ID of the project in which resources will be provisioned. | `string` | n/a | yes |
| vpc\_network| The shared VPC network to provision the postgresql database. This shared network should be shared with the service project | `string` | n/a | yes |
| shared\_host\_project\_id | The Project ID of the shared host project | `string` | n/a | yes |


## IAP Bastion
Refer to the below url for documentation
https://github.com/terraform-google-modules/terraform-google-bastion-host
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## Private MySQL
Refer to the below url for documentation
https://github.com/terraform-google-modules/terraform-google-sql-db/tree/master/modules/safer_mysql

## Cloud NAT
Refer to the below url for documentation
https://github.com/terraform-google-modules/terraform-google-cloud-nat