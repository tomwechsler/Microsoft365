Set-Location c:\
Clear-Host

$UserCredential = Get-Credential

#Exchange
$Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri https://outlook.office365.com/powershell-liveid/ -Credential $UserCredential -Authentication Basic -AllowRedirection

Import-PSSession $Session

#Raumpostfach
New-Mailbox -Name ZMRoom -DisplayName "Zuerich Meeting Raum" -Room

Set-CalendarProcessing ZMRoom -AutomateProcessing AutoAccept

#Gerätepostfach
New-Mailbox -Name "Mobiler Beamer" -Equipment

Get-Mailbox "ZMRoom" | Select-Object emailaddresses, Identity, Resourcetype

Get-Mailbox "Mobiler Beamer" | Select-Object emailaddresses, Identity, Resourcetype

Remove-PSSession $Session