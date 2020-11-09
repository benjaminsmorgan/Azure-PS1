# Benjamin Morgan benjamin.s.morgan@outlook.com 
# ref https://docs.microsoft.com/en-us/powershell/module/az.resources/new-azresourcelock?view=azps-5.0.0
# $Locklevel - Accepts CanNotDelete or ReadOnly or any amount of those terms such as CanNo or Rea
# $RGinput - Operator input used to get the RG object
# $RGObject - Full RG object .resourcegroupname is used for the actual command
# $LockName - Operator provided lock name
# $LockNote - Operator provided lock notes
function FunctionName {
    param (
        [Parameter(Mandatory=$true, Position=0)] # Accepts CanNotDelete or ReadOnly (C or R)
        [string]$Locklevel,
        [Parameter(Mandatory=$true, Position=1)] # Operator input for RG name
        [string]$RGinput
    )
    Begin {
        # Collection of additional variables
        $RGObject = Get-AzResourceGroup -Name $RGinput # Gets RG object using operator input
        $LockName = Read-Host "Please provide a name for this lock" # Prompt operator for a lock name
        $LockNote = Read-Host "Please provide a note for this lock" # Prompt operator for a lock note
        # End collection of additional variables
        # Apply lock to RG
        New-AzResourceLock -LockName $LockName -LockLevel $Locklevel -LockNotes $LockNote -ResourceGroupName $RGObject.ResourceGroupName # Applies all operator provided values to create a lock
        # End apply lock to RG
    }
}