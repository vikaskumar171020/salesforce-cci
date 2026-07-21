# ⚡ AgentForce CRM (Salesforce DX & CumulusCI)

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
- **`dev_setup`**: Custom flow that builds the `dev_org` environment and immediately runs all Apex unit tests to ensure environment integrity.
- **`qa_org`**: Provisions a `qa` scratch org and deploys source metadata for quality assurance.
- **`qa_setup`**: Builds `qa_org` and executes full test validation.
- **`ci_feature`**: CI flow for feature branch validation (deploys unmanaged metadata into a `feature` org).
- **`ci_feature_test`**: Complete CI pipeline flow that builds the feature org and executes all Apex tests.

---

## 🧪 Testing & Quality Assurance Workflows

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

### Code Quality, Linting & Formatting

| Action                       | NPM Command               | Underlying Command                 |
| :--------------------------- | :------------------------ | :--------------------------------- |
| **Lint LWC/Aura Code**       | `npm run lint`            | `eslint **/{aura,lwc}/**/*.js ...` |
| **Format All Project Files** | `npm run prettier`        | `prettier --write ...`             |
| **Check Code Formatting**    | `npm run prettier:verify` | `prettier --check ...`             |

---

## 🎨 Pre-commit & Quality Hooks

This repository uses **Husky** and **lint-staged** to automatically run Prettier code formatting and ESLint static code analysis before every `git commit`.
