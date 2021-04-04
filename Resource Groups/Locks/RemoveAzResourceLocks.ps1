# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Mircosoft docs links
    Get-AzResourceGroup:        https://docs.microsoft.com/en-us/powershell/module/az.resources/get-azresourcegroup?view=azps-5.1.0
    Get-AzResource:             https://docs.microsoft.com/en-us/powershell/module/az.resources/get-azresource?view=azps-5.1.0
    Get-AzResourceLock:         https://docs.microsoft.com/en-us/powershell/module/az.resources/get-azresourcelock?view=azps-5.0.0
    Remove-AzResourceLock:      https://docs.microsoft.com/en-us/powershell/module/az.resources/remove-azresourcelock?view=azps-5.0.0
} #>
<# Required Functions Links: {
    GetAzResourceLocks:         https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/Locks/GetAzResourceLocks.ps1
    GetAzResourceGroup:         https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/GetAzResourceGroup.ps1
    GetAzResource:              https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/GetAzResource.ps1
    GetAzResourceGroupLocksAll: https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/Locks/GetAzResourceGroupLocksAll.ps1
    GetAzResourceGroupLockNamed:https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/Locks/GetAzResourceGroupLockNamed.ps1
    GetAzResourceLocksAll:      https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/Locks/GetAzResourceLocksAll.ps1
    GetAzResourceLockNamed:     https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/Locks/GetAzResourceLockNamed.ps1
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
function RemoveAzResourceLocks {                                                            # Function to remove resource locks
    Begin {                                                                                 # Begin function
        :RemoveAzureLocks while ($true) {                                                   # Outer loop for managing function
            if (!$Locks) {                                                                  # If $Locks is $null
                $Locks = GetAzResourceLocks                                                 # Calls GetAzResourceLocks and assigns to $Locks
                if(!$Locks) {                                                               # If $Locks is $null
                    Break RemoveAzureLocks                                                  # Breaks :RemoveAzureLocks
                }                                                                           # End if(!$Locks) | Inner
            }                                                                               # End if(!$Locks) | Outer
            foreach ($_ in $Locks) {                                                        # For each item in $Locks
                Write-Host $_.Name                                                          # Write message to screen
            }                                                                               # End foreach ($_ in $Locks)
            Write-Host 'Remove these locks'                                                 # Write message to screen
            $OperatorConfirm = Read-Host '[Y] or [N]'                                       # Operator confirmation to remove the locks
            if ($OperatorConfirm -eq 'Y') {                                                 # If $Operatorconfirm equals 'y' 
                foreach ($_ in $Locks) {                                                    # For each item in $Locks
                    Try {                                                                   # Try the following
                        Write-Host 'Removing'$_.name                                        # Write message to screen
                        Remove-AzResourceLock -LockId $_.LockId -force -ErrorAction 'Stop'  # Removes the current item in $Locks
                    }                                                                       # End try
                    catch {                                                                 # If Try fails
                        Write-Host 'An error has occured'                                   # Write message to screen
                        $LocksRemoved = 'n'                                                 # Sets $LocksRemoved to 'n'
                        Return $LocksRemoved                                                # Returns to calling function with $LocksRemoved
                    }                                                                       # End catch
                }                                                                           # End foreach ($_ in $Locks)
                Write-Host 'All locks removed'                                              # Write message to screen
                $LocksRemoved = 'y'                                                         # Sets $LocksRemoved to 'y'
                Return $LocksRemoved                                                        # Returns to calling function with $LocksRemoved
            }                                                                               # End if ($OperatorConfirm -eq 'Y') 
            else {                                                                          # Else if $Operatorconfirm is not equal to 'y'
                Write-Host "No changes made"                                                # Message write to screen
                $LocksRemoved = 'n'                                                         # Sets $LocksRemoved to 'n'
                Return $LocksRemoved                                                        # Returns to calling function with $LocksRemoved
            }                                                                               # End else (if ($OperatorConfirm -eq 'Y') )
        }                                                                                   # End :RemoveAzureLocks while ($true)
        return                                                                              # Returns to calling function with $null
    }                                                                                       # End begin 
}                                                                                           # End function RemoveAzResourceLocks