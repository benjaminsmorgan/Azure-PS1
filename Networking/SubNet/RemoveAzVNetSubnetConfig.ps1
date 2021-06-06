# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Mircosoft docs links
    Remove-AzVirtualNetworkSubnetConfig: https://docs.microsoft.com/en-us/powershell/module/az.network/remove-azvirtualnetworksubnetconfig?view=azps-5.6.0
    GetAzNetworkInterface:      https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/NIC/GetAzNetworkInterface.ps1
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
    $NICList:                   List of all NICs if present
    $OpConfirm:                 Operator confirmation to remove the subnet
} #>
<# Process Flow {
    Function
        Call RemoveAzVNetSubnetConfig > Get $null
            Call GetAzVNetSubnetConfig > Get $SubnetObject
            End GetAzVNetSubnetConfig
                Return RemoveAzVNetSubnetConfig > Send $SubnetObject, $VNetObject
        End RemoveAzVNetSubnetConfig
            Return function > Send $null
}#>
function RemoveAzVNetSubnetConfig {                                                         # Function to remove a subnet
    Begin {                                                                                 # Begin function
        :RemoveAzureSubnet while ($true) {                                                  # Outer loop for managing function
            $SubnetObject, $VNetObject = GetAzVNetSubnetConfig                              # Call function and assign output to $var
            if (!$SubnetObject) {                                                           # If $SubnetObject is $null
                Break RemoveAzureSubnet                                                     # Breaks :RemoveAzureSubnet
            }                                                                               # End if (!$SubnetObject)
            $NICList = Get-AzNetworkInterface | Where-Object `
                {$_.IpConfigurations.Subnet.ID -eq $SubnetObject.ID}                        # Gets a list of all NICs on this subnet if present
            if ($NICList) {                                                                 # If $NICList has a value
                Write-Host 'This subnet cannot be deleted'                                  # Write message to screen
                Write-Host 'until all NICs are removed from it'                             # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break RemoveAzureSubnet                                                     # Breaks :RemoveAzureSubnet
            }                                                                               # End if ($NICList)
            Write-Host 'Remove Subnet: '$SubnetObject.Name                                  # Write message to screen
            Write-Host 'From VNet:     '$VNetObject.Name                                    # Write message to screen
            $OpConfirm = Read-Host '[Y] Yes [N] No'                                         # Operator confirmation for removing the subnet
            Clear-Host                                                                      # Clears screen
            if ($OpConfirm -eq 'y') {                                                       # If $OpConfirm equals 'y'
                Try {                                                                       # Try the following
                    Write-Host 'Removing subnet:'$SubnetObject.Name                         # Write message to screen
                    Remove-AzVirtualNetworkSubnetConfig -Name $SubnetObject.Name `
                        -VirtualNetwork $VNetObject | Set-AzVirtualNetwork `
                        -ErrorAction 'Stop'                                                 # Removes the subnet
                }                                                                           # End try
                catch {                                                                     # If try fails
                    Clear-Host                                                              # Clears screen
                    write-Host 'An error has occured'                                       # Write message to screen
                    Write-Host 'No changes have been made'                                  # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Break RemoveAzureSubnet                                                 # Breaks :RemoveAzureSubnet
                }                                                                           # End catch
                Clear-Host                                                                  # Clears screen
                Write-Host 'The subnet:'$SubnetObject.Name' has been removed'               # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break RemoveAzureSubnet                                                     # Breaks :RemoveAzureSubnet
            }                                                                               # End if ($OpConfirm -eq 'y') 
            else {                                                                          # If $OpConfirm does not equal 'y'
                Clear-Host                                                                  # Clears screen
                Write-Host 'No changes have been made'                                      # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break RemoveAzureSubnet                                                     # Breaks :RemoveAzureSubnet
            }                                                                               # End else (if ($OpConfirm -eq 'y'))
        }                                                                                   # End :RemoveAzureSubnet while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function RemoveAzVNetSubnetConfig