# parks.robbiea.co.uk

Britain's Protected Landscapes — a single self-contained HTML page, served from a
private S3 bucket behind CloudFront at `parks.robbiea.co.uk`.

The Terraform creates the bucket, an ACM certificate (issued in `us-east-1` and
DNS-validated in the existing `robbiea.co.uk` Route 53 zone), the CloudFront
distribution and the `A`/`AAAA` alias records. Nothing is created by hand.

## Deploying

```sh
cp terraform/terraform.tfvars.example terraform/terraform.tfvars   # first time only; set hosted_zone_id
cd terraform && terraform init && terraform apply
cd .. && ./deploy.sh
```

`deploy.sh` syncs `site/` to the bucket and invalidates CloudFront. Edit
`site/index.html` and re-run it to publish changes. `terraform.tfvars` and state
are gitignored.
