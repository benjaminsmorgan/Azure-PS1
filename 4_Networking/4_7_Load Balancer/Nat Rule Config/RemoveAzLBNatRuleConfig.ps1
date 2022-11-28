# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Microsoft docs links
    Remove-AzLoadBalancerInboundNatRuleConfig:  https://docs.microsoft.com/en-us/powershell/module/az.network/remove-azloadbalancerinboundnatruleconfig?view=azps-6.1.0
    Set-AzLoadBalancerInboundNatRuleConfig:     https://docs.microsoft.com/en-us/powershell/module/az.network/set-azloadbalancerinboundnatruleconfig?view=azps-6.1.0
    Get-AzLoadBalancerInboundNatRuleConfig:     https://docs.microsoft.com/en-us/powershell/module/az.network/get-azloadbalancerinboundnatruleconfig?view=azps-6.1.0
    Get-AzLoadBalancer:                         https://docs.microsoft.com/en-us/powershell/module/az.network/gew-azloadbalancer?view=azps-5.5.0  
    Get-AzPublicIpAddress:                      https://docs.microsoft.com/en-us/powershell/module/az.network/get-azpublicipaddress?view=azps-5.5.0
    Get-AzLoadBalancerFrontendIpConfig:         https://docs.microsoft.com/en-us/powershell/module/az.network/get-azloadbalancerfrontendipconfig?view=azps-6.1.0
    Get-AzNetworkInterface:                     https://docs.microsoft.com/en-us/powershell/module/az.network/get-aznetworkinterface?view=azps-6.1.0
    Get-AzNetworkInterfaceIpConfig:             https://docs.microsoft.com/en-us/powershell/module/az.network/get-aznetworkinterfaceipconfig?view=azps-6.1.0
} #>
<# Required Functions Links: {
    GetAzLBNatRuleConfig:       https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/Load%20Balancer/Nat%20Rule%20Config/GetAzLBNatRuleConfig.ps1
} #>
<# Functions Description: {
    RemoveAzLBNatRuleConfig:    Function to remove a load balancer nat rule configuration
    GetAzLBNatRuleConfig:       Function for getting load balancer nat rule
} #>
<# Variables: {      
    :RemoveAzureLBNatRule       Outer loop for managing function
    $CallingFunction:           Name of this function, or the one that called it
    $LBNatRule:                 Load balancer nat rule object
    $LoadBalancerObject:        Load balancer object
    $OpConfirm:                 Opertator confirmation to remove the nat rule
    GetAzLBNatRuleConfig{}      Gets $LBNatRule, $LoadBalancerObject
} #>
<# Process Flow {
    function
        Call RemoveAzLBNatRuleConfig > Get $null
            Call GetAzLBNatRuleConfig > Get $LBNatRule, $LoadBalancerObject
            End GetAzLBNatRuleConfig
                Return RemoveAzLBNatRuleConfig > Send $LBNatRule, $LoadBalancerObject
        End RemoveAzLBNatRuleConfig
            Return function > Send $null
}#>
Function RemoveAzLBNatRuleConfig {                                                          # Function to remove a load balancer nat rule configuration
    Begin {                                                                                 # Begin function
        if (!$CallingFunction) {                                                            # If $CallingFunction is $null
            $CallingFunction = 'RemoveAzLBNatRuleConfig'                                    # Creates $CallingFunction
        }                                                                                   # End if (!$CallingFunction)
        :RemoveAzureLBNatRule while ($true) {                                               # Outer loop for managing function
            $LBNatRule, $LoadBalancerObject = GetAzLBNatRuleConfig ($CallingFunction)       # Calls function and assigns output to $vars
            if (!$LBNatRule) {                                                              # If $LBNatRule is $null
                Break RemoveAzureLBNatRule                                                  # Breaks :RemoveAzureLBNatRule
            }                                                                               # End if (!$LBNatRule)
            Write-Host 'Remove the following'                                               # Write message to screen
            Write-Host 'Nat Rule Config:'$LBNatRule.Name                                    # Write message to screen
            Write-Host 'Load Balancer:  '$LoadBalancerObject.Name                           # Write message to screen
            $OpConfirm = Read-Host '[Y] Yes [N] No'                                         # Operator confirmation of action
            Clear-Host                                                                      # Clears screen
            if ($OpConfirm -eq 'y') {                                                       # If $OpConfirm equals 'y'
                Try {                                                                       # Try the following
                    Remove-AzLoadBalancerInboundNatRuleConfig -LoadBalancer `
                        $LoadBalancerObject -Name $LBNatRule.Name -ErrorAction 'Stop' `
                        | Out-Null                                                          # Removes the nat rule
                    Set-AzLoadBalancer -LoadBalancer $LoadBalancerObject `
                        -ErrorAction 'Stop' | Out-Null                                      # Saves the load balancer config
                }                                                                           # End Try
                Catch {                                                                     # If Try fails
                    Write-Host 'An error has occured'                                       # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    Write-Host 'No changes have been made'                                  # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Break RemoveAzureLBNatRule                                              # Breaks :RemoveAzureLBNatRule
                }                                                                           # End catch
                Write-Host 'The nat rule has been removed'                                  # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break RemoveAzureLBNatRule                                                  # Breaks :RemoveAzureLBNatRule
            }                                                                               # End if ($OpConfirm -eq 'y')
            else {                                                                          # All other inputs for $OpConfirm
                Write-Host 'No changes have been made'                                      # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break RemoveAzureLBNatRule                                                  # Breaks :RemoveAzureLBNatRule
            }                                                                               # End else (if ($OpConfirm -eq 'y'))
        }                                                                                   # End :RemoveAzureLBNatRule while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End Function RemoveAzLBNatRuleConfig