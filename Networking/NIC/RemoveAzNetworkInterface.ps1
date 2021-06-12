# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Mircosoft docs links
    Remove-AzNetworkInterface:                  https://docs.microsoft.com/en-us/powershell/module/az.network/remove-aznetworkinterface?view=azps-5.6.0
    Get-AzNetworkInterface:                     https://docs.microsoft.com/en-us/powershell/module/az.network/get-aznetworkinterface?view=azps-5.4.0
} #>
<# Required Functions Links: {
    GetAzNetworkInterface:      https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/NIC/GetAzNetworkInterface.ps1
} #>
<# Functions Description: {
    RemoveAzNetworkInterface:   Removes a network interface   
    GetAzNetworkInterface:      Gets an existing network interface
} #>
<# Variables: {
    :RemoveAzureNic             Outer loop for managing function
    $NicObject:                 Network interface object
    $VM:                        $NicObject.VirtualMachine if present
    $CallingFunction:           Name of the current function
    $OpConfirm:                 Operator confirmation for removing the nic
    GetAzNetworkInterface{}     Get $NicObject
} #>
<# Process Flow {
    Function
        Call RemoveAzNetworkInterface > Get $null
            Call GetAzNetworkInterface > Get $NicObject,$SubnetObject,$VnetObject
            End GetAzNetworkInterface
                Return RemoveAzNetworkInterface > Send $NicObject,$SubnetObject,$VnetObject
        End RemoveAzNetworkInterface
            Return function > Send $null
}#>
function RemoveAzNetworkInterface {                                                         # Function to remove a network interface
    Begin {                                                                                 # Begin function
        :RemoveAzureNic while ($true) {                                                     # Outer loop for managing function
            if (!$NicObject) {                                                              # If $NicObject does not have a value
                $CallingFunction = 'RemoveAzNetworkInterface'                               # Sets $CallingFunction
                $NicObject,$SubnetObject,$VnetObject = `
                    GetAzNetworkInterface ($CallingFunction)                                # Calls function and assigns output to $var
                if (!$NicObject) {                                                          # If $NicObject does not have a value
                    Break RemoveAzureNic                                                    # Breaks :RemoveAzureNic
                }                                                                           # End if (!$NicObject)
            }                                                                               # End if (!$NicObject)
            If ($NicObject.VirtualMachine) {                                                # If $NicObject.VirtualMachine has a value
                $VM = $NicObject.VirtualMachine.Id                                          # Pulls the VM info into $VM
                $VM = $VM.Split('/')[-1]                                                    # Isolates the attached VM name
                Write-Host 'The selected NIC is attached to:'$VM                            # Write message to screen
                Write-Host 'Unable to delete the NIC while attached'                        # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break RemoveAzureNic                                                        # Breaks :RemoveAzureNic
            }                                                                               # End If ($NicObject.VirtualMachine)
            Write-Host 'Remove the NIC:'$NicObject.name                                     # Write message to screen
            Write-Host 'Resource group:'$NicObject.ResourceGroupName                        # Write message to screen
            $OpConfirm = Read-Host '[Y] Yes [N] No'                                         # Operator confirmation to remove the Nic
            if ($OpConfirm -eq 'y') {                                                       # If $OpConfirm equals 'y;
                Try {                                                                       # Try the following
                    Remove-AzNetworkInterface -Name $NicObject.Name -ResourceGroupName `
                        $NicObject.ResourceGroupName -Force -ErrorAction 'Stop'             # Removes the selected NIC
                }                                                                           # End try
                Catch {                                                                     # If try fails
                    Write-Host 'An error has occured'                                       # Write message to screen
                    Write-Host 'No changes have been made'                                  # Write message to screen
                    Break RemoveAzureNic                                                    # Breaks :RemoveAzureNic
                }                                                                           # End catch
                Write-Host 'The selected Nic has been removed'                              # Write message to screen
                Break RemoveAzureNic                                                        # Breaks :RemoveAzureNic
            }                                                                               # End if ($OpConfirm -eq 'y')
            else {                                                                          # All other inputs for $OpConfirm
                Break RemoveAzureNic                                                        # Breaks :RemoveAzureNic
            }                                                                               # End else (If ($OpConfirm -eq 'y'))
        }                                                                                   # End :RemoveAzureNic while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function RemoveAzNetworkInterface