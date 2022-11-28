# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Microsoft docs links
    Add-AzNetworkInterfaceIpConfig:             https://docs.microsoft.com/en-us/powershell/module/az.network/add-aznetworkinterfaceipconfig?view=azps-6.0.0
    Set-AzNetworkInterface:                     https://docs.microsoft.com/en-us/powershell/module/az.network/set-aznetworkinterface?view=azps-5.6.0
    Get-AzNetworkInterface:                     https://docs.microsoft.com/en-us/powershell/module/az.network/get-aznetworkinterface?view=azps-5.4.0
    Get-AzVirtualNetworkSubnetConfig:           https://docs.microsoft.com/en-us/powershell/module/az.network/get-azvirtualnetworksubnetconfig?view=azps-5.4.0
    Get-AzVirtualNetwork:                       https://docs.microsoft.com/en-us/powershell/module/az.network/get-azvirtualnetwork?view=azps-5.4.0
} #>
<# Required Functions Links: {
    GetAzNetworkInterface:      https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/NIC/GetAzNetworkInterface.ps1
} #>
<# Functions Description: {
    AddAzNICIpConfig:           Creates a NIC IP configuration
    GetAzNetworkInterface:      Gets an existing network interface
} #>
<# Variables: {      
    :SetAzureNICIpConfig        Outer loop for managing function
    :SetAzureIPConfigName       Inner loop for setting the IP config name
    $CallingFunction:           Name of this function
    $OperatorSelect:            Operator selection option
    $NicObject:                 The nic whos configuration is being changed
    $SubnetObject:              Subnet of the nic 
    $VnetObject:                Vnet holding the subnet (Not used)
    $NicIPConfigName:           Operator input for the IP config name
    GetAzNetworkInterface{}     Gets $NicObject,$SubnetObject,$VnetObject
} #>
<# Process Flow {
    function
        Call AddAzNICIpConfig > Get $null
            Call GetAzNetworkInterface > Get $NicObject,$SubnetObject,$VnetObject
            End GetAzNetworkInterface
                Return AddAzNICIpConfig > Send $NicObject,$SubnetObject,$VnetObject
        End AddAzNICIpConfig
            Return function > Send $null
}#>
function AddAzNICIpConfig {                                                                 # Function to add a NIC IP config
    Begin {                                                                                 # Begin function
        if (!$CallingFunction) {                                                            # If $CallingFunction is $null
            $CallingFunction = 'AddAzNICIpConfig'                                           # Sets $CallingFunction
        }                                                                                   # End if (!$CallingFunction)
        :AddAzureNicIPConfig while ($true) {                                                # Outer loop for managing function
            $NicObject,$SubnetObject,$VnetObject = GetAzNetworkInterface ($CallingFunction) # Calls function and assigns output to $var
            if (!$NicObject) {                                                              # If $NicObject is $null
                Break AddAzureNICIpConfig                                                   # Breaks :AddAzureNICIpConfig
            }                                                                               # End if (!$NicObject)
            :SetAzureIPConfigName while ($true) {                                           # Inner loop for setting the new IP config name
                Write-Host 'Please enter the name of the IP config name'                    # Write message to screen
                $NicIPConfigName = Read-Host 'Name'                                         # Operator input for the new IP config name
                Clear-Host                                                                  # Clears screen
                Write-Host 'Use:'$NicIPConfigName' as the IP name'                          # Write message to screen
                $OpConfirm = Read-Host '[Y] Yes [N] No [E] Exit'                            # Operator confirmation of the IP config name
                Clear-Host                                                                  # Clears screen
                if ($OpConfirm -eq 'y') {                                                   # If $OpConfirm equals 'y'
                    Break SetAzureIPConfigName                                              # Breaks :SetAzureIPConfigName  
                }                                                                           # End if ($OpConfirm -eq 'y')
                elseif ($OpConfirm -eq 'e') {                                               # Else if $OpConfirm equals 'e'
                    Break AddAzureNICIpConfig                                               # Breaks :AddAzureNICIpConfig
                }                                                                           # End elseif ($OpConfirm -eq 'e')
            }                                                                               # End :SetAzureIPConfigName while ($true)
            $SubnetID = $SubnetObject.ID                                                    # Isolates the subnet ID
            Try {                                                                           # Try the following
                Write-Host 'Addinging the IP config'                                        # Write message to screen
                Add-AzNetworkInterfaceIpConfig -Name $NicIPConfigName -NetworkInterface `
                    $NicObject -SubnetId $SubnetID -ErrorAction 'Stop' | Out-Null           # Adds the new config
                $NicObject | Set-AzNetworkInterface -erroraction'Stop' | Out-Null           # Saves the changes
            }                                                                               # End try
            catch {                                                                         # If Try fails
                Clear-Host                                                                  # Clears screen
                Write-Host 'An error has occured'                                           # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Write-Host 'You may not have the permissions'                               # Write message to screen
                Write-Host 'to complete this action or'                                     # Write message to screen
                Write-Host 'the resource or resource group'                                 # Write message to screen
                Write-Host 'may be locked preventing changes'                               # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break AddAzureNicIPConfig                                                   # Breaks :AddAzureNicIPConfig
            }                                                                               # End catch
            Clear-Host                                                                      # Clears screen
            Write-Host 'IP config has been added to:'$NicObject.Name                        # Write message to the screen
            Pause                                                                           # Pauses all actions for operator input
            Break AddAzureNicIPConfig                                                       # Breaks :AddAzureNicIPConfig
        }                                                                                   # End :AddAzureNicIPConfig while ($true)
        Clear-Host                                                                          # Clears screen
        return $null                                                                        # Returns to calling function with $null 
    }                                                                                       # End Begin
}                                                                                           # End function AddAzNICIpConfig