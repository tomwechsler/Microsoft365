Set-Location c:\
Clear-Host

#We need the PowerShell module
Install-Module MSOnline -AllowClobber -Force -Verbose

#Connect to Microsoft 365 (formerly Office365)
Connect-MsolService

#Did it work
Get-MsolUser

#We search the properties of Get-MsolUser
Get-MsolUser | Get-Member

#Just so, who has a license
Get-MsolUser -All | where {$_.IsLicensed -ne $null} | Select-Object -Property Displayname, UserPrincipalName

#Just so, who has no license
Get-MsolUser -All | where {$_.IsLicensed -eq $false} | Select-Object -Property Displayname, UserPrincipalName

#The last password change time stamp
Get-MsolUser -All | Select DisplayName,UserPrincipalName,LastPasswordChangeTimeStamp

#Listing the admin roles
Get-MsolRole | Out-GridView

#Note: The names of the roles differ from the Azure AD

#Who is Global Admin? 
$comrole = Get-MsolRole -RoleName "Company Administrator" 
Get-MsolRoleMember -RoleObjectId $comrole.ObjectId

#Who is Exchange Online Admin?
$exorole = Get-MsolRole -RoleName "Exchange Service Administrator" 
Get-MsolRoleMember -RoleObjectId $exorole.ObjectId

#And where is SharePoint Online Admin?
$sporole = Get-MsolRole -RoleName "SharePoint Service Administrator" 
Get-MsolRoleMember -RoleObjectId $sporole.ObjectId

#How about a cool solution?
Get-MsolRole | %{$role = $_.name; Get-MsolRoleMember -RoleObjectId $_.objectid} | select @{Name="Role"; Expression = {$role}}, DisplayName, EmailAddress

#Please somewhat sorted!
Get-MsolRole | %{$role = $_.name; Get-MsolRoleMember -RoleObjectId $_.objectid} | select @{Name="Role"; Expression = {$role}}, DisplayName, EmailAddress | Sort-Object -Property Displayname
