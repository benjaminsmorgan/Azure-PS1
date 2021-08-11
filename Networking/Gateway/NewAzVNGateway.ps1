# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Microsoft docs links
    Get-AzVirtualNetwork:                       https://docs.microsoft.com/en-us/powershell/module/az.network/get-azvirtualnetwork?view=azps-5.4.0
    Get-AzPublicIpAddress:                      https://docs.microsoft.com/en-us/powershell/module/az.network/get-azpublicipaddress?view=azps-5.5.0 
    New-AzVirtualNetworkGatewayIpConfig:        https://docs.microsoft.com/en-us/powershell/module/az.network/new-azvirtualnetworkgatewayipconfig?view=azps-6.3.0
    Get-AzVirtualNetworkSubnetConfig:           https://docs.microsoft.com/en-us/powershell/module/az.network/get-azvirtualnetworksubnetconfig?view=azps-6.3.0
    Get-AzVirtualNetworkGateway:                https://docs.microsoft.com/en-us/powershell/module/az.network/get-azvirtualnetworkgateway?view=azps-6.3.0
    New-AzVirtualNetworkGateway:                https://docs.microsoft.com/en-us/powershell/module/az.network/new-azvirtualnetworkgateway?view=azps-6.3.0
} #>
<# Required Functions Links: {
    GetAzVirtualNetwork:        https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/VNet/GetAzVirtualNetwork.ps1
    SetAzGatewayType:           https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/Gateway/SetAzGatewayType.ps1
    SetAzGatewayVPNSku:         https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/Gateway/SetAzGatewayVPNSku.ps1
    SetAzGatewayVPNSkuGen:      https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/Gateway/SetAzGatewayVPNSkuGen.ps1
    NewAzVNGatewayIPcon:        https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/Gateway/NewAzVNGatewayIPcon.ps1
    GetAzPublicIpAddress:       https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/Public%20IP/GetAzPublicIpAddress.ps1
} #>
<# Functions Description: {
    NewAzVNGateway:             Function to create a new virtual network gateway
    GetAzVirtualNetwork:        Function for getting an Azure virtual network
    SetAzGatewayType:           Function to set a virtual network gateway type
    SetAzGatewayVPNSku:         Function to set a virtual network gateway sku
    SetAzGatewayVPNSkuGen:      Function to set a virtual network gateway sku generation
    NewAzVNGatewayIPcon:        Function to create a new gateway ip configuration
    GetAzPublicIpAddress:       Function to get an existing public IP address
} #>
<# Variables: {      
    :NewAzureVNGateway          Outer loop for managing function
    :SetAzureGWName             Inner loop for setting the gateway name
    :Confirm                    Inner loop for confirming operator input
    :SetAzureGWActiveActive     Inner loop for configuring active-active config
    $CallingFunction:           Name of this function or the one that called it
    $ValidArray:                Array of valid body characters for gateway name
    $Valid1stChar:              Array of valid first characters for gateway name
    $ValidLastChar:             Array of valid last characters for gateway name
    $GWNameObject:              Operator input for gateway name
    $GWNameArray:               $GWNameObject converted to array
    $OpConfirm:                 Operator confirmation of inputted values
    $VNetObject:                Virtual network object
    $SubnetList:                $VNetObject.Subnets
    $SubnetObject:              Subnet object
    $IPConID:                   Current item .ID
    $CID:                       Current item config type
    $ExistingGateway:           Existing gateway object on $VNetObject
    $GatewayType:               Gateway type
    $GatewaySku:                Gateway sku
    $GatewaySkuGen:             Gateway sku generator
    $VPNType:                   VPN type
    $GatewayIPConfig:           Gateway IP config
    $OpSelect:                  Operator selection to add active-active config
    $GatewayIPConfigPri:        Primary gateway IP config
    $GatewayIPConfigSec:        Secondary gateway IP config
    $MSG:                       Last powershell error message
    GetAzVirtualNetwork{}       Gets $VNetObject
    SetAzGatewayType{}          Gets $GatewaySku
    SetAzGatewayVPNSku{}        Gets $GatewaySku
    SetAzGatewayVPNSkuGen{}     Gets $GatewaySku
    NewAzVNGatewayIPcon{}       Gets $GatewayIPConfig
        GetAzPublicIpAddress{}      Gets $PublicIPObject
} #>
<# Process Flow {
    function
        Call NewAzVNGateway > Get $null  
            Call GetAzVirtualNetwork > Get $VNetObject
            End GetAzVirtualNetwork
                Return NewAzVNGateway > Send $VNetObject
            Call SetAzGatewayType > Get $GatewaySku
            End SetAzGatewayType
                Return NewAzVNGateway > Send $GatewaySku
            Call SetAzGatewayVPNSku > Get $GatewaySku
            End SetAzGatewayVPNSku
                Return NewAzVNGateway > Send $GatewaySku
            Call SetAzGatewayVPNSkuGen > Get $GatewaySkuGen
            End SetAzGatewayVPNSkuGen
                Return NewAzVNGateway > Send $GatewaySkuGen
            Call NewAzVNGatewayIPcon > Get $GatewayIPConfig
                Call GetAzPublicIpAddress > Get $PublicIPObject
                End GetAzPublicIpAddress
                    Return NewAzVNGatewayIPcon > Send $PublicIPObject
            End NewAzVNGatewayIPcon
                Return NewAzVNGateway > Send $GatewayIPConfig
        End NewAzVNGateway
            Return function > Send $null
}#>
function NewAzVNGateway {                                                                   # Function to create a new virtual network gateway
    Begin {                                                                                 # Begin function
        if (!$CallingFunction) {                                                            # If $CallingFunction is $null
            $CallingFunction = 'NewAzVNGateway'                                             # Creates $CallingFunction 
        }                                                                                   # End if (!$CallingFunction)
        :NewAzureVNGateway while ($true) {                                                  # Outer loop for managing function
            Write-Host 'The following must exist prior to building the gateway'             # Write message to screen
            Write-Host 'A virtual network with a subnet named "GatewaySubnet"'              # Write message to screen   
            Write-Host 'An available public IP sku matching gateway sku'                    # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            Pause                                                                           # Pauses all actions for operator input
            Clear-Host                                                                      # Clears screen
            $ValidArray = 'abcdefghijklmnopqrstuvwxyz0123456789-_.'                         # Creates a string of valid characters
            $ValidArray = $ValidArray.ToCharArray()                                         # Loads all valid characters into array
            $Valid1stChar = 'abcdefghijklmnopqrstuvwxyz0123456789'                          # Creates a string of valid first character
            $Valid1stChar = $Valid1stChar.ToCharArray()                                     # Loads all valid characters into array
            $ValidLastChar = 'abcdefghijklmnopqrstuvwxyz0123456789_'                        # Creates a string of valid last character
            $ValidLastChar = $ValidLastChar.ToCharArray()                                   # Loads all valid characters into array
            :SetAzureGWName while ($true) {                                                 # Inner loop for setting the gateway name
                Write-Host 'Enter the gateway name'                                         # Write message to screen
                Write-Host ''                                                               # Writes message to screen
                $GWNameObject = Read-Host 'Name'                                            # Operator input for the gateway name
                $GWNameArray = $GWNameObject.ToCharArray()                                  # Loads $GWNameObject into array
                Clear-Host                                                                  # Clears screen
                if ($GWNameObject.Length -ge 81) {                                          # If $GWNameObject.Length is greater or equal to 81
                    Write-Host 'The gateway name is to long'                                # Write message to screen
                    Write-Host 'Max length of the name is 80 characters'                    # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    $GWNameObject = $null                                                   # Clears $GWNameObject
                }                                                                           # End if ($GWNameObject.Length -ge 80)
                if ($GWNameArray[0] -notin $Valid1stChar) {                                 # If 0 position of $GWNameArray is not in $Valid1stChar
                    Write-Host 'The first character of the name must be a letter or number' # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    $GWNameObject = $null                                                   # Clears $GWNameObject
                }                                                                           # End if ($GWNameArray[0] -notin $Valid1stChar)
                if ($GWNameArray[-1] -notin $ValidLastChar) {                               # If last position of $GWNameArray is not in $ValidLastChar
                    Write-Host `
                        'The last character of the name must be a letter, number or _ '     # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    $GWNameObject = $null                                                   # Clears $GWNameObject
                }                                                                           # End if ($GWNameArray[0] -notin $Valid1stChar)
                foreach ($_ in $GWNameArray) {                                              # For each item in $GWNameArray
                    if ($_ -notin $ValidArray) {                                            # If current item is not in $ValidArray
                        if ($_ -eq ' ') {                                                   # If current item equals 'space'
                            Write-Host ''                                                   # Write message to screen    
                            Write-Host 'Gateway name cannot include any spaces'             # Write message to screen
                        }                                                                   # End if ($_ -eq ' ')
                        else {                                                              # If current item is not equal to 'space'
                            Write-Host ''                                                   # Write message to screen    
                            Write-Host $_' is not a valid character'                        # Write message to screen
                        }                                                                   # End else (if ($_ -eq ' '))
                        $GWNameObject = $null                                               # Clears $GWNameObject
                    }                                                                       # End if ($_ -notin $ValidArray)
                }                                                                           # End foreach ($_ in $GWNameArray)
                if ($GWNameObject) {                                                        # If $GWNameObject has a value
                    :Confirm while ($true) {                                                # Inner loop for confirming the gateway name
                        Write-Host 'Use:'$GWNameObject' as the gateway name'                # Writes message to screen
                        Write-Host ''                                                       # Writes message to screen
                        $OpConfirm = Read-Host '[Y] Yes [N] No [E] Exit'                    # Operator confirmation of the gateway name
                        Clear-Host                                                          # Clears screen
                        if ($OpConfirm -eq 'y') {                                           # If $OpConfirm equals 'y'
                            Break SetAzureGWName                                            # Breaks :SetAzureGWName
                        }                                                                   # End if ($OpConfirm -eq 'y')
                        elseif ($OpConfirm -eq 'n') {                                       # Else if $OpConfirm equals 'n'
                            $GWNameObject = $null                                           # Clears $var
                            Break confirm                                                   # Breaks :Confirm
                        }                                                                   # End elseif ($OpConfirm -eq 'n')
                        elseif ($OpConfirm -eq 'e') {                                       # Else if $OpConfirm equals 'e'
                            Break NewAzureVNGateway                                         # Breaks :NewAzureVNGateway
                        }                                                                   # End elseif ($OpConfirm -eq 'e')
                        else {                                                              # All other inputs for $OpConfirm
                            Write-Host 'That was not a valid input'                         # Write message to screen
                            Write-Host ''                                                   # Write message to screen
                            Pause                                                           # Pauses all actions for operator input
                            Clear-Host                                                      # Clears screen
                        }                                                                   # End else (if ($OpConfirm -eq 'y'))
                    }                                                                       # End :Confirm while ($true)
                }                                                                           # End if ($GWNameObject)
                else {                                                                      # If $GWNameObject does not have a value
                    Pause                                                                   # Pauses all actions for operator input
                    Clear-Host                                                              # Clears screen
                }                                                                           # End else (if ($GWNameObject))
            }                                                                               # End :SetAzureGWName while ($true)
            $VNetObject = GetAzVirtualNetwork ($CallingFunction)                            # Calls function and assigns output to $var
            if (!$VnetObject) {                                                             # If $VnetObject is $null
                Break NewAzureVNGateway                                                     # Breaks :NewAzureVNGateway
            }                                                                               # End if (!$VnetObject)
            $SubnetList = $VNetObject.Subnets                                               # SubnetList is equal to $VNetObject.Subnets
            foreach ($_ in $SubnetList) {                                                   # For each item in $SubnetList
                if ($_.Name -eq 'GatewaySubnet') {                                          # If current item equals 'GatewaySubnet
                    $SubnetObject = Get-AzVirtualNetworkSubnetConfig -Name 'GatewaySubnet' `
                        -VirtualNetwork $VNetObject                                         # Gets the subnet object
                    foreach ($ID in $SubnetObject.IpConfigurations.ID) {                    # For each item in $SubnetObject.IpConfigurations.ID    
                        $IPConID = $ID                                                      # Isolates the full IPconfig ID
                        $CID = $IPConID.split('/')[7]                                       # Isolates the IP config type
                        if ($CID -eq 'virtualNetworkGateways') {                            # If $CID equals 'virtualNetworkGateways'
                            $ExistingGateway = $IPConID.split('/')[-3]                      # Isolates the Vnet Gateway
                            Write-Host 'Gathering existing gateway info'                    # Write message to screen
                            $ExistingGateway = Get-AzVirtualNetworkGateway -Name `
                                $ExistingGateway -ResourceGroupName `
                                $VNetObject.ResourceGroupName                               # Gets an existing gateway on $VNetObject
                            Clear-Host                                                      # Clears screen 
                            Write-Host 'A network gateway already exists on this VNet'      # Write message to screen
                            Write-Host ''                                                   # Write message to screen
                            Write-Host 'Please remove the following '                       # Write message to screen
                            Write-Host 'before adding a new gateway'                        # Write message to screen
                            Write-Host ''                                                   # Write message to screen
                            Write-Host 'Name:'$ExistingGateway.Name                         # Write message to screen
                            Write-Host 'Type:'$ExistingGateway.GatewayType                  # Write message to screen
                            Write-Host ''                                                   # Write message to screen
                            Pause                                                           # Pauses all actions for operator input
                            Break NewAzureVNGateway                                         # Breaks :NewAzureVNGateway
                        }                                                                   # End if ($CID -eq 'virtualNetworkGateways') 
                    }                                                                       # End foreach ($ID in $SubnetObject.IpConfigurations.ID)
                }                                                                           # End if ($_ -eq 'GatewaySubnet')
            }                                                                               # End foreach ($_ in $SubnetList)  
            if (!$SubnetObject) {                                                           # If $SubnetObject is $null
                Write-Host 'In order to complete this task, a new'                          # Write message to screen
                Write-Host 'subnet named "GatewaySubnet" must exist.'                       # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Write-Host 'Please create this subnet and rerun this function'              # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break NewAzureVNGateway                                                     # Breaks :NewAzureVNGateway    
            }                                                                               # End if (!$SubnetObject)
            $GatewayType = SetAzGatewayType ($CallingFunction)                              # Calls function and assigns output to $var
            if (!$GatewayType) {                                                            # If $GatewayType is $null
                Break NewAzureVNGateway                                                     # Breaks :NewAzureVNGateway
            }                                                                               # End if (!$GatewayType)    
            $GatewaySku = SetAzGatewayVPNSku ($CallingFunction, $GatewayType)               # Calls function and assigns output to $var
            if (!$GatewaySku) {                                                             # If $GatewaySku is $null
                Break NewAzureVNGateway                                                     # Breaks :NewAzureVNGateway
            }                                                                               # End if (!$GatewaySku)
            if ($GatewaySku -eq 'Basic') {                                                  # If $GatewaySku equals 'Basic'
                $VPNType = 'PolicyBased'                                                    # Sets $VPNType
            }                                                                               # End if ($GatewaySku -eq 'Basic')
            if ($GatewaySku -ne 'Basic' -and $GatewayType -eq 'VPN') {                      # If $GatewaySku does not equal 'Basic' and $GatewayType equals 'VPN'
                $VPNType = 'RouteBased'                                                     # Sets $VPNType
            }                                                                               # End if ($GatewaySku -ne 'Basic' -and $GatewayType -eq 'VPN')
            if ($GatewayType -eq 'VPN') {                                                   # If $GatewayType equals 'VPN'
                $GatewaySkuGen = SetAzGatewayVPNSkuGen ($CallingFunction, $GatewaySku)      # Calls function and assigns output to $var
                if (!$GatewaySkuGen) {                                                      # If $GatewaySkuGen is $null
                    Break NewAzureVNGateway                                                 # Breaks :NewAzureVNGateway
                }                                                                           # End if (!$GatewaySkuGen)
            }                                                                               # End if ($GatewayType -eq 'VPN') 
            $GatewayIPConfig = NewAzVNGatewayIPcon ($SubnetObject, $GatewaySku)             # Calls function and assigns output to $var
            if (!$GatewayIPConfig) {                                                        # If $GatewayIPConfig is $null
                Break NewAzureVNGateway                                                     # Breaks :NewAzureVNGateway
            }                                                                               # End if (!$GatewayIPConfig)
            if ($GatewaySku -eq 'VpnGw1' -or 'VpnGw2' -or 'VpnGw3' -or 'VpnGw1AZ' -or `
                'VpnGw2AZ' -or 'VpnGw3Az' -or 'HighPerformance') {                          # If $GatewaySku equals  'VpnGw1', 'VpnGw2', 'VpnGw3', 'VpnGw1AZ', 'VpnGw2AZ', 'VpnGw3Az' -or 'HighPerformance'
                :SetAzureGWActiveActive while ($true) {                                     # Inner loop for configuring an Active-Active gateway config
                    Write-Host 'Add a second public IP (active-active mode)'                # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    $OpSelect = Read-Host '[Y] Yes [N] No [E] Exit'                         # Operator selection of Active-Active config
                    Clear-Host                                                              # Clears screen
                    if ($OpSelect -eq 'y') {                                                # If $OpSelect equals 'y'
                        $GatewayIPConfigPri = $GatewayIPConfig                              # $GatewayIPConfigPri is equal to $GatewayIPConfig
                        $GatewayIPConfig = $null                                            # Clears $var
                        $GatewayIPConfig = NewAzVNGatewayIPcon ($SubnetObject, $GatewaySku) # Calls function and assigns output to $var
                        if ($GatewayIPConfig) {                                             # If $GatewayIPConfig has a value
                            if ($GatewayIPConfig.Name -eq $GatewayIPConfigPri.Name) {       # If $GatewayIPConfig.Name equals $GatewayIPConfigPri
                                Write-Host 'Invalid configuration on secondary config'      # Write message to screen   
                                Write-Host 'Please use a different name for the IP config'  # Write message to screen
                                Write-Host ''                                               # Write message to screen
                                Pause                                                       # Pauses all actions for operator input
                                $GatewayIPConfig = $null                                    # Clears $var
                            }                                                               # End if ($GatewayIPConfig.Name -eq $GatewayIPConfigPri.Name)
                            if ($GatewayIPConfigPri.PublicIPAddress.ID -eq `
                                $GatewayIPConfig.PublicIPAddress.ID) {                      # If $GatewayIPConfigPri.PublicIPAddress.ID equals $GatewayIPConfig.PublicIPAddress.ID
                                Write-Host 'Invalid configuration on secondary config'      # Write message to screen   
                                Write-Host 'Please use a different public IP config'        # Write message to screen
                                Write-Host ''                                               # Write message to screen
                                Pause                                                       # Pauses all actions for operator input
                                $GatewayIPConfig = $null                                    # Clears $var
                            }                                                               # End if ($GatewayIPConfigPri.PublicIPAddress.ID -eq $GatewayIPConfig.PublicIPAddress.ID)
                        }                                                                   # End if ($GatewayIPConfig)    
                        Clear-Host                                                          # Clears screen
                        if ($GatewayIPConfig) {                                             # If $GatewayIPConfig has a value
                            $GatewayIPConfigSec = $GatewayIPConfig                          # $GatewayIPConfigPri is equal to $GatewayIPConfig
                            $GatewayIPConfig = $null                                        # Clears $var
                            Break SetAzureGWActiveActive                                    # Breaks :SetAzureGWActiveActive
                        }                                                                   # End if ($GatewayIPConfig) 
                    }                                                                       # End if ($OpSelect -eq 'y')
                    elseif ($OpSelect -eq 'n') {                                            # Else if $OpSelect equals 'n'
                        Break SetAzureGWActiveActive                                        # Breaks :SetAzureGWActiveActive
                    }                                                                       # End elseif ($OpSelect -eq 'n')
                    elseif ($OpSelect -eq 'e') {                                            # Else if $OpSelect equals'e'
                        Break NewAzureVNGateway                                             # Breaks :NewAzureVNGateway
                    }                                                                       # End elseif ($OpSelect -eq 'e')
                    else {                                                                  # All other inputs for $OpSelect
                        Write-Host 'That was not a valid input'                             # Write message to screen
                        Write-Host ''                                                       # Write message to screen
                        Pause                                                               # Pauses all actions for operator input
                        Clear-Host                                                          # Clears screen
                    }                                                                       # End else (if ($OpSelect -eq 'y'))
                }                                                                           # End :SetAzureGWActiveActive while ($true)
            }                                                                               # End if ($GatewaySku -eq  'VpnGw1' -or 'VpnGw2' -or 'VpnGw3' -or 'VpnGw1AZ' -or 'VpnGw2AZ' -or 'VpnGw3Az' -or 'HighPerformance')
            Try {                                                                           # Try the following
                Write-Host 'Creating the gateway'                                           # End # Write message to screen
                Write-Host 'This will take awhile'                                          # End # Write message to screen    
                if ($GatewayIPConfigPri) {                                                  # If $GatewayIPConfigPri has a value
                    if ($GatewayType -eq 'VPN') {                                           # If $GatewayType equals 'VPN'
                        New-AzVirtualNetworkGateway -Name $GWNameObject -ResourceGroupName `
                            $VNetObject.ResourceGroupName -Location $VNetObject.Location `
                            -GatewayType $GatewayType -GatewaySku $GatewaySku `
                            -VpnGatewayGeneration $GatewaySkuGen -VpnType $VPNType `
                            -IpConfigurations $GatewayIPConfigPri,$GatewayIPConfigSec `
                            -EnableActiveActiveFeature -ErrorAction 'Stop' | Out-Null       # Creates the gateway
                    }                                                                       # End if ($GatewayType -eq 'VPN')
                    else {                                                                  # Else if $GatewayType does not equal 'VPN
                        New-AzVirtualNetworkGateway -Name $GWNameObject -ResourceGroupName `
                            $VNetObject.ResourceGroupName -Location $VNetObject.Location `
                            -GatewayType $GatewayType -GatewaySku $GatewaySku `
                            -IpConfigurations $GatewayIPConfig,$GatewayIPConfig2 `
                            -EnableActiveActiveFeature -ErrorAction 'Stop' | Out-Null       # Creates the gateway
                    }                                                                       # End else (if ($GatewayType -eq 'VPN'))
                }                                                                           # End if ($GatewayIPConfigPri)
                else {                                                                      # Else if $GatewayIPConfigPri is $null
                    if ($GatewayType -eq 'VPN') {                                           # If $GatewayType equals 'VPN'
                        New-AzVirtualNetworkGateway -Name $GWNameObject -ResourceGroupName `
                            $VNetObject.ResourceGroupName -Location $VNetObject.Location `
                            -GatewayType $GatewayType -GatewaySku $GatewaySku `
                            -VpnGatewayGeneration $GatewaySkuGen -VpnType $VPNType `
                            -IpConfigurations $GatewayIPConfig -ErrorAction 'Stop' `
                            | Out-Null                                                      # Creates the gateway
                    }                                                                       # End if ($GatewayType -eq 'VPN')
                    else {                                                                  # Else if $GatewayType does not equal 'VPN
                        New-AzVirtualNetworkGateway -Name $GWNameObject -ResourceGroupName `
                        $VNetObject.ResourceGroupName -Location $VNetObject.Location `
                        -GatewayType $GatewayType -GatewaySku $GatewaySku `
                        -IpConfigurations $GatewayIPConfig -ErrorAction 'Stop' | Out-Null   # Creates the gateway
                    }                                                                       # End else (if ($GatewayType -eq 'VPN'))
                }                                                                           # End else (if ($GatewayIPConfigPri))
            }                                                                               # End try
            Catch {                                                                         # If Try fails
                Clear-Host                                                                  # Clears screen
                Write-Host 'An error has occured'                                           # Write message to screen
                Write-Host ''                                                               # Write message to screen
                $MSG = $Error[0]                                                            # Gets the error message
                if ($MSG.Exception.InnerException.Body.Message) {                           # If $MSG.Exception.InnerException.Body.Message has a value             
                    $MSG = $MSG.Exception.InnerException.Body.Message                       # Isolates the error message
                    Write-Warning $MSG                                                      # Write message to screen
                    Write-Host ''                                                           # Write message to screen    
                }                                                                           # End if ($MSG.Exception.InnerException.Body.Message)
                else {                                                                      # Else if $MSG.Exception.InnerException.Body.Message is $null
                    Write-Warning $MSG                                                      # Write message to screen
                    Write-Host ''                                                           # Write message to screen        
                }                                                                           # End else (if ($MSG.Exception.InnerException.Body.Message))
                Write-Host 'No changes have been made'                                      # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break NewAzureVNGateway                                                     # Breaks :NewAzureVNGateway    
            }                                                                               # End Catch
            Clear-Host                                                                      # Clears screen
            Write-Host 'The gateway has been created'                                       # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            Pause                                                                           # Pauses all actions for operator input
            Break NewAzureVNGateway                                                         # Breaks :NewAzureVNGateway    
        }                                                                                   # End :NewAzureVNGateway while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function NewAzVNGateway
function SetAzGatewayType {                                                                 # Function to set a virtual network gateway type
    Begin {                                                                                 # Begin function
        :SetAzureGatewayType while ($true) {                                                # Inner loop for setting the gateway type
            Write-Host 'Select the gateway type'                                            # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            Write-Host '[0]  Exit'                                                          # Write message to screen
            Write-Host '[1]  Vpn'                                                           # Write message to screen
            Write-Host '[2]  ExpressRoute'                                                  # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            $OpSelect = Read-Host 'Option [#]'                                              # Operator input to select the gateway type
            Clear-Host                                                                      # Clears screen
            if ($Opselect -eq '0') {                                                        # If $OpSelect equals '0'  
                Break SetAzureGatewayType                                                   # Breaks :SetAzureGatewayType
            }                                                                               # End if ($Opselect -eq '0')
            elseif ($Opselect -eq '1') {                                                    # Else if $OpSelect equals '1'
                $GatewayType = 'Vpn'                                                        # Sets the gateway type
            }                                                                               # End elseif ($Opselect -eq '1')
            elseif ($Opselect -eq '2') {                                                    # Else if $OpSelect equals '2'
                $GatewayType = 'ExpressRoute'                                               # Sets the gateway type
            }                                                                               # End elseif ($Opselect -eq '2')
            else {                                                                          # All other inputs for $OpSelect 
                Write-Host 'That was not a valid input'                                     # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Clear-Host                                                                  # Clears screen
            }                                                                               # End else (if ($Opselect -eq '0'))
            if ($GatewayType) {                                                             # If $GatewayType has a value                    
                :Confirm while ($true) {                                                    # Inner loop for confirming the gateway type
                    Write-Host 'Use:'$GatewayType' as the the gateway type'                 # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    $OpConfirm = Read-Host '[Y] Yes [N] No [E] Exit'                        # Operator confirmation of the type
                    Clear-Host                                                              # Clears screen
                    if ($OpConfirm -eq 'y') {                                               # If $OpConfirm equals 'y'
                        Return $GatewayType                                                 # Returns to calling function with $var
                    }                                                                       # End if ($OpConfirm -eq 'y')
                    elseif ($OpConfirm -eq 'n') {                                           # Else if $OpConfirm equals 'n'
                        Break Confirm                                                       # Breaks :Break
                    }                                                                       # End elseif ($OpConfirm -eq 'n') 
                    elseif ($OpConfirm -eq 'e') {                                           # Else if $OpConfirm equals 'e'
                        Break SetAzureGatewayType                                           # Breaks :NewAzureVNGateway
                    }                                                                       # End elseif ($OpConfirm -eq 'e')
                    else {                                                                  # All other inputs for $OpConfirm
                        Write-Host 'That was not a valid input'                             # Write message to screen
                        Write-Host ''                                                       # Write message to screen
                        Pause                                                               # Pauses all actions for operator input
                        Clear-Host                                                          # Clears screen
                    }                                                                       # End else (if ($OpConfirm -eq 'y'))
                }                                                                           # End :Confirm while ($true)
            }                                                                               # End if ($GatewayType)
        }                                                                                   # End :SetAzureGatewayType while ($true) 
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function SetAzGatewayType
function SetAzGatewayVPNSku {                                                               # Function to set a virtual network gateway sku
    Begin {                                                                                 # Begin function
        :SetAzureGatewayVPNSku while ($true) {                                              # Outer loop for managing function
            Write-Host 'Select the gateway sku'                                             # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            $VPNUrl ='https://docs.microsoft.com/en-us/azure/vpn-gateway/vpn-gateway-about-vpn-gateway-settings#gwsku'
            $ERURL = 'https://docs.microsoft.com/en-us/azure/expressroute/expressroute-about-virtual-network-gateways'
            if ($GatewayType -eq 'VPN') {                                                   # If $GatewayType equals 'VPN'
                Write-Host $VPNURL                                                          # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Write-Host '[0]  Exit'                                                      # Write message to screen
                Write-Host '[1]  Basic           (Legacy)'                                  # Write message to screen
                Write-Host '[2]  Standard        (Legacy)'                                  # Write message to screen
                Write-Host '[3]  HighPerformance (Legacy)'                                  # Write message to screen
                Write-Host '[4]  VpnGw1'                                                    # Write message to screen
                Write-Host '[5]  VpnGw2'                                                    # Write message to screen
                Write-Host '[6]  VpnGw3'                                                    # Write message to screen
                Write-Host '[7]  VpnGw4'                                                    # Write message to screen
                Write-Host '[8]  VpnGw5'                                                    # Write message to screen
                <#
                Write-Host '[9]  VpnGw1AZ'                                                  # Write message to screen
                Write-Host '[10] VpnGw2AZ'                                                  # Write message to screen
                Write-Host '[11] VpnGw3AZ'                                                  # Write message to screen
                Write-Host '[12] VpnGw4AZ'                                                  # Write message to screen
                Write-Host '[13] VpnGw5AZ'                                                  # Write message to screen 
                #>
            }                                                                               # End if ($GatewayType -eq 'VPN')
            elseif ($GatewayType -eq 'ExpressRoute') {                                      # Else if $GatewayType equals 'ExpressRoute'
                Write-Host $ERURL                                                           # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Write-Host '[0] Exit'                                                       # Write message to screen
                Write-Host '[2] Standard         (Legacy)'                                  # Write message to screen
                Write-Host '[2] HighPerformance  (Legacy)'                                  # Write message to screen
                Write-Host '[3] UltraPerformance (Legacy)'                                  # Write message to screen
                Write-Host '[4] ErGw1AZ'                                                    # Write message to screen
                Write-Host '[5] ErGw2AZ'                                                    # Write message to screen
                Write-Host '[6] ErGw3AZ'                                                    # Write message to screen
            }                                                                               # End elseif ($GatewayType -eq 'ExpressRoute')
            else {                                                                          # All other values for $GatewayType
                Clear-Host                                                                  # Clears screen
                Write-Host 'A gateway type was not specified'                               # Write message to screen
                Write-Host 'before this function was called'                                # Write message to screen   
                Write-Host ''                                                               # Write message to screen
                Write-Host 'No changes have been made'                                      # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break SetAzureGatewayVPNSku                                                 # Breaks :SetAzureGatewayVPNSku
            }                                                                               # End else (if ($GatewayType -eq 'VPN'))
            Write-Host ''                                                                   # Write message to screen
            $OpSelect = Read-Host 'Option [#]'                                              # Operator input to select the gateway sku
            Clear-Host                                                                      # Clears screen
            if ($Opselect -eq '0') {                                                        # If $OpSelect equals '0'  
                Break SetAzureGatewayVPNSku                                                 # Breaks :SetAzureGatewayVPNSku
            }                                                                               # End if ($Opselect -eq '0')
            if ($GatewayType -eq 'VPN') {                                                   # If $GatewayType equals 'VPN'
                if ($Opselect -eq '1') {                                                    # If $OpSelect equals '1'
                    $GatewaySku = 'Basic'                                                   # Sets the gateway sku
                }                                                                           # End elseif ($Opselect -eq '1')
                elseif ($Opselect -eq '2') {                                                # Else if $OpSelect equals '2'
                    $GatewaySku = 'Standard'                                                # Sets the gateway sku
                }                                                                           # End elseif ($Opselect -eq '2')
                elseif ($Opselect -eq '3') {                                                # Else if $OpSelect equals '3'
                    $GatewaySku = 'HighPerformance'                                         # Sets the gateway sku
                }                                                                           # End elseif ($Opselect -eq '3')
                elseif ($Opselect -eq '4') {                                                # Else if $OpSelect equals '4'
                    $GatewaySku = 'VpnGw1'                                                  # Sets the gateway sku
                }                                                                           # End elseif ($Opselect -eq '4')
                elseif ($Opselect -eq '5') {                                                # Else if $OpSelect equals '5'
                    $GatewaySku = 'VpnGw2'                                                  # Sets the gateway sku
                }                                                                           # End elseif ($Opselect -eq '5')
                elseif ($Opselect -eq '6') {                                                # Else if $OpSelect equals '6'
                    $GatewaySku = 'VpnGw3'                                                  # Sets the gateway sku
                }                                                                           # End elseif ($Opselect -eq '6')
                elseif ($Opselect -eq '7') {                                                # Else if $OpSelect equals '7'
                    $GatewaySku = 'VpnGw4'                                                  # Sets the gateway sku
                }                                                                           # End elseif ($Opselect -eq '7')
                elseif ($Opselect -eq '8') {                                                # Else if $OpSelect equals '8'
                    $GatewaySku = 'VpnGw5'                                                  # Sets the gateway sku
                }                                                                           # End elseif ($Opselect -eq '8')
                <#
                elseif ($Opselect -eq '9') {                                                # Else if $OpSelect equals '9'
                    $GatewaySku = 'VpnGw1AZ'                                                # Sets the gateway sku
                }                                                                           # End elseif ($Opselect -eq '9')
                elseif ($Opselect -eq '10') {                                               # Else if $OpSelect equals '10'
                    $GatewaySku = 'VpnGw2AZ'                                                # Sets the gateway sku
                }                                                                           # End elseif ($Opselect -eq '10')
                elseif ($Opselect -eq '11') {                                               # Else if $OpSelect equals '11'
                    $GatewaySku = 'VpnGw3AZ'                                                # Sets the gateway sku
                }                                                                           # End elseif ($Opselect -eq '11')
                elseif ($Opselect -eq '12') {                                               # Else if $OpSelect equals '12'
                    $GatewaySku = 'VpnGw4AZ'                                                # Sets the gateway sku
                }                                                                           # End elseif ($Opselect -eq '12')
                elseif ($Opselect -eq '13') {                                               # Else if $OpSelect equals '13'
                    $GatewaySku = 'VpnGw5AZ'                                                # Sets the gateway sku
                }                                                                           # End elseif ($Opselect -eq '13')
                #>
                else {                                                                      # All other inputs for $OpSelect 
                    Write-Host 'That was not a valid input'                                 # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Clear-Host                                                              # Clears screen
                }                                                                           # End else (if ($Opselect -eq '1'))   
            }                                                                               # End if ($GatewayType -eq 'VPN')
            else {                                                                          # Else if $GatewayType does not equal 'VPN'
                if ($Opselect -eq '1') {                                                    # If $OpSelect equals '1'
                    $GatewaySku = 'Standard'                                                # Sets the gateway sku
                }                                                                           # End elseif ($Opselect -eq '1')
                elseif ($Opselect -eq '2') {                                                # Else if $OpSelect equals '2'
                    $GatewaySku = 'HighPerformance'                                         # Sets the gateway sku
                }                                                                           # End elseif ($Opselect -eq '2')
                elseif ($Opselect -eq '3') {                                                # Else if $OpSelect equals '3'
                    $GatewaySku = 'UltraPerformance'                                        # Sets the gateway sku
                }                                                                           # End elseif ($Opselect -eq '3')
                elseif ($Opselect -eq '4') {                                                # Else if $OpSelect equals '4'
                    $GatewaySku = 'ErGw1AZ'                                                 # Sets the gateway sku
                }                                                                           # End elseif ($Opselect -eq '4')
                elseif ($Opselect -eq '5') {                                                # Else if $OpSelect equals '5'
                    $GatewaySku = 'ErGw2AZ'                                                 # Sets the gateway sku
                }                                                                           # End elseif ($Opselect -eq '5')
                elseif ($Opselect -eq '6') {                                                # Else if $OpSelect equals '6'
                    $GatewaySku = 'ErGw3AZ'                                                 # Sets the gateway sku
                }                                                                           # End elseif ($Opselect -eq '6')
                else {                                                                      # All other inputs for $OpSelect 
                    Write-Host 'That was not a valid input'                                 # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Clear-Host                                                              # Clears screen
                }                                                                           # End else (if ($Opselect -eq '1'))    
            }                                                                               # End else (if ($GatewayType -eq 'VPN'))
            if ($GatewaySku) {                                                              # If $GatewaySku has a value                    
                :Confirm while ($true) {                                                    # Inner loop for confirming the gateway sku
                    Write-Host 'Use:'$GatewaySku' as the the gateway sku'                   # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    $OpConfirm = Read-Host '[Y] Yes [N] No [E] Exit'                        # Operator confirmation of the sku
                    Clear-Host                                                              # Clears screen
                    if ($OpConfirm -eq 'y') {                                               # If $OpConfirm equals 'y'
                        Return $GatewaySku                                                  # Returns to calling function with $var
                    }                                                                       # End if ($OpConfirm -eq 'y')
                    elseif ($OpConfirm -eq 'n') {                                           # Else if $OpConfirm equals 'n'
                        Break Confirm                                                       # Breaks :Break
                    }                                                                       # End elseif ($OpConfirm -eq 'n') 
                    elseif ($OpConfirm -eq 'e') {                                           # Else if $OpConfirm equals 'e'
                        Break SetAzureGatewayVPNSku                                         # Breaks :SetAzureGatewayVPNSku
                    }                                                                       # End elseif ($OpConfirm -eq 'e')
                    else {                                                                  # All other inputs for $OpConfirm
                        Write-Host 'That was not a valid input'                             # Write message to screen
                        Write-Host ''                                                       # Write message to screen
                        Pause                                                               # Pauses all actions for operator input
                        Clear-Host                                                          # Clears screen
                    }                                                                       # End else (if ($OpConfirm -eq 'y'))
                }                                                                           # End :Confirm while ($true)
            }                                                                               # End if ($GatewaySku)
        }                                                                                   # End :SetAzureGatewayVPNSku while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function SetAzGatewayVPNSku
function SetAzGatewayVPNSkuGen {                                                            # Function to set a virtual network gateway sku generation
    Begin {                                                                                 # Begin function
        $GEN1 =@('Basic','Standard','HighPerformance','VpnGw1','VpnGw2','VpnGw3',`
            'VpnGw1AZ','VpnGw2AZ','VpnGw3AZ')                                               # Creates $Gen1 array
        $Gen2 =@('VpnGw2','VpnGw3','VpnGw4','VpnGw5','VpnGw2AZ','VpnGw3AZ','VpnGw4AZ',`
            'VpnGw5AZ')                                                                     # Creates $Gen2 array
        :SetAzureGWVPNSkuGen while ($true) {                                                # Outer loop for managing function
            Write-Host 'Select the gateway sku generation'                                  # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            $Url ='https://docs.microsoft.com/en-us/azure/vpn-gateway/vpn-gateway-about-vpn-gateway-settings#gwsku'
            Write-Host $URL                                                                 # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            Write-Host 'Gateway SKU:'$GatewaySku                                            # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            Write-Host '[0] Exit'                                                           # Write message to screen
            if ($GatewaySku -in $Gen1) {                                                    # If $GatewaySku is in $Gen1 array
                Write-Host '[1] Gen 1'                                                      # Write message to screen
            }                                                                               # End if ($GatewaySku -in $Gen1)
            else {                                                                          # Else if $GatewaySku is not in $Gen1 array
                Write-Host '[1] Gen 1 (Unavailable)'                                        # Write message to screen
            }                                                                               # End else (if ($GatewaySku -in $Gen1))
            if ($GatewaySku -in $Gen2) {                                                    # If $GatewaySku is in $Gen2 array
                Write-Host '[2] Gen 2'                                                      # Write message to screen
            }                                                                               # End if ($GatewaySku -in $Gen2)
            else {                                                                          # Else if $GatewaySku is not in $Gen2 array
                Write-Host '[2] Gen 2 (Unavailable)'                                        # Write message to screen
            }                                                                               # End else (if ($GatewaySku -in $Gen2))
            Write-Host ''                                                                   # Write message to screen
            $OpSelect = Read-Host 'Option [#]'                                              # Operator input to select the gateway sku
            Clear-Host                                                                      # Clears screen
            if ($Opselect -eq '0') {                                                        # If $OpSelect equals '0'  
                Break SetAzureGWVPNSkuGen                                                   # Breaks :SetAzureGWVPNSkuGen
            }                                                                               # End if ($Opselect -eq '0')
            if ($OpSelect -eq '1') {                                                        # If $OpSelect equals '1'
                if ($GatewaySku -in $Gen1) {                                                # If $GatewaySku is in $Gen1 array
                    $GatewaySkuGen = 'Generation1'                                          # Sets $GatewaySkuGen
                }                                                                           # End if ($GatewaySku -in $Gen1) 
                else {                                                                      # Else if $GatewaySku is not in $Gen1 array
                    Write-Host 'That was not a valid input'                                 # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Clear-Host                                                              # Clears screen
                }                                                                           # End else (if ($GatewaySku -in $Gen1) )
            }                                                                               # End if ($OpSelect -eq '1')
            elseif ($OpSelect -eq '2') {                                                    # Else if $OpSelect equals '2'
                if ($GatewaySku -in $Gen2) {                                                # If $GatewaySku is in $Gen2 array
                    $GatewaySkuGen = 'Generation2'                                          # Sets $GatewaySkuGen
                }                                                                           # End if ($GatewaySku -in $Gen2) 
                else {                                                                      # Else if $GatewaySku is not in $Gen2 array
                    Write-Host 'That was not a valid input'                                 # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Clear-Host                                                              # Clears screen
                }                                                                           # End else (if ($GatewaySku -in $Gen2))               
            }                                                                               # End elseif ($OpSelect -eq '2')
            else {                                                                          # All other inputs for $OpSelect
                Write-Host 'That was not a valid input'                                     # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Clear-Host                                                                  # Clears screen
            }                                                                               # End else (if ($OpSelect -eq '1'))
            if ($GatewaySkuGen) {                                                           # If $GatewaySkuGen has a value                    
                :Confirm while ($true) {                                                    # Inner loop for confirming the gateway sku
                    Write-Host 'Use:'$GatewaySkuGen' as the the gateway sku'                # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    $OpConfirm = Read-Host '[Y] Yes [N] No [E] Exit'                        # Operator confirmation of the sku
                    Clear-Host                                                              # Clears screen
                    if ($OpConfirm -eq 'y') {                                               # If $OpConfirm equals 'y'
                        Return $GatewaySkuGen                                               # Returns to calling function with $var
                    }                                                                       # End if ($OpConfirm -eq 'y')
                    elseif ($OpConfirm -eq 'n') {                                           # Else if $OpConfirm equals 'n'
                        Break Confirm                                                       # Breaks :Break
                    }                                                                       # End elseif ($OpConfirm -eq 'n') 
                    elseif ($OpConfirm -eq 'e') {                                           # Else if $OpConfirm equals 'e'
                        Break SetAzureGWVPNSkuGen                                           # Breaks :SetAzureGWVPNSkuGen
                    }                                                                       # End elseif ($OpConfirm -eq 'e')
                    else {                                                                  # All other inputs for $OpConfirm
                        Write-Host 'That was not a valid input'                             # Write message to screen
                        Write-Host ''                                                       # Write message to screen
                        Pause                                                               # Pauses all actions for operator input
                        Clear-Host                                                          # Clears screen
                    }                                                                       # End else (if ($OpConfirm -eq 'y'))
                }                                                                           # End :Confirm while ($true)
            }                                                                               # End if ($GatewaySkuGen)
        }                                                                                   # End :SetAzureGWVPNSkuGen while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function SetAzGatewayVPNSkuGen
function NewAzVNGatewayIPcon {                                                              # Function to create a new gateway ip configuration
    Begin {                                                                                 # Begin function
        :NewAzureVNGWIPCon while ($true) {                                                  # Outer loop for managing function
            $ValidArray = 'abcdefghijklmnopqrstuvwxyz0123456789-_.'                         # Creates a string of valid characters
            $ValidArray = $ValidArray.ToCharArray()                                         # Loads all valid characters into array
            $Valid1stChar = 'abcdefghijklmnopqrstuvwxyz0123456789'                          # Creates a string of valid first character
            $Valid1stChar = $Valid1stChar.ToCharArray()                                     # Loads all valid characters into array
            $ValidLastChar = 'abcdefghijklmnopqrstuvwxyz0123456789_'                        # Creates a string of valid last character
            $ValidLastChar = $ValidLastChar.ToCharArray()                                   # Loads all valid characters into array
            :SetAzureGWIPName while ($true) {                                               # Inner loop for setting the gateway IP name
                Write-Host 'Enter the gateway IP name'                                      # Write message to screen
                Write-Host ''                                                               # Writes message to screen
                $GWIPNameObject = Read-Host 'Name'                                          # Operator input for the gateway IP config name
                $GWNameArray = $GWIPNameObject.ToCharArray()                                # Loads $GWIPNameObject into array
                Clear-Host                                                                  # Clears screen
                if ($GWIPNameObject.Length -ge 81) {                                        # If $GWIPNameObject.Length is greater or equal to 81
                    Write-Host 'The gateway IP name is to long'                             # Write message to screen
                    Write-Host 'Max length of the name is 80 characters'                    # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    $GWIPNameObject = $null                                                 # Clears $GWIPNameObject
                }                                                                           # End if ($GWIPNameObject.Length -ge 80)
                if ($GWNameArray[0] -notin $Valid1stChar) {                                 # If 0 position of $GWNameArray is not in $Valid1stChar
                    Write-Host 'The first character of the name must be a letter or number' # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    $GWIPNameObject = $null                                                 # Clears $GWIPNameObject
                }                                                                           # End if ($GWNameArray[0] -notin $Valid1stChar)
                if ($GWNameArray[-1] -notin $ValidLastChar) {                               # If last position of $GWNameArray is not in $ValidLastChar
                    Write-Host `
                        'The last character of the name must be a letter, number or _ '     # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    $GWIPNameObject = $null                                                 # Clears $GWIPNameObject
                }                                                                           # End if ($GWNameArray[0] -notin $Valid1stChar)
                foreach ($_ in $GWNameArray) {                                              # For each item in $GWNameArray
                    if ($_ -notin $ValidArray) {                                            # If current item is not in $ValidArray
                        if ($_ -eq ' ') {                                                   # If current item equals 'space'
                            Write-Host ''                                                   # Write message to screen    
                            Write-Host 'Gateway IP name cannot include any spaces'          # Write message to screen
                        }                                                                   # End if ($_ -eq ' ')
                        else {                                                              # If current item is not equal to 'space'
                            Write-Host ''                                                   # Write message to screen    
                            Write-Host $_' is not a valid character'                        # Write message to screen
                        }                                                                   # End else (if ($_ -eq ' '))
                        $GWIPNameObject = $null                                             # Clears $GWIPNameObject
                    }                                                                       # End if ($_ -notin $ValidArray)
                }                                                                           # End foreach ($_ in $GWNameArray)
                if ($GWIPNameObject) {                                                      # If $GWIPNameObject has a value
                    Write-Host 'Use:'$GWIPNameObject' as the gateway IP name'               # Writes message to screen
                    Write-Host ''                                                           # Writes message to screen
                    $OpConfirm = Read-Host '[Y] Yes [N] No [E] Exit'                        # Operator confirmation of the gateway name
                    Clear-Host                                                              # Clears screen
                    if ($OpConfirm -eq 'e') {                                               # If $OpConfirm equals 'e'
                        Break NewAzureVNGWIPCon                                             # Breaks :NewAzureVNGWIPCon
                    }                                                                       # End if ($OpConfirm -eq 'e')
                    if ($OpConfirm -eq 'y') {                                               # If $OpConfirm equals 'y'
                        Break SetAzureGWIPName                                              # Breaks :SetAzureGWIPName
                    }                                                                       # End if ($OpConfirm -eq 'y')
                }                                                                           # End if ($GWIPNameObject)
                else {                                                                      # If $GWIPNameObject does not have a value
                    Pause                                                                   # Pauses all actions for operator input
                    Clear-Host                                                              # Clears screen
                }                                                                           # End else (if ($GWIPNameObject))
            }                                                                               # End :SetAzureGWIPName while ($true)
            :SetVNGWPubIP while ($true) {                                                   # Inner loop to set the public IP sku
                $PublicIPObject = GetAzPublicIpAddress ($CallingFunction)                   # Calls function and assigns output to $var
                if (!$PublicIPObject) {                                                     # If $PublicIPObject is $null
                    Break NewAzureVNGateway                                                 # Breaks :NewAzureVNGateway
                }                                                                           # End if (!$PublicIPObject)
                if ($GatewaySku -notlike '*AZ*') {                                          # If $GatewaySku not like '*AZ*'
                    if ($PublicIPObject.PublicIpAllocationMethod -eq 'Static') {            # If $PublicIPObject.PublicIpAllocationMethod equals 'Static'                
                        Write-Host 'This public IP sku cannot be used'                      # Write message to screen
                        Write-Host ''                                                       # Write message to screen
                        Write-Host 'Please selected a public IP with'                       # Write message to screen
                        Write-Host 'an allocation method of "Dynamic"'                      # Write message to screen
                        Write-Host ''                                                       # Write message to screen
                        Pause                                                               # Pauses all actions for operator input
                        Clear-Host                                                          # Clears screen
                        $PublicIPObject = $null                                             # Clears $var
                    }                                                                       # End if ($PublicIPObject.PublicIpAllocationMethod -eq 'Static')
                }                                                                           # End if ($GatewaySku -notlike '*AZ*') 
                if ($GatewaySku -like '*AZ*') {                                             # If $GatewaySku like '*AZ*'
                    if ($PublicIPObject.PublicIpAllocationMethod -ne 'Static') {            # If $PublicIPObject.PublicIpAllocationMethod does not equal 'Static'                
                        Write-Host 'This public IP sku cannot be used'                      # Write message to screen
                        Write-Host ''                                                       # Write message to screen
                        Write-Host 'Please selected a public IP with'                       # Write message to screen
                        Write-Host 'an allocation method of "Static"'                       # Write message to screen
                        Write-Host ''                                                       # Write message to screen
                        Pause                                                               # Pauses all actions for operator input
                        Clear-Host                                                          # Clears screen
                        $PublicIPObject = $null                                             # Clears $var
                    }                                                                       # End if ($PublicIPObject.PublicIpAllocationMethod -ne 'Static')
                    if ($PublicIPObject.sku.Name -eq 'Basic') {                             # If $PublicIPObject.sku.Name equals 'Basic'               
                        Write-Host 'This public IP sku cannot be used'                      # Write message to screen
                        Write-Host ''                                                       # Write message to screen
                        Write-Host 'Please selected a public IP with'                       # Write message to screen
                        Write-Host 'an sku of "Standard"'                                   # Write message to screen
                        Write-Host ''                                                       # Write message to screen
                        Pause                                                               # Pauses all actions for operator input
                        Clear-Host                                                          # Clears screen
                        $PublicIPObject = $null                                             # Clears $var
                    }                                                                       # End if ($PublicIPObject.sku.Name -eq 'Basic')
                }                                                                           # End if ($GatewaySku -like '*AZ*') 
                if ($PublicIPObject.IpConfiguration.ID) {                                   # If $PublicIPObject.IpConfiguration.ID has a value
                    Write-Host 'This public IP sku cannot be used'                          # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    Write-Host 'Please selected a public IP with'                           # Write message to screen
                    Write-Host 'that is not currently assigned to'                          # Write message to screen
                    Write-Host 'another object'                                             # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Clear-Host                                                              # Clears screen
                    $PublicIPObject = $null                                                 # Clears $var
                }                                                                           # End if ($PublicIPObject.IpConfiguration.ID)
                if ($PublicIPObject) {                                                      # If $PublicIPObject has a value
                    :Confirm while ($true) {                                                # Inner loop for confirming the public IP address
                        Write-Host 'Use:'$PublicIPObject.Name' as the gateway public IP'    # Write message to screen
                        Write-Host ''                                                       # Write message to screen
                        $OpConfirm = Read-Host '[Y] Yes [N] No [E] Exit'                    # Operator input for confirming the public IP address
                        Clear-Host                                                          # Clears screen
                        if ($OpConfirm -eq 'y') {                                           # If $OpConfirm equals 'y'
                            Break SetVNGWPubIP                                              # Breaks :SetVNGWPubIP
                        }                                                                   # End if ($OpConfirm -eq 'y')
                        if ($OpConfirm -eq 'n') {                                           # If $OpConfirm equals 'n'
                            $PublicIPObject = $null                                         # Clears $var
                            Break Confirm                                                   # Breaks :confirm 
                        }                                                                   # End if ($OpConfirm -eq 'n')
                        if ($OpConfirm -eq 'e') {                                           # If $OpConfirm equals 'e'
                            Break NewAzureVNGWIPCon                                         # Breaks :NewAzureVNGWIPCon 
                        }                                                                   # End if ($OpConfirm -eq 'e')
                        else {                                                              # All other inputs for $OpConfirm
                            Write-Host 'That was not a valid input'                         # Write message to screen
                            Write-Host ''                                                   # Write message to screen
                            Pause                                                           # Pauses all actions for operator input
                            Clear-Host                                                      # Clears screen
                        }                                                                   # End else (if ($OpConfirm -eq 'y'))
                    }                                                                       # End :Confirm while ($true)
                }                                                                           # End if ($PublicIPObject)
            }                                                                               # End :SetVNGWPubIP while ($true)  
            Try {                                                                           # Try the following
                $GatewayIPConfig = New-AzVirtualNetworkGatewayIpConfig -Name `
                        $GWIPNameObject -SubnetID $SubnetObject.ID -PublicIpAddressID `
                        $PublicIPObject.ID -ErrorAction 'Stop'                              # Creates the gateway IP config
            }                                                                               # End try
            catch {                                                                         # If Try fails
                Clear-Host                                                                  # Clears screen
                Write-Host 'An error has occured'                                           # Write message to screen
                Write-Host ''                                                               # Write message to screen
                $MSG = $Error[0]                                                            # Gets the error message
                if ($MSG.Exception.InnerException.Body.Message) {                           # If $MSG.Exception.InnerException.Body.Message has a value             
                    $MSG = $MSG.Exception.InnerException.Body.Message                       # Isolates the error message
                    Write-Warning $MSG                                                      # Write message to screen
                    Write-Host ''                                                           # Write message to screen    
                }                                                                           # End if ($MSG.Exception.InnerException.Body.Message)
                else {                                                                      # Else if $MSG.Exception.InnerException.Body.Message is $null
                    Write-Warning $MSG                                                      # Write message to screen
                    Write-Host ''                                                           # Write message to screen        
                }                                                                           # End else (if ($MSG.Exception.InnerException.Body.Message))
                Write-Host 'No changes have been made'                                      # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break NewAzureVNGWIPCon                                                     # Breaks :NewAzureVNGWIPCon    
            }                                                                               # End Catch
            Clear-Host                                                                      # Clears screen
            Write-Host 'The gateway has been created'                                       # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            Pause                                                                           # Pauses all actions for operator input
            Clear-Host                                                                      # Clears screen
            Return $GatewayIPConfig                                                         # Returns to calling function with $var  
        }                                                                                   # End :NewAzureVNGWIPCon while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End begin
}                                                                                           # End function NewAzVNGatewayIPcon
function GetAzPublicIpAddress {                                                             # Function for getting a public IP sku
    Begin {                                                                                 # Begin function
        :GetAzurePublicIP while ($true) {                                                   # Outer loop for managing function
            $ObjectList = Get-AzPublicIpAddress                                             # Gets a list of all public IP address
            if (!$ObjectList) {                                                             # If $ObjectList is $null
                Write-Host 'No public IP skus are present in this subscription'             # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break GetAzurePublicIP                                                      # Breaks :GetAzurePublicIP
            }                                                                               # End if (!$ObjectList)
            [System.Collections.ArrayList]$ObjectArray = @()                                # Creates array for list to be loaded into
            $ObjectNumber = 1                                                               # Creates #var used for list selection
            foreach ($_ in $ObjectList) {                                                   # For each item in $ObjectList
                if ($_.IpConfiguration.Id) {                                                # If current item .IpConfiguration.Id has a value
                    $AttachedNIC = ($_.IpConfiguration.Id).Split('/')[-3]                   # Gets the attached NIC name
                    $AttachedNICIPConfig = ($_.IpConfiguration.Id).Split('/')[-1]           # Gets the attached NIC IP config name
                }                                                                           # End if ($_.IpConfiguration.Id) 
                $ObjectInput = [PSCustomObject]@{                                           # Custom item to load into array
                    'Number'=$ObjectNumber;'Name'=$_.Name;'RG'=$_.ResourceGroupName;`
                    'Sku'=$_.Sku.Name;'Allocation'=$_.PublicIpAllocationMethod;`
                    'Address'=$_.IPAddress;'NIC'=$AttachedNIC;`
                    'IPconfig'=$AttachedNICIPConfig                                         # Creates the item list to load int array
                }                                                                           # End $ObjectInput = [PSCustomObject]@
                $ObjectArray.Add($ObjectInput) | Out-Null                                   # Loads item into array, out-null removes write to screen
                $ObjectNumber = $ObjectNumber + 1                                           # Increments $var up by 1
                $AttachedNIC = $null                                                        # Clears $var
                $AttachedNICIPConfig = $null                                                # Clears $var
            }                                                                               # End foreach ($_ in $ObjectList)
            :SelectAzurePublicIP while ($true) {                                            # Inner loop for selecting the public IP
                Write-Host ''                                                               # Write message to screen
                Write-Host '[0]          Exit'                                              # Write message to screen
                Write-Host ''                                                               # Write message to screen
                foreach ($_ in $ObjectArray) {                                              # For each item in $ObjectArray
                    $Number = $_.Number                                                     # Creats $Number (Used for formating)
                    if ($Number -le 9) {                                                    # If $Number is 9 or less
                        Write-Host "[$Number]         "$_.Name                              # Write message to screen
                    }                                                                       # End if ($Number -le 9)
                    else {                                                                  # If $Number is greater than 9
                        Write-Host "[$Number]        "$_.Name                               # Write message to screen    
                    }                                                                       # End else if ($Number -le 9)
                    Write-Host 'RG Name:    '$_.RG                                          # Write message to screen
                    Write-Host 'Allocation: '$_.Allocation                                  # Write message to screen
                    Write-Host 'IP Address: '$_.address                                     # Write message to screen
                    Write-Host 'SKU Type:   '$_.Sku                                         # Write message to screen
                    if ($_.Nic) {                                                           # If current item .Nic has a value
                        Write-Host 'NIC Name:   '$_.Nic                                     # Write message to screen
                        Write-Host 'NIC Config: '$_.IPConfig                                # Write message to screen
                    }                                                                       # End if ($_.Nic)                                 
                    Write-Host ''                                                           # Write message to screen
                }                                                                           # End foreach ($_ in $ObjectArray) 
                if ($CallingFunction) {                                                     # If $Calling function has a value
                    Write-Host 'You are selecting the Public IP Sku for:'$CallingFunction   # Write message to screen
                }                                                                           # End if ($CallingFunction)
                $OpSelect = Read-Host 'Option [#]'                                          # Operator input for the public IP selection
                Clear-Host                                                                  # Clears screen
                if ($OpSelect -eq '0') {                                                    # If $var equals 0
                    Break GetAzurePublicIP                                                  # Breaks :GetAzurePublicIP
                }                                                                           # End if ($OpSelect -eq '0')
                elseif ($OpSelect -in $ObjectArray.Number) {                                # If $OpSelect in $ObjectArray.Number list
                    $OpSelect = $ObjectArray | Where-Object `
                        {$_.Number -eq $OpSelect}                                           # $OpSelect is equal to $ObjectArray where $ObjectArray.Number equals $OpSelect
                    $PublicIPObject = Get-AzPublicIpAddress -Name $OpSelect.Name `
                        -ResourceGroupName $OpSelect.RG                                     # Pulls $PublicIPObject
                    Return $PublicIPObject                                                  # Returns to calling function with $PublicIPObject
                }                                                                           # End elseif ($OpSelect -in $ObjectArray.Number)
                else {                                                                      # All other values
                    Write-Host 'That was not a valid input'                                 # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Clear-Host                                                              # Clears screen
                }                                                                           # End else (if ($OpSelect -eq '0'))
            }                                                                               # End :SelectAzurePublicIP while ($true)
        }                                                                                   # End :GetAzurePublicIP while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End begin
}                                                                                           # End function GetAzPublicIpAddress
function GetAzVirtualNetwork {                                                              # Function for getting an Azure virtual network
    Begin {                                                                                 # Begin function
        :GetAzureVnet while ($true) {                                                       # Outer loop for managing function
            $ObjectList = Get-AzVirtualNetwork                                              # pulls all items into list for selection
            if (!$ObjectList) {                                                             # If $ObjectList is $null
                Write-Host ''                                                               # Write message to screen
                Write-Host 'No virtual networks present in this subscription'               # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break GetAzureVnet                                                          # Breaks :GetAzureVnet
            }                                                                               # End if (!$ObjectList)
            $ListNumber = 1                                                                 # $var used for selecting the virtual network
            [System.Collections.ArrayList]$ObjectArray = @()                                # Creates the RG list array
            foreach ($_ in $ObjectList) {                                                   # For each $_ in $RGListList
                $ArrayInput = [PSCustomObject]@{'Number' = $ListNumber; 'Name' = $_.Name; `
                    'RG' = $_.ResourceGroupName; 'Location' = $_.Location; 'ASpace' = `
                    $_.AddressSpace.AddressPrefixes}                                        # Creates the item to loaded into array
                $ObjectArray.Add($ArrayInput) | Out-Null                                    # Loads item into array, out-null removes write to screen
                $ListNumber = $ListNumber + 1                                               # Increments $RGListNumber by 1
            }                                                                               # End foreach ($_ in $RGList)
            :SelectAzureVNet while ($true) {                                                # Inner loop for selecting the Vnet
                Write-Host '[0]  Exit'                                                      # Write message to screen
                Write-Host ''                                                               # Write message to screen
                foreach ($_ in $ObjectArray) {                                              # For each item in $ObjectArray
                    $Number = $_.Number                                                     # $Number is equal to current item .number
                    if ($Number -le 9) {                                                    # If $number is 9 or less
                        Write-Host "[$Number]      "$_.Name                                 # Write message to screen
                    }                                                                       # End if ($Number -le 9)
                    else {                                                                  # If $number is greater than 9
                        Write-Host "[$Number]     "$_.Name                                  # Write message to screen
                    }                                                                       # End else (if ($Number -le 9))
                    Write-Host 'RG:      '$_.RG                                             # Write message to screen
                    Write-Host 'Loc:     '$_.Location                                       # Write message to screen
                    Write-Host 'A Space: '$_.ASpace                                         # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                }                                                                           # End foreach ($Name in $Array)    
                if ($CallingFunction) {                                                     # If $CallingFunction has a value
                    Write-Host 'Selecting the VNet for:'$CallingFunction                    # Write message to screen
                }                                                                           # End if ($CallingFunction)
                $OpSelect = Read-Host 'Option [#]'                                          # Operator input for the VNet selection
                Clear-Host                                                                  # Clears screen
                if ($OpSelect -eq '0') {                                                    # If $OpSelect equals 0
                    Break GetAzureVNet                                                      # Breaks :GetAzureVNet
                }                                                                           # End if ($OpSelect -eq '0')
                elseif ($OpSelect -in $ObjectArray.Number) {                                # Else if $OpSelect is in $ObjectArray.Number
                    $OpSelect = $ObjectArray | Where-Object {$_.Number -eq $OpSelect}       # $OpSelect is equal to $ObjectArray where $OpSelect equals $ObjectArray.Number
                    $VNetObject = Get-AzVirtualNetwork -Name $OpSelect.Name `
                        -ResourceGroupName $OpSelect.RG                                     # Pulls the full object and assigns to $var
                        Return $VNetObject                                                  # Returns to calling function with $var
                }                                                                           # End elseif ($OpSelect -in $ObjectArray.Number)
                else {                                                                      # All other inputs for $OpSelect
                    Write-Host 'That was not a valid input'                                 # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Clear-Host                                                              # Clears screen
                }                                                                           # End else (if ($OpSelect -eq '0'))
            }                                                                               # End :SelectAzureVNet while ($true)
        }                                                                                   # End :GetAzureVnet while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function GetAzVirtualNetwork