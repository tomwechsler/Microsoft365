Set-Location c:\
Clear-Host

#Get Credentials to connect
$Credential = Get-Credential
  
#Create the session
$Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri https://outlook.office365.com/powershell-liveid/ `
           -Credential $Credential -Authentication Basic -AllowRedirection
  
#Import the session
Import-PSSession $Session -AllowClobber

#Did it work?
Get-UnifiedGroup
 
#Create new Microsoft 365 Group
New-UnifiedGroup -DisplayName "Study Group" -Alias "0365-Study-Group" `
        -EmailAddresses "0365-Study-Group@tomwechsler.xyz" -AccessType Private

#An other Microsoft 365 Group
New-UnifiedGroup –DisplayName "ITBros Admins" -Alias "ITBrosAdmins" -AccessType Public

#Add a member
Add-UnifiedGroupLinks -Identity "ITBros Admins" –LinkType Members –Links Tina.Jackson

#To list the Group Members
Get-UnifiedGroupLinks "ITBros Admins" –LinkType Member

#To list the Group Owners
Get-UnifiedGroupLinks "ITBros Admins" –LinkType Owner

#To add an additional Owner to the Group (this will not work!)
Add-UnifiedGroupLinks –Identity "ITBros Admins" –LinkType Owner –Links tim.godin@tomwechsler.xyz

#First, we have to add Tim Godin as a member to the group
Add-UnifiedGroupLinks -Identity "ITBros Admins" –LinkType Members –Links Tim.Godin

#Now we can add Tim Godin as an additional Owner to the Group
Add-UnifiedGroupLinks –Identity "ITBros Admins" –LinkType Owner –Links tim.godin@tomwechsler.xyz

#To list the Group Owners
Get-UnifiedGroupLinks "ITBros Admins" –LinkType Owner

#Remove the session 
Remove-PSSession $Session