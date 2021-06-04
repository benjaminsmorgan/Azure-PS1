# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Mircosoft docs links
    Remove-AzResourceGroup:     https://docs.microsoft.com/en-us/powershell/module/az.resources/remove-azresourcegroup?view=azps-5.1.0
    Get-AzResourceGroup:        https://docs.microsoft.com/en-us/powershell/module/az.resources/get-azresourcegroup?view=azps-5.1.0
    Get-AzResourceLock:         https://docs.microsoft.com/en-us/powershell/module/az.resources/get-azresourcelock?view=azps-5.0.0
    Remove-AzResourceLock:      https://docs.microsoft.com/en-us/powershell/module/az.resources/remove-azresourcelock?view=azps-5.0.0
} #>
<# Required Functions Links: {
    GetAzResourceGroup:         https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/Resource%20Groups/GetAzResourceGroup.ps1
    GetAzRGLocksAll:            https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/Locks/GetAzRGLocksAll.ps1
    RemoveAzResourceLocks:      https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/Locks/RemoveAzResourceLocks.ps1  
} #>
<# Functions Description: {
    RemoveAzResourceGroup:      Removes a resource group object
    GetAzResourceGroup:         Gets resource group from full name match
    GetAzLocation:              Gets a list of azure locations
    GetAzRGLocksAll:            Gets a list of locks on $RGObject
    RemoveAzResourceLocks:      Removes all items in $Locks
} #>
<# Variables: {
    :RemoveAzResourceGroup      Outer loop for managing function
    $RGObject:                  Resource group object
    $CallingFunction:           Name of this function
    $OpConfirm:                 Operator confirmation to remove the resource group
    $Locks:                     List of all locks on resource group and contained resources
    $LocksRemoved:              Confirmation of $Locks being removed
    GetAzResourceGroup{}        Gets $RGObject
    GetAzRGLocksAll{}           Gets $Locks
    RemoveAzResourceLocks{}     Gets $LocksRemoved
} #>
<# Process Flow {
    Function
        Call RemoveAzResourceGroup > Get $null
            Call GetAzResourceGroup > Get $RGObject
            End GetAzResourceGroup
                Return RemoveAzResourceGroup > Send $RGObject
            Call function GetAzRGLocksAll > Get $Locks
            End GetAzRGLocksAll
                Return RemoveAzResourceGroup > Send $Locks
            Call Function RemoveAzResourceLocks > Get $LocksRemoved
            End RemoveAzResourceLocks
                Return RemoveAzResourceGroup > Send $LocksRemoved
        End RemoveAzResourceGroup
            Return ManageAzResourceGroup > Send $null
}#> 
function RemoveAzResourceGroup {                                                            # Function to remove a resource group
    Begin {                                                                                 # Begin funciton
        :RemoveAzureRGObject while ($true) {                                                # Outer loop for managing function
            $ErrorActionPreference='silentlyContinue'                                       # Disables Errors
            if (!$RGObject) {                                                               # If $RGObject does not have a value
                $CallingFunction = 'RemoveAzResourceGroup'                                  # Creates $CallingFunction
                $RGObject = GetAzResourceGroup ($CallingFunction)                           # Calls function and assigns output to $var
                if (!$RGObject) {                                                           # If $RGObject does not have a value
                    Break RemoveAzureRGObject                                               # Breaks :RemoveAzureRGObject
                }                                                                           # End if (!$RGObject) | Inner
            }                                                                               # End if (!$RGObject) | Outer
            Write-Host '////////////////////////////WARNING\\\\\\\\\\\\\\\\\\\\\\\\\\\\'    # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            Write-Host ' This will delete:'$RGObject.ResourceGroupName                      # Write message to screen
            Write-Host ' This action cannot be undone once completed'                       # Write message to screen
            Write-Host ' All resource locks will be removed automatically if confirmed '    # Write message to screen
            Write-Host ' All resources within the resource group will also be deleted  '    # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            Write-Host '\\\\\\\\\\\\\\\\\\\\\\\\\\\\WARNING////////////////////////////'    # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            Write-Host 'Delete this resource group'                                         # Write message to screen
            $OpConfirm = Read-Host '[Y] Yes [N] No'                                         # Operator input on confirming deletion of the resource group
            Clear-Host                                                                      # Clears screen
            $RGObjectName = $RGObject.ResourceGroupName                                     # Collects the name of the resource group for later use
            if ($OpConfirm -eq 'y') {                                                       # If $OpConfirm equals 'y'
                    Write-Host 'Checking for locks on:'$RGObjectName.ResourceGroupName      # Write message to screen
                $Locks = GetAzRGLocksAll ($RGObject)                                        # Calls function and assigns output to $vat
                if ($Locks) {                                                               # If $Locks has a value
                    Write-Host 'Removing all locks'                                         # Write message to screen
                    $LocksRemoved = RemoveAzResourceLocks ($Locks)                          # Calls function and assigns output to $var
                    if ($LocksRemoved -eq 'n') {                                            # If $LocksRemoved equals 'n'
                        Break RemoveAzureRGObject                                           # Breaks :RemoveAzureRGObject
                    }                                                                       # End if ($LocksRemoved -eq 'n')
                    Write-Host 'All Locks removed'                                          # Write message to screen
                }                                                                           # End if ($Locks)
                else {                                                                      # If $Locks does not have a value
                    Write-Host 'No locks on this resource group'                            # Write message to screen
                }                                                                           # End if ($Locks)
                Write-Host $RGObject.ResourceGroupName'is being removed'                    # Write message to screen
                Write-Host 'this may take a while'                                          # Write message to screen
                Try {                                                                       # Try the following
                    Remove-AzResourceGroup -Name $RGObject.ResourceGroupName -Force `
                        -ErrorAction 'Stop' | Out-Null                                      # Removes the resource group
                }                                                                           # End Try
                Catch {                                                                     # If try fails
                    Clear-Host                                                              # Clears screen
                    Write-Host 'An error has occured'                                       # Write message to screen
                    Write-Host 'The resource group was not removed'                         # Write message to screen
                    Write-Host 'You may not have the permssions to complete this action'    # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Break RemoveAzureRGObject                                               # Break RemoveAzureRGObject   
                }                                                                           # End catch
                Write-Host $RGObjectName'has been removed'                                  # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break RemoveAzureRGObject                                                   # Break RemoveAzureRGObject
            }                                                                               # End if ($OpConfirm -eq 'y')
            else {                                                                          # All other inputs for $OpConfirm
                Write-Host 'No changes have been made'                                      # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break RemoveAzureRGObject                                                   # Breaks :RemoveAzureRGObject
            }                                                                               # End else (if ($OpConfirm -eq 'y')
            
        }                                                                                   # End :RemoveAzureRGObject while ($True)
        Clear-Host                                                                          # Clears screen
        Return                                                                              # Returns to calling function with $null
    }                                                                                       # End begin statement
}                                                                                           # End function RemoveAzResourceGroup