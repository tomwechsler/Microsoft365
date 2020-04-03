Set-Location c:\
Clear-Host

Install-Module MSOnline -AllowClobber -Force -Verbose

Install-Module AzureAD -AllowClobber -Force -Verbose

Connect-MsolService
Connect-AzureAD

Get-MsolAccountSku

Get-AzureADSubscribedSku | Select SkuPartNumber

Get-AzureADUser -ObjectID admin365@wechsler19.onmicrosoft.com | Select DisplayName, UsageLocation

(Get-MsolAccountSku | where {$_.AccountSkuId -eq "wechsler19:ENTERPRISEPACK"}).ServiceStatus

Get-MsolUser -UserPrincipalName admin365@wechsler19.onmicrosoft.com | Format-List DisplayName,Licenses

(Get-MsolUser -UserPrincipalName admin365@wechsler19.onmicrosoft.com).Licenses.ServiceStatus

Get-MsolUser -All -UnlicensedUsersOnly

Get-MsolUser -All | where {$_.UsageLocation -eq $null}

Set-MsolUser -UserPrincipalName "admin365@wechsler19.onmicrosoft.com" -UsageLocation CH

Set-MsolUserLicense -UserPrincipalName "admin365@wechsler19.onmicrosoft.com" -AddLicenses "wechsler19:ENTERPRISEPACK"

Get-MsolUser -All -UnlicensedUsersOnly | Set-MsolUserLicense -AddLicenses "wechsler19:ENTERPRISEPACK"

Get-MsolUser -All -Department "Sales" -UsageLocation "CH" -UnlicensedUsersOnly | Set-MsolUserLicense -AddLicenses "wechsler19:ENTERPRISEPACK"

#user who has been assigned multiple licenses
$userUPN="admin365@wechsler19.onmicrosoft.com"
$AllLicenses=(Get-MsolUser -UserPrincipalName $userUPN).Licenses
$licArray = @()
for($i = 0; $i -lt $AllLicenses.Count; $i++)
{
$licArray += "License: " + $AllLicenses[$i].AccountSkuId
$licArray +=  $AllLicenses[$i].ServiceStatus
$licArray +=  ""
}
$licArray