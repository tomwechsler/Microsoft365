#Install the Skype for Business Online PowerShell Module (https://www.microsoft.com/en-us/download/details.aspx?id=39366)

Set-Location c:\
Clear-Host

#Install the teams module
Install-Module MicrosoftTeams -AllowClobber -Force -Verbose

#Import the teams module
Import-Module -Name MicrosoftTeams

#Create cred's
$Cred = Get-Credential

#Create a session
$CSSession = New-CsOnlineSession -Credential $Cred

#Import the session
Import-PSSession -Session $CSSession -AllowClobber

#Connect to Microsoft 365 (formerly Office365)
Connect-MsolService -Credential $Cred

#Did it work
Get-MsolUser

#We need the ObjectId of a user
Get-MsolUser -UserPrincipalName "jane.ford@tomwechsler.xyz" | Select-Object ObjectId

#Check the assigment for a user
Get-CsUserPolicyAssignment -Identity 76ae4015-3774-4524-a534-c6b3e6816be5

#Check all users for some policies
Get-CsOnlineUser | Format-Table UserPrincipalName, TeamsMessagingPolicy, TeamsMeetingPolicy, TeamsAppSetupPolicy

Get-CsTeamsMessagingPolicy -Identity "Tom"

#To grant a single user a Messaging Policy
Grant-CsTeamsMessagingPolicy -Identity jane.ford@tomwechsler.xyz -PolicyName "Tom"

#Search all users in the department "Administration"
Get-CsOnlineUser -Filter {Department -eq 'Administration'} | Select UserPrincipalName

#Set a Policy for the specific users
Get-CsOnlineUser -Filter {Department -eq 'Administration'} | Grant-CsTeamsMessagingPolicy -PolicyName "Tom"

#Let's check
Get-CsOnlineUser -Filter {TeamsMessagingPolicy -eq 'Tom'} | Select UserPrincipalName

#an other way
Get-CsOnlineUser | Format-Table UserPrincipalName, TeamsMessagingPolicy, TeamsMeetingPolicy, TeamsAppSetupPolicy

#Undo
Get-CsOnlineUser -Filter {Department -eq 'Administration'} | Grant-CsTeamsMessagingPolicy -PolicyName $Null

#Other example
Get-CsOnlineUser -Filter {Department -eq 'Administration'} | Grant-CsTeamsMeetingPolicy -PolicyName $Null

#Other example
Get-CsOnlineUser -Filter {Department -eq 'Administration'} | Grant-CsTeamsAppSetupPolicy -PolicyName $Null