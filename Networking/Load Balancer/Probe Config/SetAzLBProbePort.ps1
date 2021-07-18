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
    SetAzLBProbePort:           Function to change an existing load balancer probe port config
    GetAzLBProbeConfig:         Function to get an existing load balancer probe config
} #>
<# Variables: {      
    :SetAzureProbeConfig        Outer loop for managing function
    :SetAzureLBProbePort        Inner loop for setting the probe port
    $CallingFunction:           Name of this function or the one that called it
    $LBProbeObject:             Load balancer probe object
    $LoadBalancerObject:        Load balancer object
    $ValidArray:                Array of valid characters for $LBProbePort
    $LBProbePort:               Operator input for the port number
    $LBProbeArray:              $LBProbePort converted to array
    $LBProbePortInt:            $LBProbePort converted to integer
    $OpConfirm:                 Operator confirmation of the port
    $RPath:                     New probe request path
    GetAzLBProbeConfig{}        Gets $LBProbeObject, $LoadBalancerObject
} #>
<# Process Flow {
    function
        Call SetAzLBProbePort > Get $null
            Call GetAzLBProbeConfig > Get $LBProbeObject, $LoadBalancerObject
            End GetAzLBProbeConfig
                Return SetAzLBProbePort > Send $LBProbeObject, $LoadBalancerObject
        End SetAzLBProbePort
            Return function > Send $null
}#>
function SetAzLBProbePort {                                                                 # Function to change an existing load balancer probe port config
    Begin {                                                                                 # Begin function
        if (!$CallingFunction) {                                                            # If $CallingFunction is $null
            $CallingFunction = 'SetAzLBProbePort'                                           # Creates $CallingFunction
        }                                                                                   # End if (!$CallingFunction)
        :SetAzureProbeConfig while ($true) {                                                # Outer loop for managing function
            $LBProbeObject, $LoadBalancerObject = GetAzLBProbeConfig ($CallingFunction)     # Calls function and assigns output to $var
            if (!$LBProbeObject) {                                                          # If $LBProbeObject is $null
                Break SetAzureProbeConfig                                                   # Breaks :SetAzureProbeConfig
            }                                                                               # End if (!$LBProbeObject)
            if ($LBProbeObject.Protocol -ne 'TCP') {                                        # If $LBProbeObject.Protocol does not equal 'TCP'
                Write-Host "This probe's protocol is not set to TCP"                        # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Write-Host 'No changes have been made'                                      # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break SetAzureProbeConfig                                                   # Breaks :SetAzureProbeConfig
            }                                                                               # End if ($LBProbeObject.Protocol -ne 'TCP')
            $ValidArray = '0123456789'                                                      # Creates a string of valid characters
            $ValidArray = $ValidArray.ToCharArray()                                         # Loads all valid characters into array
            :SetAzureLBProbePort while ($true) {                                            # Inner loop for setting the probe port
                Write-Host 'Enter new probe port'                                           # Write message to screen
                Write-Host ''                                                               # Writes message to screen
                $LBProbePort = Read-Host 'Probe Port #'                                     # Operator input for the probe port 
                $LBProbeArray = $LBProbePort.ToCharArray()                                  # Adds $LBProbePort to array
                Clear-Host                                                                  # Clears screen
                foreach ($_ in $LBProbeArray) {                                             # For each item in $LBProbeArray
                    if ($_ -notin $ValidArray) {                                            # If current item is not in $ValidArray
                        $LBProbePort = $null                                                # Clears $LBProbePort
                    }                                                                       # End if ($_ -notin $ValidArray)
                }                                                                           # End foreach ($_ in $LBProbeArray)
                Try {                                                                       # Try the following
                    $LBProbePortInt = [INT]$LBProbePort                                     # Converts $LBProbePort to an integer
                }                                                                           # End Try
                Catch {                                                                     # If Try fails
                    $LBProbePortInt = $null                                                 # Clears $LBProbePortInt
                }                                                                           # End Catch
                if ($LBProbePortInt -lt 1 -or $LBProbePortInt -gt 65535) {                  # If ($LBProbePortInt less than 1 or $LBProbePortInt greater than 65535)
                    Write-Host 'That was not a valid port number'                           # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    $LBProbePort = $null                                                    # Clears $LBProbePort
                }                                                                           # End if ($LBProbePortInt -lt 1 -or $LBProbePortInt -gt 65535)
                $LBProbeArray = $null                                                       # Clears $LBProbeArray
                if ($LBProbePort) {                                                         # If $LBProbePort has a value
                    Write-Host 'Set'$LBProbePort' as the probe port'                        # Write message to screen
                    Write-Host ''                                                           # Writes message to screen
                    $OpConfirm = Read-Host '[Y] Yes [N] No [E] Exit'                        # Operator confirmation of the probe port
                    Clear-Host                                                              # Clears screen
                    if ($OpConfirm -eq 'e') {                                               # If $OpConfirm equals 'e'
                        Break SetAzureProbeConfig                                           # Breaks :SetAzureProbeConfig
                    }                                                                       # End if ($OpConfirm -eq 'e')
                    if ($OpConfirm -eq 'y') {                                               # If $OpConfirm equals 'y'
                        $RPath = $null                                                      # Sets $RPath
                        Break SetAzureLBProbePort                                           # Breaks :SetAzureLBProbePort        
                    }                                                                       # End if ($OpConfirm -eq 'y')
                }                                                                           # End if ($LBProbePort)
                else {                                                                      # Else if $LBProbePort is $null
                    Pause                                                                   # Pauses all actions for operator input
                    Clear-Host                                                              # Clears screen
                }                                                                           # End else (if ($LBProbePort))
            }                                                                               # End :SetAzureLBProbePort while ($true)
            Write-Host 'Updating the probe configuration'                                   # Write message to screen
            Try {                                                                           # Try the following
                Set-AzLoadBalancerProbeConfig -LoadBalancer $LoadBalancerObject -Name `
                    $LBProbeObject.Name -IntervalInSeconds $LBProbeObject.IntervalInSeconds `
                    -Protocol $LBProbeObject.Protocol -Port $LBProbePort -ProbeCount `
                    $LBProbeObject.NumberOfProbes -RequestPath $RPath -ErrorAction 'Stop' `
                    | Out-Null                                                              # Updates the probe port
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
}                                                                                           # End function SetAzLBProbePort