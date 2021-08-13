Set-Location C:\
Clear-Host

#The SharePoint Module
Install-Module -Name Microsoft.Online.SharePoint.PowerShell -Force -Verbose

#Credential
$cred = Get-Credential

#Let's connect
Connect-SPOService `
    -Url https://tomscloud-admin.sharepoint.com `
    -Credential $cred

#Did it work?
Get-SPOSite

#Disconnect
Disconnect-SPOService