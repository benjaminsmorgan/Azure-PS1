# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Microsoft docs links
    Get-AzResource:                             https://docs.microsoft.com/en-us/powershell/module/az.resources/get-azresource?view=azps-6.3.0
    Get-AzVirtualNetworkGateway:                https://docs.microsoft.com/en-us/powershell/module/az.network/get-azvirtualnetworkgateway?view=azps-6.3.0
    Remove-AzVirtualNetworkGateway:             https://docs.microsoft.com/en-us/powershell/module/az.network/remove-azvirtualnetworkgateway?view=azps-6.3.0
} #>
<# Required Functions Links: {
    NewAzVNGateway:             https://github.com/benjaminsmorgan/Azure-Powershell/tree/main/Networking/Gateway/NewAzVNGateway.ps1
    ListAzVNGateway:            https://github.com/benjaminsmorgan/Azure-Powershell/tree/main/Networking/Gateway/ListAzVNGateway.ps1
    RemoveAzVNGateway:          https://github.com/benjaminsmorgan/Azure-Powershell/tree/main/Networking/Gateway/RemoveAzVNGateway.ps1
    GetAzVNGateway:             https://github.com/benjaminsmorgan/Azure-Powershell/tree/main/Networking/Gateway/GetAzVNGateway.ps1
} #>
<# Functions Description: {
    ManageAzVNGateway:          Function to manage virtual network gateways
    NewAzVNGateway:             Function to create a virtual network gateway
    ListAzVNGateway:            Function to list virtual network gateways
    RemoveAzVNGateway:          Function to remove a virtual network gateway
    GetAzVNGateway:             Function to get virtual network gateway
} #>
<# Variables: {      
    :ManageAzureGateway         Outer loop for managing function
    $OpSelect:                  Operator input to select the management function
    NewAzVNGateway{}            Creates $GatewayObject
    ListAzVNGateway{}           Lists $GatewayObjects
    RemoveAzVNGateway{}         Removes $GatewayObject
        GetAzVNGateway{}            Gets $GatewayObject
} #>
<# Process Flow {
    function
        Call ManageAzVNGateway > Get $null
            Call NewAzVNGateway > Get $null

            End NewAzVNGateway
                Return ManageAzVNGateway > Send $null
            Call ListAzVNGateway > Get $null            
            End ListAzVNGateway
                Return ManageAzVNGateway > Send $null
            Call RemoveAzVNGateway > Get $null
                Call GetAzVNGateway > Get $GatewayObject            
                End GetAzVNGateway
                    Return RemoveAzVNGateway > Send $GatewayObject
            End RemoveAzVNGateway
                Return ManageAzVNGateway > Send $null                
            
        End ManageAzVNGateway
            Return function > Send $null
}#>
function ManageAzVNGateway {                                                                # Function to manage virtual network gateways
    Begin {                                                                                 # Begin function
        :ManageAzureGateway while ($true) {                                                 # Outer loop for managing function
            Write-Host 'Manage Gateways'                                                    # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            Write-Host '[0] Exit'                                                           # Write message to screen
            Write-Host '[1] New Gateway'                                                    # Write message to screen
            Write-Host '[2] List Gateways'                                                  # Write message to screen
            Write-Host '[3] Remove Gateway'                                                 # Write message to screen
            Write-Host '[4] Manage Gateway Configs (In dev)'                                # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            $OpSelect = Read-Host 'Option [#]'                                              # Operator selection for management function
            Clear-Host                                                                      # Clears screen
            if ($OpSelect -eq '0') {                                                        # If $OpSelect equals '0'
                Break ManageAzureGateway                                                    # Breaks :ManageAzureGateway
            }                                                                               # End if ($OpSelect -eq '0')
            elseif ($OpSelect -eq '1') {                                                    # Else if $OpSelect equals '1'
                Write-Host 'New Gateway'                                                    # Write message to screen
                NewAzVNGateway                                                              # Calls function
            }                                                                               # End elseif ($OpSelect -eq '1') 
            elseif ($OpSelect -eq '2') {                                                    # Else if $OpSelect equals '2'
                Write-Host 'List Gateways'                                                  # Write message to screen
                ListAzVNGateway                                                             # Calls function
            }                                                                               # End elseif ($OpSelect -eq '2') 
            elseif ($OpSelect -eq '3') {                                                    # Else if $OpSelect equals '3'
                Write-Host 'Remove Gateway'                                                 # Write message to screen
                RemoveAzVNGateway                                                           # Calls function
            }                                                                               # End elseif ($OpSelect -eq '3') 
            elseif ($OpSelect -eq '4') {                                                    # Else if $OpSelect equals '4'
                Write-Host 'Manage Gateway Configs'                                         # Write message to screen
                #Function                                                            # Calls function
            }                                                                               # End elseif ($OpSelect -eq '4') 
            else {                                                                          # All other inputs for $OpSelect
                Write-Host 'That was not a valid input'                                     # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Clear-Host                                                                  # Clears screen
            }                                                                               # End else (if ($OpSelect -eq '0'))
        }                                                                                   # End :ManageAzureGateway while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function ManageAzVNGateway
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
            :SetAzureGatewaySku while ($true) {                                             # Inner loop for setting the gateway sku
                Write-Host 'Select the gateway sku'                                         # Write message to screen
                Write-Host ''                                                               # Write message to screen
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
function ListAzVNGateway {                                                                  # Function to list all virtual network gateways
    Begin {                                                                                 # Begin function
        :GetAzureGateway while ($true) {                                                    # Outer loop for managing function
            Write-Host 'Gathering gateway info'                                             # Write message to screen
            Write-Host 'This may take a moment'                                             # Write message to screen
            $ObjectList = Get-AzResource | Where-Object `
                {$_.ResourceType -eq 'Microsoft.Network/virtualNetworkGateways'}            # Gets a list of all gateways
            if (!$ObjectList) {                                                             # If $ObjectList is $null
                Clear-Host                                                                  # Clears screen
                Write-Host 'No gateways present in this subscription'                       # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Write-Host 'If the gateway was just created, please retry in 15 minutes'    # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break GetAzureGateway                                                       # Breaks :GetAzureGateway
            }                                                                               # End if (!$ObjectList)
            [System.Collections.ArrayList]$ObjectArray = @()                                # Creates object list array
            foreach ($_ in $ObjectList) {                                                   # For each item in $ObjectList
                $CGateway = Get-AzVirtualNetworkGateway -Name $_.Name -ResourceGroupName `
                    $_.ResourceGroupName                                                    # Gets current object gateway info
                $VNetName = $CGateway.IPConfigurations.Subnet.ID.Split('/')[8]              # Isolates the Vnet name
                $PubIPName = $CGateway.IPConfigurations.PublicIPAddress.ID.Split('/')[-1]   # Isolates the public IP name
                $ObjectInput = [PSCustomObject]@{                                           # custom object to add info to $ObjectArray
                    'Number'=$ObjectNumber;                                                 # Object number
                    'Name'=$CGateway.Name;                                                  # Gateway name
                    'RG'=$CGateway.ResourceGroupName;                                       # Gateway resource group name
                    'Location'=$CGateway.Location;                                          # Gateway location
                    'Vnet'=$VNetName;                                                       # Vnet name
                    'PubIP'=$PubIPName                                                      # Public IP name
                    'GType'=$CGateway.GatewayType;                                          # Gateway type
                    'VPNType'=$CGateway.VPNType;                                            # Gateway VPN type
                    'EnableBgp'=$CGateway.EnableBgp;                                        # Gateway EnableBgp
                    'GDefaultSite'=$CGateway.GatewayDefaultSite;                            # Gateway default site
                    'SkuCap'=$CGateway.Sku.Capacity;                                        # Gateway sku capacity
                    'SkuName'=$CGateway.Sku.Name;                                           # Gateway sku name
                    'SkuTier'=$CGateway.Sku.Tier                                            # Gateway tier
                }                                                                           # End $ObjectInput = [PSCustomObject]@
                $ObjectArray.Add($ObjectInput) | Out-Null                                   # Adds $ObjectInput to $ObjectArray
                $CGateway = $null                                                           # Clears $var
                $VNetName = $null                                                           # Clears $var
                $PubIPName = $null                                                          # Clears $var
            }                                                                               # End foreach ($_ in $ObjectList)
            Clear-Host                                                                      # Clears screen
            foreach ($_ in $ObjectArray) {                                                  # For each item in $ObjectArray
                Write-Host 'Gateway Name:   '$_.Name                                        # Write message to screen
                Write-Host 'Vnet Name:      '$_.VNet                                        # Write message to screen
                Write-Host 'Gateway RG:     '$_.RG                                          # Write message to screen
                Write-Host 'Gateway Loc:    '$_.Location                                    # Write message to screen
                Write-Host 'Pub IP Name:    '$_.PubIP                                       # Write message to screen
                Write-Host 'Gateway Type:   '$_.Gtype                                       # Write message to screen
                Write-Host 'GW VPN Type:    '$_.VPNtype                                     # Write message to screen
                Write-Host 'Gateway Sku:    '$_.SkuName                                     # Write message to screen
                if ($_.GDefaultSite) {                                                      # If $_.GDefaultSite has a value
                    Write-Host 'GW Default Site:'$_.GDefaultSite                            # Write message to screen
                }                                                                           # End if ($_.GDefaultSite) 
                else  {                                                                     # Else if $_.GDefaultSite is $null
                    Write-Host 'GW Default Site: N/A'                                       # Write message to screen
                }                                                                           # End if ($_.GDefaultSite) 
                Write-Host 'EnableBgp:      '$_.EnableBgp                                   # Write message to screen                    
                Write-Host ''                                                               # Write message to screen
            }                                                                               # End foreach ($_ in $ObjectArray)
            Pause                                                                           # Pauses all actions for operator input
            Break GetAzureGateway                                                           # Breaks :GetAzureGateway
        }                                                                                   # End :GetAzureGateway while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End begin
}                                                                                           # End function ListAzVNGateway
function GetAzVNGateway {                                                                   # Function to get a virtual network gateway
    Begin {                                                                                 # Begin function
        :GetAzureGateway while ($true) {                                                    # Outer loop for managing function
            Write-Host 'Gathering gateway info'                                             # Write message to screen
            Write-Host 'This may take a moment'                                             # Write message to screen
            $ObjectList = Get-AzResource | Where-Object `
                {$_.ResourceType -eq 'Microsoft.Network/virtualNetworkGateways'}            # Gets a list of all gateways
            if (!$ObjectList) {                                                             # If $ObjectList is $null
                Clear-Host                                                                  # Clears screen
                Write-Host 'No gateways present in this subscription'                       # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Write-Host 'If the gateway was just created, please retry in 15 minutes'    # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break GetAzureGateway                                                       # Breaks :GetAzureGateway
            }                                                                               # End if (!$ObjectList)
            $ObjectNumber = 1                                                               # Sets $ObjectNumber
            [System.Collections.ArrayList]$ObjectArray = @()                                # Creates object list array
            foreach ($_ in $ObjectList) {                                                   # For each item in $ObjectList
                $CGateway = Get-AzVirtualNetworkGateway -Name $_.Name -ResourceGroupName `
                    $_.ResourceGroupName                                                    # Gets current object gateway info
                $VNetName = $CGateway.IPConfigurations.Subnet.ID.Split('/')[8]              # Isolates the Vnet name
                $PubIPName = $CGateway.IPConfigurations.PublicIPAddress.ID.Split('/')[-1]   # Isolates the public IP name
                $ObjectInput = [PSCustomObject]@{                                           # custom object to add info to $ObjectArray
                    'Number'=$ObjectNumber;                                                 # Object number
                    'Name'=$CGateway.Name;                                                  # Gateway name
                    'RG'=$CGateway.ResourceGroupName;                                       # Gateway resource group name
                    'Location'=$CGateway.Location;                                          # Gateway location
                    'Vnet'=$VNetName;                                                       # Vnet name
                    'PubIP'=$PubIPName                                                      # Public IP name
                    'GType'=$CGateway.GatewayType;                                          # Gateway type
                    'VPNType'=$CGateway.VPNType;                                            # Gateway VPN type
                    'EnableBgp'=$CGateway.EnableBgp;                                        # Gateway EnableBgp
                    'GDefaultSite'=$CGateway.GatewayDefaultSite;                            # Gateway default site
                    'SkuCap'=$CGateway.Sku.Capacity;                                        # Gateway sku capacity
                    'SkuName'=$CGateway.Sku.Name;                                           # Gateway sku name
                    'SkuTier'=$CGateway.Sku.Tier                                            # Gateway tier
                }                                                                           # End $ObjectInput = [PSCustomObject]@
                $ObjectArray.Add($ObjectInput) | Out-Null                                   # Adds $ObjectInput to $ObjectArray
                $ObjectNumber = $ObjectNumber + 1                                           # Increments $ObjectNumber up by 1
                $CGateway = $null                                                           # Clears $var
                $VNetName = $null                                                           # Clears $var
                $PubIPName = $null                                                          # Clears $var
            }                                                                               # End foreach ($_ in $ObjectList)
            Clear-Host                                                                      # Clears screen
            :SelectAzureGateway while ($true) {                                             # Inner loop for selecting the gateway
                Write-Host '[0]              Exit'                                          # Write message to screen
                Write-Host ''                                                               # Write message to screen
                foreach ($_ in $ObjectArray) {                                              # For each item in $ObjectArray
                    $Number = $_.Number                                                     # $Number is equal to current item .number
                    if ($Number -le 9) {                                                    # If $Number is 9 or less
                        Write-Host "[$Number]             "$_.Name                          # Write message to screen
                    }                                                                       # End if ($Number -le 9)
                    else  {                                                                 # Else if $Number is more than 9
                        Write-Host "[$Number]            "$_.Name                           # Write message to screen
                    }                                                                       # End else (if ($Number -le 9))
                    Write-Host 'Vnet Name:      '$_.VNet                                    # Write message to screen
                    Write-Host 'Gateway RG:     '$_.RG                                      # Write message to screen
                    Write-Host 'Gateway Loc:    '$_.Location                                # Write message to screen
                    Write-Host 'Pub IP Name:    '$_.PubIP                                   # Write message to screen
                    Write-Host 'Gateway Type:   '$_.Gtype                                   # Write message to screen
                    Write-Host 'GW VPN Type:    '$_.VPNtype                                 # Write message to screen
                    Write-Host 'Gateway Sku:    '$_.SkuName                                 # Write message to screen
                    if ($_.GDefaultSite) {                                                  # If $_.GDefaultSite has a value
                        Write-Host 'GW Default Site:'$_.GDefaultSite                        # Write message to screen
                    }                                                                       # End if ($_.GDefaultSite) 
                    else  {                                                                 # Else if $_.GDefaultSite is $null
                        Write-Host 'GW Default Site: N/A'                                   # Write message to screen
                    }                                                                       # End if ($_.GDefaultSite) 
                    Write-Host 'EnableBgp:      '$_.EnableBgp                               # Write message to screen                    
                    Write-Host ''                                                           # Write message to screen
                }                                                                           # End foreach ($_ in $ObjectArray)
                if ($CallingFunction) {                                                     # If $CallingFunction has a value
                    Write-Host 'You are selecting the gateway for:'$CallingFunction         # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                }                                                                           # End if ($CallingFunction) 
                $OpSelect = Read-Host 'Option [#]'                                          # Operator selection of the gateway
                Clear-Host                                                                  # Clears screen
                if ($OPSelect -eq '0') {                                                    # If $OpSelect equals '0'
                    Break GetAzureGateway                                                   # Breaks :GetAzureGateway
                }                                                                           # End if ($OPSelect -eq '0')
                elseif ($OpSelect -in $ObjectArray.Number) {                                # Else if $OpSelect -in $ObjectArray.Number
                    $OpSelect = $ObjectArray | Where-Object {$_.Number -eq $OpSelect}       # $OpSelect is $ObjectArray where $ObjectArray.Number equals $OpSelect
                    $GatewayObject = Get-AzVirtualNetworkGateway -Name $OpSelect.Name `
                        -ResourceGroupName $OpSelect.RG                                     # Pulls the full gateway object
                    Return $GatewayObject                                                   # Returns to calling function with $var
                }                                                                           # End elseif ($OpSelect -in $ObjectArray.Number)
                else  {                                                                     # All other inputs for $OpSelect
                    Write-Host 'That was not a valid input'                                 # Writes message to screen
                    Write-Host ''                                                           # Writes message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Clear-Host                                                              # Clears screen
                }                                                                           # End else (if ($OPSelect -eq '0'))
            }                                                                               # End :SelectAzureGateway while ($true)
        }                                                                                   # End :GetAzureGateway while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End begin
}                                                                                           # End function GetAzVNGateway
function RemoveAzVNGateway {                                                                # Function to remove a virtual network gateway
    Begin {                                                                                 # Begin function
        if (!$CallingFunction) {                                                            # If $CallingFunction is $null
            $CallingFunction = 'RemoveAzVNGateway'                                          # Creates $CallingFunction
        }                                                                                   # End if (!$CallingFunction)
        :RemoveAzureGateway while ($true) {                                                 # Outer loop for managing function
            $GatewayObject = GetAzVNGateway ($CallingFunction)                              # Calls function and assigns output to $var
            if (!$GatewayObject) {                                                          # If $GatewayObject does not have a value
                Break RemoveAzureGateway                                                    # Breaks :RemoveAzureGateway
            }                                                                               # End if (!$GatewayObject)
            $VNetName = $GatewayObject.IPConfigurations.Subnet.ID.Split('/')[8]             # Isolates the Vnet name
            Write-Host 'Remove Gateway: '$GatewayObject.name                                # Write message to screen
            Write-Host 'From VNet:      '$VNetName                                          # Write message to screen
            Write-Host 'From RG:        '$GatewayObject.ResourceGroupName                   # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            $OpConfirm = Read-Host '[Y] Yes [N]'                                            # Operator confirmation to remove the gateway
            Clear-Host                                                                      # Clears screen
            if ($OpConfirm -eq 'y') {                                                       # If $OpConfirm equals 'y'
                Write-Host 'Removing the gateway'                                           # Write message to screen
                Write-Host 'This will take a while'                                         # Write message to screen
                Try {                                                                       # Try the following
                    Remove-AzVirtualNetworkGateway -Name $GatewayObject.Name `
                        -ResourceGroupName $GatewayObject.ResourceGroupName `
                        -Force -ErrorAction 'Stop' | Out-Null                               # Removes the gateway
                }                                                                           # End Try
                Catch {                                                                     # If Try fails
                    Clear-Host                                                              # Clears screen
                    $MSG = $Error[0]                                                        # Gets the error message
                    $MSG = $MSG.Exception.InnerException.Body.Message                       # Isolates the error message
                    Write-Host 'An error has occured'                                       # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    Write-Warning $MSG                                                      # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    Write-Host 'No changes have been made'                                  # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Break RemoveAzureGateway                                                # Breaks :RemoveAzureGateway    
                }                                                                           # End Catch
                Clear-Host                                                                  # Clears screen
                Write-Host 'The gateway has been removed'                                   # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break RemoveAzureGateway                                                    # Breaks :RemoveAzureGateway    
            }                                                                               # End if ($OpConfirm -eq 'y')
            else {                                                                          # All other inputs for $OpConfirm
                Write-Host 'No changes have been made'                                      # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break RemoveAzureGateway                                                    # Breaks :RemoveAzureGateway    
            }                                                                               # End else (if ($OpConfirm -eq 'y'))
        }                                                                                   # End :RemoveAzureGateway while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function RemoveAzVNGateway