# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Microsoft docs links
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
    SetAzLBNatRuleProtocol:     Function to change an existing load balancer nat rule protocol
    GetAzLBNatRuleConfig:       Function for getting load balancer nat rule
} #>
<# Variables: {      
    :SetAzureLBNatRule          Outer loop for managing function
    :NewAzureLBRuleProtocol     Inner loop for setting the nat rule protocol
    :NewAzureLBNatRulePort      Inner loop for setting the nat rule source port
    $CallingFunction:           Name of this function or the one that called it
    $LBNatRule:                 Nat rule object
    $LoadBalancerObject:        Load balancer object
    $ValidArray:                Array of valid characters for the port
    $CurrentRules:              List of all rules on $LBNatRule.FrontendIpConfiguration.ID
    $CurrentNatRules:           List of all nat rules on $LBNatRule.FrontendIpConfiguration.ID
    $ObjectArray:               Array holding all the currently in use front end ports and protocols
    $PortandProtocol:           Current item .Protocol and .FrontEndPort 
    $ObjectInput:               $var used to load info into $ObjectArray
    $OpSelect:                  Operator selection of TCP or UDP
    $LBRuleProtocol:            New nat rule protocol
    $LBNatRulePort:             Operator input for the new nat rule source port
    $LBRuleArray:               $LBNatRulePort converted to array
    $LBNatRulePortProto:        $LBRuleProtocol and $LBNatRulePort
    $OpConfirm:                 Operator confirmation to change the source port
    $EFloatIP:                  Current value of $LBNatRule.EnableFloatingIP
    $ETCPReset:                 Current value of $LBNatRule.EnableTCPReset
    GetAzLBNatRuleConfig{}      Gets $LBNatRule, $LoadBalancerObject
} #>
<# Process Flow {
    function
        Call SetAzLBNatRuleProtocol > Get $null
            Call GetAzLBNatRuleConfig > Get $LBNatRule, $LoadBalancerObject
            End GetAzLBNatRuleConfig
                Return SetAzLBNatRuleProtocol > Send $LBNatRule, $LoadBalancerObject
        End SetAzLBNatRuleProtocol
            Return function > Send $null
}#>
function SetAzLBNatRuleProtocol {                                                           # Function to change an existing load balancer nat rule protocol
    Begin {                                                                                 # Begin function
        if (!$CallingFunction) {                                                            # If $CallingFunction is $null
            $CallingFunction = 'SetAzLBNatRuleProtocol'                                     # Creates $CallingFunction
        }                                                                                   # End if (!$CallingFunction)
        :SetAzureLBNatRule while ($true) {                                                  # Outer loop for managing function
            $LBNatRule, $LoadBalancerObject = GetAzLBNatRuleConfig ($CallingFunction)       # Calls function and assigns output to $var
            if (!$LBNatRule) {                                                              # If $LBNatRule is $null
                Break SetAzureLBNatRule                                                     # Breaks :SetAzureLBNatRule
            }                                                                               # End if (!$LBNatRule)
            $CurrentRules = Get-AzLoadBalancerRuleConfig -LoadBalancer $LoadBalancerObject `
            | Where-Object {$_.FrontendIPConfiguration.ID -eq `
                $LBNatRule.FrontendIpConfiguration.ID}                                      # Gets a list of all rules using $LBNatRule.FrontendIpConfiguration.ID
            $CurrentNatRules = Get-AzLoadBalancerInboundNatRuleConfig -LoadBalancer `
                $LoadBalancerObject | Where-Object {$_.FrontendIPConfiguration.ID -eq `
                $LBNatRule.FrontendIpConfiguration.ID}                                      # Gets a list of all nat rules using $LBNatRule.FrontendIpConfiguration.ID
            [System.Collections.ArrayList]$ObjectArray = @()                                # Creates $ObjectArray
            foreach ($_ in $CurrentRules) {                                                 # For each item in $CurrentRules
                $PortandProtocol = $_.Protocol + ' ' + $_.FrontEndPort                      # $PortandProtocol is equal to current item .Protocol and .FrontEndPort                    
                $ObjectInput = [PSCustomObject]@{                                           # Creates the item to loaded into array
                    'PortandProto'=$PortandProtocol                                         # $PortandProtocol
                }                                                                           # End $ObjectInput = [PSCustomObject]@
                $ObjectArray.Add($ObjectInput) | Out-Null                                   # Adds $ObjectInput to $ObjectArray
                $PortandProtocol = $null                                                    # Clears $var
            }                                                                               # End foreach ($_ in $CurrentRules)
            foreach ($_ in $CurrentNatRules) {                                              # For each item in $CurrentNatRules
                $PortandProtocol = $_.Protocol + ' ' + $_.FrontEndPort                      # $PortandProtocol is equal to current item .Protocol and .FrontEndPort                    
                $ObjectInput = [PSCustomObject]@{                                           # Creates the item to loaded into array
                    'PortandProto'=$PortandProtocol                                         # $PortandProtocol
                }                                                                           # End $ObjectInput = [PSCustomObject]@
                $ObjectArray.Add($ObjectInput) | Out-Null                                   # Adds $ObjectInput to $ObjectArray
                $PortandProtocol = $null                                                    # Clears $var
            }                                                                               # End foreach ($_ in $CurrentNatRules)
            :NewAzureLBRuleProtocol while ($true) {                                         # Inner loop for setting the rule load disto
                if ($ObjectArray) {                                                         # If $ObjectArray has a value
                    Write-Host 'The following front end ports are already in use'           # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    foreach ($_ in $ObjectArray) {                                          # For each item in $ObjectArray
                        Write-Host $_.PortandProto                                          # Write message to screen
                    }                                                                       # End foreach ($_ in $ObjectArray)
                    Write-Host ''                                                           # Write message to screen
                }                                                                           # End if ($ObjectArray)
                Write-Host 'Nat Rule Name:'$LBNatRule.name                                  # Write message to screen
                Write-Host 'Load Balancer:'$LoadBalancerObject.name                         # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Write-Host 'Rule Protocol Options'                                          # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Write-Host '[0] Exit'                                                       # Write message to screen
                Write-Host '[1] TCP'                                                        # Write message to screen
                Write-Host '[2] UDP'                                                        # Write message to screen
                $OpSelect = Read-Host 'Option [#]'                                          # Operator input to select load disto
                Clear-Host                                                                  # Clears screen
                if ($OpSelect -eq '0') {                                                    # If $OpSelect equals '0'
                    Break SetAzureLBNatRule                                                 # Breaks SetAzureLBNatRule
                }                                                                           # End if ($OpSelect -eq '0')
                elseif ($OpSelect -eq '1') {                                                # Else if $OpSelect equals '1'
                    $LBRuleProtocol = 'TCP'                                                 # Sets $LBRuleProtocol
                    Break NewAzureLBRuleProtocol                                            # Breaks :NewAzureLBRuleProtocol
                }                                                                           # End elseif ($OpSelect -eq '1')
                elseif ($OpSelect -eq '2') {                                                # Else if $OpSelect equals '2'
                    $LBRuleProtocol = 'UDP'                                                 # Sets $LBRuleProtocol
                    Break NewAzureLBRuleProtocol                                            # Breaks :NewAzureLBRuleProtocol
                }                                                                           # End elseif ($OpSelect -eq '2')
                else {                                                                      # All other inputs for $OpSelect
                    Write-Host 'That was not a valid input'                                 # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Clear-Host                                                              # Clears screen
                }                                                                           # End else (if ($OpSelect -eq '0'))
            }                                                                               # End :NewAzureLBRuleProtocol while ($true)
            $ValidArray = '0123456789'                                                      # Creates a string of valid characters
            $ValidArray = $ValidArray.ToCharArray()                                         # Loads all valid characters into array
            :NewAzureLBNatRulePort while ($true) {                                          # Inner loop for setting the nat rule port
                Write-Host 'Enter the nat rule port'                                        # Write message to screen
                Write-Host ''                                                               # Writes message to screen
                $LBNatRulePort = Read-Host 'Port #'                                         # Operator input for the nat rule port 
                $LBRuleArray = $LBNatRulePort.ToCharArray()                                 # Adds $LBNatRulePort to array
                $LBNatRulePortProto = $LBRuleProtocol + ' ' + $LBNatRulePort                # $LBNatRulePortProto is equal to $LBRuleProtocol and $LBNatRulePort
                Clear-Host                                                                  # Clears screen
                :CheckInput foreach ($_ in $LBRuleArray) {                                  # For each item in $LBRuleArray
                    if ($_ -notin $ValidArray) {                                            # If current item is not in $ValidArray
                        Write-Host 'That was not a valid input'                             # Write message to screen
                        Write-Host ''                                                       # Write message to screen
                        $LBNatRulePort = $null                                              # Clears $LBRuleFrontEndPort
                        Break CheckInput                                                    # Breaks :CheckInput
                    }                                                                       # End if ($_ -notin $ValidArray)
                }                                                                           # End foreach ($_ in $LBRuleArray)
                $LBRuleArray = $null                                                        # Clears $LBRuleArray
                if ($LBNatRulePortProto -in $ObjectArray.PortandProto) {                    # If $LBNatRulePortProto is in $ObjectArray.PortandProto
                    Write-Host 'Port:'$LBNatRulePortProto' is already in use'               # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    Write-Host 'Please select another port'                                 # Write message to screen
                    Write-Host 'or move this rule to a different'                           # Write message to screen
                    Write-Host 'front end configuration'                                    # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    $LBNatRulePort = $null                                                  # Clears $LBNatRulePort
                }                                                                           # End if ($LBNatRulePortProto -in $ObjectArray.PortandProto)
                if ($LBNatRulePort) {                                                       # If $LBNatRulePort has a value
                    Write-Host 'Use:'$LBNatRulePortProto' as the nat rule port'             # Write message to screen
                    Write-Host ''                                                           # Writes message to screen
                    $OpConfirm = Read-Host '[Y] Yes [N] No [E] Exit'                        # Operator confirmation of the nat rule port
                    Clear-Host                                                              # Clears screen
                    if ($OpConfirm -eq 'e') {                                               # If $OpConfirm equals 'e'
                        Break SetAzureLBNatRule                                             # Breaks :SetAzureLBNatRule
                    }                                                                       # End if ($OpConfirm -eq 'e')
                    elseif ($OpConfirm -eq 'y') {                                           # Else if $OpConfirm equals 'y'
                        Break NewAzureLBNatRulePort                                         # Breaks :NewAzureLBNatRulePort
                    }                                                                       # End elseif ($OpConfirm -eq 'y')
                }                                                                           # End if ($LBNatRulePort)
                else {                                                                      # Else if $LBNatRulePort is $null
                    Pause                                                                   # Pauses all actions for operator input
                    Clear-Host                                                              # Clears screen
                }                                                                           # End else (if ($LBNatRulePort))
            }                                                                               # End :NewAzureLBNatRulePort while ($true)
            Write-Host 'Changing the nat rule port'                                         # Write message to screen
            if (!$EFloatIP) {                                                               # If (!$EFloatIP is $null
                if ($LBNatRule.EnableFloatingIP -eq $True) {                                # If $LBNatRule.EnableFloatingIP equals $True                          
                    $EFloatIP = $true                                                       # Sets $EFloatIP
                }                                                                           # End if ($LBNatRule.EnableFloatingIP -eq $True)
                else {                                                                      # Else if $LBNatRule.EnableFloatingIP does not equal $True 
                    $EFloatIP = $false                                                      # Sets $EFloatIP
                }                                                                           # End else (if ($LBNatRule.EnableFloatingIP -eq $True))
            }                                                                               # End if (!$EFloatIP)
            if ($LBNatRule.EnableTcpReset -eq $true) {                                      # If $LBNatRule.EnableTcpReset equals $true                               
                $ETCPReset = $true                                                          # Sets $ETCPReset
            }                                                                               # End if ($LBNatRule.EnableTcpReset -eq $true)
            else {                                                                          # Else if $LBNatRule.EnableTcpReset does not equal $true
                $ETCPReset = $false                                                         # Sets $ETCPReset
            }                                                                               # End Else (if ($LBNatRule.EnableTcpReset -eq $true))
            Try {                                                                           # Try the following
                Set-AzLoadBalancerInboundNatRuleConfig -LoadBalancer $LoadBalancerObject `
                    -Name $LBNatRule.Name -FrontendIpConfigurationId `
                        $LBNatRule.FrontendIpConfiguration.ID -Protocol $LBRuleProtocol `
                        -FrontendPort $LBNatRulePort -BackendPort $LBNatRulePort `
                        -EnableTcpReset:$ETCPReset -EnableFloatingIP:$EFloatIP `
                        -IdleTimeoutInMinutes  $LBNatRule.IdleTimeoutInMinutes -ErrorAction `
                        'Stop' | Out-Null                                                   # Changes the nat rule protocol
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
}                                                                                           # End function SetAzLBNatRuleProtocol