# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Microsoft docs links
    Remove-AzNetworkInterfaceIPConfig:          https://docs.microsoft.com/en-us/powershell/module/az.network/Remove-aznetworkinterfaceipconfig?view=azps-5.6.0
    Set-AzNetworkInterface:                     https://docs.microsoft.com/en-us/powershell/module/az.network/set-aznetworkinterface?view=azps-5.6.0
    Get-AzNetworkInterface:                     https://docs.microsoft.com/en-us/powershell/module/az.network/get-aznetworkinterface?view=azps-5.4.0
    Set-AzNetworkInterfaceIPConfig:             https://docs.microsoft.com/en-us/powershell/module/az.network/set-aznetworkinterfaceipconfig?view=azps-5.6.0
} #>
<# Required Functions Links: {
    GetAzNICIpConfig:           https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/NIC/GetAzNICIpConfig.ps1     
} #>
<# Functions Description: {
    RemoveAzNICIpConfig:        Removes a network interface config
    GetAzNICIpConfig:           Gets a network interface IP config
} #>
<# Variables: {      
    :RemoveAzureNICIpConfig     Outer loop for managing function
    $CallingFunction:           Name of this function or the one that called it
    $NicIPConfigObject:         NIC IP configuration object
    $NicObject:                 Network interface object
    $OpConfirm:                 Operator confirmation to remove the IP configuration
    GetAzNICIpConfig{}          Gets $NicIPConfigObject, $NicObject
} #>
<# Process Flow {
    function
        Call RemoveAzNICIpConfig > Get $null
            Call GetAzNICIpConfig > Get $NicIPConfigObject, $NicObject
            End GetAzNICIpConfig
                Return RemoveAzNICIpConfig > Send $NicIPConfigObject, $NicObject
        End RemoveAzNICIpConfig
            Return function > Send $null
}#>
function RemoveAzNICIpConfig {                                                              # Function to Remove a NIC IP config
    Begin {                                                                                 # Begin function
        if (!$CallingFunction) {                                                            # If $CallingFunction is $null
            $CallingFunction = 'RemoveAzNICIpConfig'                                        # Creates $CallingFunction
        }                                                                                   # End if (!$CallingFunction)
        :RemoveAzureNICIpConfig while($true) {                                              # Outer loop for managing function
            $NicIPConfigObject,$NicObject = GetAzNICIpConfig ($CallingFunction)             # Calls function and assigns output to $vars
            if (!$NicIPConfigObject) {                                                      # If $NicIPConfigObject is $null
                Break RemoveAzureNICIpConfig                                                # Breaks :RemoveAzureNICIpConfig
            }                                                                               # End if (!$NicIPConfigObject) 
            if ($NICIPConfigObject.Primary -eq 'true') {                                    # If $NICIPConfigObject.Primary equals 'true'
                Write-Host ''                                                               # Write message to screen
                Write-Host 'This config is primary and cannot be removed'                   # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break RemoveAzureNICIpConfig                                                # Breaks :RemoveAzureNICIpConfig
            }                                                                               # End if ($NICIPConfigObject.Primary -eq 'true')
            Write-Host 'Remove the following:'                                              # Write message to screen
            Write-Host ''                                                                   # Write message to screen 
            Write-Host 'Config:'$NicIPConfigObject.name                                     # Write message to screen
            Write-Host 'NIC:   '$NicObject.Name                                             # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            $OpConfirm = Read-Host '[Y] Yes [N] No'                                         # Operator confirmation to remove the public IP sku
            Clear-Host                                                                      # Clears screen
            if ($OpConfirm -ne 'y') {                                                       # If $OpConfirm does not equal 'y'
                Write-Host 'No changes have been made'                                      # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break RemoveAzureNICIpConfig                                                # Breaks :RemoveAzureNICIpConfig
            }                                                                               # End if ($OpConfirm -ne 'y')
            Try {                                                                           # Try the following
                Write-Host 'Removing the IP configuration'                                  # Write message to screen
                Remove-AzNetworkInterfaceIpConfig -Name $NicIPConfigObject.Name `
                    -NetworkInterface $NicObject -ErrorAction 'Stop' | Out-Null             # Removes the selected configuration
                $NicObject | Set-AzNetworkInterface  -ErrorAction 'Stop' | Out-Null         # Saves the settings
            }                                                                               # End try
            Catch {                                                                         # If try fails
                Clear-Host                                                                  # Clears host
                Write-Host 'An error has occured'                                           # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Write-Host 'You may not have the permissions'                               # Write message to screen
                Write-Host 'to complete this action or'                                     # Write message to screen
                Write-Host 'the resource or resource group'                                 # Write message to screen
                Write-Host 'may be locked preventing changes'                               # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break RemoveAzureNICIpConfig                                                # Breaks RemoveAzureNICIpConfig
            }                                                                               # End catch            
            Clear-Host                                                                      # Clears host                                                          
            Write-Host 'The IP configuration has been removed'                              # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            Pause                                                                           # Pauses all actions for operator input
            Break RemoveAzureNICIpConfig                                                    # Breaks RemoveAzureNICIpConfig
        }                                                                                   # End :RemoveAzureNICIpConfig while($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function RemoveAzNICIpConfig