# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Mircosoft docs links
    Set-AzNetworkInterface:     https://docs.microsoft.com/en-us/powershell/module/az.network/set-aznetworkinterface?view=azps-5.6.0
    Get-AzNetworkInterfaceIPConfig: https://docs.microsoft.com/en-us/powershell/module/az.network/get-aznetworkinterfaceipconfig?view=azps-5.6.0
    New-AzNetworkInterface:     https://docs.microsoft.com/en-us/powershell/module/az.network/new-aznetworkinterface?view=azps-5.6.0
    Get-AzNetworkInterface:     https://docs.microsoft.com/en-us/powershell/module/az.network/get-aznetworkinterface?view=azps-5.4.0
    Get-AzResourceGroup:        https://docs.microsoft.com/en-us/powershell/module/az.resources/get-azresourcegroup?view=azps-5.1.0
    Get-AzLocation:             https://docs.microsoft.com/en-us/powershell/module/az.resources/get-azlocation?view=azps-5.4.0
    Get-AzVirtualNetworkSubnetConfig: https://docs.microsoft.com/en-us/powershell/module/az.network/get-azvirtualnetworksubnetconfig?view=azps-5.4.0
    Get-AzVirtualNetwork:       https://docs.microsoft.com/en-us/powershell/module/az.network/get-azvirtualnetwork?view=azps-5.4.0
} #>
<# Required Functions Links: {
    NewAzNetworkInterface:      https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/NIC/NewAzNetworkInterface.ps1
    GetAzNetworkInterface:      https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/NIC/GetAzNetworkInterface.ps1
    GetAzResourceGroup:         https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/GetAzResourceGroup.ps1
    GetAzLocation:              https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/GetAzLocation.ps1
    GetAzVNetSubnetConfig:      https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/SubNet/GetAzVNetSubnetConfig.ps1
} #>
<# Functions Description: {
    AddAzNICIpConfig:           Creates a NIC IP configuration
    NewAzNetworkInterface:      Creates new network interfaces
    GetAzNetworkInterface:      Gets an existing network interface
    RemoveAzNetworkInterface:   Removes a network interface   
    GetAzVNetSubnetConfig:      Gets an azure virtual network subnet
    GetAzResourceGroup:         Gets a resource group
    GetAzLocation:              Gets an Azure location
} #>
<# Variables: {      
    :SetAzureNICIpConfig        Outer loop for managing function
    :SelectAzureNic             Inner loop for getting or creating a nic
    :SetAzureIPConfigName       Inner loop for setting the IP config name
    $CallingFunction:           Name of this function
    $OperatorSelect:            Operator selection option
    $NicObject:                 The nic whos configuration is being changed
    $SubnetObject:              Subnet of the nic 
    $VnetObject:                Vnet holding the subnet (Not used)
    $NicIPConfigName:           Operator input for the IP config name
    NewAzNetworkInterface{}     Creates $NicObject
        GetAzResourceGroup{}        Gets $RGObject
        GetAzLocation{}             Gets $LocationObject
        GetAzVNetSubnetConfig{}     Gets $SubnetObject
    GetAzNetworkInterface{}     Gets $NicObject
} #>
<# Process Flow {
    function
        Call AddAzNICIpConfig > Get $NicObject
            Call NewAzNetworkInterface > Get $NicObject
                Call GetAzResourceGroup > Get $RGObject
                End GetAzResourceGroup
                    Return NewAzNetworkInterface > Send $RGObject
                Call GetAzLocation > Get $LocationObject
                End GetAzLocation
                    Return NewAzNetworkInterface > Send $LocationObject
                Call GetAzVNetSubnetConfig > Get $SubnetObject
                End GetAzVNetSubnetConfig
                    Return NewAzNetworkInterface > Send $SubnetObject
            End NewAzNetworkInterface
                Return AddAzNICIpConfig > Send $NicObject
            Call GetAzNetworkInterface > Get $NicObject
            End GetAzNetworkInterface
                Return AddAzNICIpConfig > $NicObject
        End AddAzNICIpConfig
            Return function > Send $NicObject
}#>
function AddAzNICIpConfig {                                                                 # Function to add a NIC IP config
    Begin {                                                                                 # Begin function
        :AddAzureNicIPConfig while ($true) {                                                # Outer loop for managing function
            $CallingFunction = 'AddAzNICIpConfig'                                           # Sets $CallingFunction
            if (!$NicObject) {                                                              # If $NicObject
                :SelectAzureNic while ($true) {                                             # Inner loop for selecting a NIC
                    Write-Host '[0] Exit'                                                   # Write message to screen
                    Write-Host '[1] New NIC'                                                # Write message to screen
                    Write-Host '[2] Existing NIC'                                           # Write message to screen
                    $OperatorSelect = Read-Host 'Select [#] option'                         # Operator input for a new or existing NIC
                    if ($OperatorSelect -eq '0') {                                          # If $OperatorSelect equals '0'
                        Break AddAzureNICIpConfig                                           # Breaks :AddAzureNICIpConfig
                    }                                                                       # End if ($OperatorSelect -eq '0')
                    elseif ($OperatorSelect -eq '1') {                                      # Else if $OperatorSelect equals '1'
                        $NicObject, $SubnetObject, $VnetObject = NewAzNetworkInterface `
                            ($CallingFunction)                                              # Calls function and assigns output to $var
                        if (!$NicObject -or !$SubnetObject -or !$VnetObject) {              # If $NicObject, $SubnetObject, or $VnetObject is $null
                            Break AddAzureNICIpConfig                                       # Breaks :AddAzureNICIpConfig
                        }                                                                   # End if (!$NicObject -or !$SubnetObject -or !$VnetObject)
                        else {                                                              # If $NicObject, $SubnetObject, and $VnetObject have a value
                            Break SelectAzureNic                                            # Breaks :SelectAzureNic
                        }                                                                   # End else (if (!$NicObject -or !$SubnetObject -or !$VnetObject))
                    }                                                                       # End elseif ($OperatorSelect -eq '1')
                    elseif ($OperatorSelect -eq '2') {                                      # Else if $OperatorSelect equals '1'
                        $NicObject, $SubnetObject, $VnetObject = GetAzNetworkInterface `
                            ($CallingFunction)                                              # Calls function and assigns output to $var
                        if (!$NicObject -or !$SubnetObject -or !$VnetObject) {              # If $NicObject, $SubnetObject, or $VnetObject is $null
                            Break AddAzureNICIpConfig                                       # Breaks :AddAzureNICIpConfig
                        }                                                                   # End if (!$NicObject -or !$SubnetObject -or !$VnetObject)
                        else {                                                              # If $NicObject, $SubnetObject, and $VnetObject have a value
                            Break SelectAzureNic                                            # Breaks :SelectAzureNic
                        }                                                                   # End else (if (!$NicObject -or !$SubnetObject -or !$VnetObject))
                    }                                                                       # End elseif ($OperatorSelect -eq '2')
                    else {                                                                  # All other inputs for $OperatorSelect
                        Write-Host 'That was not a valid option'                            # Write message to screen
                    }                                                                       # End else (if ($OperatorSelect -eq '0'))
                }                                                                           # Inner loop for selecting a new or existing nic
            }                                                                               # End if (!$NicObject)
            :SetAzureIPConfigName while ($true) {                                           # Inner loop for setting the new IP config name
                $NicIPConfigName = Read-Host 'Please enter the name of the IP config name'  # Operator input for the new IP config name
                if ($NicIPConfigName -eq 'exit') {                                          # If $NicIPConfigName
                    Break AddAzureNicIPConfig                                               # Breaks :AddAzureNicIPConfig
                }                                                                           # End if ($NicIPConfigName -eq 'exit')
                Write-Host 'Use'$NicIPConfigName                                            # Write message to screen
                $OperatorConfirm = Read-Host '[Y] or [N]'                                   # Operator confirmation of the IP config name
                if ($OperatorConfirm -eq 'y') {                                             # If $OperatorConfirm equals 'y'
                    Break SetAzureIPConfigName                                              # Breaks :SetAzureIPConfigName  
                }                                                                           # End if ($OperatorConfirm -eq 'y')
            }                                                                               # End :SetAzureIPConfigName while ($true)
            Try {                                                                           # Try the following
                Add-AzNetworkInterfaceIpConfig -Name $NicIPConfigName -NetworkInterface `
                    $NicObject -SubnetId $SubnetObject.ID                                   # Adds the new config
                $NicObject | Set-AzNetworkInterface                                         # Saves the changes
            }                                                                               # End try
            catch {                                                                         # If Try fails
                Write-Host 'An error has occured'                                           # Write message to the screen
                Break AddAzureNicIPConfig                                                   # Breaks :AddAzureNicIPConfig
            }                                                                               # End catch
            Return $NicObject                                                               # Returns $NicObject to calling function
        }                                                                                   # End :AddAzureNicIPConfig while ($true)
        return                                                                              # Returns to calling function with $null 
    }                                                                                       # End Begin
}                                                                                           # End function AddAzNICIpConfig