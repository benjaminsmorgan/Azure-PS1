# Benjamin Morgan benjamin.s.morgan@outlook.com 
# $RGNameInput - Operator input for the RG Name
# $RGOjb - Object for the selected resource group
# $Confirm1 - Simple operator confirmation, 'Yes' has to be typed out
# $Confirm2 - Second operator confirmation after warnings, requires operator input to match the name exactly
# Locks - Pulls all resource locks on and within the group into a single $var
# LockID - ID foreach statement to remove locks
function FunctionName { # This function removes all locks and deletes a resource group. Use at own risk
    param (
        [Parameter(Mandatory=$true, Position=0)]
        [string] $RGNameInput
    )
    Begin {
        $RGObj = Get-AzResourceGroup -ResourceGroupName $RGNameInput # Collects the RG object for deletion
        if (!$RGObj){ # Terminates script if operator provided value does not match a resource group
            Write-Host "The name provided does not match an existing resource group"
            Break # Terminates script
        }
        $Confirm1 = Read-Host "If you want to delete"$RGObj.ResourceGroupName"Type 'Yes'" # First operator confirmation
        if ($Confirm1 -eq "Yes") { # Validates operator input
            Write-Host "Any locks on te resource groups that exist will be removed automatically"
            Write-Host "If the account has the permissions to delete all objects within the group"
            Write-Host "Nothing will stop the removal of the group and all containing assets"
            $Confirm2 = Read-Host "Type '"$RGObj.ResourceGroupName"' To confirm deletion" # Second operator confirmation
            if ($Confirm2 -eq $RGObj.ResourceGroupName) { # Validates operator input
                $Locks = Get-AzResourceLock -ResourceGroupName $RGObj.ResourceGroupName # Retrieves all locks in and on resource group
                foreach ($LockId in $Locks) { # Completes the command in a loop untill performed on all LockIds within $Locks
                    $LockId.name # Prints the LockId for each lock as the cycle goes
                    Remove-AzResourceLock -LockId $LockId.LockId -force # Removes the lock by targeting the LockID, -force removes operator confirmation
                }
                Remove-AzResourceGroup -ResourceGroupName $RGObj.ResourceGroupName -Force # Deletes the resource and all contained resources
            }
            else { # Ends script as result of operator not confirming removal
                Write-Host "Terminating Script"
                Break # Terminates Script
            }
        }
        else { # Ends script as result of operator not confirming removal
            Write-Host "Terminating Script"
            Break # Terminates Script
        }
    }
}