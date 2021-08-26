Set-Location C:\
Clear-Host

param(
[Parameter(Position=0,Mandatory=$True,ValueFromPipeline=$True)]
[string]$Identity,
[Parameter(Position=1,Mandatory=$False,ValueFromPipeline=$True)]
[switch]$KeepForwarding)

#Organizational information
$AcceptedDomains = Get-AcceptedDomain
$AcceptedDomains = $AcceptedDomains.DomainName
$AcceptedDomains = $AcceptedDomains.Domain

#Check wether this is actually a mail enabled user
#Exit when RecipientType is a MailUser
$User = Get-User $Identity -ErrorAction SilentlyContinue
$RecipientType = $User.RecipientType
If ($RecipientType -ne "MailUser") {
    Write-Output "$Identity is not a Mail Enabled user, but a $RecipientType. Nothing has been changed."
    Exit
}    

#Store relevant information
$MailUser = Get-MailUser $Identity
$SMTPValues = $MailUser.EmailAddresses
$SMTPValues = $SMTPValues.SmtpAddress
$SMTPExternal = $MailUser.ExternalEmailAddress
$SMTPPrimary = $MailUser.PrimarySmtpAddress
$Alias = $MailUser.Alias

#Mail disable MailUser without the need for confirmation. Account is now a normal AD user.
Disable-MailUser $Identity -Confirm:$False

#Now Mailbox enable the same user with same Alias as when it was a mail user
Enable-Mailbox -Identity $Identity -Alias $Alias

#Check what the current PrimarySMTPAddress is and compare it to the Mail User
$Mailbox = Get-Mailbox $Identity
$MailboxPrimarySMTP = $Mailbox.PrimarySMTPAddress
If ($MailboxPrimarySMTP -ne $SMTPPrimary) {
    Write-Host "Warning! The Mailbox Reply SMTP differs from the Primary SMTP as when the user was mail enabled." -foregroundcolor "Red"    
    Write-Host "Check whether this should be the case and whether the correct Email Addres Policy has been applied." -foregroundcolor "Red"  
} else {
    Write-Host "Informational: Mailbox Reply SMTP is the same as the Primary SMTP when the user was mail enabled:$MailboxPrimarySMTP"
}

#Now we have to check and add all other SMTP Addresses.
$CounterA = 0
ForEach ($SMTPAddress in $SMTPValues){
    $SMTPAddress = $SMTPValues[$CounterA]
    $CounterB = 0
    $AmountSMTPAdded = 0
    ForEach ($AcceptedDomain in $AcceptedDomains) { 
        $AcceptedDomain = $AcceptedDomains[$CounterB]

        #Check whether the SMTP addres falls within the configured accepted domains
        If ($SMTPAddress.ToLower().EndsWith("$AcceptedDomain")) {
                
                #Check whether the SMTP Address is the current Reply SMTP and thus already added
                If ($SMTPAddress -ne $MailboxPrimarySMTP) {
                    Set-Mailbox –identity $Identity -EmailAddresses @{Add="$SMTPAddress"}
                    Write-Host "$SMTPAddress has been added as an SMTP Addres to $Identity"
                    $AmountSMTPAdded = $AmountSMTPAdded + 1
                } else {
                    If ($SMTPAddress -eq $MailboxPrimarySMTP) {
                        $AmountSMTPAdded = $AmountSMTPAdded + 1
                    }
                }
        }
        $CounterB = $CounterB + 1      
    }
    $CounterA = $CounterA + 1
    If ($AmountSMTPAdded -eq 0) { 
        Write-Host "Informational: $SMTPAddress does not correspond with any Accepted Domain and has not been added." -foregroundcolor "Yellow" 
    }
}
        
#If optional parameter KeepForwarding is set to $True, the Forwarding SMTP Address will be set
#Mail will be delivered to mailbox and to external address        
If ($KeepForwarding -eq $True) {
    Set-Mailbox -Identity $Identity -ForwardingSmtpAddress $SMTPExternal -DeliverToMailboxAndForward $True
    Write-Host "Mail for $Identity will be delivered to the mailbox AND forwarded to $SMTPExternal"
}
