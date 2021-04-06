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
    $CallingFunction:           Name of this function1
    GetAzResourceGroup{}        Gets $RGObject
    GetAzRGLocksAll{}           Gets $Locks
    RemoveAzResourceLocks{}     Gets $LocksRemoved
} #>
<# Process Flow {
    Function
        Call ManageAzResourceGroup
            Call NewAzResourceGroup > Get $RGObject
                Call GetAzLocation > Get $LocationObject
                End GetAzLocation
                    Return NewAzResourceGroup > Send $LocationObject
            End NewAzResourceGroup
                Return ManageAzResourceGroup > Send $RGObject
            Call GetAzResourceGroup > Get $RGObject
            End GetAzResourceGroup
                Return ManageAzResourceGroup > Send $RGObject
            Call ListAzRGResources > Get $null
                Call GetAzResourceGroup > Get $RGObject
                End GetAzResourceGroup
                    Return ListAzRGResources > Send $RGObject
            End ListAzRGResources
                Return ManageAzResourceGroup > Send $null
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
        End Function ManageAzResourceGroup
                Return Function > Send $RGObject                                    
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
            Clear-Host                                                                      # Clears screen
            Write-Host "////////////////////////////WARNING\\\\\\\\\\\\\\\\\\\\\\\\\\\\"    # Write message to screen
            Write-Host `
                ""$RGObject.ResourceGroupName "will be deleted, this cannot be undone"      # Write message to screen
            Write-Host " All resource locks will be removed automatically if confirmed "    # Write message to screen
            Write-Host " All resources within the resource group will also be deleted  "    # Write message to screen
            Write-Host "\\\\\\\\\\\\\\\\\\\\\\\\\\\\WARNING////////////////////////////"    # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            Write-Host 'Delete this resource group'                                         # Write message to screen
            $OperatorConfirm = Read-Host '[Y] or [N]'                                       # Operator input on confirming deletion of the resource group
            $RGObjectName = $RGObject.ResourceGroupName                                     # Collects the name of the resource group for later use
            if ($OperatorConfirm -eq "Y") {                                                 # If $OperatorConfirm equals 'y'
                Write-Host "This resource group has been approved for deletion"             # Write message to screen
            }                                                                               # End if ($OperatorConfirm -eq 'Y')
            else {                                                                          # Else if $OperatorConfirm does not equal 'y'
                Break RemoveAzureRGObject                                                   # Breaks :RemoveAzureRGObject
            }                                                                               # End else (if ($OperatorConfirm -eq 'y')
            $Locks = $null                                                                  # Clears any previous use of $Locks
            $Locks = GetAzRGLocksAll ($RGObject)                                            # Calls function and assigns output to $vat
            if ($Locks) {                                                                   # If $Locks has a value
                Write-Host "Removing all locks"...                                          # Write message to screen
                $LocksRemoved = RemoveAzResourceLocks ($Locks)                              # Calls function
                if ($LocksRemoved -eq 'n') {                                                # If $LocksRemoved equals 'n'
                    Break RemoveAzureRGObject                                               # Breaks :RemoveAzureRGObject
                }                                                                           # End if ($LocksRemoved -eq 'n')
                Write-Host "Locks removed"                                                  # Write message to screen
            }                                                                               # End if ($Locks)
            Write-Host $RGObject.ResourceGroupName"is being removed, this may take a while" # Message write to screen
            Try {                                                                           # Try the following
                Remove-AzResourceGroup -Name $RGObject.ResourceGroupName -Force `
                    -ErrorAction 'Stop' | Out-Null                                          # Removes the resource group
            }                                                                               # End Try
            Catch {                                                                         # If try fails
                Write-Host 'An error has occured'                                           # Write message to screen
                Write-Host 'The resource group was not removed'                             # Write message to screen
                Write-Host 'You may not have the permssions to complete this action'        # Write message to screen
                Break RemoveAzureRGObject                                                   # Break RemoveAzureRGObject   
            }                                                                               # End catch
            Write-Host $RGObjectName'has been removed'                                      # Write message to screen
            Break RemoveAzureRGObject                                                       # Break RemoveAzureRGObject
        }                                                                                   # End :RemoveAzureRGObject while ($True)
        Start-Sleep(5)                                                                      # Pauses actions for 5 seconds
        Clear-Host                                                                          # Clears screen
        Return                                                                              # Returns to calling function with $null
    }                                                                                       # End begin statement
}                                                                                           # End function RemoveAzResourceGroup