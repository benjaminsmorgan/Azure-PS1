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
    RemoveAzResourceLocksAll:   Removes resource locks passed in $Locks
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
    RemoveAzResourceLocksAll {
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
            if (!$RGObject) { # If statement if $RGObject is $null after calling GetAzResourceObject
                Write-Host "The RemoveAzResourceGroup function was terminated"
                Return # Returns to calling function
            } # End if statement
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
                Write-Host "RemoveAzResourceLock function was terminated" # Message write to screen
                Return # Returns to calling function
            } # End elseif statement
            Write-Host "Confirmation declined" # Message write to screen
            Write-Host "Please enter the resource group name" # Message write to screen
            $RGObject = $null # Clears $RGObject, restarting named while loop
        } # End while statement
        $Locks = $null # Clears any previous use of $Locks
        $Locks = GetAzResourceGroupLocksAll ($RGObject) # Calls function GetAzResourceLock and assigns to $Locks
        if ($Locks) { # If statement for if function GetAzResourceLock collects any locks and assigns them to $locks
            Write-Host "Removing all locks"... # Message write to screen
            RemoveAzResourceLocksAll ($Locks) # Calls function RemoveAzResourceLocksAll
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
function GetAzResourceGroupLocksAll { # Function to get all locks assigned to a resource group, can pipe $Locks to another function
    Begin {
        $ErrorActionPreference='silentlyContinue' # Disables Errors
        if (!$RGObject) { # If statement if $RGObject is $null
            $RGObject = GetAzResourceGroup # Calls function GetAzResourceGroup and assigns to $RGObject
            if (!$RGObject) { # If statement if $RGObject is $null after calling GetAzResourceObject
                Write-Host "GetAzResourceGroupLocksAll function was terminated" # Message write to screen
                Return # Returns to calling function
            } # End if statement
        } # End if statement
        $Locks = Get-AzResourceLock -ResourceGroupName $RGObject.ResourceGroupName # Collects all locks and assigns to $Locks
        if (!$Locks) { # If statement for no object assigned to $Locks
            Write-Host "No locks are on this resource group" # Write message to screen
            Write-Host "The GetAzResourceGroupLocksAll function was terminated" # Message write to screen
            Return # Returns to calling function
        } # End if statement
        else { # Else statement for an object being assigned to $Locks
            Write-Host $Locks.Name -Separator `n # Write-host used so list is written to screen when function is used as $Locks = GetAzResourceGroupLocksAll
            Return $Locks # Returns $Locks to the calling function
        } # End else statement
    } # End begin statement
} # End function
function RemoveAzResourceLocksAll { # Function to remove resource locks, this must have $Locks passed to it to function. No input validation is done
    Begin {
        $ErrorActionPreference='silentlyContinue' # Disables Errors
        foreach ($LockId in $Locks) { # Completes the command in a loop untill performed on all LockIds within $Locks
            $LockId.name # Prints the LockId for each lock as the cycle goes
            Remove-AzResourceLock -LockId $LockId.LockId -force # Removes the lock by targeting the LockID, -force removes operator confirmation
        } # End foreach loop
    } # End begin statement
} # End function