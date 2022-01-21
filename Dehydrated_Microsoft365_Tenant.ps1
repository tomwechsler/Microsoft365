Set-Location C:\
Clear-Host

#We need the exchange online modil
Install-Module -Name ExchangeOnlineManagement -Verbose -AllowClobber -Force

#Lets connect
Connect-ExchangeOnline

#Did it work?
Get-Mailbox

#We can check the dehydrate status using the below command
Get-OrganizationConfig | Format-List Identity,IsDehydrated

#If the Microsoft 365 tenant is dehydrated. We can hydrate the tenant using the below command
Enable-OrganizationCustomization

#We can check the dehydrate status using the below command
Get-OrganizationConfig | Format-List Identity,IsDehydrated