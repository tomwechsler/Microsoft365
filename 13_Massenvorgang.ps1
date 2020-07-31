Set-Location c:\
Clear-Host

#Connect to Exchange
$Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri https://outlook.office365.com/powershell-liveid/ -Credential $UserCredential -Authentication Basic -AllowRedirection

Import-PSSession $Session -AllowClobber

#Sind wir verbunden?
Get-Mailbox

Get-mailbox "tim.taylor" | select -ExpandProperty emailaddresses

Import-CSV "C:\import\Email-Adressen.csv" | ForEach {Set-Mailbox $_.Mailbox –EmailAddresses @{Add=$_.NewEmailAddress}}

Get-mailbox "tim.taylor" | select -ExpandProperty emailaddresses

Get-mailbox "tim.allen" | select -ExpandProperty emailaddresses

Remove-PSSession $session