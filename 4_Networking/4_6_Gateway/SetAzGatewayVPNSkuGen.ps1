# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Microsoft docs links
    None
} #>
<# Required Functions Links: {
    None
} #>
<# Functions Description: {
    SetAzGatewayVPNSkuGen:      Function to set a virtual network gateway sku generation
} #>
<# Variables: {      
    :SetAzureGWVPNSkuGen        Outer loop for managing function
    :Confirm                    Inner loop to confirm selection
    $Gen1:                      List of skus that have a gen 1 option
    $Gen2:                      List of skus that have a gen 2 option
    $Url:                       Link to gateway sku details
    $GatewaySku:                Gateway sku
    $OpSelect:                  Operator input to select the VPN sku generation
    $GatewaySkuGen:             Gateway sku generation
    $OpConfirm:                 Operator confirmation of the sku value
} #>
<# Process Flow {
    function
        Call SetAzGatewayVPNSkuGen > Get $GatewaySkuGen            
        End SetAzGatewayVPNSkuGen
            Return function > Send $GatewaySkuGen
}#>
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