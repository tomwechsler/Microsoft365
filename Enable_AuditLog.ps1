Set-Location C:\
Clear-Host

#We need the exchange online module
Install-Module -Name ExchangeOnlineManagement -Verbose -AllowClobber -Force

#Create a variable with credentials
$cred = get-credential

#Lets connect
Connect-ExchangeOnline –Credential $cred

#Did it work?
Get-Mailbox

#Verify the auditing status for your organization
Get-AdminAuditLogConfig | FL UnifiedAuditLogIngestionEnabled

#Use PowerShell to turn on auditing
Set-AdminAuditLogConfig -UnifiedAuditLogIngestionEnabled $true

#Turn off auditing
Set-AdminAuditLogConfig -UnifiedAuditLogIngestionEnabled $false

#Verify the auditing status for your organization
Get-AdminAuditLogConfig | FL UnifiedAuditLogIngestionEnabled
