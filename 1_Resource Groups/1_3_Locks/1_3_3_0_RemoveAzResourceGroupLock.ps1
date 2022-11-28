# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Microsoft docs links
    Remove-AzResourceLock:      https://docs.microsoft.com/en-us/powershell/module/az.resources/remove-azresourcelock?view=azps-5.0.0
    Get-AzResourceGroup:        https://docs.microsoft.com/en-us/powershell/module/az.resources/get-azresourcegroup?view=azps-5.1.0
    Get-AzResourceLock:         https://docs.microsoft.com/en-us/powershell/module/az.resources/get-azresourcelock?view=azps-5.0.0
} #>
<# Required Functions Links: {
    RemoveAzResourceLocks:      https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/Locks/RemoveAzResourceLocks.ps1
    GetAzResourceGroupLock:     https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/Locks/GetAzResourceGroupLock.ps1
    GetAzResourceGroup:         https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/Resource%20Groups/GetAzResourceGroup.ps1
} #>
<# Functions Description: {
    RemoveAzResourceGroupLock:  Gets a resource group lock and sends it to RemoveAzResourceLocks
    RemoveAzResourceLocks:      Removes all $Locks
    GetAzResourceGroupLock:     Collects a lock on a resource group
    GetAzResourceGroup:         Collects resource group object
} #>
<# Variables: {
    :RemoveAzureRGLock          Outer loop for managing function  
    $CallingFunction:           Name of this function
    $Locks:                     Lock object
    $LocksRemoved:              Temp $var not used in this function
    GetAzResourceGroupLocks{}   Gets $Locks
        GetAzResourceGroup{}        Gets $RGObject
    RemoveAzResourceLocks{}     Removes $Locks
} #>
<# Process Flow {
    Function
        Call RemoveAzResourceGroupLock > Get $null
            Call GetAzResourceGroupLock > Get $Locks
                Call GetAzResourceGroup > Get $RGObject
                End GetAzResourceGroup
                    Return GetAzResourceGroupLock > Send $RGObject
            End GetAzResourceGroupLock
                Return RemoveAzResourceGroupLock > Send $Locks 
            Call RemoveAzResourceLocks > Get $LocksRemoved
            End RemoveAzResourceLocks
                Return RemoveAzResourceGroupLock > Send $LocksRemoved
        End RemoveAzResourceGroupLock
            Return function > Send $null
}#>
function RemoveAzResourceGroupLock {                                                        # Function to remove a single resource group lock
    Begin {                                                                                 # Begin function
        :RemoveAzureRGLock while ($true) {                                                  # Outer loop for managing function
            if (!$CallingFunction) {                                                        # If $CallingFunction is $null
                $CallingFunction = 'RemoveAzResourceGroupLock'                              # Creates $CallingFunction
            }                                                                               # End if (!$CallingFunction)
            $Locks = GetAzResourceGroupLock ($CallingFunction)                              # Calls function and assigns output to $var
            if (!$Locks) {                                                                  # If $Locks is $null
                Break RemoveAzureRGLock                                                     # Breaks :RemoveAzureRGLock
            }                                                                               # End if (!$Locks) 
            RemoveAzResourceLocks ($Locks)                                                  # Calls function and assigns output to $var
            Break RemoveAzureRGLock                                                         # Breaks :RemoveAzureRGLock
        }                                                                                   # End :RemoveAzureRGLock while ($true) 
        Clear-Host                                                                          # Clears screen
        return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End begin
}                                                                                           # End function RemoveAzResourceGroupLock