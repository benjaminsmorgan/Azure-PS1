# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Mircosoft docs links
    Get-AzResourceGroup:        https://docs.microsoft.com/en-us/powershell/module/az.resources/get-azresourcegroup?view=azps-5.1.0
    Get-AzResource:             https://docs.microsoft.com/en-us/powershell/module/az.resources/get-azresource?view=azps-5.1.0
    Get-AzResourceLock:         https://docs.microsoft.com/en-us/powershell/module/az.resources/get-azresourcelock?view=azps-5.0.0
    Remove-AzResourceLock:      https://docs.microsoft.com/en-us/powershell/module/az.resources/remove-azresourcelock?view=azps-5.0.0
} #>
<# Required Functions Links: {
    GetAzResourceLocks:         https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Locks/GetAzResourceLocks.ps1
    GetAzResourceGroup:         https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/GetAzResourceGroup.ps1
    GetAzResource:              https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/GetAzResource.ps1
    GetAzResourceGroupLocksAll: https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Locks/GetAzResourceGroupLocksAll.ps1
    GetAzResourceGroupLockNamed:https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Locks/GetAzResourceGroupLockNamed.ps1
    GetAzResourceLocksAll:      https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Locks/GetAzResourceLocksAll.ps1
    GetAzResourceLockNamed:     https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Locks/GetAzResourceLockNamed.ps1
} #>
<# Functions Description: {
    RemoveAzResourceLocks:      Removes locks
    GetAzResourceLocks:         Management function to get different sets of locks
    GetAzResourceGroup:         Collects resource group object
    GetAzResource:              Collects resources within a resource group
    GetAzResourceGroupLocksAll: Collects all locks on a resource group and its resources
    GetAzResourceGroupLockNamed:Collects a named locks on a resource group
    GetAzResourceLocksAll:      Collects all locks on a resource
    GetAzResourceLockNamed:     Collects a named lock on a resource
} #>
<# Variables: {
    RemoveAzResourceLocks {
        $Locks:                 Lock or locks object
    }    
    GetAzResourceLocks {
        $Locks:                 Lock or locks object
        $OperatorSelect:        Operator input what locks to collect
    }
    GetAzResourceGroup {
        $RGObject:              Resource group object
        $RGObjectInput:         Operator input for the resource group name
        $RGList:                Variable used for printing all resource groups to screen if needed
    }
        GetAzResource {
        $RGObject:              Resource group object
        $RSObject:              Resource object
        $RSObjectInput:         Operator input for the resource name
        $RSList:                Variable used for printing all resources to screen if needed
    }
    GetAzResourceGroupLocksAll {
        $RGObject:              Resource group object
        $Locks:                 Locks object
    }
    GetAzResourceGroupLockNamed {
        $RGObject:              Resource group object
        $Locks:                 Locks object
        $LocksInput:            Input to collect a named lock
        $LocksList:             Object containing all locks within the resource group
        $OperatorConfirm:       Operator confirmation that the lock found was the intended target
    }
    GetAzResourceLocksAll {
        $RGObject:              Resource group object
        $RSObject:              Resource object
        $Locks:                 Locks object
    }
    GetAzResourceLockNamed {
        $RGObject:              Resource group object
        $RSObject:              Resource object
        $Locks:                 Locks object
        $LocksInput:            Input to collect a named lock
        $LocksList:             Object containing all locks on the resource
        $OperatorConfirm:       Operator confirmation that the lock found was the intended target
    }
} #>
<# Process Flow {
    Function
        Call RemoveAzResourceLocks
            Call GetAzResourceLocks > Get $Locks
                Call GetAzResourceGroupLocksAll > Get $Locks
                    Call GetAzResourceGroup > Get $RGObject
                Call GetAzResourceGroupLockNamed > Get $Locks
                    Call GetAzResourceGroup > Get $RGObject
                Call GetAzResourceLocksAll > Get $Locks
                    Call GetAzResourceGroup > Get $RGObject
                    Call GetAzResource > Get $RSObject
                Call GetAzResourceLockNamed > Get $Locks
                    Call GetAzResourceGroup > Get $RGObject
                    Call GetAzResource > Get $RSObject
}#>
function RemoveAzResourceLocks { # Function to remove resource locks, No input validation is done
    Begin {
        if (!$Locks) { # If statement if $Locks is $null
            $Locks = GetAzResourceLocks # Calls GetAzResourceLocks and assigns to $Locks
            if(!$Locks) { # If statement if $Locks is $null after calling function to assign
                Write-Host "RemoveAzResourceLocks function was terminated, no changes made" # Message write to screen
                Return $Locks # Returns to calling function
            } # End if statement
        } # End if statement
        $Locks.Name # Writes all names contained in $Locks
        $OperatorConfirm = Read-Host "Type 'Y' or 'Yes' to remove these locks" # Operator confirmation to remove the listed locks
        if (!($OperatorConfirm -ceq 'Y' -or $OperatorConfirm -ceq 'Yes')) { # If $Operatorconfirm is not (Equal to 'Y' or 'Yes') statement
            $Locks = $null # $Locks is set to $null
            Write-Host "RemoveAzResourceLocks function was terminated, no changes made" # Message write to screen
            Return $Locks # Return to calling function
        } # End if statement
        else { # Else statement if $Operatorconfirm is (Equal to 'Y' or 'Yes')
            $ErrorActionPreference='silentlyContinue' # Disables Errors
            foreach ($LockId in $Locks) { # Completes the command in a loop untill performed on all LockIds within $Locks
                $LockId.name # Prints the LockId for each lock as the cycle goes
                Remove-AzResourceLock -LockId $LockId.LockId -force # Removes the lock by targeting the LockID, -force removes operator confirmation
            } # End foreach loop
            $Locks = $null # Clears $Locks prior to returning to calling function
            Return $Locks # Returns to calling function
        } # End else statement
    } # End begin statement
} # End function