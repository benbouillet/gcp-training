# Personal GCP training

This repository acts as a personal knowledge for acquiring skills at managing an
IaC stack in GCP.

## Quick start

The CI/CD is containerized and should be handled via `docker-compose`.

To build the CI/CD container:

```bash
docker compose build
```

To deploy the stack:

```bash
docker compose run --rm ci deploy
```

To destroy the stack:

```bash
docker compose run --rm ci destroy
```

> Note: you can use the flag `AUTOAPPROVE=1` to avoid the interactive user confirmation:
>
> ```bash
> AUTOAPPROVE=1 docker compose run --rm ci deploy
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

## Architecture

The Terraform section deploys & manages:

- a dedicated VPC network (this is only the bootstrap!)

## Roadmap

- [ ] deploy a public Compute instance (with SSH connectivity over the internet)
- [ ] deploy a private Compute instance behind NAT (with Cloud IAP)
- [ ] deploy a bucket
- [ ] deploy CloudSQL and ensure connectivity with Compute Instance(s)
- [ ] deploy a Load Balancer in front of several Compute Instances with HTTPS
- [ ] deploy MemoryStore (Redis)
- [ ] deploy a serverless fonction
- [ ] deploy the Datadog integration
- [ ] deploy GKE

## Resources

- [Google Cloud Region Picker](https://googlecloudplatform.github.io/region-picker/):
  This tool helps you pick a Google Cloud region considering approximated carbon
  footprint, price and latency.
- [Google Cloud Platform Pricing](https://gcloud-compute.com/): This webapp
  helps to find the optimal Google Compute Engine (GCE) machine type or instance
  in the many Google Cloud Platform (GCP) regions:
  - [Google Compute Engine Machine Types](https://gcloud-compute.com/instances.html):
    instances specs comparison
  - [Google Cloud Platform Regions](https://gcloud-compute.com/regions.htmlI):
    region comparison
  - [Google Compute Engine Operating System Images](https://gcloud-compute.com/images.html):
    Compute Engine images comparison
  - [Instance picker](https://gcloud-compute.com/grid.html): complete table for instance
    comparison (with prices per region)

<!-- BEGIN_TF_DOCS -->

<!-- END_TF_DOCS -->
