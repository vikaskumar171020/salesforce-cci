# ⚡ Salesforce CCI Automation (Salesforce DX & CumulusCI)

A modern **Salesforce DX** application repository built using standard `force-app` source format and fully orchestrated with **CumulusCI (CCI)** (`cumulusci.yml`). This project automates scratch org creation, feature branch builds, metadata deployment, Apex unit testing, LWC Jest testing, and end-to-end Robot Framework testing.

---

## 📌 Project Architecture

- **Project Type:** Salesforce DX (`sfdx-project.json`)
- **Package Directory:** [`force-app`](./force-app)
- **Source API Version:** `63.0`
- **Orchestration Tool:** [CumulusCI (`cumulusci.yml`)](./cumulusci.yml)
- **Scratch Org Definition:** [`config/project-scratch-def.json`](./config/project-scratch-def.json)

---

## 🛠️ Prerequisites & Initial Setup

Before running CumulusCI workflows, complete the following prerequisites:

1. **Install Required CLI Tools:**
   - [Salesforce CLI (`sf`)](https://developer.salesforce.com/tools/salesforcecli)
   - [CumulusCI (`cci`)](https://cumulusci.readthedocs.io/)
   - [Node.js & npm](https://nodejs.org/)

2. **Authenticate Dev Hub Org:**

   ```bash
   sf org login web --set-default-dev-hub --alias MyDevHub
   ```

3. **Connect CumulusCI to Dev Hub:**

   ```bash
   cci service connect devhub --username devhub --project
   ```

4. **Install Node Dependencies:**
   ```bash
   npm install
   ```

### 🔑 Dev Hub Service Management Commands

- **Check Active Dev Hub Connection:**
  ```bash
  cci service info devhub
  ```
- **List All Connected CCI Services:**
  ```bash
  cci service list
  ```
- **Connect / Switch Dev Hub Service:**
  ```bash
  cci service connect devhub --username <devhub-alias> --project
  ```
- **Disconnect Dev Hub Service:**
  ```bash
  cci service disconnect devhub
  ```

---

## 🔄 CumulusCI Feature & Scratch Org Generation

CumulusCI (CCI) automates creating isolated scratch orgs for development, quality assurance, feature verification, and release builds.

### Scratch Org Configurations

All scratch orgs are generated using [`config/project-scratch-def.json`](./config/project-scratch-def.json):

| Org Alias     | Duration | Purpose                                                               | Command to Build      |
| :------------ | :------- | :-------------------------------------------------------------------- | :-------------------- |
| **`dev`**     | 30 days  | Main development scratch org for building and testing unmanaged code. | `npm run cci:dev`     |
| **`qa`**      | 30 days  | Quality assurance org for verifying features before merging.          | `npm run cci:qa`      |
| **`feature`** | 1 day    | Short-lived scratch org for feature branch testing and PR validation. | `npm run cci:feature` |
| **`beta`**    | 1 day    | Pre-release and beta package verification org.                        | `npm run cci:beta`    |
| **`release`** | 30 days  | Final release packaging and validation org.                           | `npm run cci:release` |

---

## ⚙️ CumulusCI Automated Flows

CumulusCI flows orchestrate multi-step deployment and setup routines:

- **`dev_org`**: Provisions a `dev` scratch org, deploys unmanaged `force-app` metadata, and applies administrator profile configurations.
- **`feature_org`**: Custom flow that provisions a dev scratch org and deploys org settings.
- **`qa_org`**: Provisions a `qa` scratch org and deploys source metadata for quality assurance.
- **`qa_setup`**: Builds `qa_org` and executes full test validation.
- **`ci_feature`**: CI flow for feature branch validation (deploys unmanaged metadata into a `feature` org).
- **`ci_feature_test`**: Complete CI pipeline flow that builds the feature org and executes all Apex tests.

---

## 🤖 GitHub Actions Scratch Org Workflow

This repository includes a manual GitHub Actions workflow ([`.github/workflows/create-scratch-org.yml`](./.github/workflows/create-scratch-org.yml)) that provisions a scratch org using CumulusCI (`feature_org` flow), configures a custom admin email, generates the admin user password, and outputs full credentials into `scratch_org_credentials.md`.

### 🔑 GitHub Actions Prerequisites & Secret Setup

Before running the workflow, save your Dev Hub credentials as a GitHub secret:

1. **Export Dev Hub SFDX Auth URL:**

   ```bash
   sf org auth show-sfdx-auth-url --target-org <YourDevHubAlias> --json
   ```

2. **Set `DEVHUB_AUTH_URL` Secret via GitHub CLI (`gh`):**

   ```bash
   gh secret set DEVHUB_AUTH_URL --body "force://PlatformCLI::<your_sfdx_auth_url>"
   ```

3. **Switching / Changing Dev Hub Orgs:**
   To switch to a different Dev Hub org:
   ```bash
   sf org login web --set-default-dev-hub --alias MyNewDevHub
   sf org auth show-sfdx-auth-url --target-org MyNewDevHub --json
   gh secret set DEVHUB_AUTH_URL --body "force://PlatformCLI::<new_sfdx_auth_url>"
   ```

### 🚀 Running the Workflow

#### Option A: Via GitHub CLI (`gh`)

```bash
gh workflow run create-scratch-org.yml -f adminEmail="admin@yourcompany.com"
```

#### Option B: Via GitHub Web UI

1. Navigate to **Actions** tab on GitHub.
2. Select **Create Scratch Org with CumulusCI** workflow.
3. Click **Run workflow**, enter your **Admin Email** in the prompt, and click **Run workflow**.

### 📄 Generated Credential Files & Outputs

Once execution completes, the workflow:

- Generates a clean **`scratch_org_credentials.md`** containing:
  - Structured **Org Information Table** (Alias, Status, Org Name, Org ID, Username, Password, Instance URL, API Version, Created Date, Expire Date).
  - **CLI Auth Token (`force://...`)** retrieved via `sf org auth show-sfdx-auth-url`.
  - **CLI Login Instructions** for authenticating the scratch org on any machine.
- Strips ANSI control characters (`\x1b[...`) for clean Markdown presentation.
- Commits `scratch_org_credentials.md` directly back to the active feature branch content (not as an artifact).
- Renders the credentials in the GitHub Actions Job Summary.

---

### 🧪 Local GitHub Workflow Pipeline Testing (`npm run test:workflow`)

To test and validate the GitHub Actions workflow script locally **without consuming your Scratch Org creation quota** or making cloud CLI calls:

```bash
npm run test:workflow
```

Or execute the script directly:

```bash
./scripts/test-workflow-locally.sh
```

#### How Local Testing Works:

1. **Org Limit Protection**: Mocks the `cci` executable locally so `cci flow run feature_org --org dev` bypasses scratch org creation.
2. **Mocked JSON Data**: Simulates JSON responses for `sf org display`, `sf org generate password`, `sf org auth show-user-password`, and `sf org auth show-sfdx-auth-url`.
3. **Dynamic Script Extraction**: Parses `.github/workflows/create-scratch-org.yml` directly so the test always verifies the exact logic defined in your workflow file.
4. **Validation**: Verifies that `scratch_org_credentials.md` contains no ANSI codes, includes all required fields, valid `force://` SFDX auth tokens, and CLI authentication commands.

This project employs a multi-layered testing strategy across Apex, Lightning Web Components (LWC), and Browser UI.

### 1. Apex Class Unit Testing (On-Org)

Apex tests are executed inside active scratch orgs with an enforced code coverage threshold of **85%**.

- **Run Apex Tests via CumulusCI:**
  ```bash
  npm run cci:test:apex
  # Raw CCI: cci task run run_tests --org dev
  ```
- **Run Apex Tests via Salesforce CLI:**
  ```bash
  sf apex test run --target-org dev --code-coverage --result-format human
  ```
- **Apex Development Standards:**
  - All Apex code must be **bulkified** (never execute SOQL/DML in loops).
  - Enforce FLS/CRUD security using `WITH USER_MODE` or schema checks.
  - Utilize modular architecture (Selector, Service, Domain patterns) and unit test mocking (`DmlInterface`, `MockIdGenerator`).

### 2. Lightning Web Component (LWC) Unit Testing (Off-Org)

LWC unit tests are executed using Jest without requiring an active Salesforce org connection:

- **Run LWC Tests:** `npm test`
- **Run LWC Tests in Watch Mode:** `npm run test:unit:watch`
- **Run LWC Tests with Coverage Report:** `npm run test:unit:coverage`

### 3. Robot Framework UI Testing (Browser E2E)

Integration and UI tests are automated via Robot Framework:

- **Run Robot Tests:**
  ```bash
  npm run cci:test:robot
  # Raw CCI: cci task run robot --org dev
  ```

---

## 🚀 Complete NPM Command Reference

All CumulusCI and Salesforce CLI workflows can be triggered via `npm` scripts:

### Scratch Org Generation & Deployment Flows

| Action                          | NPM Command            | Underlying Command                           |
| :------------------------------ | :--------------------- | :------------------------------------------- |
| **Build Dev Scratch Org**       | `npm run cci:dev`      | `cci flow run dev_org --org dev`             |
| **Build Dev Org + Apex Tests**  | `npm run cci:dev:full` | `cci flow run dev_setup --org dev`           |
| **Build QA Scratch Org**        | `npm run cci:qa`       | `cci flow run qa_org --org qa`               |
| **Build QA Org + Apex Tests**   | `npm run cci:qa:full`  | `cci flow run qa_setup --org qa`             |
| **Build Feature Scratch Org**   | `npm run cci:feature`  | `cci flow run ci_feature --org feature`      |
| **Run CI Feature Flow + Tests** | `npm run cci:ci`       | `cci flow run ci_feature_test --org feature` |
| **Build Beta Scratch Org**      | `npm run cci:beta`     | `cci flow run dev_org --org beta`            |
| **Build Release Scratch Org**   | `npm run cci:release`  | `cci flow run dev_org --org release`         |

### Scratch Org Lifecycle Management

| Action                          | NPM Command                      | Underlying Command                |
| :------------------------------ | :------------------------------- | :-------------------------------- |
| **Create Dev Scratch Org**      | `npm run cci:org:create:dev`     | `cci org scratch dev dev`         |
| **Create QA Scratch Org**       | `npm run cci:org:create:qa`      | `cci org scratch qa qa`           |
| **Create Feature Scratch Org**  | `npm run cci:org:create:feature` | `cci org scratch feature feature` |
| **Create Beta Scratch Org**     | `npm run cci:org:create:beta`    | `cci org scratch beta beta`       |
| **Create Release Scratch Org**  | `npm run cci:org:create:release` | `cci org scratch release release` |
| **Open Dev Org in Browser**     | `npm run cci:org:open`           | `cci org browser dev`             |
| **Open QA Org in Browser**      | `npm run cci:org:open:qa`        | `cci org browser qa`              |
| **Open Beta Org in Browser**    | `npm run cci:org:open:beta`      | `cci org browser beta`            |
| **Open Release Org in Browser** | `npm run cci:org:open:release`   | `cci org browser release`         |
| **View Dev Org Info**           | `npm run cci:org:info`           | `cci org info dev`                |
| **View QA Org Info**            | `npm run cci:org:info:qa`        | `cci org info qa`                 |
| **View Beta Org Info**          | `npm run cci:org:info:beta`      | `cci org info beta`               |
| **View Release Org Info**       | `npm run cci:org:info:release`   | `cci org info release`            |
| **List All Active Orgs**        | `npm run cci:org:list`           | `cci org list`                    |
| **Delete Dev Scratch Org**      | `npm run cci:org:delete`         | `cci org scratch_delete dev`      |
| **Delete QA Scratch Org**       | `npm run cci:org:delete:qa`      | `cci org scratch_delete qa`       |
| **Delete Beta Scratch Org**     | `npm run cci:org:delete:beta`    | `cci org scratch_delete beta`     |
| **Delete Release Scratch Org**  | `npm run cci:org:delete:release` | `cci org scratch_delete release`  |

### Code Quality, Testing & Formatting

| Action                           | NPM Command               | Underlying Command                      |
| :------------------------------- | :------------------------ | :-------------------------------------- |
| **Test GitHub Workflow Locally** | `npm run test:workflow`   | `bash scripts/test-workflow-locally.sh` |
| **Lint LWC/Aura Code**           | `npm run lint`            | `eslint **/{aura,lwc}/**/*.js ...`      |
| **Format All Project Files**     | `npm run prettier`        | `prettier --write ...`                  |
| **Check Code Formatting**        | `npm run prettier:verify` | `prettier --check ...`                  |

---

## 🎨 Pre-commit & Quality Hooks

This repository uses **Husky** and **lint-staged** to automatically run Prettier code formatting and ESLint static code analysis before every `git commit`.
