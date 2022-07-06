Set-Location c:\
Clear-Host

$UserCredential = Get-Credential

$Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri https://outlook.office365.com/powershell-liveid/ -Credential $UserCredential -Authentication Basic -AllowRedirection

Import-PSSession $Session -DisableNameChecking

Get-Mailbox -Identity "Jane Ford"

Get-Mailbox -Identity "Jane Ford" | Format-List

Get-Mailbox -Identity "Jane Ford" | Format-List DisplayName, LitigationHoldEnabled, LitigationHoldDate, LitigationHoldOwner, LitigationHoldDuration

Get-Mailbox -Identity "Jane Ford" | Format-List DisplayName, Lit*

Get-Mailbox -ResultSize unlimited | Format-Table DisplayName, LitigationHoldEnabled -Auto

Get-Mailbox -ResultSize unlimited | Where-Object {$_.LitigationHoldEnabled -eq $True}

Get-MailboxJunkEmailConfiguration -Identity "Jane Ford"

Get-Mailbox -ResultSize unlimited | Get-MailboxJunkEmailConfiguration | Where-Object {$_.Enabled -eq $false}

Get-Mailbox | Get-MailboxStatistics | Format-Table displayname, totalitemsize, ItemCount


#Make sure that the Remote PowerShell session is disconnected
Remove-PSSession $Session
