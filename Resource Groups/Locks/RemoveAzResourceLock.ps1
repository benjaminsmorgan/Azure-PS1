# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Mircosoft docs links
    Remove-AzResourceLock:      https://docs.microsoft.com/en-us/powershell/module/az.resources/remove-azresourcelock?view=azps-5.0.0
    Get-AzResource:             https://docs.microsoft.com/en-us/powershell/module/az.resources/get-azresource?view=azps-5.1.0
    Get-AzResourceLock:         https://docs.microsoft.com/en-us/powershell/module/az.resources/get-azresourcelock?view=azps-5.0.0
} #>
<# Required Functions Links: {
    RemoveAzResourceLocks:      https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/Locks/RemoveAzResourceLocks.ps1
    GetAzResourceLock:          https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/Locks/GetAzResourceLock.ps1
    GetAzResource:              https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/Resources/GetAzResource.ps1
} #>
<# Functions Description: {
    RemoveAzResourceLock:  Gets a resource group lock and sends it to RemoveAzResourceLocks
    RemoveAzResourceLocks:      Removes all $Locks
    GetAzResourceLock:     Collects a lock on a resource group
    GetAzResource:         Collects resource group object
} #>
<# Variables: {
    :RemoveAzureRSLock          Outer loop for managing function  
    $CallingFunction:           Name of this function
    $Locks:                     Lock object
    $LocksRemoved:              Temp $var not used in this function
    GetAzResourceLocks{}    Gets $Locks
        GetAzResource{}             Gets $RSObject
    RemoveAzResourceLocks{}     Removes $Locks
} #>
<# Process Flow {
    Function
        Call RemoveAzResourceLock > Get $null
            Call GetAzResourceLock > Get $Locks
                Call GetAzResource > Get $RSObject
                End GetAzResource
                    Return GetAzResourceLock > Send $RSObject
            End GetAzResourceLock
                Return RemoveAzResourceLock > Send $Locks 
            Call RemoveAzResourceLocks > Get $LocksRemoved
            End RemoveAzResourceLocks
                Return RemoveAzResourceLock > Send $LocksRemoved
        End RemoveAzResourceLock
            Return function > Send $null
}#>
function RemoveAzResourceLock {                                                             # Function to remove a single resource lock
    Begin {                                                                                 # Begin function
        :RemoveAzureRSLock while ($true) {                                                  # Outer loop for managing function
            if (!$CallingFunction) {                                                        # If $CallingFunction is $null
                $CallingFunction = 'RemoveAzResourceLock'                                   # Creates $CallingFunction
            }                                                                               # End if (!$CallingFunction)
            if (!$Locks) {                                                                  # If $Locks is $null
                $Locks = GetAzResourceLock ($CallingFunction)                               # Calls function and assigns output to $var
                if (!$Locks) {                                                              # If $Locks is $null
                    Break RemoveAzureRSLock                                                 # Breaks :RemoveAzureRSLock
                }                                                                           # End if (!$Locks) | Inner
            }                                                                               # End if (!$Locks) | Outer
            $LocksRemoved = RemoveAzResourceLocks ($Locks)                                  # Calls function and assigns output to $var
            $LocksRemoved = $null                                                           # Clears $LocksRemoved
            Break RemoveAzureRSLock                                                         # Breaks :RemoveAzureRSLock
        }                                                                                   # End :RemoveAzureRSLock while ($true) 
        Clear-Host                                                                          # Clears screen
        return                                                                              # Returns to calling function with $null
    }                                                                                       # End begin
}                                                                                           # End function RemoveAzResourceLock