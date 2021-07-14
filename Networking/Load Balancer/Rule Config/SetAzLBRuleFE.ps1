# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Mircosoft docs links
    Get-AzLoadBalancerFrontendIpConfig:         https://docs.microsoft.com/en-us/powershell/module/az.network/get-azloadbalancerfrontendipconfig?view=azps-6.0.0
    Get-AzPublicIpAddress:                      https://docs.microsoft.com/en-us/powershell/module/az.network/get-azpublicipaddress?view=azps-5.5.0    
    Get-AzLoadBalancerBackendAddressPool:       https://docs.microsoft.com/en-us/powershell/module/az.network/get-azloadbalancerbackendaddresspool?view=azps-6.1.0
    Set-AzLoadBalancerRuleConfig:               https://docs.microsoft.com/en-us/powershell/module/az.network/set-azloadbalancerruleconfig?view=azps-6.1.0
    Set-AzLoadBalancer:                         https://docs.microsoft.com/en-us/powershell/module/az.network/set-azloadbalancer?view=azps-6.1.0
    Get-AzLoadBalancer:                         https://docs.microsoft.com/en-us/powershell/module/az.network/get-azloadbalancer?view=azps-5.5.0 
    Get-AzLoadBalancerRuleConfig:               https://docs.microsoft.com/en-us/powershell/module/az.network/get-azloadbalancerruleconfig?view=azps-6.1.0
} #>
<# Required Functions Links: {
    GetAzLBRuleConfig:          https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/Load%20Balancer/Rule%20Config/GetAzLBRuleConfig.ps1
    GetAzLBRuleFE:              https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/Load%20Balancer/Rule%20Config/GetAzLBRuleFE.ps1
} #>
<# Functions Description: {
    SetAzLBRuleFE:              Function to change an existing load balancer rule front end config
    GetAzLBRuleConfig:          Function to get an existing load balancer rule config
    GetAzLBRuleFE:              Function to get a load balancer front end config for load balancer rule
} #>
<# Variables: {      
    :SetAzureLBRuleFE           Outer loop for managing function
    $CallingFunction:           Name of this function or the one that called it
    $LBRuleObject:              Load balancer rule object
    $LoadBalancerObject:        Load balancer object
    $LBFEObject:                Load balancer front end object
    $CurrentPublicSku:          Public IP sku on $LBRuleObject
    $NewPublicSku:              Public IP sku on $LBFEObject
    $CurrentFEName:             Name of the front end on $LBRuleObject
    $CurrentFEObject:           Front end object on $LBRuleObject
    $OpConfirm:                 Operator confirmation to make the change
    $LBBackEndName:             Load balancer rule back end name
    $LBBackEndObject:           Load balancer rule back end object
    $EFloatIP:                  Current value of $LBRuleObject.EnableFloatingIP
    $ETCPReset:                 Current value of $LBRuleObject.EnableTCPReset
    GetAzLBRuleConfig{}         Gets $LBRuleObject, $LoadBalancerObject
    GetAzLBRuleFE{}             Gets $LBFEObject
} #>
<# Process Flow {
    function
        Call SetAzLBRuleFE > Get $null
            Call GetAzLBRuleConfig > Get $LBRuleObject, $LoadBalancerObject
            End GetAzLBRuleConfig
                Return SetAzLBRuleFE > Send $LBRuleObject, $LoadBalancerObject
            Call GetAzLBRuleFE > Get $LBFEObject
            End GetAzLBRuleFE
                Return SetAzLBRuleFE > Send $LBFEObject
        End SetAzLBRuleFE
            Return function > Send $null
}#>
function SetAzLBRuleFE {                                                                    # Function to change an existing load balancer rule front end config
    Begin {                                                                                 # Begin function
        if (!$CallingFunction) {                                                            # If $CallingFunction is $null
            $CallingFunction = 'SetAzLBRuleFE'                                              # Creates $CallingFunction
        }                                                                                   # End if (!$CallingFunction)
        :SetAzureLBRuleFE while ($true) {                                                   # Outer loop for managing function
            $LBRuleObject, $LoadBalancerObject = GetAzLBRuleConfig ($CallingFunction)       # Calls function and assigns output to $var
            if (!$LBRuleObject) {                                                           # If $LBRuleObject is $null
                Break SetAzureLBRuleFE                                                      # Breaks :SetAzureLBRuleFE
            }                                                                               # End if (!$LBRuleObject)
            $LBFEObject = GetAzLBRuleFE ($CallingFunction, $LoadBalancerObject)             # Calls function and assigns output to $var
            if (!$LBFEObject) {                                                             # If $LBFEObject is $null
                Break SetAzureLBRuleFE                                                      # Breaks :SetAzureLBRuleFE
            }                                                                               # End if (!$LBFEObject)
            $CurrentFEName = $LBRuleObject.FrontendIPConfiguration.ID                       # Isolates the front end ID
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
            $OpConfirm = Read-Host '[Y] Yes [N] No'                                         # Operator confrimation to change the rule front end
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
                        $LBFEObject.ID -Protocol $LBRuleObject.Protocol -FrontendPort `
                        $LBRuleObject.FrontendPort -BackendPort $LBRuleObject.BackEndPort `
                        -IdleTimeoutInMinutes $LBRuleObject.IdleTimeoutInMinutes `
                        -BackendAddressPoolId  $LBBackEndObject.ID -LoadDistribution `
                        $LBRuleObject.LoadDistribution -EnableTcpReset:$ETCPReset `
                        -EnableFloatingIP:$EFloatIP -ProbeID $LBRuleObject.Probe.ID `
                        -ErrorAction 'Stop' | Out-Null                                      # Changes the rule front end config
                    Write-Host 'Saving the load balancer configuration'                     # Write message to screen
                    $LoadBalancerObject | Set-AzLoadBalancer -ErrorAction 'Stop' | Out-Null # Saves the changes to $LoadBalancerObject
                }                                                                           # End try
                Catch {                                                                     # If try fails
                    Clear-Host                                                              # Clears screen
                    Write-Host 'An error has occured'                                       # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Break SetAzureLBRuleFE                                                  # Breaks :SetAzureLBRuleFE
                }                                                                           # End catch
                Clear-Host                                                                  # Clears screen
                Write-Host 'Requested changes have been made'                               # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break SetAzureLBRuleFE                                                      # Breaks :SetAzureLBRuleFE
            }                                                                               # End if ($OpConfirm -eq 'y')
            else  {                                                                         # All other inputs for $OpConfirm
                Break SetAzureLBRuleFE                                                      # Breaks :SetAzureLBRuleFE
            }                                                                               # End else (if ($OpConfirm -eq 'y'))
        }                                                                                   # End :SetAzureLBRuleFE while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function SetAzLBRuleFE