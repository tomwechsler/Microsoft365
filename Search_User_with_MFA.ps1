Set-Location c:\
Clear-Host

#We need the PowerShell module
Install-Module MSOnline -AllowClobber -Force -Verbose

#Connect to Microsoft 365
Connect-MsolService

#Did it work
Get-MsolUser

#We search the properties of Get-MsolUser
Get-MsolUser | Get-Member

#A first investigation
Get-MsolUser -All | where {$_.StrongAuthenticationMethods -ne $null} | Select-Object -Property UserPrincipalName

#Run the following command to output MFA details and status for all users
Get-MsolUser -All | select DisplayName,UserPrincipalName,@{N="MFA Status"; E={ if( $_.StrongAuthenticationMethods.IsDefault -eq $true) {($_.StrongAuthenticationMethods | Where IsDefault -eq $True).MethodType} else { "Disabled"}}} | FT -AutoSize

#Details for one specific user
Get-MsolUser -UserPrincipalName jane.ford@tomwechsler.xyz | select DisplayName,UserPrincipalName,@{N="MFA Status"; E={ if( $_.StrongAuthenticationMethods.IsDefault -eq $true) {($_.StrongAuthenticationMethods | Where IsDefault -eq $True).MethodType} else { "Disabled"}}} | FT -AutoSize

#enables MFA for an individual user (a Conditional Access Policy would be a better way)
$st = New-Object -TypeName Microsoft.Online.Administration.StrongAuthenticationRequirement
$st.RelyingParty = "*"
$st.State = "Enabled"
$sta = @($st)

#Change the following UserPrincipalName to the user you wish to change state
Set-MsolUser -UserPrincipalName tim.jones@tomwechsler.xyz -StrongAuthenticationRequirements $sta

#Check
Get-MsolUser -All | where {$_.StrongAuthenticationMethods -ne $null} | Select-Object -Property UserPrincipalName

#Define your list of users to update state in bulk (a Conditional Access Policy would be a better way)
$users = "tim.taylor@tomwechsler.xyz","tim.jones@tomwechsler.xyz","jane.ford@tomwechsler.xyz"

foreach ($user in $users)
{
    $st = New-Object -TypeName Microsoft.Online.Administration.StrongAuthenticationRequirement
    $st.RelyingParty = "*"
    $st.State = "Enabled"
    $sta = @($st)
    Set-MsolUser -UserPrincipalName $user -StrongAuthenticationRequirements $sta
}

#Check in the Azure Portal

#To disable MFA
Get-MsolUser -UserPrincipalName tim.jones@tomwechsler.xyz | Set-MsolUser -StrongAuthenticationRequirements @()

#You could also directly disable MFA
Set-MsolUser -UserPrincipalName tim.taylor@tomwechsler.xyz -StrongAuthenticationRequirements @()
