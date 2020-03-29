Set-Location c:\
Clear-Host

#Erstellen einer Text Datei mit den Login-Daten (diese sind nicht im Klartext!!)
(Get-Credential).Password | ConvertFrom-SecureString| Out-File "C:\Scripts\Password.txt"

#Erstellen von Variablen mit Login-Daten
$User = "tom@videotrainer.ch"
$File = "C:\Scripts\Password.txt"
$cred = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $User, (Get-Content $File | ConvertTo-SecureString)

#Installieren der Module
Install-Module -Name AzureAD -Force -AllowClobber -Verbose
Install-Module -Name MSOnline -Force -AllowClobber -Verbose
Install-Module -Name Microsoft.Online.SharePoint.PowerShell
# https://www.microsoft.com/download/details.aspx?id=39366 (Skype for Business)

#Importieren der Module in die lokale PowerShell Sitzung
Import-Module AzureAD
Import-Module MsOnline
Import-Module Microsoft.Online.SharePoint.PowerShell
Import-Module "C:\\Program Files\\Common Files\\Skype for Business Online\\Modules\\SkypeOnlineConnector\\SkypeOnlineConnector.psd1"

#Erstellen einer "Session" zu Skype for Business und Exchange Online
$s4b= New-CsOnlineSession -Credential $cred
$exchange = New-PSSession -ConfigurationName Microsoft.Exchange –ConnectionUri https://outlook.office365.com/powershell-liveid/ -Credential $cred -Authentication Basic –AllowRedirection

#Verbinden zu Office 365 und SharePoint
Connect-MsolService -Credential $cred
Connect-SPOService -Url https://wechsler75-admin.sharepoint.com -credential $cred

#Verbinden mit AzureAD
Connect-AzureAD -Credential $cred

#Importieren der Session's in die lokale PowerShell Sitzung
Import-PSSession $exchange -AllowClobber
Import-PSSession $s4b

#Hat es funktioniert?
Get-MsolUser
Get-Mailbox
Get-SPOSite
Get-CsOnlineUser
Get-AzureADUser