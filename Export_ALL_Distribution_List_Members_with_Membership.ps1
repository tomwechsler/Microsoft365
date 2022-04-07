Set-Location C:\
Clear-Host

#We need the module (without the parameter for a specific version)
Install-Module -Name ExchangeOnlineManagement -AllowClobber -Force -Verbose

#Let's import the module
Import-Module ExchangeOnlineManagement

#Check the version (if you have not selected a version)
Get-InstalledModule -Name ExchangeOnlineManagement

#Update if needed
Update-Module -Name ExchangeOnlineManagement -Verbose

#Now we connect to Exchange Online
Connect-ExchangeOnline

#To list all the distribution groups
Get-DistributionGroup -ResultSize Unlimited

#To obtain a list of group members
Get-DistributionGroupMember -Identity "MarketingTeam20220406114100" -ResultSize Unlimited

#Get members from a given distribution list and then, export its members to a CSV file
$DLName = "MarketingTeam20220406114100"

Get-DistributionGroupMember -Identity $DLName -ResultSize Unlimited |
 Select Name, PrimarySMTPAddress, RecipientType |
  Export-CSV "C:\Distribution-List-Members.csv" -NoTypeInformation -Encoding UTF8

##Lets have a look
Get-Content C:\Distribution-List-Members.csv | Out-GridView

#Export all distribution lists with members to a CSV file!
$Result=@()
$groups = Get-DistributionGroup -ResultSize Unlimited
$totalmbx = $groups.Count
$i = 1
$groups | ForEach-Object {
Write-Progress -activity "Processing $_.DisplayName" -status "$i out of $totalmbx completed"
$group = $_
Get-DistributionGroupMember -Identity $group.Name -ResultSize Unlimited | ForEach-Object {
$member = $_
$Result += New-Object PSObject -property @{
GroupName = $group.DisplayName
Member = $member.Name
EmailAddress = $member.PrimarySMTPAddress
RecipientType= $member.RecipientType
}}
$i++
}
$Result | Export-CSV "C:\All-Distribution-Group-Members.csv" -NoTypeInformation -Encoding UTF8

#Lets have a look
$Result | Out-GridView