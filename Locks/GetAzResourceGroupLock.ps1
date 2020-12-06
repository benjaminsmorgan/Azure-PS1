# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Mircosoft docs links
    Get-AzResourceGroup:        https://docs.microsoft.com/en-us/powershell/module/az.resources/get-azresourcegroup?view=azps-5.1.0
    Get-AzResourceLock:         https://docs.microsoft.com/en-us/powershell/module/az.resources/get-azresourcelock?view=azps-5.0.0
} #>
<# Required Functions: {
    GetAzResourceGroup:         Collects resource group object
    GetAzResourceGroupLocks:    Collects resource locks
} #>
<# Variables: {
    GetAzResourceGroup {
        $RGObject:              Resource group object
        $RGObjectInput:         Operator input for the resource group name
        $RGList:                Variable used for printing all resource groups to screen if needed
    }
    GetAzResourceGroupLock {
        $RGObject:              Resource group object
        $Locks:                 Lock or locks object
        $LocksList:             List of all locks assigned to the resouce group
    }
} #>
function RemoveAzResourceLock { # Function to remove resource locks
    Begin {
        while (!$Locks) { # While statement to get $Locks by calling another function is $Locks is $null
            Write-Host "'1' Remove all locks on a resource group and its resources" # Write option to screen
            Write-Host "'2' Remove a named lock on a resource group" # Write option to screen
            Write-Host "'3' Remove all locks on a resource" # Write option to screen
            Write-Host "'4' Remove a named lock on a resource" # Write option to screen
            $OperatorSelect = Read-Host "Enter the number from the list" # Operator input to call function to collect $Locks
            if ($OperatorSelect -eq '1') { # If statement for option 1
                Write-Host "**Remove all locks on a resource group and its resources**" # Write message to screen
                $Locks = GetAzResourceGroupLocksAll # Calls function GetAzResourceGroupLocksAll and assigns to $Locks
                if (!$Locks) { # Check to see if called function returned a value
                    Write-Host "RemoveAzResourceLock function was terminated" # Message write to screen
                    Return # Returns to calling function
                } # End if statement
            } # End if statement
            elseif ($OperatorSelect -eq '2') { # elseif statement for option 2
                Write-Host "**Remove a named lock on a resource group**" # Write message to screen
                $Locks = GetAzResourceGroupLock # Calls function GetAzResourceGroupLock and assigns to $Locks
                if (!$Locks) { # Check to see if called function returned a value
                    Write-Host "RemoveAzResourceLock function was terminated" # Message write to screen
                    Return # Returns to calling function
                } # End if statement
            } # End elseif statement
            elseif ($OperatorSelect -eq '3') { # elseif statement for option 3
                Write-Host "**Remove all locks on a resource**" # Write message to screen
                $Locks = GetAzResourceLocksAll # Calls function GetAzResourceLocksAll and assigns to $Locks
                if (!$Locks) { # Check to see if called function returned a value
                    Write-Host "RemoveAzResourceLock function was terminated" # Message write to screen
                    Return # Returns to calling function
                } # End if statement
            } # End elseif statement
            elseif ($OperatorSelect -eq '4') { # elseif statement for option 4
                Write-Host "**Remove a named lock on a resource**" # Write message to screen
                $Locks = GetAzResourceLock # Calls function GetAzResourceLock and assigns to $Locks
                if (!$Locks) { # Check to see if called function returned a value
                    Write-Host "RemoveAzResourceLock function was terminated" # Message write to screen
                    Return # Returns to calling function
                } # End if statement
            } # End elseif statement
            elseif ($OperatorSelect -eq 'Exit') { # elseif statement for 'Exit'
                Write-Host "RemoveAzResourceLock function was terminated" # Message write to screen
                Return # Returns to calling function
            } # End elseif statement
            else { # Else statement for no valid inputs by the operator
                Write-Host "**That was not a valid selection**" # Write error to screen
            } # End else statement
        } # End while statement
        $ErrorActionPreference='silentlyContinue' # Disables Errors
        foreach ($LockId in $Locks) { # Completes the command in a loop untill performed on all LockIds within $Locks
            $LockId.name # Prints the LockId for each lock as the cycle goes
            Remove-AzResourceLock -LockId $LockId.LockId -force # Removes the lock by targeting the LockID, -force removes operator confirmation
        } # End foreach loop
    } # End begin statement
} # End function
function GetAzResourceGroupLock { # Function to get a named lock assigned to a resource group, can pipe $Locks to another function
    Begin {
        $ErrorActionPreference='silentlyContinue' # Disables Errors
        if (!$RGObject) { # If statement if $RGObject is $null
            $RGObject = GetAzResourceGroup # Calls function GetAzResourceGroup and assigns to $RGObject
            if (!$RGObject) { # If statement if $RGObject is $null after calling GetAzResourceObject
                Write-Host "GetAzResourceGroupLock function was terminated"
                Return # Returns to calling function
            } # End if statement
        } # End if statement
        while (!$Locks) { # While statement used for looping until the correct lock has been found
            $LocksInput = Read-Host "Enter the lock name" # Operator input for a resource lock name, left blank to get all locks
            if ($LocksInput -eq 'exit') { # Operator input for exit
                Write-Host "GetAzResourceGroupLock function was terminated"
                Return # Returns to calling function
            } # End if statement
            $Locks = Get-AzResourceLock -ResourceGroupName $RGObject.ResourceGroupName -LockName $LocksInput # Collects the named lock and assigns to $Locks
            if (!$Locks) { # If statement for no object assigned to $Locks
                Write-Host "No locks by that name were found on this resource group" # Write message to screen
                Write-Host "The following are the current locks assigned to" $RGObject.ResourceGroupName
                $LocksList = Get-AzResourceLock -ResourceGroupName $RGObject.ResourceGroupName -AtScope
                Write-Host $LocksList.Name -Separator `n # Write-host used so list is written to screen when function is used as $Locks = GetAzResourceGroupLocksAll
            } # End if statement
            else {
                $OperatorConfirm = Read-Host "Is this the correct lock" $Locks.Name 
                if ($OperatorConfirm -eq 'y' -or $OperatorConfirm -eq 'yes') {
                    Write-Host $Locks.Name -Separator `n # Write-host used so list is written to screen when function is used as $Locks = GetAzResourceGroupLock
                    Return $Locks # Returns $Locks to the calling function
                } # End if statement
                elseif ($OperatorConfirm -eq 'exit') {
                    $Locks = $null
                    Write-Host "GetAzResourceGroupLock function was terminated"
                    Return
                } # End elseif statement
                else { # Else statement if operator does not confirm the lock
                    $Locks = $null # Clears $Locks to restart the loop
                } # End else statement
            } # End else statement
        } # End while statement
    } # End begin statement
} # End function
function GetAzResourceGroup { # Function to get a resource group, can pipe $RGObject to another function
    Begin {
        $ErrorActionPreference='silentlyContinue' # Disables Errors
        $RGObject = $null # Clears $RGObject from all previous use
        while (!$RGObject) { # Loop to continue getting a resource group until the operator provided name matches an existing group
            $RGObjectInput = Read-Host "Resource group name" # Operator input of the resource group name
            if ($RGObjectInput -eq 'exit') { # Operator input for exit
                Write-Host "GetAzResourceGroup function was terminated"
                Return # Returns to calling function
            } # End if statement
            $RGObject = Get-AzResourceGroup -Name $RGObjectInput # Collection of the resource group from the operator input
            if (!$RGObject) { # Error reporting if input does not match an existing group
                Write-Host "The name provided does not match an existing resource group" # Error note
                Write-Host "This is the list of available resource groups" # Error note
                $RGList = Get-AzResourceGroup # Collects all resource group objects and assigns to a variable
                Write-Host "" # Error reporting
                Write-Host $RGList.ResourceGroupName -Separator `n # Write-host used so list is written to screen when function is used as $RGObject = GetAzResourceGroup
                Write-Host "" # Error reporting
            } # End of if statement
            else { # Else for when $RGObject is assigned
                Write-Host $RGObject.ResourceGroupName 'Has been assigned to "$RGObject"' # Writes the resource group name to the screen before ending function
            } # End of else statement
        } # End of while statement
        Return $RGObject  # Returns the value of $RGObject to a function that called it
    } # End of begin statement
} # End of function