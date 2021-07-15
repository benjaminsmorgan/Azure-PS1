# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Mircosoft docs links
    Get-AzLoadBalancerRuleConfig:               https://docs.microsoft.com/en-us/powershell/module/az.network/get-azloadbalancerruleconfig?view=azps-6.2.0
    Get-AzLoadBalancerFrontendIpConfig:         https://docs.microsoft.com/en-us/powershell/module/az.network/get-azloadbalancerfrontendipconfig?view=azps-6.1.0
    Get-AzPublicIpAddress:                      https://docs.microsoft.com/en-us/powershell/module/az.network/get-azpublicipaddress?view=azps-5.5.0
    Set-AzLoadBalancerInboundNatRuleConfig:     https://docs.microsoft.com/en-us/powershell/module/az.network/set-azloadbalancerinboundnatruleconfig?view=azps-6.2.0
    Set-AzLoadBalancer:                         https://docs.microsoft.com/en-us/powershell/module/az.network/set-azloadbalancer?view=azps-6.2.0
    Get-AzLoadBalancerInboundNatRuleConfig:     https://docs.microsoft.com/en-us/powershell/module/az.network/get-azloadbalancerinboundnatruleconfig?view=azps-6.1.0
    Get-AzLoadBalancer:                         https://docs.microsoft.com/en-us/powershell/module/az.network/gew-azloadbalancer?view=azps-5.5.0  
    Get-AzNetworkInterface:                     https://docs.microsoft.com/en-us/powershell/module/az.network/get-aznetworkinterface?view=azps-6.1.0
    Get-AzNetworkInterfaceIpConfig:             https://docs.microsoft.com/en-us/powershell/module/az.network/get-aznetworkinterfaceipconfig?view=azps-6.1.0
} #>
<# Required Functions Links: {
    GetAzLBNatRuleConfig:       https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/Load%20Balancer/Nat%20Rule%20Config/GetAzLBNatRuleConfig.ps1
} #>
<# Functions Description: {
    SetAzLBNatRuleFloatIP:      Function to Enable/Disable floating IP on nat rule
    GetAzLBNatRuleConfig:       Function for getting load balancer nat rule
} #>
<# Variables: {      
    :SetAzureLBNatRule          Outer loop for managing function
    :SetAzureNatRuleFIP         Inner loop for select the enable TCP reset value
    $CallingFunction:           Name of this function or the one that called it
    $LBNatRule:                 Nat rule object
    $LoadBalancerObject:        Load balanacer object
    $OpSelect:                  Operator selection of enable TCP reset
    $ETCPReset:                 New value of enable TCP reset
    $LBNatRuleTargetPort:       $LBNatRule.BackEndPort
    $EFloatIP:                  Current value of enable floating IP
    GetAzLBNatRuleConfig{}      Gets $LBNatRule, $LoadBalancerObject
} #>
<# Process Flow {
    function
        Call SetAzLBNatRuleFloatIP > Get $null
            Call GetAzLBNatRuleConfig > Get $LBNatRule, $LoadBalancerObject
            End GetAzLBNatRuleConfig
                Return SetAzLBNatRuleFloatIP > Send $LBNatRule, $LoadBalancerObject
        End SetAzLBNatRuleFloatIP
            Return function > Send $null
}#>
function SetAzLBNatRuleFloatIP {                                                            # Function to Enable/Disable floating IP on nat rule 
    Begin {                                                                                 # Begin function
        if (!$CallingFunction) {                                                            # If $CallingFunction is $null
            $CallingFunction = 'SetAzLBNatRuleFloatIP'                                      # Creates $CallingFunction
        }                                                                                   # End if (!$CallingFunction)
        :SetAzureLBNatRule while ($true) {                                                  # Outer loop for managing function
            $LBNatRule, $LoadBalancerObject = GetAzLBNatRuleConfig ($CallingFunction)       # Calls function and assigns output to $var
            if (!$LBNatRule) {                                                              # If $LBNatRule is $null
                Break SetAzureLBNatRule                                                     # Breaks :SetAzureLBNatRule
            }                                                                               # End if (!$LBNatRule)
            :SetAzureNatRuleFIP while ($true) {                                             # Inner loop for setting the nat rule enablefloatingIP
                Write-Host 'Rule Name:    '$LBNatRule.name                                  # Write message to screen
                Write-Host 'Load Balancer:'$LoadBalancerObject.name                         # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Write-Host 'Floating IP options'                                            # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Write-Host '[0] Exit'                                                       # Write message to screen
                Write-Host '[1] Disabled'                                                   # Write message to screen
                Write-Host '[2] Enabled'                                                    # Write message to screen
                Write-Host ''                                                               # Write message to screen
                $OpSelect = Read-Host 'Option [#]'                                          # Operator input to select floating IP value
                Clear-Host                                                                  # Clears screen
                if ($OpSelect -eq '0') {                                                    # If $OpSelect equals '0'
                    Break SetAzureLBNatRule                                                 # Breaks SetAzureLBNatRule
                }                                                                           # End if ($OpSelect -eq '0')
                elseif ($OpSelect -eq '1') {                                                # Else if $OpSelect equals '1'
                    $EFloatIP = $false                                                      # Sets $EFloatIP
                    Write-Host 'Disabling Floating IP'                                      # Write message to screen
                    Break SetAzureNatRuleFIP                                                # Breaks :SetAzureNatRuleFIP
                }                                                                           # End elseif ($OpSelect -eq '1')
                elseif ($OpSelect -eq '2') {                                                # Else if $OpSelect equals '2'
                    $EFloatIP = $true                                                       # Sets $EFloatIP
                    Write-Host 'Enabling Floating IP'                                       # Write message to screen
                    Break SetAzureNatRuleFIP                                                # Breaks :SetAzureNatRuleFIP
                }                                                                           # End elseif ($OpSelect -eq '2')
                else {                                                                      # All other inputs for $OpSelect
                    Write-Host 'That was not a valid input'                                 # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Clear-Host                                                              # Clears screen
                }                                                                           # End else (if ($OpSelect -eq '0'))
            }                                                                               # End :SetAzureNatRuleFIP while ($true) 
            Clear-Host                                                                      # Clears screen
            $LBNatRuleTargetPort = $LBNatRule.BackEndPort                                   # Sets $LBNatRuleTargetPort
            if ($LBNatRule.enableTCPReset -eq $True) {                                      # If $LBNatRule.enableTCPReset equals $True                          
                $ETCPReset = $true                                                          # Sets $EFloatIP
            }                                                                               # End if ($LBNatRule.enableTCPReset -eq $True)
            else {                                                                          # Else if $LBNatRule.enableTCPReset does not equal $True 
                $ETCPReset = $false                                                         # Sets $EFloatIP
            }                                                                               # End else (if ($LBNatRule.enableTCPReset -eq $True))
            Try {                                                                           # Try the following
                Set-AzLoadBalancerInboundNatRuleConfig -LoadBalancer $LoadBalancerObject `
                    -Name $LBNatRule.Name -FrontendIpConfigurationId `
                    $LBNatRule.FrontendIPConfiguration.ID -Protocol $LBNatRule.Protocol `
                    -FrontendPort $LBNatRule.FrontEndPort -BackendPort `
                    $LBNatRuleTargetPort -EnableTcpReset:$ETCPReset `
                    -EnableFloatingIP:$EFloatIP -IdleTimeoutInMinutes `
                    $LBNatRule.IdleTimeoutInMinutes -ErrorAction 'Stop' | Out-Null          # Changes the nat rule enableFloatingIP value
                Write-Host 'Saving the load balancer configuration'                         # Write message to screen
                $LoadBalancerObject | Set-AzLoadBalancer -ErrorAction 'Stop' | Out-Null     # Saves the changes to $LoadBalancerObject
            }                                                                               # End try
            Catch {                                                                         # If try fails
                Clear-Host                                                                  # Clears screen
                Write-Host 'An error has occured'                                           # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break SetAzureLBNatRule                                                     # Breaks :SetAzureLBNatRule
            }                                                                               # End catch
            Clear-Host                                                                      # Clears screen
            Write-Host 'Requested changes have been made'                                   # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            Pause                                                                           # Pauses all actions for operator input
            Break SetAzureLBNatRule                                                         # Breaks :SetAzureLBNatRule
        }                                                                                   # End :SetAzureLBNatRule while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function SetAzLBNatRuleFloatIP