# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Mircosoft docs links
    Get-AzLoadBalancerRuleConfig:               https://docs.microsoft.com/en-us/powershell/module/az.network/get-azloadbalancerruleconfig?view=azps-6.2.0
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
    SetAzLBNatRuleTO:           Function to change an existing load balancer nat rule front end
    GetAzLBNatRuleConfig:       Function for getting load balancer nat rule
} #>
<# Variables: {      
    :SetAzureLBNatRule          Outer loop for managing function
    :SetAzureLBRuleIdleTO       Inner loop to set the nat rule time out
    $CallingFunction:           Name of this function or the one that called it
    $LBNatRule:                 Load balancer nat rule
    $LoadBalancerObject:        Load balancer object
    $LBFEObject:                Front end ip config object
    $ValidArray:                Array of valid characters for the nat rule time out
    $LBRuleIdleTO:              Operator input for the time out
    $LBRuleArray:               $LBRuleIdleTO converted to array
    $LBRuleIdleTOInt:           $LBRuleIdleTO converted to integer
    $OpConfirm:                 Operator confirmation to change the front end 
    $LBNatRuleFE:               $LBnatRule.FrontEndIPConfiguration.ID
    $LBNatRuleTargetPort:       $LBNatRule.BackEndPort           
    GetAzLBNatRuleConfig{}      Gets $LBNatRule, $LoadBalancerObject
} #>
<# Process Flow {
    function
        Call SetAzLBNatRuleTO > Get $null
            Call GetAzLBNatRuleConfig > Get $LBNatRule, $LoadBalancerObject
            End GetAzLBNatRuleConfig
                Return SetAzLBNatRuleTO > Send $LBNatRule, $LoadBalancerObject
        End SetAzLBNatRuleTO
            Return function > Send $null
}#>
function SetAzLBNatRuleTO {                                                                 # Function to change an existing load balancer nat rule time out
    Begin {                                                                                 # Begin function
        if (!$CallingFunction) {                                                            # If $CallingFunction is $null
            $CallingFunction = 'SetAzLBNatRuleTO'                                           # Creates $CallingFunction
        }                                                                                   # End if (!$CallingFunction)
        :SetAzureLBNatRule while ($true) {                                                  # Outer loop for managing function
            $LBNatRule, $LoadBalancerObject = GetAzLBNatRuleConfig ($CallingFunction)       # Calls function and assigns output to $var
            if (!$LBNatRule) {                                                              # If $LBNatRule is $null
                Break SetAzureLBNatRule                                                     # Breaks :SetAzureLBNatRule
            }                                                                               # End if (!$LBNatRule)
            $ValidArray = '0123456789'                                                      # Creates a string of valid characters
            $ValidArray = $ValidArray.ToCharArray()                                         # Loads all valid characters into array
            :SetAzureLBRuleIdleTO while ($true) {                                           # Inner loop for setting the nat rule idle timeout
                Write-Host 'Enter new idle time out in minutes for this nat rule'           # Write message to screen
                Write-Host ''                                                               # Writes message to screen
                $LBRuleIdleTO = Read-Host 'Idle timeout (Minutes)'                          # Operator input for the rule idle timeout 
                $LBRuleArray = $LBRuleIdleTO.ToCharArray()                                  # Adds $LBRuleIdleTO to array
                Clear-Host                                                                  # Clears screen
                foreach ($_ in $LBRuleArray) {                                              # For each item in $LBRuleArray
                    if ($_ -notin $ValidArray) {                                            # If current item is not in $ValidArray
                        $LBRuleIdleTO = $null                                               # Clears $LBRuleIdleTO
                    }                                                                       # End if ($_ -notin $ValidArray)
                }                                                                           # End foreach ($_ in $LBRuleArray)
                $LBRuleIdleTOInt = [INT]$LBRuleIdleTO                                       # Converts $LBRuleIdleTO to an integer
                if ($LBRuleIdleTOInt -lt 4 -or $LBRuleIdleTOInt -gt 30) {                   # if ($LBRuleIdleTOInt less than 4 or $LBRuleIdleTOInt greater than 30)
                    Write-Host 'The idle time out must be between 4 and 30 minutes'         # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    $LBRuleIdleTO = $null                                                   # Clears $LBRuleIdleTO
                }                                                                           # End if ($LBRuleIdleTOInt -lt 4 -or $LBRuleIdleTOInt -gt 30)
                $LBRuleArray = $null                                                        # Clears $LBRuleArray
                if ($LBRuleIdleTO) {                                                        # If $LBRuleIdleTO has a value
                    Write-Host 'Set'$LBRuleIdleTO' minutes as the rule idle time out'       # Write message to screen
                    Write-Host ''                                                           # Writes message to screen
                    $OpConfirm = Read-Host '[Y] Yes [N] No [E] Exit'                        # Operator confirmation of the idle timeout
                    Clear-Host                                                              # Clears screen
                    if ($OpConfirm -eq 'e') {                                               # If $OpConfirm equals 'e'
                        Break SetAzureLBNatRule                                             # Breaks :SetAzureLBNatRule
                    }                                                                       # End if ($OpConfirm -eq 'e')
                    if ($OpConfirm -eq 'y') {                                               # If $OpConfirm equals 'y'
                        Break SetAzureLBRuleIdleTO                                          # Breaks :SetAzureLBRuleIdleTO        
                    }                                                                       # End if ($OpConfirm -eq 'y')
                }                                                                           # End if ($LBRuleIdleTO)
                else {                                                                      # Else if $LBRuleIdleTO is $null
                    Pause                                                                   # Pauses all actions for operator input
                    Clear-Host                                                              # Clears screen
                }                                                                           # End else (if ($LBRuleIdleTO))
            }                                                                               # End :SetAzureLBRuleIdleTO while ($true)
            Write-Host ''                                                                   # Write message to screen
            if ($LBNatRule.IdleTimeoutInMinutes.length -eq 1) {                             # If $LBNatRule.IdleTimeoutInMinutes.length equals 1
                Write-Host 'Current time out:'$LBNatRule.IdleTimeoutInMinutes'  Minutes'    # Write message to screen
            }                                                                               # End if ($LBNatRule.IdleTimeoutInMinutes.length -eq 1) 
            else {                                                                          # Else if $LBNatRule.IdleTimeoutInMinutes.length does not equal 1
                Write-Host 'Current time out:'$LBNatRule.IdleTimeoutInMinutes' Minutes'     # Write message to screen
            }                                                                               # End else (if ($LBNatRule.IdleTimeoutInMinutes.length -eq 1))
            if ($LBRuleIdleTO.length -eq 1) {                                               # If $LBRuleIdleTO.length equals 1
                Write-Host 'New time out:    '$LBRuleIdleTO'    Minutes'                    # Write message to screen
            }                                                                               # End if ($LBRuleIdleTO.length -eq 1) 
            else {                                                                          # Else if $LBRuleIdleTO.length does not equal 1 
                Write-Host 'New time out:    '$LBRuleIdleTO'   Minutes'                     # Write message to screen
            }                                                                               # End else (if ($LBRuleIdleTO.length -eq 1) )
            Write-Host ''                                                                   # Write message to screen
            Write-Host 'Make this change'                                                   # Write message to screen
            $OpConfirm = Read-Host '[Y] Yes [N] No'                                         # Operator confrimation to change the nat rule front end
            Clear-Host                                                                      # Clears screen
            if ($OpConfirm -eq 'y') {                                                       # If $OPConfirm equals 'y'    
                $LBNatRuleTargetPort = $LBNatRule.BackEndPort                               # Sets $LBNatRuleTargetPort
                $LBNatRuleFE = $LBNatRule.FrontendIPConfiguration.ID                        # Isolates $LBNatRule.FrontendIPConfiguration.ID
                Write-Host 'Changing the nat rule idle time out'                            # Write message to screen
                Try {                                                                       # Try the following
                    if ($LBNatRule.EnableFloatingIP -eq $true -and `
                        $LBNatRule.EnableTCPReset -eq $true) {                              # If $LBNatRule.EnableFloatingIP equals $true and .EnableTCPReset equal $true
                        Set-AzLoadBalancerInboundNatRuleConfig `
                            -LoadBalancer $LoadBalancerObject `
                            -Name $LBNatRule.Name `
                            -FrontendIpConfigurationId $LBNatRuleFE `
                            -Protocol $LBNatRule.Protocol `
                            -FrontendPort $LBNatRule.FrontEndPort `
                            -BackendPort $LBNatRuleTargetPort `
                            -IdleTimeoutInMinutes $LBRuleIdleTO `
                            -EnableFloatingIP `
                            -EnableTcpReset `
                            -ErrorAction 'Stop' | Out-Null                                  # Changes the nat rule idle time out
                    }                                                                       # End if ($LBNatRule.EnableFloatingIP -eq $true -and $LBNatRule.EnableTCPReset -eq $true)
                    elseif ($LBNatRule.EnableFloatingIP -eq $false `
                        -and $LBNatRule.EnableTCPReset -eq $true) {                         # Else if $LBNatRule.EnableFloatingIP equals $false and .EnableTCPReset equal $true
                        Set-AzLoadBalancerInboundNatRuleConfig `
                            -LoadBalancer $LoadBalancerObject `
                            -Name $LBNatRule.Name `
                            -FrontendIpConfigurationId $LBNatRuleFE `
                            -Protocol $LBNatRule.Protocol `
                            -FrontendPort $LBNatRule.FrontEndPort `
                            -BackendPort $LBNatRuleTargetPort `
                            -IdleTimeoutInMinutes $LBRuleIdleTO `
                            -EnableTcpReset `
                            -ErrorAction 'Stop' | Out-Null                                  # Changes the nat rule idle time out
                    }                                                                       # End elseif ($LBNatRule.EnableFloatingIP -eq $false -and $LBNatRule.EnableTCPReset -eq $true)
                    elseif ($LBNatRule.EnableFloatingIP -eq $true -and `
                        $LBNatRule.EnableTCPReset -eq $false) {                             # Else if $LBNatRule.EnableFloatingIP equals $true and .EnableTCPReset equal $false
                        Set-AzLoadBalancerInboundNatRuleConfig `
                            -LoadBalancer $LoadBalancerObject `
                            -Name $LBNatRule.Name `
                            -FrontendIpConfigurationId $LBNatRuleFE `
                            -Protocol $LBNatRule.Protocol `
                            -FrontendPort $LBNatRule.FrontEndPort `
                            -BackendPort $LBNatRuleTargetPort `
                            -IdleTimeoutInMinutes $LBRuleIdleTO `
                            -EnableFloatingIP `
                            -ErrorAction 'Stop' | Out-Null                                  # Changes the nat rule idle time out
                    }                                                                       # End elseif ($LBNatRule.EnableFloatingIP -eq $true -and $LBNatRule.EnableTCPReset -eq $false)
                    else {                                                                  # Else if $LBNatRule.EnableFloatingIP equals $false and .EnableTCPReset equal $false
                        Set-AzLoadBalancerInboundNatRuleConfig `
                            -LoadBalancer $LoadBalancerObject `
                            -Name $LBNatRule.Name `
                            -FrontendIpConfigurationId $LBNatRuleFE `
                            -Protocol $LBNatRule.Protocol `
                            -FrontendPort $LBNatRule.FrontEndPort `
                            -BackendPort $LBNatRuleTargetPort `
                            -IdleTimeoutInMinutes $LBRuleIdleTO `
                            -ErrorAction 'Stop' | Out-Null                                  # Changes the nat rule idle time out
                    }                                                                       # End else (if ($LBNatRule.EnableFloatingIP -eq $true -and $LBNatRule.EnableTCPReset -eq $true))
                    Write-Host 'Saving the load balancer configuration'                     # Write message to screen
                    $LoadBalancerObject | Set-AzLoadBalancer -ErrorAction 'Stop' | Out-Null # Saves the changes to $LoadBalancerObject
                }                                                                           # End try
                Catch {                                                                     # If try fails
                    Clear-Host                                                              # Clears screen
                    Write-Host 'An error has occured'                                       # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Break SetAzureLBNatRule                                                 # Breaks :SetAzureLBNatRule
                }                                                                           # End catch
                Clear-Host                                                                  # Clears screen
                Write-Host 'Requested changes have been made'                               # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break SetAzureLBNatRule                                                     # Breaks :SetAzureLBNatRule
            }                                                                               # End if ($OpConfirm -eq 'y')
            else  {                                                                         # All other inputs for $OpConfirm
                Write-Host 'No changes have been made'                                      # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Break SetAzureLBNatRule                                                     # Breaks :SetAzureLBNatRule
            }                                                                               # End else (if ($OpConfirm -eq 'y'))                                                    
        }                                                                                   # End :SetAzureLBNatRule while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function SetAzLBNatRuleTO