Set-Location c:\
Clear-Host

#We need the PowerShell module
Install-Module MSOnline -AllowClobber -Force -Verbose

#Variables 
#90 days prior date
$startDate = "{0:yyyy-MM-dd}" -f (get-date).AddDays(-90)
#current date
$endDate = "{0:yyyy-MM-dd}" -f (get-date)
$externalUserExtention = "*#EXT#*"

#Path for log file
$filePath="C:\Temp\logs.txt"

#Get Credentials
$credentials=Get-Credential

#Create the session
$session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri https://outlook.office365.com/powershell-liveid/ -Credential $credentials -Authentication Basic -AllowRedirection

#Import the session
Import-PSSession $session -DisableNameChecking -AllowClobber

#Log to text file
function logtoText($filePath, $msg){$msg >> $filepath;}
#Log to text ends here

#Connect to Microsoft 365 (formerly Office365)
Connect-MsolService -Credential $credentials

#Search for all external users
$allExternalUsers = Get-MsolUser | Where-Object -FilterScript { $_.UserPrincipalName -Like $externalUserExtention }

#Get Unified Audit Log for all users
ForEach($externalUser in $allExternalUsers)
{
#Get the last login date
$lastLoginDate =Search-UnifiedAuditLog -UserIds  $externalUser.UserPrincipalName -StartDate $startDate -EndDate $endDate| Foreach-Object {$_.CreationDate = [DateTime]$_.CreationDate; $_} | Group-Object UserIds | Foreach-Object {$_.Group | Sort-Object CreationDate | Select-Object -Last 1} | Select CreationDate
#Log the details
Write-Host "User -" $externalUser.UserPrincipalName "| Last Login Date -" $lastLoginDate.CreationDate
logtoText $filePath ("User - " + $externalUser.UserPrincipalName + "| Last Login Date - " + $lastLoginDate.CreationDate)
}
#Get All External Users ends here

#Remove the session 
Remove-PSSession $Session
