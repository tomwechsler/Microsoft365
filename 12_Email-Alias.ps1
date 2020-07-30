Set-Location c:\
Clear-Host

#Exchange
$Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri https://outlook.office365.com/powershell-liveid/ -Credential $UserCredential -Authentication Basic -AllowRedirection

Import-PSSession $Session -AllowClobber

#Sind wir verbunden?
Get-Mailbox

#Achtung: Objekte welche durch AD Connect synchronisert wurden, müssen im lokalen AD bearbeitet werden
Get-mailbox "Stefan Hinz" | select -ExpandProperty emailaddresses
Set-Mailbox "Stefan Hinz" -EmailAddresses @{add="sh@videotrainer01.onmicrosoft.com"}


New-Mailbox -Alias "Zurbriggen" -Name "Zurbriggen" -DisplayName "Pirmin Zurbriggen" -MicrosoftOnlineServicesID zurbriggen@videotrainer01.onmicrosoft.com -Password (ConvertTo-SecureString -String 'Passw0rd' -AsPlainText -Force) -ResetPasswordOnNextLogon $false
Get-mailbox "Zurbriggen" | select -ExpandProperty emailaddresses


Set-Mailbox "Zurbriggen" -EmailAddresses @{add="pzurbriggen@videotrainer01.onmicrosoft.com"}

Get-mailbox "Zurbriggen" | select -ExpandProperty emailaddresses


Set-Mailbox "Zurbriggen" -WindowsEmailAddress pzurbriggen@videotrainer01.onmicrosoft.com

Get-mailbox "Zurbriggen" | select -ExpandProperty emailaddresses


Remove-Mailbox -Identity "Zurbriggen"

Get-Mailbox
