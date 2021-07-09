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
    SetAzLBRuleProtocol:        Function to change an existing load balancer rule protocol
    GetAzLBRuleConfig:          Function to get an existing load balancer rule config
} #>
<# Variables: {      
    :SetAzureLBRuleProtocol     Outer loop for managing function
    :NewAzureLBRuleProtocol     Inner loop to set the rule protocol
    :NewAzureLBRuleFEPort       Inner loop to set the rule front end port
    :NewAzureLBRuleBEPort       Inner loop to set the rule back end port
    $CallingFunction:           Name of this function or the one that called it
    $LBRuleObject:              Load balancer rule object
    $LoadBalancerObject:        Load balancer object
    $CurrentBEName:             Current rule back end name
    $CurrentBEObject:           Current rule back end object
    $CurrentBEID:               Current rule back end object ID
    $HAAvail:                   Flag is $LoadBalancerObject is a standard internal load balancer
    $OpSelect:                  Operator selection for the rule protocol
    $LBRuleProtocol:            Rule new protocol
    $ValidArray:                Array of valid characters for $LBRuleFrontEndPort and $LBRuleBackEndPort
    $LBRuleFrontEndPort:        Operator input for the front end port
    $LBRuleArray:               $LBRuleFrontEndPort and $LBRuleBackEndPort converted to array
    $OpConfirm:                 Operator confirmation of values
    $LBRuleBackEndPort:         Operator input for the back end port
    GetAzLBRuleConfig{}         Gets $LBRuleObject, $LoadBalancerObject
} #>
<# Process Flow {
    function
        Call SetAzLBRuleProtocol > Get $null
            Call GetAzLBRuleConfig > Get $LBRuleObject, $LoadBalancerObject
            End GetAzLBRuleConfig
                Return SetAzLBRuleProtocol > Send $LBRuleObject, $LoadBalancerObject
        End SetAzLBRuleProtocol
            Return function > Send $null
}#>
function SetAzLBRuleProtocol {                                                              # Function to change an existing load balancer rule protocol
    Begin {                                                                                 # Begin function
        if (!$CallingFunction) {                                                            # If $CallingFunction is $null
            $CallingFunction = 'SetAzLBRuleProtocol'                                        # Creates $CallingFunction
        }                                                                                   # End if (!$CallingFunction)
        :SetAzureLBRuleProtocol while ($true) {                                             # Outer loop for managing function
            $LBRuleObject, $LoadBalancerObject = GetAzLBRuleConfig ($CallingFunction)       # Calls function and assigns output to $var
            if (!$LBRuleObject) {                                                           # If $LBRuleObject is $null
                Break SetAzureLBRuleProtocol                                                # Breaks :SetAzureLBRuleProtocol
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
            :NewAzureLBRuleProtocol while ($true) {                                         # Inner loop for setting the rule load disto
                Write-Host 'Rule Name:    '$LBRuleObject.name                               # Write message to screen
                Write-Host 'Load Balancer:'$LoadBalancerObject.name                         # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Write-Host 'Rule Protocol Options'                                          # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Write-Host '[0] Exit'                                                       # Write message to screen
                Write-Host '[1] TCP'                                                        # Write message to screen
                Write-Host '[2] UDP'                                                        # Write message to screen
                if ($LoadBalancerObject.Sku.Name -eq 'Standard' -and `
                    !$LoadBalancerObject.FrontendIpConfigurations.PublicIPAddress.ID) {     # If $LoadBalancerObject.Sku.Name equals 'Standard' and $LoadBalancerObject.FrontendIpConfigurations.PublicIPAddress.ID is $null
                    Write-Host '[3] HA (Both)'                                              # Write message to screen
                    $HAAvail = 'Y'                                                          # Sets $HAAvail flag as 'Y'
                }                                                                           # End if ($LoadBalancerObject.Sku.Name -eq 'Standard' -and !$LoadBalancerObject.FrontendIpConfigurations.PublicIPAddress.ID)
                Write-Host ''                                                               # Write message to screen
                $OpSelect = Read-Host 'Option [#]'                                          # Operator input to select load disto
                Clear-Host                                                                  # Clears screen
                if ($OpSelect -eq '0') {                                                    # If $OpSelect equals '0'
                    Break SetAzureLBRuleProtocol                                            # Breaks SetAzureLBRuleProtocol
                }                                                                           # End if ($OpSelect -eq '0')
                elseif ($OpSelect -eq '1') {                                                # Else if $OpSelect equals '1'
                    $LBRuleProtocol = 'TCP'                                                 # Sets $LBRuleProtocol
                    Break NewAzureLBRuleProtocol                                            # Breaks :NewAzureLBRuleProtocol
                }                                                                           # End elseif ($OpSelect -eq '1')
                elseif ($OpSelect -eq '2') {                                                # Else if $OpSelect equals '2'
                    $LBRuleProtocol = 'UDP'                                                 # Sets $LBRuleProtocol
                    Break NewAzureLBRuleProtocol                                            # Breaks :NewAzureLBRuleProtocol
                }                                                                           # End elseif ($OpSelect -eq '2')
                elseif ($OpSelect -eq '3' -and $HAAvail -eq 'y') {                          # Else if $OpSelect equals '3' -and $HAAvail equals 'y'
                    $LBRuleProtocol = 'All'                                                 # Sets $LBRuleProtocol
                    Break NewAzureLBRuleProtocol                                            # Breaks :NewAzureLBRuleProtocol
                }                                                                           # End elseif ($OpSelect -eq '3')
                else {                                                                      # All other inputs for $OpSelect
                    Write-Host 'That was not a valid input'                                 # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Clear-Host                                                              # Clears screen
                }                                                                           # End else (if ($OpSelect -eq '0'))
            }                                                                               # End :NewAzureLBRuleProtocol while ($true)
            if ($LBRuleProtocol -eq 'TCP' -or $LBRuleProtocol -eq 'UDP') {                  # If $LBRuleProtocol equals 'TCP' or 'UDP'
                $ValidArray = '0123456789'                                                  # Creates a string of valid characters
                $ValidArray = $ValidArray.ToCharArray()                                     # Loads all valid characters into array
                :NewAzureLBRuleFEPort while ($true) {                                       # Inner loop for setting the rule front end port
                    Write-Host 'Enter the rule pool front end port'                         # Write message to screen
                    Write-Host ''                                                           # Writes message to screen
                    $LBRuleFrontEndPort = Read-Host 'Port #'                                # Operator input for the front end rule port 
                    $LBRuleArray = $LBRuleFrontEndPort.ToCharArray()                        # Adds $LBRuleFrontEndPort to array
                    Clear-Host                                                              # Clears screen
                    foreach ($_ in $LBRuleArray) {                                          # For each item in $LBRuleArray
                        if ($_ -notin $ValidArray) {                                        # If current item is not in $ValidArray
                            $LBRuleFrontEndPort = $null                                     # Clears $LBRuleFrontEndPort
                        }                                                                   # End if ($_ -notin $ValidArray)
                    }                                                                       # End foreach ($_ in $LBRuleArray)
                    $LBRuleArray = $null                                                    # Clears $LBRuleArray
                    if ($LBRuleFrontEndPort) {                                              # If $LBRuleFrontEndPort has a value
                        Write-Host 'Use:'$LBRuleFrontEndPort' as the front end rule port'   # Write message to screen
                        Write-Host ''                                                       # Writes message to screen
                        $OpConfirm = Read-Host '[Y] Yes [N] No [E] Exit'                    # Operator confirmation of the front end rule port
                        Clear-Host                                                          # Clears screen
                        if ($OpConfirm -eq 'e') {                                           # If $OpConfirm equals 'e'
                            Break SetAzureLBRuleProtocol                                    # Breaks :SetAzureLBRuleProtocol
                        }                                                                   # End if ($OpConfirm -eq 'e')
                        if ($OpConfirm -eq 'y') {                                           # If $OpConfirm equals 'y'
                            Break NewAzureLBRuleFEPort                                      # Breaks :NewAzureLBRuleFEPort        
                        }                                                                   # End if ($OpConfirm -eq 'y')
                    }                                                                       # End if ($LBRuleFrontEndPort)
                    else {                                                                  # Else if $LBRuleFrontEndPort is $null
                        Write-Host 'That was not a valid input'                             # Write message to screen
                        Write-Host ''                                                       # Write message to screen
                        Pause                                                               # Pauses all actions for operator input
                        Clear-Host                                                          # Clears screen
                    }                                                                       # End else (if ($LBRuleFrontEndPort))
                }                                                                           # End :NewAzureLBRuleFEPort while ($true)
                :NewAzureLBRuleBEPort while ($true) {                                       # Inner loop for setting the rule back end port
                    Write-Host 'Enter the rule pool back end port'                          # Write message to screen
                    Write-Host ''                                                           # Writes message to screen
                    $LBRuleBackEndPort = Read-Host 'Port #'                                 # Operator input for the back end rule port 
                    $LBRuleArray = $LBRuleBackEndPort.ToCharArray()                         # Adds $LBRuleBackEndPort to array
                    Clear-Host                                                              # Clears screen
                    foreach ($_ in $LBRuleArray) {                                          # For each item in $LBRuleArray
                        if ($_ -notin $ValidArray) {                                        # If current item is not in $ValidArray
                            $LBRuleBackEndPort = $null                                      # Clears $LBRuleBackEndPort
                        }                                                                   # End if ($_ -notin $ValidArray)
                    }                                                                       # End foreach ($_ in $LBRuleArray)
                    $LBRuleArray = $null                                                    # Clears $LBRuleArray
                    if ($LBRuleBackEndPort) {                                               # If $LBRuleBackEndPort has a value
                        Write-Host 'Use:'$LBRuleBackEndPort' as the back end rule port'     # Write message to screen
                        Write-Host ''                                                       # Writes message to screen
                        $OpConfirm = Read-Host '[Y] Yes [N] No [E] Exit'                    # Operator confirmation of the back end rule port
                        Clear-Host                                                          # Clears screen
                        if ($OpConfirm -eq 'e') {                                           # If $OpConfirm equals 'e'
                            Break SetAzureLBRuleProtocol                                    # Breaks :SetAzureLBRuleProtocol
                        }                                                                   # End if ($OpConfirm -eq 'e')
                        if ($OpConfirm -eq 'y') {                                           # If $OpConfirm equals 'y'
                            Break NewAzureLBRuleBEPort                                      # Breaks :NewAzureLBRuleBEPort        
                        }                                                                   # End if ($OpConfirm -eq 'y')
                    }                                                                       # End if ($LBRuleBackEndPort)
                    else {                                                                  # Else if $LBRuleBackEndPort is $null
                        Write-Host 'That was not a valid input'                             # Write message to screen
                        Write-Host ''                                                       # Write message to screen
                        Pause                                                               # Pauses all actions for operator input
                        Clear-Host                                                          # Clears screen
                    }                                                                       # End else (if ($LBRuleBackEndPort))
                }                                                                           # End :NewAzureLBRuleBEPort while ($true)
            }                                                                               # End if ($LBRuleProtocol -eq 'TCP' -or $LBRuleProtocol -eq 'UDP')
            else {                                                                          # Else if $LBRuleProtocol does not equal 'TCP' or 'UDP'
                $LBRuleFrontEndPort = '0'                                                   # Sets $LBRuleFrontEndPort
                $LBRuleBackEndPort = '0'                                                    # Sets $LBRuleBackEndPort
            }                                                                               # End else (if ($LBRuleProtocol -eq 'TCP' -or $LBRuleProtocol -eq 'UDP'))
            Write-Host 'Changing the rule protocol'                                         # Write message to screen
            Try {                                                                           # Try the following
                if ($LBRuleObject.EnableFloatingIP -eq $True `
                    -and $LBRuleObject.EnableTcpReset -eq $True) {                          # If $LBRuleObject.EnableFloatingIP and $LBRuleObject.EnableTcpReset equal $true
                    Set-AzLoadBalancerRuleConfig `
                        -LoadBalancer $LoadBalancerObject `
                        -Name $LBRuleObject.Name `
                        -FrontendIpConfigurationId `
                        $LBRuleObject.FrontendIpConfiguration.ID `
                        -Protocol $LBRuleProtocol `
                        -FrontendPort $LBRuleFrontEndPort `
                        -BackendPort $LBRuleBackEndPort `
                        -IdleTimeoutInMinutes  $LBRuleObject.IdleTimeoutInMinutes `
                        -BackendAddressPoolId  $CurrentBEID `
                        -LoadDistribution $LBRuleObject.LoadDistribution `
                        -EnableTcpReset -EnableFloatingIP `
                        -ProbeID $LBRuleObject.Probe.ID -Verbose -ErrorAction `
                        'Stop' | Out-Null                                                   # Changes the rule protocol
                }                                                                           # End if ($LBRuleObject.EnableFloatingIP -eq $True -and $LBRuleObject.EnableTcpReset -eq $True)
                elseif ($LBRuleObject.EnableFloatingIP -eq $True) {                         # Else if $LBRuleObject.EnableFloatingIP equals $True
                    Set-AzLoadBalancerRuleConfig `
                        -LoadBalancer $LoadBalancerObject `
                        -Name $LBRuleObject.Name `
                        -FrontendIpConfigurationId `
                        $LBRuleObject.FrontendIpConfiguration.ID `
                        -Protocol $LBRuleProtocol `
                        -FrontendPort $LBRuleFrontEndPort `
                        -BackendPort $LBRuleBackEndPort `
                        -IdleTimeoutInMinutes  $LBRuleObject.IdleTimeoutInMinutes `
                        -BackendAddressPoolId  $CurrentBEID `
                        -LoadDistribution $LBRuleObject.LoadDistribution `
                        -EnableFloatingIP `
                        -ProbeID $LBRuleObject.Probe.ID -Verbose -ErrorAction `
                        'Stop' | Out-Null                                                   # Changes the rule protocol
                }                                                                           # End elseif ($LBRuleObject.EnableFloatingIP -eq $True)
                elseif ($LBRuleObject.EnableTcpReset -eq $true) {                           # Else if $LBRuleObject.EnableTcpReset equals $true
                    Set-AzLoadBalancerRuleConfig `
                        -LoadBalancer $LoadBalancerObject `
                        -Name $LBRuleObject.Name `
                        -FrontendIpConfigurationId `
                        $LBRuleObject.FrontendIpConfiguration.ID `
                        -Protocol $LBRuleProtocol `
                        -FrontendPort $LBRuleFrontEndPort `
                        -BackendPort $LBRuleBackEndPort `
                        -IdleTimeoutInMinutes  $LBRuleObject.IdleTimeoutInMinutes `
                        -BackendAddressPoolId  $CurrentBEID `
                        -LoadDistribution $LBRuleObject.LoadDistribution `
                        -EnableTcpReset `
                        -ProbeID $LBRuleObject.Probe.ID -Verbose -ErrorAction `
                        'Stop' | Out-Null                                                   # Changes the rule protocol    
                }                                                                           # End elseif ($LBRuleObject.EnableTcpReset -eq $true) 
                else {                                                                      # Else if $LBRuleObject.EnableFloatingIP and $LBRuleObject.EnableTcpReset does not equal $true
                    Set-AzLoadBalancerRuleConfig `
                        -LoadBalancer $LoadBalancerObject `
                        -Name $LBRuleObject.Name `
                        -FrontendIpConfigurationId `
                        $LBRuleObject.FrontendIpConfiguration.ID `
                        -Protocol $LBRuleProtocol `
                        -FrontendPort $LBRuleFrontEndPort `
                        -BackendPort $LBRuleBackEndPort `
                        -IdleTimeoutInMinutes  $LBRuleObject.IdleTimeoutInMinutes `
                        -BackendAddressPoolId  $CurrentBEID `
                        -LoadDistribution $LBRuleObject.LoadDistribution `
                        -ProbeID $LBRuleObject.Probe.ID -Verbose -ErrorAction `
                        'Stop' | Out-Null                                                   # Changes the rule protocol
                }                                                                           # End Else (if ($LBBEObject.EnableFloatingIP -eq $True -and $LBBEObject.EnableTcpReset -eq $True))
                Write-Host 'Saving the load balancer configuration'                         # Write message to screen
                $LoadBalancerObject | Set-AzLoadBalancer -ErrorAction 'Stop' | Out-Null     # Saves the changes to $LoadBalancerObject
            }                                                                               # End try
            Catch {                                                                         # If try fails
                Clear-Host                                                                  # Clears screen
                Write-Host 'An error has occured'                                           # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break SetAzureLBRuleProtocol                                                  # Breaks :SetAzureLBRuleProtocol
            }                                                                               # End catch
            Clear-Host                                                                      # Clears screen
            Write-Host 'Requested changes have been made'                                   # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            Pause                                                                           # Pauses all actions for operator input
            Break SetAzureLBRuleProtocol                                                      # Breaks :SetAzureLBRuleProtocol
        }                                                                                   # End :SetAzureLBRuleProtocol while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function SetAzLBRuleProtocol