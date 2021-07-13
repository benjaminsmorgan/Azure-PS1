# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Mircosoft docs links
    Add-AzLoadBalancerInboundNatRuleConfig:     https://docs.microsoft.com/en-us/powershell/module/az.network/add-azloadbalancerinboundnatruleconfig?view=azps-6.1.0
    Set-AzLoadBalancer:                         https://docs.microsoft.com/en-us/powershell/module/az.network/set-azloadbalancer?view=azps-6.1.0
    Get-AzLoadBalancerFrontendIpConfig:         https://docs.microsoft.com/en-us/powershell/module/az.network/get-azloadbalancerfrontendipconfig?view=azps-6.0.0
    Get-AzLoadBalancer:                         https://docs.microsoft.com/en-us/powershell/module/az.network/get-azloadbalancer?view=azps-6.1.0
    Get-AzPublicIpAddress:                      https://docs.microsoft.com/en-us/powershell/module/az.network/get-azpublicipaddress?view=azps-5.5.0   
    Get-AzLoadBalancerInboundNatRuleConfig:     https://docs.microsoft.com/en-us/powershell/module/az.network/get-azloadbalancerinboundnatruleconfig?view=azps-6.1.0
    Get-AzNetworkInterface:                     https://docs.microsoft.com/en-us/powershell/module/az.network/get-aznetworkinterface?view=azps-6.1.0
    Get-AzNetworkInterfaceIpConfig:             https://docs.microsoft.com/en-us/powershell/module/az.network/get-aznetworkinterfaceipconfig?view=azps-6.1.0
    Set-AzNetworkInterfaceIpConfig:             https://docs.microsoft.com/en-us/powershell/module/az.network/set-aznetworkinterfaceipconfig?view=azps-6.1.0
    Set-AzNetworkInterface:                     https://docs.microsoft.com/en-us/powershell/module/az.network/set-aznetworkinterface?view=azps-6.1.0
    Get-AzVmss:                                 https://docs.microsoft.com/en-us/powershell/module/az.compute/get-azvmss?view=azps-6.1.0
    Remove-AzLoadBalancerInboundNatRuleConfig:  https://docs.microsoft.com/en-us/powershell/module/az.network/remove-azloadbalancerinboundnatruleconfig?view=azps-6.1.0
    Set-AzLoadBalancerInboundNatRuleConfig:     https://docs.microsoft.com/en-us/powershell/module/az.network/set-azloadbalancerinboundnatruleconfig?view=azps-6.1.0
} #>
<# Required Functions Links: {
    AddAzLBNatRuleConfig:       https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/Load%20Balancer/Nat%20Rule%20Config/AddAzLBNatRuleConfig.ps1
    ListAzLBNatRuleConfig:      https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/Load%20Balancer/Nat%20Rule%20Config/ListAzLBNatRuleConfig.ps1
    SetAzLBNatRuleVM:           https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/Load%20Balancer/Nat%20Rule%20Config/SetAzLBNatRuleVM.ps1
    RemoveAzLBNatRuleConfig:    https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/Load%20Balancer/Nat%20Rule%20Config/RemoveAzLBNatRuleConfig.ps1
    GetAzLBNatRuleConfig:       https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/Load%20Balancer/Nat%20Rule%20Config/GetAzLBNatRuleConfig.ps1
    GetAzNICIpConfig:           https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/NIC/GetAzNICIpConfig.ps1
    GetAzLBFEConfig:            https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/Load%20Balancer/Front%20End%20Config/GetAzLBFEConfig.ps1
} #>
<# Functions Description: {
    ManageAzLBNatRuleConfig:    Function to manage nat rule configurations
    AddAzLBNatRuleConfig:       Function to add a nat rule configuration
    ListAzLBNatRuleConfig:      Function for listing load balancer nat rules
    SetAzLBNatRuleVM:           Function to associate a VM to a nat rule
    RemoveAzLBNatRuleConfig:    Function to remove a load balancer nat rule configuration
    GetAzLBNatRuleConfig:       Function for getting load balancer nat rule
    GetAzNICIpConfig:           Gets a NIC IP configuration
    GetAzLBFEConfig:            Function to get a load balancer front end config
} #>
<# Variables: {      
    :ManageAzureLBNatRuleConfig Outer loop for managing function
    $OpSelect:                  Operator input for selecting the management function
    AddAzLBNatRuleConfig{}      Creates $LBNatRule
        GetAzLBFEConfig{}           Gets $FrontEndIPConfigObject,$LoadBalancerObject
    ListAzLBNatRuleConfig{}     Lists $LBNatRules
    SetAzLBNatRuleVM{}          Sets $LBNatRule
        GetAzLBNatRuleConfig{}      Gets $LBNatRule, $LoadBalancerObject
        GetAzNICIpConfig{}          Gets $NicIPConfigObject,$NicObject
    RemoveAzLBNatRuleConfig{}   Removes $LBNatRule
        GetAzLBNatRuleConfig{}      Gets $LBNatRule, $LoadBalancerObject
} #>
<# Process Flow {
    function
        Call ManageAzLBNatRuleConfig > Get $null
            Call AddAzLBNatRuleConfig > Get $null
                Call GetAzLBFEConfig > Get $FrontEndIPConfigObject,$LoadBalancerObject
                End GetAzLBFEConfig
                    Return AddAzLBNatRuleConfig > Send $FrontEndIPConfigObject,$LoadBalancerObject
            End AddAzLBNatRuleConfig
                Return ManageAzLBNatRuleConfig > Send $null
            Call ListAzLBNatRuleConfig > Get $null
            End ListAzLBNatRuleConfig
                Return ManageAzLBNatRuleConfig > Send $null
            Call SetAzLBNatRuleVM > Get $null
                Call GetAzLBNatRuleConfig > Get $LBNatRule, $LoadBalancerObject
                End GetAzLBNatRuleConfig
                    Return SetAzLBNatRuleVM > Send $LBNatRule, $LoadBalancerObject
                Call GetAzNICIpConfig > Get $NicIPConfigObject,$NicObjectt
                End GetAzNICIpConfig
                    Return SetAzLBNatRuleVM > Send $NicIPConfigObject,$NicObject
            End SetAzLBNatRuleVM
                Return ManageAzLBNatRuleConfig > Send $null
            Call RemoveAzLBNatRuleConfig > Get $null
                Call GetAzLBNatRuleConfig > Get $LBNatRule, $LoadBalancerObject
                End GetAzLBNatRuleConfig
                    Return RemoveAzLBNatRuleConfig > Send $LBNatRule, $LoadBalancerObject
            End RemoveAzLBNatRuleConfig
                Return ManageAzLBNatRuleConfig > Send $null
        End ManageAzLBNatRuleConfig
            Return function > Send $null
}#>
function ManageAzLBNatRuleConfig {                                                          # Function to manage nat rule configurations
    Begin {                                                                                 # Begin function
        :ManageAzureLBNatRuleConfig while ($true) {                                         # Outer loop for managing function
            Write-Host 'Manage Load Balancer Nat Rules'                                     # Write message to screen
            Write-Host '[0] Exit'                                                           # Write message to screen
            Write-Host '[1] Add Nat Rule Config'                                            # Write message to screen
            Write-Host '[2] List Nat Rule Configs'                                          # Write message to screen
            Write-Host '[3] Set Nat Rule Front End Config'                                  # Write message to screen
            Write-Host '[4] Set Nat Rule Source Port Config'                                # Write message to screen
            Write-Host '[5] Set Nat Rule Target Port Config'                                # Write message to screen
            Write-Host '[6] Set Nat Rule Idle Iime Out Config'                              # Write message to screen
            Write-Host '[7] Add VM to Nat Rule Config'                                      # Write message to screen
            Write-Host '[8] Remove VM from Nat Rule Config'                                 # Write message to screen
            Write-Host '[9] Remove Nat Rule Config'                                         # Write message to screen
            $OpSelect = Read-Host 'Option [#]'                                              # Operator input for the function selection
            Clear-Host                                                                      # Clears screen
            if ($OpSelect -eq '0') {                                                        # If $OpSelect equals '0'    
                Break ManageAzureLBNatRuleConfig                                            # Breaks :ManageAzureLBNatRuleConfig
            }                                                                               # End if ($OpSelect -eq '0')
            elseif ($OpSelect -eq '1') {                                                    # Else if $OpSelect equals '1'
                Write-Host 'Add Nat Rule Config'                                            # Write message to screen
                AddAzLBNatRuleConfig                                                        # Calls function
            }                                                                               # End elseif ($OpSelect -eq '1')
            elseif ($OpSelect -eq '2') {                                                    # Else if $OpSelect equals '2'
                Write-Host 'List Nat Rule Configs'                                          # Write message to screen
                ListAzLBNatRuleConfig                                                       # Calls function
            }                                                                               # End elseif ($OpSelect -eq '2')
            elseif ($OpSelect -eq '3') {                                                    # Else if $OpSelect equals '3'
                Write-Host 'Set Nat Rule Front End Config'                                  # Write message to screen
                SetAzLBNatRuleFE                                                            # Calls function
            }                                                                               # End elseif ($OpSelect -eq '3')
            elseif ($OpSelect -eq '4') {                                                    # Else if $OpSelect equals '4'
                Write-Host 'Set Nat Rule Source Port Config'                                # Write message to screen
                SetAzLBNatRulePort                                                          # Calls function
            }                                                                               # End elseif ($OpSelect -eq '4')
            elseif ($OpSelect -eq '5') {                                                    # Else if $OpSelect equals '5'
                Write-Host 'Set Nat Rule Target Port Config'                                # Write message to screen
                SetAzLBNatRuleTargetPort                                                    # Calls function
            }                                                                               # End elseif ($OpSelect -eq '5')
            elseif ($OpSelect -eq '6') {                                                    # Else if $OpSelect equals '6'
                Write-Host 'Set Nat Rule Idle Iime Out Config'                              # Write message to screen
                SetAzLBNatRuleTO                                                            # Calls function
            }                                                                               # End elseif ($OpSelect -eq '6')
            elseif ($OpSelect -eq '7') {                                                    # Else if $OpSelect equals '7'
                Write-Host 'Add VM to Nat Rule Config'                                      # Write message to screen
                SetAzLBNatRuleVM                                                            # Calls function
            }                                                                               # End elseif ($OpSelect -eq '7')
            elseif ($OpSelect -eq '8') {                                                    # Else if $OpSelect equals '8'
                Write-Host 'Remove VM from Nat Rule Config'                                 # Write message to screen
                RemoveAzLBNatRuleVM                                                         # Calls function
            }                                                                               # End elseif ($OpSelect -eq '8')
            elseif ($OpSelect -eq '9') {                                                    # Else if $OpSelect equals '9'
                Write-Host 'Remove Nat Rule Config'                                         # Write message to screen
                RemoveAzLBNatRuleConfig                                                     # Calls function
            }                                                                               # End elseif ($OpSelect -eq '9')
            else {                                                                          # All other inputs for $OpSelect
                Write-Host 'That was not a valid input'                                     # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Clear-Host                                                                  # Clears screen
            }                                                                               # End else (if ($OpSelect -eq '0'))
        }                                                                                   # End :ManageAzureLBNatRuleConfig while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function ManageAzLBFEConfig
function AddAzLBNatRuleConfig {                                                             # Function to add a nat rule configuration
    Begin {                                                                                 # Begin function
        if (!$CallingFunction) {                                                            # If $CallingFunction is $null
            $CallingFunction = 'AddAzLBNatRuleConfig'                                       # Creates $CallingFunction
        }                                                                                   # End if (!$CallingFunction)
        :AddAzureLBNatRule while ($true) {                                                  # Inner loop for setting the nat rule name
            $FrontEndIPConfigObject,$LoadBalancerObject = GetAzLBFEConfig `
                ($CallingFunction)                                                          # Calls function and assigns output to $vars
            if (!$FrontEndIPConfigObject) {                                                 # If $FrontEndIPConfigObject is $null
                Break AddAzureLBNatRule                                                     # Breaks :AddAzureLBNatRule
            }                                                                               # End if (!$FrontEndIPConfigObject)
            $ValidArray = 'abcdefghijklmnopqrstuvwxyz0123456789-_.'                         # Creates a string of valid characters
            $ValidArray = $ValidArray.ToCharArray()                                         # Loads all valid characters into array
            $Valid1stChar = 'abcdefghijklmnopqrstuvwxyz0123456789'                          # Creates a string of valid first character
            $Valid1stChar = $Valid1stChar.ToCharArray()                                     # Loads all valid characters into array
            $ValidLastChar = 'abcdefghijklmnopqrstuvwxyz0123456789_'                        # Creates a string of valid last character
            $ValidLastChar = $ValidLastChar.ToCharArray()                                   # Loads all valid characters into array
            :NewAzureLBRuleName while ($true) {                                             # Inner loop for setting the rule name
                Write-Host 'Enter a load balancer rule name'                                # Write message to screen
                Write-Host ''                                                               # Writes message to screen
                $LBRuleName = Read-Host 'Name'                                              # Operator input for the pool name
                Clear-Host                                                                  # Clears screen
                $LBRuleNameArray = $LBRuleName.ToCharArray()                                # Loads $LBRuleNameArray into array
                Clear-Host                                                                  # Clears screen
                if ($LBRuleName.Length -ge 81) {                                            # If $LBRuleName.Length is greater or equal to 81
                    Write-Host 'The rule name is to long'                                   # Write message to screen
                    Write-Host 'Max length of the name is 80 characters'                    # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    $LBRuleName = $null                                                     # Clears $LBRuleName
                }                                                                           # End if ($LBRuleName.Length -ge 80)
                if ($LBRuleNameArray[0] -notin $Valid1stChar) {                             # If 0 position of $LBRuleNameArray is not in $Valid1stChar
                    Write-Host 'The first character of the name must be a letter or number' # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    $LBRuleName = $null                                                     # Clears $LBRuleName
                }                                                                           # End if ($LBRuleNameArray[0] -notin $Valid1stChar)
                if ($LBRuleNameArray[-1] -notin $ValidLastChar) {                           # If last position of $LBRuleNameArray is not in $ValidLastChar
                    Write-Host `
                        'The last character of the name must be a letter, number or _ '     # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    $LBRuleName = $null                                                     # Clears $LBRuleName
                }                                                                           # End if ($LBRuleNameArray[0] -notin $Valid1stChar)
                foreach ($_ in $LBRuleNameArray) {                                          # For each item in $LBRuleNameArray
                    if ($_ -notin $ValidArray) {                                            # If current item is not in $ValidArray
                        if ($_ -eq ' ') {                                                   # If current item equals 'space'
                            Write-Host ''                                                   # Write message to screen    
                            Write-Host 'Rule name cannot include any spaces'                # Write message to screen
                        }                                                                   # End if ($_ -eq ' ')
                        else {                                                              # If current item is not equal to 'space'
                            Write-Host ''                                                   # Write message to screen    
                            Write-Host $_' is not a valid character'                        # Write message to screen
                        }                                                                   # End else (if ($_ -eq ' '))
                        $LBRuleName = $null                                                 # Clears $LBRuleName
                    }                                                                       # End if ($_ -notin $ValidArray)
                }                                                                           # End foreach ($_ in $LBNameArray)
                if ($LBRuleName) {                                                          # If $LBRuleName has a value
                    Write-Host 'Use:'$LBRuleName' as the rule name'                         # Writes message to screen
                    Write-Host ''                                                           # Writes message to screen
                    $OpConfirm = Read-Host '[Y] Yes [N] No [E] Exit'                        # Operator confirmation of the rule name
                    Clear-Host                                                              # Clears screen
                    if ($OpConfirm -eq 'e') {                                               # If $OpConfirm equals 'e'
                        Break AddAzureLBNatRule                                             # Breaks :AddAzureLBNatRule
                    }                                                                       # End if ($OpConfirm -eq 'e')
                    if ($OpConfirm -eq 'y') {                                               # If $OpConfirm equals 'y'
                        Break NewAzureLBRuleName                                            # Breaks :NewAzureLBRuleName
                    }                                                                       # End if ($OpConfirm -eq 'y')
                }                                                                           # End if ($LBRuleName)
                else {                                                                      # If $LBRuleName is $null
                    Pause                                                                   # Pauses all actions for operator input
                    Clear-Host                                                              # Clears screen
                }                                                                           # End else (if ($LBRuleName))
            }                                                                               # End :NewAzureLBRuleName while ($true)
            :NewAzureLBRuleProtocol while ($true) {                                         # Inner loop for setting the rule protocol
                Write-Host 'Inbound Nat Rule Protocol'                                      # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Write-Host '[0] Exit'                                                       # Write message to screen
                Write-Host '[1] TCP'                                                        # Write message to screen
                Write-Host '[2] UDP'                                                        # Write message to screen
                Write-Host ''                                                               # Write message to screen
                $OpSelect = Read-Host 'Option [#]'                                          # Operator input to select the rule protocol
                Clear-Host                                                                  # Clears screen
                if ($OpSelect -eq '0') {                                                    # If $OpSelect equals '0'
                    Break AddAzureLBNatRule                                                 # Breaks :AddAzureLBNatRule
                }                                                                           # End if ($OpSelect -eq '0')
                elseif ($OpSelect -eq '1') {                                                # Else if $OpSelect equals '1'
                    $LBRuleProtocol = 'TCP'                                                 # Creates $LBRuleProtocol
                    Break NewAzureLBRuleProtocol                                            # Breaks :NewAzureLBRuleProtocol 
                }                                                                           # End elseif ($OpSelect -eq '1')
                elseif ($OpSelect -eq '2') {                                                # Else if $OpSelect equals '2'
                    $LBRuleProtocol = 'UDP'                                                 # Creates $LBRuleProtocol
                    Break NewAzureLBRuleProtocol                                            # Breaks :NewAzureLBRuleProtocol
                }                                                                           # End elseif ($OpSelect -eq '2')
                else  {                                                                     # All other inputs for $OpSelect
                    Write-Host 'That was not a valid input'                                 # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Clear-Host                                                              # Clears screen
                }                                                                           # End else (if ($OpSelect -eq '0'))
            }                                                                               # End :NewAzureLBRuleProtocol while ($true)
            $ValidArray = '0123456789'                                                      # Creates a string of valid characters
            $ValidArray = $ValidArray.ToCharArray()                                         # Loads all valid characters into array
            :NewAzureLBRulePort while ($true) {                                             # Inner loop for setting the rule port
                Write-Host 'Enter the nat rule port'                                        # Write message to screen
                Write-Host ''                                                               # Writes message to screen
                $LBRulePort = Read-Host 'Port #'                                            # Operator input for the front end rule port 
                $LBRuleArray = $LBRulePort.ToCharArray()                                    # Adds $LBRulePort to array
                Clear-Host                                                                  # Clears screen
                foreach ($_ in $LBRuleArray) {                                              # For each item in $LBRuleArray
                    if ($_ -notin $ValidArray) {                                            # If current item is not in $ValidArray
                        $LBRulePort = $null                                                 # Clears $LBRulePort
                    }                                                                       # End if ($_ -notin $ValidArray)
                }                                                                           # End foreach ($_ in $LBRuleArray)
                $LBRuleArray = $null                                                        # Clears $LBRuleArray
                if ($LBRulePort) {                                                          # If $LBRulePort has a value
                    Write-Host 'Use:'$LBRulePort' as the rule port'                         # Write message to screen
                    Write-Host ''                                                           # Writes message to screen
                    $OpConfirm = Read-Host '[Y] Yes [N] No [E] Exit'                        # Operator confirmation of the rule port
                    Clear-Host                                                              # Clears screen
                    if ($OpConfirm -eq 'e') {                                               # If $OpConfirm equals 'e'
                        Break AddAzureLBNatRule                                             # Breaks :AddAzureLBNatRule
                    }                                                                       # End if ($OpConfirm -eq 'e')
                    if ($OpConfirm -eq 'y') {                                               # If $OpConfirm equals 'y'
                        Break NewAzureLBRulePort                                            # Breaks :NewAzureLBRulePort        
                    }                                                                       # End if ($OpConfirm -eq 'y')
                }                                                                           # End if ($LBRulePort)
                else {                                                                      # Else if $LBRulePort is $null
                    Write-Host 'That was not a valid input'                                 # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Clear-Host                                                              # Clears screen
                }                                                                           # End else (if ($LBRulePort))
            }                                                                               # End :NewAzureLBRulePort while ($true)
            :NewAzureLBRuleIdleTO while ($true) {                                           # Inner loop for setting the rule idle timeout
                Write-Host 'Enter the idle time out in minutes for this rule'               # Write message to screen
                Write-Host ''                                                               # Writes message to screen
                $LBRuleIdleTO = Read-Host 'Idle timeout'                                    # Operator input for the rule idle timeout 
                $LBRuleIdleINT = [int]$LBRuleIdleTO                                         # Converts the operator input into an interger
                $LBRuleArray = $LBRuleIdleTO.ToCharArray()                                  # Adds $LBRuleIdleTO to array
                Clear-Host                                                                  # Clears screen
                if ($LBRuleIdleINT -gt 30) {                                                # If $LBRuleIdleINT is greater than 30
                    Write-Host 'Rule time out max is 30 minutes'                            # Write message to screen
                    Write-Host 'Please choose a lower timeout'                              # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    $LBRuleIdleTO = $null                                                   # Clears $LBRuleIdleTO
                }                                                                           # End if ($LBRuleIdleTO -gt 30)
                $LBRuleIdleINT =$null
                foreach ($_ in $LBRuleArray) {                                              # For each item in $LBRuleArray
                    if ($_ -notin $ValidArray) {                                            # If current item is not in $ValidArray
                        $LBRuleIdleTO = $null                                               # Clears $LBRuleIdleTO
                    }                                                                       # End if ($_ -notin $ValidArray)
                }                                                                           # End foreach ($_ in $LBRuleArray)
                $LBRuleArray = $null                                                        # Clears $LBRuleArray
                if ($LBRuleIdleTO) {                                                        # If $LBRuleIdleTO has a value
                    Write-Host 'Use:'$LBRuleIdleTO' as the rule idle time out'              # Write message to screen
                    Write-Host ''                                                           # Writes message to screen
                    $OpConfirm = Read-Host '[Y] Yes [N] No [E] Exit'                        # Operator confirmation of the idle timeout
                    Clear-Host                                                              # Clears screen
                    if ($OpConfirm -eq 'e') {                                               # If $OpConfirm equals 'e'
                        Break AddAzureLBNatRule                                             # Breaks :AddAzureLBNatRule
                    }                                                                       # End if ($OpConfirm -eq 'e')
                    if ($OpConfirm -eq 'y') {                                               # If $OpConfirm equals 'y'
                        Break NewAzureLBRuleIdleTO                                          # Breaks :NewAzureLBRuleIdleTO        
                    }                                                                       # End if ($OpConfirm -eq 'y')
                }                                                                           # End if ($LBRuleIdleTO)
                else {                                                                      # Else if $LBRuleIdleTO is $null
                    Write-Host 'That was not a valid input'                                 # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Clear-Host                                                              # Clears screen
                }                                                                           # End else (if ($LBRuleIdleTO))
            }                                                                               # End :NewAzureLBRuleIdleTO while ($true)
            Try {                                                                           # Try the following
                Write-Host 'Adding the nat rule to the load balancer'                       # Write message to screen
                Add-AzLoadBalancerInboundNatRuleConfig -LoadBalancer $LoadBalancerObject `
                    -FrontendIpConfigurationId $FrontEndIPConfigObject.ID `
                    -Name $LBRuleName  -Protocol $LBRuleProtocol -FrontendPort $LBRulePort `
                    -BackendPort $LBRulePort -IdleTimeoutInMinutes $LBRuleIdleTO `
                    -ErrorAction 'Stop' | Out-Null                                          # Creates the load balancer nat rule
            }                                                                               # End try
            Catch {                                                                         # If Try fails
                Clear-Host                                                                  # Clears screen
                Write-Host 'An error has occured'                                           # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break AddAzureLBNatRule                                                     # Breaks :AddAzureLBNatRule
            }                                                                               # End catch
            Write-Host 'Saving the configuration'
            $LoadBalancerObject | Set-AzLoadBalancer -ErrorAction 'silentlyContinue' `
                | Out-Null                                                                  # Saves the changes
            Clear-Host                                                                      # Clears screen
            Write-Host 'The rule has been added'                                            # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            Pause                                                                           # Pauses all actions for operator input
            Break AddAzureLBNatRule                                                         # Breaks :AddAzureLBNatRule
        }                                                                                   # End :AddAzureLBNatRule while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function AddAzLBNatRuleConfig
Function ListAzLBNatRuleConfig {                                                            # Function to list all load balancer nat rules
    Begin {                                                                                 # Begin function
        :ListAzureLBNatRule while ($true) {                                                 # Outer loop for managing function
            $LBList = Get-AzLoadBalancer                                                    # Gets a list of all load balancers
            Write-Host 'Gathering load balancer configurations'                             # Write message to screen
            Write-Host 'This may take a moment'                                             # Write message to screen
            if (!$LBList) {                                                                 # If $LBList is $null
                Clear-Host                                                                  # Clears screen
                Write-Host 'No load balancers present in this subscription'                 # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break ListAzureLBNatRule                                                    # Breaks :ListAzureLBNatRule
            }                                                                               # End if (!$LBList)
            [System.Collections.ArrayList]$ObjectArray = @()                                # Creates object list array
            foreach ($_ in $LBList) {                                                       # For each item in $LBList
                $LoadBalancerObject = $_                                                    # $LoadBalancerObject is equal to current item
                $LBRuleList = Get-AzLoadBalancerInboundNatRuleConfig -LoadBalancer `
                    $LoadBalancerObject                                                     # Gets a list of load balancers nat rules on $LoadBalancerObject
                if ($LBRuleList) {                                                          # If $LBRuleList has a value
                    foreach ($_ in $LBRuleList) {                                           # For each item in $LBRuleList
                        $FrontEndID = $_.FrontendIpConfiguration.ID                         # Gets the rule front end ID
                        $FrontEndID = $FrontEndID.Split('/')[-1]                            # Isloates the front end config name
                        $FrontEnd = Get-AzLoadBalancerFrontendIpConfig -LoadBalancer `
                            $LoadBalancerObject -Name $FrontEndID                           # Gets the front end object
                        if ($FrontEnd.Subnet.ID) {                                          # If $FrontEnd.Subnet.ID has a value
                            $FrontEndSub = $FrontEnd.Subnet.ID                              # Isloates the front end subnet ID
                            $FrontEndSub = $FrontEndSub.Split('/')[-1]                      # Isolates the front end subnet name
                        }                                                                   # End if ($FrontEnd.Subnet.ID)
                        if ($FrontEnd.PublicIpAddress.ID) {                                 # If $FrontEnd.PublicIpAddress.ID has a value
                            $PubIPID = $FrontEnd.PublicIpAddress.ID                         # Isolates the public IP ID
                            $FEPublicIPObject = Get-AzPublicIpAddress | Where-Object `
                                {$_.ID -eq $PubIPID}                                        # Gets the public ID sku object
                        }                                                                   # End if ($FrontEnd.PublicIpAddress.ID)
                        if ($_.BackendIpConfiguration.ID) {                                 # If current item .BackendIpConfiguration.ID has a value
                            $BackEndID = $_.BackendIpConfiguration.ID                       # Isolates the back end IP config ID
                            $BackEndNic = $BackEndID.Split('/')[8]                          # Isolates the back end NIC name
                            $BackEndName = $BackEndID.Split('/')[-1]                        # Isolates the back end IP config name
                            $BackEndNic = Get-AzNetworkInterface -Name $BackEndNic          # Gets the back end NIC
                            $BackEndConfig = Get-AzNetworkInterfaceIpConfig `
                                -NetworkInterface $BackEndNic -Name $BackEndName            # Gets the back end config NIC ip config
                            $BackEndSub = $BackEndConfig.Subnet.Id                          # Isolates the back end subnet ID
                            $BackEndSub = $BackEndSub.Split('/')[-1]                        # Isolates the back end subnet name
                            $VMObject = Get-AzVM | Where-Object `
                                {$_.NetworkProfile.NetworkInterfaces.ID -eq $BackEndNic.ID} # Gets the VM $BackEndNic is attached to 
                        }                                                                   # End if ($_.BackendIpConfiguration.ID) 
                        $ObjectList = [PSCustomObject]@{                                    # Var used to load items into $ObjectArray
                            'Name'=$_.Name;                                                 # Nat rule name
                            'Proto'=$_.Protocol;                                            # Nat rule protocol
                            'LBName'=$LoadBalancerObject.Name;                              # Load balancer name
                            'FEPort'=$_.FrontendPort;                                       # Nat rule source port
                            'BEPort'=$_.BackEndPort;                                        # Nat rule target port
                            'Idle'=$_.IdleTimeoutInMinutes;                                 # Nat rule idle time out
                            'FEName'=$FrontEnd.Name;                                        # Front end name
                            'FEPriIP'=$FrontEnd.PrivateIpAddress;                           # Front end private IP
                            'FEPriAll'=$FrontEnd.PrivateIpAllocationMethod;                 # Front end private IP allocation
                            'FESub'=$FrontEndSub;                                           # Front end subnet
                            'FEPubIPName'=$FEPublicIPObject.Name;                           # Target public IP sku name
                            'FEPubIPAdd'=$FEPublicIPObject.IpAddress;                       # Target public IP address
                            'FEPubIPAll'=$FEPublicIPObject.PublicIpAllocationMethod;        # Target public IP addess allocation
                            'BEPriIP'=$BackEndConfig.PrivateIpAddress;                      # Target private IP address
                            'BEPriIPAll'=$BackEndConfig.PrivateIpAllocationMethod;          # Target private IP allocation 
                            'BESub'=$BackEndSub;                                            # Target subnet
                            'VMName'=$VMObject.Name                                         # VM object name        
                        }                                                                   # End $ObjectList = [PSCustomObject]@
                        $ObjectArray.Add($ObjectList) | Out-Null                            # Adds ObjectList to $ObjectArray
                        $FrontEndID = $null                                                 # Clears $var                     
                        $FrontEnd = $null                                                   # Clears $var
                        $FrontEndSub = $null                                                # Clears $var
                        $PubIPID = $null                                                    # Clears $var
                        $FEPublicIPObject = $null                                           # Clears $var
                        $BackEndID = $null                                                  # Clears $var
                        $BackEndNic = $null                                                 # Clears $var
                        $BackEndName = $null                                                # Clears $var
                        $BackEndConfig = $null                                              # Clears $var
                        $BackEndSub = $null                                                 # Clears $var
                        $VMObject = $null                                                   # Clears $var
                    }                                                                       # End foreach ($_ in $LBRuleList)
                }                                                                           # End if ($LBRuleList)
            }                                                                               # End foreach ($_ in $LBList)
            Clear-Host                                                                      # Clears screen    
            if (!$ObjectArray) {                                                            # If $ObjectArray is $null
                Write-Host 'No inbound nat rules are present in this subscription'          # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break ListAzureLBNatRule                                                    # Breaks :ListAzureLBNatRule
            }                                                                               # End if (!$ObjectArray)
            foreach ($_ in $ObjectArray) {                                                  # For each item in $ObjectArray
                Write-Host 'Nat rule name: '$_.Name                                         # Write message to screen
                Write-Host 'LB name:       '$_.LBName                                       # Write message to screen
                Write-Host 'Protocol:      '$_.Proto                                        # Write message to screen
                Write-Host 'FE port:       '$_.FEPort                                       # Write message to screen
                Write-Host 'BE port:       '$_.BEPort                                       # Write message to screen
                Write-Host 'Idle TO in min:'$_.Idle                                         # Write message to screen
                Write-Host 'Front end name:'$_.FeName                                       # Write message to screen
                if ($_.FESub) {                                                             # If $_.FESub has a value
                    Write-Host 'FE private IP: '$_.FEPriIP                                  # Write message to screen
                    Write-Host 'FE IP method:  '$_.FEPriAll                                 # Write message to screen
                    Write-Host 'FE subnet:     '$_.FESub                                    # Write message to screen
                }                                                                           # End if ($_.FESub)
                if ($_.FEPubIPName) {                                                       # If $_.FEPubIPName has a value
                    Write-Host 'FE pub IP name:'$_.FEPubIPName                              # Write message to screen
                    Write-Host 'FE pub IP add: '$_.FEPubIPAdd                               # Write message to screen
                    Write-Host 'FE pub method: '$_.FEPubIPAll                               # Write message to screen
                }                                                                           # End if ($_.FEPubIPName)
                if ($_.BESub) {                                                             # If $_.BESub has a value
                    Write-Host 'BE private IP: '$_.BEPriIP                                  # Write message to screen
                    Write-Host 'BE IP method:  '$_.BEPriIPAll                               # Write message to screen
                    Write-Host 'BE subnet:     '$_.BESub                                    # Write message to screen
                }                                                                           # End if ($_.BESub)
                if ($_.BEPubIP) {                                                           # If $_.BEPubIP has a value
                    Write-Host 'BE public IP:  '$_.BEPubIP                                  # Write message to screen
                }                                                                           # End if ($_.BEPubIP)
                if ($_.VMName) {                                                            # If $_.VMName has a value
                    Write-Host 'Target VM Name:'$_.VMName                                   # Write message to screen
                }                                                                           # End if ($_.VMName)
                Write-Host ''                                                               # Write message to screen
            }                                                                               # End foreach ($_ in $ObjectArray)
            Pause                                                                           # Pauses all actions for operator input
            Break ListAzureLBNatRule                                                        # Breaks :ListAzureLBNatRule
        }                                                                                   # End :ListAzureLBNatRule while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function ListAzLBNatRuleConfig
Function GetAzLBNatRuleConfig {                                                             # Function to get a load balancer nat rule
    Begin {                                                                                 # Begin function
        :GetAzureLBNatRule while ($true) {                                                  # Outer loop for managing function
            $LBList = Get-AzLoadBalancer                                                    # Gets a list of all load balancers
            Write-Host 'Gathering load balancer configurations'                             # Write message to screen
            Write-Host 'This may take a moment'                                             # Write message to screen
            if (!$LBList) {                                                                 # If $LBList is $null
                Clear-Host                                                                  # Clears screen
                Write-Host 'No load balancers present in this subscription'                 # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break GetAzureLBNatRule                                                     # Breaks :GetAzureLBNatRule
            }                                                                               # End if (!$LBList)
            [System.Collections.ArrayList]$ObjectArray = @()                                # Creates object list array
            $ObjectNumber = 1                                                               # Creates $ObjectNumber
            foreach ($_ in $LBList) {                                                       # For each item in $LBList
                $LoadBalancerObject = $_                                                    # $LoadBalancerObject is equal to current item
                $LBRuleList = Get-AzLoadBalancerInboundNatRuleConfig -LoadBalancer `
                    $LoadBalancerObject                                                     # Gets a list of load balancers nat rules on $LoadBalancerObject
                if ($LBRuleList) {                                                          # If $LBRuleList has a value
                    foreach ($_ in $LBRuleList) {                                           # For each item in $LBRuleList
                        $FrontEndID = $_.FrontendIpConfiguration.ID                         # Gets the rule front end ID
                        $FrontEndID = $FrontEndID.Split('/')[-1]                            # Isloates the front end config name
                        $FrontEnd = Get-AzLoadBalancerFrontendIpConfig -LoadBalancer `
                            $LoadBalancerObject -Name $FrontEndID                           # Gets the front end object
                        if ($FrontEnd.Subnet.ID) {                                          # If $FrontEnd.Subnet.ID has a value
                            $FrontEndSub = $FrontEnd.Subnet.ID                              # Isloates the front end subnet ID
                            $FrontEndSub = $FrontEndSub.Split('/')[-1]                      # Isolates the front end subnet name
                        }                                                                   # End if ($FrontEnd.Subnet.ID)
                        if ($FrontEnd.PublicIpAddress.ID) {                                 # If $FrontEnd.PublicIpAddress.ID has a value
                            $PubIPID = $FrontEnd.PublicIpAddress.ID                         # Isolates the public IP ID
                            $FEPublicIPObject = Get-AzPublicIpAddress | Where-Object `
                                {$_.ID -eq $PubIPID}                                        # Gets the public ID sku object
                        }                                                                   # End if ($FrontEnd.PublicIpAddress.ID)
                        if ($_.BackendIpConfiguration.ID) {                                 # If current item .BackendIpConfiguration.ID has a value
                            $BackEndID = $_.BackendIpConfiguration.ID                       # Isolates the back end IP config ID
                            $BackEndNic = $BackEndID.Split('/')[8]                          # Isolates the back end NIC name
                            $BackEndName = $BackEndID.Split('/')[-1]                        # Isolates the back end IP config name
                            $BackEndNic = Get-AzNetworkInterface -Name $BackEndNic          # Gets the back end NIC
                            $BackEndConfig = Get-AzNetworkInterfaceIpConfig `
                                -NetworkInterface $BackEndNic -Name $BackEndName            # Gets the back end config NIC ip config
                            $BackEndSub = $BackEndConfig.Subnet.Id                          # Isolates the back end subnet ID
                            $BackEndSub = $BackEndSub.Split('/')[-1]                        # Isolates the back end subnet name
                            $VMObject = Get-AzVM | Where-Object `
                                {$_.NetworkProfile.NetworkInterfaces.ID -eq $BackEndNic.ID} # Gets the VM $BackEndNic is attached to 
                        }                                                                   # End if ($_.BackendIpConfiguration.ID) 
                        $ObjectList = [PSCustomObject]@{                                    # Var used to load items into $ObjectArray
                            'Number'=$ObjectNumber;                                         # List number
                            'Name'=$_.Name;                                                 # Nat rule name
                            'Proto'=$_.Protocol;                                            # Nat rule protocol
                            'LBName'=$LoadBalancerObject.Name;                              # Load balancer name
                            'FEPort'=$_.FrontendPort;                                       # Nat rule source port
                            'BEPort'=$_.BackEndPort;                                        # Nat rule target port
                            'Idle'=$_.IdleTimeoutInMinutes;                                 # Nat rule idle time out
                            'FEName'=$FrontEnd.Name;                                        # Front end name
                            'FEPriIP'=$FrontEnd.PrivateIpAddress;                           # Front end private IP
                            'FEPriAll'=$FrontEnd.PrivateIpAllocationMethod;                 # Front end private IP allocation
                            'FESub'=$FrontEndSub;                                           # Front end subnet
                            'FEPubIPName'=$FEPublicIPObject.Name;                           # Target public IP sku name
                            'FEPubIPAdd'=$FEPublicIPObject.IpAddress;                       # Target public IP address
                            'FEPubIPAll'=$FEPublicIPObject.PublicIpAllocationMethod;        # Target public IP addess allocation
                            'BEPriIP'=$BackEndConfig.PrivateIpAddress;                      # Target private IP address
                            'BEPriIPAll'=$BackEndConfig.PrivateIpAllocationMethod;          # Target private IP allocation 
                            'BESub'=$BackEndSub;                                            # Target subnet
                            'VMName'=$VMObject.Name                                         # VM object name                                              
                        }                                                                   # End $ObjectList = [PSCustomObject]@
                        $ObjectArray.Add($ObjectList) | Out-Null                            # Adds ObjectList to $ObjectArray
                        $ObjectNumber = $ObjectNumber + 1                                   # Increments $ObjectNumber up by 1
                        $FrontEndID = $null                                                 # Clears $var                     
                        $FrontEnd = $null                                                   # Clears $var
                        $FrontEndSub = $null                                                # Clears $var
                        $PubIPID = $null                                                    # Clears $var
                        $FEPublicIPObject = $null                                           # Clears $var
                        $BackEndID = $null                                                  # Clears $var
                        $BackEndNic = $null                                                 # Clears $var
                        $BackEndName = $null                                                # Clears $var
                        $BackEndConfig = $null                                              # Clears $var
                        $BackEndSub = $null                                                 # Clears $var
                        $VMObject = $null                                                   # Clears $var
                    }                                                                       # End foreach ($_ in $LBRuleList)
                }                                                                           # End if ($LBRuleList)
            }                                                                               # End foreach ($_ in $LBList)
            Clear-Host                                                                      # Clears screen    
            if (!$ObjectArray) {                                                            # If $ObjectArray is $null
                Write-Host 'No inbound nat rules are present in this subscription'          # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break GetAzureLBNatRule                                                     # Breaks :GetAzureLBNatRule
            }                                                                               # End if (!$ObjectArray)
            :SelectAzureLBNatRule while ($true) {                                           # Inner loop for selecting the nat rule
                Write-Host '[0]  Exit'                                                      # Write message to screen
                Write-Host ''                                                               # Write message to screen
                foreach ($_ in $ObjectArray) {                                              # For each item in $ObjectArray
                    $Number = $_.Number                                                     # $Number is equal to current item .number
                    if ($Number -le 9) {                                                    # If $Number is 9 or less
                        Write-Host "[$Number]            "$_.Name                           # Write message to screen
                    }                                                                       # End if ($Number -le 9)
                    else {                                                                  # Else if $Number is greater than 9
                        Write-Host "[$Number]           "$_.Name                            # Write message to screen
                    }                                                                       # End else (if ($Number -le 9))
                    Write-Host 'LB name:       '$_.LBName                                   # Write message to screen
                    Write-Host 'Protocol:      '$_.Proto                                    # Write message to screen
                    Write-Host 'FE port:       '$_.FEPort                                   # Write message to screen
                    Write-Host 'BE port:       '$_.BEPort                                   # Write message to screen
                    Write-Host 'Idle TO in min:'$_.Idle                                     # Write message to screen
                    Write-Host 'Front end name:'$_.FeName                                   # Write message to screen
                    if ($_.FESub) {                                                         # If $_.FESub has a value
                        Write-Host 'FE private IP: '$_.FEPriIP                              # Write message to screen
                        Write-Host 'FE IP method:  '$_.FEPriAll                             # Write message to screen
                        Write-Host 'FE subnet:     '$_.FESub                                # Write message to screen
                    }                                                                       # End if ($_.FESub)
                    if ($_.FEPubIPName) {                                                   # If $_.FEPubIPName has a value
                        Write-Host 'FE pub IP name:'$_.FEPubIPName                          # Write message to screen
                        Write-Host 'FE pub IP add: '$_.FEPubIPAdd                           # Write message to screen
                        Write-Host 'FE pub method: '$_.FEPubIPAll                           # Write message to screen
                    }                                                                       # End if ($_.FEPubIPName)
                    if ($_.BESub) {                                                         # If $_.BESub has a value
                        Write-Host 'BE private IP: '$_.BEPriIP                              # Write message to screen
                        Write-Host 'BE IP method:  '$_.BEPriIPAll                           # Write message to screen
                        Write-Host 'BE subnet:     '$_.BESub                                # Write message to screen
                    }                                                                       # End if ($_.BESub)
                    if ($_.BEPubIP) {                                                       # If $_.BEPubIP has a value
                        Write-Host 'BE public IP:  '$_.BEPubIP                              # Write message to screen
                    }                                                                       # End if ($_.BEPubIP)
                    if ($_.VMName) {                                                        # If $_.VMName has a value
                        Write-Host 'Target VM Name:'$_.VMName                               # Write message to screen
                    }                                                                       # End if ($_.VMName)
                    Write-Host ''                                                           # Write message to screen
                }                                                                           # End foreach ($_ in $ObjectArray)
                if ($CallingFunction) {                                                     # If $CallingFunction has a value
                    Write-Host 'You are selecting the nat rule for:'$CallingFunction        # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                }                                                                           # End if ($CallingFunction)
                $OpSelect = Read-Host 'Option [#]'                                          # Operator input to select the nat rule
                Clear-Host                                                                  # Clears screen
                if ($OpSelect -eq '0') {                                                    # If $OpSelect equals '0'
                    Break GetAzureLBNatRule                                                 # Breaks :GetAzureLBNatRule
                }                                                                           # End if ($OpSelect -eq '0')
                elseif ($OpSelect -in $ObjectArray.Number) {
                    $OpSelect = $ObjectArray | Where-Object {$_.Number -eq $OpSelect}       # OpSelect is equal to $ObjectArray where $Opselect equals $ObjectArray.Number
                    $LoadBalancerObject = Get-AzLoadBalancer -name $OpSelect.LBName         # Pulls the load balancer
                    $LBNatRule = Get-AzLoadBalancerInboundNatRuleConfig -LoadBalancer `
                        $LoadBalancerObject -Name $OpSelect.Name                            # Pulls the load balancer rule
                    Return $LBNatRule, $LoadBalancerObject                                  # Returns to calling function with $vars
                }                                                                           # End elseif ($OpSelect -in $ObjectArray.Number)
                else {                                                                      # All other inputs for $OpSelect
                    Write-Host 'That was not a valid input'                                 # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Clear-Host                                                              # Clears screen
                }                                                                           # End else (if ($OpSelect -eq '0'))
            }                                                                               # End :SelectAzureLBNatRule while ($true)
        }                                                                                   # End :GetAzureLBNatRule while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function GetAzLBNatRuleConfig
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
function SetAzLBNatRulePort {                                                               # Function to change an existing load balancer nat rule port
    Begin {                                                                                 # Begin function
        if (!$CallingFunction) {                                                            # If $CallingFunction is $null
            $CallingFunction = 'SetAzLBNatRulePort'                                         # Creates $CallingFunction
        }                                                                                   # End if (!$CallingFunction)
        :SetAzureLBNatRule while ($true) {                                                  # Outer loop for managing function
            $LBNatRule, $LoadBalancerObject = GetAzLBNatRuleConfig ($CallingFunction)       # Calls function and assigns output to $var
            if (!$LBNatRule) {                                                              # If $LBNatRule is $null
                Break SetAzureLBNatRule                                                     # Breaks :SetAzureLBNatRule
            }                                                                               # End if (!$LBNatRule)
            $ValidArray = '0123456789'                                                      # Creates a string of valid characters
            $ValidArray = $ValidArray.ToCharArray()                                         # Loads all valid characters into array
            :NewAzureLBNatRulePort while ($true) {                                          # Inner loop for setting the nat rule port
                Write-Host 'Enter the nat rule pool port'                                   # Write message to screen
                Write-Host ''                                                               # Writes message to screen
                $LBNatRulePort = Read-Host 'Port #'                                         # Operator input for the nat rule port 
                $LBRuleArray = $LBNatRulePort.ToCharArray()                                 # Adds $LBNatRulePort to array
                Clear-Host                                                                  # Clears screen
                foreach ($_ in $LBRuleArray) {                                              # For each item in $LBRuleArray
                    if ($_ -notin $ValidArray) {                                            # If current item is not in $ValidArray
                        $LBNatRulePort = $null                                              # Clears $LBNatRulePort
                    }                                                                       # End if ($_ -notin $ValidArray)
                }                                                                           # End foreach ($_ in $LBRuleArray)
                $LBRuleArray = $null                                                        # Clears $LBRuleArray
                if ($LBNatRulePort) {                                                       # If $LBNatRulePort has a value
                    Write-Host 'Use:'$LBNatRulePort' as the nat rule source port'           # Write message to screen
                    Write-Host ''                                                           # Writes message to screen
                    $OpConfirm = Read-Host '[Y] Yes [N] No [E] Exit'                        # Operator confirmation of the nat rule port
                    Clear-Host                                                              # Clears screen
                    if ($OpConfirm -eq 'e') {                                               # If $OpConfirm equals 'e'
                        Break SetAzureLBNatRule                                             # Breaks :SetAzureLBNatRule
                    }                                                                       # End if ($OpConfirm -eq 'e')
                    if ($OpConfirm -eq 'y') {                                               # If $OpConfirm equals 'y'
                        Write-Host 'Current target port is:   '$LBNatRule.BackEndPort       # Write message to screen
                        Write-Host 'Change the target port to:'$LBNatRulePort               # Write message to screen
                        Write-Host ''                                                       # Write message to screen
                        $OpSelect = Read-Host '[Y] Yes [N] No'                              # Operator selection for change the target port too
                        Clear-Host                                                          # Clears screen
                        if ($OpSelect -eq 'y') {                                            # If $OpSelect equals 'y'
                            $LBNatRuleTargetPort = $LBNatRulePort                           # Sets $LBNatRuleTargetPort
                        }                                                                   # End if ($OpSelect -eq 'y')
                        else {                                                              # All other inputs for $OpSelect
                            $LBNatRuleTargetPort = $LBNatRule.BackEndPort                   # Sets $LBNatRuleTargetPort
                        }                                                                   # End else (if ($OpSelect -eq 'y'))
                        if ($LBNatRulePort -ne $LBNatRuleTargetPort) {                      # If $LBNatRulePort does not equal $LBNatRuleTargetPort
                            Write-Host 'Enable floating IP'                                 # Write message to screen
                            Write-Host ''                                                   # Write message to screen
                            $OpSelect = Read-Host '[Y] Yes [N] No'                          # Operator selection to enable floating IP
                            if ($OpSelect -eq 'y') {                                        # If $OpSelect equals 'y'
                                $EnableFloatingIP = 'y'                                     # Sets $EnableFloatingIP
                            }                                                               # End if ($OpSelect -eq 'y')
                            else {                                                          # All other inputs for $OpSelect
                                $EnableFloatingIP = 'n'                                     # Sets $EnableFloatingIP
                            }                                                               # End else (if ($OpSelect -eq 'y'))
                        }                                                                   # End if ($LBNatRulePort -ne $LBNatRuleTargetPort)
                        Break NewAzureLBNatRulePort                                         # Breaks :NewAzureLBNatRulePort        
                    }                                                                       # End if ($OpConfirm -eq 'y')
                }                                                                           # End if ($LBNatRulePort)
                else {                                                                      # Else if $LBNatRulePort is $null
                    Write-Host 'That was not a valid input'                                 # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Clear-Host                                                              # Clears screen
                }                                                                           # End else (if ($LBNatRulePort))
            }                                                                               # End :NewAzureLBNatRulePort while ($true)
            Write-Host 'Changing the nat rule port'                                         # Write message to screen
            Try {                                                                           # Try the following
                if (($LBNatRule.EnableFloatingIP -eq $true -or $EnableFloatingIP -eq 'y') `
                    -and $LBNatRule.EnableTCPReset -eq $true) {                             # If ($LBNatRule.EnableFloatingIP equals true or $EnableFloatingIP equals 'y') and .EnableTCPReset equal $true
                    Set-AzLoadBalancerInboundNatRuleConfig `
                        -LoadBalancer $LoadBalancerObject `
                        -Name $LBNatRule.Name `
                        -FrontendIpConfigurationId `
                        $LBNatRule.FrontendIpConfiguration.ID `
                        -Protocol $LBNatRule.Protocol `
                        -FrontendPort $LBNatRulePort `
                        -BackendPort $LBNatRuleTargetPort `
                        -IdleTimeoutInMinutes  $LBNatRule.IdleTimeoutInMinutes `
                        -EnableFloatingIP `
                        -EnableTcpReset `
                        -ErrorAction 'Stop' | Out-Null                                      # Changes the nat rule port config
                }                                                                           # End if (($LBNatRule.EnableFloatingIP -eq $true -or $EnableFloatingIP -eq 'y') -and $LBNatRule.EnableTCPReset -eq $true)
                elseif (($LBNatRule.EnableFloatingIP -eq $false `
                    -or $EnableFloatingIP -eq 'n') -and `
                    $LBNatRule.EnableTCPReset -eq $true) {                                  # If $LBNatRule.EnableTCPReset equals $true
                    Set-AzLoadBalancerInboundNatRuleConfig `
                        -LoadBalancer $LoadBalancerObject `
                        -Name $LBNatRule.Name `
                        -FrontendIpConfigurationId `
                        $LBNatRule.FrontendIpConfiguration.ID `
                        -Protocol $LBNatRule.Protocol `
                        -FrontendPort $LBNatRulePort `
                        -BackendPort $LBNatRuleTargetPort `
                        -IdleTimeoutInMinutes  $LBNatRule.IdleTimeoutInMinutes `
                        -EnableTcpReset `
                        -ErrorAction 'Stop' | Out-Null                                      # Changes the nat rule port config
                }                                                                           # End elseif (($LBNatRule.EnableFloatingIP -eq $false -or $EnableFloatingIP -eq 'n') -and $LBNatRule.EnableTCPReset -eq $true)
                elseif (($LBNatRule.EnableFloatingIP -eq $true -or `
                    $EnableFloatingIP -eq 'y') -and `
                    $LBNatRule.EnableTCPReset -eq $false) {                                 # If $LBNatRule.EnableFloatingIP equals true or $EnableFloatingIP equals 'y'
                    Set-AzLoadBalancerInboundNatRuleConfig `
                        -LoadBalancer $LoadBalancerObject `
                        -Name $LBNatRule.Name `
                        -FrontendIpConfigurationId `
                        $LBNatRule.FrontendIpConfiguration.ID `
                        -Protocol $LBNatRule.Protocol `
                        -FrontendPort $LBNatRulePort `
                        -BackendPort $LBNatRuleTargetPort `
                        -IdleTimeoutInMinutes  $LBNatRule.IdleTimeoutInMinutes `
                        -EnableFloatingIP `
                        -ErrorAction 'Stop' | Out-Null                                      # Changes the nat rule port config
                }                                                                           # End elseif (($LBNatRule.EnableFloatingIP -eq $true -or $EnableFloatingIP -eq 'y') -and $LBNatRule.EnableTCPReset -eq $false)
                else {                                                                      # Else if $LBNatRule.EnableFloatingIP and .EnableTCPReset equal $fals
                    Set-AzLoadBalancerInboundNatRuleConfig `
                        -LoadBalancer $LoadBalancerObject `
                        -Name $LBNatRule.Name `
                        -FrontendIpConfigurationId `
                        $LBNatRule.FrontendIpConfiguration.ID `
                        -Protocol $LBNatRule.Protocol `
                        -FrontendPort $LBNatRulePort `
                        -BackendPort $LBNatRuleTargetPort `
                        -IdleTimeoutInMinutes  $LBNatRule.IdleTimeoutInMinutes `
                        -ErrorAction 'Stop' | Out-Null                                      # Changes the nat rule port config
                }                                                                           # End else (if (($LBNatRule.EnableFloatingIP -eq $true -or $EnableFloatingIP -eq 'y') -and $LBNatRule.EnableTCPReset -eq $true))
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
}                                                                                           # End function SetAzLBNatRulePort
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
function SetAzLBNatRuleVM {                                                                 # Function to associate a VM to a nat rule
    Begin {                                                                                 # Begin function
        if (!$CallingFunction) {                                                            # If $CallingFunction is $null
            $CallingFunction  = 'SetAzLBNatRuleVM'                                          # Creates $CallingFunction
        }                                                                                   # End if (!$CallingFunction)
        :SetAzureLBNatRuleVM while ($true) {                                                # Outer loop for managing function
            $LBNatRule, $LoadBalancerObject = GetAzLBNatRuleConfig ($CallingFunction)       # Calls function and assigns output to $var
            if (!$LBNatRule) {                                                              # If $LBNatRule is $null
                Break SetAzureLBNatRuleVM                                                   # Breaks :SetAzureLBNatRuleVM
            }                                                                               # End if (!$LBNatRule)
            $NicIPConfigObject,$NicObject = GetAzNICIpConfig ($CallingFunction)             # Calls function and assigns output to $var
            if (!$NicIPConfigObject) {                                                      # If $NicIPConfigObject is $null
                Break SetAzureLBNatRuleVM                                                   # Breaks :SetAzureLBNatRuleVM
            }                                                                               # End if (!$NicIPConfigObject)
            if (!$NicObject.VirtualMachine.ID) {                                            # If $NicObject.VirtualMachine.ID is $null
                Write-Host 'The selecting NIC config does not have an associated VM'        # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break SetAzureLBNatRuleVM                                                   # Breaks :SetAzureLBNatRuleVM
            }                                                                               # End if (!$NicObject.VirtualMachine.ID)
            if ($NicIPConfigObject.ID -in $LBNatRule.BackendIPConfiguration.ID) {           # If ($NicIPConfigObject.ID is in $LBNatRule.BackendIPConfiguration.ID
                Write-Host 'That IP config is already associated to this rule'              # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break SetAzureLBBEPoolVM                                                    # Breaks :SetAzureLBBEPoolVM    
            }                                                                               # End if ($NicIPConfigObject.ID -in $LBNatRule.BackendIPConfiguration.ID)
            $VMName = $NicObject.VirtualMachine.ID.Split('/')[-1]                           # Isloates the VM name
            Write-Host 'Make the following change:'                                         # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            Write-Host 'Add'                                                                # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            Write-Host 'VM Name:      '$VMName                                              # Write message to screen
            Write-Host 'Nic Name:     '$NicObject.name                                      # Write message to screen
            Write-Host 'Config Name:  '$NicIPConfigObject.Name                              # Write message to screen
            Write-Host 'Private IP:   '$NicIPConfigObject.PrivateIPAddress                  # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            Write-Host 'To'                                                                 # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            Write-Host 'Load Balancer:'$LoadBalancerObject.name                             # Write message to screen
            Write-Host 'Nat Rule:     '$LBNatRule.name                                      # Write message to screen
            Write-Host 'Nat Protocol: '$LBNatRule.Protocol                                  # Write message to screen
            Write-Host 'Nat FE Port:  '$LBNatRule.FrontendPort                              # Write message to screen
            Write-Host 'Nat BE Port:  '$LBNatRule.BackendPort                               # Write message to screen
            Write-Host 'Nat Idle TO:  '$LBNatRule.IdleTimeoutInMinutes                      # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            $OpConfirm = Read-Host '[Y] Yes [N] No'                                         # Operator confirmation to make the change
            Clear-Host                                                                      # Clears screen
            if ($OpConfirm -eq 'y') {                                                       # If $OpConfirm equals 'y'
                Try {                                                                       # Try the following
                    Write-Host 'Adding the IP config to nat rule'                           # Write message to screen
                    $NicObject | Set-AzNetworkInterfaceIpConfig -Name `
                        $NicIPConfigObject.Name -LoadBalancerInboundNatRuleId `
                        $LBNatRule.ID -ErrorAction 'Stop' | Out-Null                        # Adds the load balancer inbound nat rule
                }                                                                           # End Try
                catch {                                                                     # If Try fails
                    Clear-Host                                                              # Clears screen
                    Write-Host 'An error has occured'                                       # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Break SetAzureLBNatRuleVM                                               # Breaks :SetAzureLBNatRuleVM
                }                                                                           # End catch
                Write-Host 'Saving nic configuration'                                       # Write message to screen
                $NicObject | Set-AzNetworkInterface                                         # Saves the nic config
                Clear-Host                                                                  # Clears screen
                Write-Host 'The changes have been made'                                     # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break SetAzureLBNatRuleVM                                                   # Breaks :SetAzureLBNatRuleVM
            }                                                                               # End if ($OpConfirm -eq 'y') 
            else {                                                                          # All other inputs for $OpSelect
                Write-Host 'No changes have been made'                                      # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break SetAzureLBNatRuleVM                                                   # Breaks :SetAzureLBNatRuleVM
            }                                                                               # End else (if ($OpConfirm -eq 'y'))
        }                                                                                   # End :SetAzureLBNatRuleVM while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function SetAzLBNatRuleVM
function RemoveAzLBNatRuleVM {                                                              # Function to change to remove a VM from exist nat rule
    Begin {                                                                                 # Begin function
        if (!$CallingFunction) {                                                            # If $CallingFunction is $null
            $CallingFunction = 'RemoveAzLBNatRuleVM'                                        # Creates $CallingFunction
        }                                                                                   # End if (!$CallingFunction)
        :SetAzureLBNatRule while ($true) {                                                  # Outer loop for managing function
            $LBNatRule, $LoadBalancerObject = GetAzLBNatRuleConfig ($CallingFunction)       # Calls function and assigns output to $var
            if (!$LBNatRule) {                                                              # If $LBNatRule is $null
                Break SetAzureLBNatRule                                                     # Breaks :SetAzureLBNatRule
            }                                                                               # End if (!$LBNatRule)
            if (!$LBNatRule.BackendIPConfiguration.ID) {                                    # If $LBNatRule.BackendIPConfiguration.ID is $null
                Write-Host 'No target VM is associated to this nat rule'                    # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Write-Host 'No changes have been made'                                      # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break SetAzureLBNatRule                                                     # Breaks :SetAzureLBNatRule
            }                                                                               # End if (!$LBNatRule.BackendIPConfiguration.ID) 
            Write-Host 'Gathering additional information'                                   # Write message to screen
            Write-Host 'This may take a moment'                                             # Write message to screen
            $NicIPConfigID = $LBNatRule.BackendIPConfiguration.ID                           # Isolates $LBNatRule.BackendIPConfiguration.ID
            $NicIPConfigName = $NicIPConfigID.Split('/')[-1]                                # Isolates the nic IP config name
            $NicName = $NicIPConfigID.Split('/')[8]                                         # Isolates the nic name
            $NicObject = Get-AzNetworkInterface -Name $NicName                              # Gets the network interface
            $NicIPConfigObject = Get-AzNetworkInterfaceIpConfig -NetworkInterface `
                $NicObject -Name $NicIPConfigName                                           # Gets the nic ip configuration
            $VMObject = Get-AzVM | Where-Object `
                {$_.NetworkProfile.NetworkInterfaces.ID -eq $NicObject.ID}                  # Gets the target VM
            Clear-Host                                                                      # Clears screen
            Write-Host 'Remove'                                                             # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            Write-Host 'VM name:  '$VMObject.Name                                           # Write message to screen
            if ($VMObject.OSProfile.LinuxConfiguration) {                                   # If $VMObject.OSProfile.LinuxConfiguration has a value
                Write-Host 'VM OS:     Linux'                                               # Write message to screen
            }                                                                               # End if ($VMObject.OSProfile.LinuxConfiguration)
            else {                                                                          # Else if $VMObject.OSProfile.LinuxConfiguration is $null
                Write-Host 'VM OS:     Windows'                                             # Write message to screen
            }                                                                               # End else (if ($VMObject.OSProfile.LinuxConfiguration))
            Write-Host 'Nic name: '$NicObject.Name                                          # Write message to screen
            Write-Host 'IP Config:'$NicIPConfigObject.Name                                  # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            Write-Host 'From'                                                               # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            Write-Host 'Nat Rule: '$LBNatRule.Name                                          # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            $OpConfirm = Read-Host '[Y] Yes [N] No'                                         # Operator confrimation to change the nat rule target VM
            Clear-Host                                                                      # Clears screen
            if ($OpConfirm -eq 'y') {                                                       # If $OPConfirm equals 'y'    
                Write-Host 'Removing the VM from nat rule'                                  # Write message to screen
                Try {                                                                       # Try the following
                    $NicObject | Set-AzNetworkInterfaceIpConfig -Name `
                    $NicIPConfigObject.Name -LoadBalancerInboundNatRuleId `
                    $null -ErrorAction 'Stop' | Out-Null                                    # Adds the load balancer inbound nat rule
                }                                                                           # End try
                Catch {                                                                     # If try fails
                    Clear-Host                                                              # Clears screen
                    Write-Host 'An error has occured'                                       # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Break SetAzureLBNatRule                                                 # Breaks :SetAzureLBNatRule
                }                                                                           # End catch
                Write-Host 'Saving nic configuration'                                       # Write message to screen
                $NicObject | Set-AzNetworkInterface                                         # Saves the nic config
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
}                                                                                           # End function RemoveAzLBNatRuleVM
function RemoveAzLBNatRuleConfig {                                                          # Function to remove a load balancer nat rule configuration
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
# Addition functions required for ManageAzLBNatRuleConfig
function GetAzLBFEConfig {                                                                  # Function to get a load balancer front end config
    Begin {                                                                                 # Begin function
        :GetAzureLBFEConfig while ($true) {                                                 # Outer loop for managing function
            Write-Host 'Gathering load balancer info'                                       # Write message to screen
            Write-Host 'This may take a moment'                                             # Write message to screen
            $ObjectList = Get-AzLoadBalancer                                                # Gets a list of all load balancers
            if (!$ObjectList) {                                                             # If $ObjectList is $null
                Clear-Host                                                                  # Clears screen
                Write-Host 'There are no load balancers in this subscription'               # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break GetAzureLBFEConfig                                                    # Breaks GetAzureLBFEConfig
            }                                                                               # if (!$ObjectList)
            [System.Collections.ArrayList]$ObjectArray = @()                                # Creates object list array
            $ObjectNumber = 1                                                               # Creates $ObjectNumber
            foreach ($_ in $ObjectList) {                                                   # For each item in $ObjectList
                Write-Host 'Gathering info on:'$_.name                                      # Write message to screen
                $LoadBalancerObject = Get-AzLoadBalancer -Name $_.Name                      # Gets the current load balancer object
                $ObjectList2 = Get-AzLoadBalancerFrontendIpConfig -LoadBalancer `
                    $LoadBalancerObject                                                     # Gets the configs of the current load balancer
                foreach ($_ in $ObjectList2) {                                              # For each item in $ObjectList2
                    if ($_.Subnet.ID) {                                                     # If current item .subnet.id has a value
                        $SubnetID = $_.Subnet.ID                                            # Isolates the subnet ID
                        $SubnetID = $SubnetID.Split('/')[-1]                                # Isolates the subnet name
                    }                                                                       # End if ($_.Subnet.ID)
                    if ($_.PublicIPAddress.ID) {                                            # If current item .PublicIPAddress.ID 
                        $PublicIPID = $_.PublicIPAddress.ID                                 # Isolates the public IP ID 
                        $PublicIPObject = Get-AzPublicIpAddress | Where-Object `
                            {$_.ID -eq $PublicIPID}                                         # Gets the public IP object
                    }                                                                       # End if ($_.PublicIPAddress.ID)
                    $ObjectInput = [PSCustomObject]@{                                       # Custom object to be added to $ObjectArray
                        'Number'=$ObjectNumber;`
                        'Name'=$_.Name;'PriIP'=$_.PrivateIpAddress;`
                        'PriIP2'=$_.PrivateIpAllocationMethod;'Sub'=$SubnetID;`
                        'PubIP'=$PublicIPObject.IpAddress;`
                        'PubIP2'=$PublicIPObject.PublicIpAllocationMethod;`
                        'PubIP3'=$PublicIPObject.Sku.Name;'LB'=$LoadBalancerObject.Name     # Creates the item to loaded into array
                    }                                                                       # End $ObjectInput = [PSCustomObject]@
                    $ObjectArray.Add($ObjectInput) | Out-Null                               # Loads item into array, out-null removes write to screen
                    $SubnetID = $null                                                       # Clears $SubnetID
                    $PublicIPID = $null                                                     # Clears $PublicIPID
                    $PublicIPObject = $null                                                 # Clears $PublicIPObject
                    $ObjectNumber = $ObjectNumber + 1                                       # Increments $ObjectNumber up by 1
                }                                                                           # End foreach ($_ in $ObjectList2)
            }                                                                               # End foreach ($_ in $ObjectList)
            Clear-Host                                                                      # Clears screen
            :SelectAzureLBFEConfig while ($true) {                                          # Inner loop for selecting the front end config
                Write-Host '[0]          Exit'                                              # Write message to screen
                Write-Host ''                                                               # Write message to screen    
                foreach ($_ in $ObjectArray) {                                              # For each item in $ObjectArray
                    $Number = $_.Number                                                     # $Number is equal to current item .Number
                    if ($Number -le 9) {                                                    # If $number is 9 or less
                        Write-Host "[$number]         "$_.Name                              # Write message to screen
                    }                                                                       # End if ($Number -le 9)
                    else {                                                                  # Else if $number is more than 9
                        Write-Host "[$number]       "$_.Name                                # Write message to screen
                    }                                                                       # End else (if ($Number -le 9))
                    Write-Host 'LB Name:    '$_.LB                                          # Write message to screen
                    if ($_.PubIP) {                                                         # If current item .PubIP has a value
                        Write-host 'Config Type: Public'                                    # Write message to screen
                        Write-Host 'IP Address: '$_.PubIP                                   # Write message to screen
                        Write-Host 'Allocation: '$_.PubIP2                                  # Write message to screen
                        Write-Host 'Sku Name:   '$_.PubIP3                                  # Write message to screen
                    }                                                                       # End if ($_.PubIP)
                    else {                                                                  # Else if current item .PubIP is $null
                        Write-host 'Config Type: Private'                                   # Write message to screen
                        if ($_.PriIP) {                                                     # if current item .priIP has a value
                            Write-Host 'IP Address: '$_.PriIP                               # Write message to screen
                        }                                                                   # End if ($_.PriIP)
                        Write-Host 'Allocation: '$_.PriIP2                                  # Write message to screen
                        Write-Host 'Subnet:     '$_.Sub                                     # Write message to screen
                    }                                                                       # End else (if ($_.PubIP))
                    Write-Host ''                                                           # Write message to screen
                }                                                                           # End foreach ($_ in $ObjectArray)
                if ($CallingFunction) {                                                     # If $CallingFunction has a value
                    Write-Host `
                        'You are selecting the front end config for:'$CallingFunction       # Write message to screen
                }                                                                           # End if ($CallingFunction)
                $OpSelect = Read-Host 'Option [#]'                                          # Operator input to select the front end config
                Clear-Host                                                                  # Clears screen
                if ($OpSelect -eq '0') {                                                    # If $OpSelect equals '0'
                    Break GetAzureLBFEConfig                                                # Breaks :GetAzureLBFEConfig
                }                                                                           # End if ($OpSelect -eq '0')
                elseif ($OpSelect -in $ObjectArray.Number) {                                # If $OpSelect in $ObjectArray.Number
                    $OpSelect = $ObjectArray | Where-Object {$_.Number -eq $OpSelect}       # $OpSelect is equal to ObjectArray where $ObjectArray.Number equals $OpSelect
                    $LoadBalancerObject = Get-AzLoadBalancer -Name $OpSelect.LB             # Gets the load balancer object
                    $FrontEndIPConfigObject = Get-AzLoadBalancerFrontendIpConfig `
                        -LoadBalancer $LoadBalancerObject -Name $OpSelect.Name              # Gets the front end IP config object
                    Return $FrontEndIPConfigObject,$LoadBalancerObject                      # Returns to calling function with $vars
                }                                                                           # End elseif ($OpSelect -in $ObjectArray.Number)
                else {                                                                      # All other inputs for $OpSelect
                    Write-Host 'That was not a valid input'                                 # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Clear-Host                                                              # Clears screen
                }                                                                           # End else if ($OpSelect -eq '0')
            }                                                                               # End :SelectAzureLBFEConfig while ($true)
        }                                                                                   # End :GetAzureLBFEConfig while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function GetAzLBFEConfig
function GetAzNICIpConfig {                                                                 # Function to get network interface config
    Begin {                                                                                 # Begin function
        :GetAzureNICIpConfig while ($true) {                                                # Outer loop for managing function
            $ObjectNumber = 1                                                               # Creates $ObjectNumber
            [System.Collections.ArrayList]$ObjectArray = @()                                # Array that all info is loaded into
            Write-Host 'Gathering network interfaces'                                       # Write message to screen
            $ObjectList = Get-AzNetworkInterface                                            # Gets a list of all NICs
            if (!$ObjectList) {                                                             # If $ObjectList is $null
                Clear-Host                                                                  # Clears screen
                Write-Host 'No Nics are present in this subscription'                       # Write message to screen
                Write-Host ''                                                               # Write message to screen
            }                                                                               # End if (!$ObjectList)
            else {                                                                          # If $ObjectList has a value
                foreach ($_ in $ObjectList) {                                               # For each item in $ObjectList
                    $NICName = $_.Name                                                      # $NICName is equal to current item .Name
                    $NicRG = $_.ResourceGroupName                                           # Gets the NIC resource group
                    $NicVM = $_.VirtualMachine.ID                                           # Gets the NIC VM if attached
                    if ($NicVM) {                                                           # If $NicVM has a value 
                        $VMObject = Get-AzVM | Where-Object {$_.ID -eq $NICVM}              # Gets the currently attached VM
                    }                                                                       # End if ($NicVM)
                    $IPConfigList = $_.IPConfigurations                                     # IPConfigList is equal to current item .IPConfigurations
                    foreach ($_ in $IPConfigList) {                                         # For each item in $IPConfigList
                        $ObjectInput = [PSCustomObject]@{                                   # Creates $ObjectInput            
                            'Number'=$ObjectNumber;'Name'=$_.Name;`
                            'PrivIP'=$_.PrivateIPAddress;`
                            'PrivIPAllo'=$_.PrivateIpAllocationMethod;`
                            'PubIP'=$_.PublicIPAddress;'Pri'=$_.Primary;`
                            'NICName'=$NICName;'NICRG'=$NicRG;'NICVM'=$VMObject.Name        # Collects the information for the array
                        }                                                                   # End $ObjectInput = [PSCustomObject]
                        $ObjectArray.Add($ObjectInput) | Out-Null                           # Loads item into array, out-null removes write to screen
                        $ObjectNumber = $ObjectNumber +1                                    # Increments $ObjectNumber up by 1
                    }                                                                       # End foreach ($_ in $IPConfigList)
                    $NICName = $null                                                        # Clears $var
                    $NicRG = $null                                                          # Clears $var
                    $NicVM = $null                                                          # Clears $var
                    $VMObject = $null                                                       # Clears $var
                }                                                                           # End foreach ($_ in $ObjectList)
            }                                                                               # End else (if (!$ObjectList))
            Write-Host 'Gathering scale set interfaces'                                     # Write message to screen
            $VmssObject = Get-AzVmss                                                        # Gets a list of Vmss objects if present
            if ($VmssObject) {                                                              # If $VmssObject has a value
                foreach ($_ in $VmssObject) {                                               # For each item in $VmssObject
                    Write-Host 'Gathering NICs on:'$_.name                                  # Writ message to screen
                    $VmssName = $_.name                                                     # Isloates the Vmss name
                    $VmssRG = $_.ResourceGroupName                                          # Isolates the Vmss resource group
                    $NicList = Get-AzNetworkInterface -VirtualMachineScaleSetName `
                        $VmssName -ResourceGroupName $VmssRG                                # Gets a list of nics attached to current vmss object
                    foreach ($_ in $NicList) {                                              # For each item in $NicList
                        $NicName = $_.Name                                                  # $NicName is equal to current item .Name
                        $NicRG = $_.ResourceGroupName                                       # $NicRG is equal to current item .ResourceGroupName
                        $IPConfigList = $_.IPConfigurations                                 # IPConfigList is equal to current item .IPConfigurations
                        foreach ($_ in $IPConfigList) {                                     # For each item in $IPConfigList
                            $ObjectInput = [PSCustomObject]@{                               # Creates $ObjectInput            
                                'Number'=$ObjectNumber;'Name'=$_.Name;`
                                'PrivIP'=$_.PrivateIPAddress;`
                                'PrivIPAllo'=$_.PrivateIpAllocationMethod;`
                                'PubIP'=$_.PublicIPAddress;'Pri'=$_.Primary;`
                                'NICName'=$NICName;'NICRG'=$NicRG;'NICVM'=$VMObject.Name;`
                                'Type'='ScaleSetNic';'VmssName'=$VmssName;'VmssRG'=$VmssRG;`
                                'Etag'=$_.Etag                                              # Collects the information for the array
                            }                                                               # End $ObjectInput = [PSCustomObject]
                            $ObjectArray.Add($ObjectInput) | Out-Null                       # Loads item into array, out-null removes write to screen
                            $ObjectNumber = $ObjectNumber +1                                # Increments $ObjectNumber up by 1
                        }                                                                   # End foreach ($_ in $IPConfigList)
                    }                                                                       # End foreach ($_ in $NicList)
                }                                                                           # End foreach ($_ in $VmssObject)
            }                                                                               # End if ($VmssObject)
            else {                                                                          # If $VmssObject is $null
                Clear-Host 'No scale sets present in this subscription'                     # Write message to screen
            }                                                                               # End else (if ($VmssObject))
            if (!$ObjectArray) {                                                            # If $ObjectArray is $null
                Clear-Host                                                                  # Clears screen
                Write-Host 'No network interfaces or scale set interfaces are present'      # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break GetAzureNICIpConfig                                                   # Breaks :GetAzureNICIpConfig
            }                                                                               # End if (!$ObjectArray)
            :SelectAzureNICIpConfig while ($true) {                                         # Inner loop for selecting the NIC IP config
                Clear-Host                                                                  # Clears screen
                Write-Host ''                                                               # Write message to screen
                Write-Host '[0]   Exit'                                                     # Write message to screen
                Write-Host ''                                                               # Write message to screen
                foreach ($_ in $ObjectArray) {                                              # For each item in $ObjectArray
                    $Number = $_.Number                                                     # $Number is equal to current item .Number
                    if ($Number -le 9) {                                                    # If $Number is 9 or less
                        Write-Host "[$Number]                   "$_.Name                    # Write message to screen
                    }                                                                       # End if ($Number -le 9)
                    else {                                                                  # If $Number is more than 9
                        Write-Host "[$Number]                  "$_.Name                     # Write message to screen
                    }                                                                       # End else (if ($Number -le 9))
                    Write-Host 'Private IP Address:   '$_.PrivIP                            # Write message to screen 
                    Write-Host 'Private IP Allocation:'$_.PrivIPAllo                        # Write message to screen
                    if ($_.PubIP) {                                                         # If current item .PubIP has a value
                        $PubID = $_.PubIP.ID                                                # Isolates the public IP sku ID
                        $PubIP = Get-AzPublicIpAddress | Where-Object {$_.ID -eq $PubID}    # Gets the public IP sku
                        Write-Host 'Public IP Address:    '$PubIP.IpAddress                 # Write message to screen
                        Write-Host 'Public IP Allocation: '$PubIP.PublicIpAllocationMethod  # Write message to screen
                    }                                                                       # End if ($_.PubIP)
                    Write-Host 'Is primary:           '$_.Pri                               # Write message to screen
                    Write-Host 'Nic Name:             '$_.NicName                           # Write message to screen
                    if ($_.NICVM) {                                                         # If current item .NICVM has a value
                        Write-Host 'Attached VM:          '$_.NicVM                         # Write message to screen
                    }                                                                       # End if ($_.NICVM)
                    Write-Host ''                                                           # Write message to screen
                }                                                                           # End foreach ($_ in $ObjectArray)
                if ($CallingFunction) {                                                     # If $CallingFunction has a value
                    Write-Host 'You are selecting the IP config for:'$CallingFunction       # Write message to screen
                }                                                                           # End if ($CallingFunction)
                $OpSelect = Read-Host 'Option [#]'                                          # Operator input to select the network config
                Clear-Host                                                                  # Clears screen
                if ($OpSelect -eq '0') {                                                    # If $OpSelect equals '0'
                    Break GetAzureNICIpConfig                                               # Breaks :GetAzureNICIpConfig
                }                                                                           # End if ($OpSelect -eq '0')
                elseif ($OpSelect -in $ObjectArray.Number) {                                # Else if $OpSelect in $ObjectArray.Name
                    $OpSelect = $ObjectArray | Where-Object {$_.Number -eq $OpSelect}       # $ObjectSelect is equal to $ObjectArray where $ObjectArray.Number equals $OpSelect
                    if ($OpSelect.Type -eq 'ScaleSetNic') {                                 # If $OpSelect.Type equals 'ScaleSetNic'
                        $NicObject = Get-AzNetworkInterface -VirtualMachineScaleSetName `
                            $OpSelect.VmssName -ResourceGroupName $OpSelect.VmssRG          # Gets the $NicObject
                        $NicIPConfigObject = $NicObject.IpConfigurations | Where-Object `
                        {$_.Etag -eq $OpSelect.Etag}                                        # Isolates NicIPConfigObject
                    }                                                                       # End if ($OpSelect.Type -eq 'ScaleSetNic')
                    else {                                                                  # Else if $OpSelect.Type does not equal 'ScaleSetNic'
                        $NicObject = Get-AzNetworkInterface -Name $OpSelect.NicName `
                            -ResourceGroupName $OpSelect.NicRG                              # Gets the $NicObject
                        $NicIPConfigObject = Get-AzNetworkInterfaceIpConfig `
                            -NetworkInterface $NicObject -Name $OpSelect.Name               # Gets the NicIPConfigObject
                    }                                                                       # End else (if ($OpSelect.Type -eq 'ScaleSetNic'))
                    Return $NicIPConfigObject,$NicObject                                    # Returns to calling function with $vars
                }                                                                           # End elseif ($OpSelect -in $ObjectArray.Number)
                else {                                                                      # All other inputs for $OpSelect
                    Write-Host 'That was not a valid input'                                 # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                }                                                                           # End else (if ($OpSelect -eq '0'))
            }                                                                               # End :SelectAzureNICIpConfig while ($true)
        }                                                                                   # End :GetAzureNICIpConfig while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function GetAzNICIpConfig