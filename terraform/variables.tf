variable "project_name" {
  description = "Name prefix for created resources. Also the S3 bucket name, so it must be globally unique."
  type        = string
  default     = "robbiea-parks"
}

variable "region" {
  description = "Region for the origin bucket."
  type        = string
  default     = "eu-west-1"
}

variable "domain_name" {
  description = "Hostname the site is served from."
  type        = string
  default     = "parks.robbiea.co.uk"
}

variable "hosted_zone_id" {
  description = "Route 53 hosted zone containing domain_name (the robbiea.co.uk zone)."
  type        = string
}

variable "price_class" {
  description = "CloudFront price class. PriceClass_100 is North America and Europe only, and is the cheapest."
  type        = string
  default     = "PriceClass_100"
}

variable "page_cache_seconds" {
  description = "How long CloudFront caches the page. deploy.sh invalidates, so a long value is safe."
  type        = number
  default     = 3600
}

variable "tags" {
  description = "Tags applied to every resource."
  type        = map(string)
  default     = {}
}

variable "site_user" {
  description = "Username for the browser sign-in prompt."
  type        = string
  default     = "parks"
}

variable "site_password" {
  description = "Password for the browser sign-in prompt. Supply it as TF_VAR_site_password so it never lands in a file."
  type        = string
  sensitive   = true
}
