# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Microsoft docs links
    Start-AzVM:                 https://docs.microsoft.com/en-us/powershell/module/az.compute/Start-azvm?view=azps-5.4.0
    Get-AzVM:                   https://docs.microsoft.com/en-us/powershell/module/az.compute/get-azvm?view=azps-5.4.0
} #>
<# Required Functions Links: {
    GetAzVM:                    https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Compute/Azure%20VM/GetAzVM.ps1
} #>
<# Functions Description: {
    StartAzVM:                  Starts a VM object
    GetAzVM:                    Gets a VM object
} #>
<# Variables: {
    :StartAzureVM               Outer loop for managing function
    $CallingFunction:           Name of this function or the one that called it
    $VMObject:                  Virtual machine object
    $OpConfirm:                 Operator confirmation to Start the VM
} #>
<# Process Flow {
    Function
        Call StartAzVM > Get $null
            Call GetAzVM > Get $VMObject
            End GetAzVMWin
                Return StartAzVM > Send $VMObject
        End StartAzVM
            Return function > Send $null
}#>
function StartAzVM {                                                                        # Function to start a VM
    Begin {                                                                                 # Begin function
        if (!$CallingFunction) {                                                            # If $CallingFunction is $null
            $CallingFunction = 'StartAzVM'                                                  # Creates $CallingFunction
        }                                                                                   # End if (!$CallingFunction)
        :StartAzureVM while ($true) {                                                       # Outer loop for managing function
            $VMObject = GetAzVM ($CallingFunction)                                          # Calls function and assigns output to $var
            if (!$VMObject) {                                                               # If $VMObject is $null
                Break StartAzureVM                                                          # Breaks :StartAzureVM
            }                                                                               # End if (!$VMObject)
            Write-Host 'Power on:'$VMObject.name                                            # Write message to screen
            $OpConfirm = Read-Host '[Y] Yes [N] No'                                         # Operator confirmation to turn on the VM
            if ($OpConfirm -eq 'y') {                                                       # If $OpConfirm equals 'y'
                Try {                                                                       # Try the following
                    Write-Host 'Attempting to power on:'$VMObject.Name                      # Write message to screen
                    Start-AzVM -Name $VMObject.Name -ResourceGroup `
                    $VMObject.ResourceGroupName -ErrorAction 'Stop'                         # Starts the selected VM
                }                                                                           # End try
                Catch {                                                                     # If Try fails
                    Write-Host 'An error occured while'                                     # Write message to screen
                    Write-Host 'attempting to power on the vm'                              # Write message to screen
                    Write-Host 'The VM may already be on'                                   # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Break StartAzureVM                                                      # Breaks :StartAzureVM
                }                                                                           # End catch
                Write-Host $VMObject.Name 'has been powered on'                             # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break StartAzureVM                                                          # Breaks :StartAzureVM
            }                                                                               # End if ($OpConfirm -eq 'y')
            else {                                                                          # All other inputs for $OpConfirm
                Write-Host 'No action taken'                                                # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break StartAzureVM                                                          # Breaks :StartAzureVM
            }                                                                               # End else (if ($OpConfirm -eq 'y'))                                                                
        }                                                                                   # End :StartAzureVM while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function StartAzVM