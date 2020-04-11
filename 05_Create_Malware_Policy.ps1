Set-Location c:\
Clear-Host

$UserCredential = Get-Credential

$Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri https://outlook.office365.com/powershell-liveid/ -Credential $UserCredential -Authentication Basic -AllowRedirection

Import-PSSession $Session -DisableNameChecking

#Policy

New-MalwareFilterpolicy -Name "Corp Malware Richtlinie" -Action deletemessage -EnableInternalSenderAdminNotifications $true -InternalSenderAdminAddress admin365@wechsler19.onmicrosoft.com

Set-MalwareFilterPolicy -Identity "Corp Malware Richtlinie" -EnableFileFilter $true -Filetype exe,com,vbs,js,SH*T

Get-MalwareFilterPolicy "Corp Malware Richtlinie" | FL

 
#Rule

New-MalwareFilterRule -Name "Schutz fuer Alle" -MalwareFilterPolicy "Corp Malware Richtlinie" -RecipientDomainIs wechsler19.onmicrosoft.com

Get-MalwareFilterRule

Get-MalwareFilterRule "Schutz fuer Alle" | FL

Disable-MalwareFilterRule "Schutz fuer Alle"

Remove-PSSession $Session