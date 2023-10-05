#Install the Exchange Online PowerShell module
Install-Module -Name ExchangeOnlineManagement -Verbose -Force -AllowClobber

#Connect to Exchange Online
Connect-ExchangeOnline

#Connect to Security & Compliance Center
Connect-IPPSSession

#Create an empty table for the results
$results = @()

#Go through all mailboxes in your organization
Get-Mailbox -ResultSize Unlimited | ForEach-Object {

    #search for the last access to the mailbox in the monitoring log
    $lastAccess = Search-MailboxAuditLog -Identity $_.Identity -ShowDetails -StartDate (Get-Date).AddDays(-30) | Sort-Object LastAccessed -Descending | Select-Object -First 1

    #Add the user name and the last access to the table
    $results += [PSCustomObject]@{
        Username = $_.UserPrincipalName
        LastAccess = $lastAccess.LastAccessed
        IsInactiveMailbox = $_.IsInactiveMailbox
    }
}

#Display the table or export it to a CSV file
$results | Format-Table -AutoSize

#$results | Export-Csv -Path C:\tempmailboxaudit.csv -NoTypeInformation