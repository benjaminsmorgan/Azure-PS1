# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Microsoft docs links
    Set-AzNetworkInterface:                     https://docs.microsoft.com/en-us/powershell/module/az.network/set-aznetworkinterface?view=azps-6.2.1
    Get-AzNetworkInterface:                     https://docs.microsoft.com/en-us/powershell/module/az.network/get-aznetworkinterface?view=azps-5.4.0
    Get-AzVirtualNetworkSubnetConfig:           https://docs.microsoft.com/en-us/powershell/module/az.network/get-azvirtualnetworksubnetconfig?view=azps-5.4.0
    Get-AzVirtualNetwork:                       https://docs.microsoft.com/en-us/powershell/module/az.network/get-azvirtualnetwork?view=azps-5.4.0
    Get-AzVM:                                   https://docs.microsoft.com/en-us/powershell/module/az.compute/get-azvm?view=azps-6.2.1
    Get-AzVmss:                                 https://docs.microsoft.com/en-us/powershell/module/az.compute/get-azvmss?view=azps-6.1.0
} #>
<# Required Functions Links: {
    GetAzNetworkInterface:      https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/NIC/GetAzNetworkInterface.ps1
} #>
<# Functions Description: {
    RemoveAzNSGNIC:             Function to remove a NSG from NIC
    GetAzNetworkInterface:      Function to get a network interface
} #>
<# Variables: {      
    :RemoveAzureNSGNic          Outer loop for managing function
    $CallingFunction:           Name of this function or the one that called it
    $NicObject:                 Nic object
    $SubnetObject:              Subnet object (Unused)
    $VnetObject:                Virtual network object (Unused)
    $CurrentNSG:                Current network support group
    $OpConfirm:                 Operator confirmation to make the change
    GetAzNetworkInterface{}     Gets $NicObject, $SubnetObject, $VnetObject
} #>
<# Process Flow {
    function
        Call RemoveAzNSGNIC > Get $null
            Call GetAzNetworkInterface > Get $NicObject, $SubnetObject, $VnetObject
            End GetAzNetworkInterface
                Return RemoveAzNSGNIC > Send $NicObject, $SubnetObject, $VnetObject
        End RemoveAzNSGNIC
            Return function > Send $null
}#>
function RemoveAzNSGNIC {                                                                   # Function to remove a NSG from NIC
    Begin {                                                                                 # Begin function
        if ($CallingFunction) {                                                             # If $CallingFunction is $null
            $CallingFunction = 'RemoveAzNSGNIC'                                             # Creates $CallingFunction
        }                                                                                   # End if ($CallingFunction)
        :RemoveAzureNSGNic while ($true) {                                                  # Outer loop for managing function
            $NicObject,$SubnetObject,$VnetObject = GetAzNetworkInterface ($CallingFunction) # Calls function and assigns output to $vars
            if (!$NicObject) {                                                              # If $NicObject is $null
                Break RemoveAzureNSGNic                                                     # Breaks :RemoveAzureNSGNic
            }                                                                               # End if (!$NicObject) 
            if ($NicObject.NetworkSecurityGroup.ID) {                                       # If $NicObject.NetworkSecurityGroup.ID has a value
                $CurrentNSG = $NicObject.NetworkSecurityGroup.ID                            # Isolates the current NSG ID
                $CurrentNSG = $CurrentNSG.Split('/')[-1]                                    # Isolates the current NSG name
                Write-Host 'Remove:  '$CurrentNSG                                           # Write message to screen
                Write-Host 'From NIC:'$NicObject.name                                       # Write message to screen
                Write-Host ''                                                               # Write message to screen
            }                                                                               # End if ($NicObject.NetworkSecurityGroup.ID)
            else {                                                                          # Else if $NicObject.NetworkSecurityGroup.ID is $null
                Write-Host 'No NSG associated to:'$NicObject.name                           # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break RemoveAzureNSGNic                                                     # Breaks :RemoveAzureNSGNic
            }                                                                               # End else (if ($NicObject.NetworkSecurityGroup.ID) )
            $OpConfirm = Read-Host '[Y] Yes [N] No'                                         # Operator confirmation to add the NSG to the NIC
            Clear-Host                                                                      # Clears screen
            if ($OpConfirm -eq 'y') {                                                       # If $OpConfirm equals 'y'
                Try {                                                                       # Try the following
                    Write-Host 'Updating the NIC config'                                    # Write message to screen
                    $NicObject.NetworkSecurityGroup = $null                                 # Removes $NSGObject to $NICObject
                    Write-Host 'Saving the NIC config'                                      # Write message to screen
                    $NicObject | Set-AzNetworkInterface -ErrorAction 'Stop' | Out-null      # Saves $NicObject
                }                                                                           # End Try
                Catch {                                                                     # If Try fails
                    Clear-Host                                                              # Clears screen
                    Write-Host 'An error has occured'                                       # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Break RemoveAzureNSGNic                                                 # Breaks :RemoveAzureNSGNic
                }                                                                           # End Catch
                Clear-Host                                                                  # Clears screen
                Write-Host 'The NSG has been removed from the NIC'                          # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break RemoveAzureNSGNic                                                     # Breaks :RemoveAzureNSGNic
            }                                                                               # End if ($OpConfirm -eq 'y')
            else {                                                                          # All other inputs for $OpConfirm
                Write-Host 'No changes have been made'                                      # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break RemoveAzureNSGNic                                                     # Breaks :RemoveAzureNSGNic
            }                                                                               # End if ($OpConfirm -eq 'y')
        }                                                                                   # End :RemoveAzureNSGNic while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function RemoveAzNSGNIC