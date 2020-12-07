# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Mircosoft docs links
    Get-AzResourceGroup:        https://docs.microsoft.com/en-us/powershell/module/az.resources/get-azresourcegroup?view=azps-5.1.0
    Get-AzResourceLock:         https://docs.microsoft.com/en-us/powershell/module/az.resources/get-azresourcelock?view=azps-5.0.0
} #>
<# Required Functions Links: {
    GetAzResourceGroup:         https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/GetAzResourceGroup.ps1
} #>
<# Functions Description: {
    GetAzResourceGroup:         Collects resource group object
    GetAzResourceGroupLockNamed:Collects a named locks on a resource group
} #>
<# Variables: {
    GetAzResourceGroup {
        $RGObject:              Resource group object
        $RGObjectInput:         Operator input for the resource group name
        $RGList:                Variable used for printing all resource groups to screen if needed
    }
    GetAzResourceGroupLockNamed {
        $RGObject:              Resource group object
        $Locks:                 Locks object
        $LocksInput:            Input to collect a named lock
        $LocksList:             Object containing all locks within the resource group
        $OperatorConfirm:       Operator confirmation that the lock found was the intended target
} #>
<# Process Flow {
    Function
        Call GetAzResourceGroupLockNamed > Get $Locks
            Call GetAzResourceGroup > Get $RGObject
}#>
function GetAzResourceGroupLockNamed { # Function to get a named lock assigned to a resource group, can pipe $Locks to another function
    Begin {
        $ErrorActionPreference='silentlyContinue' # Disables Errors
        if (!$RGObject) { # If statement if $RGObject is $null
            $RGObject = GetAzResourceGroup # Calls function GetAzResourceGroup and assigns to $RGObject
            if (!$RGObject) { # If statement if $RGObject is $null after calling GetAzResourceObject
                Write-Host "GetAzResourceGroupLockNamed function was terminated"
                Return # Returns to calling function
            } # End if statement
        } # End if statement
        while (!$Locks) { # While statement used for looping until the correct lock has been found
            $LocksInput = Read-Host "Enter the lock name" # Operator input for a resource group lock name
            if ($LocksInput -eq 'exit') { # Operator input for exit
                Write-Host "GetAzResourceGroupLockNamed function was terminated"
                Return # Returns to calling function
            } # End if statement
            $Locks = Get-AzResourceLock -ResourceGroupName $RGObject.ResourceGroupName -LockName $LocksInput # Collects the named lock and assigns to $Locks
            if (!$Locks) { # If statement for no object assigned to $Locks
                Write-Host "No locks by that name were found on this resource group" # Write message to screen
                Write-Host "The following are the current locks assigned to" $RGObject.ResourceGroupName
                $LocksList = Get-AzResourceLock -ResourceGroupName $RGObject.ResourceGroupName -AtScope
                Write-Host $LocksList.Name -Separator `n # Write-host used so list is written to screen when function is used as $Locks = GetAzResourceGroupLocksAll
            } # End if statement
            else { # Else statement if a lock is found with the operator input
                $OperatorConfirm = Read-Host "Is this the correct lock" $Locks.Name 
                if ($OperatorConfirm -eq 'y' -or $OperatorConfirm -eq 'yes') {
                    Write-Host $Locks.Name -Separator `n # Write-host used so list is written to screen when function is used as $Locks = GetAzResourceGroupLock
                    Return $Locks # Returns $Locks to the calling function
                } # End if statement
                elseif ($OperatorSelect -eq 'Exit') { # Elseif statement for 'Exit'
                    Write-Host "GetAzResourceGroupLockNamed function was terminated" # Message write to screen
                    Return # Returns to calling function
                } # End elseif statement
                else { # Else statement if operator does not confirm the lock
                    $Locks = $null # Clears $Locks to restart the loop
                } # End else statement
            } # End else statement
        } # End while statement
    } # End begin statement
} # End function