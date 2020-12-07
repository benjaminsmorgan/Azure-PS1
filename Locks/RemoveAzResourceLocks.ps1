# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Mircosoft docs links
    Get-AzResourceGroup:        https://docs.microsoft.com/en-us/powershell/module/az.resources/get-azresourcegroup?view=azps-5.1.0
    Get-AzResource:             https://docs.microsoft.com/en-us/powershell/module/az.resources/get-azresource?view=azps-5.1.0
    Get-AzResourceLock:         https://docs.microsoft.com/en-us/powershell/module/az.resources/get-azresourcelock?view=azps-5.0.0
    Remove-AzResourceLock:      https://docs.microsoft.com/en-us/powershell/module/az.resources/remove-azresourcelock?view=azps-5.0.0
} #>
<# Required Functions: {
    RemoveAzResourceLocks:      Removes locks
    GetAzResourceLocks:         Management function to get different sets of locks
    GetAzResourceGroup:         Collects resource group object
    GetAzResource:              Collects resources within a resource group
    GetAzResourceGroupLocksAll: Collects all locks on a resource group and its resources
    GetAzResourceGroupLockNamed:Collects a named locks on a resource group
    GetAzResourceLocksAll:      Collects all locks on a resource
    GetAzResourceLockNamed:     Collects a named lock on a resource
    GetAzResource:              Collects resources within a resource group
} #>
<# Variables: {
    RemoveAzResourceLocks {
        $Locks:                 Lock or locks object
    }    
    GetAzResourceLocks {
        $Locks:                 Lock or locks object
        $OperatorSelect:        Operator input what locks to collect
    }
    GetAzResourceGroup{
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
    RemoveAzResourceLocks           ->          [Call] GetAzResourceLocks               ->          [Request] $Locks
    GetAzResourceLocks              ->          [Call] GetAzResourceGroupLocksAll       ->          [Request] $Locks
        GetAzResourceGroupLocksAll      ->          [Call] GetAzResourceGroup               ->          [Request] $RGObject
            GetAzResourceGroupLocksAll      ->          [Return] GetAzResouseLocks              ->          [Return]  $Locks
                GetAzResourceLocks              ->          [Return] RemoveAzResourceLocks          ->          [Return]  $Locks
    GetAzResourceLocks              ->          [Call] GetAzResourceGroupLocksNamed     ->          [Request] $Locks
        GetAzResourceGroupLocksNamed    ->          [Call] GetAzResourceGroup               ->          [Request] $RGObject
            GetAzResourceGroupLocksNamed    ->          [Return] GetAzResouseLocks              ->          [Return]  $Locks
                GetAzResourceLocks              ->          [Return] RemoveAzResourceLocks          ->          [Return]  $Locks
    GetAzResourceLocks              ->          [Call] GetAzResourceLocksAll            ->          [Request] $Locks
        GetAzResourceLocksAll           ->          [Call] GetAzResourceGroup               ->          [Request] $RGObject
            GetAzResourceLocksAll           ->          [Call] GetAzResource                    ->          [Request] $RSObject
                GetAzResourceLocksAll           ->          [Return] GetAzResouseLocks              ->          [Return]  $Locks
                    GetAzResourceLocks              ->          [Return] RemoveAzResourceLocks          ->          [Return]  $Locks
    GetAzResourceLocks              ->          [Call] GetAzResourceLocksNamed          ->          [Request] $Locks
        GetAzResourceLocksNamed         ->          [Call] GetAzResourceGroup               ->          [Request] $RGObject
            GetAzResourceLocksNamed         ->          [Call] GetAzResource                    ->          [Request] $RSObject
                GetAzResourceLocksNamed         ->          [Return] GetAzResouseLocks              ->          [Return]  $Locks    
                    GetAzResourceLocks              ->          [Return] RemoveAzResourceLocks          ->          [Return]  $Locks
    RemoveAzResourceLocks           ->          [Delete] $Locks
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
function GetAzResourceLocks { # Function to manage getting resource locks, can pipe $Locks into another function
    Begin {
        while (!$Locks) { # While statement to get $Locks by calling another function is $Locks is $null
            Write-Host "'1' Get all locks on a resource group and its resources" # Write option to screen
            Write-Host "'2' Get a named lock on a resource group" # Write option to screen
            Write-Host "'3' Get all locks on a resource" # Write option to screen
            Write-Host "'4' Get a named lock on a resource" # Write option to screen
            $OperatorSelect = Read-Host "Enter the number from the list" # Operator input to call function to collect $Locks
            if ($OperatorSelect -eq '1') { # If statement for option 1
                Write-Host "**Get all locks on a resource group and its resources**" # Write message to screen
                $Locks = GetAzResourceGroupLocksAll # Calls function GetAzResourceGroupLocksAll and assigns to $Locks
                if (!$Locks) { # Check to see if called function returned a value
                    Write-Host "GetAzResourceLocks function was terminated" # Message write to screen
                    Return # Returns to calling function
                } # End if statement
                Return $Locks # Returns $Locks to calling function
            } # End if statement
            elseif ($OperatorSelect -eq '2') { # elseif statement for option 2
                Write-Host "**Get a named lock on a resource group**" # Write message to screen
                $Locks = GetAzResourceGroupLockNamed # Calls function GetAzResourceGroupLockNamed and assigns to $Locks
                if (!$Locks) { # Check to see if called function returned a value
                    Write-Host "GetAzResourceLocks function was terminated" # Message write to screen
                    Return # Returns to calling function
                } # End if statement
                Return $Locks # Returns $Locks to calling function
            } # End elseif statement
            elseif ($OperatorSelect -eq '3') { # elseif statement for option 3
                Write-Host "**Get all locks on a resource**" # Write message to screen
                $Locks = GetAzResourceLocksAll # Calls function GetAzResourceLocksAll and assigns to $Locks
                if (!$Locks) { # Check to see if called function returned a value
                    Write-Host "GetAzResourceLocks function was terminated" # Message write to screen
                    Return # Returns to calling function
                } # End if statement
                Return $Locks # Returns $Locks to calling function
            } # End elseif statement
            elseif ($OperatorSelect -eq '4') { # elseif statement for option 4
                Write-Host "**Get a named lock on a resource**" # Write message to screen
                $Locks = GetAzResourceLockNamed # Calls function GetAzResourceLockNamed and assigns to $Locks
                if (!$Locks) { # Check to see if called function returned a value
                    Write-Host "GetAzResourceLocks function was terminated" # Message write to screen
                    Return # Returns to calling function
                } # End if statement
                Return $Locks # Returns $Locks to calling function
            } # End elseif statement
            elseif ($OperatorSelect -eq 'Exit') { # Elseif statement for 'Exit'
                Write-Host "GetAzResourceLocks function was terminated" # Message write to screen
                Return # Returns to calling function
            } # End elseif statement
            else { # Else statement for no valid inputs by the operator
                Write-Host "**That was not a valid selection**" # Write error to screen
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
function GetAzResource {
    Begin {
        $ErrorActionPreference='silentlyContinue' # Disables Errors
        $RSObject = $null
        if (!$RGObject) { # If statement if $RGObject is $null
            $RGObject = GetAzResourceGroup # Calls function GetAzResourceGroup and assigns to $RGObject
            if (!$RGObject) { # If statement if $RGObject is $null after calling GetAzResourceObject
                Write-Host "GetAzResource function was terminated" # Message write to screen
                Return # Returns to calling function
            } # End if statement
        } # End if statement
        while (!$RSObject) { # Loop to continue getting a resource until the operator provided name matches an existing resource
            $RSObjectInput = Read-Host "Resource name" # Operator input of the resource name
            if ($RSObjectInput -eq 'exit') { # Operator input for exit
                Write-Host "GetAzResource function was terminated"
                Return # Returns to calling function
            } # End if statement
            $RSObject = Get-AzResource -Name $RSObjectInput -ResourceGroupName $RGObject.ResourceGroupName # Collection of the resource from the operator input
            if (!$RSObject) { # Error reporting if input does not match an existing group
                Write-Host "The name provided does not match an existing resource" # Error note
                Write-Host "This is the list of available resources" # Error note
                $RSList = Get-AzResource -ResourceGroupName $RGObject.ResourceGroupName # Collects all resource objects and assigns to a variable
                Write-Host "" # Error reporting
                Write-Host $RSList.Name -Separator `n # Write-host used so list is written to screen when function is used as $RGObject = GetAzResourceGroup
                Write-Host "" # Error reporting
            } # End of if statement
            else { # Else for when $RSObject is assigned
                Write-Host $RSObject.Name 'Has been assigned to "$RSObject"' # Writes the resource name to the screen before ending function
            } # End of else statement
        } # End of while statement
        Return $RSObject  # Returns the value of $RSObject to a function that called it
    } # End begin statement
} # End function 
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
function GetAzResourceLocksAll { # Function to get all locks assigned to a resource, can pipe $Locks to another function
    Begin {
        $RGObject = GetAzResourceGroup # Calls function GetAzResourceGroup and assigns to $RGObject
        if (!$RGObject) { # If statement if $RGObject is $null after calling GetAzResourceObject
            Write-Host "GetAzResourceLocksAll function was terminated" # Message write to screen
            Return # Returns to calling function
        } # End if statement
        $RSObject = GetAzResource # Calls function GetAzResourceGroup and assigns to $RGObject
        if (!$RSObject) { # If statement if $RGObject is $null after calling GetAzResourceObject
            Write-Host "GetAzResourceLocksAll function was terminated" # Message write to screen
            Return # Returns to calling function
        } # End if statement
        $Locks = Get-AzResourceLock -ResourceGroupName $RGObject.ResourceGroupName -ResourceName $RSObject.Name -ResourceType $RSObject.ResourceType | Where-Object {$_.ResourceName -eq $RSObject.Name} # Collects all locks and assigns to $Locks
        if (!$Locks) { # If statement for no object assigned to $Locks
            Write-Host "No locks are on this resource" # Write message to screen
            Write-Host "The GetAzResourceLocksAll function was terminated" # Message write to screen
            Return # Returns to calling function
        } # End if statement
        else { # Else statement for an object being assigned to $Locks
            Write-Host $Locks.Name -Separator `n # Write-host used so list is written to screen when function is used as $Locks = GetAzResourceLocksAll
            Return $Locks # Returns $Locks to the calling function
        } # End else statement
    } # End begin statement
} # End function   
function GetAzResourceLockNamed { # Function to get a named lock assigned to a resource, can pipe $Locks to another function
    Begin {
        $RGObject = GetAzResourceGroup # Calls function GetAzResourceGroup and assigns to $RGObject
        if (!$RGObject) { # If statement if $RGObject is $null after calling GetAzResourceObject
            Write-Host "GetAzResourceLockNamed function was terminated" # Message write to screen
            Return # Returns to calling function
        } # End if statement
        $RSObject = GetAzResource # Calls function GetAzResourceGroup and assigns to $RGObject
        if (!$RSObject) { # If statement if $RGObject is $null after calling GetAzResourceObject
            Write-Host "GetAzResourceLockNamed function was terminated" # Message write to screen
            Return # Returns to calling function
        } # End if statement
        while (!$Locks) { # While statement used for looping until the correct lock has been found
            $LocksInput = Read-Host "Enter the lock name" # Operator input for a resource lock name
            if ($LocksInput -eq 'exit') { # Operator input for exit
                Write-Host "GetAzResourceLockNamed function was terminated"
                Return # Returns to calling function
            } # End if statement
            $Locks = Get-AzResourceLock -ResourceGroupName $RGObject.ResourceGroupName -ResourceName $RSObject.Name -ResourceType $RSObject.ResourceType -LockName $LocksInput | Where-Object {$_.ResourceName -eq $RSObject.Name} # Collects all locks and assigns to $Locks
            if (!$Locks) { # If statement for no object assigned to $Locks
                Write-Host "No locks by that name were found on this resource" # Write message to screen
                Write-Host "The following are the current locks assigned to" $RSObject.Name
                $LocksList = Get-AzResourceLock -ResourceGroupName $RGObject.ResourceGroupName -ResourceName $RSObject.Name -ResourceType $RSObject.ResourceType | Where-Object {$_.ResourceName -eq $RSObject.Name} # Collects all locks and assigns to $Locks
                Write-Host $LocksList.Name -Separator `n # Write-host used so list is written to screen when function is used as $Locks = GetAzResourceGroupLocksAll
            } # End if statement
            else {
                $OperatorConfirm = Read-Host "Is this the correct lock" $Locks.Name 
                if ($OperatorConfirm -eq 'y' -or $OperatorConfirm -eq 'yes') {
                    Write-Host $Locks.Name -Separator `n # Write-host used so list is written to screen when function is used as $Locks = GetAzResourceGroupLock
                    Return $Locks # Returns $Locks to the calling function
                } # End if statement
                elseif ($OperatorSelect -eq 'Exit') { # Elseif statement for 'Exit'
                    Write-Host "GetAzResourceLockNamed function was terminated" # Message write to screen
                    Return # Returns to calling function
                } # End elseif statement
                else { # Else statement if operator does not confirm the lock
                    $Locks = $null # Clears $Locks to restart the loop
                } # End else statement
            } # End else statement
        } # End while statement
    } # End begin statement
} # End funtion