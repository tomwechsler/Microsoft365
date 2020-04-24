Set-Location c:\
Clear-Host

#Windows Remote Management (WinRM) on your computer needs to allow Basic authentication (it's enabled by default)
winrm get winrm/config/client/auth

winrm quickconfig

#If you don't see the value Basic = true
winrm set winrm/config/client/auth @{Basic="true"}

#Install the PowerShellGet
Install-Module PowershellGet -Force

#Update your existing version of the PowerShellGet
Update-Module PowershellGet

#Windows PowerShell needs to be configured to run scripts
Set-ExecutionPolicy RemoteSigned

#Close and re-open the elevated Windows PowerShell window to get the changes from the previous steps

Install-Module -Name ExchangeOnlineManagement

#Update the EXO V2 module, If the EXO V2 module is already installed
#To see the version of the EXO V2 module that's currently installed
Import-Module ExchangeOnlineManagement; Get-Module ExchangeOnlineManagement

#Run the following command to update the EXO V2 module
Update-Module -Name ExchangeOnlineManagement

#To confirm that the update was successful
Import-Module ExchangeOnlineManagement; Get-Module ExchangeOnlineManagement

#To uninstall the EXO V2 module
Uninstall-Module -Name ExchangeOnlineManagement

#Connect to Exchange Online using the EXO V2 module
$UserCredential = Get-Credential

#Accounts without MFA enabled
Connect-ExchangeOnline -Credential $UserCredential -ShowProgress $true

#Accounts with MFA enabled
Connect-ExchangeOnline -UserPrincipalName <UPN> -ShowProgress $true

#PropertySets: This parameter accepts one or more available property set names separated by commas
Get-EXOMailbox -PropertySets Archive,Custom

#Properties: This parameter accepts one or more property names separated by commas
Get-EXOMailbox -Properties LitigationHoldEnabled,AuditEnabled

Get-EXOMailbox -Properties IsMailboxEnabled,SamAccountName -PropertySets Delivery

Get-EXOCASMailbox -Properties EwsEnabled, MAPIBlockOutlookNonCachedMode -PropertySets ActiveSync

#This example returns the properties in the Minimum property set for the first ten mailboxes
Get-EXOMailbox -ResultSize 10

Get-EXOMailbox -ResultSize 10 -PropertySets All