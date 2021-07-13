# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Mircosoft docs links
    Set-AzLoadBalancerInboundNatRuleConfig:     https://docs.microsoft.com/en-us/powershell/module/az.network/set-azloadbalancerinboundnatruleconfig?view=azps-6.2.0
    Set-AzLoadBalancer:                         https://docs.microsoft.com/en-us/powershell/module/az.network/set-azloadbalancer?view=azps-6.1.0
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
    SetAzLBNatRuleTargetPort:   Function to change an existing load balancer nat rule target port
    GetAzLBNatRuleConfig:       Function for getting load balancer nat rule
} #>
<# Variables: {      
    :SetAzureLBNatRule          Outer loop for managing function
    :NewAzureLBNatRulePort      Inner loop for setting the nat rule target port
    $CallingFunction:           Name of this function or the one that called it
    $LBNatRule:                 Nat rule object
    $LoadBalancerObject:        Load balancer object
    $ValidArray:                Array of valid characters for the port
    $LBNatRuleTargetPort:       Operator input for the new nat rule target port
    $LBRuleArray:               $LBNatRuleTargetPort converted to array
    $OpConfirm:                 Operator confirmation to change the source port
    $OpSelect:                  Operator selection to change the target port and enable floating IP
    $EnableFIP:                 Flag for enabling or disabling floating IP
    GetAzLBNatRuleConfig{}      Gets $LBNatRule, $LoadBalancerObject
} #>
<# Process Flow {
    function
        Call SetAzLBNatRuleTargetPort > Get $null
            Call GetAzLBNatRuleConfig > Get $LBNatRule, $LoadBalancerObject
            End GetAzLBNatRuleConfig
                Return SetAzLBNatRuleTargetPort > Send $LBNatRule, $LoadBalancerObject
        End SetAzLBNatRuleTargetPort
            Return function > Send $null
}#>
function SetAzLBNatRuleTargetPort {                                                         # Function to change an existing load balancer nat rule target port
    Begin {                                                                                 # Begin function
        if (!$CallingFunction) {                                                            # If $CallingFunction is $null
            $CallingFunction = 'SetAzLBNatRuleTargetPort'                                   # Creates $CallingFunction
        }                                                                                   # End if (!$CallingFunction)
        :SetAzureLBNatRule while ($true) {                                                  # Outer loop for managing function
            $LBNatRule, $LoadBalancerObject = GetAzLBNatRuleConfig ($CallingFunction)       # Calls function and assigns output to $var
            if (!$LBNatRule) {                                                              # If $LBNatRule is $null
                Break SetAzureLBNatRule                                                     # Breaks :SetAzureLBNatRule
            }                                                                               # End if (!$LBNatRule)
            $ValidArray = '0123456789'                                                      # Creates a string of valid characters
            $ValidArray = $ValidArray.ToCharArray()                                         # Loads all valid characters into array
            :NewAzureLBNatRulePort while ($true) {                                          # Inner loop for setting the nat rule port
                Write-Host 'Enter the nat rule pool target port'                            # Write message to screen
                Write-Host ''                                                               # Writes message to screen
                $LBNatRuleTargetPort = Read-Host 'Port #'                                   # Operator input for the nat rule port 
                $LBRuleArray = $LBNatRuleTargetPort.ToCharArray()                           # Adds $LBNatRuleTargetPort to array
                Clear-Host                                                                  # Clears screen
                foreach ($_ in $LBRuleArray) {                                              # For each item in $LBRuleArray
                    if ($_ -notin $ValidArray) {                                            # If current item is not in $ValidArray
                        $LBNatRuleTargetPort = $null                                        # Clears $LBNatRuleTargetPort
                    }                                                                       # End if ($_ -notin $ValidArray)
                }                                                                           # End foreach ($_ in $LBRuleArray)
                $LBRuleArray = $null                                                        # Clears $LBRuleArray
                if ($LBNatRuleTargetPort) {                                                 # If $LBNatRuleTargetPort has a value
                    Write-Host 'Current Target Port:'$LBNatRule.BackEndPort                 # Write message to screen
                    Write-Host 'New Target Port:    '$LBNatRuleTargetPort                   # Write message to screen
                    Write-Host ''                                                           # Writes message to screen
                    Write-Host 'Make this change'                                           # Write message to screen
                    $OpConfirm = Read-Host '[Y] Yes [N] No [E] Exit'                        # Operator confirmation of the nat rule port
                    Clear-Host                                                              # Clears screen
                    if ($OpConfirm -eq 'e') {                                               # If $OpConfirm equals 'e'
                        Break SetAzureLBNatRule                                             # Breaks :SetAzureLBNatRule
                    }                                                                       # End if ($OpConfirm -eq 'e')
                    if ($OpConfirm -eq 'y') {                                               # If $OpConfirm equals 'y'
                        if ($LBNatRuleTargetPort -ne $LBNatRule.FrontendPort) {             # If $LBNatRuleTargetPort does not equal $LBNatRule.FrontendPort
                            Write-Host 'Enable floating IP'                                 # Write message to screen
                            Write-Host ''                                                   # Write message to screen
                            $OpSelect = Read-Host '[Y] Yes [N] No'                          # Operator selection to enable floating IP
                            Clear-Host                                                      # Clears screen
                            if ($OpSelect -eq 'y') {                                        # If $OpSelect equals 'y'
                                $EnableFIP = 'y'                                            # Sets $EnableFIP
                            }                                                               # End if ($OpSelect -eq 'y')
                            else {                                                          # All other inputs for $OpSelect
                                $EnableFIP = 'n'                                            # Sets $EnableFIP
                            }                                                               # End else (if ($OpSelect -eq 'y'))
                        }                                                                   # End if ($LBNatRuleTargetPort -ne $LBNatRule.FrontendPort)
                        Break NewAzureLBNatRulePort                                         # Breaks :NewAzureLBNatRulePort        
                    }                                                                       # End if ($OpConfirm -eq 'y')
                }                                                                           # End if ($LBNatRuleTargetPort)
                else {                                                                      # Else if $LBNatRuleTargetPort is $null
                    Write-Host 'That was not a valid input'                                 # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Clear-Host                                                              # Clears screen
                }                                                                           # End else (if ($LBNatRuleTargetPort))
            }                                                                               # End :NewAzureLBNatRulePort while ($true)
            Write-Host 'Changing the nat rule target port'                                  # Write message to screen
            Try {                                                                           # Try the following
                if ($EnableFIP -eq 'y' -and $LBNatRule.EnableTCPReset -eq $true) {          # If $EnableFIP equals 'y' and .EnableTCPReset equal $true
                    Set-AzLoadBalancerInboundNatRuleConfig `
                        -LoadBalancer $LoadBalancerObject `
                        -Name $LBNatRule.Name `
                        -FrontendIpConfigurationId `
                        $LBNatRule.FrontendIpConfiguration.ID `
                        -Protocol $LBNatRule.Protocol `
                        -FrontendPort $LBNatRule.FrontEndPort `
                        -BackendPort $LBNatRuleTargetPort `
                        -IdleTimeoutInMinutes  $LBNatRule.IdleTimeoutInMinutes `
                        -EnableFloatingIP `
                        -EnableTcpReset `
                        -ErrorAction 'Stop' | Out-Null                                      # Changes the nat rule port config
                }                                                                           # End if ($EnableFIP -eq 'y' -and $LBNatRule.EnableTCPReset -eq $true)
                elseif ($EnableFIP -eq 'n' -and $LBNatRule.EnableTCPReset -eq $true) {      # If $LBNatRule.EnableTCPReset equals $true
                    Set-AzLoadBalancerInboundNatRuleConfig `
                        -LoadBalancer $LoadBalancerObject `
                        -Name $LBNatRule.Name `
                        -FrontendIpConfigurationId `
                        $LBNatRule.FrontendIpConfiguration.ID `
                        -Protocol $LBNatRule.Protocol `
                        -FrontendPort $LBNatRule.FrontEndPort `
                        -BackendPort $LBNatRuleTargetPort `
                        -IdleTimeoutInMinutes  $LBNatRule.IdleTimeoutInMinutes `
                        -EnableTcpReset `
                        -ErrorAction 'Stop' | Out-Null                                      # Changes the nat rule port config
                }                                                                           # End elseif ($EnableFIP -eq 'n' -and $LBNatRule.EnableTCPReset -eq $true)
                elseif ($EnableFIP -eq 'y' -and $LBNatRule.EnableTCPReset -eq $false) {     # If $EnableFIP equals 'y'
                    Set-AzLoadBalancerInboundNatRuleConfig `
                        -LoadBalancer $LoadBalancerObject `
                        -Name $LBNatRule.Name `
                        -FrontendIpConfigurationId `
                        $LBNatRule.FrontendIpConfiguration.ID `
                        -Protocol $LBNatRule.Protocol `
                        -FrontendPort $LBNatRule.FrontEndPort `
                        -BackendPort $LBNatRuleTargetPort `
                        -IdleTimeoutInMinutes  $LBNatRule.IdleTimeoutInMinutes `
                        -EnableFloatingIP `
                        -ErrorAction 'Stop' | Out-Null                                      # Changes the nat rule port config
                }                                                                           # End elseif ($EnableFIP -eq 'y' -and $LBNatRule.EnableTCPReset -eq $false)
                else {                                                                      # Else if $EnableFIP equals 'n' .EnableTCPReset equal $false
                    Set-AzLoadBalancerInboundNatRuleConfig `
                        -LoadBalancer $LoadBalancerObject `
                        -Name $LBNatRule.Name `
                        -FrontendIpConfigurationId `
                        $LBNatRule.FrontendIpConfiguration.ID `
                        -Protocol $LBNatRule.Protocol `
                        -FrontendPort $LBNatRule.FrontEndPort `
                        -BackendPort $LBNatRuleTargetPort `
                        -IdleTimeoutInMinutes  $LBNatRule.IdleTimeoutInMinutes `
                        -ErrorAction 'Stop' | Out-Null                                      # Changes the nat rule port config
                }                                                                           # End else (if ($EnableFIP -eq 'y' -and $LBNatRule.EnableTCPReset -eq $true))
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
}                                                                                           # End function SetAzLBNatRuleTargetPort