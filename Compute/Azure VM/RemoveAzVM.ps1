# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Microsoft docs links
    Remove-AzVM:                https://docs.microsoft.com/en-us/powershell/module/az.compute/Remove-azvm?view=azps-5.4.0
    Get-AzVM:                   https://docs.microsoft.com/en-us/powershell/module/az.compute/get-azvm?view=azps-5.4.0
} #>
<# Required Functions Links: {
    GetAzVM:                    https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Compute/Azure%20VM/GetAzVM.ps1
} #>
<# Functions Description: {
    RemoveAzVM:                 Removes a VM object
    GetAzVM:                    Gets a VM object
} #>
<# Variables: {
    :RemoveAzureVM              Outer loop for managing function
    $CallingFunction:           Name of this function or the one that called it
    $VMObject:                  Virtual machine object
    $OpConfirm:                 Operator confirmation to remove the VM
    
} #>
<# Process Flow {
    Function
        Call RemoveAzVM > Get $null
            Call GetAzVM > Get $VMObject
            End GetAzVMWin
                Return RemoveAzVM > Send $VMObject
        End RemoveAzVM
            Return function > Send $null
}#>
function RemoveAzVM {                                                                       # Function to remove a VM
    Begin {                                                                                 # Begin function
        if (!$CallingFunction) {                                                            # If $CallingFunction is $null
            $CallingFunction = 'RemoveAzVM'                                                 # Creates $CallingFunction
        }                                                                                   # End if (!$CallingFunction)
        :RemoveAzureVM while ($true) {                                                      # Outer loop for managing function
            $VMObject = GetAzVM ($CallingFunction)                                          # Calls function and assigns output to $var
            if (!$VMObject) {                                                               # If $VMObject is $null
                Break RemoveAzureVM                                                         # Breaks :RemoveAzureVM
            }                                                                               # End if (!$VMObject)
            Write-Host 'Remove:'$VMObject.name                                              # Write message to screen
            $OpConfirm = Read-Host '[Y] Yes [N] No'                                         # Operator confirmation to turn on the VM
            if ($OpConfirm -eq 'y') {                                                       # If $OpConfirm equals 'y'
                Try {                                                                       # Try the following
                    Write-Host 'Attempting to remove:'$VMObject.Name                        # Write message to screen
                    Remove-AzVM -Name $VMObject.Name -ResourceGroup `
                    $VMObject.ResourceGroupName -Force -ErrorAction 'Stop'                  # Removes the selected VM
                }                                                                           # End try
                Catch {                                                                     # If Try fails
                    Write-Host 'An error occured while'                                     # Write message to screen
                    Write-Host 'attempting to remove the vm'                                # Write message to screen
                    Write-Host 'The VM or resource group'                                   # Write message to screen
                    Write-Host 'Maybe locked or you may'                                    # Write message to screen
                    Write-Host 'not have the permissions'                                   # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Break RemoveAzureVM                                                     # Breaks :RemoveAzureVM
                }                                                                           # End catch
                Write-Host $VMObject.Name 'has been removed'                                # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break RemoveAzureVM                                                         # Breaks :RemoveAzureVM
            }                                                                               # End if ($OpConfirm -eq 'y')
            else {                                                                          # All other inputs for $OpConfirm
                Write-Host 'No action taken'                                                # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break RemoveAzureVM                                                         # Breaks :RemoveAzureVM
            }                                                                               # End else (if ($OpConfirm -eq 'y'))                                                                
        }                                                                                   # End :RemoveAzureVM while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function RemoveAzVM