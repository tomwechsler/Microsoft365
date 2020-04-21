Set-Location c:\
Clear-Host

Install-Module -Name Microsoft.Online.SharePoint.PowerShell -Force -Verbose

Import-Module -Name Microsoft.Online.SharePoint.PowerShell

$credential = Get-Credential

Connect-SPOService -Url https://wechsler19-admin.sharepoint.com -credential $credential

Get-SPOSite -Detailed | ft #mit fl erhalten Sie mehr Infos

Get-SPOWebTemplate

New-SPOSite -Title "Powershell Demosite" `
-Url https://wechsler19.sharepoint.com/sites/demosite2 `
-LocaleID 1031 `
-Template "STS#0" `
-TimeZoneId 4 `
-Owner admin365@wechsler19.onmicrosoft.com `
-StorageQuota 1024 `
-ResourceQuota 300

Set-SPOSite -Identity https://wechsler19.sharepoint.com/sites/demosite2 -ResourceQuota 0 -StorageQuota 15000

Remove-SPOSite -Identity https://wechsler19.sharepoint.com/sites/demosite2 -NoWait

Restore-SPODeletedSite -Identity https://wechsler19.sharepoint.com/sites/demosite2
