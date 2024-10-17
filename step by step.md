**School Connection private preview configuration steps**

This will guide you through the process of adding students' parent or guardian information using Graph (PowerShell) and enable School Connection from the Teams Admin Center. You can then download the Teams mobile app from [aka.ms/SchoolConnectionInTeams](https://aka.ms/SchoolConnectionInTeams) and enable School Connection to see student assignments, feedback, insights etc. Learn more about School Connection at [parent.microsoft.com](https://parent.microsoft.com/).

**Prerequisites**

- You need Global Admin permissions in your M365 tenant to complete the steps.
- A CSV file with student and guardian relationships, a PowerShell script to upload the data using Graph run in an environment with the appropriate modules and permissions.

**Enable School Connection in the Teams Admin Center**

Navigate to admin.teams.microsoft.com, expand _Education_ in the left menu and select _Parent and guardian settings_.

Enable School Connection by turning the toggle. If you don't see the toggle, see the prerequisites above.

**Create an app in Entra**

In order to interact with the Graph API to update the relatedContacts for students, you need to create and connect using an Application with _EduRoster.ReadWrite.All_ permissions.

**Assign the** _ **Application Administrator** _ **role**

By default a Global Admin does not have the necessary permissions to add the application and assign permissions. In order to add the role, navigate to https://entra.microsoft.com logged in as a Global Admin, expand _Identity_, _Users_, and select _All users_ in the menu on the left.

Search for and click on your Global Admin account, then select _Assigned roles_ in the _Manage_ section.

Click "+ Add assignments" and add the _Application Administrator_ role.

**Create the application**
In the left navigation menu expand _Applications_, select _App registrations_ and click "+ New registration".

Enter your preferred name, for demo purposes I will use 'SchoolConnection'.

In the _Redirect URI_ section select _Web_ as platform and enter "[http://localhost](http://localhost/)", then click _Register_.

Copy and save the _Application (client) ID_ and the _Directory (tenant) ID_ for later.

Select "_Add a certificate or secret_" in the _Essentials_ area, followed by "+ New client secret".

Give your secret a description, I will use '_SchoolConnectionDemo'_ for demo purposes, and click "Add".

Copy and save the _Value_ of your secret for later.

FYI! For batch upload consider authenticating using a certificate, as the client secret will time out after one hour.

Select _API Permissions_ in the _Manage_ section, followed by "_+ Add a permission_".

Choose _Microsoft Graph_, then _Application permissions._

Search for "_eduroster_", expand _EduRoster_, select EduRoster.ReadWrite.All and click "Add permissions".

Consent by selecting _"✔️_ _Grant admin consent for TENANTNAME"_.

Proceed with the PowerShell script, and once you succeed with that you should be ready to [try out School Connection](https://support.microsoft.com/en-us/topic/get-to-know-school-connection-fe96d765-f20e-4b75-9d8b-3debc8c2d929?ui=en-us&rs=en-us&ad=us)!
