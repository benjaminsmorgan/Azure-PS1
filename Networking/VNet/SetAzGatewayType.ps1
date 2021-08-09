# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Microsoft docs links
    None
} #>
<# Required Functions Links: {
    None
} #>
<# Functions Description: {
    SetAzGatewayVPNSku:         Function to set a virtual network gateway type
} #>
<# Variables: {      
    :SetAzureGatewayVPNSku      Outer loop for managing function
    :Confirm                    Inner loop to confirm selection
    $OpSelect:                  Operator input to select the gateway type
    $GatewayType:               Gateway type
    $OpConfirm:                 Operator confirmation of the gateway type
} #>
<# Process Flow {
    function
        Call SetAzGatewayVPNSku > Get $GatewaySku            
        End SetAzGatewayVPNSku
            Return function > Send $GatewaySku
}#>
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