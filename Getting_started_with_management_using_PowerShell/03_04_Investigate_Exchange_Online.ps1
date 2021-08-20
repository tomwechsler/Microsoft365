Set-Location C:\
Clear-Host

#To be able to install the exchange online module
Set-ExecutionPolicy RemoteSigned

#Install the exchange online management module
Install-Module -Name ExchangeOnlineManagement -Verbose -Force

#Update the module (if necessary)
Update-Module -Name ExchangeOnlineManagement -Verbose -Force

#Connect to exchange online
Connect-ExchangeOnline -UserPrincipalName admin365@wechsler2020.onmicrosoft.com

#Is an archive already in use?
Get-Mailbox | Where-Object {$_.ArchiveDatabase -ne $null}
Get-Mailbox | Where-Object {$_.ArchiveDatabase -ne $null} | Format-Table name, archivedatabase, archivename, archivequota, archivewarningquota -AutoSize

#Run this command to enable the archive mailbox for a single user
Enable-Mailbox -Identity "tom@contosotom.ch" -Archive

#Run this command to enable the archive mailbox for all users in your organization
Get-Mailbox -Filter {ArchiveStatus -Eq "None" -AND RecipientTypeDetails -eq "UserMailbox"} | Enable-Mailbox -Archive

#Note: When you turn on an archive, a retention policy should also be configured

#Run this command to disable the archive mailbox for a single user   
Disable-Mailbox -Identity "tom@contosotom.ch" -Archive

#Run this command to disable the archive mailbox for all users in your organization
Get-Mailbox -Filter {ArchiveStatus -Eq "Active" -AND RecipientTypeDetails -eq "UserMailbox"} | Disable-Mailbox -Archive

#This example returns a summary list of all distribution groups that can be upgraded to Microsoft 365 Groups
Get-EligibleDistributionGroupForMigration -ResultSize unlimited

#This example creates device access rules that blocks access for Android
New-ActiveSyncDeviceAccessRule -Characteristic DeviceType -QueryString "Android" -AccessLevel Block

#To proof the rule has been created
Get-ActiveSyncDeviceAccessRule

#To remove the rule use
Remove-ActiveSyncDeviceAccessRule -Identity "Android (DeviceType)"

#To proof the rule has been removed
Get-ActiveSyncDeviceAccessRule

#Details about a received message
Get-MessageTraceDetail -MessageTraceId fa111196-fd22-429f-1616-08d8b8948ac5 -RecipientAddress admin365@wechsler2020.onmicrosoft.com