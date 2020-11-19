Set-Location c:\
Clear-Host

#We need the PowerShell module
Install-Module MSOnline -AllowClobber -Force -Verbose

#Variables 
$startDate = "{0:yyyy-MM-dd}" -f (get-date).AddDays(-90)	#90 days prior date.
$endDate = "{0:yyyy-MM-dd}" -f (get-date)	#current date.
$externalUserExtention = "*#EXT#*"

#Path for log file.
$filePath="<filepath>\logs.txt"

#Get Credentials
$credentials=Get-Credential

#Load Modules for exchange online
$session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri https://outlook.office365.com/powershell-liveid/ -Credential $credentials -Authentication Basic -AllowRedirection
Import-PSSession $session -DisableNameChecking -AllowClobber

#Log to text file.
function logtoText($filePath, $msg){$msg >> $filepath;}
#Log to text ends here.

#Get All External Users
Connect-MsolService -Credential $credentials
$allExternalUsers = Get-MsolUser | Where-Object -FilterScript { $_.UserPrincipalName -Like $externalUserExtention }

#Get Unified Audit Log for all users.
ForEach($externalUser in $allExternalUsers)
{
#Get the last login date.
$lastLoginDate =Search-UnifiedAuditLog -UserIds  $externalUser.UserPrincipalName -StartDate $startDate -EndDate $endDate| Foreach-Object {$_.CreationDate = [DateTime]$_.CreationDate; $_} | Group-Object UserIds | Foreach-Object {$_.Group | Sort-Object CreationDate | Select-Object -Last 1} | Select CreationDate
#Log the details.
Write-Host "User -" $externalUser.UserPrincipalName "| Last Login Date -" $lastLoginDate.CreationDate
logtoText $filePath ("User - " + $externalUser.UserPrincipalName + "| Last Login Date - " + $lastLoginDate.CreationDate)
}
#Get All External Users ends here