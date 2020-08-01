Set-Location c:\
Clear-Host

#Exchange

$Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri https://outlook.office365.com/powershell-liveid/ -Credential $UserCredential -Authentication Basic -AllowRedirection

Import-PSSession $Session

#Hat's geklappt?
Get-Mailbox

#Freigegebenes Postfach
New-Mailbox -Shared -Name "IT Support" -Alias ITSupport 

Set-Mailbox ITSupport -RequireSenderAuthenticationEnabled $true

Set-Mailbox "ITSupport@videotrainer.ch" -GrantSendOnBehalfTo “tim.allen@videotrainer01.onmicrosoft.com" 

Get-Mailbox "IT Support" | FL Name,RecipientTypeDetails,PrimarySmtpAddress,requiresenderauthenticationenabled,grantsendonbehalfto,accessrights

Add-RecipientPermission -identity "ITSupport@videotrainer.ch" -accessrights SendAs -trustee "tim.taylor@videotrainer01.onmicrosoft.com"

Add-MailboxPermission -Identity "IT Support" -user "tim.taylor" -AccessRights FullAccess -InheritanceType all

Get-MailboxPermission -Identity "ITSupport@videotrainer.ch"

Get-RecipientPermission -Identity "ITSupport@videotrainer.ch"


