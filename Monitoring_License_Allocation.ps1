Set-Location c:\
Clear-Host

#We need the PowerShell module
Install-Module MSOnline -AllowClobber -Force -Verbose

#Lets connect
Connect-MsolService

#To find the unlicensed accounts in your organization
Get-MsolUser -All -UnlicensedUsersOnly

#To find accounts that don't have a UsageLocation value
Get-MsolUser -All | where {$_.UsageLocation -eq $null}

#View all users with Displayname and UsageLocation
Get-MsolUser -All | Format-Table DisplayName,Usagelocation -AutoSize

#List the licensing plans that are available in your organization
Get-MsolAccountSku

#List the services that are available in each licensing plan
(Get-MsolAccountSku | where {$_.AccountSkuId -eq "wechsler:ENTERPRISEPREMIUM"}).ServiceStatus

#This example shows the services to which the user jane.ford@tomwechsler.xyz has access
(Get-MsolUser -UserPrincipalName jane.ford@tomwechsler.xyz).Licenses.ServiceStatus

#Set UsageLocation for a specific user
Set-MsolUser -UserPrincipalName "info@wechsler.onmicrosoft.com" -UsageLocation CH

#Add a license for a specific user
Set-MsolUserLicense -UserPrincipalName "info@wechsler.onmicrosoft.com" -AddLicenses "wechsler:ENTERPRISEPREMIUM"

#Set a license for all unlicensed users (maybe not the best option - be careful)
Get-MsolUser -All -UnlicensedUsersOnly | Set-MsolUserLicense -AddLicenses "wechsler:ENTERPRISEPREMIUM"

#We investigate a department
Get-MsolUser -All -Department "Administration" -UnlicensedUsersOnly | Select-Object DisplayName, UsageLocation, Islicensed

#Set UsageLocation for a specific user
Set-MsolUser -UserPrincipalName "jane.dodge@tomwechsler.xyz" -UsageLocation CH

#A safer to add licenses to users
Get-MsolUser -All -Department "Administration" -UsageLocation "CH" -UnlicensedUsersOnly | Set-MsolUserLicense -AddLicenses "wechsler:ENTERPRISEPREMIUM"

#To view all the services for a user who has been assigned multiple licenses
$userUPN="jane.ford@tomwechsler.xyz"
$AllLicenses=(Get-MsolUser -UserPrincipalName $userUPN).Licenses
$licArray = @()
for($i = 0; $i -lt $AllLicenses.Count; $i++)
{
$licArray += "License: " + $AllLicenses[$i].AccountSkuId
$licArray +=  $AllLicenses[$i].ServiceStatus
$licArray +=  ""
}
$licArray

#Remove a license for a specific user
Set-MsolUserLicense -UserPrincipalName jane.ford@tomwechsler.xyz -RemoveLicenses "wechsler:ENTERPRISEPREMIUM"

#This removes all licenses from all user accounts in the Administration department in the Switzerland
$userArray = Get-MsolUser -All -Department "Administration" -UsageLocation "CH" | where {$_.isLicensed -eq $true}
for ($i=0; $i -lt $userArray.Count; $i++)
{
Set-MsolUserLicense -UserPrincipalName $userArray[$i].UserPrincipalName -RemoveLicenses $userArray[$i].licenses.accountskuid
}