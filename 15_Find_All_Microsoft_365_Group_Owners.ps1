Set-Location C:\
Clear-Host

#To be able to install the exchange online module
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned

#Install the exchange online management module
Install-Module -Name ExchangeOnlineManagement -Verbose -Force

#Update the module (if necessary)
Update-Module -Name ExchangeOnlineManagement -Verbose -Force

#Connect to exchange online
Connect-ExchangeOnline -UserPrincipalName admin365@tomscloud.onmicrosoft.com
 
#Get All Microsoft 365 Groups
$GroupData = @()
$Groups = Get-UnifiedGroup -ResultSize Unlimited -SortBy Name
 
#Loop through each Group
$Groups | Foreach-Object {
    #Get Group Owners
    $GroupOwners = Get-UnifiedGroupLinks -LinkType Owners -Identity $_.Id | Select DisplayName, PrimarySmtpAddress
    $GroupData += New-Object -TypeName PSObject -Property @{
            GroupName = $_.Alias
            GroupEmail = $_.PrimarySmtpAddress 
            OwnerName = $GroupOwners.DisplayName -join "; "
            OwnerIDs = $GroupOwners.PrimarySmtpAddress -join "; "
    }
}
#Get Groups Data
$GroupData
$GroupData | Export-Csv "C:\Temp\GroupOwners.csv" -NoTypeInformation
 
#Remove the session
Disconnect-ExchangeOnline -Confirm:$false

##The second way##

#Get Credentials to connect
$Cred = Get-Credential

#We need the cmdlets
Install-Module -Name AzureAD -AllowClobber -Force -Verbose

#Sometimes the module must be imported
Import-Module AzureAD
  
#Connect to AzureAD
Connect-AzureAD -Credential $Cred | Out-Null
$GroupData = @()
 
#Get all Microsoft 365 Groups
Get-AzureADMSGroup -Filter "groupTypes/any(c:c eq 'Unified')" -All:$true | ForEach-object {
    $GroupName = $_.DisplayName
     
    #Get Owners
    $GroupOwners = Get-AzureADGroupOwner -ObjectId $_.ID | Select UserPrincipalName, DisplayName 
 
        $GroupData += New-Object PSObject -Property ([Ordered]@{ 
        GroupName = $GroupName
        OwnerID = $GroupOwners.UserPrincipalName -join "; "
        OwnerName = $GroupOwners.DisplayName -join "; "
    })
}
 
#Export Group Owners data to CSV
$GroupData
$GroupData | Export-Csv "C:\Temp\GroupOwners.csv" -NoTypeInformation

#Remove the session
Disconnect-AzureAD