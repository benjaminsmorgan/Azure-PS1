# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Microsoft docs links
    None
} #>
<# Required Functions Links: {
    None
} #>
<# Functions Description: {
    SetAzGatewayVPNSku:         Function to set a virtual network gateway sku
} #>
<# Variables: {      
    :SetAzureGatewayVPNSku      Outer loop for managing function
    :Confirm                    Inner loop to confirm selection
    $VPNUrl:                    Link to gateway VPN sku details
    $ERUrl:                     Link to gateway express route sku details
    $GatewayType:               Gateway type
    $OpSelect:                  Operator input to select the VPN sku
    $GatewaySku:                Gateway sku
    $OpConfirm:                 Operator confirmation of the sku value
} #>
<# Process Flow {
    function
        Call SetAzGatewayVPNSku > Get $GatewaySku            
        End SetAzGatewayVPNSku
            Return function > Send $GatewaySku
}#>
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
                Write-Host '[1] ErGw1AZ'                                                    # Write message to screen
                Write-Host '[2] ErGw2AZ'                                                    # Write message to screen
                Write-Host '[3] ErGw3AZ'                                                    # Write message to screen
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
                    $GatewaySku = 'ErGw1AZ'                                                 # Sets the gateway sku
                }                                                                           # End elseif ($Opselect -eq '1')
                elseif ($Opselect -eq '2') {                                                # Else if $OpSelect equals '2'
                    $GatewaySku = 'ErGw2AZ'                                                 # Sets the gateway sku
                }                                                                           # End elseif ($Opselect -eq '2')
                elseif ($Opselect -eq '3') {                                                # Else if $OpSelect equals '3'
                    $GatewaySku = 'ErGw3AZ'                                                 # Sets the gateway sku
                }                                                                           # End elseif ($Opselect -eq '3')
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