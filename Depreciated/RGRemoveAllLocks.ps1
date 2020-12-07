# Benjamin Morgan benjamin.s.morgan@outlook.com 
# ref https://docs.microsoft.com/en-us/powershell/module/az.resources/remove-azresourcelock?view=azps-5.0.0
# $RGInput - Operator input for RG name
# $RGObject - RG object .ResourceGroupName is used
# $Locks - All lock objects under a resource group
# $LocksNames - Lock name and resource group name formated into table
# $OPConfirm - Operator confirmation for lock removal (Used as single confirmation because of -force)
# $LockID - Sub-object of $lock, used foreach command
function FunctionName { # Warning, this is a torch and burn script. If ran on any resource group ALL LOCKS WILL BE REMOVED
    Begin {
        $ErrorActionPreference = "silentlyContinue" # Disables all auto errors
        $RGInput = Read-Host "Please enter the resource group name" # Operator input for RG name
        $RGObject = Get-AzResourceGroup -ResourceGroupName $RGInput # Assigns RG object from $RGInput
        if ($RGInput -eq "Exit") { # Provides operator an exit function
            Write-Host "Exiting Script"
            Break # Terminates script
        }
        elseif (!$RGObject) { # Checks to see if $RGInput matches a resource group
            Write-Host "The provided name did not match any resource groups"
            $RGList = Get-AzResourceGroup | Select-Object ResourceGroupName | Format-Table # Collects list of all RGs available
            Write-Host "The following resource groups are available"
            Write-Host "*****************************************"
            $RGList # Prints lists for operator to confirm spelling
            Write-Host "*****************************************"
            FunctionName # Restarts the script for operator to re-enter $RGInput
        }
        $Locks = Get-AzResourceLock -ResourceGroupName $RGObject.ResourceGroupName # Collects all locks under a resource group (Includes resource locks)
        $LocksNames = $Locks | Select-Object Name, ResourceGroupName | Format-Table # Pulls from $locks the lock name and the resource group name
        Write-Host "The following locks will be removed"
        Write-Host "*****************************************"
        $LocksNames # Prints $LocksNames for operator review
        Write-Host "*****************************************"
        Write-Host
        $OpConfirm = Read-Host "Do you want to remove these locks" # Prompts operator to do a single confirmation for all lock removals
        if ($OpConfirm -eq "Y" -or $OpConfirm -eq "Yes") { # Accepts 'y' or 'Yes' from operator and starts the removal process
            foreach ($LockId in $Locks) { # Completes the command in a loop untill performed on all LockIds within $Locks
                $LockId.name # Prints the LockId for each lock as the cycle goes
                Remove-AzResourceLock -LockId $LockId.LockId -force # Removes the lock by targeting the LockID, -force removes operator confirmation
            }
            Break # Once each unique LockID has been cycled through, this ends the script
        }
        else { # Else statement for all other operator inputs for $OPConfirm
            Write-Host "**************************"
            Write-Host "No Locks have been removed"
            Write-Host "**************************"
        }
    }
}