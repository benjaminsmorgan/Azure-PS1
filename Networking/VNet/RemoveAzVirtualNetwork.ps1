# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Mircosoft docs links
    Remove-AzVirtualNetwork:    https://docs.microsoft.com/en-us/powershell/module/az.network/remove-azvirtualnetwork?view=azps-5.4.0
    Get-AzVirtualNetwork:       https://docs.microsoft.com/en-us/powershell/module/az.network/get-azvirtualnetwork?view=azps-5.4.0
} #>
<# Required Functions Links: {
    GetAzVirtualNetwork:        https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/VNet/GetAzVirtualNetwork.ps1
} #>
<# Functions Description: {
    RemoveAzVirtualNetwork:     Removes an azure virtual network
    GetAzVirtualNetwork:        Gets an azure virtual network
} #>
<# Variables: {
    :RemoveAzureVnet            Outer loop for managing function
    $CallingFunction:           Name of this function or the one that called it
    $VNetObject:                Virtual network object
    $OpConfirm:                 Operator confirmation to remove the Vnet
    GetAzVirtualNetwork{}       Gets $VNetObject 
} #>
<# Process Flow {
    Function
        Call RemoveAzVirtualNetwork > Get $null
            Call GetAzVirtualNetwork > Get $VNetObject
            End GetAzVirtualNetwork
                Return RemoveAzVirtualNetwork > Send $VNetObject
        End RemoveAzVirtualNetwork
            Return function > Send $null
}#>
function RemoveAzVirtualNetwork {                                                           # Function to remove an Azure virtual network
    Begin {                                                                                 # Being function
        if (!$CallingFunction) {                                                            # If $CallingFunction is $null
            $CallingFunction = 'RemoveAzVirtualNetwork'                                     # Creates $CallingFunction
        }                                                                                   # End if (!$CallingFunction)
        :RemoveAzureVnet while ($true) {                                                    # Outer loop for managing function
            $VNetObject = GetAzVirtualNetwork ($CallingFunction)                            # Calls function and assigns output to $var
            if (!$VNetObject) {                                                             # If $VNetObject is $null
                Break RemoveAzureVnet                                                       # Breaks :RemoveAzureVnet
            }                                                                               # End if (!$VNetObject)
            Write-Host 'Remove the following:'                                              # Write message to screen
            Write-Host 'virtual network name:'$VNetObject.Name                              # Write message to screen
            Write-Host 'resource group:      '$VNetObject.ResourceGroupName                 # Write message to screen
            $OpConfirm = Read-Host '[Y] Yes [N] No'                                         # Operator confirmation to remove the selected VNet
            Clear-Host                                                                      # Clears screen
            if ($OpConfirm -eq 'y') {                                                       # If $OpConfirm equals 'y'
                Try {                                                                       # Try the following
                    Write-Host 'Removing:'$VNetObject.name                                  # Write message to screen
                    Remove-AzVirtualNetwork -Name $VNetObject.Name -ResourceGroupName `
                        $VNetObject.ResourceGroupName -Force -ErrorAction 'Stop'            # Removes the virtual network
                }                                                                           # End Try
                Catch {                                                                     # If Try fails
                    Write-Host 'An error has occured'                                       # Write message to screen
                    Write-Host 'You may not have the'                                       # Write message to screen 
                    Write-Host 'required permissions'                                       # Write message to screen
                    Write-Host 'No changes have been made'                                  # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Break RemoveAzureVnet                                                   # Breaks :RemoveAzureVnet
                }                                                                           # End catch
                Write-Host 'The selected virtual network has been removed'                  # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break RemoveAzureVnet                                                       # Breaks :RemoveAzureVnet
            }                                                                               # End if ($OpConfirm -eq 'y')
            else {                                                                          # If $OpConfirm does not equal 'y'
                Write-Host 'No changes made'                                                # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break RemoveAzureVnet                                                       # Breaks :RemoveAzureVnet
            }                                                                               # End else (if ($OpConfirm -eq 'y'))
        }                                                                                   # End :RemoveAzureVnet while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function RemoveAzVirtualNetwork