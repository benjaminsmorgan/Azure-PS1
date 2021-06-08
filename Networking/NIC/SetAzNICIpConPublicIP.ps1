# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Mircosoft docs links
    Set-AzNetworkInterfaceIpConfig: https://docs.microsoft.com/en-us/powershell/module/az.network/set-aznetworkinterfaceipconfig?view=azps-6.0.0
    Get-AzPublicIpAddress:      https://docs.microsoft.com/en-us/powershell/module/az.network/get-azpublicipaddress?view=azps-5.5.0    
} #>
<# Required Functions Links: {
    GetAzNICIpConfig:           https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/NIC/GetAzNICIpConfig.ps1
    GetAzPublicIpAddress:       https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/Public%20IP/GetAzPublicIpAddress.ps1    
} #>
<# Functions Description: {
    SetAzNICIpConfigPublicIP:   Adds a public IP sku to a network interface config
} #>
<# Variables: {      
    :SetAzureNICIpConfig        Outer loop for managing function
    $CallingFunction:           Name of this function or the one that called it
    $NicIPConfigObject:         NIC IP configuration object
    $NicObject:                 Network interface object
    $PublicIPObject:            Public IP address sku
    GetAzNICIpConfig{}          Gets $NicIPConfigObject, $NicObject
    GetAzPublicIpAddress{}      Gets $PublicIPObject
} #>
<# Process Flow {
    function
        Call SetAzNICIpConfigPublicIP > Get $null
            Call GetAzNICIpConfig > Get $NicIPConfigObject, $NicObject
            End GetAzNICIpConfig
                Return SetAzNICIpConfigPublicIP > Send $NicIPConfigObject, $NicObject
            Call GetAzPublicIpAddress > Get $PublicIPObject
            End GetAzPublicIpAddress
                Return SetAzNICIpConfigPublicIP > Send $PublicIPObject
        End SetAzNICIpConfigPublicIP
            Return SetAzNICIpConfigPublicIP > Send $null
}#>
function SetAzNICIpConfigPublicIP {                                                         # Function to add a public IP sku to a network interface config
    Begin {                                                                                 # Begin function
        :SetAzureNICIpConfig while($true) {                                                 # Outer loop for managing function
            if (!$CallingFunction) {                                                        # If $CallingFunction is $null
                $CallingFunction = 'SetAzNICIpConfig'                                       # Creates $CallingFunction
            }                                                                               # End if (!$CallingFunction)
            $NicIPConfigObject,$NicObject = GetAzNICIpConfig                                # Calls function and assigns output to $vars
            if (!$NicIPConfigObject) {                                                      # If $NicIPConfigObject is $null
                Break SetAzureNICIpConfig                                                   # Breaks :SetAzureNICIpConfig
            }                                                                               # End if (!$NicIPConfigObject)
            $PublicIPObject = GetAzPublicIpAddress ($CallingFunction)                       # Calls function and assigns output to $var
            if (!$PublicIPObject) {                                                         # If $PublicIPObject is $null
                Break SetAzureNICIpConfig                                                   # Breaks :SetAzureNICIpConfig
            }                                                                               # End if (!$PublicIPObject)
            Try {                                                                           # Try the following
                $NicObject | Set-AzNetworkInterfaceIpConfig -Name $NicIPConfigObject.Name `
                    -PublicIpAddressId $PublicIPObject.ID -SubnetId `
                    $NicIPConfigObject.Subnet.ID -ErrorAction 'Stop'                        # Adds $PublicIPObject to $NicIPConfigObject
                $NicObject | Set-AzNetworkInterface -ErrorAction 'Stop'                     # Saves $NicObject config
            }                                                                               # End try
            catch {                                                                         # If try fails
                Write-Host 'An error has occured'                                           # Write message to screen
                Write-Host 'You may not have the permissions to do this'                    # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break SetAzureNICIpConfig                                                   # Breaks :SetAzureNICIpConfig
            }                                                                               # End catch
            Write-Host 'Nic IP configuration has been updated'                              # Write message to screen
            Pause                                                                           # Pauses all actions for operator input
            Break SetAzureNICIpConfig                                                       # Breaks :SetAzureNICIpConfig
        }                                                                                   # End :SetAzureNICIpConfig while($true)
        Clear-Host                                                                          # Clears screen
        Return                                                                              # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function SetAzNICIpConfigPublicIP