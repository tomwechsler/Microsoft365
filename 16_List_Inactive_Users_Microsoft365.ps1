Set-Location C:\
Clear-Host

#Install MSOline Module
Install-Module -Name MSOnline -AllowClobber -Force -Verbose

#Import MSOline Module
Import-Module -Name MSOnline

#This connects to Microsoft 365
Connect-MsolService

#We need the module (without the parameter for a specific version)
Install-Module -Name ExchangeOnlineManagement -Force -Verbose

#More specific if you want
Install-Module -Name ExchangeOnlineManagement -RequiredVersion 2.0.5 -Force -Verbose

#Update the module (if necessary)
Update-Module -Name ExchangeOnlineManagement -Verbose -Force

#Let's import the module
Import-Module ExchangeOnlineManagement

#Check the version (if you have not selected a version)
Get-InstalledModule -Name ExchangeOnlineManagement

#Variable for the Credential
$UserCredential = Get-Credential

#Now we connect to Exchange Online
Connect-ExchangeOnline -Credential $UserCredential

#Another way to connect (choose one or the other)
Connect-ExchangeOnline -UserPrincipalName tom@wechsler.cloud

#Set admin UPN
$UPN = 'tom@wechsler.cloud'

#Time range
$startDate = (Get-Date).AddDays(-180).ToString('MM/dd/yyyy')
$endDate = (Get-Date).ToString('MM/dd/yyyy')

#We are looking for accounts that are active - not deactivated
$allUsers = @()
$allUsers = Get-MsolUser -All -EnabledFilter EnabledOnly | Select UserPrincipalName

#We search
$loggedOnUsers = @()
$loggedOnUsers = Search-UnifiedAuditLog -StartDate $startDate -EndDate $endDate -Operations UserLoggedIn, PasswordLogonInitialAuthUsingPassword, UserLoginFailed -ResultSize 5000

#Create the list
$inactiveInLastSixMonthsUsers = @()
$inactiveInLastSixMonthsUsers = $allUsers.UserPrincipalName | where {$loggedOnUsers.UserIds -NotContains $_}

#We get a result
Write-Output "The following users have no logged in for the last 180 days:"

#written to the screen
Write-Output $inactiveInLastSixMonthsUsers

#Export list to CSV
$inactiveInLastSixMonthsUsers
$inactiveInLastSixMonthsUsers > "C:\Temp\InactiveUsers.csv"

#Remove the session
Disconnect-ExchangeOnline -Confirm:$false