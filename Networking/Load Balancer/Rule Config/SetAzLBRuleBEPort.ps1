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
    SetAzLBRuleBEPort:          Function to change an existing load balancer rule back end port
    GetAzLBRuleConfig:          Function to get an existing load balancer rule config
} #>
<# Variables: {      
    :SetAzureLBRuleBEPort       Outer loop for managing function
    :NewAzureLBRuleBEPort       Inner loop to set the rule back end port
    $CallingFunction:           Name of this function or the one that called it
    $LBRuleObject:              Load balancer rule object
    $LoadBalancerObject:        Load balancer object
    $CurrentBEName:             Current rule back end name
    $CurrentBEObject:           Current rule back end object
    $CurrentBEID:               Current rule back end object ID
    $ValidArray:                Array of valid charaters for $LBRuleBackEndPort
    $LBRuleBackEndPort:         Operator input for the rule new back end port
    $LBRuleArray:               $LBRuleBackEndPort converted to array
    $EFloatIP:                  Current value of $LBRuleObject.EnableFloatingIP
    $ETCPReset:                 Current value of $LBRuleObject.EnableTCPReset
    $OpConfirm:                 Operator confirmation to make the change
    GetAzLBRuleConfig{}         Gets $LBRuleObject, $LoadBalancerObject
} #>
<# Process Flow {
    function
        Call SetAzLBRuleBEPort > Get $null
            Call GetAzLBRuleConfig > Get $LBRuleObject, $LoadBalancerObject
            End GetAzLBRuleConfig
                Return SetAzLBRuleBEPort > Send $LBRuleObject, $LoadBalancerObject
        End SetAzLBRuleBEPort
            Return function > Send $null
}#>
function SetAzLBRuleBEPort {                                                                # Function to change an existing load balancer rule back end port
    Begin {                                                                                 # Begin function
        if (!$CallingFunction) {                                                            # If $CallingFunction is $null
            $CallingFunction = 'SetAzLBRuleBEPort'                                          # Creates $CallingFunction
        }                                                                                   # End if (!$CallingFunction)
        :SetAzureLBRuleBEPort while ($true) {                                               # Outer loop for managing function
            $LBRuleObject, $LoadBalancerObject = GetAzLBRuleConfig ($CallingFunction)       # Calls function and assigns output to $var
            if (!$LBRuleObject) {                                                           # If $LBRuleObject is $null
                Break SetAzureLBRuleBEPort                                                  # Breaks :SetAzureLBRuleBEPort
            }                                                                               # End if (!$LBRuleObject)
            if ($LBRuleObject.Protocol -eq 'All') {                                         # If $LBRuleObject.Protocol equals 'All'
                Write-Host 'This rule is configured with'                                   # Write message to screen
                Write-Host 'High Availability (HA) ports'                                   # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Write-Host 'Specifying a port is not an'                                    # Write message to screen
                Write-Host 'option for this rule'                                           # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break SetAzureLBRuleBEPort                                                  # Breaks :SetAzureLBRuleBEPort
            }                                                                               # End if ($LBRuleObject.Protocol -eq 'All')
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
            :NewAzureLBRuleBEPort while ($true) {                                           # Inner loop for setting the rule back end port
                Write-Host 'Enter the rule pool back end port'                              # Write message to screen
                Write-Host ''                                                               # Writes message to screen
                $LBRuleBackEndPort = Read-Host 'Port #'                                     # Operator input for the back end rule port 
                $LBRuleArray = $LBRuleBackEndPort.ToCharArray()                             # Adds $LBRuleBackEndPort to array
                Clear-Host                                                                  # Clears screen
                foreach ($_ in $LBRuleArray) {                                              # For each item in $LBRuleArray
                    if ($_ -notin $ValidArray) {                                            # If current item is not in $ValidArray
                        $LBRuleBackEndPort = $null                                          # Clears $LBRuleBackEndPort
                    }                                                                       # End if ($_ -notin $ValidArray)
                }                                                                           # End foreach ($_ in $LBRuleArray)
                $LBRuleArray = $null                                                        # Clears $LBRuleArray
                if ($LBRuleBackEndPort) {                                                   # If $LBRuleBackEndPort has a value
                    Write-Host 'Use:'$LBRuleBackEndPort' as the back end pool rule port'    # Write message to screen
                    Write-Host ''                                                           # Writes message to screen
                    $OpConfirm = Read-Host '[Y] Yes [N] No [E] Exit'                        # Operator confirmation of the back end rule port
                    Clear-Host                                                              # Clears screen
                    if ($OpConfirm -eq 'e') {                                               # If $OpConfirm equals 'e'
                        Break SetAzureLBRuleBEPort                                          # Breaks :SetAzureLBRuleBEPort
                    }                                                                       # End if ($OpConfirm -eq 'e')
                    if ($OpConfirm -eq 'y') {                                               # If $OpConfirm equals 'y'
                        Break NewAzureLBRuleBEPort                                          # Breaks :NewAzureLBRuleBEPort        
                    }                                                                       # End if ($OpConfirm -eq 'y')
                }                                                                           # End if ($LBRuleBackEndPort)
                else {                                                                      # Else if $LBRuleBackEndPort is $null
                    Write-Host 'That was not a valid input'                                 # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Clear-Host                                                              # Clears screen
                }                                                                           # End else (if ($LBRuleBackEndPort))
            }                                                                               # End :NewAzureLBRuleBEPort while ($true)
            Write-Host 'Changing the rule back end port'                                    # Write message to screen
            Try {                                                                           # Try the following
                if ($LBRuleObject.EnableFloatingIP -eq $True) {                             # If $LBRuleObject.EnableFloatingIP equals $True                          
                    $EFloatIP = $true                                                       # Sets $EFloatIP
                }                                                                           # End if ($LBRuleObject.EnableFloatingIP -eq $True)
                else {                                                                      # Else if $LBRuleObject.EnableFloatingIP does not equal $True 
                    $EFloatIP = $false                                                      # Sets $EFloatIP
                }                                                                           # End else (if ($LBRuleObject.EnableFloatingIP -eq $True))
                if ($LBRuleObject.EnableTcpReset -eq $true) {                               # If $LBRuleObject.EnableTcpReset equals $true                               
                    $ETCPReset = $true                                                      # Sets $ETCPReset
                }                                                                           # End if ($LBRuleObject.EnableTcpReset -eq $true)
                else {                                                                      # Else if $LBRuleObject.EnableTcpReset does not equal $true
                    $ETCPReset = $false                                                     # Sets $ETCPReset
                }                                                                           # End Else (if ($LBRuleObject.EnableTcpReset -eq $true))
                Set-AzLoadBalancerRuleConfig -LoadBalancer $LoadBalancerObject -Name `
                    $LBRuleObject.Name -FrontendIpConfigurationId `
                    $LBRuleObject.FrontendIpConfiguration.ID -Protocol `
                    $LBRuleObject.Protocol -FrontendPort $LBRuleObject.FrontendPort `
                    -BackendPort  $LBRuleBackEndPort -IdleTimeoutInMinutes  `
                    $LBRuleObject.IdleTimeoutInMinutes -BackendAddressPoolId $CurrentBEID `
                    -LoadDistribution $LBRuleObject.LoadDistribution `
                    -EnableTcpReset:$ETCPReset -EnableFloatingIP:$EFloatIP -ProbeID `
                    $LBRuleObject.Probe.ID -ErrorAction 'Stop' | Out-Null                   # Changes the rule back end config
                Write-Host 'Saving the load balancer configuration'                         # Write message to screen
                $LoadBalancerObject | Set-AzLoadBalancer -ErrorAction 'Stop' | Out-Null     # Saves the changes to $LoadBalancerObject
            }                                                                               # End try
            Catch {                                                                         # If try fails
                Clear-Host                                                                  # Clears screen
                Write-Host 'An error has occured'                                           # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break SetAzureLBRuleBEPort                                                  # Breaks :SetAzureLBRuleBEPort
            }                                                                               # End catch
            Clear-Host                                                                      # Clears screen
            Write-Host 'Requested changes have been made'                                   # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            Pause                                                                           # Pauses all actions for operator input
            Break SetAzureLBRuleBEPort                                                      # Breaks :SetAzureLBRuleBEPort
        }                                                                                   # End :SetAzureLBRuleBEPort while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function SetAzLBRuleBEPort