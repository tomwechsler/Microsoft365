Set-Location C:\
Clear-Host

#We need the exchange online module
Install-Module -Name ExchangeOnlineManagement -Verbose -AllowClobber -Force

#Lets connect
Connect-ExchangeOnline

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
