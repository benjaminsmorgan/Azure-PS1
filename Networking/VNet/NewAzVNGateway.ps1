# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Microsoft docs links
    Get-AzVirtualNetworkSubnetConfig:           https://docs.microsoft.com/en-us/powershell/module/az.network/get-azvirtualnetworksubnetconfig?view=azps-5.4.0
    Get-AzVirtualNetwork:                       https://docs.microsoft.com/en-us/powershell/module/az.network/get-azvirtualnetwork?view=azps-5.4.0
} #>
<# Required Functions Links: {
    None
} #>
<# Functions Description: {
    GetAzVNetSubnetConfig:      Gets an azure virtual network subnet
} #>
<# Variables: {
    :GetAzureSubnet             Outer loop for managing function
    :SelectAzureSubNet          Inner loop for selecting the subnet
    $ObjectList:                List of all virtual networks
    $ObjectNumber:              $var used to number an item in $ObjectArray
    $ObjectArray:               Array of subnet object
    $VNet:                      $Var holding the current Vnet name
    $VnetPFX:                   $Var holding the current Vnet prefix
    $VNetRG:                    $Var holding the current Vnet resource group name
    $SubnetList:                List of subnets in the current vnet
    $ListInput:                 $Var used to load items into $ObjectArray
    $Number:                    The current item .number, used for formating
    $OpSelect:                  Operator input to select the subnet
    $VNetObject:                The Vnet holding the selected subnet
    $SubnetObject:              The subnet object
} #>
<# Process Flow {
    Function
        Call GetAzVNetSubnetConfig > Get $SubnetObject, $VNetObject
        End GetAzVNetSubnetConfig
            Return Function > Send $SubnetObject, $VNetObject
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
                    Write-Host 'Use:'$GWNameObject' as the gateway name'                    # Writes message to screen
                    Write-Host ''                                                           # Writes message to screen
                    $OpConfirm = Read-Host '[Y] Yes [N] No [E] Exit'                        # Operator confirmation of the gateway name
                    Clear-Host                                                              # Clears screen
                    if ($OpConfirm -eq 'e') {                                               # If $OpConfirm equals 'e'
                        Break NewAzureVNGateway                                             # Breaks :NewAzureVNGateway
                    }                                                                       # End if ($OpConfirm -eq 'e')
                    if ($OpConfirm -eq 'y') {                                               # If $OpConfirm equals 'y'
                        Break SetAzureGWName                                                # Breaks :SetAzureGWName
                    }                                                                       # End if ($OpConfirm -eq 'y')
                }                                                                           # End if ($GWNameObject)
                else {                                                                      # If $GWNameObject does not have a value
                    Pause                                                                   # Pauses all actions for operator input
                    Clear-Host                                                              # Clears screen
                }                                                                           # End else (if ($GWNameObject))
            }                                                                               # End :SetAzureGWName while ($true)
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
                        Break NewAzureVNGateway                                             # Breaks :NewAzureVNGateway
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
                        $CID = $ID.split('/')[7]                                            # Isolates the IP config type
                        if ($CID -eq 'virtualNetworkGateways') {                            # If $CID equals 'virtualNetworkGateways'
                            Write-Host 'A network gateway already exists on this VNet'      # Write message to screen
                            Write-Host ''                                                   # Write message to screen
                            Write-Host 'Please remove this gateway or select another VNet'  # Write message to screen
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
            :SetAzureGatewayType while ($true) {                                            # Inner loop for setting the gateway type
                Write-Host 'Select the gateway type'                                        # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Write-Host '[0]  Exit'                                                      # Write message to screen
                Write-Host '[1]  Vpn'                                                       # Write message to screen
                Write-Host '[2]  ExpressRoute'                                              # Write message to screen
                Write-Host ''                                                               # Write message to screen
                $OpSelect = Read-Host 'Option [#]'                                          # Operator input to select the gateway type
                Clear-Host                                                                  # Clears screen
                if ($Opselect -eq '0') {                                                    # If $OpSelect equals '0'  
                    Break NewAzureVNGateway                                                 # Breaks :NewAzureVNGateway
                }                                                                           # End if ($Opselect -eq '0')
                elseif ($Opselect -eq '1') {                                                # Else if $OpSelect equals '1'
                    $GatewayType = 'Vpn'                                                    # Sets the gateway type
                }                                                                           # End elseif ($Opselect -eq '1')
                elseif ($Opselect -eq '2') {                                                # Else if $OpSelect equals '2'
                    $GatewayType = 'ExpressRoute'                                           # Sets the gateway type
                }                                                                           # End elseif ($Opselect -eq '2')
                else {                                                                      # All other inputs for $OpSelect 
                    Write-Host 'That was not a valid input'                                 # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Clear-Host                                                              # Clears screen
                }                                                                           # End else (if ($Opselect -eq '0'))
                if ($GatewayType) {                                                         # If $GatewayType has a value                    
                    :Confirm while ($true) {                                                # Inner loop for confirming the gateway type
                        Write-Host 'Use:'$GatewayType' as the the gateway type'             # Write message to screen
                        Write-Host ''                                                       # Write message to screen
                        $OpConfirm = Read-Host '[Y] Yes [N] No [E] Exit'                    # Operator confirmation of the type
                        Clear-Host                                                          # Clears screen
                        if ($OpConfirm -eq 'y') {                                           # If $OpConfirm equals 'y'
                            Break SetAzureGatewayType                                       # Breaks :SetAzureGatewayType
                        }                                                                   # End if ($OpConfirm -eq 'y')
                        elseif ($OpConfirm -eq 'n') {                                       # Else if $OpConfirm equals 'n'
                            Break Confirm                                                   # Breaks :Break
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
                }                                                                           # End if ($GatewayType)
            }                                                                               # End :SetAzureGatewayType while ($true)   
            :SetAzureGatewaySku while ($true) {                                             # Inner loop for setting the gateway sku
                Write-Host 'Select the gateway sku'                                         # Write message to screen
                Write-Host ''                                                               # Write message to screen
                $Url ='https://docs.microsoft.com/en-us/azure/vpn-gateway/vpn-gateway-about-vpn-gateway-settings#gwsku'
                Write-Host $URL                                                             # Write message to screen
                Write-Host '[0]  Exit'                                                      # Write message to screen
                Write-Host '[1]  Basic'                                                     # Write message to screen
                Write-Host '[2]  Standard'                                                  # Write message to screen
                Write-Host '[3]  HighPerformance'                                           # Write message to screen
                Write-Host '[4]  UltraPerformance'                                          # Write message to screen
                Write-Host '[5]  VpnGw1'                                                    # Write message to screen
                Write-Host '[6]  VpnGw2'                                                    # Write message to screen
                Write-Host '[7]  VpnGw3'                                                    # Write message to screen
                Write-Host '[8]  VpnGw4'                                                    # Write message to screen
                Write-Host '[9]  VpnGw5'                                                    # Write message to screen
                Write-Host '[10] VpnGw1AZ'                                                  # Write message to screen
                Write-Host '[11] VpnGw2AZ'                                                  # Write message to screen
                Write-Host '[12] VpnGw3AZ'                                                  # Write message to screen
                Write-Host '[13] VpnGw4AZ'                                                  # Write message to screen
                Write-Host '[14] VpnGw5AZ'                                                  # Write message to screen
                Write-Host '[15] ErGw1AZ'                                                   # Write message to screen
                Write-Host '[16] ErGw2AZ'                                                   # Write message to screen
                Write-Host '[17] ErGw3AZ'                                                   # Write message to screen
                Write-Host ''                                                               # Write message to screen
                $OpSelect = Read-Host 'Option [#]'                                          # Operator input to select the gateway sku
                Clear-Host                                                                  # Clears screen
                if ($Opselect -eq '0') {                                                    # If $OpSelect equals '0'  
                    Break NewAzureVNGateway                                                 # Breaks :NewAzureVNGateway
                }                                                                           # End if ($Opselect -eq '0')
                elseif ($Opselect -eq '1') {                                                # Else if $OpSelect equals '1'
                    $GatewaySku = 'Basic'                                                   # Sets the gateway sku
                }                                                                           # End elseif ($Opselect -eq '1')
                elseif ($Opselect -eq '2') {                                                # Else if $OpSelect equals '2'
                    $GatewaySku = 'Standard'                                                # Sets the gateway sku
                }                                                                           # End elseif ($Opselect -eq '2')
                elseif ($Opselect -eq '3') {                                                # Else if $OpSelect equals '3'
                    $GatewaySku = 'HighPerformance'                                         # Sets the gateway sku
                }                                                                           # End elseif ($Opselect -eq '3')
                elseif ($Opselect -eq '4') {                                                # Else if $OpSelect equals '4'
                    $GatewaySku = 'UltraPerformance'                                        # Sets the gateway sku
                }                                                                           # End elseif ($Opselect -eq '4')
                elseif ($Opselect -eq '5') {                                                # Else if $OpSelect equals '5'
                    $GatewaySku = 'VpnGw1'                                                  # Sets the gateway sku
                }                                                                           # End elseif ($Opselect -eq '5')
                elseif ($Opselect -eq '6') {                                                # Else if $OpSelect equals '6'
                    $GatewaySku = 'VpnGw2'                                                  # Sets the gateway sku
                }                                                                           # End elseif ($Opselect -eq '6')
                elseif ($Opselect -eq '7') {                                                # Else if $OpSelect equals '7'
                    $GatewaySku = 'VpnGw3'                                                  # Sets the gateway sku
                }                                                                           # End elseif ($Opselect -eq '7')
                elseif ($Opselect -eq '8') {                                                # Else if $OpSelect equals '8'
                    $GatewaySku = 'VpnGw4'                                                  # Sets the gateway sku
                }                                                                           # End elseif ($Opselect -eq '8')
                elseif ($Opselect -eq '9') {                                                # Else if $OpSelect equals '9'
                    $GatewaySku = 'VpnGw5'                                                  # Sets the gateway sku
                }                                                                           # End elseif ($Opselect -eq '9')
                elseif ($Opselect -eq '10') {                                               # Else if $OpSelect equals '10'
                    $GatewaySku = 'VpnGw1AZ'                                                # Sets the gateway sku
                }                                                                           # End elseif ($Opselect -eq '10')
                elseif ($Opselect -eq '11') {                                               # Else if $OpSelect equals '11'
                    $GatewaySku = 'VpnGw2AZ'                                                # Sets the gateway sku
                }                                                                           # End elseif ($Opselect -eq '11')
                elseif ($Opselect -eq '12') {                                               # Else if $OpSelect equals '12'
                    $GatewaySku = 'VpnGw3AZ'                                                # Sets the gateway sku
                }                                                                           # End elseif ($Opselect -eq '12')
                elseif ($Opselect -eq '13') {                                               # Else if $OpSelect equals '13'
                    $GatewaySku = 'VpnGw4AZ'                                                # Sets the gateway sku
                }                                                                           # End elseif ($Opselect -eq '13')
                elseif ($Opselect -eq '14') {                                               # Else if $OpSelect equals '14'
                    $GatewaySku = 'VpnGw5AZ'                                                # Sets the gateway sku
                }                                                                           # End elseif ($Opselect -eq '14')
                elseif ($Opselect -eq '15') {                                               # Else if $OpSelect equals '15'
                    $GatewaySku = 'ErGw1AZ'                                                 # Sets the gateway sku
                }                                                                           # End elseif ($Opselect -eq '15')
                elseif ($Opselect -eq '16') {                                               # Else if $OpSelect equals '16'
                    $GatewaySku = 'ErGw2AZ'                                                 # Sets the gateway sku
                }                                                                           # End elseif ($Opselect -eq '16')
                elseif ($Opselect -eq '17') {                                               # Else if $OpSelect equals '17'
                    $GatewaySku = 'ErGw3AZ'                                                 # Sets the gateway sku
                }                                                                           # End elseif ($Opselect -eq '17')
                else {                                                                      # All other inputs for $OpSelect 
                    Write-Host 'That was not a valid input'                                 # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Clear-Host                                                              # Clears screen
                }                                                                           # End else (if ($Opselect -eq '0'))
                if ($GatewaySku) {                                                          # If $GatewaySku has a value                    
                    :Confirm while ($true) {                                                # Inner loop for confirming the gateway sku
                        Write-Host 'Use:'$GatewaySku' as the the gateway sku'               # Write message to screen
                        Write-Host ''                                                       # Write message to screen
                        $OpConfirm = Read-Host '[Y] Yes [N] No [E] Exit'                    # Operator confirmation of the sku
                        Clear-Host                                                          # Clears screen
                        if ($OpConfirm -eq 'y') {                                           # If $OpConfirm equals 'y'
                            Break SetAzureGatewaySku                                        # Breaks :SetAzureGatewaySku
                        }                                                                   # End if ($OpConfirm -eq 'y')
                        elseif ($OpConfirm -eq 'n') {                                       # Else if $OpConfirm equals 'n'
                            Break Confirm                                                   # Breaks :Break
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
                }                                                                           # End if ($GatewaySku)
            }                                                                               # End :SetAzureGatewaySku while ($true)            
            $PublicIPObject = GetAzPublicIpAddress ($CallingFunction)                       # Calls function and assigns output to $var
            if (!$PublicIPObject) {                                                         # If $PublicIPObject is $null
                Break NewAzureVNGateway                                                     # Breaks :NewAzureVNGateway
            }                                                                               # End if (!$PublicIPObject)
            Try {                                                                           # Try the following
                Write-Host 'Creating the gateway IP config'                                 # End # Write message to screen
                $GatewayIPConfig = New-AzVirtualNetworkGatewayIpConfig -Name `
                    $GWIPNameObject -SubnetID $SubnetObject.ID -PublicIpAddressID `
                    $PublicIPObject.ID -ErrorAction 'Stop'                                  # Creates the gateway IP config
                Write-Host 'Creating the gateway'                                           # End # Write message to screen
                Write-Host 'This will take awhile'                                          # End # Write message to screen
                New-AzVirtualNetworkGateway -Name $GWNameObject -ResourceGroupName `
                    $VNetObject.ResourceGroupName -Location $VNetObject.Location `
                    -GatewaySku $GatewaySku -IpConfigurations $GatewayIPConfig `
                    -ErrorAction 'Stop' | Out-Null                                          # Creates the gateway
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
