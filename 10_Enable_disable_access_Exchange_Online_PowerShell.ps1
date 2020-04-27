Set-Location c:\
Clear-Host

$UserCredential = Get-Credential

$Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri https://outlook.office365.com/powershell-liveid/ -Credential $UserCredential -Authentication Basic -AllowRedirection

Import-PSSession $Session -DisableNameChecking

#Enable or disable access to Exchange Online PowerShell for a user
Set-User -Identity tim.taylor@contosotom.ch -RemotePowerShellEnabled $false

Set-User -Identity tim.taylor@contosotom.ch -RemotePowerShellEnabled $true

Get-User -Identity "Tim Taylor" | Format-List RemotePowerShellEnabled

#This example removes access to Exchange Online PowerShell for all users whose Title attribute contains the value "Sales Associate".

$DSA = Get-User -ResultSize unlimited -Filter "(RecipientType -eq 'UserMailbox') -and (Title -like '*Sales Associate*')"

$DSA | foreach {Set-User -Identity $_ -RemotePowerShellEnabled $false}

#Use a list of specific users
$NPS = Get-Content "C:\NoPowerShell.txt"

$NPS | foreach {Set-User -Identity $_ -RemotePowerShellEnabled $false}

Get-User -Identity "Fred Prefect" | Format-List RemotePowerShellEnabled

#To display the Exchange Online PowerShell access status for all users
Get-User -ResultSize unlimited | Format-Table -Auto Name,DisplayName,RemotePowerShellEnabled

#To display only those users who don't have access to Exchange Online PowerShell
Get-User -ResultSize unlimited -Filter 'RemotePowerShellEnabled -eq $false'

#To display only those users who have access to Exchange Online PowerShell
Get-User -ResultSize unlimited -Filter 'RemotePowerShellEnabled -eq $true'

Remove-PSSession $Session