# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Mircosoft docs links
    Get-AzLoadBalancerBackendAddressPool:       https://docs.microsoft.com/en-us/powershell/module/az.network/get-azloadbalancerbackendaddresspool?view=azps-6.1.0
    Get-AzNetworkInterface:                     https://docs.microsoft.com/en-us/powershell/module/az.network/get-aznetworkinterface?view=azps-6.1.0
    Get-AzNetworkInterfaceIpConfig:             https://docs.microsoft.com/en-us/powershell/module/az.network/get-aznetworkinterfaceipconfig?view=azps-6.1.0
    Get-AzVM:                                   https://docs.microsoft.com/en-us/powershell/module/az.compute/get-azvm?view=azps-6.1.0
    Set-AzLoadBalancerRuleConfig:               https://docs.microsoft.com/en-us/powershell/module/az.network/set-azloadbalancerruleconfig?view=azps-6.1.0
    Set-AzLoadBalancer:                         https://docs.microsoft.com/en-us/powershell/module/az.network/set-azloadbalancer?view=azps-6.1.0
    Get-AzLoadBalancer:                         https://docs.microsoft.com/en-us/powershell/module/az.network/get-azloadbalancer?view=azps-5.5.0 
    Get-AzLoadBalancerRuleConfig:               https://docs.microsoft.com/en-us/powershell/module/az.network/get-azloadbalancerruleconfig?view=azps-6.1.0
} #>
<# Required Functions Links: {
    GetAzLBRuleConfig:          https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/Load%20Balancer/Rule%20Config/GetAzLBRuleConfig.ps1
    GetAzLBRuleBE:              https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/Load%20Balancer/Rule%20Config/GetAzLBRuleBE.ps1
} #>
<# Functions Description: {
    SetAzLBRuleBE:              Function to change an existing load balancer rule back end config
    GetAzLBRuleConfig:          Function to get an existing load balancer rule config
    GetAzLBRuleBE:              Function to get a load balancer front end config for load balancer rule
} #>
<# Variables: {      
    :SetAzureLBRuleBE           Outer loop for managing function
    $CallingFunction:           Name of this function or the one that called it
    $LBRuleObject:              Load balancer rule object
    $LoadBalancerObject:        Load balancer object
    $LBBEObject:                Load balancer back end object
    $CurrentBEName:             Name of the back end on $LBRuleObject
    $CurrentBEObject:           Back end object on $LBRuleObject
    $OpConfirm:                 Operator confirmation to make the change
    GetAzLBRuleConfig{}         Gets $LBRuleObject, $LoadBalancerObject
    GetAzLBRuleBE{}             Gets $LBBEObject
} #>
<# Process Flow {
    function
        Call SetAzLBRuleBE > Get $null
            Call GetAzLBRuleConfig > Get $LBRuleObject, $LoadBalancerObject
            End GetAzLBRuleConfig
                Return SetAzLBRuleBE > Send $LBRuleObject, $LoadBalancerObject
            Call GetAzLBRuleBE > Get $LBBEObject
            End GetAzLBRuleBE
                Return SetAzLBRuleBE > Send $LBBEObject
        End SetAzLBRuleBE
            Return function > Send $null
}#>
function SetAzLBRuleBE {                                                                    # Function to change an existing load balancer rule back end config
    Begin {                                                                                 # Begin function
        if (!$CallingFunction) {                                                            # If $CallingFunction is $null
            $CallingFunction = 'SetAzLBRuleBE'                                              # Creates $CallingFunction
        }                                                                                   # End if (!$CallingFunction)
        :SetAzureLBRuleBE while ($true) {                                                   # Outer loop for managing function
            $LBRuleObject, $LoadBalancerObject = GetAzLBRuleConfig ($CallingFunction)       # Calls function and assigns output to $var
            if (!$LBRuleObject) {                                                           # If $LBRuleObject is $null
                Break SetAzureLBRuleBE                                                      # Breaks :SetAzureLBRuleBE
            }                                                                               # End if (!$LBRuleObject)
            $LBBEObject = GetAzLBRuleBE ($CallingFunction, $LoadBalancerObject)             # Calls function and assigns output to $var
            if (!$LBBEObject) {                                                             # If $LBBEObject is $null
                Break SetAzureLBRuleBE                                                      # Breaks :SetAzureLBRuleBE
            }                                                                               # End if (!$LBBEObject)
            if ($LBRuleObject.BackendAddressPool.ID) {                                      # If $LBRuleObject.BackendAddressPool.ID has a value
                $CurrentBEName = $LBRuleObject.BackendAddressPool.ID                        # Isolates the back end ID
                $CurrentBEName = $CurrentBEName.Split('/')[-1]                              # Isolates the back end name
                $CurrentBEObject = Get-AzLoadBalancerBackendAddressPool -LoadBalancer `
                    $LoadBalancerObject -Name $CurrentBEName                                # Gets the current back end info
            }                                                                               # End if ($LBRuleObject.BackendAddressPool.ID)
            Write-Host 'Make the following change'                                          # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            Write-Host 'Current Back End'                                                   # Write message to screen
            if ($CurrentBEObject.Name) {                                                    # If $CurrentBEObject.Name has a value
                Write-Host 'Name:    '$CurrentBEObject.Name                                 # Write message to screen
            }                                                                               # End if ($CurrentBEObject.Name)
            else {                                                                          # Else if $CurrentBEObject.Name is $null                                                                     
                Write-Host 'Name:     N/A'                                                  # Write message to screen
            }                                                                               # End else (if ($CurrentBEObject.Name))
            Write-Host ''                                                                   # Write message to screen
            Write-Host 'New Front End'                                                      # Write message to screen
            Write-Host 'Name:    '$LBBEObject.Name                                          # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            Write-Host 'Make this change'                                                   # Write message to screen
            $OpConfirm = Read-Host '[Y] Yes [N] No'                                         # Operator confrimation to change the rule back end
            Clear-Host                                                                      # Clears screen
            if ($OpConfirm -eq 'y') {                                                       # If $OPConfirm equals 'y'
                Write-Host 'Changing the rule back end configuration'                       # Write message to screen
                Try {                                                                       # Try the following
                    if ($LBRuleObject.EnableFloatingIP -eq $True `
                        -and $LBRuleObject.EnableTcpReset -eq $True) {                      # If $LBRuleObject.EnableFloatingIP and $LBRuleObject.EnableTcpReset equal $true
                        Set-AzLoadBalancerRuleConfig `
                            -LoadBalancer $LoadBalancerObject `
                            -Name $LBRuleObject.Name `
                            -FrontendIpConfigurationId `
                            $LBRuleObject.FrontendIpConfiguration.ID `
                            -Protocol $LBRuleObject.Protocol `
                            -FrontendPort $LBRuleObject.FrontendPort `
                            -BackendPort $LBRuleObject.BackEndPort `
                            -IdleTimeoutInMinutes $LBRuleObject.IdleTimeoutInMinutes `
                            -BackendAddressPoolId  $LBBEObject.ID `
                            -LoadDistribution $LBRuleObject.LoadDistribution `
                            -EnableTcpReset -EnableFloatingIP `
                            -ProbeID $LBRuleObject.Probe.ID -Verbose -ErrorAction `
                            'Stop' | Out-Null                                               # Changes the rule back end config
                    }                                                                       # End if ($LBRuleObject.EnableFloatingIP -eq $True -and $LBRuleObject.EnableTcpReset -eq $True)
                    elseif ($LBRuleObject.EnableFloatingIP -eq $True) {                     # Else if $LBRuleObject.EnableFloatingIP equals $True
                        Set-AzLoadBalancerRuleConfig `
                            -LoadBalancer $LoadBalancerObject `
                            -Name $LBRuleObject.Name `
                            -FrontendIpConfigurationId `
                            $LBRuleObject.FrontendIpConfiguration.ID `
                            -Protocol $LBRuleObject.Protocol `
                            -FrontendPort $LBRuleObject.FrontendPort `
                            -BackendPort $LBRuleObject.BackEndPort `
                            -IdleTimeoutInMinutes $LBRuleObject.IdleTimeoutInMinutes `
                            -BackendAddressPoolId  $LBBEObject.ID `
                            -LoadDistribution $LBRuleObject.LoadDistribution `
                            -EnableFloatingIP `
                            -ProbeID $LBRuleObject.Probe.ID -Verbose -ErrorAction `
                            'Stop' | Out-Null                                               # Changes the rule back end config
                    }                                                                       # End elseif ($LBRuleObject.EnableFloatingIP -eq $True)
                    elseif ($LBRuleObject.EnableTcpReset -eq $true) {                       # Else if $LBRuleObject.EnableTcpReset equals $true
                        Set-AzLoadBalancerRuleConfig `
                            -LoadBalancer $LoadBalancerObject `
                            -Name $LBRuleObject.Name `
                            -FrontendIpConfigurationId `
                            $LBRuleObject.FrontendIpConfiguration.ID `
                            -Protocol $LBRuleObject.Protocol `
                            -FrontendPort $LBRuleObject.FrontendPort `
                            -BackendPort $LBRuleObject.BackEndPort `
                            -IdleTimeoutInMinutes $LBRuleObject.IdleTimeoutInMinutes `
                            -BackendAddressPoolId  $LBBEObject.ID `
                            -LoadDistribution $LBRuleObject.LoadDistribution `
                            -EnableTcpReset `
                            -ProbeID $LBRuleObject.Probe.ID -Verbose -ErrorAction `
                            'Stop' | Out-Null                                               # Changes the rule back end config    
                    }                                                                       # End elseif ($LBRuleObject.EnableTcpReset -eq $true) 
                    else {                                                                  # Else if $LBRuleObject.EnableFloatingIP and $LBRuleObject.EnableTcpReset does not equal $true
                        Set-AzLoadBalancerRuleConfig `
                            -LoadBalancer $LoadBalancerObject `
                            -Name $LBRuleObject.Name `
                            -FrontendIpConfigurationId `
                            $LBRuleObject.FrontendIpConfiguration.ID `
                            -Protocol $LBRuleObject.Protocol `
                            -FrontendPort $LBRuleObject.FrontendPort `
                            -BackendPort $LBRuleObject.BackEndPort `
                            -IdleTimeoutInMinutes $LBRuleObject.IdleTimeoutInMinutes `
                            -BackendAddressPoolId  $LBBEObject.ID `
                            -LoadDistribution $LBRuleObject.LoadDistribution `
                            -ProbeID $LBRuleObject.Probe.ID -Verbose -ErrorAction `
                            'Stop' | Out-Null                                               # Changes the rule back end config
                    }                                                                       # End Else (if ($LBBEObject.EnableFloatingIP -eq $True -and $LBBEObject.EnableTcpReset -eq $True))
                    Write-Host 'Saving the load balancer configuration'                     # Write message to screen
                    $LoadBalancerObject | Set-AzLoadBalancer -ErrorAction 'Stop' | Out-Null # Saves the changes to $LoadBalancerObject
                }                                                                           # End try
                Catch {                                                                     # If try fails
                    Clear-Host                                                              # Clears screen
                    Write-Host 'An error has occured'                                       # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Break SetAzureLBRuleBE                                                  # Breaks :SetAzureLBRuleBE
                }                                                                           # End catch
                Clear-Host                                                                  # Clears screen
                Write-Host 'Requested changes have been made'                               # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break SetAzureLBRuleBE                                                      # Breaks :SetAzureLBRuleBE
            }                                                                               # End if ($OpConfirm -eq 'y')
            else  {                                                                         # All other inputs for $OpConfirm
                Break SetAzureLBRuleBE                                                      # Breaks :SetAzureLBRuleBE
            }                                                                               # End else (if ($OpConfirm -eq 'y'))
        }                                                                                   # End :SetAzureLBRuleBE while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function SetAzLBRuleBE