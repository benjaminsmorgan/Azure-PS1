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
    SetAzLBRuleTimeOut:         Function to change an existing load balancer rule idle time out
    GetAzLBRuleConfig:          Function to get an existing load balancer rule config
} #>
<# Variables: {      
    :SetAzureLBRuleTO           Outer loop for managing function
    :SetAzureLBRuleIdleTO       Inner loop to set the rule time out
    $CallingFunction:           Name of this function or the one that called it
    $LBRuleObject:              Load balancer rule object
    $LoadBalancerObject:        Load balancer object
    $CurrentBEName:             Current rule back end name
    $CurrentBEObject:           Current rule back end object
    $CurrentBEID:               Current rule back end object ID
    $ValidArray:                Array of valid charaters for $LBRuleIdleTO
    $LBRuleIdleTO:              Operator input for the rule new idle time out
    $LBRuleArray:               $LBRuleIdleTO converted to array
    $LBRuleIdleTOInt:           $LBRuleIdleTO converted to integer
    $OpConfirm:                 Operator confirmation to make the change
    GetAzLBRuleConfig{}         Gets $LBRuleObject, $LoadBalancerObject
} #>
<# Process Flow {
    function
        Call SetAzLBRuleTimeOut > Get $null
            Call GetAzLBRuleConfig > Get $LBRuleObject, $LoadBalancerObject
            End GetAzLBRuleConfig
                Return SetAzLBRuleTimeOut > Send $LBRuleObject, $LoadBalancerObject
        End SetAzLBRuleTimeOut
            Return function > Send $null
}#>
function SetAzLBRuleTimeOut {                                                               # Function to change an existing load balancer rule idle time out
    Begin {                                                                                 # Begin function
        if (!$CallingFunction) {                                                            # If $CallingFunction is $null
            $CallingFunction = 'SetAzLBRuleTimeOut'                                         # Creates $CallingFunction
        }                                                                                   # End if (!$CallingFunction)
        :SetAzureLBRuleTO while ($true) {                                                   # Outer loop for managing function
            $LBRuleObject, $LoadBalancerObject = GetAzLBRuleConfig ($CallingFunction)       # Calls function and assigns output to $var
            if (!$LBRuleObject) {                                                           # If $LBRuleObject is $null
                Break SetAzureLBRuleTO                                                      # Breaks :SetAzureLBRuleTO
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
            $ValidArray = '0123456789'                                                      # Creates a string of valid characters
            $ValidArray = $ValidArray.ToCharArray()                                         # Loads all valid characters into array
            :SetAzureLBRuleIdleTO while ($true) {                                           # Inner loop for setting the rule idle timeout
                Write-Host 'Enter new idle time out in minutes for this rule'               # Write message to screen
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
                        Break SetAzureLBRuleTO                                              # Breaks :SetAzureLBRuleTO
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
            Write-Host 'Changing the rule idle time out'                                    # Write message to screen
            Try {                                                                           # Try the following
                if ($LBRuleObject.EnableFloatingIP -eq $True `
                    -and $LBRuleObject.EnableTcpReset -eq $True) {                          # If $LBRuleObject.EnableFloatingIP and $LBRuleObject.EnableTcpReset equal $true
                    Set-AzLoadBalancerRuleConfig `
                        -LoadBalancer $LoadBalancerObject `
                        -Name $LBRuleObject.Name `
                        -FrontendIpConfigurationId `
                        $LBRuleObject.FrontendIpConfiguration.ID `
                        -Protocol $LBRuleObject.Protocol `
                        -FrontendPort $LBRuleObject.FrontendPort `
                        -BackendPort $LBRuleObject.BackEndPort `
                        -IdleTimeoutInMinutes  $LBRuleIdleTO `
                        -BackendAddressPoolId  $CurrentBEID `
                        -LoadDistribution $LBRuleObject.LoadDistribution `
                        -EnableTcpReset -EnableFloatingIP `
                        -ProbeID $LBRuleObject.Probe.ID -Verbose -ErrorAction `
                        'Stop' | Out-Null                                                   # Changes the rule back end config
                }                                                                           # End if ($LBRuleObject.EnableFloatingIP -eq $True -and $LBRuleObject.EnableTcpReset -eq $True)
                elseif ($LBRuleObject.EnableFloatingIP -eq $True) {                         # Else if $LBRuleObject.EnableFloatingIP equals $True
                    Set-AzLoadBalancerRuleConfig `
                        -LoadBalancer $LoadBalancerObject `
                        -Name $LBRuleObject.Name `
                        -FrontendIpConfigurationId `
                        $LBRuleObject.FrontendIpConfiguration.ID `
                        -Protocol $LBRuleObject.Protocol `
                        -FrontendPort $LBRuleObject.FrontendPort `
                        -BackendPort $LBRuleObject.BackEndPort `
                        -IdleTimeoutInMinutes  $LBRuleIdleTO `
                        -BackendAddressPoolId  $CurrentBEID `
                        -LoadDistribution $LBRuleObject.LoadDistribution `
                        -EnableFloatingIP `
                        -ProbeID $LBRuleObject.Probe.ID -Verbose -ErrorAction `
                        'Stop' | Out-Null                                                   # Changes the rule back end config
                }                                                                           # End elseif ($LBRuleObject.EnableFloatingIP -eq $True)
                elseif ($LBRuleObject.EnableTcpReset -eq $true) {                           # Else if $LBRuleObject.EnableTcpReset equals $true
                    Set-AzLoadBalancerRuleConfig `
                        -LoadBalancer $LoadBalancerObject `
                        -Name $LBRuleObject.Name `
                        -FrontendIpConfigurationId `
                        $LBRuleObject.FrontendIpConfiguration.ID `
                        -Protocol $LBRuleObject.Protocol `
                        -FrontendPort $LBRuleObject.FrontendPort `
                        -BackendPort $LBRuleObject.BackEndPort `
                        -IdleTimeoutInMinutes  $LBRuleIdleTO `
                        -BackendAddressPoolId  $CurrentBEID `
                        -LoadDistribution $LBRuleObject.LoadDistribution `
                        -EnableTcpReset `
                        -ProbeID $LBRuleObject.Probe.ID -Verbose -ErrorAction `
                        'Stop' | Out-Null                                                   # Changes the rule back end config    
                }                                                                           # End elseif ($LBRuleObject.EnableTcpReset -eq $true) 
                else {                                                                      # Else if $LBRuleObject.EnableFloatingIP and $LBRuleObject.EnableTcpReset does not equal $true
                    Set-AzLoadBalancerRuleConfig `
                        -LoadBalancer $LoadBalancerObject `
                        -Name $LBRuleObject.Name `
                        -FrontendIpConfigurationId `
                        $LBRuleObject.FrontendIpConfiguration.ID `
                        -Protocol $LBRuleObject.Protocol `
                        -FrontendPort $LBRuleObject.FrontendPort `
                        -BackendPort $LBRuleObject.BackEndPort `
                        -IdleTimeoutInMinutes  $LBRuleIdleTO `
                        -BackendAddressPoolId  $CurrentBEID `
                        -LoadDistribution $LBRuleObject.LoadDistribution `
                        -ProbeID $LBRuleObject.Probe.ID -Verbose -ErrorAction `
                        'Stop' | Out-Null                                                   # Changes the rule back end config
                }                                                                           # End Else (if ($LBBEObject.EnableFloatingIP -eq $True -and $LBBEObject.EnableTcpReset -eq $True))
                Write-Host 'Saving the load balancer configuration'                         # Write message to screen
                $LoadBalancerObject | Set-AzLoadBalancer -ErrorAction 'Stop' | Out-Null     # Saves the changes to $LoadBalancerObject
            }                                                                               # End try
            Catch {                                                                         # If try fails
                Clear-Host                                                                  # Clears screen
                Write-Host 'An error has occured'                                           # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break SetAzureLBRuleTO                                                      # Breaks :SetAzureLBRuleTO
            }                                                                               # End catch
            Clear-Host                                                                      # Clears screen
            Write-Host 'Requested changes have been made'                                   # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            Pause                                                                           # Pauses all actions for operator input
            Break SetAzureLBRuleTO                                                          # Breaks :SetAzureLBRuleTO
        }                                                                                   # End :SetAzureLBRuleTO while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function SetAzLBRuleTimeOut