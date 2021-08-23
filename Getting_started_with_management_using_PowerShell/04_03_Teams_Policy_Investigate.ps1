Set-Location c:\
Clear-Host

#Install the teams module
Install-Module MicrosoftTeams -AllowClobber -Force -Verbose

#Install the MSOnline module
Install-Module MSOnline -AllowClobber -Force -Verbose

#Import the teams module
Import-Module -Name MicrosoftTeams

#Credentials
$cred = Get-Credential

#Connect to Teams
Connect-MicrosoftTeams –Credential $cred

#Connect to Microsoft 365 (formerly Office 365)
Connect-MsolService –Credential $cred

#Did it work
Get-MsolUser

#Did it work
Get-Team

#We need the ObjectId of a user
Get-MsolUser -UserPrincipalName "tom@tomscloud.ch" | Select-Object ObjectId

#Check the assigment for a user
Get-CsUserPolicyAssignment -Identity ba36d788-31a5-4f72-9709-7d586056762c

#Check all users for some policies
Get-CsOnlineUser | Format-Table UserPrincipalName, TeamsMessagingPolicy, TeamsMeetingPolicy, TeamsAppSetupPolicy

#The details of the policy
Get-CsTeamsMessagingPolicy -Identity "Tom"

#To grant a single user a Messaging Policy
Grant-CsTeamsMessagingPolicy -Identity fred.jonas@tomscloud.ch -PolicyName "Tom"

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

#Remove a policy from a user
Grant-CsTeamsMessagingPolicy -Identity fred.jonas@tomscloud.ch -PolicyName $null