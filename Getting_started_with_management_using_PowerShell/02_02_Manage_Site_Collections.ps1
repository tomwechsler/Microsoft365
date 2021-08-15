Set-Location C:\
Clear-Host

#The SharePoint Module
Install-Module -Name Microsoft.Online.SharePoint.PowerShell

#Credential
$cred = get-credential

#Let's connect
Connect-SPOService -Url https://tomscloud-admin.sharepoint.com -credential $cred

#Did it work?
Get-SPOSite

#To get more details
Get-SPOSite -Identity https://tomscloud.sharepoint.com/ | Format-List *

#Which templates are available?
Get-SPOWebTemplate

#Create a new site
New-SPOSite –Url https://tomscloud.sharepoint.com/sites/sales –Owner tom@tomscloud.ch –StorageQuota 400 –Title “Verkaufs Team”

#Now you can finish creating the site in SharePoint Admin Center => or configure the site with Set-SPOSite

#Did it work?
Get-SPOSite

#Remove a site
Remove-SPOSite -Identity https://tomscloud.sharepoint.com/sites/sales -NoWait

#The control
Get-SPODeletedSite

#You can also restore the site
Restore-SPODeletedSite -Identity https://tomscloud.sharepoint.com/sites/sales

#The control
Get-SPODeletedSite

#Did it work?
Get-SPOSite