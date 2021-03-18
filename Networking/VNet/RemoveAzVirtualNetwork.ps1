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
    $VNetObject:                Virtual network object
    $OperatorConfirm:           Operator confirmation to remove the Vnet
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
        :RemoveAzureVnet while ($true) {                                                    # Outer loop for managing function
            if (!$VNetObject) {                                                             # If $VNetObject is $null
                $VNetObject = GetAzVirtualNetwork                                           # Calls function and assigns output to $var
                if (!$VNetObject) {                                                         # If $VNetObject is $null
                    Break RemoveAzureVnet                                                   # Breaks :RemoveAzureVnet
                }                                                                           # End if (!$VNetObject)
            }                                                                               # End if (!$VNetObject)
            Write-Host 'Remove the virtual network named'$VNetObject.Name                   # Write message to screen
            Write-Host 'from the resource group'$VNetObject.ResourceGroupName               # Write message to screen
            $OperatorConfirm = Read-Host '[Y] or [N]'                                       # Operator confirmation to remove the selected VNet
            if ($OperatorConfirm -eq 'y') {                                                 # If $OperatorConfirm equals 'y'
                Try {                                                                       # Try the following
                    Remove-AzVirtualNetwork -Name $VNetObject.Name -ResourceGroupName `
                        $VNetObject.ResourceGroupName -Force -ErrorAction 'Stop'            # Removes the virtual network
                }                                                                           # End Try
                Catch {                                                                     # If Try fails
                    Write-Host 'An error has occured'                                       # Write message to screen
                    Write-Host 'You may not have the'                                       # Write message to screen 
                    Write-Host 'required permissions'                                       # Write message to screen
                    Write-Host 'No changes have been made'                                  # Write message to screen
                    Break RemoveAzureVnet                                                   # Breaks :RemoveAzureVnet
                }                                                                           # End catch
                Write-Host 'The selected virtual network has been removed'                  # Write message to screen
                Break RemoveAzureVnet                                                       # Breaks :RemoveAzureVnet
            }                                                                               # End if ($OperatorConfirm -eq 'y')
            else {                                                                          # If $OperatorConfirm does not equal 'y'
                Write-Host 'No changes made'                                                # Write message to screen
                Break RemoveAzureVnet                                                       # Breaks :RemoveAzureVnet
            }                                                                               # End else (if ($OperatorConfirm -eq 'y'))
        }                                                                                   # End :RemoveAzureVnet while ($true)
        Return                                                                              # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function RemoveAzVirtualNetwork