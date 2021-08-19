#List mailbox
Get-EXOMailbox | Select DisplayName, RecipientTypeDetails | Format-Table -AutoSize

#View organisation configuration
Get-OrganizationConfig 

#Some settings
Set-Mailbox -Identity fred.prefect `
	-HiddenFromAddressListsEnabled $true `
	-DeliverToMailboxAndForward $false `
	-ForwardingAddress fred.jonas@tomrocks.ch

#New mail contact
New-MailContact `
	-Name "401K Questions" `
	-ExternalEmailAddress companyname@tomticket.com 

#Some settings
Set-MailContact `
	-Identity "401K Questions" `
	-MailTip "Do not send confidential information to this mailbox!"

#We create some text
$Body = @"
"Hello </br> </br>
Please Note I am not currently working for tomrocks anymore. </br> </br>  
Please contact Tom Wechsler <a href="mailto:tom@tomrocks.ch">tom@tomrocks.ch</a> for any questions. </br> </br>
Thanks!"
"@

#Set the auto reply
Set-MailboxAutoReplyConfiguration `
	-Identity fred.jonas@tomrocks.ch `
	-ExternalMessage $body `
	-InternalMessage $body `
	-AutoReplyState Enabled

#List the groups
Get-DistributionGroup

#Add group member
Add-DistributionGroupMember `
	-Identity "Marketing" `
	-Member "fred.jonas@tomrocks.ch"

#Some settings
Set-DistributionGroup `
	-Identity "All Company" `
	-AcceptMessagesOnlyFrom "tom@tomrocks.ch"