# personalORG

Salesforce DX project configured with CumulusCI (`cumulusci.yml`) for automated scratch org creation, metadata deployment, and flow management.

## Development with CumulusCI

To work on this project in a scratch org:

1. **Prerequisite:** Ensure CumulusCI is installed and your Salesforce CLI Dev Hub is connected:
   ```bash
   sf org login web --set-default-dev-hub --alias MyDevHub
   ```
2. **Build Dev Org:** Run the development flow to create a scratch org, deploy `force-app`, and apply setup configurations:
   ```bash
   cci flow run dev_org --org dev
   ```
   _or using npm:_ `npm run cci:dev`
3. **Open Org:** Launch the scratch org in your default browser:
   ```bash
   cci org browser dev
   ```
   _or using npm:_ `npm run cci:org:open`

### Common Commands

| Task                      | Command                            | NPM Shortcut             |
| :------------------------ | :--------------------------------- | :----------------------- |
| **Build & Setup Dev Org** | `cci flow run dev_org --org dev`   | `npm run cci:dev`        |
| **Open Scratch Org**      | `cci org browser dev`              | `npm run cci:org:open`   |
| **View Org Details**      | `cci org info dev`                 | —                        |
| **List All Orgs**         | `cci org list`                     | —                        |
| **Run Apex Tests**        | `cci task run run_tests --org dev` | —                        |
| **Delete Scratch Org**    | `cci org scratch_delete dev`       | `npm run cci:org:delete` |
