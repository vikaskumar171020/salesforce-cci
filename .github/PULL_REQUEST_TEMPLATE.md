# Pull Request Description Guide & Template

> 💡 **New to opening Pull Requests in this repository?**
> Please read the guidance under each section comments below before submitting. A great PR description helps reviewers understand **why** the change is needed, **what** changed, and **how** to verify it.

---

## 📝 Summary

<!--
  [GUIDE FOR AUTHORS]
  Describe the high-level intent and context of this Pull Request.
  - What problem does this PR solve or what new feature does it introduce?
  - Why is this change necessary?
  - Example: "Adds a custom LWC component to display real-time agent call logs on the Contact layout and updates the Lead trigger service to enforce bulkification."
-->

Provide a brief summary of the changes introduced by this PR:

---

## ⚠️ Critical & Breaking Changes

<!--
  [GUIDE FOR AUTHORS]
  Highlight any breaking changes, schema updates, permissions changes, or configuration steps required prior to or post-deployment.
  - If there are NO breaking changes, write: "None".
  - Example: "Requires setting up the `AgentForce_Permission_Set` in target orgs before deploying."
-->

- [ ] Check if this PR contains breaking changes or deployment pre-requisites.

_Detail any critical changes here:_

---

## 🛠️ Changes Made

<!--
  [GUIDE FOR AUTHORS]
  Provide a bulleted list of specific implementation details and code changes.
  - Mention specific Apex classes, Handlers, Services, LWCs, or configuration files changed.
  - Example:
    - Added `ContactLoggerController.cls` with `@AuraEnabled` method using `WITH USER_MODE`.
    - Updated `LeadTriggerHandler.cls` to bulkify SOQL queries inside `afterUpdate`.
-->

-

---

## 🔗 Issues Closed

<!--
  [GUIDE FOR AUTHORS]
  Reference GitHub issues closed by this PR so they auto-close on merge.
  - Format: `Fixes #123`, `Closes #456`, or `Resolves #789`
-->

Fixes #

---

## 📦 Salesforce Metadata Changes

<!--
  [GUIDE FOR AUTHORS]
  Summarize metadata additions or deletions in `force-app`.
  - Added: New Apex classes, LWCs, Custom Objects, Custom Fields, Permission Sets, Flows.
  - Deleted: Removed components or metadata files.
-->

### ➕ Added / Modified Metadata

-

### ➖ Deleted Metadata

-

---

## 🧪 Testing & Verification Instructions

<!--
  [GUIDE FOR AUTHORS]
  Provide step-by-step instructions so reviewers can verify these changes in a Scratch Org or Sandbox.
  - Include commands to run (e.g. `sf project deploy start`, `npm test`).
  - Describe manual UI testing steps or record setup required.
  - Example:
    1. Spin up scratch org: `cci flow run feature_org --org dev`
    2. Open scratch org: `sf org open`
    3. Navigate to Contact record page and verify the LWC renders call logs properly.
    4. Run Apex test suite: `sf apex test run --code-coverage --result-format human`
-->

1.
2.
3.

---

## 📋 Quality & Compliance Checklist

<!--
  [GUIDE FOR AUTHORS]
  Ensure your code complies with our repository standards (see GEMINI.md):
-->

- [ ] **Apex Bulkification**: All SOQL/SOSL queries and DML statements are strictly bulkified (no DML/SOQL inside loops).
- [ ] **Security Scoping**: Enforced object & field level security using `WITH USER_MODE` or `Security.stripInaccessible`.
- [ ] **Apex Unit Tests**: Unit tests written for single & bulk inputs (200+ records) with >85% code coverage.
- [ ] **LWC Best Practices**: Uses SLDS design tokens, standard state management, and proper ARIA accessibility attributes.
- [ ] **Formatting & Linting**: Ran `npm run prettier` and `npm run lint` with zero errors.
