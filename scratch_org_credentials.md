# 🚀 Scratch Org Details & Credentials

## 📊 CumulusCI Dev Org Info

```text
CumulusCI Configuration Warnings:
  '/home/runner/work/salesforce-cci/salesforce-cci/cumulusci.yml' -> 'orgs' -> 'scratch' -> 'dev' -> 'set_password'
    extra fields not permitted
  '/home/runner/work/salesforce-cci/salesforce-cci/cumulusci.yml' -> 'orgs' -> 'scratch' -> 'feature' -> 'set_password'
    extra fields not permitted
  '/home/runner/work/salesforce-cci/salesforce-cci/cumulusci.yml' -> 'orgs' -> 'scratch' -> 'qa' -> 'set_password'
    extra fields not permitted
  '/home/runner/work/salesforce-cci/salesforce-cci/cumulusci.yml' -> 'orgs' -> 'scratch' -> 'beta' -> 'set_password'
    extra fields not permitted
  '/home/runner/work/salesforce-cci/salesforce-cci/cumulusci.yml' -> 'orgs' -> 'scratch' -> 'release' -> 'set_password'
    extra fields not permitted
[07/22/26 18:28:35] Creating scratch org with command: sf org create scratch
                    --json  -f config/project-scratch-def.json -w 120
                    --target-dev-hub devhub --no-namespace --duration-days 30 -a
                    AgentForceCRM__dev
Error: Failed to create scratch org:
{
  "name": "LIMIT_EXCEEDED",
  "message": "The signup request failed because this organization has reached
its daily scratch org signup limit",
  "exitCode": 1,
  "context": "OrgCreateScratch",
  "stack": "LIMIT_EXCEEDED: The signup request failed because this organization
has reached its daily scratch org signup limit\n    at SfCommandError.from
(file:///opt/hostedtoolcache/node/22.23.1/x64/lib/node_modules/@salesforce/cli/n
ode_modules/@salesforce/sf-plugins-core/lib/SfCommandError.js:48:16)\n    at
OrgCreateScratch.catch
(file:///opt/hostedtoolcache/node/22.23.1/x64/lib/node_modules/@salesforce/cli/n
ode_modules/@salesforce/sf-plugins-core/lib/sfCommand.js:332:47)\n    at
OrgCreateScratch._run
(/opt/hostedtoolcache/node/22.23.1/x64/lib/node_modules/@salesforce/cli/node_mod
ules/@oclif/core/lib/command.js:187:29)\n    at
process.processTicksAndRejections (node:internal/process/task_queues:103:5)\n
at async Config.runCommand
(/opt/hostedtoolcache/node/22.23.1/x64/lib/node_modules/@salesforce/cli/node_mod
ules/@oclif/core/lib/config/config.js:422:25)\n    at async run
(/opt/hostedtoolcache/node/22.23.1/x64/lib/node_modules/@salesforce/cli/node_mod
ules/@oclif/core/lib/main.js:97:16)\n    at async
file:///opt/hostedtoolcache/node/22.23.1/x64/lib/node_modules/@salesforce/cli/bi
n/run.js:15:1",
  "cause": "LIMIT_EXCEEDED: The signup request failed because this organization
has reached its daily scratch org signup limit\n    at HttpApi.getError
(/opt/hostedtoolcache/node/22.23.1/x64/lib/node_modules/@salesforce/cli/node_mod
ules/@jsforce/jsforce-node/lib/http-api.js:315:15)\n    at
process.processTicksAndRejections (node:internal/process/task_queues:103:5)\n
at async
/opt/hostedtoolcache/node/22.23.1/x64/lib/node_modules/@salesforce/cli/node_modu
les/@jsforce/jsforce-node/lib/http-api.js:127:33\n    at async Connection.create
(/opt/hostedtoolcache/node/22.23.1/x64/lib/node_modules/@salesforce/cli/node_mod
ules/@jsforce/jsforce-node/lib/connection.js:739:15)\n    at async
requestScratchOrgCreation
(/opt/hostedtoolcache/node/22.23.1/x64/lib/node_modules/@salesforce/cli/node_mod
ules/@salesforce/core/lib/org/scratchOrgInfoApi.js:283:16)\n    at async
Promise.all (index 0)\n    at async scratchOrgCreate
(/opt/hostedtoolcache/node/22.23.1/x64/lib/node_modules/@salesforce/cli/node_mod
ules/@salesforce/core/lib/org/scratchOrgCreate.js:147:65)\n    at async
OrgCreateScratch.run
(file:///opt/hostedtoolcache/node/22.23.1/x64/lib/node_modules/@salesforce/cli/n
ode_modules/@salesforce/plugin-org/lib/commands/org/create/scratch.js:215:72)\n
   at async OrgCreateScratch._run
(/opt/hostedtoolcache/node/22.23.1/x64/lib/node_modules/@salesforce/cli/node_mod
ules/@oclif/core/lib/command.js:183:22)\n    at async Config.runCommand
(/opt/hostedtoolcache/node/22.23.1/x64/lib/node_modules/@salesforce/cli/node_mod
ules/@oclif/core/lib/config/config.js:422:25) {\n  data: {\n    message: 'The
signup request failed because this organization has reached its daily scratch
org signup limit',\n    errorCode: 'LIMIT_EXCEEDED',\n    fields: []\n  },\n
errorCode: 'LIMIT_EXCEEDED'\n}",
  "warnings": [],
  "code": "LIMIT_EXCEEDED",
  "status": 1,
  "commandName": "OrgCreateScratch"
}


Run this command for more information about debugging errors: cci error --help
```

## 🔐 Password Generation Output

```text
[1m[33mWarning:[39m[22m This command has generated and displayed a password. Avoid sharing or logging this output as it contains a sensitive credential.
Successfully set the password "iHo4bkapbvvtq_afibhs" for user test-l9ttcvhpser3@example.com.
You can see the password again by running "sf org auth show-user-password -o test-l9ttcvhpser3@example.com".
```

## 🔑 User Password (`sf org auth show-user-password --target-org test-l9ttcvhpser3@example.com`)

```text
? You're about to reveal the password for "test-l9ttcvhpser3@example.com". Do yo
u want to continue? (y/N)[1A[107GWarning: Detected unsettled top-level await at file:///opt/hostedtoolcache/node/22.23.1/x64/lib/node_modules/@salesforce/cli/bin/run.js:15
await cli.run();
^



[1B
[G[?25h[1m[31mError (13):[39m[22m User force closed the prompt with 13 null


```

## 🌐 Scratch Org Display Details (`sf org display --target-org test-l9ttcvhpser3@example.com`)

```text
[1m[33mWarning:[39m[22m Secrets are now hidden from 'sf org display' command output. Use the 'sf org auth' commands instead. As a temporary workaround, you can set SF_TEMP_SHOW_SECRETS=true to render these secrets. This workaround will be removed in an upcoming release.

Org Description
 KEY              VALUE
--------------------------------------------------------------------------------
 Access Token     [REDACTED] Use 'sf org auth show-access-token' to view
 Alias            AgentForceCRM__dev
 Api Version      67.0
 Client Id        PlatformCLI
 Created By       vikaskumar@devhub2.com
 Created Date     2026-07-22T18:28:06.000+0000
 Dev Hub Id       vikaskumar@devhub2.com
 Edition          Developer
 Expiration Date  2026-08-21
 Id               00DC1000004h38QMAQ
 Instance Url     https://innovation-page-5874-dev-ed.scratch.my.salesforce.com
 Org Name         AgentForce company
 Password         [REDACTED] Use 'sf org auth show-user-password' to view
 Signup Username  test-l9ttcvhpser3@example.com
 Status           [32mActive[39m
 Username         test-l9ttcvhpser3@example.com

```
