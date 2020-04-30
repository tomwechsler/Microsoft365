Set-Location c:\
Clear-Host

$UserCredential = Get-Credential

#Exchange
$Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri https://outlook.office365.com/powershell-liveid/ -Credential $UserCredential -Authentication Basic -AllowRedirection

Import-PSSession $Session

Get-Mailbox

#Verteilerliste

New-DistributionGroup -Name “Raumvermietung” -MemberJoinRestriction open

#Sicherheitsgruppe

New-DistributionGroup -Name "Techniker" -Alias Techniker -Type "Security" -Members jane.ford@contosotom.ch

#Mitglieder hinzufügen

Add-DistributionGroupMember -Identity "Techniker" -Member "tim.taylor@contosotom.ch"

#Liste der Mitglieder

Get-DistributionGroupmember -Identity "Techniker"

#Dynamische Gruppe

New-DynamicDistributionGroup -IncludedRecipients MailboxUsers -Name "Fachschaft" -ConditionalDepartment Fachschaft

Get-DynamicDistributionGroup | FL Name,RecipientTypeDetails,RecipientFilter,PrimarySmtpAddress

$FTE = Get-DynamicDistributionGroup "Fachschaft"

Get-Recipient -RecipientPreviewFilter $FTE.RecipientFilter -OrganizationalUnit $FTE.RecipientContainer

Remove-PSSession $Session
