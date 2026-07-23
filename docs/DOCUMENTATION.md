# ⚡ AgentForce CRM — Complete GitHub Actions & CumulusCI Technical Guide

This repository orchestrates a **Salesforce DX** project with **CumulusCI (CCI)** and automated **GitHub Actions workflows**.

---

## 📌 Architecture Summary

- **Package Directory:** `force-app` (API Version 66.0)
- **CCI Configuration:** `cumulusci.yml`
- **Scratch Org Definition:** `config/project-scratch-def.json`
- **CI/CD Workflow:** `.github/workflows/create-scratch-org.yml`
- **CCI Configuration:** `cumulusci.yml`
- **Scratch Org Definition:** `config/project-scratch-def.json`
- **CI/CD Workflow:** `.github/workflows/create-scratch-org.yml`
- **Output Credential File:** `scratch_org_credentials.md` (committed directly to feature branches as branch content)

---

## 🔑 Dev Hub Setup & Secret Configuration

Before invoking GitHub Actions workflows, connect your Salesforce Dev Hub org:

```bash
# 1. Login to Dev Hub locally
sf org login web --set-default-dev-hub --alias MyDevHub

# 2. Extract SFDX Auth URL
sf org auth show-sfdx-auth-url --target-org MyDevHub --json

# 3. Save secret to GitHub Repository via GitHub CLI (gh)
gh secret set DEVHUB_AUTH_URL --body "force://PlatformCLI::<your_copied_auth_url>"
```

### Switching Dev Hub Orgs

To switch the Dev Hub used by GitHub Actions in the future:

```bash
sf org login web --set-default-dev-hub --alias NewDevHub
sf org auth show-sfdx-auth-url --target-org NewDevHub --json
gh secret set DEVHUB_AUTH_URL --body "force://PlatformCLI::<new_auth_url>"
```

---

## 🚀 Triggering the GitHub Actions Workflow

The workflow is configured with `workflow_dispatch` and requires an `adminEmail` parameter.

### Via GitHub CLI:

```bash
gh workflow run create-scratch-org.yml -f adminEmail="admin@company.com"
```

### Via GitHub Web UI:

1. Go to **Actions** ➔ **Create Scratch Org with CumulusCI**.
2. Click **Run workflow**.
3. Enter your **Admin Email** in the prompt and click **Run workflow**.

---

## 📄 Output Credential File (`scratch_org_credentials.md`)

When execution completes, the workflow generates `scratch_org_credentials.md` containing:

- CumulusCI Feature Org Setup Output (`cci flow run feature_org --org dev`)
- Password Generation Output (`sf org generate password --target-org <username>`)
- User Password Output (`sf org auth show-user-password --target-org <username>`)
- Org Display Details (`sf org display --target-org <username>`)

The file is automatically committed to your branch (`ci: save scratch org credentials markdown file [skip ci]`) and appended to the GitHub Job Summary.

---

## ⚙️ Key Technical Fixes Applied

1. **`set_password: false` in `cumulusci.yml`**: Prevents token invalidation mid-flow during metadata deployment.
2. **`CUMULUSCI_KEY: "1234567890abcdef"`**: Fixes Python's `keyrings.alt` pickle decoding error in headless Linux CI environments.
3. **Removed `einsteinGptSettings`**: Resolves `ProblemDeployingSettings` error in Developer edition Dev Hubs.
4. **Unified Workflow Step**: Combines org creation, setup, password generation, and markdown export into a single step to prevent duplicate scratch org creations.

---

## 🌐 GitHub Pages Publishing Instructions

To enable GitHub Pages for this repository:

1. Go to your repository settings on GitHub: `https://github.com/vikaskumar171020/salesforce-cci/settings/pages`
2. Under **Build and deployment** ➔ **Source**, select **Deploy from a branch**.
3. Under **Branch**, select `main` and folder `/docs`.
4. Click **Save**.
