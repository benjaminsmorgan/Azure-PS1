# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Mircosoft docs links
    Get-AzLoadBalancer:                         https://docs.microsoft.com/en-us/powershell/module/az.network/get-azloadbalancer?view=azps-5.5.0 
    Add-AzLoadBalancerRuleConfig:               https://docs.microsoft.com/en-us/powershell/module/az.network/add-azloadbalancerruleconfig?view=azps-6.1.0
    Set-AzLoadBalancer:                         https://docs.microsoft.com/en-us/powershell/module/az.network/set-azloadbalancer?view=azps-6.1.0
    Get-AzLoadBalancerFrontendIpConfig:         https://docs.microsoft.com/en-us/powershell/module/az.network/get-azloadbalancerfrontendipconfig?view=azps-6.0.0
    Get-AzPublicIpAddress:                      https://docs.microsoft.com/en-us/powershell/module/az.network/get-azpublicipaddress?view=azps-5.5.0
    Get-AzLoadBalancerBackendAddressPool:       https://docs.microsoft.com/en-us/powershell/module/az.network/get-azloadbalancerbackendaddresspool?view=azps-6.1.0
    Get-AzNetworkInterface:                     https://docs.microsoft.com/en-us/powershell/module/az.network/get-aznetworkinterface?view=azps-6.1.0
    Get-AzNetworkInterfaceIpConfig:             https://docs.microsoft.com/en-us/powershell/module/az.network/get-aznetworkinterfaceipconfig?view=azps-6.1.0
    Get-AzVM:                                   https://docs.microsoft.com/en-us/powershell/module/az.compute/get-azvm?view=azps-6.1.0
    Get-AzLoadBalancerProbeConfig:              https://docs.microsoft.com/en-us/powershell/module/az.network/get-azloadbalancerprobeconfig?view=azps-6.1.0
} #>
<# Required Functions Links: {
    GetAzLoadBalancer:          https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/Load%20Balancer/GetAzLoadBalancer.ps1
    GetAzLBRuleFE:              https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/Load%20Balancer/Rule%20Config/GetAzLBRuleFE.ps1
    GetAzLBRuleBE:              https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/Load%20Balancer/Rule%20Config/GetAzLBRuleBE.ps1
    GetAzLBRuleProbe:           https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/Load%20Balancer/Rule%20Config/GetAzLBRuleProbe.ps1
} #>
<# Functions Description: {
    GetAzLoadBalancer:          Function to get an existing load balancer
    GetAzLBRuleFE:              Function to get a load balancer front end config for load balancer rule
    GetAzLBRuleBE:              Function to get an existing load balancer back end pool config for load balancer rule
    GetAzLBRuleProbe:           Function to get an existing load balancer probe config for load balancer rule
} #>
<# Variables: {      
    :AddAzureLBRule             Outer loop for managing function
    :SetAzureLBRuleBE           Inner loop for setting the rule back end pool
    :NewAzureLBRuleProtocol     Inner loop for setting the rule protocol
    :NewAzureLBRuleFEPort       Inner loop for setting the rule front end port
    :NewAzureLBRuleBEPort       Inner loop for setting the rule back end port
    :NewAzureLBRuleIdleTO       Inner loop for setting the rule time out
    $CallingFunction:           Name of this function or the one that called it
    $LoadBalancerObject:        Load balancer object
    $VName1st:                  Array of value rule name 1st characters
    $VNameElse:                 Array of value rule name characters
    $VNameLast:                 Array of value rule name last characters
    $LBRuleName:                Operator input for the rule name
    $LBRuleArray:               $LBRuleName converted to array
    $OpConfirm:                 Operator confirmation of values
    $LBFEObject:                Load balancer front end config object
    $OpSelect:                  Operator selection of options
    $LBBackEndObject:           Load balancer back end config object
    $LBProbeObject:             Load balancer probe config object
    $LBRuleProtocolObject:      Rule protocol object 
    $ValidArray:                Array of valid characters for ports and time out
    $LBRuleFrontEndPort:        Rule front end port object
    $LBRuleArray:               $LBRuleFrontEndPort/$LBRuleBackEndPort converted to array
    $LBRuleBackEndPort:         Rule back end port object
    $LBRuleIdleTO:              Rule idle timeout
    $LBRuleIdleTOInt:           $LBRuleIdleTO converted to interger
    GetAzLoadBalancer{}         Gets $LoadBalancerObject
    GetAzLBRuleFE{}             Gets $LBFEObject
    GetAzLBRuleBE{}             Gets $LBBackEndObject
    GetAzLBRuleProbe{}          Gets $LBProbeObject
} #>
<# Process Flow {
    function
        Call AddAzLBRuleConfig > Get $null
            Call GetAzLoadBalancer > Get $LoadBalancerObject
            End GetAzLoadBalancer
                Return AddAzLBRuleConfig > Send $LoadBalancerObject
            Call GetAzLBRuleFE > Get $LBFEObject
            End GetAzLBRuleFE
                Return AddAzLBRuleConfig > Send $LBFEObject
            Call GetAzLBRuleBE > Get $LBBackEndObject
            End GetAzLBRuleBE
                Return AddAzLBRuleConfig > Send $LBBackEndObject
            Call GetAzLBRuleProbe > Get $LBProbeObject
            End GetAzLBRuleProbe
                Return AddAzLBRuleConfig > Send $LBProbeObject
        End AddAzLBRuleConfig
            Return function > Send $null
}#>
function AddAzLBRuleConfig {                                                                # Funtion to add a new load balancer rule config
    Begin {                                                                                 # Begin function
        if (!$CallingFunction) {                                                            # If $CallingFunction is $null
            $CallingFunction = 'AddAzLBRuleConfig'                                          # Creates $CallingFunction
        }                                                                                   # End if (!$CallingFunction)
        :AddAzureLBRule while ($true) {                                                     # Outer loop for managing function
            $LoadBalancerObject = GetAzLoadBalancer ($CallingFunction)                      # Calls function and assigns output to $var
            if (!$LoadBalancerObject) {                                                     # If $LoadBalancerObject is $null
                Break AddAzureLBRule                                                        # Breaks :AddAzureLBRule
            }                                                                               # End if (!$LoadBalancerObject)
            if (!$LoadBalancerObject.Probes) {                                              # If $LoadBalancerObject.Probes is $null
                Write-Host 'No probes exist on this load balancer'                          # Write message to screen
                Write-Host 'Please create a probe configuration'                            # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break AddAzureLBRule                                                        # Breaks :AddAzureLBRule
            }                                                                               # End if (!$LoadBalancerObject.Probes)
            $VName1st = 'abcdefghijklmnopqrstuvwxyz0123456789'                              # Valid name first character
            $VName1st = $VName1st.ToCharArray()                                             # Converts $var to character array
            $VNameElse = 'abcdefghijklmnopqrstuvwxyz0123456789.-_'                          # Valid name body characters
            $VNameElse = $VNameElse.ToCharArray()                                           # Converts $var to character array
            $VNameLast = 'abcdefghijklmnopqrstuvwxyz0123456789_'                            # Valid name last character
            $VNameLast = $VNameLast.ToCharArray()                                           # Converts $var to character array
            :SetAzureLBRuleName while ($true) {                                             # Inner loop for setting the name
                Write-Host 'Back End name rules:'                                           # Write message to screen
                Write-Host 'The name can be up to 80 characters long'                       # Write message to screen
                Write-Host 'It must begin with a word character (A-9)'                      # Write message to screen
                Write-Host 'The name may contain word characters or . - _'                  # Write message to screen
                Write-Host 'It must end with a word character (A-9) or with _'              # Write message to screen
                Write-Host ''                                                               # Write message to screen
                if ($LoadBalancerObject.LoadBalancingRules) {                               # If $LoadBalancerObject.LoadBalancingRules has a value
                    Write-Host 'The following rule names are already in use'                # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    foreach ($_ in $LoadBalancerObject.LoadBalancingRules.Name) {           # For each item in $LoadBalancerObject.LoadBalancingRules.Name
                        Write-Host $_                                                       # Write message to screen
                    }                                                                       # End foreach ($_ in $LoadBalancerObject.LoadBalancingRules.Name)
                    Write-Host ''                                                           # Write message to screen
                }                                                                           # End if ($LoadBalancerObject.LoadBalancingRules)
                $LBRuleName = Read-Host 'Name'                                              # Operator input for the rule name
                $LBRuleArray = $LBRuleName.ToCharArray()                                    # Converts $var to character array
                Clear-Host                                                                  # Clears screen
                if ($LBRuleName.Length -gt 80) {                                            # If $LBRuleName.Length is greater than 80
                    Write-Host 'The input is to long and cannot be used'                    # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    $LBRuleName = $null                                                     # Clears $var
                }                                                                           # End if ($LBRuleName.Length -gt 80)
                if ($LBRuleArray[0] -notin $VName1st) {                                     # If 0 position of $LBRuleArray is not in $VName1st
                    Write-Host  $LBRuleArray[-1]' is not a valid character'                 # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    $LBRuleName = $null                                                     # Clears $LBRuleName
                }                                                                           # End if ($LBRuleArray[0] -notin $VName1st)
                foreach ($_ in $LBRuleArray) {                                              # For each item in $LBRuleArray
                    if ($_ -notin $VNameElse) {                                             # If current item is not in $VNameElse
                        if ($_ -eq ' ') {                                                   # If current item equals 'space'
                            Write-Host 'Rule name cannot include any spaces'                # Write message to screen
                            Write-Host ''                                                   # Write message to screen    
                        }                                                                   # End if ($_ -eq ' ')
                        else {                                                              # If current item is not equal to 'space'    
                            Write-Host $_' is not a valid character'                        # Write message to screen
                            Write-Host ''                                                   # Write message to screen
                        }                                                                   # End else (if ($_ -eq ' '))
                        $LBRuleName = $null                                                 # Clears $LBRuleName
                    }                                                                       # End if ($_ -notin $LBRuleArray)
                }                                                                           # End foreach ($_ in $LBNameArray)
                if ($LBRuleArray[-1] -notin $VNameLast) {                                   # If last position of $LBRuleArray is not in $VNameLast
                    Write-Host  $LBRuleArray[-1]' is not a valid character'                 # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    $LBRuleName = $null                                                     # Clears $LBRuleName
                }                                                                           # End if ($LBRuleArray[0] -notin $VNameLast)
                if ($LBRuleName -in $LoadBalancerObject.LoadBalancingRules.Name) {          # If $LBRuleName is in $LoadBalancerObject.LoadBalancingRules.Name
                    Write-Host 'That name is already in use'                                # Write message to screen
                    Write-Host 'Please choose a different name'                             # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    $LBRuleName = $null                                                     # Clears $LBRuleName    
                }                                                                           # End if ($LBRuleName -in $LoadBalancerObject.LoadBalancingRules.Name)
                if ($LBRuleName) {                                                          # If $LBRuleName has a value
                    Write-Host 'Use:'$LBRuleName' as the rule name'                         # Write message to screen
                    $OpConfirm = Read-Host '[Y] Yes [N] No [E] Exit'                        # Operator confirmation of the rule name
                    Clear-Host                                                              # Clears screen
                    if ($OpConfirm -eq 'e') {                                               # If $OpConfirm equals 'e'
                        Break AddAzureLBRule                                                # Breaks :AddAzureLBRule
                    }                                                                       # End if ($OpConfirm -eq 'e')
                    elseif ($OpConfirm -eq 'y') {                                           # Else if $OpConfirm equals 'y'
                        Break SetAzureLBRuleName                                            # Breaks :SetAzureLBRuleName
                    }                                                                       # End elseif ($OpConfirm -eq 'y')
                }                                                                           # End if ($LBRuleName)
                else {                                                                      # Else if $LBRuleName is $null
                    Pause                                                                   # Pauses all actions for operator input
                    Clear-Host                                                              # Clears screen
                }                                                                           # End else (if ($LBRuleName))
            }                                                                               # End :SetAzureLBRuleName while ($true)
            $LBFEObject = GetAzLBRuleFE ($CallingFunction, $LoadBalancerObject)             # Calls function and assigns output to $var
            if (!$LBFEObject) {                                                             # If $LBFEObject is $null
                Break AddAzureLBRule                                                        # Breaks :AddAzureLBRule
            }                                                                               # End if (!$LBFEObject)
            if ($LoadBalancerObject.BackendAddressPools) {                                  # If $LoadBalancerObject.BackendAddressPools has a value
                :SetAzureLBRuleBE while ($true) {                                           # Inner loop to set the back end pool
                    Write-Host 'Add a back end pool'                                        # Write message to screen
                    $OpSelect = Read-Host '[Y] Yes [N] No [E] Exit'                         # Operator input to select if back end to be added to rule 
                    Clear-Host                                                              # Clears screen
                    if ($OpSelect -eq 'e') {                                                # If $OpSelect equals 'e'
                        Break AddAzLBRuleConfig                                             # Breaks :AddAzLBRuleConfig
                    }                                                                       # End if ($OpSelect -eq 'e') 
                    elseif ($OpSelect -eq 'y') {                                            # Else if $OpSelect equals 'y'
                        $LBBackEndObject = GetAzLBRuleBE `
                            ($CallingFunction, $LoadBalancerObject)                         # Calls function and assigns output to $var
                        Break SetAzureLBRuleBE                                              # Breaks :SetAzureLBRuleBE
                    }                                                                       # End elseif ($OpSelect -eq 'y')
                    elseif ($OpSelect -eq 'n') {                                            # Else if $OpSelect equals 'n'
                        Break SetAzureLBRuleBE                                              # Breaks :SetAzureLBRuleBE
                    }                                                                       # End elseif ($OpSelect -eq 'n')
                    else {                                                                  # All other inputs for $OpSelect
                        Write-Host 'That was not a valid input'                             # Write message to screen
                        Write-Host ''                                                       # Write message to screen
                        Pause                                                               # Pauses all actions for operator input
                        Clear-Host                                                          # Clears screen
                    }                                                                       # End else (if ($OpSelect -eq 'e'))
                }                                                                           # End :SetAzureLBRuleBE while ($true)
            }                                                                               # End if ($LoadBalancerObject.BackendAddressPools) 
            $LBProbeObject = GetAzLBRuleProbe ($CallingFunction, $LoadBalancerObject)       # Calls function and assigns output to $var
            if (!$LBProbeObject) {                                                          # If $LBProbeObject is $null
                Break AddAzureLBRule                                                        # Breaks :AddAzureLBRule
            }                                                                               # End if (!$LBProbeObject)
            :NewAzureLBRuleProtocol while ($true) {                                         # Inner loop for setting the rule protocol
                Write-Host 'Load balancer rule protocol'                                    # Write message to screen
                Write-Host '[0] Exit'                                                       # Write message to screen
                Write-Host '[1] TCP'                                                        # Write message to screen
                Write-Host '[2] UDP'                                                        # Write message to screen
                Write-Host ''                                                               # Writes message to screen
                $OpSelect = Read-Host 'Option [#]'                                          # Operator input for the protocol object
                Clear-Host                                                                  # Clears screen
                if ($OpSelect -eq '0') {                                                    # If $OpSelect equals '0'
                    Break AddAzureLBRule                                              # Breaks :AddAzureLBRule
                }                                                                           # End if ($OpSelect -eq '0')
                elseif ($OpSelect -eq '1') {                                                # If $OpSelect equals '1'
                    $LBRuleProtocolObject = 'TCP'                                           # Sets $LBRuleProtocolObject to 'TCP'
                    Break NewAzureLBRuleProtocol                                            # Breaks :NewAzureLBRuleProtocol
                }                                                                           # End elseif ($OpSelect -eq '1')
                elseif ($OpSelect -eq '2') {                                                # If $OpSelect equals '2'
                    $LBRuleProtocolObject = 'UDP'                                           # Sets $LBRuleProtocolObject to 'UDP'
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
            :NewAzureLBRuleFEPort while ($true) {                                     # Inner loop for setting the rule front end port
                Write-Host 'Enter the rule pool front end port'                             # Write message to screen
                Write-Host ''                                                               # Writes message to screen
                $LBRuleFrontEndPort = Read-Host 'Port #'                                    # Operator input for the front end rule port 
                $LBRuleArray = $LBRuleFrontEndPort.ToCharArray()                            # Adds $LBRuleFrontEndPort to array
                Clear-Host                                                                  # Clears screen
                foreach ($_ in $LBRuleArray) {                                              # For each item in $LBRuleArray
                    if ($_ -notin $ValidArray) {                                            # If current item is not in $ValidArray
                        $LBRuleFrontEndPort = $null                                         # Clears $LBRuleFrontEndPort
                    }                                                                       # End if ($_ -notin $ValidArray)
                }                                                                           # End foreach ($_ in $LBRuleArray)
                $LBRuleArray = $null                                                        # Clears $LBRuleArray
                if ($LBRuleFrontEndPort) {                                                  # If $LBRuleFrontEndPort has a value
                    Write-Host 'Use:'$LBRuleFrontEndPort' as the front end pool rule port'  # Write message to screen
                    Write-Host ''                                                           # Writes message to screen
                    $OpConfirm = Read-Host '[Y] Yes [N] No [E] Exit'                        # Operator confirmation of the front end rule port
                    Clear-Host                                                              # Clears screen
                    if ($OpConfirm -eq 'e') {                                               # If $OpConfirm equals 'e'
                        Break AddAzureLBRule                                                # Breaks :AddAzureLBRule
                    }                                                                       # End if ($OpConfirm -eq 'e')
                    if ($OpConfirm -eq 'y') {                                               # If $OpConfirm equals 'y'
                        Break NewAzureLBRuleFEPort                                    # Breaks :NewAzureLBRuleFEPort        
                    }                                                                       # End if ($OpConfirm -eq 'y')
                }                                                                           # End if ($LBRuleFrontEndPort)
                else {                                                                      # Else if $LBRuleFrontEndPort is $null
                    Write-Host 'That was not a valid input'                                 # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Clear-Host                                                              # Clears screen
                }                                                                           # End else (if ($LBRuleFrontEndPort))
            }                                                                               # End :NewAzureLBRuleFEPort while ($true)
            :NewAzureLBRuleBEPort while ($true) {                                      # Inner loop for setting the rule back end port
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
                        Break AddAzureLBRule                                                # Breaks :AddAzureLBRule
                    }                                                                       # End if ($OpConfirm -eq 'e')
                    if ($OpConfirm -eq 'y') {                                               # If $OpConfirm equals 'y'
                        Break NewAzureLBRuleBEPort                                     # Breaks :NewAzureLBRuleBEPort        
                    }                                                                       # End if ($OpConfirm -eq 'y')
                }                                                                           # End if ($LBRuleBackEndPort)
                else {                                                                      # Else if $LBRuleBackEndPort is $null
                    Write-Host 'That was not a valid input'                                 # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Clear-Host                                                              # Clears screen
                }                                                                           # End else (if ($LBRuleBackEndPort))
            }                                                                               # End :NewAzureLBRuleBEPort while ($true)
            :NewAzureLBRuleIdleTO while ($true) {                                           # Inner loop for setting the rule idle timeout
                Write-Host 'Enter the idle time out in minutes for this rule'               # Write message to screen
                Write-Host ''                                                               # Writes message to screen
                $LBRuleIdleTO = Read-Host 'Idle timeout'                                    # Operator input for the rule idle timeout 
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
                    Write-Host 'Use:'$LBRuleIdleTO' as the rule idle time out'              # Write message to screen
                    Write-Host ''                                                           # Writes message to screen
                    $OpConfirm = Read-Host '[Y] Yes [N] No [E] Exit'                        # Operator confirmation of the idle timeout
                    Clear-Host                                                              # Clears screen
                    if ($OpConfirm -eq 'e') {                                               # If $OpConfirm equals 'e'
                        Break AddAzureLBRule                                                # Breaks :AddAzureLBRule
                    }                                                                       # End if ($OpConfirm -eq 'e')
                    if ($OpConfirm -eq 'y') {                                               # If $OpConfirm equals 'y'
                        Break NewAzureLBRuleIdleTO                                          # Breaks :NewAzureLBRuleIdleTO        
                    }                                                                       # End if ($OpConfirm -eq 'y')
                }                                                                           # End if ($LBRuleIdleTO)
                else {                                                                      # Else if $LBRuleIdleTO is $null
                    Pause                                                                   # Pauses all actions for operator input
                    Clear-Host                                                              # Clears screen
                }                                                                           # End else (if ($LBRuleIdleTO))
            }                                                                               # End :NewAzureLBRuleIdleTO while ($true)
            Try {                                                                           # Try the following
                Write-Host 'Creating the rule'                                              # Write message to screen
                if ($LBBackEndObject) {                                                     # If $LBBackEndObject has a value
                    Add-AzLoadBalancerRuleConfig -LoadBalancer $LoadBalancerObject `
                        -Name $LBRuleName -FrontendIpConfiguration $LBFEObject `
                        -BackendAddressPool $LBBackEndObject `
                        -Protocol $LBRuleProtocolObject -FrontendPort `
                        $LBRuleFrontEndPort -BackendPort $LBRuleBackEndPort `
                        -IdleTimeoutInMinutes $LBRuleIdleTO -Probe $LBProbeObject `
                        -ErrorAction 'Stop' | Out-Null                                      # Creates the rule
                }                                                                           # End if ($LBBackEndObject)
                else {                                                                      # Else if $LBBackEndObject is $null
                    Add-AzLoadBalancerRuleConfig -LoadBalancer $LoadBalancerObject `
                    -Name $LBRuleName -FrontendIpConfiguration $LBFEObject `
                    -Protocol $LBRuleProtocolObject -FrontendPort `
                    $LBRuleFrontEndPort -BackendPort $LBRuleBackEndPort `
                    -IdleTimeoutInMinutes $LBRuleIdleTO -Probe $LBProbeObject `
                    -ErrorAction 'Stop' | Out-Null                                          # Creates the rule
                }                                                                           # End else if ($LBBackEndObject)
                Write-Host 'Saving the changes'                                             # Write message to screen
                $LoadBalancerObject | Set-AzLoadBalancer -ErrorAction 'Stop' | Out-Null     # Saves the changes
            }                                                                               # End Try
            Catch {                                                                         # If Try fails
                Clear-Host                                                                  # Clears screen
                Write-Host 'An error has occured'                                           # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break AddAzureLBRule                                                        # Breaks :AddAzureLBRule
            }                                                                               # End catch
            Clear-Host                                                                      # Clears screen
            Write-Host 'The rule has been created'                                          # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            Pause                                                                           # Pauses all actions for operator input
            Break AddAzureLBRule                                                            # Breaks :AddAzureLBRule
        }                                                                                   # End :AddAzureLBRule while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function AddAzLBRuleConfig
function GetAzLoadBalancer {                                                                # Function to get an existing load balancer
    Begin {                                                                                 # Begin function
        :GetAzureLoadBalancer while ($true) {                                               # Outer loop to manage function
            Write-Host 'Gathering load balancer info'                                       # Write message to screen
            Write-Host 'This may take a moment'                                             # Write message to screen
            $ObjectList = Get-AzLoadBalancer                                                # Generates the load balancer list
            if (!$ObjectList) {                                                             # If $ObjectList is $null 
                Clear-Host                                                                  # Clears screen
                Write-Host 'No load balancers are in this subscription'                     # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break GetAzureLoadBalancer                                                  # Breaks GetAzureLoadBalancer
            }                                                                               # End if (!$ObjectList)
            $ObjectNumber = 1                                                               # Sets $ObjectNumber to 1
            [System.Collections.ArrayList]$ObjectArray = @()                                # Creates the load balancer array
            foreach ($_ in $ObjectList) {                                                   # For each item in $ObjectList
                if ($_.FrontendIpConfigurations.publicIPaddress.id) {                       # If the current item .FrontendIpConfigurations.publicIPaddress.id has a value
                    $PubIPID = $_.FrontendIpConfigurations.publicIPaddress.id               # Sets $PubIPID to the current item .FrontendIpConfigurations.publicIPaddress.id 
                    $PublicIPObject = Get-AzPublicIpAddress | Where-Object `
                        {$_.ID -eq $PubIPID}                                                # Pulls the attached public IP sku info
                }                                                                           # End if ($_.FrontendIpConfigurations.publicIPaddress.id)
                if ($_.BackendAddressPools.BackendIpConfigurations.id) {                    # If current item .BackendAddressPools.BackendIpConfigurations.id has a value
                    $VmssID = $_.BackendAddressPools.BackendIpConfigurations.id             # Isolates .BackendAddressPools.BackendIpConfigurations.id
                    $VmssRG = $VmssID.Split('/')[4]                                         # Isolates the Vmss resource group
                    $VmssName = $VmssID.Split('/')[8]                                       # Isolates the Vmss name
                }                                                                           # End if ($_.BackendAddressPools.BackendIpConfigurations.id)
                $ObjectInput = [PSCustomObject]@{                                           # Creates the item to loaded into array
                    'Number'=$ObjectNumber;'Name'=$_.Name;'RGName'=$_.ResourceGroupName;`
                    'LOC'=$_.Location;'Sku'=$_.Sku.Name;'PubAllocation'=`
                    $PublicIPObject.PublicIpAllocationMethod;`
                    'PubAddress'=$PublicIPObject.IpAddress;'Pubname'=$PublicIPObject.Name; `
                    'VmssName'=$VmssName;'VmssRG'=$VmssRG                                   # Gets current item info
                }                                                                           # End $ObjectInput = [PSCustomObject]@
                $ObjectArray.Add($ObjectInput) | Out-Null                                   # Loads item into array
                $ObjectNumber = $ObjectNumber + 1                                           # Increments $ObjectNumber by 1
            }                                                                               # End foreach ($_ in $ObjectList)
            Clear-Host                                                                      # Clears screen
            :SelectAzureLoadBalancer while ($true) {                                        # Inner loop to select the load balancer
                Write-Host '[0]  Exit'                                                      # Write message to screen
                Write-Host ''                                                               # Write message to screen
                foreach ($_ in $ObjectArray) {                                              # For each $_ in $ObjectArray
                    $Number = $_.Number                                                     # Number is equal to current item .number
                    if ($Number -le 9) {                                                    # If $Number is 9 or less
                        Write-Host "[$Number]            "$_.Name                           # Write message to screen
                    }                                                                       # End if ($Number -le 9)
                    else {                                                                  # Else if $Number is greater than 9
                        Write-Host "[$Number]           "$_.Name                            # Write message to screen
                    }                                                                       # End else (if ($Number -le 9))
                    Write-Host 'LB loc:        '$_.loc                                      # Write message to screen
                    Write-Host 'LB RG:         '$_.RGName                                   # Write message to screen
                    Write-Host 'LB SKU:        '$_.Sku                                      # Write message to screen
                    if ($_.Pubname) {                                                       # If $_.Pubname has a value
                        Write-Host 'Pub IP name:   '$_.Pubname                              # Write message to screen
                        Write-Host 'Pub IP address:'$_.PubAddress                           # Write message to screen
                        Write-Host 'Pub IP allocat:'$_.PubAllocation                        # Write message to screen
                    }                                                                       # End if ($_.Pubname)
                    if ($_.VmssName) {                                                      # If $_.VmssName has a value
                        Write-Host 'Vmss name:     '$_.VmssName                             # Write message to screen
                        Write-Host 'Vmss RG:       '$_.VmssRG                               # Write message to screen
                    }                                                                       # End if ($_.VmssName)
                    Write-Host ''                                                           # Write message to screen         
                }                                                                           # End foreach ($_ in $ObjectArray)
                if ($CallingFunction) {                                                     # If $CallingFunction has a value
                    Write-Host 'You are selecting the load balancer for:'$CallingFunction   # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                }                                                                           # End if ($CallingFunction)
                $OpSelect = Read-Host 'Option [#]'                                          # Operator input to select the load balancer
                Clear-Host                                                                  # Clears screen 
                if ($OpSelect -eq '0') {                                                    # If $OpSelect equals 0
                    Break GetAzureLoadBalancer                                              # Breaks :GetAzureLoadBalancer
                }                                                                           # End if ($OpSelect -eq '0')
                elseif ($OpSelect -in $ObjectArray.Number) {                                # If $OpSelect in $ObjectArray.Number
                    $OpSelect = $ObjectArray | Where-Object {$_.Number -eq $OpSelect}       # $OpSelect is equal to $ObjectArray where $ObjectArray.Number equals $OpSelect
                    $LoadBalancerObject = Get-AzLoadBalancer -Name $OpSelect.Name `
                        -ResourceGroupName $OPSelect.RGName                                 # Pulls the full load balancer object
                    Return $LoadBalancerObject                                              # Returns to calling function with $LoadBalancerObject
                }                                                                           # End elseif ($OpSelect -in $ObjectArray.Number) 
                else {                                                                      # If $LoadBalancerObject does not have a value
                    Write-Host 'That was not a valid input'                                 # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Clear-Host                                                              # Clears screen
                }                                                                           # End else (if ($OpSelect -eq '0'))
            }                                                                               # End :SelectAzureLoadBalancer while ($true)
        }                                                                                   # End :GetAzureLoadBalancer while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function GetAzLoadBalancer 
function GetAzLBRuleFE {                                                                    # Function to get a load balancer front end config for load balancer rule
    Begin {                                                                                 # Begin function
        :GetAzureLBFEConfig while ($true) {                                                 # Outer loop for managing function
            $ObjectNumber = 1                                                               # Sets $ObjectNumber to 1
            [System.Collections.ArrayList]$ObjectArray = @()                                # Creates the load balancer array
            $ObjectList = Get-AzLoadBalancerFrontendIpConfig -LoadBalancer `
                $LoadBalancerObject                                                         # Gets the configs of $LoadBalancerObject
            foreach ($_ in $ObjectList) {                                                   # For each item in $ObjectList
                if ($_.Subnet.ID) {                                                         # If current item .subnet.id has a value
                    $SubnetID = $_.Subnet.ID                                                # Isolates the subnet ID
                    $SubnetID = $SubnetID.Split('/')[-1]                                    # Isolates the subnet name
                }                                                                           # End if ($_.Subnet.ID)
                if ($_.PublicIPAddress.ID) {                                                # If current item .PublicIPAddress.ID 
                    $PublicIPID = $_.PublicIPAddress.ID                                     # Isolates the public IP ID 
                    $PublicIPObject = Get-AzPublicIpAddress | Where-Object `
                        {$_.ID -eq $PublicIPID}                                             # Gets the public IP object
                }                                                                           # End if ($_.PublicIPAddress.ID)
                $ObjectInput = [PSCustomObject]@{                                           # Custom object to be added to $ObjectArray
                    'Number'=$ObjectNumber;                                                 # $ObjectNumber 
                    'Name'=$_.Name;                                                         # Current item .name
                    'PriIP'=$_.PrivateIpAddress;                                            # Current item .PrivateIPaddress
                    'PriIP2'=$_.PrivateIpAllocationMethod;                                  # Current item .PrivateIPAllocation
                    'Sub'=$SubnetID;                                                        # $SubnetID
                    'PubIP'=$PublicIPObject.IpAddress;                                      # PublicIPObject.IPAddress
                    'PubIP2'=$PublicIPObject.PublicIpAllocationMethod;                      # $PublicIPObject.PublicIpAllocationMethod
                    'PubIP3'=$PublicIPObject.Sku.Name;                                      # $PublicIPObject.Sku.Name     
                }                                                                           # End $ObjectInput = [PSCustomObject]@
                $ObjectArray.Add($ObjectInput) | Out-Null                                   # Loads item into array, out-null removes write to screen
                $SubnetID = $null                                                           # Clears $SubnetID
                $PublicIPID = $null                                                         # Clears $PublicIPID
                $PublicIPObject = $null                                                     # Clears $PublicIPObject
                $ObjectNumber = $ObjectNumber + 1                                           # Increments $ObjectNumber up by 1
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
                    $LBFEObject = Get-AzLoadBalancerFrontendIpConfig `
                        -LoadBalancer $LoadBalancerObject -Name $OpSelect.Name              # Gets the front end IP config object
                    Return $LBFEObject                                                      # Returns to calling function with $var    
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
}                                                                                           # End function GetAzLBRuleFE
function GetAzLBRuleBE {                                                                    # Function to get an existing load balancer back end pool config for load balancer rule
    Begin {                                                                                 # Begin function
        :GetAzureLBBEPoolConfig while ($true) {                                             # Outer loop to manage function
            $ObjectNumber = 1                                                               # Sets $ObjectNumber to 1
            [System.Collections.ArrayList]$ObjectArray = @()                                # Creates the object array
            $ObjectList = Get-AzLoadBalancerBackendAddressPool -LoadBalancer `
                $LoadBalancerObject                                                         # Gets a list of all back end pools on $LBObject
            foreach ($_ in $ObjectList) {                                                   # For each item in $ObjectList
                $ObjectInput = [PSCustomObject]@{                                           # Creates the item to loaded into array
                    'Number'=$ObjectNumber;
                    'Name'=$_.Name;                                                         # Current item .name
                    'BackEndAddresses'=$_.LoadBalancerBackendAddresses                      # Current item .LoadBalancerBackendAddresses
                }                                                                           # End $ObjectInput = [PSCustomObject]@
                $ObjectArray.Add($ObjectInput) | Out-Null                                   # Loads item into array
                $ObjectNumber = $ObjectNumber + 1                                           # Increments $ObjectNumber by 1
            }                                                                               # End foreach ($_ in $ObjectList)
            Clear-Host                                                                      # Clears screen
            if (!$ObjectArray) {                                                            # If $ObjectArray is $null    
                Write-Host 'No load balancer back end configs exist'                        # Write message to screen
                Write-Host 'on load balancer:'$LoadBalancerObject.Name                      # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break GetAzureLBBEPoolConfig                                                # Breaks :GetAzureLBBEPoolConfig
            }                                                                               # End if (!$ObjectArray)
            Write-Host '[0]   Exit'                                                         # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            foreach ($_ in $ObjectArray) {                                                  # For each $_ in $ObjectArray
                $Number = $_.Number                                                         # Number is equal to current item .number
                if ($Number -le 9) {                                                        # If $Number is 9 or less
                    Write-Host "[$Number]  "$_.Name                                         # Write message to screen
                }                                                                           # End if ($Number -le 9)
                else {                                                                      # Else if $Number is greater than 9
                    Write-Host "[$Number] "$_.Name                                          # Write message to screen
                }                                                                           # End else (if ($Number -le 9))
                if ($_.BackEndAddresses) {                                                  # If current item .BackEndAddresses has a value
                    $BackEndAddresses = $_.BackEndAddresses                                 # Isolates the current item .BackEndAddresses
                    foreach ($_ in $BackEndAddresses) {                                     # For each item in $BackEndAddresses
                        $BackEndName = $_                                                   # Isolates the current item
                        $BackEndIPCon = $BackEndName.NetworkInterfaceIpConfiguration.ID     # Isolates the back end IP configuration ID
                        $BackEndNic = Get-AzNetworkInterface | Where-Object `
                            {$_.IpConfigurations.ID -eq $BackEndIPCon}                      # Gets the back end NIC
                        $BackEndConfig = Get-AzNetworkInterfaceIpConfig `
                            -NetworkInterface $BackEndNic | `
                            Where-Object {$_.ID -eq $BackEndIPCon}                          # Gets the config back end IP configuration
                        $BackEndVM = Get-AzVM | Where-Object `
                            {$_.ID -eq $BackEndNic.VirtualMachine.ID}                       # Gets the VM info
                        Write-Host 'VM Name:       '$BackEndVM.Name                         # Write message to screen
                        Write-Host 'IP Con Name:   '$BackEndConfig.Name                     # Write message to screen
                        if ($BackEndConfig.PrivateIpAddress) {                              # If $BackEndConfig.PrivateIpAddress has a value
                            Write-Host 'IP Con Priv IP:'$BackEndConfig.PrivateIpAddress     # Write message to screen
                        }                                                                   # End if ($BackEndConfig.PrivateIpAddress)
                        if ($BackEndConfig.PrivateIpAllocationMethod) {                     # If $BackEndConfig.PrivateIpAllocationMethod has a value
                            $PrivAll = $BackEndConfig.PrivateIpAllocationMethod             # Isolates $BackEndConfig.PrivateIpAllocationMethod      
                            Write-Host 'IP Con Priv IP:'$PrivAll                            # Write message to screen
                            $PrivAll = $null                                                # Clears $var    
                        }                                                                   # End if ($BackEndConfig.PrivateIpAllocationMethod)
                        if ($BackEndConfig.PublicIpAddress) {                               # If $BackEndConfig.PublicIpAddress has a value
                            Write-Host 'IP Con Priv IP:'$BackEndConfig.PublicIpAddress      # Write message to screen
                        }                                                                   # End if ($BackEndConfig.PublicIpAddress)
                        $BackEndName = $null                                                # Clears $var
                        $BackEndIPCon = $null                                               # Clears $var
                        $BackEndNic = $null                                                 # Clears $var
                        $BackEndConfig = $null                                              # Clears $var
                        $BackEndVM = $null                                                  # Clears $var
                    }                                                                       # End foreach ($_ in $BackEndAddresses)
                    $BackEndAddresses = $null                                               # Clears $var
                }                                                                           # End if ($_.BackEndAddresses)
                else {                                                                      # Else if $_.BackEndAddresses is $null
                    Write-Host 'No associated NICs to this back end pool'                   # Write message to screen
                }                                                                           # End else (if ($_.BackEndAddresses))
                Write-Host ''                                                               # Write message to screen         
            }                                                                               # End foreach ($_ in $ObjectArray)
            if ($CallingFunction) {                                                         # If $CallingFunction has a value
                Write-Host 'You are selecting the back end config for:'$CallingFunction     # Write message to screen
                Write-Host ''                                                               # Write message to screen
            }                                                                               # End if ($CallingFunction)
            :SelectAzureLBBEConfig while ($true) {                                          # Inner loop to select the load balancer back end config
                $OpSelect = Read-Host 'Option [#]'                                          # Operator input to select the load balancer
                if ($OpSelect -eq '0') {                                                    # If $OpSelect equals 0
                    Break GetAzureLBBEPoolConfig                                            # Breaks :GetAzureLBBEPoolConfig
                }                                                                           # End if ($OpSelect -eq '0')
                elseif ($OpSelect -in $ObjectArray.Number) {                                # If $OpSelect in $ObjectArray.Number
                    $OpSelect = $ObjectArray | Where-Object {$_.Number -eq $OpSelect}       # $OpSelect is equal to $ObjectArray where $ObjectArray.Number equals $OpSelect
                    $LBBackEndObject = Get-AzLoadBalancerBackendAddressPool -LoadBalancer `
                        $LoadBalancerObject -Name $OpSelect.Name                            # Pulls the load balancer back end config object
                    Clear-Host                                                              # Clears screen
                    Return $LBBackEndObject                                                 # Returns to calling function with $var
                }                                                                           # End elseif ($OpSelect -in $ObjectArray.Number) 
                else {                                                                      # All other inputs for $OpSelect
                    Write-Host 'That was not a valid input'                                 # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                }                                                                           # End else (if ($OpSelect -eq '0'))
            }                                                                               # End :SelectAzureLBBEConfig while ($true)
        }                                                                                   # End :GetAzureLBBEPoolConfig while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function GetAzLBRuleBE
function GetAzLBRuleProbe {                                                                 # Function to get an existing load balancer probe config for load balancer rule
    Begin {                                                                                 # Begin function
        :GetAzureLBProbeConfig while ($true) {                                              # Outer loop to manage function
            $ObjectNumber = 1                                                               # Sets $ObjectNumber to 1
            [System.Collections.ArrayList]$ObjectArray = @()                                # Creates the load balancer array
            $ObjectList = Get-AzLoadBalancerProbeConfig -LoadBalancer $LoadBalancerObject   # Gets a list of all probes on $LoadBalancerObject
            foreach ($_ in $ObjectList) {                                                   # For each item in $ObjectList
                $ObjectInput = [PSCustomObject]@{                                           # Creates the item to loaded into array
                    'Number'=$ObjectNumber;                                                 # Object number
                    'Name'=$_.Name;                                                         # Rule name
                    'Proto'=$_.Protocol;                                                    # Probe protocol
                    'Port'=$_.Port;                                                         # Probe port
                    'Int'=$_.IntervalInSeconds;                                             # Probe interval
                    'Count'=$_.NumberOfProbes;                                              # Probe count
                    'RPath'=$_.RequestPath;                                                 # Request path
                    'Rule'=$_.LoadBalancingRules.ID                                         # Probe rules if any
                }                                                                           # End $ObjectInput = [PSCustomObject]@
                $ObjectArray.Add($ObjectInput) | Out-Null                                   # Loads item into array
                $ObjectNumber = $ObjectNumber + 1                                           # Increments $ObjectNumber by 1
            }                                                                               # End foreach ($_ in $ObjectList)
            Clear-Host                                                                      # Clears screen
            if (!$ObjectArray) {                                                            # If $ObjectArray is $null    
                Write-Host 'No load balancer probe configs exist'                           # Write message to screen
                Write-Host 'on load balancer:'$LBObject                                     # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break GetAzureLBProbeConfig                                                 # Breaks :GetAzureLBProbeConfig
            }                                                                               # End if (!$ObjectArray)
            :SelectAzureLBProbeConfig while ($true) {                                       # Inner loop to select the load balancer probe config
                Write-Host '[0]             Exit'                                           # Write message to screen
                Write-Host ''                                                               # Write message to screen
                foreach ($_ in $ObjectArray) {                                              # For each $_ in $ObjectArray
                    $Number = $_.Number                                                     # Number is equal to current item .number
                    if ($Number -le 9) {                                                    # If $Number is 9 or less
                        Write-Host "[$Number]            "$_.Name                           # Write message to screen
                    }                                                                       # End if ($Number -le 9)
                    else {                                                                  # Else if $Number is greater than 9
                        Write-Host "[$Number]           "$_.Name                            # Write message to screen
                    }                                                                       # End else (if ($Number -le 9))
                    Write-Host 'Probe Protocol:'$_.Proto                                    # Write message to screen
                    Write-Host 'Probe Port:    '$_.Port                                     # Write message to screen
                    Write-Host 'Probe Interval:'$_.Int                                      # Write message to screen
                    Write-Host 'Probe Count:   '$_.Count                                    # Write message to screen
                    if ($_.RPath) {                                                         # If current item .RPath has a value
                        Write-Host 'Probe RPath:   '$_.Rpath                                # Write message to screen
                    }                                                                       # End if ($_.RPath)
                    else {                                                                  # Else if current item .RPath does not have value
                        Write-Host 'Probe RPath:    N/A'                                    # Write message to screen         
                    }                                                                       # End else (if ($_.RPath))
                    Write-Host 'Rule count:    '$_.Rule.Count                               # Write message to screen
                    Write-Host ''                                                           # Write message to screen         
                }                                                                           # End foreach ($_ in $ObjectArray)
                if ($CallingFunction) {                                                     # If $CallingFunction has a value
                    Write-Host 'You are selecting the probe config for:'$CallingFunction    # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                }                                                                           # End if ($CallingFunction)
                $OpSelect = Read-Host 'Option [#]'                                          # Operator input to select the load balancer
                if ($OpSelect -eq '0') {                                                    # If $OpSelect equals 0
                    Break GetAzureLBProbeConfig                                             # Breaks :GetAzureLBProbeConfig
                }                                                                           # End if ($OpSelect -eq '0')
                elseif ($OpSelect -in $ObjectArray.Number) {                                # If $OpSelect in $ObjectArray.Number
                    $OpSelect = $ObjectArray | Where-Object {$_.Number -eq $OpSelect}       # $OpSelect is equal to $ObjectArray where $ObjectArray.Number equals $OpSelect
                    $LBProbeObject = Get-AzLoadBalancerProbeConfig -LoadBalancer `
                        $LoadBalancerObject -Name $OpSelect.Name                            # Pulls the load balancer probe config object
                    Clear-Host                                                              # Clears screen
                    Return $LBProbeObject                                                   # Returns to calling function with $var
                }                                                                           # End elseif ($OpSelect -in $ObjectArray.Number) 
                else {                                                                      # All other inputs for $OpSelect
                    Write-Host 'That was not a valid input'                                 # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Clear-Host                                                              # Clears screen
                }                                                                           # End else (if ($OpSelect -eq '0'))
            }                                                                               # End :SelectAzureLBProbeConfig while ($true)
        }                                                                                   # End :GetAzureLBProbeConfig while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function GetAzLBRuleProbe