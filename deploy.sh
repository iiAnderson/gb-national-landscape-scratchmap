#!/usr/bin/env bash
#
# Publish the site. Everything under site/ is served as-is.
#
#   ./deploy.sh
#
set -euo pipefail
cd "$(dirname "$0")"

BUCKET="${SITE_BUCKET:-$(terraform -chdir=terraform output -raw bucket_name)}"
DISTRIBUTION="${DISTRIBUTION_ID:-$(terraform -chdir=terraform output -raw distribution_id)}"

aws s3 sync site/ "s3://$BUCKET/" --delete
echo "deployed to s3://$BUCKET/"

# The page has an hour-long TTL, so without this a deploy is invisible for up
# to an hour.
if [ -n "$DISTRIBUTION" ]; then
  ID=$(aws cloudfront create-invalidation --distribution-id "$DISTRIBUTION" \
         --paths '/' '/index.html' \
         --query 'Invalidation.Id' --output text)
  echo "invalidating $DISTRIBUTION ($ID)"
  aws cloudfront wait invalidation-completed --distribution-id "$DISTRIBUTION" --id "$ID"
  echo "invalidation complete"
fi
