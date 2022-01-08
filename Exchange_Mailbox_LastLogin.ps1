Set-Location C:\
Clear-Host

#We need the module (without the parameter for a specific version)
Install-Module -Name ExchangeOnlineManagement -AllowClobber -Force -Verbose

#Let's import the module
Import-Module ExchangeOnlineManagement

#Check the version (if you have not selected a version)
Get-InstalledModule -Name ExchangeOnlineManagement

#Now we connect to Exchange Online
Connect-ExchangeOnline

#Let's check the accepted domain (Just for info)
Get-AcceptedDomain | Format-List Domainname, *type*

#Specific information from a user
Get-Mailbox -Identity jane.ford@tomrocks.ch | Format-List Identity,WhenCreated,ExchangeGUID

#Display the list of inactive mailboxes
Get-Mailbox -InactiveMailboxOnly | FT DisplayName,PrimarySMTPAddress,WhenSoftDeleted

#Export the list of inactive mailboxes
Get-Mailbox -InactiveMailboxOnly | Select Displayname,PrimarySMTPAddress,DistinguishedName,ExchangeGuid,WhenSoftDeleted | Export-Csv InactiveMailboxes.csv -NoType

#All mailboxes in one variable
$mailboxes = Get-Mailbox

#Latest date of receipt item
ForEach ($user in $mailboxes){
Get-MailboxFolderStatistics $user.name -IncludeOldestAndNewestItems | Sort-Object NewestItemReceivedDate | 
Where-Object {$_.NewestItemReceivedDate -ne $null} | Select-Object Identity,NewestItemReceivedDate -last 1 }

#Last logon time
Get-Mailbox -ResultSize Unlimited | Get-MailboxStatistics | Select-Object DisplayName,LastLogonTime

#Last login for 90 days
Get-Mailbox -ResultSize Unlimited | Get-MailboxStatistics | Where{$_.Lastlogontime -lt (Get-Date).AddDays(-90)} | Select DisplayName, LastLoggedOnUserAccount, LastLogonTime

#Never Logged In
$mailboxes = Get-Mailbox -ResultSize Unlimited
$mailboxes | ForEach-Object {
$mbx = $_
$mbs = Get-MailboxStatistics -Identity $mbx.UserPrincipalName | Select-Object LastLogonTime
if ($mbs.LastLogonTime -eq $null){
$lt = "Never Logged In"
}else{
$lt = $mbs.LastLogonTime }

New-Object -TypeName PSObject -Property @{ 
UserPrincipalName = $mbx.UserPrincipalName
LastLogonTime = $lt }
}
