Set-Location C:\
Clear-Host

#We need the module (without the parameter for a specific version)
Install-Module -Name ExchangeOnlineManagement -AllowClobber -Force -Verbose

#More specific if you want
Install-Module -Name ExchangeOnlineManagement -RequiredVersion 2.0.3 -AllowClobber -Force -Verbose

#Let's import the module
Import-Module ExchangeOnlineManagement

#Check the version (if you have not selected a version)
Get-InstalledModule -Name ExchangeOnlineManagement

#Variable for the Credential
$UserCredential = Get-Credential

#Now we connect to Exchange Online
Connect-ExchangeOnline -Credential $UserCredential -ShowProgress $true

#Another way to connect (choose one or the other)
Connect-ExchangeOnline -UserPrincipalName tom@wechsler.onmicrosoft.com -ShowProgress $true

#Specific information from a user
Get-Mailbox –Identity tina.jackson@tomwechsler.xyz | Format-List Identity, ExchangeGUID

#Let's check the accepted domain
Get-AcceptedDomain | Format-List Domainname, *type*

#Check the large audience (sender adds distribution group that has more members than the configured large audience size, they are shown the Large Audience MailTip
Get-OrganizationConfig | Select-Object MailTipsLargeAudienceThreshold

#We investigate a specific role group
Get-RoleGroup "Recipient Management" | Format-List

#We expand the roles property
Get-RoleGroup "Recipient Management" | Select-Object -ExpandProperty Roles

#View the retention policy
Get-RetentionPolicy

#Let's look at the default policy
Get-RetentionPolicy -Identity "Default MRM Policy" | Format-List

#Closer look at the retention policy tag links
Get-RetentionPolicy -Identity "Default MRM Policy" | Select-Object -ExpandProperty RetentionPolicyTagLinks
