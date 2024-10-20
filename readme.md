# Upload relatedContacts for Teams EDU

## Description

For testing purposes only - use at your own risk.

The PowerShell script wil take input from the CSV file to update the relatedContacts information of a set of students using Graph.
The main goal of this is to provide relatedContacts information while testing School Connection, with minimal effort.

## Getting Started

Read [step by step.md](https://github.com/magnusatteamsrocks/TeamsEDU/blob/main/step%20by%20step.md) for further instructions.

### Dependencies

* Global Admin and Application Administrator permissions in your M365 tenant
* A CSV file with student and guardian relationships, there's s a a demo example in this repo
* Tested with PowerShell version 7.3.6 and above
* Microsoft.Graph.Beta.Education PowerShell module version 2.7.0 or later
* MSAL.PS PowerShell module
* An app installed in your tenant with EduRoster.ReadWrite.All permissions (login using a certificate or client secret) - see [step by step.md](https://github.com/magnusatteamsrocks/TeamsEDU/blob/main/step%20by%20step.md) for full instructions).

## Authors

Magnus Sandtorv
[@magnus_sandtorv](https://twitter.com/magnus_sandtorv)

## Acknowledgments

Inspiration, code snippets, etc.
* [thesysadminchannel - Connect to Graph using an app](https://thesysadminchannel.com/how-to-connect-to-microsoft-graph-api-using-powershell/#ServicePrincipal)
