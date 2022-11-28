# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Microsoft docs links
    Remove-AzResource:          https://docs.microsoft.com/en-us/powershell/module/az.resources/remove-azresource?view=azps-5.2.0
    Get-AzResource:             https://docs.microsoft.com/en-us/powershell/module/az.resources/get-azresource?view=azps-5.1.0
    Get-AzResourceLock:         https://docs.microsoft.com/en-us/powershell/module/az.resources/get-azresourcelock?view=azps-5.0.0
    Remove-AzResourceLock:      https://docs.microsoft.com/en-us/powershell/module/az.resources/remove-azresourcelock?view=azps-5.0.0
} #>
<# Required Functions Links: {  
    GetAzResource:              https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/GetAzResource.ps1
    GetAzRSLocksAll:            https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/Locks/GetAzRSLocksAll.ps1
    RemoveAzResourceLocks:      https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/Locks/RemoveAzResourceLocks.ps1
} #>
<# Functions Description: {
    RemoveAzResource:           Removes a selected resource
    GetAzResource:              Collects resources within a resource group 
    GetAzRSLocksAll:            Collects all locks on a resource
    RemoveAzResourceLocks:      Removes resource locks passed in $Locks
} #>
<# Variables: {
    :RemoveAzureRSObject        Outer loop for managing function 
    $RSObject:                  Resource object
    $CallingFunction:           Name of this function
    $RGLocks:                   List of locks on the resource group container the resource
    $OperatorConfirm:           Operator confirmation to delete this resource
    $Locks:                     List of locks on this resource
    $LocksRemoved:              Confirmation that locks on resource have been removed
    GetAzResource{}             Gets $RSObject
    GetAzRSLocksAll{}           Gets $Locks
    RemoveAzResourceLocks{}     Gets $LocksRemoved
} #>
<# Process Flow {
    Function
        Call RemoveAzResource > Get $null
            Call GetAzResource > Get $RSObject
            End GetAzResource
                Return RemoveAzResource > Send $RSObject
            Call GetAzRSLocksAll > Get $Locks
            End GetAzRSLocksAll
                Return RemoveAzResource > Send $Locks
            Call RemoveAzResourceLocks > Get $LocksRemoved
            End RemoveAzResourceLocks
                Return RemoveAzResourceLocks > Send $LocksRemoved
        End RemoveAzResource
                Return Function > Send $null                                    
}#>  
function RemoveAzResource {                                                                 # Removes a selected resource
    Begin {                                                                                 # Begin function
        :RemoveAzureRSObject while ($true) {                                                # Outer loop for managing function
            if (!$RSObject) {                                                               # If $RSObject does not have a value
                $CallingFunction = 'RemoveAzResource'                                       # Creates $CallingFunction
                $RSObject = GetAzResource ($CallingFunction)                                # Calls function and assigns output to $var
                if (!$RSObject) {                                                           # If $RSObject does not have a value
                    Break RemoveAzureRSObject                                               # Breaks :GetAzureRSObject
                }                                                                           # End if (!$RSObject) | Inner
            }                                                                               # End if (!$RSObject) | Outer
            $RGLocks = Get-AzResourceLock -ResourceGroupName $RSObject.ResourceGroupName `
                -AtScope                                                                    # Collects all locks on $RSObject group and assigns to $RGLocks
            if ($RGLocks) {                                                                 # If $RGLocks is not empty
                Write-Host 'Locks exist on the resource group'$RSObject.ResourceGroupName   # Write message to screen
                Write-Host 'Locks muse be removed before this resource can be removed'      # Write message to screen
                Break RemoveAzureRSObject                                                   # Breaks :RemoveAzureRSObject
            }                                                                               # End if ($RGLocks)
            Write-Host "////////////////////////////WARNING\\\\\\\\\\\\\\\\\\\\\\\\\\\\"    # Write message to screen
            Write-Host ""$RSObject.Name "will be deleted, this cannot be undone"            # Write message to screen
            Write-Host " All resource locks will be removed automatically if confirmed "    # Write message to screen
            Write-Host " This option can be exited by typing 'Exit'                    "    # Write message to screen
            Write-Host "\\\\\\\\\\\\\\\\\\\\\\\\\\\\WARNING////////////////////////////"    # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            Write-Host 'Delete this resource'                                               # Write message to screen
            $OperatorConfirm = Read-Host '[Y] or [N]'                                       # Operator input on confirming deletion of the resource
            if ($OperatorConfirm -eq 'Y') {                                                 # If $OperatorConfirm equals 'Y' 
                Write-Host "This resource has been approved for deletion"                   # Write message to screen
            }                                                                               # End if ($OperatorConfirm -eq 'Y')
            else {                                                                          # If $OperatorConfirm does not equal 'Y'
                Break RemoveAzureRSObject                                                   # Breaks :RemoveAzureRSObject
            }                                                                               # End else (if ($OperatorConfirm -eq 'Y'))
            $Locks = GetAzRSLocksAll ($RSObject)                                            # Calls function function and assigns output to $var
            if ($Locks) {                                                                   # If $Locks has a value
                Write-Host "Removing all locks"...                                          # Message write to screen
                $LocksRemoved = RemoveAzResourceLocks ($Locks)                              # Calls function RemoveAzResourceLocks
                if ($LocksRemoved -eq 'n') {                                                # If $LocksRemoved equals 'n' 
                    Write-Host 'Locks must be removed before'                               # Write message to screen
                    Write-Host 'this resource can be removed'                               # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Break RemoveAzureRSObject                                               # End Break RemoveAzureRSObject   
                }                                                                           # End if ($LocksRemoved -eq 'n') 
                Write-Host "Locks removed"                                                  # Message write to screen
            }                                                                               # End if ($Locks)
            Write-Host $RSObject.Name"is being removed, this may take a while"              # Message write to screen
            Try {                                                                           # Try the following
            Remove-AzResource -Name $RSObject.Name -ResourceGroup `
                $RSObject.ResourceGroupName -ResourceType $RSObject.ResourceType -Force     # Removes the resource assigned to $RSObject, -force removes confirmation
            }                                                                               # End try
            Catch {                                                                         # If try fauls 
                Write-Host `
                    $RSObjectName "was not deleted, you may not have correct permissions"   # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break RemoveAzureRSObject                                                   # Breaks :RemoveAzureRSObject
            }                                                                               # End Catch
            Write-Host 'The selected resource has been removed'                             # Write message to screen
            Pause                                                                           # Pauses all actions for operator input
            Break RemoveAzureRSObject                                                       # Breaks :RemoveAzureRSObject
        }                                                                                   # End :RemoveAzureRSObject while ($True)
        Clear-Host                                                                          # Clears screen
        Return                                                                              # Returns to calling function
    }                                                                                       # End Begin
}                                                                                           # End function RemoveAzResource