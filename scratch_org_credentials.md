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
[07/22/26 18:17:26] Creating scratch org with command: sf org create scratch
                    --json  -f config/project-scratch-def.json -w 120
                    --target-dev-hub devhub --no-namespace --duration-days 30 -a
                    AgentForceCRM__dev
[07/22/26 18:17:52]
                    Created: OrgId: 00D9I000003OSpRUAW,
                    Username:test-vjdj9gjoayzu@example.com
                    Generating scratch org user password with command: sf org
                    generate password -o test-vjdj9gjoayzu@example.com
[07/22/26 18:17:56] Getting org info from Salesforce CLI for
                    test-vjdj9gjoayzu@example.com
Error: Expired session for
https://site-ruby-6616-dev-ed.scratch.my.salesforce.com/services/data/v67.0/sobj
ects/Organization/%5BREDACTED%5D%20Use%20'sf%20org%20auth%20show-access-token'%2
0to%20view. Response content: [{'message': 'INVALID_AUTH_HEADER', 'errorCode':
'INVALID_AUTH_HEADER'}]
Run this command for more information about debugging errors: cci error --help
```

## 🔐 Password Generation Output

```text
[1m[33mWarning:[39m[22m This command has generated and displayed a password. Avoid sharing or logging this output as it contains a sensitive credential.
Successfully set the password "kaklep3[jbQtqtphrucc" for user test-vjdj9gjoayzu@example.com.
You can see the password again by running "sf org auth show-user-password -o test-vjdj9gjoayzu@example.com".
```

## 🔑 Scratch Org Credentials (`sf org display --target-org test-vjdj9gjoayzu@example.com`)

```text
[1m[33mWarning:[39m[22m Secrets are now hidden from 'sf org display' command output. Use the 'sf org auth' commands instead. As a temporary workaround, you can set SF_TEMP_SHOW_SECRETS=true to render these secrets. This workaround will be removed in an upcoming release.

Org Description
 KEY              VALUE
--------------------------------------------------------------------------
 Access Token     [REDACTED] Use 'sf org auth show-access-token' to view
 Alias            AgentForceCRM__dev
 Api Version      67.0
 Client Id        PlatformCLI
 Created By       vikaskumar@devhub2.com
 Created Date     2026-07-22T18:17:28.000+0000
 Dev Hub Id       vikaskumar@devhub2.com
 Edition          Developer
 Expiration Date  2026-08-21
 Id               00D9I000003OSpRUAW
 Instance Url     https://site-ruby-6616-dev-ed.scratch.my.salesforce.com
 Org Name         AgentForce company
 Password         [REDACTED] Use 'sf org auth show-user-password' to view
 Signup Username  test-vjdj9gjoayzu@example.com
 Status           [32mActive[39m
 Username         test-vjdj9gjoayzu@example.com

```
