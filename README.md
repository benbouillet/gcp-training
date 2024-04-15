# Personal GCP training

This repository acts as a personal knowledge for acquiring skills at managing an
IaC stack in GCP.

## Quick start

The CI/CD is containerized and should be handled via `docker-compose`.

To build the CI/CD container:

```bash
./ci.sh build
```

To deploy the stack:

```bash
./ci.sh deploy
```

To destroy the stack:

```bash
./ci.sh destroy
```

> Note: you can use the flag `AUTOAPPROVE=1` to avoid the interactive user confirmation:
>
> ```bash
> AUTOAPPROVE=1 ./ci.sh deploy
> ```
>
> This works for both `deploy` & `destroy`.

> Note2: the containerized CI/CD always deletes the `.terraform` folder
> to avoid cross-architecture issues.
> You can override this behavior by setting the environment variable `NONIT=1`
>
> ```bash
> NOINIT=1 ./ci.sh deploy
> ```
>
> This works for both `deploy` & `destroy`.

## Pre-requisites

### Packages

- `docker` - `~> 25`

### Authentication & Permissions

This repository is only compatible with [Application Default Credentials (ADC)](https://cloud.google.com/docs/authentication/application-default-credentials)
authent as of now.

You are expected to set environment variable `GOOGLE_APPLICATION_CREDENTIALS`
with the `.json` credentials file path (pending better authentication management).

### Variables

Apart from the terraform variables that are not defined in `terraform.tfvars`
and must be defined in a dedicated `.env` (with the `TF_VAR_` prefix), you must
set up the following environment variable (ideally in a `.env` file):

* `GOOGLE_APPLICATION_CREDENTIALS`: the path the to ADC `.json` file as stated
  above
* `INFRA_BUCKET: the name of the GSC bucket to use to manage the terraform
  state (the bucket is not part of the IaC stack and must be created separately)
* `INFRACOST_API_KEY` (optional): the [infracost](https://www.infracost.io/)
  API Key to estimated costs before any `terraform apply`

## Architecture

The Terraform section deploys & manages:

- a dedicated VPC network (this is only the bootstrap!)

## Roadmap

- [x] deploy a public Compute instance (with SSH connectivity over the internet)
- [ ] deploy a private Compute instance behind NAT (with Cloud IAP)
- [ ] deploy a bucket
- [ ] deploy CloudSQL and ensure connectivity with Compute Instance(s)
- [ ] deploy a Load Balancer in front of several Compute Instances with HTTPS
- [ ] deploy MemoryStore (Redis)
- [ ] deploy a serverless fonction
- [ ] deploy the Datadog integration
- [ ] deploy GKE

## Development

The following dependencies are required for development:

* `tflint`
* `terraform-docs`
* `pre-commit`

## Resources

- [Google Cloud Region Picker](https://googlecloudplatform.github.io/region-picker/):
  This tool helps you pick a Google Cloud region considering approximated carbon
  footprint, price and latency.
- [Google Cloud Platform Pricing](https://gcloud-compute.com/): This webapp
  helps to find the optimal Google Compute Engine (GCE) machine type or instance
  in the many Google Cloud Platform (GCP) regions:
  - [Google Compute Engine Machine Types](https://gcloud-compute.com/instances.html):
    instances specs comparison
  - [Google Cloud Platform Regions](https://gcloud-compute.com/regions.html):
    region comparison
  - [Google Compute Engine Operating System Images](https://gcloud-compute.com/images.html):
    Compute Engine images comparison
  - [Instance picker](https://gcloud-compute.com/grid.html): complete table for instance
    comparison (with prices per region)
- [Google pricing](https://cloud.google.com/pricing/list?hl=en)

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | 1.7.5 |
| <a name="requirement_external"></a> [external](#requirement\_external) | ~> 2.3.3 |
| <a name="requirement_google"></a> [google](#requirement\_google) | 5.24.0 |
| <a name="requirement_http"></a> [http](#requirement\_http) | 3.4.2 |
| <a name="requirement_random"></a> [random](#requirement\_random) | 3.6.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_external"></a> [external](#provider\_external) | 2.3.3 |
| <a name="provider_google"></a> [google](#provider\_google) | 5.24.0 |
| <a name="provider_http"></a> [http](#provider\_http) | 3.4.2 |
| <a name="provider_random"></a> [random](#provider\_random) | 3.6.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_public_instance"></a> [public\_instance](#module\_public\_instance) | ./public_instance/ | n/a |

## Resources

| Name | Type |
|------|------|
| [google_compute_firewall.ssh_to_instance_ipv4](https://registry.terraform.io/providers/hashicorp/google/5.24.0/docs/resources/compute_firewall) | resource |
| [google_compute_network.vpc](https://registry.terraform.io/providers/hashicorp/google/5.24.0/docs/resources/compute_network) | resource |
| [google_compute_subnetwork.public](https://registry.terraform.io/providers/hashicorp/google/5.24.0/docs/resources/compute_subnetwork) | resource |
| [random_pet.stack](https://registry.terraform.io/providers/hashicorp/random/3.6.0/docs/resources/pet) | resource |
| [external_external.git](https://registry.terraform.io/providers/hashicorp/external/latest/docs/data-sources/external) | data source |
| [google_compute_zones.available](https://registry.terraform.io/providers/hashicorp/google/5.24.0/docs/data-sources/compute_zones) | data source |
| [http_http.local_ipv4](https://registry.terraform.io/providers/hashicorp/http/3.4.2/docs/data-sources/http) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_client_name"></a> [client\_name](#input\_client\_name) | n/a | `string` | n/a | yes |
| <a name="input_environment"></a> [environment](#input\_environment) | n/a | `string` | n/a | yes |
| <a name="input_gcp_project_id"></a> [gcp\_project\_id](#input\_gcp\_project\_id) | Google Cloud Project | `string` | n/a | yes |
| <a name="input_gcp_region"></a> [gcp\_region](#input\_gcp\_region) | Default GCP Region | `string` | n/a | yes |
| <a name="input_instances_user"></a> [instances\_user](#input\_instances\_user) | Default user used to connect to the compute instances | `string` | n/a | yes |
| <a name="input_project_name"></a> [project\_name](#input\_project\_name) | n/a | `string` | n/a | yes |
| <a name="input_project_owner"></a> [project\_owner](#input\_project\_owner) | n/a | `string` | n/a | yes |
| <a name="input_technical_owner"></a> [technical\_owner](#input\_technical\_owner) | n/a | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_instance_public_ip"></a> [instance\_public\_ip](#output\_instance\_public\_ip) | n/a |
| <a name="output_instance_ssh_private_key"></a> [instance\_ssh\_private\_key](#output\_instance\_ssh\_private\_key) | n/a |
| <a name="output_instance_user"></a> [instance\_user](#output\_instance\_user) | n/a |
<!-- END_TF_DOCS -->
