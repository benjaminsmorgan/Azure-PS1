# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Mircosoft docs links
    Get-AzLoadBalancerProbeConfig:              https://docs.microsoft.com/en-us/powershell/module/az.network/get-azloadbalancerprobeconfig?view=azps-6.1.0
    Get-AzLoadBalancerBackendAddressPool:       https://docs.microsoft.com/en-us/powershell/module/az.network/get-azloadbalancerbackendaddresspool?view=azps-6.1.0
    Set-AzLoadBalancerRuleConfig:               https://docs.microsoft.com/en-us/powershell/module/az.network/set-azloadbalancerruleconfig?view=azps-6.1.0
    Set-AzLoadBalancer:                         https://docs.microsoft.com/en-us/powershell/module/az.network/set-azloadbalancer?view=azps-6.1.0
    Get-AzLoadBalancer:                         https://docs.microsoft.com/en-us/powershell/module/az.network/get-azloadbalancer?view=azps-5.5.0 
    Get-AzLoadBalancerRuleConfig:               https://docs.microsoft.com/en-us/powershell/module/az.network/get-azloadbalancerruleconfig?view=azps-6.1.0
} #>
<# Required Functions Links: {
    GetAzLBRuleConfig:          https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/Load%20Balancer/Rule%20Config/GetAzLBRuleConfig.ps1
    GetAzLBRuleProbe:           https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/Load%20Balancer/Rule%20Config/GetAzLBRuleProbe.ps1
} #>
<# Functions Description: {
    SetAzLBRuleProbe:           Function to change an existing load balancer rule probe config
    GetAzLBRuleConfig:          Function to get an existing load balancer rule config
    GetAzLBRuleProbe:           Function to get an existing load balancer probe config for load balancer rule
} #>
<# Variables: {      
    :SetAzureLBRuleProbe        Outer loop for managing function
    $CallingFunction:           Name of this function or the one that called it
    $LBRuleObject:              Load balancer rule object
    $LoadBalancerObject:        Load balancer object
    $LBProbeObject:             Load balancer probe object
    $CurrentProbeName:          Name of the probe on $LBRuleObject
    $CurrentProbeObject:        Probe object on $LBRuleObject
    $OpConfirm:                 Operator confirmation to make the change
    $LBBackEndName:             Load balancer rule back end name
    $LBBackEndObject:           Load balancer rule back end object
    GetAzLBRuleConfig{}         Gets $LBRuleObject, $LoadBalancerObject
    GetAzLBRuleProbe{}          Gets $LBProbeObject
} #>
<# Process Flow {
    function
        Call SetAzLBRuleProbe > Get $null
            Call GetAzLBRuleConfig > Get $LBRuleObject, $LoadBalancerObject
            End GetAzLBRuleConfig
                Return SetAzLBRuleProbe > Send $LBRuleObject, $LoadBalancerObject
            Call GetAzLBRuleProbe > Get $LBProbeObject
            End GetAzLBRuleProbe
                Return SetAzLBRuleProbe > Send $LBProbeObject
        End SetAzLBRuleProbe
            Return function > Send $null
}#>
function SetAzLBRuleProbe {                                                                 # Function to change an existing load balancer rule probe config
    Begin {                                                                                 # Begin function
        if (!$CallingFunction) {                                                            # If $CallingFunction is $null
            $CallingFunction = 'SetAzLBRuleProbe'                                           # Creates $CallingFunction
        }                                                                                   # End if (!$CallingFunction)
        :SetAzureLBRuleProbe while ($true) {                                                # Outer loop for managing function
            $LBRuleObject, $LoadBalancerObject = GetAzLBRuleConfig ($CallingFunction)       # Calls function and assigns output to $var
            if (!$LBRuleObject) {                                                           # If $LBRuleObject is $null
                Break SetAzureLBRuleProbe                                                   # Breaks :SetAzureLBRuleProbe
            }                                                                               # End if (!$LBRuleObject)
            $LBProbeObject = GetAzLBRuleProbe ($CallingFunction, $LoadBalancerObject)       # Calls function and assigns output to $var
            if (!$LBProbeObject) {                                                          # If $LBProbeObject is $null
                Break SetAzureLBRuleProbe                                                   # Breaks :SetAzureLBRuleProbe
            }                                                                               # End if (!$LBProbeObject)
            $CurrentProbeName = $LBRuleObject.Probe.ID                                      # Isolates the probe ID
            $CurrentProbeName = $CurrentProbeName.Split('/')[-1]                            # Isolates the probe name
            $CurrentProbeObject = Get-AzLoadBalancerProbeConfig -LoadBalancer `
                $LoadBalancerObject -Name $CurrentProbeName                                 # Gets the current probe info
            Write-Host 'Make the following change'                                          # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            Write-Host 'Current Probe'                                                      # Write message to screen
            Write-Host 'Name:    '$CurrentProbeObject.Name                                  # Write message to screen
            Write-Host 'Protocol:'$CurrentProbeObject.Protocol                              # Write message to screen
            Write-Host 'Port:    '$CurrentProbeObject.Port                                  # Write message to screen
            Write-Host 'Interval:'$CurrentProbeObject.IntervalInSeconds                     # Write message to screen
            Write-Host 'Count:   '$CurrentProbeObject.NumberOfProbes                        # Write message to screen
            if ($CurrentProbeObject.RequestPath) {                                          # If $CurrentProbeObject.RequestPath has a value
                Write-Host 'RPath:   '$CurrentProbeObject.RequestPath                       # Write message to screen
            }                                                                               # End if ($CurrentProbeObject.RequestPath)
            else {                                                                          # Else if $CurrentProbeObject.RequestPath is $null
                Write-Host 'RPath:    N/A'                                                  # Write message to screen
            }                                                                               # End else (if ($CurrentProbeObject.RequestPath))
            Write-Host ''                                                                   # Write message to screen
            Write-Host 'New Probe'                                                          # Write message to screen
            Write-Host 'Name:    '$LBProbeObject.Name                                       # Write message to screen
            Write-Host 'Protocol:'$LBProbeObject.Protocol                                   # Write message to screen
            Write-Host 'Port:    '$LBProbeObject.Port                                       # Write message to screen
            Write-Host 'Interval:'$LBProbeObject.IntervalInSeconds                          # Write message to screen
            Write-Host 'Count:   '$LBProbeObject.NumberOfProbes                             # Write message to screen
            if ($LBProbeObject.RequestPath) {                                               # If $LBProbeObject.RequestPath has a value
                Write-Host 'RPath:   '$LBProbeObject.RequestPath                            # Write message to screen
            }                                                                               # End if ($LBProbeObject.RequestPath)
            else {                                                                          # Else if $LBProbeObject.RequestPath is $null
                Write-Host 'RPath:    N/A'                                                  # Write message to screen
            }                                                                               # End else (if ($LBProbeObject.RequestPath))
            Write-Host ''                                                                   # Write message to screen
            Write-Host 'Make this change'                                                   # Write message to screen
            $OpConfirm = Read-Host '[Y] Yes [N] No'                                         # Operator confrimation to change the rule probe
            Clear-Host                                                                      # Clears screen
            if ($LBRuleObject.BackendAddressPool.ID) {                                      # If $LBRuleObject.BackendAddressPool.ID has a value
                $LBBackEndName = $LBRuleObject.BackendAddressPool.ID                        # Isolates the rule backend ID
                $LBBackEndName = $LBBackEndName.Split('/')[-1]                              # Isolates the rule back end name
                $LBBackEndObject = Get-AzLoadBalancerBackendAddressPool `
                    -LoadBalancer $LoadBalancerObject -Name $LBBackEndName                  # Gets the back end object
            }                                                                               # End if ($LBRuleObject.BackendAddressPool.ID)
            else {                                                                          # Else if $LBRuleObject.BackendAddressPool.ID is $null
                $LBBackEndObject = $null                                                    # Clears $LBBackEndObject                                       
            }                                                                               # End else (if ($LBRuleObject.BackendAddressPool.ID))
            if ($OpConfirm -eq 'y') {                                                       # If $OPConfirm equals 'y'
                Write-Host 'Changing the rule probe configuration'                          # Write message to screen
                Try {                                                                       # Try the following
                    if ($LBRuleObject.EnableFloatingIP -eq $True `
                        -and $LBRuleObject.EnableTcpReset -eq $True) {                      # If $LBRuleObject.EnableFloatingIP and $LBRuleObject.EnableTcpReset equal $true
                        Set-AzLoadBalancerRuleConfig `
                            -LoadBalancer $LoadBalancerObject `
                            -Name $LBRuleObject.Name `
                            -FrontendIpConfigurationId `
                            $LBRuleObject.FrontendIPConfiguration.ID `
                            -Protocol $LBRuleObject.Protocol `
                            -FrontendPort $LBRuleObject.FrontendPort `
                            -BackendPort $LBRuleObject.BackEndPort `
                            -IdleTimeoutInMinutes $LBRuleObject.IdleTimeoutInMinutes `
                            -BackendAddressPoolId  $LBBackEndObject.ID `
                            -LoadDistribution $LBRuleObject.LoadDistribution `
                            -EnableTcpReset -EnableFloatingIP `
                            -ProbeID $LBProbeObject.ID -Verbose -ErrorAction `
                            'Stop' | Out-Null                                               # Changes the rule probe config
                    }                                                                       # End if ($LBRuleObject.EnableFloatingIP -eq $True -and $LBRuleObject.EnableTcpReset -eq $True)
                    elseif ($LBRuleObject.EnableFloatingIP -eq $True) {                     # Else if $LBRuleObject.EnableFloatingIP equals $True
                        Set-AzLoadBalancerRuleConfig `
                            -LoadBalancer $LoadBalancerObject `
                            -Name $LBRuleObject.Name `
                            -FrontendIpConfigurationId `
                            $LBRuleObject.FrontendIPConfiguration.ID `
                            -Protocol $LBRuleObject.Protocol `
                            -FrontendPort $LBRuleObject.FrontendPort `
                            -BackendPort $LBRuleObject.BackEndPort `
                            -IdleTimeoutInMinutes $LBRuleObject.IdleTimeoutInMinutes `
                            -BackendAddressPoolId  $LBBackEndObject.ID `
                            -LoadDistribution $LBRuleObject.LoadDistribution `
                            -EnableFloatingIP `
                            -ProbeID $LBProbeObject.ID -Verbose -ErrorAction `
                            'Stop' | Out-Null                                               # Changes the rule probe config
                    }                                                                       # End elseif ($LBRuleObject.EnableFloatingIP -eq $True)
                    elseif ($LBRuleObject.EnableTcpReset -eq $true) {                       # Else if $LBRuleObject.EnableTcpReset equals $true
                        Set-AzLoadBalancerRuleConfig `
                            -LoadBalancer $LoadBalancerObject `
                            -Name $LBRuleObject.Name `
                            -FrontendIpConfigurationId `
                            $LBRuleObject.FrontendIPConfiguration.ID `
                            -Protocol $LBRuleObject.Protocol `
                            -FrontendPort $LBRuleObject.FrontendPort `
                            -BackendPort $LBRuleObject.BackEndPort `
                            -IdleTimeoutInMinutes $LBRuleObject.IdleTimeoutInMinutes `
                            -BackendAddressPoolId  $LBBackEndObject.ID `
                            -LoadDistribution $LBRuleObject.LoadDistribution `
                            -EnableTcpReset `
                            -ProbeID $LBProbeObject.ID -Verbose -ErrorAction `
                            'Stop' | Out-Null                                               # Changes the rule probe config    
                    }                                                                       # End elseif ($LBRuleObject.EnableTcpReset -eq $true) 
                    else {                                                                  # Else if $LBRuleObject.EnableFloatingIP and $LBRuleObject.EnableTcpReset does not equal $true
                        Set-AzLoadBalancerRuleConfig `
                            -LoadBalancer $LoadBalancerObject `
                            -Name $LBRuleObject.Name `
                            -FrontendIpConfigurationId `
                            $LBRuleObject.FrontendIPConfiguration.ID `
                            -Protocol $LBRuleObject.Protocol `
                            -FrontendPort $LBRuleObject.FrontendPort `
                            -BackendPort $LBRuleObject.BackEndPort `
                            -IdleTimeoutInMinutes $LBRuleObject.IdleTimeoutInMinutes `
                            -BackendAddressPoolId  $LBBackEndObject.ID `
                            -LoadDistribution $LBRuleObject.LoadDistribution `
                            -ProbeID $LBProbeObject.ID -Verbose -ErrorAction `
                            'Stop' | Out-Null                                               # Changes the rule probe config
                    }                                                                       # End Else (if ($LBProbeObject.EnableFloatingIP -eq $True -and $LBProbeObject.EnableTcpReset -eq $True))
                    Write-Host 'Saving the load balancer configuration'                     # Write message to screen
                    $LoadBalancerObject | Set-AzLoadBalancer -ErrorAction 'Stop' | Out-Null # Saves the changes to $LoadBalancerObject
                }                                                                           # End try
                Catch {                                                                     # If try fails
                    Clear-Host                                                              # Clears screen
                    Write-Host 'An error has occured'                                       # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Break SetAzureLBRuleProbe                                               # Breaks :SetAzureLBRuleProbe
                }                                                                           # End catch
                Clear-Host                                                                  # Clears screen
                Write-Host 'Requested changes have been made'                               # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break SetAzureLBRuleProbe                                                   # Breaks :SetAzureLBRuleProbe
            }                                                                               # End if ($OpConfirm -eq 'y')
            else  {                                                                         # All other inputs for $OpConfirm
                Break SetAzureLBRuleProbe                                                   # Breaks :SetAzureLBRuleProbe
            }                                                                               # End else (if ($OpConfirm -eq 'y'))
        }                                                                                   # End :SetAzureLBRuleProbe while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function SetAzLBRuleProbe