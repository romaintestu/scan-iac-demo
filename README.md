# scan-iac-demo

# Lacework IaC Scanning Template


This repo demonstrates how to run **Lacework IaC scanning** in GitHub Actions and block risky changes before merge.


## What you get
- ✅ GitHub Actions workflow scanning Terraform/K8s on PR & push.
- ✅ Build fails on **High/Critical** by default (`--fail-on-policy`)
- ✅ SARIF results uploaded to the Security tab
- ✅ (Optional) pre-commit hook to catch issues locally


## Prereqs
- Lacework account (Code Security enabled)
- Create GitHub repository **secrets**:
- `LW_ACCOUNT_NAME`
- `LW_API_KEY`
- `LW_API_SECRET`


> Alternatively you can use an **access token**. Adjust the workflow if you prefer `LW_ACCESS_TOKEN`.


## How it works
- On PR/push, the workflow installs the Lacework CLI + IaC component and scans the `infra/` directory.
- The job fails on high-risk findings (threshold configurable) and uploads SARIF.


## Run locally (optional)
- Install Lacework CLI: `curl -sSL https://get.lacework.net/cli | bash`
- `lacework component install iac`
- `lacework configure -a <account> -k <api_key> -s <api_secret> --noninteractive`
- `lacework iac scan --path infra --severity-threshold high`


## Exception handling
Use repo discussions/PRs to track exceptions; keep them minimal and time‑boxed. You can also manage exceptions centrally within Lacework policies.


## Folder structure
- `infra/terraform`: demo Terraform with intentional misconfigs (for testing)
- `infra/kubernetes`: demo K8s manifest with unsafe settings (for testing)


## Security & governance tips
- Lock `main` with branch protection + required checks
- Add CODEOWNERS (security/platform) for `infra/**`
- Use Dependabot to keep Actions up-to-date
