function ManageAzVNGWConfig {                                                               # Function to manage virtual network gateway configs
    Begin {                                                                                 # Begin function
        :ManageAzureGateway while ($true) {                                                 # Outer loop for managing function
            Write-Host 'Manage Gateway Configs'                                             # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            Write-Host 'This function is under development'                                 # Write message to screen
            Write-Host '[0] Exit'                                                           # Write message to screen
            Write-Host '[1] Resize Gateway'                                                 # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            $OpSelect = Read-Host 'Option [#]'                                              # Operator selection for management function
            Clear-Host                                                                      # Clears screen
            if ($OpSelect -eq '0') {                                                        # If $OpSelect equals '0'
                Break ManageAzureGateway                                                    # Breaks :ManageAzureGateway
            }                                                                               # End if ($OpSelect -eq '0')
            elseif ($OpSelect -eq '1') {                                                    # Else if $OpSelect equals '1'
                Write-Host 'Resize Gateway'                                                 # Write message to screen
                ResizeAzVNGateway                                                           # Calls function
            }                                                                               # End elseif ($OpSelect -eq '1')  
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
}                                                                                           # End function ManageAzVNGWConfig
function ResizeAzVNGateway {                                                                # Function to resize a gateway
    Begin {                                                                                 # Begin function
        if (!$CallingFunction) {                                                            # If $CallingFunction is $null
            $CallingFunction = 'ResizeAzVNGateway'                                          # Creates $CallingFunction
        }                                                                                   # End if (!$CallingFunction)
        :ResizeAzureVNGateway while ($true) {                                               # Outer loop for managing function
            $GatewayObject = GetAzVNGateway ($CallingFunction)                              # Calls function and assigns output to $var
            if (!$GatewayObject) {                                                          # If $GatewayObject is $null
                Break ResizeAzureVNGateway                                                  # Breaks :ResizeAzureVNGateway
            }                                                                               # End if (!$GatewayObject)
            :SetAzureVNGatewaySku while ($true) {                                           # Inner loop to set the gateway sku
                Write-Host 'Gateway VPN Generation:'$GatewayObject.VpnGatewayGeneration     # Write message to screen
                Write-Host ''                                                               # Write message to screen
                if ($GatewayObject.VpnGatewayGeneration -eq 'Generation1') {                # If $GatewayObject.VpnGatewayGeneration equals 'Generation1'
                    Write-Host 'New Gateway Sku'                                            # Write message to screen
                    Write-Host ''                                                           # Write message to screen                
                    Write-Host '[0] Exit'                                                   # Write message to screen
                    Write-Host '[1] VpnGw1'                                                 # Write message to screen
                    Write-Host '[2] VpnGw2'                                                 # Write message to screen
                    Write-Host '[3] VpnGw3'                                                 # Write message to screen
                    Write-Host '[4] VpnGw4 (Not Available)'                                 # Write message to screen
                    Write-Host '[5] VpnGw5 (Not Available)'                                 # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    $OpSelect = Read-Host 'Option [#]'                                      # Operator input to select new sku
                    Clear-Host                                                              # Clears screen
                    if ($OpSelect -eq '0') {                                                # If $OpSelect equals '0'
                        Break ResizeAzureVNGateway                                          # Breaks :ResizeAzureVNGateway
                    }                                                                       # End if ($OpSelect -eq '0')
                    elseif ($OpSelect -eq '1') {                                            # Else if $OpSelect -eq '1'
                        $GatewaySku = 'VpnGw1'                                              # Sets $GatewaySku
                    }                                                                       # End elseif ($OpSelect -eq '1')
                    elseif ($OpSelect -eq '2') {                                            # Else if $OpSelect -eq '2'
                        $GatewaySku = 'VpnGw2'                                              # Sets $GatewaySku
                    }                                                                       # End elseif ($OpSelect -eq '2')
                    elseif ($OpSelect -eq '3') {                                            # Else if $OpSelect -eq '3'
                        $GatewaySku = 'VpnGw3'                                              # Sets $GatewaySku
                    }                                                                       # End elseif ($OpSelect -eq '3')
                    else {                                                                  # All other inputs for $OpSelect
                        Write-Host 'That was not a valid input'                             # Write message to screen
                        Write-Host ''                                                       # Write message to screen
                        Pause                                                               # Pauses all actions for operator input
                        Clear-Host                                                          # Clears screen 
                    }                                                                       # End else (if ($OpSelect -eq '0'))
                }                                                                           # End if ($GatewayObject.VpnGatewayGeneration -eq 'Generation1')
                else {                                                                      # Else if $GatewayObject.VpnGatewayGeneration does not equal 'Generation1'
                    Write-Host 'New Gateway Sku'                                            # Write message to screen
                    Write-Host ''                                                           # Write message to screen                
                    Write-Host '[0] Exit'                                                   # Write message to screen
                    Write-Host '[1] VpnGw1 (Not Available)'                                 # Write message to screen
                    Write-Host '[2] VpnGw2'                                                 # Write message to screen
                    Write-Host '[3] VpnGw3'                                                 # Write message to screen
                    Write-Host '[4] VpnGw4'                                                 # Write message to screen
                    Write-Host '[5] VpnGw5'                                                 # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    $OpSelect = Read-Host 'Option [#]'                                      # Operator input to select new sku
                    Clear-Host                                                              # Clears screen
                    if ($OpSelect -eq '0') {                                                # If $OpSelect equals '0'
                        Break ResizeAzureVNGateway                                          # Breaks :ResizeAzureVNGateway
                    }                                                                       # End if ($OpSelect -eq '0')
                    elseif ($OpSelect -eq '2') {                                            # Else if $OpSelect -eq '2'
                        $GatewaySku = 'VpnGw2'                                              # Sets $GatewaySku
                    }                                                                       # End elseif ($OpSelect -eq '2')
                    elseif ($OpSelect -eq '3') {                                            # Else if $OpSelect -eq '3'
                        $GatewaySku = 'VpnGw3'                                              # Sets $GatewaySku
                    }                                                                       # End elseif ($OpSelect -eq '3')
                    elseif ($OpSelect -eq '4') {                                            # Else if $OpSelect -eq '4'
                        $GatewaySku = 'VpnGw4'                                              # Sets $GatewaySku
                    }                                                                       # End elseif ($OpSelect -eq '4')
                    elseif ($OpSelect -eq '5') {                                            # Else if $OpSelect -eq '5'
                        $GatewaySku = 'VpnGw5'                                              # Sets $GatewaySku
                    }                                                                       # End elseif ($OpSelect -eq '5')
                    else {                                                                  # All other inputs for $OpSelect
                        Write-Host 'That was not a valid input'                             # Write message to screen
                        Write-Host ''                                                       # Write message to screen
                        Pause                                                               # Pauses all actions for operator input
                        Clear-Host                                                          # Clears screen 
                    }                                                                       # End else (if ($OpSelect -eq '0'))
                }                                                                           # End else (if ($GatewayObject.VpnGatewayGeneration -eq 'Generation1'))
                if ($GatewaySku) {                                                          # If $GatewaySku has a value
                    if ($GatewaySku -eq $GatewayObject.Sku.Name) {                          # If $GatewaySku equals $GatewayObject.Sku.Name
                        Write-Host 'The selected sku is already set'                        # Write message to screen
                        Write-Host ''                                                       # Write message to screen
                        Write-Host 'No changes have been made'                              # Write message to screen
                        Write-Host ''                                                       # Write message to screen
                        Pause                                                               # Pauses all actions for operator input
                        Break ResizeAzureVNGateway                                          # Breaks :ResizeAzureVNGateway
                    }                                                                       # End if ($GatewaySku -eq $GatewayObject.Sku.Name)
                    Break SetAzureVNGatewaySku                                              # Breaks :SetAzureVNGatewaySku
                }                                                                           # End if ($GatewaySku)
            }                                                                               # End :SetAzureVNGatewaySku while ($true)
            :Confirm while ($true) {                                                        # Inner loop to confirm the changes
                Write-Host 'Make the following changes'                                     # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Write-Host 'Gateway Name:    '$GatewayObject.Name                           # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Write-Host 'Current Sku Name:'$GatewayObject.Sku.Name                       # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Write-Host 'New Sku Name:    '$GatewaySku                                   # Write message to screen
                Write-Host ''                                                               # Write message to screen
                $OpConfirm = Read-Host '[Y] Yes [N] No'                                     # Operator confirmation to make this change
                Clear-Host                                                                  # Clears screen
                if ($OpConfirm -eq 'y') {                                                   # If $OpConfirm equals 'y'
                    Break Confirm                                                           # Breaks :Confirm
                }                                                                           # End if ($OpConfirm -eq 'y')
                elseif ($OpConfirm -eq 'n') {                                               # Else if $OpConfirm equals 'n'
                    Write-Host 'No changes have been made'                                  # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Break ResizeAzureVNGateway                                              # Breaks :ResizeAzureVNGateway
                }                                                                           # End elseif ($OpConfirm -eq 'n')
                else {                                                                      # All other inputs for $OpConfirm
                    Write-Host 'That was not a valid input'                                 # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Clear-Host                                                              # Clears screen
                }                                                                           # End else (if ($OpConfirm -eq 'y'))
            }                                                                               # End :Confirm while ($true)
            Try {                                                                           # Try the following
                Write-Host 'Resizing the gateway sku'                                       # Write message to screen
                Resize-AzVirtualNetworkGateway -VirtualNetworkGateway $GatewayObject `
                    -GatewaySku $GatewaySku -ErrorAction 'Stop' | Out-Null                  # Resizes the gateway
            }                                                                               # End Try
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
                Break ResizeAzureVNGateway                                                  # Breaks :ResizeAzureVNGateway    
            }                                                                               # End Catch
            Clear-Host                                                                      # Clears screen
            Write-Host 'The gateway has been resized'                                       # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            Pause                                                                           # Pauses all actions for operator input
            Break NewAzureVNGateway                                                         # Breaks :NewAzureVNGateway    
        }                                                                                   # End :ResizeAzureVNGateway while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End begin
}                                                                                           # End function ResizeAzVNGateway