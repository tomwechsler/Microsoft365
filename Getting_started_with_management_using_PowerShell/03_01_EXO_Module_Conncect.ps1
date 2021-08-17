Set-Location C:\
Clear-Host

#We need the exchange online modil
Install-Module -Name ExchangeOnlineManagement -Verbose -AllowClobber -Force

#Create a variable with credentials
$cred = Get-Credential

#Lets connect
Connect-ExchangeOnline –Credential $cred

#Did it work?
Get-Mailbox