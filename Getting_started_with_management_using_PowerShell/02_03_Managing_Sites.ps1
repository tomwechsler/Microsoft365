Set-Location C:\
Clear-Host

#Which templates are available?
Get-SPOWebTemplate

#Site template
Get-SPOSite -Template GROUP#0

#We create a new site
New-SPOSite `
    -Url https://tomscloud.sharepoint.com/sites/TestPSteamSite`
     -Owner fred.jonas@tomscloud.ch 	`
     -Title "Modern Stand Alone Team Site" `
     -Template STS#3	`
     -StorageQuota 10240

#An other site
New-SPOSite `
    -Url https://tomscloud.sharepoint.com/sites/TestPSCommSite `
     -Owner fred.jonas@tomscloud.ch `
     -Title "Communication Site" `
     -Template SITEPAGEPUBLISHING#0`
     -StorageQuota 10240

#Change some settings
Set-SPOSite `
    -Identity https://tomscloud.sharepoint.com/sites/TestPSCommSite`
    -Title "EMEA Sales"`
    -SocialBarOnSitePagesDisabled $true`
    -SharingCapability ExternalUserSharingOnly

#To remove a site
Remove-SPOSite `
    -Identity https://tomscloud.sharepoint.com/sites/TestPSCommSite `
    -Confirm:$false

#Restore a site
Restore-SPODeletedSite `
    -Identity https://tomscloud.sharepoint.com/sites/TestPSCommSite

#How to register a hub site
Register-SPOHubSite `
    -Site https://tomscloud.sharepoint.com/sites/TestPSCommSite  `
    -Principals $null

#Add a hub site association
Add-SPOHubSiteAssociation`
    -Site https://tomscloud.sharepoint.com/sites/TestPSteamSite `
     -HubSite https://tomscloud.sharepoint.com/sites/TestPSCommSite