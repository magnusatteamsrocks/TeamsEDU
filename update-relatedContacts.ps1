<#
	Script to update the relatedContacts information of a set of students student using Graph, in order to enable access to Parent Connection, School Connection etc.
	
	Change the content of the variables $appId, $tenantId and $clientSecret.
	
    The script will look for relationship data in C:\TEMP\relationships.csv, there's a CSV template provided in the repo.
    If the file does not exist the script will prompt you to input the full path of the file.
    For testing purposes you can use demo data and mobile is not a required field.
    
	More details on Update relatedContacts:
	https://learn.microsoft.com/en-us/graph/api/relatedcontact-update?view=graph-rest-beta&tabs=powershell

	How to setup an app, add permissions and connect to Microsoft Graph using PowerShell:
	https://thesysadminchannel.com/how-to-connect-to-microsoft-graph-api-using-powershell/#ServicePrincipal
	
	Get to know School Connection:
	https://support.microsoft.com/en-us/topic/get-to-know-school-connection-fe96d765-f20e-4b75-9d8b-3debc8c2d929?ui=en-us&rs=en-us&ad=us


    TODO:   
            - ❌ implement better reporting
            - ✅ implement logic to read data from CSV files, loop through all rows and update relatedContacts accordingly (one parent per student)
            - ✅ implement logic to read data from CSV files, loop through all rows and, create and populate hashtable on the fly and update relatedContacts accordingly (multiple parents per student)
            - ✅ error handling
                - ✅ Check for modules and break with a message if they are missing
                - ✅ Check for the required Graph permissions and break if they are missing
                - ✅ Check for correct CSV-path and provide an option to input the correct path if it fails

#>

# Check for and import the necessary PowerShell modules.

try {
    Import-Module Microsoft.Graph.Beta.Education -MinimumVersion 2.7.0
}
catch {
    Write-Host -ForegroundColor RED "Please install and import a the Microsoft.Graph.Beta.Education PowerShell module (minimum version 2.7.0)"
    break    
}

try {
    Import-Module MSAL.PS -MinimumVersion 4.37.0.0
}
catch {
    Write-Host -ForegroundColor RED "Please install and import the MSAL.PS PowerShell module (minimum version 4.37.0.0)"
    break
}

# Create variables for the application used to connect to Graph
$appId = "SchoolConnectionDemoAppId"
$tenantId = "yourTenantId"
$clientSecret= "SchoolConnectionDemoClientSecretValue"

# Fetch token
$MsalToken = Get-MsalToken -TenantId $TenantId -ClientId $AppId -ClientSecret ($ClientSecret | ConvertTo-SecureString -AsPlainText -Force)

# Convert token to SecureString 
$token = ($MsalToken.AccessToken | ConvertTo-SecureString -AsPlainText -Force)

# Connect to Graph using access token
Connect-MgGraph -AccessToken $token -NoWelcome

# Verify that permission scopes includes EduRoster.ReadWrite.All - if not disconnect.
$context = Get-MgContext | Select-Object AppName, Scopes
if ($context.Scopes -notcontains "EduRoster.ReadWrite.All"){
    Write-Host "You're not connected with the appropritate permissions, please review the documentation. Disconnecting Graph"
    Disconnect-MgGraph
    break
} else {
    Write-Host -ForegroundColor Green "You are successfylly connected to" $context.AppName "with" $context.Scopes "permissions"
}

# Import relationship data from CSV
$CSVfilepath = "C:\Temp\relationships.csv"
try {
    $relationships = Import-Csv -Path $CSVfilepath
}
catch {
    $relationships = Import-Csv -Path (Read-Host -Prompt "Type in the full path of the csv file containg relationship data")
}

# Output the number of students and guardians
Write-Host -ForegroundColor Green Successfully imported ($relationships.studentUPN.Count) student relatedContacts for a total of (($relationships | select studentUPN -unique).count) students

# fetch all guardians for each student
$students = $relationships | Select-Object studentUPN -Unique

    foreach ($student in $students) {
        $guardians = $relationships | Where-Object { $_.studentUPN -eq $student.studentUPN
        }
       # create a hash table with one or more guardians
        $relatedContacts = @()
            foreach ($guardian in $guardians) {
                $relatedContacts += @{
                    displayName = $guardian.guardiandisplayName
                    emailAddress = $guardian.guardianEmail
                    mobilePhone = $guardian.guardianMobile
                    relationship = $guardian.relationshipRole
                    accessConsent = $true
            }
        
        $params = @{
            relatedContacts = $relatedContacts
        }
        
        # Pull student id
        $educationUser = Get-MgBetaEducationUser | ? {$_.mail -like $student.studentUPN}

        # Update the educationUser-object with the parent information.
        Update-MgBetaEducationUser -EducationUserId $educationUser.id -BodyParameter $params
        
        # Query graph to see if the relatedContacts object has been updated and output the result
        $user = Invoke-graphrequest -method GET -uri "https://graph.microsoft.com/beta/education/users/$($educationUser.id)?`$select=relatedContacts,id,displayName"
        $user | ConvertTo-Json

    }
}