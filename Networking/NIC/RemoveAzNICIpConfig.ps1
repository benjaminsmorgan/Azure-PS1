# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Mircosoft docs links
    Remove-AzNetworkInterfaceIPConfig: https://docs.microsoft.com/en-us/powershell/module/az.network/Remove-aznetworkinterfaceipconfig?view=azps-5.6.0
    Set-AzNetworkInterface:     https://docs.microsoft.com/en-us/powershell/module/az.network/set-aznetworkinterface?view=azps-5.6.0
    Get-AzNetworkInterface:     https://docs.microsoft.com/en-us/powershell/module/az.network/get-aznetworkinterface?view=azps-5.4.0
    Get-AzVirtualNetworkSubnetConfig: https://docs.microsoft.com/en-us/powershell/module/az.network/get-azvirtualnetworksubnetconfig?view=azps-5.4.0
    Get-AzVirtualNetwork:       https://docs.microsoft.com/en-us/powershell/module/az.network/get-azvirtualnetwork?view=azps-5.4.0
} #>
<# Required Functions Links: {
    GetAzNetworkInterface:      https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/NIC/GetAzNetworkInterface.ps1
} #>
<# Functions Description: {
    RemoveAzNICIpConfig:        Removes a NIC IP configuration
    GetAzNetworkInterface:      Gets an existing network interface
} #>
<# Variables: {      
    :RemoveAzureNICIpConfig     Outer loop for managing function
    :GetAzureNicIPConfig        Inner loop for getting the nic ip config
    :SelectAzureNicIPConfig     Inner loop for selecting the nic ip config
    $CallingFunction:           Name of this function
    $OperatorSelect:            Operator selection option
    $NicObject:                 The nic whos configuration is being changed
    $SubnetObject:              Subnet of the nic (Not used)
    $VnetObject:                Vnet holding the subnet (Not used)
    $NicIPList:                 List of all IP configs on nic
    $ListNumber:                Number used in $ListArray
    $ListArray:                 Used to display nic ip configs
    $ListInput:                 $var used to load info into $ListArray
    $NicIPCon:                  $var used to apply the changes to a selected config
    GetAzNetworkInterface{}     Gets $NicObject
} #>
<# Process Flow {
    function
        Call RemoveAzNICIpConfig > Get $NicObject
            Call GetAzNetworkInterface > Get $NicObject
            End GetAzNetworkInterface
                Return RemoveAzNICIpConfig > $NicObject
        End RemoveAzNICIpConfig
            Return function > Send $NicObject
}#>
function RemoveAzNICIpConfig {                                                              # Function to Remove a NIC IP config
    Begin {                                                                                 # Begin function
        :RemoveAzureNICIpConfig while($true) {                                              # Outer loop for managing function
            if (!$CallingFunction) {                                                        # If $CallingFunction is $null
                $CallingFunction = 'RemoveAzNICIpConfig'                                    # Creates $CallingFunction
            }                                                                               # End if (!$CallingFunction)
            if (!$NicObject) {                                                              # If $NicObject is $null
                $NicObject, $SubnetObject, $VnetObject = GetAzNetworkInterface `
                        ($CallingFunction)                                                  # Calls function and assigns output to $var
                if (!$NicObject) {                                                          # If $NicObject is $null
                    Break RemoveAzureNICIpConfig                                            # Breaks :RemoveAzureNICIpConfig
                }                                                                           # End if (!$NicObject)    
            }                                                                               # End if (!$NicObject)
            :GetAzureNicIPConfig while ($true) {                                            # Inner loop for selecting the nic IP config
                $NicIPList = $NicObject.IPConfigurations                                    # Gets list of all existing IP configs
                $ListNumber = 1                                                             # Sets list number for $ListArray
                [System.Collections.ArrayList]$ListArray = @()                              # Array used to present information
                foreach ($_ in $NicIPList) {                                                # For each item in $NicIPList
                    $ListInput = [PSCustomObject]@{'Number'=$ListNumber;'Primary' `
                        =$_.Primary;'name'=$_.Name;'PrivIP'=$_.PrivateIPAddress; `
                        'PrivAllo'=$_.PrivateIpAllocationMethod}                            # Adds info to $ListInput   
                    $ListArray.Add($ListInput) | Out-Null                                   # Loads content of $ListInput into $ListArray
                    $ListNumber = $ListNumber + 1                                           # Increments $ListNumber up by one
                }                                                                           # End foreach ($_ in $NicIPList)
                Write-Host '[ 0 ] Exit'                                                     # Write message to screen
                Write-Host ''                                                               # Write message to screen
                foreach ($_ in $ListArray) {                                                # For each item in $ListArray
                    Write-Host '['$_.Number']'                                              # Write message to screen
                    Write-Host 'Name:    '$_.Name                                           # Write message to screen
                    Write-Host 'Primary: '$_.Primary                                        # Write message to screen
                    Write-Host 'PrivIP:  '$_.PrivIP                                         # Write message to screen
                    Write-Host 'PrivAllo:'$_.PrivAllo                                       # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                }                                                                           # End foreach ($_ in $ListArray)
                :SelectAzureNicIPConfig while ($true) {                                     # Inner loop for selecting the IP configuration
                    $OperatorSelect = Read-Host 'Select [#] of Nic IP config'               # Operator input for selecting the IP config
                    if ($OperatorSelect -eq '0') {                                          # If $OperatorSelect equals '0'
                        Break RemoveAzureNICIpConfig                                        # Breaks :RemoveAzureNICIpConfig
                    }                                                                       # End if ($OperatorSelect -eq '0')
                    elseif ($OperatorSelect -in $ListArray.Number) {                        # Else if $OperatorSelect in $ListArray.Number
                        $NicIPCon = $ListArray | Where-Object {$_.Number -eq `
                            $OperatorSelect}                                                # Sets $NicIPCon
                        Break GetAzureNicIPConfig                                           # Breaks :GetAzureNicIPConfig
                    }                                                                       # End elseif ($OperatorSelect -in $ListArray.Number)
                    else {                                                                  # All other inputs for $OperatorSelect
                        Write-Host 'That was not a valid selection'                         # Write message to screen
                    }                                                                       # End else (if ($OperatorSelect -eq '0'))
                }                                                                           # End :SelectAzureNicIPConfig while ($true)
            }                                                                               # End :GetAzureNicIPConfig while ($true)
            Try {                                                                           # Try the following
                $NicObject = Remove-AzNetworkInterfaceIpConfig -Name $NicIPCon.Name `
                    -NetworkInterface $NicObject                                            # Removes the selected configuration
                $NicObject | Set-AzNetworkInterface  -ErrorAction 'Stop' | Out-Null         # Saves the settings
            }                                                                               # End try
            Catch {                                                                         # If try fails
                Write-Host 'An error has occured'                                           # Write message to screen
                Break RemoveAzureNICIpConfig                                                # Breaks RemoveAzureNICIpConfig
            }                                                                               # End catch                                                                      
            Write-Host 'The IP has been set'                                                # Write message to screen
            Return $NicObject                                                               # Returns to calling function with $Var
        }                                                                                   # End :RemoveAzureNICIpConfig while($true)
        Return                                                                              # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function RemoveAzNICIpConfig