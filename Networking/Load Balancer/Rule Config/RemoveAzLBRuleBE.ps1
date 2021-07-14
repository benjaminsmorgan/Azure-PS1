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
    RemoveAzLBRuleBE:           Function to change an existing load balancer rule back end config
    GetAzLBRuleConfig:          Function to get an existing load balancer rule config
} #>
<# Variables: {      
    :SetAzureLBRuleBE           Outer loop for managing function
    $CallingFunction:           Name of this function or the one that called it
    $LBRuleObject:              Load balancer rule object
    $LoadBalancerObject:        Load balancer object
    $CurrentBEName:             Name of the back end on $LBRuleObject
    $CurrentBEObject:           Back end object on $LBRuleObject
    $EFloatIP:                  Current value of $LBRuleObject.EnableFloatingIP
    $ETCPReset:                 Current value of $LBRuleObject.EnableTCPReset
    $OpConfirm:                 Operator confirmation to make the change
    GetAzLBRuleConfig{}         Gets $LBRuleObject, $LoadBalancerObject
} #>
<# Process Flow {
    function
        Call RemoveAzLBRuleBE > Get $null
            Call GetAzLBRuleConfig > Get $LBRuleObject, $LoadBalancerObject
            End GetAzLBRuleConfig
                Return RemoveAzLBRuleBE > Send $LBRuleObject, $LoadBalancerObject
        End RemoveAzLBRuleBE
            Return function > Send $null
}#>
    function RemoveAzLBRuleBE {                                                                 # Function to remove an existing load balancer rule back end config
        Begin {                                                                                 # Begin function
            if (!$CallingFunction) {                                                            # If $CallingFunction is $null
                $CallingFunction = 'RemoveAzLBRuleBE'                                           # Creates $CallingFunction
            }                                                                                   # End if (!$CallingFunction)
            :SetAzureLBRuleBE while ($true) {                                                   # Outer loop for managing function
                $LBRuleObject, $LoadBalancerObject = GetAzLBRuleConfig ($CallingFunction)       # Calls function and assigns output to $var
                if (!$LBRuleObject) {                                                           # If $LBRuleObject is $null
                    Break SetAzureLBRuleBE                                                      # Breaks :SetAzureLBRuleBE
                }                                                                               # End if (!$LBRuleObject)
                if ($LBRuleObject.BackendAddressPool.ID) {                                      # If $LBRuleObject.BackendAddressPool.ID has a value
                    $CurrentBEName = $LBRuleObject.BackendAddressPool.ID                        # Isolates the back end ID
                    $CurrentBEName = $CurrentBEName.Split('/')[-1]                              # Isolates the back end name
                    $CurrentBEObject = Get-AzLoadBalancerBackendAddressPool -LoadBalancer `
                        $LoadBalancerObject -Name $CurrentBEName                                # Gets the current back end info
                }                                                                               # End if ($LBRuleObject.BackendAddressPool.ID)
                else {                                                                          # Else if $LBRuleObject.BackendAddressPool.ID is $null
                    Write-Host 'This rule does not have a'                                      # Write message to screen
                    Write-Host 'back end associated to it'                                      # Write message to screen
                    Write-Host ''                                                               # Write message to screen
                    Write-Host 'No changes have been made'                                      # Write message to screen
                    Write-Host ''                                                               # Write message to screen
                    Pause                                                                       # Pauses all actions for operator input
                    Break SetAzureLBRuleBE                                                      # Breaks :SetAzureLBRuleBE    
                }                                                                               # End else (if ($LBRuleObject.BackendAddressPool.ID))
                Write-Host 'Remove the following'                                               # Write message to screen
                Write-Host ''                                                                   # Write message to screen
                Write-Host 'Current Back End'                                                   # Write message to screen
                Write-Host 'Name:     '$CurrentBEObject.Name                                    # Write message to screen
                Write-Host 'LB Name:  '$LoadBalancerObject.Name                                 # Write message to screen
                Write-Host 'Rule Name:'$LBRuleObject.Name                                       # Write message to screen
                Write-Host ''                                                                   # Write message to screen
                $OpConfirm = Read-Host '[Y] Yes [N] No'                                         # Operator confrimation to remove the rule back end
                Clear-Host                                                                      # Clears screen
                if ($OpConfirm -eq 'y') {                                                       # If $OPConfirm equals 'y'
                    Write-Host 'Changing the rule front end configuration'                      # Write message to screen
                    Try {                                                                       # Try the following
                        if ($LBRuleObject.EnableFloatingIP -eq $True) {                         # If $LBRuleObject.EnableFloatingIP equals $True                          
                            $EFloatIP = $true                                                   # Sets $EFloatIP
                        }                                                                       # End if ($LBRuleObject.EnableFloatingIP -eq $True)
                        else {                                                                  # Else if $LBRuleObject.EnableFloatingIP does not equal $True 
                            $EFloatIP = $false                                                  # Sets $EFloatIP
                        }                                                                       # End else (if ($LBRuleObject.EnableFloatingIP -eq $True))
                        if ($LBRuleObject.EnableTcpReset -eq $true) {                           # If $LBRuleObject.EnableTcpReset equals $true                               
                            $ETCPReset = $true                                                  # Sets $ETCPReset
                        }                                                                       # End if ($LBRuleObject.EnableTcpReset -eq $true)
                        else {                                                                  # Else if $LBRuleObject.EnableTcpReset does not equal $true
                            $ETCPReset = $false                                                 # Sets $ETCPReset
                        }                                                                       # End Else (if ($LBRuleObject.EnableTcpReset -eq $true))    
                        Set-AzLoadBalancerRuleConfig -LoadBalancer $LoadBalancerObject `
                            -Name $LBRuleObject.Name -FrontendIpConfigurationId `
                            $LBRuleObject.FrontendIpConfiguration.ID `
                            -Protocol $LBRuleObject.Protocol -FrontendPort `
                            $LBRuleObject.FrontendPort -BackendPort $LBRuleObject.BackEndPort `
                            -IdleTimeoutInMinutes $LBRuleObject.IdleTimeoutInMinutes `
                            -BackendAddressPoolId  $null -LoadDistribution `
                            $LBRuleObject.LoadDistribution -EnableTcpReset:$ETCPReset `
                            -EnableFloatingIP:$EFloatIP -ProbeID $LBRuleObject.Probe.ID `
                            -ErrorAction 'Stop' | Out-Null                                      # Removes the rule back end config
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
    }                                                                                           # End function RemoveAzLBRuleBE