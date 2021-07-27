# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Microsoft docs links
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
    SetAzLBRuleFEPort:          Function to change an existing load balancer rule front end port
    GetAzLBRuleConfig:          Function to get an existing load balancer rule config
} #>
<# Variables: {      
    :SetAzureLBRuleFEPort       Outer loop for managing function
    :NewAzureLBRuleFEPort       Inner loop to set the rule front end port
    $CallingFunction:           Name of this function or the one that called it
    $LBRuleObject:              Load balancer rule object
    $LoadBalancerObject:        Load balancer object
    $CurrentBEName:             Current rule back end name
    $CurrentBEObject:           Current rule back end object
    $CurrentBEID:               Current rule back end object ID
    $CurrentRules:              List of all rules on $LBRuleObject.FrontendIpConfiguration.ID
    $CurrentNatRules:           List of all nat rules on $LBRuleObject.FrontendIpConfiguration.ID
    $ObjectArray:               Array holding all the currently in use front end ports and protocols
    $PortandProtocol:           Current item .Protocol and .FrontEndPort 
    $ObjectInput:               $var used to load info into $ObjectArray
    $ValidArray:                Array of valid charaters for $LBRuleFrontEndPort
    $LBRuleFrontEndPort:        Operator input for the rule new front end port
    $LBRuleArray:               $LBRuleFrontEndPort converted to array
    $LBRulePortProto:           $LBRuleObject.Protocol and $LBRuleFrontEndPort
    $EFloatIP:                  Current value of $LBRuleObject.EnableFloatingIP
    $ETCPReset:                 Current value of $LBRuleObject.EnableTCPReset
    $OpConfirm:                 Operator confirmation to make the change
    GetAzLBRuleConfig{}         Gets $LBRuleObject, $LoadBalancerObject
} #>
<# Process Flow {
    function
        Call SetAzLBRuleFEPort > Get $null
            Call GetAzLBRuleConfig > Get $LBRuleObject, $LoadBalancerObject
            End GetAzLBRuleConfig
                Return SetAzLBRuleFEPort > Send $LBRuleObject, $LoadBalancerObject
        End SetAzLBRuleFEPort
            Return function > Send $null
}#>
function SetAzLBRuleFEPort {                                                                # Function to change an existing load balancer rule front end port
    Begin {                                                                                 # Begin function
        if (!$CallingFunction) {                                                            # If $CallingFunction is $null
            $CallingFunction = 'SetAzLBRuleFEPort'                                          # Creates $CallingFunction
        }                                                                                   # End if (!$CallingFunction)
        :SetAzureLBRuleFEPort while ($true) {                                               # Outer loop for managing function
            $LBRuleObject, $LoadBalancerObject = GetAzLBRuleConfig ($CallingFunction)       # Calls function and assigns output to $var
            if (!$LBRuleObject) {                                                           # If $LBRuleObject is $null
                Break SetAzureLBRuleFEPort                                                  # Breaks :SetAzureLBRuleFEPort
            }                                                                               # End if (!$LBRuleObject)
            if ($LBRuleObject.Protocol -eq 'All') {                                         # If $LBRuleObject.Protocol equals 'All'
                Write-Host 'This rule is configured with'                                   # Write message to screen
                Write-Host 'High Availability (HA) ports'                                   # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Write-Host 'Specifying a port is not an'                                    # Write message to screen
                Write-Host 'option for this rule'                                           # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break SetAzureLBRuleFEPort                                                  # Breaks :SetAzureLBRuleFEPort
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
            $CurrentRules = Get-AzLoadBalancerRuleConfig -LoadBalancer $LoadBalancerObject `
                | Where-Object {$_.FrontendIPConfiguration.ID -eq `
                $LBRuleObject.FrontendIpConfiguration.ID}                                   # Gets a list of all rules using $LBRuleObject.FrontendIpConfiguration.ID
            $CurrentNatRules = Get-AzLoadBalancerInboundNatRuleConfig -LoadBalancer `
                $LoadBalancerObject | Where-Object {$_.FrontendIPConfiguration.ID -eq `
                $LBRuleObject.FrontendIpConfiguration.ID}                                   # Gets a list of all nat rules using $LBRuleObject.FrontendIpConfiguration.ID
                [System.Collections.ArrayList]$ObjectArray = @()                            # Creates $ObjectArray
                foreach ($_ in $CurrentRules) {                                             # For each item in $CurrentRules
                    $PortandProtocol = $_.Protocol + ' ' + $_.FrontEndPort                  # $PortandProtocol is equal to current item .Protocol and .FrontEndPort                    
                    $ObjectInput = [PSCustomObject]@{                                       # Creates the item to loaded into array
                        'PortandProto'=$PortandProtocol                                     # $PortandProtocol
                    }                                                                       # End $ObjectInput = [PSCustomObject]@
                    $ObjectArray.Add($ObjectInput) | Out-Null                               # Adds $ObjectInput to $ObjectArray
                    $PortandProtocol = $null                                                # Clears $var
                }                                                                           # End foreach ($_ in $CurrentRules)
                foreach ($_ in $CurrentNatRules) {                                          # For each item in $CurrentNatRules
                    $PortandProtocol = $_.Protocol + ' ' + $_.FrontEndPort                  # $PortandProtocol is equal to current item .Protocol and .FrontEndPort                    
                    $ObjectInput = [PSCustomObject]@{                                       # Creates the item to loaded into array
                        'PortandProto'=$PortandProtocol                                     # $PortandProtocol
                    }                                                                       # End $ObjectInput = [PSCustomObject]@
                    $ObjectArray.Add($ObjectInput) | Out-Null                               # Adds $ObjectInput to $ObjectArray
                    $PortandProtocol = $null                                                # Clears $var
                }                                                                           # End foreach ($_ in $CurrentNatRules)    
            $ValidArray = '0123456789'                                                      # Creates a string of valid characters
            $ValidArray = $ValidArray.ToCharArray()                                         # Loads all valid characters into array
            :NewAzureLBRuleFEPort while ($true) {                                           # Inner loop for setting the rule front end port
                if ($ObjectArray) {                                                         # If $ObjectArray has a value
                    Write-Host 'The following front end ports are already in use'           # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    foreach ($_ in $ObjectArray) {                                          # For each item in $ObjectArray
                        Write-Host $_.PortandProto                                          # Write message to screen
                    }                                                                       # End foreach ($_ in $ObjectArray)
                    Write-Host ''                                                           # Write message to screen
                }                                                                           # End if ($ObjectArray)
                Write-Host 'Enter the rule pool front end port'                             # Write message to screen
                Write-Host ''                                                               # Writes message to screen
                $LBRuleFrontEndPort = Read-Host 'Port #'                                    # Operator input for the front end rule port 
                $LBRuleArray = $LBRuleFrontEndPort.ToCharArray()                            # Adds $LBRuleFrontEndPort to array
                $LBRulePortProto = $LBRuleObject.Protocol + ' ' + $LBRuleFrontEndPort       # $LBRulePortProto is equal to $LBRuleObject.Protocol and $LBRuleFrontEndPort
                Clear-Host                                                                  # Clears screen
                :CheckInput foreach ($_ in $LBRuleArray) {                                  # For each item in $LBRuleArray
                    if ($_ -notin $ValidArray) {                                            # If current item is not in $ValidArray
                        Write-Host 'That was not a valid input'                             # Write message to screen
                        Write-Host ''                                                       # Write message to screen
                        $LBRuleFrontEndPort = $null                                         # Clears $LBRuleFrontEndPort
                        Break CheckInput                                                    # Breaks :CheckInput
                    }                                                                       # End if ($_ -notin $ValidArray)
                }                                                                           # End foreach ($_ in $LBRuleArray)
                $LBRuleArray = $null                                                        # Clears $LBRuleArray
                if ($LBRulePortProto -in $ObjectArray.PortandProto) {                       # If $LBRulePortProto is in $ObjectArray.PortandProto
                    Write-Host 'Port:'$LBRulePortProto' is already in use'                  # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    Write-Host 'Please select another port'                                 # Write message to screen
                    Write-Host 'or move this rule to a different'                           # Write message to screen
                    Write-Host 'front end configuration'                                    # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    $LBRuleFrontEndPort = $null                                             # Clears $LBRuleFrontEndPort
                }                                                                           # End if ($LBRulePortProto -in $ObjectArray.PortandProto)
                if ($LBRuleFrontEndPort) {                                                  # If $LBRuleFrontEndPort has a value
                    Write-Host 'Use:'$LBRulePortProto' as the front end pool rule port'     # Write message to screen
                    Write-Host ''                                                           # Writes message to screen
                    $OpConfirm = Read-Host '[Y] Yes [N] No [E] Exit'                        # Operator confirmation of the front end rule port
                    Clear-Host                                                              # Clears screen
                    if ($OpConfirm -eq 'e') {                                               # If $OpConfirm equals 'e'
                        Break SetAzureLBRuleFEPort                                          # Breaks :SetAzureLBRuleFEPort
                    }                                                                       # End if ($OpConfirm -eq 'e')
                    if ($OpConfirm -eq 'y') {                                               # If $OpConfirm equals 'y'
                        Break NewAzureLBRuleFEPort                                          # Breaks :NewAzureLBRuleFEPort        
                    }                                                                       # End if ($OpConfirm -eq 'y')
                }                                                                           # End if ($LBRuleFrontEndPort)
                else {                                                                      # Else if $LBRuleFrontEndPort is $null
                    Pause                                                                   # Pauses all actions for operator input
                    Clear-Host                                                              # Clears screen
                }                                                                           # End else (if ($LBRuleFrontEndPort))
            }                                                                               # End :NewAzureLBRuleFEPort while ($true)
            Write-Host 'Changing the rule front end port'                                   # Write message to screen
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
                    $LBRuleObject.Protocol -FrontendPort $LBRuleFrontEndPort `
                    -BackendPort $LBRuleObject.BackEndPort -IdleTimeoutInMinutes  `
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
                Break SetAzureLBRuleFEPort                                                  # Breaks :SetAzureLBRuleFEPort
            }                                                                               # End catch
            Clear-Host                                                                      # Clears screen
            Write-Host 'Requested changes have been made'                                   # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            Pause                                                                           # Pauses all actions for operator input
            Break SetAzureLBRuleFEPort                                                      # Breaks :SetAzureLBRuleFEPort
        }                                                                                   # End :SetAzureLBRuleFEPort while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function SetAzLBRuleFEPort