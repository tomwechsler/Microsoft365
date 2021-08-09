Set-Location c:\
Clear-Host

Set-ExecutionPolicy -ExecutionPolicy Unrestricted

#Install the AzureADPreview
Install-Module -Name AzureADPreview -AllowClobber -Verbose -Force

#Connect without MFA
$cred = Get-Credential 
Connect-AzureAD -Credential $cred

#Connect with MFA
Connect-AzureAD -AccountId "tom@tomscloud.ch"

#IMPORTANT => You cannot install both modules on the same system!

#Install the AzureAD
Install-Module -Name AzureAD -AllowClobber -Verbose -Force

#Connect without MFA
$cred = Get-Credential 
Connect-AzureAD -Credential $cred

#Connect with MFA
Connect-AzureAD -AccountId "tom@tomscloud.ch"

#Did it work?
Get-AzureADUser

#With MSOnline
Set-Location C:\
Clear-Host

Install-Module MSOnline -AllowClobber -Force -Verbose

Connect-MsolService

Get-MsolAccountSku

Get-AzureADSubscribedSku | Select SkuPartNumber

Get-AzureADUser -ObjectID jane.ford@tomscloud.ch | Select DisplayName, UsageLocation

(Get-MsolAccountSku | where {$_.AccountSkuId -eq "wechsler:SPE_E5"}).ServiceStatus

Get-MsolUser -UserPrincipalName jane.ford@tomscloud.ch | Format-List DisplayName,Licenses

(Get-MsolUser -UserPrincipalName jane.ford@tomscloud.ch).Licenses.ServiceStatus

Get-MsolUser -All -UnlicensedUsersOnly

Get-MsolUser -All | where {$_.UsageLocation -eq $null}
