Set-Location c:\
Clear-Host

#What licenses are available?
Get-AzureADSubscribedSku 

#More info about the license package
Get-AzureADSubscribedSku | Select-Object -Property ObjectId, SkuPartNumber, ConsumedUnits -ExpandProperty PrepaidUnits

#What is included in the license package
Get-AzureADSubscribedSku `
    -ObjectId 95b14fab-6bbf-4756-94d4-99993dd27f55_05e9a617-0261-4cee-bb44-138d3ef5d965 | Select-Object -ExpandProperty ServicePlans

#To list all licensed users
Get-AzureAdUser | ForEach { $licensed=$False ; For ($i=0; $i -le ($_.AssignedLicenses | Measure).Count ; $i++)`
 { If( [string]::IsNullOrEmpty(  $_.AssignedLicenses[$i].SkuId ) -ne $True) { $licensed=$true } } ; If( $licensed -eq $true)`
  { Write-Host $_.UserPrincipalName} }

#To list all of the unlicensed users
Get-AzureAdUser | ForEach{ $licensed=$False ; For ($i=0; $i -le ($_.AssignedLicenses | Measure).Count ; $i++)`
 { If( [string]::IsNullOrEmpty(  $_.AssignedLicenses[$i].SkuId ) -ne $True) { $licensed=$true } } ; If( $licensed -eq $false)`
  { Write-Host $_.UserPrincipalName} }

#Do users have a usage location? 
Get-AzureADUser | Select DisplayName,Department,UsageLocation

#We select a user
$User = Get-AzureADUser -ObjectId fred.prefect@tomscloud.ch

#The user needs a location
Set-AzureADUser -ObjectId $User.ObjectId -UsageLocation CH

#We need the SKU ID
Get-AzureADSubscribedSku | Select SkuPartNumber, SkuID

#Create the AssignedLicense object
$Sku = New-Object -TypeName Microsoft.Open.AzureAD.Model.AssignedLicense

#Set the SKU ID
$Sku.SkuId = "6fd2c87f-b296-42f0-b197-1e91e994b900"

#Create the AssignedLicenses Object
$Licenses = New-Object -TypeName Microsoft.Open.AzureAD.Model.AssignedLicenses

#Add the SKU
$Licenses.AddLicenses = $Sku

#Setting a License to a User
Set-AzureADUserLicense -ObjectId $User.ObjectId -AssignedLicenses $Licenses

#Creating a Custom License
$User = Get-AzureADUser -ObjectId fred.prefect@tomscloud.ch.ch

#Create the AssignedLicense object
$Sku = New-Object -TypeName Microsoft.Open.AzureAD.Model.AssignedLicense
$Sku.SkuId = "6fd2c87f-b296-42f0-b197-1e91e994b900"

#Show the ServicePlans
Get-AzureADSubscribedSku -ObjectId 95b14fab-6bbf-4756-94d4-99993dd27f55_05e9a617-0261-4cee-bb44-138d3ef5d965 | Select-Object -ExpandProperty ServicePlans

#Get the LicenseSKU and create the Disabled ServicePlans object
$Sku.DisabledPlans = @("a23b959c-7ce8-4e57-9140-b90eb88a9e97","aebd3021-9f8f-4bf8-bbe3-0ed2f4f047a1")

#Create the AssignedLicenses Object
$Licenses = New-Object –TypeName Microsoft.Open.AzureAD.Model.AssignedLicenses

#Add the SKU
$Licenses.AddLicenses = $Sku

#Assign the license to the user
Set-AzureADUserLicense -ObjectId $User.ObjectId -AssignedLicenses $Licenses