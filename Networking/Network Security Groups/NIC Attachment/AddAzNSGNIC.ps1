# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Microsoft docs links
    Set-AzNetworkInterface:                     https://docs.microsoft.com/en-us/powershell/module/az.network/set-aznetworkinterface?view=azps-6.2.1
    Get-AzNetworkSecurityGroup:                 https://docs.microsoft.com/en-us/powershell/module/az.network/get-aznetworksecuritygroup?view=azps-6.2.1
    Get-AzNetworkInterface:                     https://docs.microsoft.com/en-us/powershell/module/az.network/get-aznetworkinterface?view=azps-5.4.0
    Get-AzVirtualNetworkSubnetConfig:           https://docs.microsoft.com/en-us/powershell/module/az.network/get-azvirtualnetworksubnetconfig?view=azps-5.4.0
    Get-AzVirtualNetwork:                       https://docs.microsoft.com/en-us/powershell/module/az.network/get-azvirtualnetwork?view=azps-5.4.0
    Get-AzVM:                                   https://docs.microsoft.com/en-us/powershell/module/az.compute/get-azvm?view=azps-6.2.1
    Get-AzVmss:                                 https://docs.microsoft.com/en-us/powershell/module/az.compute/get-azvmss?view=azps-6.1.0
} #>
<# Required Functions Links: {
    GetAzNSG:                   https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/Network%20Security%20Groups/GetAzNSG.ps1
    GetAzNetworkInterface:      https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/NIC/GetAzNetworkInterface.ps1
} #>
<# Functions Description: {
    AddAzNSGNIC:                Function to add a NSG to NIC
    GetAzNSG:                   Function to get a network security group
    GetAzNetworkInterface:      Function to get a network interface
} #>
<# Variables: {      
    :AddAzureNSGNic             Outer loop for managing function
    $CallingFunction:           Name of this function or the one that called it
    $NSGObject:                 Network security group
    $NicObject:                 Nic object
    $SubnetObject:              Subnet object (Unused)
    $VnetObject:                Virtual network object (Unused)
    $CurrentNSG:                Current network support group
    $OpConfirm:                 Operator confirmation to make the change
    GetAzNSG{}                  Gets $NSGObject
    GetAzNetworkInterface{}     Gets $NicObject, $SubnetObject, $VnetObject
} #>
<# Process Flow {
    function
        Call AddAzNSGNIC > Get $null
            Call GetAzNSG > Get $NSGObject
            End GetAzNSG
                Return AddAzNSGNIC > Send $NSGObject
            Call GetAzNetworkInterface > Get $NicObject, $SubnetObject, $VnetObject
            End GetAzNetworkInterface
                Return AddAzNSGNIC > Send $NicObject, $SubnetObject, $VnetObject
        End AddAzNSGNIC
            Return function > Send $null
}#>
function AddAzNSGNIC {                                                                      # Function to add a NSG to NIC
    Begin {                                                                                 # Begin function
        if ($CallingFunction) {                                                             # If $CallingFunction is $null
            $CallingFunction = 'AddAzNSGNIC'                                                # Creates $CallingFunction
        }                                                                                   # End if ($CallingFunction)
        :AddAzureNSGNic while ($true) {                                                     # Outer loop for managing function
            $NSGObject = GetAzNSG ($CallingFunction)                                        # Calls function and assigns output to $var
            if (!$NSGObject) {                                                              # If $NSGObject is $null
                Break AddAzureNSGNic                                                        # Breaks :AddAzureNSGNic
            }                                                                               # End if (!$NSGObject) 
            $NicObject,$SubnetObject,$VnetObject = GetAzNetworkInterface ($CallingFunction) # Calls function and assigns output to $vars
            if (!$NicObject) {                                                              # If $NicObject is $null
                Break AddAzureNSGNic                                                        # Breaks :AddAzureNSGNic
            }                                                                               # End if (!$NicObject) 
            if ($NicObject.NetworkSecurityGroup.ID) {                                       # If $NicObject.NetworkSecurityGroup.ID has a value
                $CurrentNSG = $NicObject.NetworkSecurityGroup.ID                            # Isolates the current NSG ID
                $CurrentNSG = $CurrentNSG.Split('/')[-1]                                    # Isolates the current NSG name
                Write-Host 'Replace:'$CurrentNSG                                            # Write message to screen
                Write-Host 'With:   '$NSGObject.name                                        # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Write-Host 'On NIC: '$NicObject.name                                        # Write message to screen
                Write-Host ''                                                               # Write message to screen
            }                                                                               # End if ($NicObject.NetworkSecurityGroup.ID)
            else {                                                                          # Else if $NicObject.NetworkSecurityGroup.ID is $null
                Write-Host 'Add:'$NSGObject.name                                            # Write message to screen
                Write-Host 'To: '$NicObject.name                                            # Write message to screen
                Write-Host ''                                                               # Write message to screen
            }                                                                               # End else (if ($NicObject.NetworkSecurityGroup.ID) )
            $OpConfirm = Read-Host '[Y] Yes [N] No'                                         # Operator confirmation to add the NSG to the NIC
            Clear-Host                                                                      # Clears screen
            if ($OpConfirm -eq 'y') {                                                       # If $OpConfirm equals 'y'
                Try {                                                                       # Try the following
                    Write-Host 'Updating the NIC config'                                    # Write message to screen
                    $NicObject.NetworkSecurityGroup = $NSGObject                            # Assigns $NSGObject to $NICObject
                    Write-Host 'Saving the NIC config'                                      # Write message to screen
                    $NicObject | Set-AzNetworkInterface -ErrorAction 'Stop' | Out-null      # Saves $NicObject
                }                                                                           # End Try
                Catch {                                                                     # If Try fails
                    Clear-Host                                                              # Clears screen
                    Write-Host 'An error has occured'                                       # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Break AddAzureNSGNic                                                    # Breaks :AddAzureNSGNic
                }                                                                           # End Catch
                Clear-Host                                                                  # Clears screen
                Write-Host 'The NSG has been added to the NIC'                              # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break AddAzureNSGNic                                                        # Breaks :AddAzureNSGNic
            }                                                                               # End if ($OpConfirm -eq 'y')
            else {                                                                          # All other inputs for $OpConfirm
                Write-Host 'No changes have been made'                                      # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break AddAzureNSGNic                                                        # Breaks :AddAzureNSGNic
            }                                                                               # End if ($OpConfirm -eq 'y')
        }                                                                                   # End :AddAzureNSGNic while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function AddAzNSGNIC