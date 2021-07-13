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
    GetAzLBRuleFE:              https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/Load%20Balancer/Rule%20Config/GetAzLBRuleFE.ps1
} #>
<# Functions Description: {
    SetAzLBNatRuleFE:           Function to change an existing load balancer nat rule front end
    GetAzLBNatRuleConfig:       Function for getting load balancer nat rule
    GetAzLBRuleFE:              Function to get a load balancer front end config for load balancer rule
} #>
<# Variables: {      
    :SetAzureLBNatRule          Outer loop for managing function
    $CallingFunction:           Name of this function or the one that called it
    $LBNatRule:                 Load balancer nat rule
    $LoadBalancerObject:        Load balancer object
    $LBFEObject:                Front end ip config object
    $LBRules:                   $LBFEObject.LoadBalancingRules
    $CurrentRule:               Rule IDs on $LBFEObject
    $HAPortCheck:               Current rule object
    $CurrentFEName:             Nat rule current front end name
    $CurrentFEObject:           Nat rule current front end object
    $CurrentPublicSku:          Nat rule current front end public IP sku
    $OpConfirm:                 Operator confirmation to change the front end 
    $LBNatRuleTargetPort:       $LBNatRule.BackEndPort           
    GetAzLBNatRuleConfig{}      Gets $LBNatRule, $LoadBalancerObject
    GetAzLBRuleFE{}             Gets $LBFEObject
} #>
<# Process Flow {
    function
        Call SetAzLBNatRuleFE > Get $null
            Call GetAzLBNatRuleConfig > Get $LBNatRule, $LoadBalancerObject
            End GetAzLBNatRuleConfig
                Return SetAzLBNatRuleFE > Send $LBNatRule, $LoadBalancerObject
            Call GetAzLBRuleFE > Get $LBFEObject
            End GetAzLBRuleFE
                Return SetAzLBNatRuleFE > Send $LBFEObject
        End SetAzLBNatRuleFE
            Return function > Send $null
}#>
function SetAzLBNatRuleFE {                                                                 # Function to change an existing load balancer nat rule front end
    Begin {                                                                                 # Begin function
        if (!$CallingFunction) {                                                            # If $CallingFunction is $null
            $CallingFunction = 'SetAzLBNatRuleFE'                                           # Creates $CallingFunction
        }                                                                                   # End if (!$CallingFunction)
        :SetAzureLBNatRule while ($true) {                                                  # Outer loop for managing function
            $LBNatRule, $LoadBalancerObject = GetAzLBNatRuleConfig ($CallingFunction)       # Calls function and assigns output to $var
            if (!$LBNatRule) {                                                              # If $LBNatRule is $null
                Break SetAzureLBNatRule                                                     # Breaks :SetAzureLBNatRule
            }                                                                               # End if (!$LBNatRule)
            $LBFEObject = GetAzLBRuleFE ($CallingFunction, $LoadBalancerObject)             # Calls function and assigns output to $vars
            if (!$LBFEObject) {                                                             # If $LBFEObject is $null
                Break SetAzureLBNatRule                                                     # Breaks :SetAzureLBNatRule
            }                                                                               # End if (!$LBFEObject)
            if ($LBFEObject.LoadBalancingRules) {                                           # If $LBFEObject.LoadBalancingRules has a value
                Write-Host 'Validating front end configuration'                             # Write message to screen
                Write-Host 'This may take a moment'                                         # Write message to screen
                $LBRules = $LBFEObject.LoadBalancingRules                                   # $LBRules is equal to $LBFEObject.LoadBalancingRules
                foreach ($_ in $LBRules) {                                                  # For each item in $LBRules
                    $CurrentRule = $_.ID                                                    # Isolates the current rule ID
                    $CurrentRule = $CurrentRule.Split('/')[-1]                              # Isolates the current rule name
                    $HAPortCheck = Get-AzLoadBalancerRuleConfig -LoadBalancer `
                        $LoadBalancerObject -Name $CurrentRule                              # Pulls the current rule
                    if ($HAPortCheck.Protocol -eq 'all') {                                  # If $HAPortCheck.Protocol equals 'all'
                        Clear-Host                                                          # Clears screen                                  
                        Write-Host 'This front end is currently in use'                     # Write message to screen
                        Write-Host 'by a rule that is using all ports'                      # Write message to screen
                        Write-Host ''                                                       # Write message to screen
                        Write-Host 'This configuration is known as'                         # Write message to screen
                        Write-Host 'High Availability (HA) ports'                           # Write message to screen
                        Write-Host 'in the Azure portal'                                    # Write message to screen
                        Write-Host ''                                                       # Write message to screen
                        Write-Host 'Please choose another front end'                        # Write message to screen
                        Write-Host 'Or remove the following rule'                           # Write message to screen
                        Write-Host 'Rule name:'$CurrentRule                                 # Write message to screen
                        Write-Host ''                                                       # Write message to screen
                        Pause                                                               # Pauses all actions for operator input
                        Break SetAzureLBNatRule                                             # Breaks :SetAzureLBNatRule
                    }                                                                       # End if ($HAPortCheck.Protocol -eq 'all')
                    $CurrentRule = $null                                                    # Clears $var
                    $HAPortCheck = $null                                                    # Clears $var
                }                                                                           # End foreach ($_ in $LBRules)
                Clear-Host                                                                  # Clears screen            
            }                                                                               # End if ($LBFEObject.LoadBalancingRules)
            $CurrentFEName = $LBNatRule.FrontendIPConfiguration.ID                          # Isolates the front end ID
            $CurrentFEName = $CurrentFEName.Split('/')[-1]                                  # Isolates the front end name
            $CurrentFEObject = Get-AzLoadBalancerFrontendIpConfig -LoadBalancer `
                $LoadBalancerObject -Name $CurrentFEName                                    # Gets the current front end info
            if ($CurrentFEObject.PublicIpAddress) {                                         # If $CurrentFEObject.PublicIpAddress has a value
                $CurrentPublicSku = Get-AzPublicIpAddress | Where-Object `
                    {$_.Id -eq $CurrentFEObject.PublicIpAddress.Id}                         # Gets the current front end public IP object
            }                                                                               # End if ($CurrentFEObject.PublicIpAddress) 
            if ($LBFEObject.PublicIpAddress) {                                              # If $LBFEObject.PublicIpAddress has a value
                $NewPublicSku = Get-AzPublicIpAddress | Where-Object `
                    {$_.Id -eq $LBFEObject.PublicIpAddress.Id}                              # Gets the new front end public IP object
            }                                                                               # End if ($LBFEObject.PublicIpAddress) 
            Write-Host 'Make the following change'                                          # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            Write-Host 'Current Front End'                                                  # Write message to screen
            Write-Host 'Name:    '$CurrentFEObject.Name                                     # Write message to screen
            if ($CurrentFEObject.PrivateIpAddress) {                                        # If $CurrentFEObject.PrivateIpAddress has a value
                Write-Host 'Pri IP:  '$CurrentFEObject.PrivateIpAddress                     # Write message to screen
            }                                                                               # End if ($CurrentFEObject.PrivateIpAddress)
            else {                                                                          # Else if $CurrentFEObject.PrivateIpAddress is $null
                Write-Host 'Pri IP:   N/A'                                                  # Write message to screen
            }                                                                               # End else (if ($CurrentFEObject.PrivateIpAddress))
            Write-Host 'Pri Type:'$CurrentFEObject.PrivateIpAllocationMethod                # Write message to screen
            if ($CurrentPublicSku) {                                                        # If $CurrentPublicSku has a value
                Write-Host 'Pub IP:  '$CurrentPublicSku.IpAddress                           # Write message to screen
            }                                                                               # End if ($CurrentPublicSku) 
            if ($CurrentFEObject.Zones) {                                                   # If $CurrentFEObject.Zones has a value
                Write-Host 'Zones:   '$CurrentFEObject.Zones                                # Write message to screen
            }                                                                               # End if ($CurrentFEObject.Zones)
            else {                                                                          # Else if $CurrentFEObject.Zones is $null
                Write-Host 'Zones:    N/A'                                                  # Write message to screen
            }                                                                               # End else (if ($CurrentFEObject.Zones))
            Write-Host ''                                                                   # Write message to screen
            Write-Host 'New Front End'                                                      # Write message to screen
            Write-Host 'Name:    '$LBFEObject.Name                                          # Write message to screen
            if ($LBFEObject.PrivateIpAddress) {                                             # If $LBFEObject.PrivateIpAddress has a value
                Write-Host 'Pri IP:  '$LBFEObject.PrivateIpAddress                          # Write message to screen
            }                                                                               # End if ($LBFEObject.PrivateIpAddress)
            else {                                                                          # Else if $LBFEObject.PrivateIpAddress is $null
                Write-Host 'Pri IP:   N/A'                                                  # Write message to screen    
            }                                                                               # End else (if ($LBFEObject.PrivateIpAddress))
            Write-Host 'Pri Type:'$LBFEObject.PrivateIpAllocationMethod                     # Write message to screen
            if ($NewPublicSku) {                                                            # If $NewPublicSku has a value
                Write-Host 'Pub IP:  '$NewPublicSku.IpAddress                               # Write message to screen
            }                                                                               # End if ($NewPublicSku)
            if ($LBFEObject.Zones) {                                                        # If $LBFEObject.Zones has a value
                Write-Host 'Zones:   '$LBFEObject.Zones                                     # Write message to screen
            }                                                                               # End if ($LBFEObject.Zones)
            else {                                                                          # Else if $LBFEObject.Zones is $null
                Write-Host 'Zones:    N/A'                                                  # Write message to screen
            }                                                                               # End else (if ($LBFEObject.Zones))
            Write-Host ''                                                                   # Write message to screen
            Write-Host 'Make this change'                                                   # Write message to screen
            $OpConfirm = Read-Host '[Y] Yes [N] No'                                         # Operator confrimation to change the nat rule front end
            Clear-Host                                                                      # Clears screen
            if ($OpConfirm -eq 'y') {                                                       # If $OPConfirm equals 'y'    
                $LBNatRuleTargetPort = $LBNatRule.BackEndPort                               # Sets $LBNatRuleTargetPort
                Write-Host 'Changing the nat rule front end configuration'                  # Write message to screen
                Try {                                                                       # Try the following
                    if ($LBNatRule.EnableFloatingIP -eq $true -and `
                        $LBNatRule.EnableTCPReset -eq $true) {                              # If $LBNatRule.EnableFloatingIP equals $true and .EnableTCPReset equal $true
                        Set-AzLoadBalancerInboundNatRuleConfig `
                            -LoadBalancer $LoadBalancerObject `
                            -Name $LBNatRule.Name `
                            -FrontendIpConfigurationId $LBFEObject.ID `
                            -Protocol $LBNatRule.Protocol `
                            -FrontendPort $LBNatRule.FrontEndPort `
                            -BackendPort $LBNatRuleTargetPort `
                            -IdleTimeoutInMinutes  $LBNatRule.IdleTimeoutInMinutes `
                            -EnableFloatingIP `
                            -EnableTcpReset `
                            -ErrorAction 'Stop' | Out-Null                                  # Changes the nat rule front end config
                    }                                                                       # End if ($LBNatRule.EnableFloatingIP -eq $true -and $LBNatRule.EnableTCPReset -eq $true)
                    elseif ($LBNatRule.EnableFloatingIP -eq $false `
                        -and $LBNatRule.EnableTCPReset -eq $true) {                         # Else if $LBNatRule.EnableFloatingIP equals $false and .EnableTCPReset equal $true
                        Set-AzLoadBalancerInboundNatRuleConfig `
                            -LoadBalancer $LoadBalancerObject `
                            -Name $LBNatRule.Name `
                            -FrontendIpConfigurationId $LBFEObject.ID `
                            -Protocol $LBNatRule.Protocol `
                            -FrontendPort $LBNatRule.FrontEndPort `
                            -BackendPort $LBNatRuleTargetPort `
                            -IdleTimeoutInMinutes  $LBNatRule.IdleTimeoutInMinutes `
                            -EnableTcpReset `
                            -ErrorAction 'Stop' | Out-Null                                  # Changes the nat rule front end config
                    }                                                                       # End elseif ($LBNatRule.EnableFloatingIP -eq $false -and $LBNatRule.EnableTCPReset -eq $true)
                    elseif ($LBNatRule.EnableFloatingIP -eq $true -and `
                        $LBNatRule.EnableTCPReset -eq $false) {                             # Else if $LBNatRule.EnableFloatingIP equals $true and .EnableTCPReset equal $false
                        Set-AzLoadBalancerInboundNatRuleConfig `
                            -LoadBalancer $LoadBalancerObject `
                            -Name $LBNatRule.Name `
                            -FrontendIpConfigurationId $LBFEObject.ID `
                            -Protocol $LBNatRule.Protocol `
                            -FrontendPort $LBNatRule.FrontEndPort `
                            -BackendPort $LBNatRuleTargetPort `
                            -IdleTimeoutInMinutes  $LBNatRule.IdleTimeoutInMinutes `
                            -EnableFloatingIP `
                            -ErrorAction 'Stop' | Out-Null                                  # Changes the nat rule front end config
                    }                                                                       # End elseif ($LBNatRule.EnableFloatingIP -eq $true -and $LBNatRule.EnableTCPReset -eq $false)
                    else {                                                                  # Else if $LBNatRule.EnableFloatingIP equals $false and .EnableTCPReset equal $false
                        Set-AzLoadBalancerInboundNatRuleConfig `
                            -LoadBalancer $LoadBalancerObject `
                            -Name $LBNatRule.Name `
                            -FrontendIpConfigurationId $LBFEObject.ID `
                            -Protocol $LBNatRule.Protocol `
                            -FrontendPort $LBNatRule.FrontEndPort `
                            -BackendPort $LBNatRuleTargetPort `
                            -IdleTimeoutInMinutes  $LBNatRule.IdleTimeoutInMinutes `
                            -ErrorAction 'Stop' | Out-Null                                  # Changes the nat rule front end config
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
                Pause                                                                       # Pauses all actions for operator input
                Break SetAzureLBNatRule                                                     # Breaks :SetAzureLBNatRule
            }                                                                               # End else (if ($OpConfirm -eq 'y'))                                                    
        }                                                                                   # End :SetAzureLBNatRule while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function SetAzLBNatRuleFE