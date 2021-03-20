# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Mircosoft docs links
    Remove-AzVirtualNetworkSubnetConfig: https://docs.microsoft.com/en-us/powershell/module/az.network/remove-azvirtualnetworksubnetconfig?view=azps-5.6.0
    Get-AzVirtualNetworkSubnetConfig: https://docs.microsoft.com/en-us/powershell/module/az.network/get-azvirtualnetworksubnetconfig?view=azps-5.4.0
    Get-AzVirtualNetwork:       https://docs.microsoft.com/en-us/powershell/module/az.network/get-azvirtualnetwork?view=azps-5.4.0
} #>
<# Required Functions Links: {
    GetAzVNetSubnetConfig:      https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/SubNet/GetAzVNetSubnetConfig.ps1
} #>
<# Functions Description: {
    RemoveAzVNetSubnetConfig:   Removes an azure virtual network subnet
    GetAzVNetSubnetConfig:      Gets an azure virtual network subnet
} #>
<# Variables: {
    :GetAzureSubnet             Outer loop for managing function
    $VNetObject:                The Vnet holding the selected subnet
    $SubnetObject:              The subnet object
    $OperatorConfirm:           Operator confirmation to remove the subnet
} #>
<# Process Flow {
    Function
        Call RemoveAzVNetSubnetConfig > Get $null
            Call GetAzVNetSubnetConfig > Get $SubnetObject
            End GetAzVNetSubnetConfig
                Return RemoveAzVNetSubnetConfig > Send $SubnetObject
        End RemoveAzVNetSubnetConfig
            Return function > Send $null
}#>
function RemoveAzVNetSubnetConfig {                                                         # Function to remove a subnet
    Begin {                                                                                 # Begin function
        :RemoveAzureSubnet while ($true) {                                                  # Outer loop for managing function
            if (!$SubnetObject) {                                                           # If $SubnetObject is $null
                $SubnetObject, $VNetObject = GetAzVNetSubnetConfig                          # Call function and assign output to $var
                if (!$SubnetObject) {                                                       # If $SubnetObject is $null
                    Break RemoveAzureSubnet                                                 # Breaks :RemoveAzureSubnet
                }                                                                           # End if (!$SubnetObject)
            }                                                                               # End if (!$SubnetObject)
            Write-Host 'Remove the subnet'$SubnetObject.Name                                # Write message to screen
            $OperatorConfirm = Read-Host '[Y] or [N]'                                       # Operator confirmation for removing the subnet
            if ($OperatorConfirm -eq 'y') {                                                 # If $OperatorConfirm equals 'y'
                Try {                                                                       # Try the following
                    Remove-AzVirtualNetworkSubnetConfig -Name $SubnetObject.Name `
                        -VirtualNetwork $VNetObject | Set-AzVirtualNetwork `
                        -ErrorAction 'Stop'                                                 # Removes the subnet
                }                                                                           # End try
                catch {                                                                     # If try fails
                    write-Host 'An error has occured'                                       # Write message to screen
                    Write-Host 'No changes have been made'                                  # Write message to screen
                    Break RemoveAzureSubnet                                                 # Breaks :RemoveAzureSubnet
                }                                                                           # End catch
                Write-Host 'The subnet has been removed'                                    # Write message to screen
                Break RemoveAzureSubnet                                                     # Breaks :RemoveAzureSubnet
            }                                                                               # End if ($OperatorConfirm -eq 'y') 
            else {                                                                          # If $OperatorConfirm does not equal 'y'
                Break RemoveAzureSubnet                                                     # Breaks :RemoveAzureSubnet
            }                                                                               # End else (if ($OperatorConfirm -eq 'y'))
        }                                                                                   # End :RemoveAzureSubnet while ($true)
        Return                                                                              # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function RemoveAzVNetSubnetConfig