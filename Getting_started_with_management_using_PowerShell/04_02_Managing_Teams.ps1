#List the teams
Get-Team

#Create a new Team
New-Team `
    -DisplayName "Accounting Team" `
    -Description "Internal Collaboration place for the Accounting Team" `
    -Visibility Private

#Some team settings
Set-Team -GroupId 6226df7e-9fa8-4814-8d20-7a9938b27200 `
	-Visibility Public `
	-AllowChannelMentions $false `
	-AllowCreateUpdateChannels $false `
    -AllowUserDeleteMessages $false `
    -AllowUserEditMessages $false `
    -AllowGiphy $false `
	-AllowStickersAndMemes $false

#Add a channel
New-TeamChannel `
    -GroupId 6226df7e-9fa8-4814-8d20-7a9938b27200 `
	-DisplayName "Milestones” `
    -MembershipType Private

#Some channel settings
Set-TeamChannel -GroupId 6226df7e-9fa8-4814-8d20-7a9938b27200 `
	-CurrentDisplayName "Milestones" `
	-NewDisplayName "Targets" `
	-Description "Use this channel to share the project targets"

#List owner
Get-TeamUser -GroupId  6226df7e-9fa8-4814-8d20-7a9938b27200 -Role Owner

#List member
Get-TeamUser -GroupId  6226df7e-9fa8-4814-8d20-7a9938b27200 -Role Member

#Add a member
Add-TeamUser -GroupId 6226df7e-9fa8-4814-8d20-7a9938b27200 `
    -User fred.jonas@tomrocks.ch

#Add an owner
Add-TeamUser -GroupId 6226df7e-9fa8-4814-8d20-7a9938b27200 `
    -User fred.jonas@tomrocks.ch `
    -Role Owner

#Remove a team
Remove-Team -GroupId 6226df7e-9fa8-4814-8d20-7a9938b27200