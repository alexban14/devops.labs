#!/bin/bash

# Replace these with your ACTUAL OAuth credentials
OAUTH_CLIENT_ID="k6B1dskFvM11CNTRL"
OAUTH_CLIENT_SECRET="tskey-client-k6B1dskFvM11CNTRL-jpN5qzSodxdWnGnhHcxywdKAt2571oE4"

echo "Updating Tailscale operator with correct OAuth credentials..."

# Upgrade the Helm installation with correct credentials
helm upgrade tailscale-operator tailscale/tailscale-operator \
  --namespace=tailscale \
  --set-string oauth.clientId="$OAUTH_CLIENT_ID" \
  --set-string oauth.clientSecret="$OAUTH_CLIENT_SECRET" \
  --wait

echo "Waiting for operator to restart..."
kubectl rollout status deployment/operator -n tailscale

echo "Checking operator logs..."
kubectl logs -n tailscale -l app=operator --tail=10
