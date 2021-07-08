# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Mircosoft docs links
    Get-AzLoadBalancerBackendAddressPool:       https://docs.microsoft.com/en-us/powershell/module/az.network/get-azloadbalancerbackendaddresspool?view=azps-6.1.0
    Set-AzLoadBalancerRuleConfig:               https://docs.microsoft.com/en-us/powershell/module/az.network/set-azloadbalancerruleconfig?view=azps-6.1.0
    Set-AzLoadBalancer:                         https://docs.microsoft.com/en-us/powershell/module/az.network/set-azloadbalancer?view=azps-6.1.0
    Get-AzLoadBalancer:                         https://docs.microsoft.com/en-us/powershell/module/az.network/get-azloadbalancer?view=azps-5.5.0 
    Get-AzLoadBalancerRuleConfig:               https://docs.microsoft.com/en-us/powershell/module/az.network/get-azloadbalancerruleconfig?view=azps-6.1.0
} #>
<# Required Functions Links: {
    GetAzLBRuleConfig:          https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/Load%20Balancer/Rule%20Config/GetAzLBRuleConfig.ps1
} #>
<# Functions Description: {
    SetAzLBRuleLoadDisto:       Function to change an existing load balancer rule load distribution
    GetAzLBRuleConfig:          Function to get an existing load balancer rule config
} #>
<# Variables: {      
    :SetAzureLBRuleLoadDisto    Outer loop for managing function
    :NewAzureLBRuleLoadDisto    Inner loop to set the rule load disto
    $CallingFunction:           Name of this function or the one that called it
    $LBRuleObject:              Load balancer rule object
    $LoadBalancerObject:        Load balancer object
    $CurrentBEName:             Current rule back end name
    $CurrentBEObject:           Current rule back end object
    $CurrentBEID:               Current rule back end object ID
    $OpSelect:                  Operator selection for the rule new load distro
    $LBRuleLoadDisto:           Load balancer rule new load distro
    GetAzLBRuleConfig{}         Gets $LBRuleObject, $LoadBalancerObject
} #>
<# Process Flow {
    function
        Call SetAzLBRuleLoadDisto > Get $null
            Call GetAzLBRuleConfig > Get $LBRuleObject, $LoadBalancerObject
            End GetAzLBRuleConfig
                Return SetAzLBRuleLoadDisto > Send $LBRuleObject, $LoadBalancerObject
        End SetAzLBRuleLoadDisto
            Return function > Send $null
}#>
function SetAzLBRuleLoadDisto {                                                             # Function to change an existing load balancer rule load distribution
    Begin {                                                                                 # Begin function
        if (!$CallingFunction) {                                                            # If $CallingFunction is $null
            $CallingFunction = 'SetAzLBRuleLoadDisto'                                       # Creates $CallingFunction
        }                                                                                   # End if (!$CallingFunction)
        :SetAzureLBRuleLoadDisto while ($true) {                                            # Outer loop for managing function
            $LBRuleObject, $LoadBalancerObject = GetAzLBRuleConfig ($CallingFunction)       # Calls function and assigns output to $var
            if (!$LBRuleObject) {                                                           # If $LBRuleObject is $null
                Break SetAzureLBRuleLoadDisto                                               # Breaks :SetAzureLBRuleLoadDisto
            }                                                                               # End if (!$LBRuleObject)
            if ($LBRuleObject.BackendAddressPool.ID) {                                      # If $LBRuleObject.BackendAddressPool.ID has a value
                $CurrentBEName = $LBRuleObject.BackendAddressPool.ID                        # Isolates the back end ID
                $CurrentBEName = $CurrentBEName.Split('/')[-1]                              # Isolates the back end name
                $CurrentBEObject = Get-AzLoadBalancerBackendAddressPool -LoadBalancer `
                    $LoadBalancerObject -Name $CurrentBEName                                # Gets the current back end info
                $CurrentBEID = $CurrentBEObject.ID                                          # Isolates the current back end ID
            }                                                                               # End if ($LBRuleObject.BackendAddressPool.ID)
            else {                                                                          # Else if $LBRuleObject.BackendAddressPool.ID is $null
                $CurrentBEID = $null                                                        # Sets $CurrentBEID
            }                                                                               # End if ($LBRuleObject.BackendAddressPool.ID)
            :NewAzureLBRuleLoadDisto while ($true) {                                        # Inner loop for setting the rule load disto
                Write-Host 'Rule Name:    '$LBRuleObject.name                               # Write message to screen
                Write-Host 'Load Balancer:'$LoadBalancerObject.name                         # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Write-Host 'Load distribution options'                                      # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Write-Host '[0] Exit'                                                       # Write message to screen
                Write-Host '[1] Default'                                                    # Write message to screen
                Write-Host '[2] Source IP'                                                  # Write message to screen
                Write-Host '[3] Source IP + Port'                                           # Write message to screen
                Write-Host ''                                                               # Write message to screen
                $OpSelect = Read-Host 'Option [#]'                                          # Operator input to select load disto
                Clear-Host                                                                  # Clears screen
                if ($OpSelect -eq '0') {                                                    # If $OpSelect equals '0'
                    Break SetAzureLBRuleLoadDisto                                           # Breaks SetAzureLBRuleLoadDisto
                }                                                                           # End if ($OpSelect -eq '0')
                elseif ($OpSelect -eq '1') {                                                # Else if $OpSelect equals '1'
                    $LBRuleLoadDisto = 'Default'                                            # Sets $LBRuleLoadDisto
                    Break NewAzureLBRuleLoadDisto                                           # Breaks :NewAzureLBRuleLoadDisto
                }                                                                           # End elseif ($OpSelect -eq '1')
                elseif ($OpSelect -eq '2') {                                                # Else if $OpSelect equals '2'
                    $LBRuleLoadDisto = 'SourceIP'                                           # Sets $LBRuleLoadDisto
                    Break NewAzureLBRuleLoadDisto                                           # Breaks :NewAzureLBRuleLoadDisto
                }                                                                           # End elseif ($OpSelect -eq '2')
                elseif ($OpSelect -eq '3') {                                                # Else if $OpSelect equals '3'
                    $LBRuleLoadDisto = 'SourceIPProtocol'                                   # Sets $LBRuleLoadDisto
                    Break NewAzureLBRuleLoadDisto                                           # Breaks :NewAzureLBRuleLoadDisto
                }                                                                           # End elseif ($OpSelect -eq '3')
                else {                                                                      # All other inputs for $OpSelect
                    Write-Host 'That was not a valid input'                                 # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Clear-Host                                                              # Clears screen
                }                                                                           # End else (if ($OpSelect -eq '0'))
            }                                                                               # End :NewAzureLBRuleLoadDisto while ($true)
            Write-Host 'Changing the rule load distribution'                                # Write message to screen
            Try {                                                                           # Try the following
                if ($LBRuleObject.EnableFloatingIP -eq $True `
                    -and $LBRuleObject.EnableTcpReset -eq $True) {                          # If $LBRuleObject.EnableFloatingIP and $LBRuleObject.EnableTcpReset equal $true
                    Set-AzLoadBalancerRuleConfig `
                        -LoadBalancer $LoadBalancerObject `
                        -Name $LBRuleObject.Name `
                        -FrontendIpConfigurationId `
                        $LBRuleObject.FrontendIpConfiguration.ID `
                        -Protocol $LBRuleObject.Protocol `
                        -FrontendPort $LBRuleObject.FrontendPort `
                        -BackendPort  $LBRuleObject.BackEndPort `
                        -IdleTimeoutInMinutes  $LBRuleObject.IdleTimeoutInMinutes `
                        -BackendAddressPoolId  $CurrentBEID `
                        -LoadDistribution $LBRuleLoadDisto `
                        -EnableTcpReset -EnableFloatingIP `
                        -ProbeID $LBRuleObject.Probe.ID -Verbose -ErrorAction `
                        'Stop' | Out-Null                                                   # Changes the rule load disto
                }                                                                           # End if ($LBRuleObject.EnableFloatingIP -eq $True -and $LBRuleObject.EnableTcpReset -eq $True)
                elseif ($LBRuleObject.EnableFloatingIP -eq $True) {                         # Else if $LBRuleObject.EnableFloatingIP equals $True
                    Set-AzLoadBalancerRuleConfig `
                        -LoadBalancer $LoadBalancerObject `
                        -Name $LBRuleObject.Name `
                        -FrontendIpConfigurationId `
                        $LBRuleObject.FrontendIpConfiguration.ID `
                        -Protocol $LBRuleObject.Protocol `
                        -FrontendPort $LBRuleObject.FrontendPort `
                        -BackendPort  $LBRuleObject.BackEndPort `
                        -IdleTimeoutInMinutes  $LBRuleObject.IdleTimeoutInMinutes `
                        -BackendAddressPoolId  $CurrentBEID `
                        -LoadDistribution $LBRuleLoadDisto `
                        -EnableFloatingIP `
                        -ProbeID $LBRuleObject.Probe.ID -Verbose -ErrorAction `
                        'Stop' | Out-Null                                                   # Changes the rule load disto
                }                                                                           # End elseif ($LBRuleObject.EnableFloatingIP -eq $True)
                elseif ($LBRuleObject.EnableTcpReset -eq $true) {                           # Else if $LBRuleObject.EnableTcpReset equals $true
                    Set-AzLoadBalancerRuleConfig `
                        -LoadBalancer $LoadBalancerObject `
                        -Name $LBRuleObject.Name `
                        -FrontendIpConfigurationId `
                        $LBRuleObject.FrontendIpConfiguration.ID `
                        -Protocol $LBRuleObject.Protocol `
                        -FrontendPort $LBRuleObject.FrontendPort `
                        -BackendPort  $LBRuleObject.BackEndPort `
                        -IdleTimeoutInMinutes  $LBRuleObject.IdleTimeoutInMinutes `
                        -BackendAddressPoolId  $CurrentBEID `
                        -LoadDistribution $LBRuleLoadDisto `
                        -EnableTcpReset `
                        -ProbeID $LBRuleObject.Probe.ID -Verbose -ErrorAction `
                        'Stop' | Out-Null                                                   # Changes the rule load disto    
                }                                                                           # End elseif ($LBRuleObject.EnableTcpReset -eq $true) 
                else {                                                                      # Else if $LBRuleObject.EnableFloatingIP and $LBRuleObject.EnableTcpReset does not equal $true
                    Set-AzLoadBalancerRuleConfig `
                        -LoadBalancer $LoadBalancerObject `
                        -Name $LBRuleObject.Name `
                        -FrontendIpConfigurationId `
                        $LBRuleObject.FrontendIpConfiguration.ID `
                        -Protocol $LBRuleObject.Protocol `
                        -FrontendPort $LBRuleObject.FrontendPort `
                        -BackendPort  $LBRuleObject.BackEndPort `
                        -IdleTimeoutInMinutes  $LBRuleObject.IdleTimeoutInMinutes `
                        -BackendAddressPoolId  $CurrentBEID `
                        -LoadDistribution $LBRuleLoadDisto `
                        -ProbeID $LBRuleObject.Probe.ID -Verbose -ErrorAction `
                        'Stop' | Out-Null                                                   # Changes the rule load disto
                }                                                                           # End Else (if ($LBBEObject.EnableFloatingIP -eq $True -and $LBBEObject.EnableTcpReset -eq $True))
                Write-Host 'Saving the load balancer configuration'                         # Write message to screen
                $LoadBalancerObject | Set-AzLoadBalancer -ErrorAction 'Stop' | Out-Null     # Saves the changes to $LoadBalancerObject
            }                                                                               # End try
            Catch {                                                                         # If try fails
                Clear-Host                                                                  # Clears screen
                Write-Host 'An error has occured'                                           # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break SetAzureLBRuleLoadDisto                                               # Breaks :SetAzureLBRuleLoadDisto
            }                                                                               # End catch
            Clear-Host                                                                      # Clears screen
            Write-Host 'Requested changes have been made'                                   # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            Pause                                                                           # Pauses all actions for operator input
            Break SetAzureLBRuleLoadDisto                                                   # Breaks :SetAzureLBRuleLoadDisto
        }                                                                                   # End :SetAzureLBRuleLoadDisto while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function SetAzLBRuleLoadDisto