# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Mircosoft docs links
    Get-AzResourceGroup:        https://docs.microsoft.com/en-us/powershell/module/az.resources/get-azresourcegroup?view=azps-5.1.0
    Remove-AzResourceGroup:     https://docs.microsoft.com/en-us/powershell/module/az.resources/remove-azresourcegroup?view=azps-5.1.0
    Get-AzResourceLock:         https://docs.microsoft.com/en-us/powershell/module/az.resources/get-azresourcelock?view=azps-5.0.0
    Remove-AzResourceLock:      https://docs.microsoft.com/en-us/powershell/module/az.resources/remove-azresourcelock?view=azps-5.0.0

} #>
<# Required Functions Links: {
    GetAzResourceGroup:         https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/GetAzResourceGroup.ps1
    GetAzResourceGroupLocksAll: https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Locks/GetAzResourceGroupLocksAll.ps1
    RemoveAzResourceLocks:      https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Locks/RemoveAzResourceLocks.ps1

} #>    
<# Function Description: {
    GetAzResourceGroup:         Collects resource group object
    RemoveAzResourceGroup:      Removes a resource group object
    GetAzResourceGroupLocksAll: Collects resource locks
    RemoveAzResourceLocks:      Removes resource locks passed in $Locks
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
    RemoveAzResourceLocks {
        $Locks:                 Lock or locks object
    }
    RemoveAzResourceLocks {
        $Locks:                 Lock or locks object
        $OperatorConfirm:       Operator input what locks to collect
    }
} #>
<# Process Flow {
    Function
        Call RemoveAzResourceGroup
            Call GetAzResourceGroup > Get $RGObject
                Call GetAzResourceGroupLocksAll > Get $Locks
                Call RemoveAzResourceLocks > Send $Locks
}#>
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
            RemoveAzResourceLocks ($Locks) # Calls function RemoveAzResourceLocks
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