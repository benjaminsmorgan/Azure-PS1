# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Microsoft docs links
    Stop-AzVM:                  https://docs.microsoft.com/en-us/powershell/module/az.compute/stop-azvm?view=azps-5.4.0
    Get-AzVM:                   https://docs.microsoft.com/en-us/powershell/module/az.compute/get-azvm?view=azps-5.4.0
} #>
<# Required Functions Links: {
    GetAzVM:                    https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Compute/Azure%20VM/GetAzVM.ps1
} #>
<# Functions Description: {
    StopAzVM:                   Stops a VM object
    GetAzVM:                    Gets a VM object
} #>
<# Variables: {
    :StopAzureVM                Outer loop for managing function
    $CallingFunction:           Name of this function or the one that called it
    $VMObject:                  Virtual machine object
    $OperatorConfirm:           Operator confirmation to stop the VM
    
} #>
<# Process Flow {
    Function
        Call StopAzVM > Get $null
            Call GetAzVM > Get $VMObject
            End GetAzVMWin
                Return StopAzVM > Send $VMObject
        End StopAzVM
            Return function > Send $null
}#>
function StopAzVM {                                                                         # Function to deallocate a VM
    Begin {                                                                                 # Begin function
        if (!$CallingFunction) {                                                            # If $CallingFunction is $null
            $CallingFunction = 'StopAzVM'                                                   # Creates $CallingFunction
        }                                                                                   # End if (!$CallingFunction)
        :StopAzureVM while ($true) {                                                        # Outer loop for managing function
            $VMObject = GetAzVM ($CallingFunction)                                          # Calls function and assigns output to $var
            if (!$VMObject) {                                                               # If $VMObject is $null
                Break StopAzureVM                                                           # Breaks :StopAzureVM
            }                                                                               # End if (!$VMObject)
            Write-Host 'Power off:'$VMObject.name                                           # Write message to screen
            $OpConfirm = Read-Host '[Y] Yes [N] No'                                         # Operator confirmation to turn off the VM
            if ($OpConfirm -eq 'y') {                                                       # If $OpConfirm equals 'y'
                Try {                                                                       # Try the following
                    Write-Host 'Attempting to power off:'$VMObject.Name                     # Write message to screen
                    Stop-AzVM -Name $VMObject.Name -ResourceGroup `
                    $VMObject.ResourceGroupName -force -ErrorAction 'Stop'                  # Stops the selected VM
                }                                                                           # End try
                Catch {                                                                     # If Try fails
                    Write-Host 'An error occured while'                                     # Write message to screen
                    Write-Host 'attempting to power off the vm'                             # Write message to screen
                    Write-Host 'The VM may already be off'                                  # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Break StopAzureVM                                                       # Breaks :StopAzureVM
                }                                                                           # End catch
                Write-Host $VMObject.Name 'has been powered off'                            # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break StopAzureVM                                                           # Breaks :StopAzureVM
            }                                                                               # End if ($OpConfirm -eq 'y')
            else {                                                                          # All other inputs for $OpConfirm
                Write-Host 'No action taken'                                                # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break StopAzureVM                                                           # Breaks :StopAzureVM
            }                                                                               # End else (if ($OpConfirm -eq 'y'))
        }                                                                                   # End :StopAzureVM while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function StopAzVM