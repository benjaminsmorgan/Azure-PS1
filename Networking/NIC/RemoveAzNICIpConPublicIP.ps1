# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Mircosoft docs links
    Set-AzNetworkInterfaceIpConfig: https://docs.microsoft.com/en-us/powershell/module/az.network/set-aznetworkinterfaceipconfig?view=azps-6.0.0
} #>
<# Required Functions Links: {
    GetAzNICIpConfig:           https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/NIC/GetAzNICIpConfig.ps1
    GetAzPublicIpAddress:       https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/Public%20IP/GetAzPublicIpAddress.ps1       
} #>
<# Functions Description: {
    RemoveAzNICIpConPublicIP:   Removes a public IP sku to a network interface config
    GetAzNICIpConfig:           Gets a network interface IP config
    GetAzPublicIpAddress:       Gets a public IP address sku  
} #>
<# Variables: {      
    :SetAzureNICIpConfig        Outer loop for managing function
    $CallingFunction:           Name of this function or the one that called it
    $NicIPConfigObject:         NIC IP configuration object
    $NicObject:                 Network interface object
    $PublicIPObject:            Public IP address sku
    $OpConfirm:                 Operator confirmation to remove the public IP sku
    GetAzNICIpConfig{}          Gets $NicIPConfigObject, $NicObject
    GetAzPublicIpAddress{}      Gets $PublicIPObject
} #>
<# Process Flow {
    function
        Call RemoveAzNICIpConPublicIP > Get $null
            Call GetAzNICIpConfig > Get $NicIPConfigObject, $NicObject
            End GetAzNICIpConfig
                Return RemoveAzNICIpConPublicIP > Send $NicIPConfigObject, $NicObject
            Call GetAzPublicIpAddress > Get $PublicIPObject
            End GetAzPublicIpAddress
                Return RemoveAzNICIpConPublicIP > Send $PublicIPObject
        End RemoveAzNICIpConPublicIP
            Return RemoveAzNICIpConPublicIP > Send $null
}#>
function RemoveAzNICIpConPublicIP {                                                         # Function to remove a public IP sku to a network interface config
    Begin {                                                                                 # Begin function
        :SetAzureNICIpConfig while($true) {                                                 # Outer loop for managing function
            if (!$CallingFunction) {                                                        # If $CallingFunction is $null
                $CallingFunction = 'SetAzNICIpConfig'                                       # Creates $CallingFunction
            }                                                                               # End if (!$CallingFunction)
            $NicIPConfigObject,$NicObject = GetAzNICIpConfig                                # Calls function and assigns output to $vars
            if (!$NicIPConfigObject) {                                                      # If $NicIPConfigObject is $null
                Break SetAzureNICIpConfig                                                   # Breaks :SetAzureNICIpConfig
            }                                                                               # End if (!$NicIPConfigObject)
            elseif (!$NicIPConfigObject.PublicIPAddress) {                                  # Else if $NicIPConfigObject.PublicIPAddress is $null
                Write-Host 'This IP config does not have an associated public IP sku'       # Write message to screen
                Write-Host 'No changes have been made'                                      # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break SetAzureNICIpConfig                                                   # Breaks :SetAzureNICIpConfig
            }                                                                               # End elseif (!$NicIPConfigObject.PublicIPAddress)
            Write-Host 'Remove the public IP from'                                          # Write message to screen
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
                Break SetAzureNICIpConfig                                                   # Breaks :SetAzureNICIpConfig
            }                                                                               # End if ($OpConfirm -ne 'y')
            Try {                                                                           # Try the following
                $NicObject | Set-AzNetworkInterfaceIpConfig -Name $NicIPConfigObject.Name `
                    -PublicIpAddressId $null -SubnetId $NicIPConfigObject.Subnet.ID `
                    -ErrorAction 'Stop' | Out-Null                                          # Adds $PublicIPObject to $NicIPConfigObject
                $NicObject | Set-AzNetworkInterface -ErrorAction 'Stop' | Out-Null          # Saves $NicObject config
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
}                                                                                           # End function RemoveAzNICIpConPublicIP