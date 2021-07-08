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
    SetAzLBRuleFloatingIP:      Function to change an existing load balancer rule floating IP
    GetAzLBRuleConfig:          Function to get an existing load balancer rule config
} #>
<# Variables: {      
    :SetAzureLBRuleFloatingIP   Outer loop for managing function
    :NewAzureLBRuleFloatingIP   Inner loop to set the rule floating IP
    $CallingFunction:           Name of this function or the one that called it
    $LBRuleObject:              Load balancer rule object
    $LoadBalancerObject:        Load balancer object
    $CurrentBEName:             Current rule back end name
    $CurrentBEObject:           Current rule back end object
    $CurrentBEID:               Current rule back end object ID
    $OpSelect:                  Operator selection for the rule new floating IP setting
    $FloatingIP:                Load balancer rule new floating IP setting
    GetAzLBRuleConfig{}         Gets $LBRuleObject, $LoadBalancerObject
} #>
<# Process Flow {
    function
        Call SetAzLBRuleFloatingIP > Get $null
            Call GetAzLBRuleConfig > Get $LBRuleObject, $LoadBalancerObject
            End GetAzLBRuleConfig
                Return SetAzLBRuleFloatingIP > Send $LBRuleObject, $LoadBalancerObject
        End SetAzLBRuleFloatingIP
            Return function > Send $null
}#>
function SetAzLBRuleFloatingIP {                                                            # Function to change an existing load balancer rule floating IP
    Begin {                                                                                 # Begin function
        if (!$CallingFunction) {                                                            # If $CallingFunction is $null
            $CallingFunction = 'SetAzLBRuleFloatingIP'                                      # Creates $CallingFunction
        }                                                                                   # End if (!$CallingFunction)
        :SetAzureLBRuleFloatingIP while ($true) {                                           # Outer loop for managing function
            $LBRuleObject, $LoadBalancerObject = GetAzLBRuleConfig ($CallingFunction)       # Calls function and assigns output to $var
            if (!$LBRuleObject) {                                                           # If $LBRuleObject is $null
                Break SetAzureLBRuleFloatingIP                                              # Breaks :SetAzureLBRuleFloatingIP
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
            :NewAzureLBRuleFloatingIP while ($true) {                                       # Inner loop for setting the rule floating IP
                Write-Host 'Rule Name:    '$LBRuleObject.name                               # Write message to screen
                Write-Host 'Load Balancer:'$LoadBalancerObject.name                         # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Write-Host 'Floating IP options'                                            # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Write-Host '[0] Exit'                                                       # Write message to screen
                Write-Host '[1] Disabled'                                                   # Write message to screen
                Write-Host '[2] Enabled'                                                    # Write message to screen
                Write-Host ''                                                               # Write message to screen
                $OpSelect = Read-Host 'Option [#]'                                          # Operator input to select load disto
                Clear-Host                                                                  # Clears screen
                if ($OpSelect -eq '0') {                                                    # If $OpSelect equals '0'
                    Break SetAzureLBRuleFloatingIP                                          # Breaks SetAzureLBRuleFloatingIP
                }                                                                           # End if ($OpSelect -eq '0')
                elseif ($OpSelect -eq '1') {                                                # Else if $OpSelect equals '1'
                    $FloatingIP = 'Disabled'                                                # Sets $FloatingIP
                    Break NewAzureLBRuleFloatingIP                                          # Breaks :NewAzureLBRuleFloatingIP
                }                                                                           # End elseif ($OpSelect -eq '1')
                elseif ($OpSelect -eq '2') {                                                # Else if $OpSelect equals '2'
                    $FloatingIP = 'Enabled'                                                 # Sets $FloatingIP
                    Break NewAzureLBRuleFloatingIP                                          # Breaks :NewAzureLBRuleFloatingIP
                }                                                                           # End elseif ($OpSelect -eq '2')
                else {                                                                      # All other inputs for $OpSelect
                    Write-Host 'That was not a valid input'                                 # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Clear-Host                                                              # Clears screen
                }                                                                           # End else (if ($OpSelect -eq '0'))
            }                                                                               # End :NewAzureLBRuleFloatingIP while ($true)
            Try {                                                                           # Try the following
                if ($LBRuleObject.EnableTcpReset -eq $True `
                    -and $FloatingIP -eq 'Enabled') {                                       # If $LBRuleObject.EnableTcpReset equals $True -and $FloatingIP equals 'Enabled'
                    Write-Host 'Enabling Floating IP'                                       # Write message to screen
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
                        'Stop' | Out-Null                                                   # Changes the rule floating IP
                }                                                                           # End if ($LBRuleObject.EnableTcpReset -eq $True -and $FloatingIP -eq 'Enabled')
                elseif ($LBRuleObject.EnableFloatingIP -eq $false `
                    -and $FloatingIP -eq 'Enabled') {                                       # Else if $LBRuleObject.EnableFloatingIP equals $false -and $FloatingIP equals 'Enabled'
                    Write-Host 'Enabling Floating IP'                                       # Write message to screen
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
                        'Stop' | Out-Null                                                   # Changes the rule floating IP
                }                                                                           # End elseif ($LBRuleObject.EnableFloatingIP -eq $false -and $FloatingIP -eq 'Enabled')
                elseif ($LBRuleObject.EnableTcpReset -eq $true `
                    -and $FloatingIP -eq 'Disabled') {                                      # Else if $LBRuleObject.EnableFloatingIP equals $true -and $FloatingIP equals 'Disabled'
                    Write-Host 'Disabling Floating IP'                                      # Write message to screen
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
                        'Stop' | Out-Null                                                   # Changes the rule floating IP    
                }                                                                           # End elseif ($LBRuleObject.EnableTcpReset -eq $true -and $FloatingIP -eq 'Disabled')
                else {                                                                      # Else if $LBRuleObject.EnableFloatingIP equals $false -and $FloatingIP equals 'Disabled'
                    Write-Host 'Disabling Floating IP'                                      # Write message to screen
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
                        'Stop' | Out-Null                                                   # Changes the rule floating IP
                }                                                                           # End else (if ($LBRuleObject.EnableTcpReset -eq $True -and $FloatingIP -eq 'Enabled'))
                Write-Host 'Saving the load balancer configuration'                         # Write message to screen
                $LoadBalancerObject | Set-AzLoadBalancer -ErrorAction 'Stop' | Out-Null     # Saves the changes to $LoadBalancerObject
            }                                                                               # End try
            Catch {                                                                         # If try fails
                Clear-Host                                                                  # Clears screen
                Write-Host 'An error has occured'                                           # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break SetAzureLBRuleFloatingIP                                              # Breaks :SetAzureLBRuleFloatingIP
            }                                                                               # End catch
            Clear-Host                                                                      # Clears screen
            Write-Host 'Requested changes have been made'                                   # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            Pause                                                                           # Pauses all actions for operator input
            Break SetAzureLBRuleFloatingIP                                                  # Breaks :SetAzureLBRuleFloatingIP
        }                                                                                   # End :SetAzureLBRuleFloatingIP while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function SetAzLBRuleFloatingIP