# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Mircosoft docs links
    Remove-AzDisk:              https://docs.microsoft.com/en-us/powershell/module/az.compute/remove-azdisk?view=azps-5.4.0
    Get-AzDisk:                 https://docs.microsoft.com/en-us/powershell/module/az.compute/get-azdisk?view=azps-5.4.0
} #>
<# Required Functions Links: {
    Get-AzDisk:                 https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Storage/Disks/GetAzDisk.ps1
} #>
<# Functions Description: {
    RemoveAzDisk:               Removes a disk object
    GetAzDisk:                  Collects disk object
} #>
<# Variables: {
    :RemoveAzureDisk            Outer loop for managing function
    $DiskObject:                Disk object
    $ConfirmDelete:             Operator confirmation to remove the disk
    GetAzDisk{}                 Gets $DiskObject
} #>
<# Process Flow {
    function
        Call RemoveAzDisk > Get $null
            Call GetAzDisk > Get $DiskObject
            End GetAzDisk
                Return RemoveAzDisk > Send $DiskObject
        End RemoveAzDisk 
            Return Function > Send $null
}#>
function RemoveAzDisk {                                                                     # Function to remove a disk object
    Begin {                                                                                 # Begin function
        :RemoveAzureDisk while ($true) {                                                    # Outer loop for managing function
            $DiskObject = GetAzDisk                                                         # Calls function and assigns output to $var
            if (!$DiskObject) {                                                             # If $DiskObject is $null
                Break RemoveAzureDisk                                                       # Breaks :RemoveAzureDisk
            }                                                                               # End if (!$DiskObject)
            Write-Host 'Remove disk:        '$DiskObject.Name                               # Write message to screen
            Write-Host 'from resource group:'$DiskObject.ResourceGroupName                  # Write message to screen
            $OpConfirm = Read-Host '[Y] Yes [N] No'                                         # Operator confirmation to delete the disk
            if ($OpConfirm -eq 'y') {                                                       # If $OpConfirm equals 'y'
                Clear-Host                                                                  # Clears screen
                Write-Host 'Deleting:'$DiskObject.Name                                      # Write message to screen
                Try {                                                                       # Try the following
                    Remove-AzDisk -ResourceGroupName $DiskObject.ResourceGroupName `
                        -DiskName $DiskObject.Name -Force -ErrorAction 'Stop'               # Removes selected disk
                }                                                                           # End Try
                Catch {                                                                     # If try fails
                    Clear-Host                                                              # Clears screen
                    Write-Host 'An error has occured'                                       # Write message to screen
                    Write-Host 'The disk may still be in use'                               # Write message to screen
                    Write-Host 'The resource group maybe locked'                            # Write message to screen
                    Write-Host 'You may not have the permissions to remove this disk'       # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Break RemoveAzureDisk                                                   # Breaks :RemoveAzureDisk
                }                                                                           # End catch
                Clear-Host                                                                  # Clears screen
                Write-Host 'The selected disk has been deleted'                             # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break RemoveAzureDisk                                                       # Breaks :RemoveAzureDisk
            }                                                                               # End if ($OpConfirm -eq 'y') 
            else {                                                                          # All other inputs for $OpSelect
                Write-Host 'No action taken'                                                # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break RemoveAzureDisk                                                       # Breaks :RemoveAzureDisk
            }                                                                               # End else (if ($OpConfirm -eq 'y'))
        }                                                                                   # End :RemoveAzureDisk while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin 
}                                                                                           # End function RemoveAzDisk