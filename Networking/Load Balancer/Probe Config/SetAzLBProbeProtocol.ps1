# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Mircosoft docs links
    Set-AzLoadBalancerProbeConfig:              https://docs.microsoft.com/en-us/powershell/module/az.network/set-azloadbalancerprobeconfig?view=azps-6.1.0
    Set-AzLoadBalancer:                         https://docs.microsoft.com/en-us/powershell/module/az.network/set-azloadbalancer?view=azps-5.5.0
    Get-AzLoadBalancer:                         https://docs.microsoft.com/en-us/powershell/module/az.network/get-azloadbalancer?view=azps-5.5.0 
    Get-AzLoadBalancerProbeConfig:              https://docs.microsoft.com/en-us/powershell/module/az.network/get-azloadbalancerprobeconfig?view=azps-6.1.0
} #>
<# Required Functions Links: {
    GetAzLBProbeConfig:         https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/Load%20Balancer/Probe%20Config/GetAzLBProbeConfig.ps1
} #>
<# Functions Description: {
    SetAzLBProbeProtocol:       Function to change an existing load balancer probe protocol config
    GetAzLBProbeConfig:         Function to get an existing load balancer probe config
} #>
<# Variables: {      
    :SetAzureProbeConfig        Outer loop for managing function
    :SetAzureProbeProtocol      Inner loop for setting the probe protocol
    :SetAzureLBProbePort        Inner loop for setting the probe port
    $CallingFunction:           Name of this function or the one that called it
    $LBProbeObject:             Load balancer probe object
    $LoadBalancerObject:        Load balancer object
    $OpSelect:                  Operator selection of the probe protocol
    $LBProbeProtocol:           Probe new protocol
    $RPath:                     New probe request path
    $ValidArray:                Array of valid characters for $LBProbePort
    $LBProbePort:               Operator input for the port number
    $LBProbeArray:              $LBProbePort converted to array
    $LBProbePortInt:            $LBProbePort converted to integer
    $OpConfirm:                 Operator confirmation of the port
    GetAzLBProbeConfig{}        Gets $LBProbeObject, $LoadBalancerObject
} #>
<# Process Flow {
    function
        Call SetAzLBProbeProtocol > Get $null
            Call GetAzLBProbeConfig > Get $LBProbeObject, $LoadBalancerObject
            End GetAzLBProbeConfig
                Return SetAzLBProbeProtocol > Send $LBProbeObject, $LoadBalancerObject
        End SetAzLBProbeProtocol
            Return function > Send $null
}#>
function SetAzLBProbeProtocol {                                                             # Function to change an existing load balancer probe protocol config
    Begin {                                                                                 # Begin function
        if (!$CallingFunction) {                                                            # If $CallingFunction is $null
            $CallingFunction = 'SetAzLBProbeProtocol'                                       # Creates $CallingFunction
        }                                                                                   # End if (!$CallingFunction)
        :SetAzureProbeConfig while ($true) {                                                # Outer loop for managing function
            $LBProbeObject, $LoadBalancerObject = GetAzLBProbeConfig ($CallingFunction)     # Calls function and assigns output to $var
            if (!$LBProbeObject) {                                                          # If $LBProbeObject is $null
                Break SetAzureProbeConfig                                                   # Breaks :SetAzureProbeConfig
            }                                                                               # End if (!$LBProbeObject)
            :SetAzureProbeProtocol while ($true) {                                          # Inner loop for setting the probe protocol
                Write-Host 'Probe Protocol Options'                                         # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Write-Host '[0] Exit'                                                       # Write message to screen
                Write-Host '[1] TCP'                                                        # Write message to screen
                Write-Host '[2] HTTP'                                                       # Write message to screen
                if ($LoadBalancerObject.Sku.Name -eq 'Standard') {                          # If $LoadBalancerObject.Sku.Name equals 'Standard'
                    Write-Host '[3] HTTPS'                                                  # Write message to screen
                }                                                                           # End if ($LoadBalancerObject.Sku -eq 'Standard')
                Write-Host ''                                                               # Write message to screen
                $OpSelect = Read-Host 'Option [#]'                                          # Operator input for the probe protocol
                Clear-Host                                                                  # Clears screen
                if ($OpSelect -eq '0') {                                                    # If $OpSelect equals '0'
                    Break SetAzureProbeConfig                                               # Breaks :SetAzureProbeConfig
                }                                                                           # End if ($OpSelect -eq '0')
                elseif ($OpSelect -eq '1') {                                                # Else if $OpSelect equals '1'
                    $LBProbeProtocol = 'TCP'                                                # Sets $LBProbeProtocol
                    Break SetAzureProbeProtocol                                             # Breaka :SetAzureProbeProtocol
                }                                                                           # End elseif ($OpSelect -eq '1'
                elseif ($OpSelect -eq '2') {                                                # Else if $OpSelect equals '2'
                    $LBProbeProtocol = 'HTTP'                                               # Sets $LBProbeProtocol
                    $LBProbePort = '80'                                                     # Sets $LBProbePort
                    $RPath = '/'                                                            # Sets $RPath
                    Break SetAzureProbeProtocol                                             # Breaka :SetAzureProbeProtocol
                }                                                                           # End elseif ($OpSelect -eq '2'
                elseif ($OpSelect -eq '3' -and `
                    $LoadBalancerObject.Sku.Name -eq 'Standard') {                          # Else if $OpSelect equals '3' and $LoadBalancerObject.Sku.Name equals 'Standard'
                    $LBProbeProtocol = 'HTTPS'                                              # Sets $LBProbeProtocol
                    $LBProbePort = '443'                                                    # Sets $LBProbePort
                    $RPath = '/'                                                            # Sets $RPath
                    Break SetAzureProbeProtocol                                             # Breaka :SetAzureProbeProtocol
                }                                                                           # End elseif ($OpSelect -eq '3' -and $LoadBalancerObject.Sku.Name -eq 'Standard')
                else {                                                                      # All other inputs for $OpSelect
                    Write-Host 'That was not a valid input'                                 # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Clear-Host                                                              # Clears screen
                }                                                                           # End else (if ($OpSelect -eq '0'))
            }                                                                               # End :SetAzureProbeProtocol while ($true) 
            if ($LBProbeProtocol -eq 'TCP') {                                               # If $LBProbeProtocol equals 'TCP'
                $ValidArray = '0123456789'                                                  # Creates a string of valid characters
                $ValidArray = $ValidArray.ToCharArray()                                     # Loads all valid characters into array
                :SetAzureLBProbePort while ($true) {                                        # Inner loop for setting the probe port
                    Write-Host 'Enter new probe port'                                       # Write message to screen
                    Write-Host ''                                                           # Writes message to screen
                    $LBProbePort = Read-Host 'Probe Port #'                                 # Operator input for the probe port 
                    $LBProbeArray = $LBProbePort.ToCharArray()                              # Adds $LBProbePort to array
                    Clear-Host                                                              # Clears screen
                    foreach ($_ in $LBProbeArray) {                                         # For each item in $LBProbeArray
                        if ($_ -notin $ValidArray) {                                        # If current item is not in $ValidArray
                            $LBProbePort = $null                                            # Clears $LBProbePort
                        }                                                                   # End if ($_ -notin $ValidArray)
                    }                                                                       # End foreach ($_ in $LBProbeArray)
                    Try {                                                                   # Try the following
                        $LBProbePortInt = [INT]$LBProbePort                                 # Converts $LBProbePort to an integer
                    }                                                                       # End Try
                    Catch {                                                                 # If Try fails
                        $LBProbePortInt = $null                                             # Clears $LBProbePortInt
                    }                                                                       # End Catch
                    if ($LBProbePortInt -lt 1 -or $LBProbePortInt -gt 65535) {              # if ($LBProbePortInt less than 1 or $LBProbePortInt greater than 65535)
                        Write-Host 'That was not a valid port number'                       # Write message to screen
                        Write-Host ''                                                       # Write message to screen
                        $LBProbePort = $null                                                # Clears $LBProbePort
                    }                                                                       # End if ($LBProbePortInt -lt 1 -or $LBProbePortInt -gt 65535)
                    $LBProbeArray = $null                                                   # Clears $LBProbeArray
                    if ($LBProbePort) {                                                     # If $LBProbePort has a value
                        Write-Host 'Set'$LBProbePort' as the probe port'                    # Write message to screen
                        Write-Host ''                                                       # Writes message to screen
                        $OpConfirm = Read-Host '[Y] Yes [N] No [E] Exit'                    # Operator confirmation of the probe port
                        Clear-Host                                                          # Clears screen
                        if ($OpConfirm -eq 'e') {                                           # If $OpConfirm equals 'e'
                            Break SetAzureProbeConfig                                       # Breaks :SetAzureProbeConfig
                        }                                                                   # End if ($OpConfirm -eq 'e')
                        if ($OpConfirm -eq 'y') {                                           # If $OpConfirm equals 'y'
                            $RPath = $null                                                  # Sets $RPath
                            Break SetAzureLBProbePort                                       # Breaks :SetAzureLBProbePort        
                        }                                                                   # End if ($OpConfirm -eq 'y')
                    }                                                                       # End if ($LBProbePort)
                    else {                                                                  # Else if $LBProbePort is $null
                        Pause                                                               # Pauses all actions for operator input
                        Clear-Host                                                          # Clears screen
                    }                                                                       # End else (if ($LBProbePort))
                }                                                                           # End :SetAzureLBProbePort while ($true)
            }                                                                               # End if ($LBProbeProtocol -eq 'TCP')
            Write-Host 'Updating the probe configuration'                                   # Write message to screen
            Try {                                                                           # Try the following
                Set-AzLoadBalancerProbeConfig -LoadBalancer $LoadBalancerObject -Name `
                    $LBProbeObject.Name -IntervalInSeconds $LBProbeObject.IntervalInSeconds `
                    -Protocol $LBProbeProtocol -Port $LBProbePort -ProbeCount `
                    $LBProbeObject.NumberOfProbes -RequestPath $RPath -ErrorAction 'Stop' `
                    | Out-Null                                                              # Updates the probe protocol
                Write-Host 'Saving the load balancer config'                                # Write message to screen
                Set-AzLoadBalancer -LoadBalancer $LoadBalancerObject -ErrorAction 'Stop' `
                    | Out-Null                                                              # Saves the updated load balancer configuration
            }                                                                               # End Try
            Catch {                                                                         # If Try fails
                Clear-Host                                                                  # Clears screen
                Write-Host 'An error has occured'                                           # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break SetAzureProbeConfig                                                   # Breaks :SetAzureProbeConfig  
            }                                                                               # End catch
            Clear-Host                                                                      # Clears screen
            Write-Host 'The requested changes have been made'                               # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            Pause                                                                           # Pauses all actions for operator input
            Break SetAzureProbeConfig                                                       # Breaks :SetAzureProbeConfig
        }                                                                                   # End :SetAzureProbeConfig while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function SetAzLBProbeProtocol