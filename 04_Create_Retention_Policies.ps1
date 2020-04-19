Set-Location c:\
Clear-Host

$UserCredential = Get-Credential

$Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri https://outlook.office365.com/powershell-liveid/ -Credential $UserCredential -Authentication Basic -AllowRedirection

Import-PSSession $Session -DisableNameChecking

#Nach 6 Monaten archivieren
New-RetentionPolicyTag “Archivierung” –Type All –RetentionEnabled $true –AgeLimitForRetention 180 –RetentionAction MoveToArchive

#Löschen nach 7 Jahren
New-RetentionPolicyTag “Loeschen” –Type All –RetentionEnabled $true –AgeLimitForRetention 2555 –RetentionAction PermanentlyDelete

#2 Jahre Wiederherstellung möglich
New-RetentionPolicyTag “Loeschen und Wiederherstellung” –Type DeletedItems –RetentionEnabled $true –AgeLimitForRetention 730 –RetentionAction DeleteandAllowRecovery

New-RetentionPolicy “Corp retention policy” –RetentionPolicyTagLinks “Archivierung", "Loeschen", "Loeschen und Wiederherstellung”

Get-RetentionPolicy "Corp retention policy"
 
Set-Mailbox "tim.taylor" -RetentionPolicy "Corp retention policy"

Get-Mailbox "tim.taylor" | select retentionPolicy


Remove-PSSession $Session