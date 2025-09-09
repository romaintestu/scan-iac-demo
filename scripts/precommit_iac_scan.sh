#!/usr/bin/env bash
set -euo pipefail


# Requires lacework CLI + iac component installed locally and configured.
# Scans staged IaC files before commit.


changed=$(git diff --cached --name-only | grep -E '^(infra/).+\.(tf|tfvars|yaml|yml|json|tpl)$' || true)


if [[ -z "$changed" ]]; then
echo "[lacework] No IaC changes staged. Skipping."
exit 0
fi


echo "[lacework] Scanning staged IaC files..."
# You can scan the parent folder once for performance; here we scan infra/
lacework iac scan --path infra --severity-threshold high --fail-on-policy
