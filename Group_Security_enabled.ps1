Set-Location C:\Temp
Clear-Host

#We need the cmdlets
Install-Module -Name AzureAD -AllowClobber -Force -Verbose

#Sometimes the module must be imported
Import-Module AzureAD

#Lets connect to the Azure Active Directory
Connect-AzureAD

#Did it work?
Get-AzureADMSGroup

#We examine the "Marketing" Microsoft 365 group for the property "SecurityEnabled" where the value false is returned!
(Get-AzureADMSGroup -SearchString "Marketing").SecurityEnabled

#We examine the "Administration" Microsoft 365 group for the property "SecurityEnabled" where the value true is returned!!
(Get-AzureADMSGroup -SearchString "Administration").SecurityEnabled

#We need the group ID
Get-AzureADMSGroup -SearchString "Marketing"

#Now we change the value
Set-AzureADMSGroup -Id 0aa1d3df-97ce-4c03-8547-f09add7f6d3c -SecurityEnabled $true
