Set-Location C:\
Clear-Host

#To install the teams module
Install-Module -Name MicrosoftTeams -AllowClobber -Verbose -Force

#Credentials
$cred = Get-Credential

#Connect to Teams
Connect-MicrosoftTeams –Credential $cred

#Did it work?
Get-Team