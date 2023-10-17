# Upload relatedContacts for Teams EDU

## Description

The PowerShell script wil take input from the CSV file to update the relatedContacts information of a set of students student using Graph.
The main goal of this is to provide relatedContacts information while testing School Connection, with minimal effort.

## Getting Started

Read step by step doc to install app.

### Dependencies

* During the private preview your tenant needs to be provisioned for Teams Admin Center to show the toggle to enable School Connection. To sign up, please fill out this [interest form](https://forms.office.com/Pages/ResponsePage.aspx?id=v4j5cvGGr0GRqy180BHbR00rk9rIPFVEpmKOrde5bRJURFAyWTNKSzBJNDBHMlRNQzY1OVhWVEhRTC4u)
* Global Admin and Application Adminiostrator permissions in your M365 tenant
* A CSV file with student and guardian relationships, there's s a a demo example in this repo
* Tested with PowerShell version 7.3.6 and above
* Microsoft.Graph.Beta.Education PowerShell module version 2.7.0 or later
* MSAL.PS PowerShell module
* An app installed in your tenant with EduRoster.ReadWrite.All permissions (login using a certificate or client secret)

## Authors

Magnus Sandtorv
[@magnus_sandtorv](https://twitter.com/magnus_sandtorv)

## Acknowledgments

Inspiration, code snippets, etc.
* [thesysadminchannel - Connect to Graph using an app](https://thesysadminchannel.com/how-to-connect-to-microsoft-graph-api-using-powershell/#ServicePrincipal)
