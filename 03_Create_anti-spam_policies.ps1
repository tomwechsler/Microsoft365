Set-Location c:\
Clear-Host

$UserCredential = Get-Credential

$Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri https://outlook.office365.com/powershell-liveid/ -Credential $UserCredential -Authentication Basic -AllowRedirection

Import-PSSession $Session -DisableNameChecking

#create a spam filter policy

New-HostedContentFilterPolicy -Name "ContosoTom Executives" -HighConfidenceSpamAction Quarantine -SpamAction Quarantine -BulkThreshold 6 #BCL 6 triggers the action for a bulk email spam filtering verdict

#create a spam filter rule

New-HostedContentFilterRule -Name "ContosoTom Executives" -HostedContentFilterPolicy "ContosoTom Executives" -SentToMemberOf "ContosoTom Executives Group"

Get-HostedContentFilterPolicy

Get-HostedContentFilterPolicy -Identity "ContosoTom Executives" | Format-List

Get-HostedContentFilterRule

Get-HostedContentFilterRule -State Disabled

Get-HostedContentFilterRule -State Enabled

Get-HostedContentFilterRule -Identity "ContosoTom Executives" | Format-List

#How do you know these procedures worked?
#Send an with the following string in it:
XJS*C4JDBQADN1.NSBN3*2IDNEN*GTUBE-STANDARD-ANTI-UBE-TEST-EMAIL*C.34X

#remove spam filter policies
Remove-HostedContentFilterPolicy -Identity "ContosoTom Executives"

Remove-HostedContentFilterRule -Identity "ContosoTom Executives"

Remove-PSSession $Session