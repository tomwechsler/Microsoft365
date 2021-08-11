Set-Location c:\
Clear-Host

#Which users have no manager?
$Users = Get-AzureADUser -All $True | Where {$_.UserType -eq 'Member' -and $_.AssignedLicenses -ne $null}

#Create a empty array
$NoManagerUsers = @()

#Loop to search
foreach ($user in $Users) 
{
    $Manager = Get-AzureADUserManager -ObjectId $user.UserPrincipalName
    if ($Manager -eq $null)
    {
        $NoManagerUsers += $user
    }
}

#Export to a Csv File
$NoManagerUsers | Select DisplayName, UserPrincipalName | Export-Csv -Path "C:\Temp\UsersWithNoManager.csv" -NoTypeInformation