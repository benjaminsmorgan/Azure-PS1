# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Mircosoft docs links
    Get-AzResourceGroup:        https://docs.microsoft.com/en-us/powershell/module/az.resources/get-azresourcegroup?view=azps-5.1.0
    Remove-AzResourceGroup:     https://docs.microsoft.com/en-us/powershell/module/az.resources/remove-azresourcegroup?view=azps-5.1.0
    Get-AzResourceLock:         https://docs.microsoft.com/en-us/powershell/module/az.resources/get-azresourcelock?view=azps-5.0.0
    Remove-AzResourceLock:      https://docs.microsoft.com/en-us/powershell/module/az.resources/remove-azresourcelock?view=azps-5.0.0

} #>
<# Required Functions: {
    GetAzResourceGroup:         Collects resource group object
    RemoveAzResourceGroup:      Removes a resource group object
    GetAzResourceGroupLocksAll: Collects resource locks
    RemoveAzResourceLock:       Removes resource locks
} #>
<# Variables: {
        RemoveAzResourceGroup {
        $RGObject:              Resource group object, used for all actions
        $RGObjectName:          Name of the resource group object, used only in confirmation
        $RGObjectVerify:        Resource group object pulled again using $RGObjectName to check if existing
        $OperatorConfirm:       Operator confirmation info is correctly input
        :SetRG                  Named while loop for setting and confirming the resource group object
    }
    GetAzResourceGroup {
        $RGObject:              Resource group object
        $RGObjectInput:         Operator input for the resource group name
        $RGList:                Variable used for printing all resource groups to screen if needed
    }
    GetAzResourceGroupLocksAll {
        $Locks:                 Lock or locks object
    }
    RemoveAzResourceLock {
        $RGObject:              Resource group object
        $Locks:                 Lock or locks object
        $OperatorSelect:        Operator input what locks to collect
    }
} #>
function RemoveAzResourceGroup { # Function to remove a resource group, includes function to remove all locks. Can be called from another function
    Begin {
        $ErrorActionPreference='silentlyContinue' # Disables Errors
        $RGObject = $null # Clears all previous uses of $RGOject
        :SetRG while (!$RGObject) { # Named while loop to collect the resource group object and confirm its deletion
            $RGObject = GetAzResourceGroup # Calls function GetAzResourceGroup and assigns to $RGObject
            Write-Host "|////////////////////////////WARNING\\\\\\\\\\\\\\\\\\\\\\\\\\\\|" # Warning write to screen
            Write-Host "|"$RGObject.ResourceGroupName "will be deleted, this cannot be undone" # Warning write to screen
            Write-Host "| All resource locks will be removed automatically if confirmed |" # Warning write to screen
            Write-Host "| All resources within the resource group will also be deleted  |" # Warning write to screen
            Write-Host "| This option can be exited by typing 'Exit'                    |" # Warning write to screen
            Write-Host "|\\\\\\\\\\\\\\\\\\\\\\\\\\\\WARNING////////////////////////////|" # Warning write to screen
            $OperatorConfirm = Read-Host "Confirm with 'Y' or 'Yes'" # Operator input on confirming deletion of the resource group
            $RGObjectName = $RGObject.ResourceGroupName # Collects the name of the resource group for later use
            if ($OperatorConfirm -ceq "Y" -or $OperatorConfirm -ceq "Yes") { # If statement for operator confirmation on deletion
                Break SetRG # Ends :SetRG named while loop with $RGObject
            } # End if statement
            elseif ($OperatorConfirm -eq 'exit') { # Elseif statement for operator input to end this function
                $RGObject = $null # Clears $RGObject
                Write-Host "Terminating Script" # Message write to screen
                Return # Returns to calling function
            } # End elseif statement
            else { # Else statement for non-confirm delete or non-exit from operator, clears $RGObject
                Write-Host "Confirmation declined" # Message write to screen
                Write-Host "Please enter the resource group name" # Message write to screen
                $RGObject = $null # Clears $RGObject, restarting named while loop
            } # End else statement
        } # End while statement
        $Locks = $null # Clears any previous use of $Locks
        $Locks = GetAzResourceGroupLocksAll ($RGObject) # Calls function GetAzResourceLock and assigns to $Locks
        if ($Locks) { # If statement for if function GetAzResourceLock collects any locks and assigns them to $locks
            Write-Host "Removing all locks"... # Message write to screen
            RemoveAzResourceLock ($RGObject, $Locks) # Calls function RemoveAzResourceLocks
            Write-Host "Locks removed" # Message write to screen
        } # End if statement
        Write-Host $RGObject.ResourceGroupName"is being removed, this may take a while" # Message write to screen
        Remove-AzResourceGroup -Name $RGObject.ResourceGroupName -Force # Removes the resource group assigned to $RGObject, -force removes confirmation
        $RGObjectVerify = Get-AzResourceGroup -Name $RGObjectName # Collects the resource group using $RGObjectName and assigns to $RGObjectVerify
        if (!$RGObjectVerify) { # If statement for $RGObjectVerify being empty (This is a successful deletion)
            Write-Host $RGObjectName "has been deleted" # Write message to screen
            Return # Returns to calling function
        } # End if statement
        else { # Else statement for $RGObjectVerify having a value (This is an unsuccessful deletion)
            Write-Host $RGObjectName "was not deleted, you may not have correct permissions" # Write message to screen
            Return # Returns to calling function
        } # End else statement
    } # End begin statement
} # End function
function GetAzResourceGroup { # Function to get a resource group, can pipe $RGObject to another function
    Begin {
        $ErrorActionPreference='silentlyContinue' # Disables Errors
        $RGObject = $null # Clears $RGObject from all previous use
        while (!$RGObject) { # Loop to continue getting a resource group until the operator provided name matches an existing group
            $RGObjectInput = Read-Host "Resource group name" # Operator input of the resource group name
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
function GetAzResourceGroupLocksAll { # Function to get all locks assigned to a resource group, can pipe $Locks to another function
    Begin {
        $ErrorActionPreference='silentlyContinue' # Disables Errors
        if (!$RGObject) { # If statement if $RGObject is $null
            $RGObject = GetAzResourceGroup # Calls function GetAzResourceGroup and assigns to $RGObject
        } # End if statement
        $Locks = Get-AzResourceLock -ResourceGroupName $RGObject.ResourceGroupName # Collects all locks and assigns to $Locks
        if (!$Locks) { # If statement for no object assigned to $Locks
            Write-Host "No locks are on this resource group" # Write message to screen
            Return # Returns to calling function
        } # End if statement
        else { # Else statement for an object being assigned to $Locks
            Write-Host $Locks.Name -Separator `n # Write-host used so list is written to screen when function is used as $Locks = GetAzResourceGroupLocksAll
            Return $Locks # Returns $Locks to the calling function
        } # End else statement
    } # End begin statement
} # End function
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
            } # End if statement
            elseif ($OperatorSelect -eq '2') { # elseif statement for option 2
                Write-Host "**Remove a named lock on a resource group**" # Write message to screen
                $Locks = GetAzResourceGroupLock # Calls function GetAzResourceGroupLock and assigns to $Locks
            } # End elseif statement
            elseif ($OperatorSelect -eq '3') { # elseif statement for option 3
                Write-Host "**Remove all locks on a resource**" # Write message to screen
                $Locks = GetAzResourceLocksAll # Calls function GetAzResourceLocksAll and assigns to $Locks
            } # End elseif statement
            elseif ($OperatorSelect -eq '4') { # elseif statement for option 4
                Write-Host "**Remove a named lock on a resource**" # Write message to screen
                $Locks = GetAzResourceLock # Calls function GetAzResourceLock and assigns to $Locks
            } # End elseif statement
            elseif ($OperatorSelect -eq 'Exit') { # elseif statement for 'Exit'
                Write-Host "**Terminating Script**" # Write message to screen
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