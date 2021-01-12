# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Mircosoft docs links
    New-AzResourceLock:         https://docs.microsoft.com/en-us/powershell/module/az.resources/new-azresourcelock?view=azps-5.2.0
    Get-AzResourceGroup:        https://docs.microsoft.com/en-us/powershell/module/az.resources/get-azresourcegroup?view=azps-5.1.0

} #>
<# Required Functions Links: {
    GetAzResourceGroup:         https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/GetAzResourceGroup.ps1
} #>
<# Functions Description: {
    NewAzResourceGroupLock:     Create a new resource lock on a resource group
    GetAzResourceGroup:         Collects resource group object
} #>
<# Variables: {
    NewAzResourceGroupLock {
        $RGObject:              Resource group object
        $LockName:              Operator input for the lock name
        $LockLevel:             Operator input for the lock level
        $LockNotes:             Optional operator input for the lock notes
        $Locks:                 Locks object
        :NewAzureRGLock         Outer loop for function
        :GetAzureLockName       Inner loop for getting lock name
        :GetAzureLockLevel      Inner loop for getting lock level
    }
    GetAzResourceGroup {
        $RGObject:              Resource group object
        $RGObjectInput:         Operator input for the resource group name
        $RGList:                Variable used for printing all resource groups to screen if needed
    }
} #>
<# Process Flow {
    Function
        Call NewAzResourceGroupLock > Get $Locks
            Call GetAzResourceGroup > Get RGObject
                Return GetAzResourceGroup > Send $RGObject
            End NewAzResourceGroupLock
                Return function > Send $Locks
}#>
function NewAzResourceGroupLock { # Function to create a new resource lock on a resource group
    Begin {
        :NewAzureRGLock while ($true) { # :NewAzureRGLock loop for creating a new resource group lock
            if (!$RGObject) { # If $RGObject is $null
                $RGObject = GetAzResourceGroup # Calls GetAzResourceGroup and assigns output to $RGObject
                if (!$RGObject) { # If called function returns empty
                    Break NewAzureRGLock # Breaks :NewAzureRGLock loop
                } # End if (!$RGObject)
            } # End if (!$RGObject)
            :GetAzureLockName while ($true) { # :GetAzureLockName loop for setting the lock name
                $LockName = Read-Host "Lock Name?" # Operator input for the lock name
                if ($LockName -eq 'exit') { # If operator input is 'exit'
                    Break NewAzureRGLock # Breaks :NewAzureRGLock loop
                } # End if ($LockName -eq 'exit')
                Write-Host "The lock name will be" $LockName # Write message to screen
                $OperatorConfirm = Read-Host "Confirm?" # Operator input to confirm the lock name
                if ($OperatorConfirm -eq 'exit') { # If operator input is 'exit' 
                    Break NewAzureRGLock # Breaks :NewAzureRGLock loop
                } # End if ($OperatorConfirm -eq 'exit')
                elseif ($OperatorConfirm -eq 'y' -or $OperatorConfirm -eq 'yes') { # Operator confirm is 'y' or 'yes'
                    Break GetAzureLockName # Breaks :GetAzureLockName
                } # End elseif ($OperatorConfirm -eq 'y' -or $OperatorConfirm -eq 'yes')
            } # End :GetAzureLockName while ($true)
            :GetAzureLockLevel while ($true) { # :GetAzureLockLevel loop for setting lock level
                Write-Host "1 Read Only" # Write message to screen
                Write-Host "2 Can Not Delete" # Write message to screen
                $LockLevel = Read-Host "Option"
                if ($LockLevel -eq 'exit') { # If operator input is 'exit'
                    Break NewAzureRGLock # Breaks :NewAzureRGLock loop
                } # End if ($LockLevel -eq 'exit')
                elseif ($LockLevel -eq '1') { # If $LockLevel is '1'
                    $LockLevel = 'ReadOnly' # Sets $LockLevel to 'ReadOnly'
                    Break GetAzureLockLevel # Breaks GetAzureLockLevel
                } # End elseif ($LockLevel -eq '1')
                elseif ($LockLevel -eq '2') { # If $LockLevel is '2'
                    $LockLevel = 'CanNotDelete'# Sets $LockLevel to 'CanNotDelete'
                    Break GetAzureLockLevel # Breaks GetAzureLockLevel
                } # End elseif ($LockLevel -eq '2')
                else { # All other inputs for $LockLevel
                    Write-Host "That is not a valid option"  # Write message to screen
                } # End else (if ($LockLevel -eq 'exit'))
            } # End :GetAzureLockLevel while($true)
            $LockNotes = Read-Host "Add lock notes" # Operator input for lock notes
            if ($LockNotes) { # If $LocksNotes has a value
                $Locks = New-AzResourceLock -LockLevel $LockLevel -LockNotes $LockNotes -LockName $LockName -ResourceGroupName $RGObject.ResourceGroupName -Force # Deploys resource lock to resource group (With lock notes)   
                Return $Locks # Returns $Locks to calling function
            } # End if ($OperatorSelect -eq "y" -or $OperatorSelect -eq 'yes')
            else { # If $LockNotes is $null
                $Locks = New-AzResourceLock -LockLevel $LockLevel -LockName $LockName -ResourceGroupName $RGObject.ResourceGroupName -Force # Deploys resource lock to resource group (No lock notes)
                Return $Locks # Returns $Locks to calling function
            } # End else (if ($OperatorSelect -eq "y" -or $OperatorSelect -eq 'yes'))
        } # End :NewAzureRGLock while ($true) {
        Return
    } # End begin
} # End function NewAzResourceGroupLock