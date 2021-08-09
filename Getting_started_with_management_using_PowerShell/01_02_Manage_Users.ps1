Set-Location c:\
Clear-Host

#All users
Get-AzureADUser

#All user from our tenant (without guests)
Get-AzureADUser | Where {$_.UserType -eq "Member"}

#All users with the department "Technik"
Get-AzureADUser | Where {$_.Department -eq "Technik"}

#Infos about a user
Get-AzureADUser -ObjectId tom@tomscloud.ch | Format-List

#We need a password profile
$PasswordProfile = New-Object `
    -TypeName Microsoft.Open.AzureAD.Model.PasswordProfile

#We need a password
$PasswordProfile.Password = "P@$$w0rd123??"

#The user must change the password at next login
$PasswordProfile.ForceChangePasswordNextLogin = $true

#Lets create a user
New-AzureADUser -GivenName "Fred" `
				-Surname "Prefect" `
				-DisplayName "Freddy Prefect" `
				-UserPrincipalName "fred.prefect@tomscloud.ch" `
				-MailNickName "Fred" `
				-AccountEnabled $true `
				-PasswordProfile $PasswordProfile `
				-JobTitle "IT Administrator" `
				-Department "IT"

#Make some changes
Set-AzureADUser `
	-ObjectId fred.prefect@tomscloud.ch `
	-DisplayName “Fred Prefect" 

#Set a manager for fred
Set-AzureADUserManager `
    -ObjectId fred.prefect@tomscloud.ch `
     -RefObjectId (Get-AzureADUser -ObjectId jane.ford@tomscloud.ch).ObjectId

#Create a user in a different way
$domain = "tomscloud.ch"
$user = @{
    City = "Oberbuchsiten"
    Country = "Switzerland"
    Department = "Information Technology"
    DisplayName = "Fred Jonas"
    GivenName = "Fred"
    JobTitle = "Azure Administrator"
    UserPrincipalName = "fred.jonas@$domain"
    PasswordProfile = $PasswordProfile
    PostalCode = "4625"
    State = "SO"
    StreetAddress = "Hiltonstrasse"
    Surname = "Jonas"
    TelephoneNumber = "455-233-22"
    MailNickname = "FredJonas"
    AccountEnabled = $true
    UsageLocation = "CH"
}

#Lets create the user
$newUser = New-AzureADUser @user

#Whats in the variable
$newUser | Format-List

#Details about the user
Get-AzureADUser -Filter "Displayname eq 'Fred Jonas'" | Select-Object Displayname, State, Department

#Show all groups
Get-AzureADGroup

#Show the group members
Get-AzureADGroupMember `
    -ObjectId (Get-AzureADGroup -SearchString "Technik").ObjectId

#Is there an owner?
Get-AzureADGroupOwner `
    -ObjectId (Get-AzureADGroup -SearchString "Technik").ObjectId

#We add an owner
Add-AzureADGroupOwner `
    -ObjectId (Get-AzureADGroup -SearchString "Technik").ObjectId `
    -RefObjectId (Get-AzureADUser -ObjectId fred.prefect@tomscloud.ch).ObjectId 