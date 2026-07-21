# Antigravity Workspace Guidelines for Salesforce DX (personalORG)

## Project Overview

This repository is a Salesforce DX project structured around `force-app` as the primary package directory.

- **Source API Version**: `63.0`
- **Default Package**: `force-app`

## Code Standards & Guidelines

### Apex Development

1. **Bulkification**: Always write bulkified Apex code. Never execute SOQL queries, SOSL queries, or DML statements inside loops.
2. **Architecture**: Follow separation of concerns (Selectors, Services, Domain/Trigger Handlers) where applicable.
3. **Security**: Enforce object and field level security using `WITH USER_MODE`, `Security.stripInaccessible`, or schema checks.
4. **Testing**: Write comprehensive unit tests targeting edge cases, bulk input (200+ records), and user personas. Aim for >85% code coverage. Never use `seeAllData=true`.

### Lightning Web Components (LWC)

1. **SLDS Styling**: Use standard Salesforce Lightning Design System (SLDS) classes and design tokens. Avoid hardcoded pixel values.
2. **Reactivity & State**: Use standard properties for state management; use `@track` for nested object/array mutations.
3. **Accessibility (a11y)**: Ensure proper ARIA roles, descriptive alt/label attributes, and keyboard navigability.
4. **Jest Testing**: Write unit tests for LWC under `__tests__` directories using `@salesforce/sfdx-lwc-jest`.

### Linting & Formatting

- **Prettier**: Format code using `npm run prettier`.
- **ESLint**: Lint LWC/Aura code using `npm run lint`.
- **Jest**: Run unit tests with `npm test`.

## Salesforce CLI Commands

- Deploy source to default org: `sf project deploy start`
- Retrieve source from org: `sf project retrieve start`
- Run Apex tests: `sf apex test run --code-coverage`
