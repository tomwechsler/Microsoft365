Set-Location c:\
Clear-Host

#Office 365 Advanced Message Encryption is included in Microsoft 365 E5, Office 365 E5 or Office 365 Education A5
#You need to be assigned permissions before you can run this cmdlet. (For this demo I used Organization Management Role Group)

#Install the module
Install-Module -Name ExchangeOnlineManagement -AllowClobber -Force -Verbose

#Optional import the module
Import-Module ExchangeOnlineManagement

#Connect to exchange
Connect-ExchangeOnline -UserPrincipalName tom@tomrocks.ch

#Did it work
Get-EXOMailbox

#Get the OME branding template
$ome = Get-OMEConfiguration | fl *

#All the settings
$ome

#Check the cmdlets
Get-Command -Name *OME*

#Find the permissions required to run a cmdlet
Get-ManagementRoleEntry -Identity *\New-OMEConfiguration | ft -AutoSize

#Create an OME branding template
New-OMEConfiguration -Identity "Outlook.com"

#Background color (blue)
Set-OMEConfiguration -Identity "Outlook.com" -BackgroundColor "#0000ff"

#Text next to the sender's name and email address
Set-OMEConfiguration -Identity "Outlook.com" -IntroductionText "has sent you a secure message."

#To disable authentication with Microsoft, Google, or Yahoo identities for this custom template
Set-OMEConfiguration -Identity "Outlook.com" -SocialIdSignIn $false

#To enable authentication with a one-time pass code for this custom template
Set-OMEConfiguration -Identity "Outlook.com" -OTPEnabled $true

#Optional set expiry days
Set-OMEConfiguration -Identity "Outlook.com" -ExternalMailExpiryInDays 7

#For more Infos check:
#https://docs.microsoft.com/en-us/microsoft-365/compliance/add-your-organization-brand-to-encrypted-messages?view=o365-worldwide#create-an-ome-branding-template-advanced-message-encryption

#Check the details
$customome = Get-OMEConfiguration -Identity "Outlook.com" | fl *

#All the settings
$customome

#Create an Exchange mail flow rule that applies your custom branding to encrypted emails
#https://docs.microsoft.com/en-us/microsoft-365/compliance/add-your-organization-brand-to-encrypted-messages?view=o365-worldwide#create-an-exchange-mail-flow-rule-that-applies-your-custom-branding-to-encrypted-emails

#Remove a custom branding template
Remove-OMEConfiguration -Identity "Outlook.com"

#Disconnect
Disconnect-ExchangeOnline