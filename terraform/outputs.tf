output "bucket_name" {
  description = "Origin bucket. deploy.sh reads this."
  value       = aws_s3_bucket.site.id
}

output "distribution_id" {
  description = "CloudFront distribution. deploy.sh reads this to invalidate."
  value       = aws_cloudfront_distribution.site.id
}

output "site_url" {
  description = "Where the site is served."
  value       = "https://${var.domain_name}"
}
