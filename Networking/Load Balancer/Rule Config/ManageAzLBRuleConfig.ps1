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
    Get-AzLoadBalancerRuleConfig:               https://docs.microsoft.com/en-us/powershell/module/az.network/get-azloadbalancerruleconfig?view=azps-6.1.0
    Remove-AzLoadBalancerRuleConfig:            https://docs.microsoft.com/en-us/powershell/module/az.network/remove-azloadbalancerruleconfig?view=azps-6.1.0
    Set-AzLoadBalancerRuleConfig:               https://docs.microsoft.com/en-us/powershell/module/az.network/set-azloadbalancerruleconfig?view=azps-6.1.0
} #>
<# Required Functions Links: {
    AddAzLBRuleConfig:          https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/Load%20Balancer/Rule%20Config/AddAzLBRuleConfig.ps1
    GetAzLBRuleFE:              https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/Load%20Balancer/Rule%20Config/GetAzLBRuleFE.ps1
    GetAzLBRuleBE:              https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/Load%20Balancer/Rule%20Config/GetAzLBRuleBE.ps1
    GetAzLBRuleProbe:           https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/Load%20Balancer/Rule%20Config/GetAzLBRuleProbe.ps1
    ListAzLBRuleConfig:         https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/Load%20Balancer/Rule%20Config/ListAzLBRuleConfig.ps1
    RemoveAzLBRuleConfig:       https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/Load%20Balancer/Rule%20Config/RemoveAzLBRuleConfig.ps1
    GetAzLBRuleConfig:          https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/Load%20Balancer/Rule%20Config/GetAzLBRuleConfig.ps1
    SetAzLBRuleFE:              https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/Load%20Balancer/Rule%20Config/SetAzLBRuleFE.ps1
    SetAzLBRuleBE:              https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/Load%20Balancer/Rule%20Config/SetAzLBRuleBE.ps1
    RemoveAzLBRuleBE:           https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/Load%20Balancer/Rule%20Config/RemoveAzLBRuleBE.ps1
    SetAzLBRuleProbe:           https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/Load%20Balancer/Rule%20Config/SetAzLBRuleProbe.ps1
    SetAzLBRuleProtocol:        https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/Load%20Balancer/Rule%20Config/SetAzLBRuleProtocol.ps1
    SetAzLBRuleFEPort:          https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/Load%20Balancer/Rule%20Config/SetAzLBRuleFEPort.ps1
    SetAzLBRuleBEPort:          https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/Load%20Balancer/Rule%20Config/SetAzLBRuleBEPort.ps1
    SetAzLBRuleTimeOut:         https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/Load%20Balancer/Rule%20Config/SetAzLBRuleTimeOut.ps1
    SetAzLBRuleLoadDisto:       https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/Load%20Balancer/Rule%20Config/SetAzLBRuleLoadDisto.ps1
    SetAzLBRuleTCPReset:        https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/Load%20Balancer/Rule%20Config/SetAzLBRuleTCPReset.ps1
    SetAzLBRuleFloatingIP:      https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/Load%20Balancer/Rule%20Config/SetAzLBRuleFloatingIP.ps1
    GetAzLoadBalancer:          https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/Load%20Balancer/GetAzLoadBalancer.ps1
} #>
<# Functions Description: {
    ManageAzLBRuleConfig:       Function to manage load balancer rule configurations
    AddAzLBRuleConfig:          Funtion to add a new load balancer rule config
    GetAzLBRuleFE:              Function to get a load balancer front end config for load balancer rule
    GetAzLBRuleBE:              Function to get an existing load balancer back end pool config for load balancer rule
    GetAzLBRuleProbe:           Function to get an existing load balancer probe config for load balancer rule
    ListAzLBRuleConfig:         Function to list all load balancer rule configs
    RemoveAzLBRuleConfig:       Function to remove a load balancer rule config
    GetAzLBRuleConfig:          Function to get an existing load balancer rule config
    SetAzLBRuleFE:              Function to change an existing load balancer rule front end config
    SetAzLBRuleBE:              Function to change an existing load balancer rule back end config
    RemoveAzLBRuleBE:           Function to change an existing load balancer rule back end config
    SetAzLBRuleProbe:           Function to change an existing load balancer rule probe config
    SetAzLBRuleProtocol:        Function to change an existing load balancer rule protocol
    SetAzLBRuleFEPort:          Function to change an existing load balancer rule front end port
    SetAzLBRuleBEPort:          Function to change an existing load balancer rule back end port
    SetAzLBRuleTimeOut:         Function to change an existing load balancer rule idle time out
    SetAzLBRuleLoadDisto:       Function to change an existing load balancer rule load distribution
    SetAzLBRuleTCPReset:        Function to change an existing load balancer rule TCP reset
    SetAzLBRuleFloatingIP:      Function to change an existing load balancer rule floating IP
    GetAzLoadBalancer:          Function to change an existing load balancer
} #>
<# Variables: {      
    :ManageAzureLBRuleConfig    Outer loop for managing function
    $OpSelect:                  Operator input for selecting the management function
    AddAzLBRuleConfig{}         Creaates $LBRuleObject
    GetAzLoadBalancer{}         Gets $LoadBalancerObject
        GetAzLBRuleFE{}             Gets $LBFEObject
        GetAzLBRuleBE{}             Gets $LBBackEndObject
        GetAzLBRuleProbe{}          Gets $LBProbeObject
    ListAzLBRuleConfig{}        Lists $LBRuleObject
    RemoveAzLBRuleConfig{}      Removes $LBRuleObject
        GetAzLBRuleConfig{}         Gets $LBRuleObject,$LoadBalancerObject
    SetAzLBRuleFE{}             Changes $LBRuleObject
        GetAzLBRuleConfig{}         Gets $LBRuleObject, $LoadBalancerObject
        GetAzLBRuleFE{}             Gets $LBFEObject
    SetAzLBRuleBE{}             Changes $LBRuleObject
        GetAzLBRuleConfig{}         Gets $LBRuleObject, $LoadBalancerObject
        GetAzLBRuleBE{}             Gets $LBBEObject
    RemoveAzLBRuleBE{}          Changes $LBRuleObject
        GetAzLBRuleConfig{}         Gets $LBRuleObject, $LoadBalancerObject
    SetAzLBRuleProbe{}          Changes $LBRuleObject
        GetAzLBRuleConfig{}         Gets $LBRuleObject, $LoadBalancerObject
        GetAzLBRuleProbe{}          Gets $LBProbeObject
    SetAzLBRuleProtocol{}       Changes $LBRuleObject
        GetAzLBRuleConfig{}         Gets $LBRuleObject, $LoadBalancerObject
    SetAzLBRuleFEPort{}         Changes $LBRuleObject
        GetAzLBRuleConfig{}         Gets $LBRuleObject, $LoadBalancerObject
    SetAzLBRuleBEPort{}         Changes $LBRuleObject
        GetAzLBRuleConfig{}         Gets $LBRuleObject, $LoadBalancerObject
    SetAzLBRuleTimeOut{}        Changes $LBRuleObject
        GetAzLBRuleConfig{}         Gets $LBRuleObject, $LoadBalancerObject
    SetAzLBRuleLoadDisto{}      Changes $LBRuleObject
        GetAzLBRuleConfig{}         Gets $LBRuleObject, $LoadBalancerObject
    SetAzLBRuleTCPReset{}       Changes $LBRuleObject
        GetAzLBRuleConfig{}         Gets $LBRuleObject, $LoadBalancerObject
    SetAzLBRuleFloatingIP{}     Changes $LBRuleObject
    GetAzLBRuleConfig{}             Gets $LBRuleObject, $LoadBalancerObject
} #>
<# Process Flow {
    function
        Call ManageAzLBRuleConfig > Get $null
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
                Return ManageAzLBRuleConfig > Send $null
            Call ListAzLBRuleConfig > Get $null
            End ListAzLBRuleConfig
                Return ManageAzLBRuleConfig > Send $null
            Call RemoveAzLBRuleConfig > Get $null
                Call GetAzLBRuleConfig > Get $LBRuleObject,$LoadBalancerObject
                End GetAzLBRuleConfig
                    Return RemoveAzLBRuleConfig > Send $LBRuleObject,$LoadBalancerObject
            End RemoveAzLBRuleConfig
                Return ManageAzLBRuleConfig > Send $null
            Call SetAzLBRuleFE > Get $null
                Call GetAzLBRuleConfig > Get $LBRuleObject, $LoadBalancerObject
                End GetAzLBRuleConfig
                    Return SetAzLBRuleFE > Send $LBRuleObject, $LoadBalancerObject
                Call GetAzLBRuleFE > Get $LBFEObject
                End GetAzLBRuleFE
                    Return SetAzLBRuleFE > Send $LBFEObject
            End SetAzLBRuleFE
                Return ManageAzLBRuleConfig > Send $null           
            Call SetAzLBRuleBE > Get $null
                Call GetAzLBRuleConfig > Get $LBRuleObject, $LoadBalancerObject
                End GetAzLBRuleConfig
                    Return SetAzLBRuleBE > Send $LBRuleObject, $LoadBalancerObject
                Call GetAzLBRuleBE > Get $LBBEObject
                End GetAzLBRuleBE
                    Return SetAzLBRuleBE > Send $LBBEObject
            End SetAzLBRuleBE
                Return ManageAzLBRuleConfig > Send $null       
            Call RemoveAzLBRuleBE > Get $null
                Call GetAzLBRuleConfig > Get $LBRuleObject, $LoadBalancerObject
                End GetAzLBRuleConfig
                    Return RemoveAzLBRuleBE > Send $LBRuleObject, $LoadBalancerObject
            End RemoveAzLBRuleBE
                Return ManageAzLBRuleConfig > Send $null
            Call SetAzLBRuleProbe > Get $null
                Call GetAzLBRuleConfig > Get $LBRuleObject, $LoadBalancerObject
                End GetAzLBRuleConfig
                    Return SetAzLBRuleProbe > Send $LBRuleObject, $LoadBalancerObject
                Call GetAzLBRuleProbe > Get $LBProbeObject
                End GetAzLBRuleProbe
                    Return SetAzLBRuleProbe > Send $LBProbeObject
            End SetAzLBRuleProbe
                Return ManageAzLBRuleConfig > Send $null
            Call SetAzLBRuleProtocol > Get $null
                Call GetAzLBRuleConfig > Get $LBRuleObject, $LoadBalancerObject
                End GetAzLBRuleConfig
                    Return SetAzLBRuleProtocol > Send $LBRuleObject, $LoadBalancerObject
            End SetAzLBRuleProtocol
                Return ManageAzLBRuleConfig > Send $null
            Call SetAzLBRuleFEPort > Get $null
                Call GetAzLBRuleConfig > Get $LBRuleObject, $LoadBalancerObject
                End GetAzLBRuleConfig
                    Return SetAzLBRuleFEPort > Send $LBRuleObject, $LoadBalancerObject
            End SetAzLBRuleFEPort
                Return ManageAzLBRuleConfig > Send $null
            Call SetAzLBRuleBEPort > Get $null
                Call GetAzLBRuleConfig > Get $LBRuleObject, $LoadBalancerObject
                End GetAzLBRuleConfig
                    Return SetAzLBRuleBEPort > Send $LBRuleObject, $LoadBalancerObject
            End SetAzLBRuleBEPort
                Return ManageAzLBRuleConfig > Send $null
            Call SetAzLBRuleTimeOut > Get $null
                Call GetAzLBRuleConfig > Get $LBRuleObject, $LoadBalancerObject
                End GetAzLBRuleConfig
                    Return SetAzLBRuleTimeOut > Send $LBRuleObject, $LoadBalancerObject
            End SetAzLBRuleTimeOut
                Return ManageAzLBRuleConfig > Send $null
            Call SetAzLBRuleLoadDisto > Get $null
                Call GetAzLBRuleConfig > Get $LBRuleObject, $LoadBalancerObject
                End GetAzLBRuleConfig
                    Return SetAzLBRuleLoadDisto > Send $LBRuleObject, $LoadBalancerObject
            End SetAzLBRuleLoadDisto
                Return ManageAzLBRuleConfig > Send $null
            Call SetAzLBRuleTCPReset > Get $null
                Call GetAzLBRuleConfig > Get $LBRuleObject, $LoadBalancerObject
                End GetAzLBRuleConfig
                    Return SetAzLBRuleTCPReset > Send $LBRuleObject, $LoadBalancerObject
            End SetAzLBRuleTCPReset
                Return ManageAzLBRuleConfig > Send $null               
        Call SetAzLBRuleFloatingIP > Get $null
            Call GetAzLBRuleConfig > Get $LBRuleObject, $LoadBalancerObject
            End GetAzLBRuleConfig
                Return SetAzLBRuleFloatingIP > Send $LBRuleObject, $LoadBalancerObject
        End SetAzLBRuleFloatingIP
            Return ManageAzLBRuleConfig > Send $null                
        End ManageAzLBRuleConfig
            Return function > Send $null
}#>
function ManageAzLBRuleConfig {                                                             # Function to manage load balancer rule configurations
    Begin {                                                                                 # Begin function
        :ManageAzureLBRuleConfig while ($true) {                                            # Outer loop for managing function
            Write-Host 'Manage Load Balancer Rules'                                         # Write message to screen
            Write-Host '[0]  Exit'                                                          # Write message to screen
            Write-Host '[1]  Add Rule Config'                                               # Write message to screen
            Write-Host '[2]  List Rule Configs'                                             # Write message to screen
            Write-Host '[3]  Remove Rule Config'                                            # Write message to screen
            Write-Host '[4]  Change Rule Front End Config'                                  # Write message to screen 
            Write-Host '[5]  Change Rule Back End Config'                                   # Write message to screen 
            Write-Host '[6]  Remove Rule Back End Config'                                   # Write message to screen 
            Write-Host '[7]  Change Rule Probe Config'                                      # Write message to screen
            Write-Host '[8]  Change Rule Protocol'                                          # Write message to screen
            Write-Host '[9]  Change Rule Front End port'                                    # Write message to screen
            Write-Host '[10] Change Rule Back End Port'                                     # Write message to screen
            Write-Host '[11] Change Rule Idle Time Out'                                     # Write message to screen 
            Write-Host '[12] Change Rule Load Distribution'                                 # Write message to screen 
            Write-Host '[13] Change Rule TCP Reset'                                         # Write message to screen 
            Write-Host '[14] Change Rule Floating IP'                                       # Write message to screen 
            $OpSelect = Read-Host 'Option [#]'                                              # Operator input for the function selection
            Clear-Host                                                                      # Clears screen
            if ($OpSelect -eq '0') {                                                        # If $OpSelect equals '0'    
                Break ManageAzureLBRuleConfig                                               # Breaks :ManageAzureLBRuleConfig
            }                                                                               # End if ($OpSelect -eq '0')
            elseif ($OpSelect -eq '1') {                                                    # Else if $OpSelect equals '1'
                Write-Host 'Add Rule Config'                                                # Write message to screen
                AddAzLBRuleConfig                                                           # Calls function
            }                                                                               # End elseif ($OpSelect -eq '1')
            elseif ($OpSelect -eq '2') {                                                    # Else if $OpSelect equals '2'
                Write-Host 'List Rule Configs'                                              # Write message to screen
                ListAzLBRuleConfig                                                          # Calls function
            }                                                                               # End elseif ($OpSelect -eq '2')
            elseif ($OpSelect -eq '3') {                                                    # Else if $OpSelect equals '3'
                Write-Host 'Remove Rule Config'                                             # Write message to screen
                RemoveAzLBRuleConfig                                                        # Calls function
            }                                                                               # End elseif ($OpSelect -eq '3')
            elseif ($OpSelect -eq '4') {                                                    # Else if $OpSelect equals '4'
                Write-Host 'Change Rule Front End Config'                                   # Write message to screen 
                SetAzLBRuleFE                                                               # Calls function
            }                                                                               # End elseif ($OpSelect -eq '4')
            elseif ($OpSelect -eq '5') {                                                    # Else if $OpSelect equals '5'
                Write-Host 'Change Rule Back End Config'                                    # Write message to screen 
                SetAzLBRuleBE                                                               # Calls function
            }                                                                               # End elseif ($OpSelect -eq '5')
            elseif ($OpSelect -eq '6') {                                                    # Else if $OpSelect equals '6'
                Write-Host 'Remove Rule Back End Config'                                    # Write message to screen 
                RemoveAzLBRuleBE                                                            # Calls function    
            }                                                                               # End elseif ($OpSelect -eq '6')
            elseif ($OpSelect -eq '7') {                                                    # Else if $OpSelect equals '7'
                Write-Host 'Change Rule Probe Config'                                       # Write message to screen 
                SetAzLBRuleProbe                                                            # Calls function
            }                                                                               # End elseif ($OpSelect -eq '7')
            elseif ($OpSelect -eq '8') {                                                    # Else if $OpSelect equals '8'
                Write-Host 'Change Rule Protocol'                                           # Write message to screen
                SetAzLBRuleProtocol                                                         # Calls function
            }                                                                               # End elseif ($OpSelect -eq '8')
            elseif ($OpSelect -eq '9') {                                                    # Else if $OpSelect equals '9'
                Write-Host 'Change Rule Front End port'                                     # Write message to screen
                SetAzLBRuleFEPort                                                           # Calls function
            }                                                                               # End elseif ($OpSelect -eq '9')
            elseif ($OpSelect -eq '10') {                                                   # Else if $OpSelect equals '10'
                Write-Host 'Change Rule Back End Port'                                      # Write message to screen
                SetAzLBRuleBEPort                                                           # Calls function
            }                                                                               # End elseif ($OpSelect -eq '10')
            elseif ($OpSelect -eq '11') {                                                   # Else if $OpSelect equals '11'
                Write-Host 'Change Rule Idle Time Out'                                      # Write message to screen 
                SetAzLBRuleTimeOut                                                          # Calls function
            }                                                                               # End elseif ($OpSelect -eq '11')
            elseif ($OpSelect -eq '12') {                                                   # Else if $OpSelect equals '12'
                Write-Host 'Change Rule Load Distribution'                                  # Write message to screen 
                SetAzLBRuleLoadDisto                                                        # Calls function
            }                                                                               # End elseif ($OpSelect -eq '12')
            elseif ($OpSelect -eq '13') {                                                   # Else if $OpSelect equals '13'
                Write-Host 'Change Rule TCP Reset'                                          # Write message to screen 
                SetAzLBRuleTCPReset                                                         # Calls function
            }                                                                               # End elseif ($OpSelect -eq '13')
            elseif ($OpSelect -eq '14') {                                                   # Else if $OpSelect equals '14'
                Write-Host 'Change Rule Floating IP'                                        # Write message to screen 
                SetAzLBRuleFloatingIP                                                       # Calls function
            }                                                                               # End elseif ($OpSelect -eq '14')
            else {                                                                          # All other inputs for $OpSelect
                Write-Host 'That was not a valid input'                                     # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Clear-Host                                                                  # Clears screen
            }                                                                               # End else (if ($OpSelect -eq '0'))
        }                                                                                   # End :ManageAzureLBRuleConfig while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function ManageAzLBRuleConfig
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
                Write-Host 'Load balancer rule name rules:'                                 # Write message to screen
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
                    Break AddAzureLBRule                                                    # Breaks :AddAzureLBRule
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
            :NewAzureLBRuleFEPort while ($true) {                                           # Inner loop for setting the rule front end port
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
                        Break NewAzureLBRuleFEPort                                          # Breaks :NewAzureLBRuleFEPort        
                    }                                                                       # End if ($OpConfirm -eq 'y')
                }                                                                           # End if ($LBRuleFrontEndPort)
                else {                                                                      # Else if $LBRuleFrontEndPort is $null
                    Write-Host 'That was not a valid input'                                 # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Clear-Host                                                              # Clears screen
                }                                                                           # End else (if ($LBRuleFrontEndPort))
            }                                                                               # End :NewAzureLBRuleFEPort while ($true)
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
                        Break AddAzureLBRule                                                # Breaks :AddAzureLBRule
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
            :NewAzureLBRuleIdleTO while ($true) {                                           # Inner loop for setting the rule idle timeout
                Write-Host 'Enter the idle time out in minutes for this rule'               # Write message to screen
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
                    Write-Host 'Set:'$LBRuleIdleTO' minutes as the rule idle time out'      # Write message to screen
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
            Write-Host '[0]  Exit'                                                          # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            foreach ($_ in $ObjectArray) {                                                  # For each $_ in $ObjectArray
                $Number = $_.Number                                                         # Number is equal to current item .number
                if ($Number -le 9) {                                                        # If $Number is 9 or less
                    Write-Host "[$Number]            "$_.Name                               # Write message to screen
                }                                                                           # End if ($Number -le 9)
                else {                                                                      # Else if $Number is greater than 9
                    Write-Host "[$Number]           "$_.Name                                # Write message to screen
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
function ListAzLBRuleConfig {                                                               # Function to list all load balancer rule configs
    Begin {                                                                                 # Begin function
        :ListAzureLBRuleConfig while ($true) {                                              # Outer loop to manage function
            Write-Host 'Gathering load balancer info'                                       # Write message to screen
            Write-Host 'This may take a moment'                                             # Write message to screen
            $ObjectList = Get-AzLoadBalancer                                                # Generates the load balancer list
            if (!$ObjectList) {                                                             # If $ObjectList is $null 
                Clear-Host                                                                  # Clears screen
                Write-Host 'No load balancers are in this subscription'                     # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break ListAzureLBRuleConfig                                                 # Breaks ListAzureLBRuleConfig
            }                                                                               # End if (!$ObjectList)
            [System.Collections.ArrayList]$ObjectArray = @()                                # Creates the load balancer array
            foreach ($_ in $ObjectList) {                                                   # For each item in $ObjectList
                $LBObject = $_                                                              # Isolates the current item
                if (!$LBObject.FrontendIpConfigurations.PublicIPAddress.ID) {               # If $LBObject.FrontendIpConfigurations.PublicIPAddress.ID is $null
                    $LBObjectType = 'Internal'                                              # Sets $LBObjectType
                }                                                                           # End if (!$LBObject.FrontendIpConfigurations.PublicIPAddress.ID)
                else {                                                                      # Else if $LBObject.FrontendIpConfigurations.PublicIPAddress.ID has a value
                    $LBObjectType = 'External'                                              # Sets $LBObjectType
                }                                                                           # End else (if (!$LBObject.FrontendIpConfigurations.PublicIPAddress.ID))
                $RuleConfigList = Get-AzLoadBalancerRuleConfig -LoadBalancer $_             # Gets a list of all rules on $LBObject
                foreach ($_ in $RuleConfigList) {                                           # For each item in $RuleConfigList
                    $ObjectInput = [PSCustomObject]@{                                       # Creates the item to loaded into array
                        'Name'=$_.Name;                                                     # Rule name
                        'LBName'=$LBObject.Name;                                            # Load balancer name
                        'LBSku'=$LBObject.Sku.Name;                                         # Load balancer sku
                        'LBType'=$LBObjectType;                                             # Load balancer internal or external
                        'RGName'=$LBObject.ResourceGroupName;                               # Load balancer resource group
                        'Proto'=$_.Protocol;                                                # Rule protocol
                        'FEPort'=$_.FrontendPort;                                           # Front end port
                        'BEPort'=$_.BackendPort;                                            # Back end port
                        'Idle'=$_.IdleTimeoutInMinutes;                                     # Idle timeout
                        'LD'=$_.LoadDistribution;                                           # Load distribution
                        'TCP'=$_.EnableTcpReset;                                            # EnableTCPReset enabled
                        'EFIP'=$_.EnableFloatingIP;                                         # Floating IP enabled
                        'FEIP'=$_.FrontendIPConfiguration.ID;                               # Front end ID
                        'BEPool'=$_.BackendAddressPool.ID;                                  # Back end pool ID
                        'Probe'=$_.Probe.ID                                                 # Probe ID
                    }                                                                       # End $ObjectInput = [PSCustomObject]@
                    $ObjectArray.Add($ObjectInput) | Out-Null                               # Loads item into array
                }                                                                           # End foreach ($_ in $RuleConfigList)
                $LBObject = $null                                                           # Clears $var
                $LBObjectType = $null                                                       # Clears $var
            }                                                                               # End foreach ($_ in $ObjectList)
            Clear-Host                                                                      # Clears screen
            if (!$ObjectArray) {                                                            # If $ObjectArray is $null    
                Write-Host 'No load balancer rule configs exist in this subscription'       # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break ListAzureLBRuleConfig                                                 # Breaks :ListAzureLBRuleConfig
            }                                                                               # End if (!$ObjectArray)
            foreach ($_ in $ObjectArray) {                                                  # For each $_ in $ObjectArray
                Write-Host 'Rule Name:     '$_.Name                                         # Write message to screen
                Write-Host 'LB Name:       '$_.LBName                                       # Write message to screen
                Write-Host 'LB Sku:        '$_.LBSku                                        # Write message to screen
                Write-Host 'LB Type:       '$_.LBType                                       # Write message to screen       
                Write-Host 'LB RG:         '$_.RGName                                       # Write message to screen
                Write-Host 'Rule Protocol: '$_.Proto                                        # Write message to screen
                Write-Host 'Front End Port:'$_.FEPort                                       # Write message to screen
                Write-Host 'Back End Port: '$_.BEPort                                       # Write message to screen
                Write-Host 'TO In Minutes: '$_.Idle                                         # Write message to screen
                Write-Host 'Load Distro:   '$_.LD                                           # Write message to screen
                Write-Host 'TCP Reset:     '$_.TCP                                          # Write message to screen
                Write-Host 'Floating IP:   '$_.EFIP                                         # Write message to screen
                if ($_.FEIP) {                                                              # If current item .FEIP has a value
                    $FEndName = $_.FEIP                                                     # Isolates the current item
                    $FEndName = $FEndName.Split('/')[-1]                                    # Isolates the front end name
                    Write-Host 'Front End Name:'$FEndName                                   # Write message to screen
                }                                                                           # End if ($_.FEIP)
                else {                                                                      # Else if current item .FEIP does not have value
                    Write-Host 'Front End Name: N/A'                                        # Write message to screen       
                }                                                                           # End else (if ($_.BEPool))
                if ($_.BEPool) {                                                            # If current item .BEPool has a value
                    $BPoolName = $_.BEPool                                                  # Isolates the current item
                    $BPoolName = $BPoolName.Split('/')[-1]                                  # Isolates the back end name
                    Write-Host 'Back End Name: '$BPoolName                                  # Write message to screen
                }                                                                           # End if ($_.BEPool)
                else {                                                                      # Else if current item .BEPool does not have value
                    Write-Host 'Back End Name:  N/A'                                        # Write message to screen       
                }                                                                           # End else (if ($_.BEPool))
                if ($_.Probe) {                                                             # If current item .Probe has a value
                    $ProbeName = $_.Probe                                                   # Isolates the current item
                    $ProbeName = $ProbeName.Split('/')[-1]                                  # Isolates the front end name
                    Write-Host 'Probe Name:    '$ProbeName                                  # Write message to screen
                }                                                                           # End if ($_.Probe)
                else {                                                                      # Else if current item .Probe does not have value
                    Write-Host 'Probe Name:     N/A'                                        # Write message to screen       
                }                                                                           # End else (if ($_.Probe))
                Write-Host ''                                                               # Write message to screen         
            }                                                                               # End foreach ($_ in $ObjectArray)
            Pause                                                                           # Pauses all actions for operator input
            Break ListAzureLBRuleConfig                                                     # Breaks :ListAzureLBRuleConfig
        }                                                                                   # End :ListAzureLBRuleConfig while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function ListAzLBRuleConfig
function GetAzLBRuleConfig {                                                                # Function to get an existing load balancer rule config
    Begin {                                                                                 # Begin function
        :GetAzureLBRuleConfig while ($true) {                                               # Outer loop to manage function
            Write-Host 'Gathering load balancer info'                                       # Write message to screen
            Write-Host 'This may take a moment'                                             # Write message to screen
            $ObjectList = Get-AzLoadBalancer                                                # Generates the load balancer list
            if (!$ObjectList) {                                                             # If $ObjectList is $null 
                Clear-Host                                                                  # Clears screen
                Write-Host 'No load balancers are in this subscription'                     # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break GetAzureLBRuleConfig                                                  # Breaks GetAzureLBRuleConfig
            }                                                                               # End if (!$ObjectList)
            $ObjectNumber = 1                                                               # Sets $ObjectNumber to 1
            [System.Collections.ArrayList]$ObjectArray = @()                                # Creates the load balancer array
            foreach ($_ in $ObjectList) {                                                   # For each item in $ObjectList
                $LBObject = $_                                                              # Isolates the current item
                if (!$LBObject.FrontendIpConfigurations.PublicIPAddress.ID) {               # If $LBObject.FrontendIpConfigurations.PublicIPAddress.ID is $null
                    $LBObjectType = 'Internal'                                              # Sets $LBObjectType
                }                                                                           # End if (!$LBObject.FrontendIpConfigurations.PublicIPAddress.ID)
                else {                                                                      # Else if $LBObject.FrontendIpConfigurations.PublicIPAddress.ID has a value
                    $LBObjectType = 'External'                                              # Sets $LBObjectType
                }                                                                           # End else (if (!$LBObject.FrontendIpConfigurations.PublicIPAddress.ID))
                $RuleConfigList = Get-AzLoadBalancerRuleConfig -LoadBalancer $_             # Gets a list of all rules on $LBObject
                foreach ($_ in $RuleConfigList) {                                           # For each item in $RuleConfigList
                    $ObjectInput = [PSCustomObject]@{                                       # Creates the item to loaded into array
                        'Number'=$ObjectNumber;                                             # Object number
                        'Name'=$_.Name;                                                     # Rule name
                        'LBName'=$LBObject.Name;                                            # Load balancer name
                        'LBSku'=$LBObject.Sku.Name;                                         # Load balancer sku
                        'LBType'=$LBObjectType;                                             # Load balancer internal or external
                        'RGName'=$LBObject.ResourceGroupName;                               # Load balancer resource group
                        'Proto'=$_.Protocol;                                                # Rule protocol
                        'FEPort'=$_.FrontendPort;                                           # Front end port
                        'BEPort'=$_.BackendPort;                                            # Back end port
                        'Idle'=$_.IdleTimeoutInMinutes;                                     # Idle timeout
                        'LD'=$_.LoadDistribution;                                           # Load distribution
                        'TCP'=$_.EnableTcpReset;                                            # EnableTCPReset enabled
                        'EFIP'=$_.EnableFloatingIP;                                         # Floating IP enabled
                        'FEIP'=$_.FrontendIPConfiguration.ID;                               # Front end ID
                        'BEPool'=$_.BackendAddressPool.ID;                                  # Back end pool ID
                        'Probe'=$_.Probe.ID                                                 # Probe ID
                    }                                                                       # End $ObjectInput = [PSCustomObject]@
                    $ObjectArray.Add($ObjectInput) | Out-Null                               # Loads item into array
                    $ObjectNumber = $ObjectNumber + 1                                       # Increments $ObjectNumber by 1
                }                                                                           # End foreach ($_ in $RuleConfigList)
                $LBObject = $null                                                           # Clears $var
                $LBObjectType = $null                                                       # Clears $var
            }                                                                               # End foreach ($_ in $ObjectList)
            Clear-Host                                                                      # Clears screen
            if (!$ObjectArray) {                                                            # If $ObjectArray is $null    
                Write-Host 'No load balancer rule configs exist in this subscription'       # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break GetAzureLBRuleConfig                                                  # Breaks :GetAzureLBRuleConfig
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
                    Write-Host 'LB Name:       '$_.LBName                                   # Write message to screen
                    Write-Host 'LB Sku:        '$_.LBSku                                    # Write message to screen
                    Write-Host 'LB Type:       '$_.LBType                                   # Write message to screen       
                    Write-Host 'LB RG:         '$_.RGName                                   # Write message to screen
                    Write-Host 'Rule Protocol: '$_.Proto                                    # Write message to screen
                    Write-Host 'Front End Port:'$_.FEPort                                   # Write message to screen
                    Write-Host 'Back End Port: '$_.BEPort                                   # Write message to screen
                    Write-Host 'TO In Minutes: '$_.Idle                                     # Write message to screen
                    Write-Host 'Load Distro:   '$_.LD                                       # Write message to screen
                    Write-Host 'TCP Reset:     '$_.TCP                                      # Write message to screen
                    Write-Host 'Floating IP:   '$_.EFIP                                     # Write message to screen
                    if ($_.FEIP) {                                                          # If current item .FEIP has a value
                        $FEndName = $_.FEIP                                                 # Isolates the current item
                        $FEndName = $FEndName.Split('/')[-1]                                # Isolates the front end name
                        Write-Host 'Front End Name:'$FEndName                               # Write message to screen
                    }                                                                       # End if ($_.FEIP)
                    else {                                                                  # Else if current item .FEIP does not have value
                        Write-Host 'Front End Name: N/A'                                    # Write message to screen       
                    }                                                                       # End else (if ($_.BEPool))
                    if ($_.BEPool) {                                                        # If current item .BEPool has a value
                        $BPoolName = $_.BEPool                                              # Isolates the current item
                        $BPoolName = $BPoolName.Split('/')[-1]                              # Isolates the back end name
                        Write-Host 'Back End Name: '$BPoolName                              # Write message to screen
                    }                                                                       # End if ($_.BEPool)
                    else {                                                                  # Else if current item .BEPool does not have value
                        Write-Host 'Back End Name:  N/A'                                    # Write message to screen       
                    }                                                                       # End else (if ($_.BEPool))
                    if ($_.Probe) {                                                         # If current item .Probe has a value
                        $ProbeName = $_.Probe                                               # Isolates the current item
                        $ProbeName = $ProbeName.Split('/')[-1]                              # Isolates the front end name
                        Write-Host 'Probe Name:    '$ProbeName                              # Write message to screen
                    }                                                                       # End if ($_.Probe)
                    else {                                                                  # Else if current item .Probe does not have value
                        Write-Host 'Probe Name:     N/A'                                    # Write message to screen       
                    }                                                                       # End else (if ($_.Probe))
                    Write-Host ''                                                           # Write message to screen         
                }                                                                           # End foreach ($_ in $ObjectArray)
                if ($CallingFunction) {                                                     # If $CallingFunction has a value
                    Write-Host 'You are selecting the rule config for:'$CallingFunction     # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                }                                                                           # End if ($CallingFunction)
                $OpSelect = Read-Host 'Option [#]'                                          # Operator input to select the load balancer
                if ($OpSelect -eq '0') {                                                    # If $OpSelect equals 0
                    Break GetAzureLBRuleConfig                                              # Breaks :GetAzureLBRuleConfig
                }                                                                           # End if ($OpSelect -eq '0')
                elseif ($OpSelect -in $ObjectArray.Number) {                                # If $OpSelect in $ObjectArray.Number
                    $OpSelect = $ObjectArray | Where-Object {$_.Number -eq $OpSelect}       # $OpSelect is equal to $ObjectArray where $ObjectArray.Number equals $OpSelect
                    $LoadBalancerObject = Get-AzLoadBalancer -Name $OpSelect.LBName `
                        -ResourceGroupName $OPSelect.RGName                                 # Pulls the full load balancer object
                    $LBRuleObject = Get-AzLoadBalancerRuleConfig -LoadBalancer `
                        $LoadBalancerObject -Name $OpSelect.Name                            # Pulls the load balancer rule config object
                    Clear-Host                                                              # Clears screen
                    Return $LBRuleObject, $LoadBalancerObject                               # Returns to calling function with $vars
                }                                                                           # End elseif ($OpSelect -in $ObjectArray.Number) 
                else {                                                                      # All other inputs for $OpSelect
                    Write-Host 'That was not a valid input'                                 # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Clear-Host                                                              # Clears screen
                }                                                                           # End else (if ($OpSelect -eq '0'))
            }                                                                               # End :SelectAzureLBProbeConfig while ($true)
        }                                                                                   # End :GetAzureLBRuleConfig while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function GetAzLBRuleConfig
function RemoveAzLBRuleConfig {                                                             # Function to remove a load balancer rule config
    Begin {                                                                                 # Begin function
        if (!$CallingFunction) {                                                            # If $CallingFunction is $null
            $CallingFunction = 'RemoveAzLBRuleConfig'                                       # Creates $CallingFunction
        }                                                                                   # End if (!$CallingFunction)
        :RemoveAzureLBRuleConfig while ($true) {                                            # Outer loop for managing function
            $LBRuleObject, $LoadBalancerObject = GetAzLBRuleConfig ($CallingFunction)       # Calls function and assigns output to $var
            if (!$LBRuleObject) {                                                           # If $LBRuleObject is $null
                Break RemoveAzureLBRuleConfig                                               # Breaks :RemoveAzureLBRuleConfig
            }                                                                               # End if (!$LBRuleObject)
            Write-Host 'Remove the following:'                                              # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            Write-Host 'Config Name:'$LBRuleObject.Name                                     # Write message to screen
            Write-Host 'LB Name:    '$LoadBalancerObject.Name                               # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            $OpConfirm = Read-Host '[Y] Yes [N] No'                                         # Operator confirmation to remove the config
            if ($OpConfirm -eq 'y') {                                                       # If $OpConfirm equals 'y'
                Try {                                                                       # Try the following
                    Write-Host 'Removing the config'                                        # Write message to screen
                    Remove-AzLoadBalancerRuleConfig -LoadBalancer `
                        $LoadBalancerObject -Name $LBRuleObject.name `
                        -ErrorAction 'Stop' | Out-Null                                      # Removes the config
                    Write-Host 'Saving changes'                                             # Write message to screen
                    $LoadBalancerObject | Set-AzLoadBalancer -ErrorAction 'Stop'            # Saves the updated load balancer config
                }                                                                           # End Try
                Catch {                                                                     # If Try fails
                    Clear-Host                                                              # Clears screen
                    Write-Host 'An error has occured'                                       # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    Write-Host 'You may not have the permissions'                           # Write message to screen
                    Write-Host 'to perform this action'                                     # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Break RemoveAzureLBRuleConfig                                           # Breaks :RemoveAzureLBRuleConfig
                }                                                                           # End catch
                Clear-Host                                                                  # Clears screen
                Write-Host 'The configuration has been removed'                             # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break RemoveAzureLBRuleConfig                                               # Breaks :RemoveAzureLBRuleConfig
            }                                                                               # End if ($OpConfirm -eq 'y')
            else {                                                                          # All other inputs for $OpConfirm
                Write-Host 'No changes have been made'                                      # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break RemoveAzureLBRuleConfig                                               # Breaks :RemoveAzureLBRuleConfig
            }                                                                               # End else (if ($OpConfirm -eq 'y'))
        }                                                                                   # End :RemoveAzureLBRuleConfig while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function RemoveAzLBRuleConfig
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
                    if ($LBRuleObject.EnableFloatingIP -eq $True `
                        -and $LBRuleObject.EnableTcpReset -eq $True) {                      # If $LBRuleObject.EnableFloatingIP and $LBRuleObject.EnableTcpReset equal $true
                        Set-AzLoadBalancerRuleConfig `
                            -LoadBalancer $LoadBalancerObject `
                            -Name $LBRuleObject.Name `
                            -FrontendIpConfigurationId $LBFEObject.ID `
                            -Protocol $LBRuleObject.Protocol `
                            -FrontendPort $LBRuleObject.FrontendPort `
                            -BackendPort $LBRuleObject.BackEndPort `
                            -IdleTimeoutInMinutes $LBRuleObject.IdleTimeoutInMinutes `
                            -BackendAddressPoolId  $LBBackEndObject.ID `
                            -LoadDistribution $LBRuleObject.LoadDistribution `
                            -EnableTcpReset -EnableFloatingIP `
                            -ProbeID $LBRuleObject.Probe.ID -Verbose -ErrorAction `
                            'Stop' | Out-Null                                               # Changes the rule front end config
                    }                                                                       # End if ($LBRuleObject.EnableFloatingIP -eq $True -and $LBRuleObject.EnableTcpReset -eq $True)
                    elseif ($LBRuleObject.EnableFloatingIP -eq $True) {                     # Else if $LBRuleObject.EnableFloatingIP equals $True
                        Set-AzLoadBalancerRuleConfig `
                            -LoadBalancer $LoadBalancerObject `
                            -Name $LBRuleObject.Name `
                            -FrontendIpConfigurationId $LBFEObject.ID `
                            -Protocol $LBRuleObject.Protocol `
                            -FrontendPort $LBRuleObject.FrontendPort `
                            -BackendPort $LBRuleObject.BackEndPort `
                            -IdleTimeoutInMinutes $LBRuleObject.IdleTimeoutInMinutes `
                            -BackendAddressPoolId  $LBBackEndObject.ID `
                            -LoadDistribution $LBRuleObject.LoadDistribution `
                            -EnableFloatingIP `
                            -ProbeID $LBRuleObject.Probe.ID -Verbose -ErrorAction `
                            'Stop' | Out-Null                                               # Changes the rule front end config
                    }                                                                       # End elseif ($LBRuleObject.EnableFloatingIP -eq $True)
                    elseif ($LBRuleObject.EnableTcpReset -eq $true) {                       # Else if $LBRuleObject.EnableTcpReset equals $true
                        Set-AzLoadBalancerRuleConfig `
                            -LoadBalancer $LoadBalancerObject `
                            -Name $LBRuleObject.Name `
                            -FrontendIpConfigurationId $LBFEObject.ID `
                            -Protocol $LBRuleObject.Protocol `
                            -FrontendPort $LBRuleObject.FrontendPort `
                            -BackendPort $LBRuleObject.BackEndPort `
                            -IdleTimeoutInMinutes $LBRuleObject.IdleTimeoutInMinutes `
                            -BackendAddressPoolId  $LBBackEndObject.ID `
                            -LoadDistribution $LBRuleObject.LoadDistribution `
                            -EnableTcpReset `
                            -ProbeID $LBRuleObject.Probe.ID -Verbose -ErrorAction `
                            'Stop' | Out-Null                                               # Changes the rule front end config    
                    }                                                                       # End elseif ($LBRuleObject.EnableTcpReset -eq $true) 
                    else {                                                                  # Else if $LBRuleObject.EnableFloatingIP and $LBRuleObject.EnableTcpReset does not equal $true
                        Set-AzLoadBalancerRuleConfig `
                            -LoadBalancer $LoadBalancerObject `
                            -Name $LBRuleObject.Name `
                            -FrontendIpConfigurationId $LBFEObject.ID `
                            -Protocol $LBRuleObject.Protocol `
                            -FrontendPort $LBRuleObject.FrontendPort `
                            -BackendPort $LBRuleObject.BackEndPort `
                            -IdleTimeoutInMinutes $LBRuleObject.IdleTimeoutInMinutes `
                            -BackendAddressPoolId  $LBBackEndObject.ID `
                            -LoadDistribution $LBRuleObject.LoadDistribution `
                            -ProbeID $LBRuleObject.Probe.ID -Verbose -ErrorAction `
                            'Stop' | Out-Null                                               # Changes the rule front end config
                    }                                                                       # End Else (if ($LBFEObject.EnableFloatingIP -eq $True -and $LBFEObject.EnableTcpReset -eq $True))
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
function SetAzLBRuleBE {                                                                    # Function to change an existing load balancer rule back end config
    Begin {                                                                                 # Begin function
        if (!$CallingFunction) {                                                            # If $CallingFunction is $null
            $CallingFunction = 'SetAzLBRuleBE'                                              # Creates $CallingFunction
        }                                                                                   # End if (!$CallingFunction)
        :SetAzureLBRuleBE while ($true) {                                                   # Outer loop for managing function
            $LBRuleObject, $LoadBalancerObject = GetAzLBRuleConfig ($CallingFunction)       # Calls function and assigns output to $var
            if (!$LBRuleObject) {                                                           # If $LBRuleObject is $null
                Break SetAzureLBRuleBE                                                      # Breaks :SetAzureLBRuleBE
            }                                                                               # End if (!$LBRuleObject)
            $LBBEObject = GetAzLBRuleBE ($CallingFunction, $LoadBalancerObject)             # Calls function and assigns output to $var
            if (!$LBBEObject) {                                                             # If $LBBEObject is $null
                Break SetAzureLBRuleBE                                                      # Breaks :SetAzureLBRuleBE
            }                                                                               # End if (!$LBBEObject)
            if ($LBRuleObject.BackendAddressPool.ID) {                                      # If $LBRuleObject.BackendAddressPool.ID has a value
                $CurrentBEName = $LBRuleObject.BackendAddressPool.ID                        # Isolates the back end ID
                $CurrentBEName = $CurrentBEName.Split('/')[-1]                              # Isolates the back end name
                $CurrentBEObject = Get-AzLoadBalancerBackendAddressPool -LoadBalancer `
                    $LoadBalancerObject -Name $CurrentBEName                                # Gets the current back end info
            }                                                                               # End if ($LBRuleObject.BackendAddressPool.ID)
            Write-Host 'Make the following change'                                          # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            Write-Host 'Current Back End'                                                   # Write message to screen
            if ($CurrentBEObject.Name) {                                                    # If $CurrentBEObject.Name has a value
                Write-Host 'Name:    '$CurrentBEObject.Name                                 # Write message to screen
            }                                                                               # End if ($CurrentBEObject.Name)
            else {                                                                          # Else if $CurrentBEObject.Name is $null                                                                     
                Write-Host 'Name:     N/A'                                                  # Write message to screen
            }                                                                               # End else (if ($CurrentBEObject.Name))
            Write-Host ''                                                                   # Write message to screen
            Write-Host 'New Front End'                                                      # Write message to screen
            Write-Host 'Name:    '$LBBEObject.Name                                          # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            Write-Host 'Make this change'                                                   # Write message to screen
            $OpConfirm = Read-Host '[Y] Yes [N] No'                                         # Operator confrimation to change the rule back end
            Clear-Host                                                                      # Clears screen
            if ($OpConfirm -eq 'y') {                                                       # If $OPConfirm equals 'y'
                Write-Host 'Changing the rule back end configuration'                       # Write message to screen
                Try {                                                                       # Try the following
                    if ($LBRuleObject.EnableFloatingIP -eq $True `
                        -and $LBRuleObject.EnableTcpReset -eq $True) {                      # If $LBRuleObject.EnableFloatingIP and $LBRuleObject.EnableTcpReset equal $true
                        Set-AzLoadBalancerRuleConfig `
                            -LoadBalancer $LoadBalancerObject `
                            -Name $LBRuleObject.Name `
                            -FrontendIpConfigurationId `
                            $LBRuleObject.FrontendIpConfiguration.ID `
                            -Protocol $LBRuleObject.Protocol `
                            -FrontendPort $LBRuleObject.FrontendPort `
                            -BackendPort $LBRuleObject.BackEndPort `
                            -IdleTimeoutInMinutes $LBRuleObject.IdleTimeoutInMinutes `
                            -BackendAddressPoolId  $LBBEObject.ID `
                            -LoadDistribution $LBRuleObject.LoadDistribution `
                            -EnableTcpReset -EnableFloatingIP `
                            -ProbeID $LBRuleObject.Probe.ID -Verbose -ErrorAction `
                            'Stop' | Out-Null                                               # Changes the rule back end config
                    }                                                                       # End if ($LBRuleObject.EnableFloatingIP -eq $True -and $LBRuleObject.EnableTcpReset -eq $True)
                    elseif ($LBRuleObject.EnableFloatingIP -eq $True) {                     # Else if $LBRuleObject.EnableFloatingIP equals $True
                        Set-AzLoadBalancerRuleConfig `
                            -LoadBalancer $LoadBalancerObject `
                            -Name $LBRuleObject.Name `
                            -FrontendIpConfigurationId `
                            $LBRuleObject.FrontendIpConfiguration.ID `
                            -Protocol $LBRuleObject.Protocol `
                            -FrontendPort $LBRuleObject.FrontendPort `
                            -BackendPort $LBRuleObject.BackEndPort `
                            -IdleTimeoutInMinutes $LBRuleObject.IdleTimeoutInMinutes `
                            -BackendAddressPoolId  $LBBEObject.ID `
                            -LoadDistribution $LBRuleObject.LoadDistribution `
                            -EnableFloatingIP `
                            -ProbeID $LBRuleObject.Probe.ID -Verbose -ErrorAction `
                            'Stop' | Out-Null                                               # Changes the rule back end config
                    }                                                                       # End elseif ($LBRuleObject.EnableFloatingIP -eq $True)
                    elseif ($LBRuleObject.EnableTcpReset -eq $true) {                       # Else if $LBRuleObject.EnableTcpReset equals $true
                        Set-AzLoadBalancerRuleConfig `
                            -LoadBalancer $LoadBalancerObject `
                            -Name $LBRuleObject.Name `
                            -FrontendIpConfigurationId `
                            $LBRuleObject.FrontendIpConfiguration.ID `
                            -Protocol $LBRuleObject.Protocol `
                            -FrontendPort $LBRuleObject.FrontendPort `
                            -BackendPort $LBRuleObject.BackEndPort `
                            -IdleTimeoutInMinutes $LBRuleObject.IdleTimeoutInMinutes `
                            -BackendAddressPoolId  $LBBEObject.ID `
                            -LoadDistribution $LBRuleObject.LoadDistribution `
                            -EnableTcpReset `
                            -ProbeID $LBRuleObject.Probe.ID -Verbose -ErrorAction `
                            'Stop' | Out-Null                                               # Changes the rule back end config    
                    }                                                                       # End elseif ($LBRuleObject.EnableTcpReset -eq $true) 
                    else {                                                                  # Else if $LBRuleObject.EnableFloatingIP and $LBRuleObject.EnableTcpReset does not equal $true
                        Set-AzLoadBalancerRuleConfig `
                            -LoadBalancer $LoadBalancerObject `
                            -Name $LBRuleObject.Name `
                            -FrontendIpConfigurationId `
                            $LBRuleObject.FrontendIpConfiguration.ID `
                            -Protocol $LBRuleObject.Protocol `
                            -FrontendPort $LBRuleObject.FrontendPort `
                            -BackendPort $LBRuleObject.BackEndPort `
                            -IdleTimeoutInMinutes $LBRuleObject.IdleTimeoutInMinutes `
                            -BackendAddressPoolId  $LBBEObject.ID `
                            -LoadDistribution $LBRuleObject.LoadDistribution `
                            -ProbeID $LBRuleObject.Probe.ID -Verbose -ErrorAction `
                            'Stop' | Out-Null                                               # Changes the rule back end config
                    }                                                                       # End Else (if ($LBBEObject.EnableFloatingIP -eq $True -and $LBBEObject.EnableTcpReset -eq $True))
                    Write-Host 'Saving the load balancer configuration'                     # Write message to screen
                    $LoadBalancerObject | Set-AzLoadBalancer -ErrorAction 'Stop' | Out-Null # Saves the changes to $LoadBalancerObject
                }                                                                           # End try
                Catch {                                                                     # If try fails
                    Clear-Host                                                              # Clears screen
                    Write-Host 'An error has occured'                                       # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Break SetAzureLBRuleBE                                                  # Breaks :SetAzureLBRuleBE
                }                                                                           # End catch
                Clear-Host                                                                  # Clears screen
                Write-Host 'Requested changes have been made'                               # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break SetAzureLBRuleBE                                                      # Breaks :SetAzureLBRuleBE
            }                                                                               # End if ($OpConfirm -eq 'y')
            else  {                                                                         # All other inputs for $OpConfirm
                Break SetAzureLBRuleBE                                                      # Breaks :SetAzureLBRuleBE
            }                                                                               # End else (if ($OpConfirm -eq 'y'))
        }                                                                                   # End :SetAzureLBRuleBE while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function SetAzLBRuleBE
function RemoveAzLBRuleBE {                                                                 # Function to remove an existing load balancer rule back end config
    Begin {                                                                                 # Begin function
        if (!$CallingFunction) {                                                            # If $CallingFunction is $null
            $CallingFunction = 'RemoveAzLBRuleBE'                                           # Creates $CallingFunction
        }                                                                                   # End if (!$CallingFunction)
        :SetAzureLBRuleBE while ($true) {                                                   # Outer loop for managing function
            $LBRuleObject, $LoadBalancerObject = GetAzLBRuleConfig ($CallingFunction)       # Calls function and assigns output to $var
            if (!$LBRuleObject) {                                                           # If $LBRuleObject is $null
                Break SetAzureLBRuleBE                                                      # Breaks :SetAzureLBRuleBE
            }                                                                               # End if (!$LBRuleObject)
            if ($LBRuleObject.BackendAddressPool.ID) {                                      # If $LBRuleObject.BackendAddressPool.ID has a value
                $CurrentBEName = $LBRuleObject.BackendAddressPool.ID                        # Isolates the back end ID
                $CurrentBEName = $CurrentBEName.Split('/')[-1]                              # Isolates the back end name
                $CurrentBEObject = Get-AzLoadBalancerBackendAddressPool -LoadBalancer `
                    $LoadBalancerObject -Name $CurrentBEName                                # Gets the current back end info
            }                                                                               # End if ($LBRuleObject.BackendAddressPool.ID)
            else {                                                                          # Else if $LBRuleObject.BackendAddressPool.ID is $null
                Write-Host 'This rule does not have a'                                      # Write message to screen
                Write-Host 'back end associated to it'                                      # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Write-Host 'No changes have been made'                                      # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break SetAzureLBRuleBE                                                      # Breaks :SetAzureLBRuleBE    
            }                                                                               # End else (if ($LBRuleObject.BackendAddressPool.ID))
            Write-Host 'Remove the following'                                               # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            Write-Host 'Current Back End'                                                   # Write message to screen
            Write-Host 'Name:     '$CurrentBEObject.Name                                    # Write message to screen
            Write-Host 'LB Name:  '$LoadBalancerObject.Name                                 # Write message to screen
            Write-Host 'Rule Name:'$LBRuleObject.Name                                       # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            $OpConfirm = Read-Host '[Y] Yes [N] No'                                         # Operator confrimation to remove the rule back end
            Clear-Host                                                                      # Clears screen
            if ($OpConfirm -eq 'y') {                                                       # If $OPConfirm equals 'y'
                Write-Host 'Changing the rule front end configuration'                      # Write message to screen
                Try {                                                                       # Try the following
                    if ($LBRuleObject.EnableFloatingIP -eq $True `
                        -and $LBRuleObject.EnableTcpReset -eq $True) {                      # If $LBRuleObject.EnableFloatingIP and $LBRuleObject.EnableTcpReset equal $true
                        Set-AzLoadBalancerRuleConfig `
                            -LoadBalancer $LoadBalancerObject `
                            -Name $LBRuleObject.Name `
                            -FrontendIpConfigurationId `
                            $LBRuleObject.FrontendIpConfiguration.ID `
                            -Protocol $LBRuleObject.Protocol `
                            -FrontendPort $LBRuleObject.FrontendPort `
                            -BackendPort $LBRuleObject.BackEndPort `
                            -IdleTimeoutInMinutes $LBRuleObject.IdleTimeoutInMinutes `
                            -BackendAddressPoolId  $null `
                            -LoadDistribution $LBRuleObject.LoadDistribution `
                            -EnableTcpReset -EnableFloatingIP `
                            -ProbeID $LBRuleObject.Probe.ID -Verbose -ErrorAction `
                            'Stop' | Out-Null                                               # Removes the rule back end config
                    }                                                                       # End if ($LBRuleObject.EnableFloatingIP -eq $True -and $LBRuleObject.EnableTcpReset -eq $True)
                    elseif ($LBRuleObject.EnableFloatingIP -eq $True) {                     # Else if $LBRuleObject.EnableFloatingIP equals $True
                        Set-AzLoadBalancerRuleConfig `
                            -LoadBalancer $LoadBalancerObject `
                            -Name $LBRuleObject.Name `
                            -FrontendIpConfigurationId `
                            $LBRuleObject.FrontendIpConfiguration.ID `
                            -Protocol $LBRuleObject.Protocol `
                            -FrontendPort $LBRuleObject.FrontendPort `
                            -BackendPort $LBRuleObject.BackEndPort `
                            -IdleTimeoutInMinutes $LBRuleObject.IdleTimeoutInMinutes `
                            -BackendAddressPoolId  $null `
                            -LoadDistribution $LBRuleObject.LoadDistribution `
                            -EnableFloatingIP `
                            -ProbeID $LBRuleObject.Probe.ID -Verbose -ErrorAction `
                            'Stop' | Out-Null                                               # Removes the rule back end config
                    }                                                                       # End elseif ($LBRuleObject.EnableFloatingIP -eq $True)
                    elseif ($LBRuleObject.EnableTcpReset -eq $true) {                       # Else if $LBRuleObject.EnableTcpReset equals $true
                        Set-AzLoadBalancerRuleConfig `
                            -LoadBalancer $LoadBalancerObject `
                            -Name $LBRuleObject.Name `
                            -FrontendIpConfigurationId `
                            $LBRuleObject.FrontendIpConfiguration.ID `
                            -Protocol $LBRuleObject.Protocol `
                            -FrontendPort $LBRuleObject.FrontendPort `
                            -BackendPort $LBRuleObject.BackEndPort `
                            -IdleTimeoutInMinutes $LBRuleObject.IdleTimeoutInMinutes `
                            -BackendAddressPoolId  $null `
                            -LoadDistribution $LBRuleObject.LoadDistribution `
                            -EnableTcpReset `
                            -ProbeID $LBRuleObject.Probe.ID -Verbose -ErrorAction `
                            'Stop' | Out-Null                                               # Removes the rule back end config    
                    }                                                                       # End elseif ($LBRuleObject.EnableTcpReset -eq $true) 
                    else {                                                                  # Else if $LBRuleObject.EnableFloatingIP and $LBRuleObject.EnableTcpReset does not equal $true
                        Set-AzLoadBalancerRuleConfig `
                            -LoadBalancer $LoadBalancerObject `
                            -Name $LBRuleObject.Name `
                            -FrontendIpConfigurationId `
                            $LBRuleObject.FrontendIpConfiguration.ID `
                            -Protocol $LBRuleObject.Protocol `
                            -FrontendPort $LBRuleObject.FrontendPort `
                            -BackendPort $LBRuleObject.BackEndPort `
                            -IdleTimeoutInMinutes $LBRuleObject.IdleTimeoutInMinutes `
                            -BackendAddressPoolId  $null `
                            -LoadDistribution $LBRuleObject.LoadDistribution `
                            -ProbeID $LBRuleObject.Probe.ID -Verbose -ErrorAction `
                            'Stop' | Out-Null                                               # Removes the rule back end config
                    }                                                                       # End Else (if ($LBBEObject.EnableFloatingIP -eq $True -and $LBBEObject.EnableTcpReset -eq $True))
                    Write-Host 'Saving the load balancer configuration'                     # Write message to screen
                    $LoadBalancerObject | Set-AzLoadBalancer -ErrorAction 'Stop' | Out-Null # Saves the changes to $LoadBalancerObject
                }                                                                           # End try
                Catch {                                                                     # If try fails
                    Clear-Host                                                              # Clears screen
                    Write-Host 'An error has occured'                                       # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Break SetAzureLBRuleBE                                                  # Breaks :SetAzureLBRuleBE
                }                                                                           # End catch
                Clear-Host                                                                  # Clears screen
                Write-Host 'Requested changes have been made'                               # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break SetAzureLBRuleBE                                                      # Breaks :SetAzureLBRuleBE
            }                                                                               # End if ($OpConfirm -eq 'y')
            else  {                                                                         # All other inputs for $OpConfirm
                Break SetAzureLBRuleBE                                                      # Breaks :SetAzureLBRuleBE
            }                                                                               # End else (if ($OpConfirm -eq 'y'))
        }                                                                                   # End :SetAzureLBRuleBE while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function RemoveAzLBRuleBE
function SetAzLBRuleProbe {                                                                 # Function to change an existing load balancer rule probe config
    Begin {                                                                                 # Begin function
        if (!$CallingFunction) {                                                            # If $CallingFunction is $null
            $CallingFunction = 'SetAzLBRuleProbe'                                           # Creates $CallingFunction
        }                                                                                   # End if (!$CallingFunction)
        :SetAzureLBRuleProbe while ($true) {                                                # Outer loop for managing function
            $LBRuleObject, $LoadBalancerObject = GetAzLBRuleConfig ($CallingFunction)       # Calls function and assigns output to $var
            if (!$LBRuleObject) {                                                           # If $LBRuleObject is $null
                Break SetAzureLBRuleProbe                                                   # Breaks :SetAzureLBRuleProbe
            }                                                                               # End if (!$LBRuleObject)
            $LBProbeObject = GetAzLBRuleProbe ($CallingFunction, $LoadBalancerObject)       # Calls function and assigns output to $var
            if (!$LBProbeObject) {                                                          # If $LBProbeObject is $null
                Break SetAzureLBRuleProbe                                                   # Breaks :SetAzureLBRuleProbe
            }                                                                               # End if (!$LBProbeObject)
            $CurrentProbeName = $LBRuleObject.Probe.ID                                      # Isolates the probe ID
            $CurrentProbeName = $CurrentProbeName.Split('/')[-1]                            # Isolates the probe name
            $CurrentProbeObject = Get-AzLoadBalancerProbeConfig -LoadBalancer `
                $LoadBalancerObject -Name $CurrentProbeName                                 # Gets the current probe info
            Write-Host 'Make the following change'                                          # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            Write-Host 'Current Probe'                                                      # Write message to screen
            Write-Host 'Name:    '$CurrentProbeObject.Name                                  # Write message to screen
            Write-Host 'Protocol:'$CurrentProbeObject.Protocol                              # Write message to screen
            Write-Host 'Port:    '$CurrentProbeObject.Port                                  # Write message to screen
            Write-Host 'Interval:'$CurrentProbeObject.IntervalInSeconds                     # Write message to screen
            Write-Host 'Count:   '$CurrentProbeObject.NumberOfProbes                        # Write message to screen
            if ($CurrentProbeObject.RequestPath) {                                          # If $CurrentProbeObject.RequestPath has a value
                Write-Host 'RPath:   '$CurrentProbeObject.RequestPath                       # Write message to screen
            }                                                                               # End if ($CurrentProbeObject.RequestPath)
            else {                                                                          # Else if $CurrentProbeObject.RequestPath is $null
                Write-Host 'RPath:    N/A'                                                  # Write message to screen
            }                                                                               # End else (if ($CurrentProbeObject.RequestPath))
            Write-Host ''                                                                   # Write message to screen
            Write-Host 'New Probe'                                                          # Write message to screen
            Write-Host 'Name:    '$LBProbeObject.Name                                       # Write message to screen
            Write-Host 'Protocol:'$LBProbeObject.Protocol                                   # Write message to screen
            Write-Host 'Port:    '$LBProbeObject.Port                                       # Write message to screen
            Write-Host 'Interval:'$LBProbeObject.IntervalInSeconds                          # Write message to screen
            Write-Host 'Count:   '$LBProbeObject.NumberOfProbes                             # Write message to screen
            if ($LBProbeObject.RequestPath) {                                               # If $LBProbeObject.RequestPath has a value
                Write-Host 'RPath:   '$LBProbeObject.RequestPath                            # Write message to screen
            }                                                                               # End if ($LBProbeObject.RequestPath)
            else {                                                                          # Else if $LBProbeObject.RequestPath is $null
                Write-Host 'RPath:    N/A'                                                  # Write message to screen
            }                                                                               # End else (if ($LBProbeObject.RequestPath))
            Write-Host ''                                                                   # Write message to screen
            Write-Host 'Make this change'                                                   # Write message to screen
            $OpConfirm = Read-Host '[Y] Yes [N] No'                                         # Operator confrimation to change the rule probe
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
                Write-Host 'Changing the rule probe configuration'                          # Write message to screen
                Try {                                                                       # Try the following
                    if ($LBRuleObject.EnableFloatingIP -eq $True `
                        -and $LBRuleObject.EnableTcpReset -eq $True) {                      # If $LBRuleObject.EnableFloatingIP and $LBRuleObject.EnableTcpReset equal $true
                        Set-AzLoadBalancerRuleConfig `
                            -LoadBalancer $LoadBalancerObject `
                            -Name $LBRuleObject.Name `
                            -FrontendIpConfigurationId `
                            $LBRuleObject.FrontendIPConfiguration.ID `
                            -Protocol $LBRuleObject.Protocol `
                            -FrontendPort $LBRuleObject.FrontendPort `
                            -BackendPort $LBRuleObject.BackEndPort `
                            -IdleTimeoutInMinutes $LBRuleObject.IdleTimeoutInMinutes `
                            -BackendAddressPoolId  $LBBackEndObject.ID `
                            -LoadDistribution $LBRuleObject.LoadDistribution `
                            -EnableTcpReset -EnableFloatingIP `
                            -ProbeID $LBProbeObject.ID -Verbose -ErrorAction `
                            'Stop' | Out-Null                                               # Changes the rule probe config
                    }                                                                       # End if ($LBRuleObject.EnableFloatingIP -eq $True -and $LBRuleObject.EnableTcpReset -eq $True)
                    elseif ($LBRuleObject.EnableFloatingIP -eq $True) {                     # Else if $LBRuleObject.EnableFloatingIP equals $True
                        Set-AzLoadBalancerRuleConfig `
                            -LoadBalancer $LoadBalancerObject `
                            -Name $LBRuleObject.Name `
                            -FrontendIpConfigurationId `
                            $LBRuleObject.FrontendIPConfiguration.ID `
                            -Protocol $LBRuleObject.Protocol `
                            -FrontendPort $LBRuleObject.FrontendPort `
                            -BackendPort $LBRuleObject.BackEndPort `
                            -IdleTimeoutInMinutes $LBRuleObject.IdleTimeoutInMinutes `
                            -BackendAddressPoolId  $LBBackEndObject.ID `
                            -LoadDistribution $LBRuleObject.LoadDistribution `
                            -EnableFloatingIP `
                            -ProbeID $LBProbeObject.ID -Verbose -ErrorAction `
                            'Stop' | Out-Null                                               # Changes the rule probe config
                    }                                                                       # End elseif ($LBRuleObject.EnableFloatingIP -eq $True)
                    elseif ($LBRuleObject.EnableTcpReset -eq $true) {                       # Else if $LBRuleObject.EnableTcpReset equals $true
                        Set-AzLoadBalancerRuleConfig `
                            -LoadBalancer $LoadBalancerObject `
                            -Name $LBRuleObject.Name `
                            -FrontendIpConfigurationId `
                            $LBRuleObject.FrontendIPConfiguration.ID `
                            -Protocol $LBRuleObject.Protocol `
                            -FrontendPort $LBRuleObject.FrontendPort `
                            -BackendPort $LBRuleObject.BackEndPort `
                            -IdleTimeoutInMinutes $LBRuleObject.IdleTimeoutInMinutes `
                            -BackendAddressPoolId  $LBBackEndObject.ID `
                            -LoadDistribution $LBRuleObject.LoadDistribution `
                            -EnableTcpReset `
                            -ProbeID $LBProbeObject.ID -Verbose -ErrorAction `
                            'Stop' | Out-Null                                               # Changes the rule probe config    
                    }                                                                       # End elseif ($LBRuleObject.EnableTcpReset -eq $true) 
                    else {                                                                  # Else if $LBRuleObject.EnableFloatingIP and $LBRuleObject.EnableTcpReset does not equal $true
                        Set-AzLoadBalancerRuleConfig `
                            -LoadBalancer $LoadBalancerObject `
                            -Name $LBRuleObject.Name `
                            -FrontendIpConfigurationId `
                            $LBRuleObject.FrontendIPConfiguration.ID `
                            -Protocol $LBRuleObject.Protocol `
                            -FrontendPort $LBRuleObject.FrontendPort `
                            -BackendPort $LBRuleObject.BackEndPort `
                            -IdleTimeoutInMinutes $LBRuleObject.IdleTimeoutInMinutes `
                            -BackendAddressPoolId  $LBBackEndObject.ID `
                            -LoadDistribution $LBRuleObject.LoadDistribution `
                            -ProbeID $LBProbeObject.ID -Verbose -ErrorAction `
                            'Stop' | Out-Null                                               # Changes the rule probe config
                    }                                                                       # End Else (if ($LBProbeObject.EnableFloatingIP -eq $True -and $LBProbeObject.EnableTcpReset -eq $True))
                    Write-Host 'Saving the load balancer configuration'                     # Write message to screen
                    $LoadBalancerObject | Set-AzLoadBalancer -ErrorAction 'Stop' | Out-Null # Saves the changes to $LoadBalancerObject
                }                                                                           # End try
                Catch {                                                                     # If try fails
                    Clear-Host                                                              # Clears screen
                    Write-Host 'An error has occured'                                       # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Break SetAzureLBRuleProbe                                               # Breaks :SetAzureLBRuleProbe
                }                                                                           # End catch
                Clear-Host                                                                  # Clears screen
                Write-Host 'Requested changes have been made'                               # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break SetAzureLBRuleProbe                                                   # Breaks :SetAzureLBRuleProbe
            }                                                                               # End if ($OpConfirm -eq 'y')
            else  {                                                                         # All other inputs for $OpConfirm
                Break SetAzureLBRuleProbe                                                   # Breaks :SetAzureLBRuleProbe
            }                                                                               # End else (if ($OpConfirm -eq 'y'))
        }                                                                                   # End :SetAzureLBRuleProbe while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function SetAzLBRuleProbe
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
            if ($LoadBalancerObject.Sku.Name -eq 'Standard' -and `
                !$LoadBalancerObject.FrontendIpConfigurations.PublicIPAddress.ID) {         # If $LoadBalancerObject.Sku.Name equals 'Standard' and $LoadBalancerObject.FrontendIpConfigurations.PublicIPAddress.ID is $null
                $HAAvail = 'y'                                                              # Sets $HAAvail
                $LBRuleFEID = $LBRuleObject.FrontendIPConfiguration.ID                      # $LBRuleFEID is equal to $LBRuleObject.FrontendIPConfiguration.ID
                $LBRuleFEName = $LBRuleFEID.Split('/')[-1]                                  # Isolates the front end name
                $LBRuleFE = Get-AzLoadBalancerFrontendIpConfig -LoadBalancer `
                    $LoadBalancerObject -Name $LBRuleFEName                                 # Gets the front end object
                if ($LBRuleFE.InboundNatRules) {                                            # If $LBRuleFE.InboundNatRules has a value
                    $HAAvail = 'n'                                                          # Sets $HAAvail
                }                                                                           # End if ($LBRuleFE.InboundNatRules)
                $LBRuleFERules = $LBRuleFE.LoadBalancingRules                               # $LBRuleFERules is equal to $LBRuleFE.LoadBalancingRules
                foreach ($_ in $LBRuleFERules) {                                            # For each item in $LBRuleFERules
                    if ($_.ID -ne $LBRuleObject.ID) {                                       # If current item if .ID not equal to $LBRuleObject.ID
                        $HAAvail = 'n'                                                      # Sets $HAAvail
                    }                                                                       # End if ($_.ID -ne $LBRuleObject.ID)
                }                                                                           # End foreach ($_ in $LBRuleFERules)
            }                                                                               # End if ($LoadBalancerObject.Sku.Name -eq 'Standard' -and !$LoadBalancerObject.FrontendIpConfigurations.PublicIPAddress.ID)
            :NewAzureLBRuleProtocol while ($true) {                                         # Inner loop for setting the rule load disto
                Write-Host 'Rule Name:    '$LBRuleObject.name                               # Write message to screen
                Write-Host 'Load Balancer:'$LoadBalancerObject.name                         # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Write-Host 'Rule Protocol Options'                                          # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Write-Host '[0] Exit'                                                       # Write message to screen
                Write-Host '[1] TCP'                                                        # Write message to screen
                Write-Host '[2] UDP'                                                        # Write message to screen
                if ($HAAvail -eq 'y') {                                                     # If $HAAvail equals 'y'
                    Write-Host '[3] HA (All)'                                               # Write message to screen
                }                                                                           # End if ($HAAvail -eq 'y')
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
                Break SetAzureLBRuleProtocol                                                # Breaks :SetAzureLBRuleProtocol
            }                                                                               # End catch
            Clear-Host                                                                      # Clears screen
            Write-Host 'Requested changes have been made'                                   # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            Pause                                                                           # Pauses all actions for operator input
            Break SetAzureLBRuleProtocol                                                    # Breaks :SetAzureLBRuleProtocol
        }                                                                                   # End :SetAzureLBRuleProtocol while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function SetAzLBRuleProtocol
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
            $ValidArray = '0123456789'                                                      # Creates a string of valid characters
            $ValidArray = $ValidArray.ToCharArray()                                         # Loads all valid characters into array
            :NewAzureLBRuleFEPort while ($true) {                                           # Inner loop for setting the rule front end port
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
                        Break SetAzureLBRuleFEPort                                          # Breaks :SetAzureLBRuleFEPort
                    }                                                                       # End if ($OpConfirm -eq 'e')
                    if ($OpConfirm -eq 'y') {                                               # If $OpConfirm equals 'y'
                        Break NewAzureLBRuleFEPort                                          # Breaks :NewAzureLBRuleFEPort        
                    }                                                                       # End if ($OpConfirm -eq 'y')
                }                                                                           # End if ($LBRuleFrontEndPort)
                else {                                                                      # Else if $LBRuleFrontEndPort is $null
                    Write-Host 'That was not a valid input'                                 # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Clear-Host                                                              # Clears screen
                }                                                                           # End else (if ($LBRuleFrontEndPort))
            }                                                                               # End :NewAzureLBRuleFEPort while ($true)
            Write-Host 'Changing the rule front end port'                                   # Write message to screen
            Try {                                                                           # Try the following
                if ($LBRuleObject.EnableFloatingIP -eq $True `
                    -and $LBRuleObject.EnableTcpReset -eq $True) {                          # If $LBRuleObject.EnableFloatingIP and $LBRuleObject.EnableTcpReset equal $true
                    Set-AzLoadBalancerRuleConfig `
                        -LoadBalancer $LoadBalancerObject `
                        -Name $LBRuleObject.Name `
                        -FrontendIpConfigurationId `
                        $LBRuleObject.FrontendIpConfiguration.ID `
                        -Protocol $LBRuleObject.Protocol `
                        -FrontendPort $LBRuleFrontEndPort `
                        -BackendPort $LBRuleObject.BackEndPort `
                        -IdleTimeoutInMinutes  $LBRuleObject.IdleTimeoutInMinutes `
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
                        -FrontendPort $LBRuleFrontEndPort `
                        -BackendPort $LBRuleObject.BackEndPort `
                        -IdleTimeoutInMinutes  $LBRuleObject.IdleTimeoutInMinutes `
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
                        -FrontendPort $LBRuleFrontEndPort `
                        -BackendPort $LBRuleObject.BackEndPort `
                        -IdleTimeoutInMinutes  $LBRuleObject.IdleTimeoutInMinutes `
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
                        -FrontendPort $LBRuleFrontEndPort `
                        -BackendPort $LBRuleObject.BackEndPort `
                        -IdleTimeoutInMinutes  $LBRuleObject.IdleTimeoutInMinutes `
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
                if ($LBRuleObject.EnableFloatingIP -eq $True `
                    -and $LBRuleObject.EnableTcpReset -eq $True) {                          # If $LBRuleObject.EnableFloatingIP and $LBRuleObject.EnableTcpReset equal $true
                    Set-AzLoadBalancerRuleConfig `
                        -LoadBalancer $LoadBalancerObject `
                        -Name $LBRuleObject.Name `
                        -FrontendIpConfigurationId `
                        $LBRuleObject.FrontendIpConfiguration.ID `
                        -Protocol $LBRuleObject.Protocol `
                        -FrontendPort $LBRuleObject.FrontendPort `
                        -BackendPort  $LBRuleBackEndPort `
                        -IdleTimeoutInMinutes  $LBRuleObject.IdleTimeoutInMinutes `
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
                        -BackendPort  $LBRuleBackEndPort `
                        -IdleTimeoutInMinutes  $LBRuleObject.IdleTimeoutInMinutes `
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
                        -BackendPort  $LBRuleBackEndPort `
                        -IdleTimeoutInMinutes  $LBRuleObject.IdleTimeoutInMinutes `
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
                        -BackendPort  $LBRuleBackEndPort `
                        -IdleTimeoutInMinutes  $LBRuleObject.IdleTimeoutInMinutes `
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
function SetAzLBRuleLoadDisto {                                                             # Function to change an existing load balancer rule load distribution
    Begin {                                                                                 # Begin function
        if (!$CallingFunction) {                                                            # If $CallingFunction is $null
            $CallingFunction = 'SetAzLBRuleLoadDisto'                                       # Creates $CallingFunction
        }                                                                                   # End if (!$CallingFunction)
        :SetAzureLBRuleLoadDisto while ($true) {                                            # Outer loop for managing function
            $LBRuleObject, $LoadBalancerObject = GetAzLBRuleConfig ($CallingFunction)       # Calls function and assigns output to $var
            if (!$LBRuleObject) {                                                           # If $LBRuleObject is $null
                Break SetAzureLBRuleLoadDisto                                               # Breaks :SetAzureLBRuleLoadDisto
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
            :NewAzureLBRuleLoadDisto while ($true) {                                        # Inner loop for setting the rule load disto
                Write-Host 'Rule Name:    '$LBRuleObject.name                               # Write message to screen
                Write-Host 'Load Balancer:'$LoadBalancerObject.name                         # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Write-Host 'Load distribution options'                                      # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Write-Host '[0] Exit'                                                       # Write message to screen
                Write-Host '[1] Default'                                                    # Write message to screen
                Write-Host '[2] Source IP'                                                  # Write message to screen
                Write-Host '[3] Source IP + Port'                                           # Write message to screen
                Write-Host ''                                                               # Write message to screen
                $OpSelect = Read-Host 'Option [#]'                                          # Operator input to select load disto
                Clear-Host                                                                  # Clears screen
                if ($OpSelect -eq '0') {                                                    # If $OpSelect equals '0'
                    Break SetAzureLBRuleLoadDisto                                           # Breaks SetAzureLBRuleLoadDisto
                }                                                                           # End if ($OpSelect -eq '0')
                elseif ($OpSelect -eq '1') {                                                # Else if $OpSelect equals '1'
                    $LBRuleLoadDisto = 'Default'                                            # Sets $LBRuleLoadDisto
                    Break NewAzureLBRuleLoadDisto                                           # Breaks :NewAzureLBRuleLoadDisto
                }                                                                           # End elseif ($OpSelect -eq '1')
                elseif ($OpSelect -eq '2') {                                                # Else if $OpSelect equals '2'
                    $LBRuleLoadDisto = 'SourceIP'                                           # Sets $LBRuleLoadDisto
                    Break NewAzureLBRuleLoadDisto                                           # Breaks :NewAzureLBRuleLoadDisto
                }                                                                           # End elseif ($OpSelect -eq '2')
                elseif ($OpSelect -eq '3') {                                                # Else if $OpSelect equals '3'
                    $LBRuleLoadDisto = 'SourceIPProtocol'                                   # Sets $LBRuleLoadDisto
                    Break NewAzureLBRuleLoadDisto                                           # Breaks :NewAzureLBRuleLoadDisto
                }                                                                           # End elseif ($OpSelect -eq '3')
                else {                                                                      # All other inputs for $OpSelect
                    Write-Host 'That was not a valid input'                                 # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Clear-Host                                                              # Clears screen
                }                                                                           # End else (if ($OpSelect -eq '0'))
            }                                                                               # End :NewAzureLBRuleLoadDisto while ($true)

            Write-Host 'Changing the rule load distribution'                                # Write message to screen
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
                        -BackendPort  $LBRuleObject.BackEndPort `
                        -IdleTimeoutInMinutes  $LBRuleObject.IdleTimeoutInMinutes `
                        -BackendAddressPoolId  $CurrentBEID `
                        -LoadDistribution $LBRuleLoadDisto `
                        -EnableTcpReset -EnableFloatingIP `
                        -ProbeID $LBRuleObject.Probe.ID -Verbose -ErrorAction `
                        'Stop' | Out-Null                                                   # Changes the rule load disto
                }                                                                           # End if ($LBRuleObject.EnableFloatingIP -eq $True -and $LBRuleObject.EnableTcpReset -eq $True)
                elseif ($LBRuleObject.EnableFloatingIP -eq $True) {                         # Else if $LBRuleObject.EnableFloatingIP equals $True
                    Set-AzLoadBalancerRuleConfig `
                        -LoadBalancer $LoadBalancerObject `
                        -Name $LBRuleObject.Name `
                        -FrontendIpConfigurationId `
                        $LBRuleObject.FrontendIpConfiguration.ID `
                        -Protocol $LBRuleObject.Protocol `
                        -FrontendPort $LBRuleObject.FrontendPort `
                        -BackendPort  $LBRuleObject.BackEndPort `
                        -IdleTimeoutInMinutes  $LBRuleObject.IdleTimeoutInMinutes `
                        -BackendAddressPoolId  $CurrentBEID `
                        -LoadDistribution $LBRuleLoadDisto `
                        -EnableFloatingIP `
                        -ProbeID $LBRuleObject.Probe.ID -Verbose -ErrorAction `
                        'Stop' | Out-Null                                                   # Changes the rule load disto
                }                                                                           # End elseif ($LBRuleObject.EnableFloatingIP -eq $True)
                elseif ($LBRuleObject.EnableTcpReset -eq $true) {                           # Else if $LBRuleObject.EnableTcpReset equals $true
                    Set-AzLoadBalancerRuleConfig `
                        -LoadBalancer $LoadBalancerObject `
                        -Name $LBRuleObject.Name `
                        -FrontendIpConfigurationId `
                        $LBRuleObject.FrontendIpConfiguration.ID `
                        -Protocol $LBRuleObject.Protocol `
                        -FrontendPort $LBRuleObject.FrontendPort `
                        -BackendPort  $LBRuleObject.BackEndPort `
                        -IdleTimeoutInMinutes  $LBRuleObject.IdleTimeoutInMinutes `
                        -BackendAddressPoolId  $CurrentBEID `
                        -LoadDistribution $LBRuleLoadDisto `
                        -EnableTcpReset `
                        -ProbeID $LBRuleObject.Probe.ID -Verbose -ErrorAction `
                        'Stop' | Out-Null                                                   # Changes the rule load disto    
                }                                                                           # End elseif ($LBRuleObject.EnableTcpReset -eq $true) 
                else {                                                                      # Else if $LBRuleObject.EnableFloatingIP and $LBRuleObject.EnableTcpReset does not equal $true
                    Set-AzLoadBalancerRuleConfig `
                        -LoadBalancer $LoadBalancerObject `
                        -Name $LBRuleObject.Name `
                        -FrontendIpConfigurationId `
                        $LBRuleObject.FrontendIpConfiguration.ID `
                        -Protocol $LBRuleObject.Protocol `
                        -FrontendPort $LBRuleObject.FrontendPort `
                        -BackendPort  $LBRuleObject.BackEndPort `
                        -IdleTimeoutInMinutes  $LBRuleObject.IdleTimeoutInMinutes `
                        -BackendAddressPoolId  $CurrentBEID `
                        -LoadDistribution $LBRuleLoadDisto `
                        -ProbeID $LBRuleObject.Probe.ID -Verbose -ErrorAction `
                        'Stop' | Out-Null                                                   # Changes the rule load disto
                }                                                                           # End Else (if ($LBBEObject.EnableFloatingIP -eq $True -and $LBBEObject.EnableTcpReset -eq $True))
                Write-Host 'Saving the load balancer configuration'                         # Write message to screen
                $LoadBalancerObject | Set-AzLoadBalancer -ErrorAction 'Stop' | Out-Null     # Saves the changes to $LoadBalancerObject
            }                                                                               # End try
            Catch {                                                                         # If try fails
                Clear-Host                                                                  # Clears screen
                Write-Host 'An error has occured'                                           # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break SetAzureLBRuleLoadDisto                                               # Breaks :SetAzureLBRuleLoadDisto
            }                                                                               # End catch
            Clear-Host                                                                      # Clears screen
            Write-Host 'Requested changes have been made'                                   # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            Pause                                                                           # Pauses all actions for operator input
            Break SetAzureLBRuleLoadDisto                                                   # Breaks :SetAzureLBRuleLoadDisto
        }                                                                                   # End :SetAzureLBRuleLoadDisto while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function SetAzLBRuleLoadDisto
function SetAzLBRuleTCPReset {                                                              # Function to change an existing load balancer rule TCP reset
    Begin {                                                                                 # Begin function
        if (!$CallingFunction) {                                                            # If $CallingFunction is $null
            $CallingFunction = 'SetAzLBRuleTCPReset'                                        # Creates $CallingFunction
        }                                                                                   # End if (!$CallingFunction)
        :SetAzureLBRuleTCPReset while ($true) {                                             # Outer loop for managing function
            $LBRuleObject, $LoadBalancerObject = GetAzLBRuleConfig ($CallingFunction)       # Calls function and assigns output to $var
            if (!$LBRuleObject) {                                                           # If $LBRuleObject is $null
                Break SetAzureLBRuleTCPReset                                                # Breaks :SetAzureLBRuleTCPReset
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
            :NewAzureLBRuleTCPReset while ($true) {                                         # Inner loop for setting the rule tcp reset
                Write-Host 'Rule Name:    '$LBRuleObject.name                               # Write message to screen
                Write-Host 'Load Balancer:'$LoadBalancerObject.name                         # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Write-Host 'TCP reset options'                                              # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Write-Host '[0] Exit'                                                       # Write message to screen
                Write-Host '[1] Disabled'                                                   # Write message to screen
                Write-Host '[2] Enabled'                                                    # Write message to screen
                Write-Host ''                                                               # Write message to screen
                $OpSelect = Read-Host 'Option [#]'                                          # Operator input to select load disto
                Clear-Host                                                                  # Clears screen
                if ($OpSelect -eq '0') {                                                    # If $OpSelect equals '0'
                    Break SetAzureLBRuleTCPReset                                            # Breaks SetAzureLBRuleTCPReset
                }                                                                           # End if ($OpSelect -eq '0')
                elseif ($OpSelect -eq '1') {                                                # Else if $OpSelect equals '1'
                    $TCPReset = 'Disabled'                                                  # Sets $TCPReset
                    Break NewAzureLBRuleTCPReset                                            # Breaks :NewAzureLBRuleTCPReset
                }                                                                           # End elseif ($OpSelect -eq '1')
                elseif ($OpSelect -eq '2') {                                                # Else if $OpSelect equals '2'
                    $TCPReset = 'Enabled'                                                   # Sets $TCPReset
                    Break NewAzureLBRuleTCPReset                                            # Breaks :NewAzureLBRuleTCPReset
                }                                                                           # End elseif ($OpSelect -eq '2')
                else {                                                                      # All other inputs for $OpSelect
                    Write-Host 'That was not a valid input'                                 # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Clear-Host                                                              # Clears screen
                }                                                                           # End else (if ($OpSelect -eq '0'))
            }                                                                               # End :NewAzureLBRuleTCPReset while ($true)
            Try {                                                                           # Try the following
                if ($LBRuleObject.EnableFloatingIP -eq $True `
                    -and $TCPReset -eq 'Enabled') {                                         # If $LBRuleObject.EnableFloatingIP equals $True and $TCPReset equals 'Enabled'    
                    Write-Host 'Enabling TCP reset'                                         # Write message to screen
                    Set-AzLoadBalancerRuleConfig `
                        -LoadBalancer $LoadBalancerObject `
                        -Name $LBRuleObject.Name `
                        -FrontendIpConfigurationId `
                        $LBRuleObject.FrontendIpConfiguration.ID `
                        -Protocol $LBRuleObject.Protocol `
                        -FrontendPort $LBRuleObject.FrontendPort `
                        -BackendPort  $LBRuleObject.BackEndPort `
                        -IdleTimeoutInMinutes  $LBRuleObject.IdleTimeoutInMinutes `
                        -BackendAddressPoolId  $CurrentBEID `
                        -LoadDistribution $LBRuleLoadDisto `
                        -EnableTcpReset -EnableFloatingIP `
                        -ProbeID $LBRuleObject.Probe.ID -Verbose -ErrorAction `
                        'Stop' | Out-Null                                                   # Changes the rule TCP reset
                }                                                                           # End if ($LBRuleObject.EnableFloatingIP -eq $True -and $TCPReset -eq 'Enabled')
                elseif ($LBRuleObject.EnableFloatingIP -eq $True `
                    -and $TCPReset -eq 'Disabled') {                                        # Else if $LBRuleObject.EnableFloatingIP equals $True and $TCPReset equals 'Disabled'
                    Write-Host 'Disabling TCP reset'                                        # Write message to screen
                    Set-AzLoadBalancerRuleConfig `
                        -LoadBalancer $LoadBalancerObject `
                        -Name $LBRuleObject.Name `
                        -FrontendIpConfigurationId `
                        $LBRuleObject.FrontendIpConfiguration.ID `
                        -Protocol $LBRuleObject.Protocol `
                        -FrontendPort $LBRuleObject.FrontendPort `
                        -BackendPort  $LBRuleObject.BackEndPort `
                        -IdleTimeoutInMinutes  $LBRuleObject.IdleTimeoutInMinutes `
                        -BackendAddressPoolId  $CurrentBEID `
                        -LoadDistribution $LBRuleLoadDisto `
                        -EnableFloatingIP `
                        -ProbeID $LBRuleObject.Probe.ID -Verbose -ErrorAction `
                        'Stop' | Out-Null                                                   # Changes the rule TCP reset
                }                                                                           # End elseif ($LBRuleObject.EnableFloatingIP -eq $True -and $TCPReset -eq 'Disabled')
                elseif ($LBRuleObject.EnableFloatingIP -eq $false `
                    -and $TCPReset -eq 'Enabled') {                                         # If $LBRuleObject.EnableFloatingIP equals $false and $TCPReset equals 'Enabled'
                    Write-Host 'Enabling TCP reset'                                         # Write message to screen
                    Set-AzLoadBalancerRuleConfig `
                        -LoadBalancer $LoadBalancerObject `
                        -Name $LBRuleObject.Name `
                        -FrontendIpConfigurationId `
                        $LBRuleObject.FrontendIpConfiguration.ID `
                        -Protocol $LBRuleObject.Protocol `
                        -FrontendPort $LBRuleObject.FrontendPort `
                        -BackendPort  $LBRuleObject.BackEndPort `
                        -IdleTimeoutInMinutes  $LBRuleObject.IdleTimeoutInMinutes `
                        -BackendAddressPoolId  $CurrentBEID `
                        -LoadDistribution $LBRuleLoadDisto `
                        -EnableTcpReset `
                        -ProbeID $LBRuleObject.Probe.ID -Verbose -ErrorAction `
                        'Stop' | Out-Null                                                   # Changes the rule TCP reset    
                }                                                                           # End elseif ($LBRuleObject.EnableFloatingIP -eq $false -and $TCPReset -eq 'Enabled) 
                else {                                                                      # Else if $LBRuleObject.EnableFloatingIP equals $false and $TCPReset equals 'Disabled'
                    Write-Host 'Disabling TCP reset'                                        # Write message to screen
                    Set-AzLoadBalancerRuleConfig `
                        -LoadBalancer $LoadBalancerObject `
                        -Name $LBRuleObject.Name `
                        -FrontendIpConfigurationId `
                        $LBRuleObject.FrontendIpConfiguration.ID `
                        -Protocol $LBRuleObject.Protocol `
                        -FrontendPort $LBRuleObject.FrontendPort `
                        -BackendPort  $LBRuleObject.BackEndPort `
                        -IdleTimeoutInMinutes  $LBRuleObject.IdleTimeoutInMinutes `
                        -BackendAddressPoolId  $CurrentBEID `
                        -LoadDistribution $LBRuleLoadDisto `
                        -ProbeID $LBRuleObject.Probe.ID -Verbose -ErrorAction `
                        'Stop' | Out-Null                                                   # Changes the rule TCP reset
                }                                                                           # End Else (if ($LBRuleObject.EnableFloatingIP -eq $True -and $TCPReset -eq 'Enabled'))
                Write-Host 'Saving the load balancer configuration'                         # Write message to screen
                $LoadBalancerObject | Set-AzLoadBalancer -ErrorAction 'Stop' | Out-Null     # Saves the changes to $LoadBalancerObject
            }                                                                               # End try
            Catch {                                                                         # If try fails
                Clear-Host                                                                  # Clears screen
                Write-Host 'An error has occured'                                           # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break SetAzureLBRuleTCPReset                                                # Breaks :SetAzureLBRuleTCPReset
            }                                                                               # End catch
            Clear-Host                                                                      # Clears screen
            Write-Host 'Requested changes have been made'                                   # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            Pause                                                                           # Pauses all actions for operator input
            Break SetAzureLBRuleTCPReset                                                    # Breaks :SetAzureLBRuleTCPReset
        }                                                                                   # End :SetAzureLBRuleTCPReset while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function SetAzLBRuleTCPReset
function SetAzLBRuleFloatingIP {                                                            # Function to change an existing load balancer rule floating IP
    Begin {                                                                                 # Begin function
        if (!$CallingFunction) {                                                            # If $CallingFunction is $null
            $CallingFunction = 'SetAzLBRuleFloatingIP'                                      # Creates $CallingFunction
        }                                                                                   # End if (!$CallingFunction)
        :SetAzureLBRuleFloatingIP while ($true) {                                           # Outer loop for managing function
            $LBRuleObject, $LoadBalancerObject = GetAzLBRuleConfig ($CallingFunction)       # Calls function and assigns output to $var
            if (!$LBRuleObject) {                                                           # If $LBRuleObject is $null
                Break SetAzureLBRuleFloatingIP                                              # Breaks :SetAzureLBRuleFloatingIP
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
            :NewAzureLBRuleFloatingIP while ($true) {                                       # Inner loop for setting the rule floating IP
                Write-Host 'Rule Name:    '$LBRuleObject.name                               # Write message to screen
                Write-Host 'Load Balancer:'$LoadBalancerObject.name                         # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Write-Host 'Floating IP options'                                            # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Write-Host '[0] Exit'                                                       # Write message to screen
                Write-Host '[1] Disabled'                                                   # Write message to screen
                Write-Host '[2] Enabled'                                                    # Write message to screen
                Write-Host ''                                                               # Write message to screen
                $OpSelect = Read-Host 'Option [#]'                                          # Operator input to select load disto
                Clear-Host                                                                  # Clears screen
                if ($OpSelect -eq '0') {                                                    # If $OpSelect equals '0'
                    Break SetAzureLBRuleFloatingIP                                          # Breaks SetAzureLBRuleFloatingIP
                }                                                                           # End if ($OpSelect -eq '0')
                elseif ($OpSelect -eq '1') {                                                # Else if $OpSelect equals '1'
                    $FloatingIP = 'Disabled'                                                # Sets $FloatingIP
                    Break NewAzureLBRuleFloatingIP                                          # Breaks :NewAzureLBRuleFloatingIP
                }                                                                           # End elseif ($OpSelect -eq '1')
                elseif ($OpSelect -eq '2') {                                                # Else if $OpSelect equals '2'
                    $FloatingIP = 'Enabled'                                                 # Sets $FloatingIP
                    Break NewAzureLBRuleFloatingIP                                          # Breaks :NewAzureLBRuleFloatingIP
                }                                                                           # End elseif ($OpSelect -eq '2')
                else {                                                                      # All other inputs for $OpSelect
                    Write-Host 'That was not a valid input'                                 # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Clear-Host                                                              # Clears screen
                }                                                                           # End else (if ($OpSelect -eq '0'))
            }                                                                               # End :NewAzureLBRuleFloatingIP while ($true)
            Try {                                                                           # Try the following
                if ($LBRuleObject.EnableTcpReset -eq $True `
                    -and $FloatingIP -eq 'Enabled') {                                       # If $LBRuleObject.EnableTcpReset equals $True -and $FloatingIP equals 'Enabled'
                    Write-Host 'Enabling Floating IP'                                       # Write message to screen
                    Set-AzLoadBalancerRuleConfig `
                        -LoadBalancer $LoadBalancerObject `
                        -Name $LBRuleObject.Name `
                        -FrontendIpConfigurationId `
                        $LBRuleObject.FrontendIpConfiguration.ID `
                        -Protocol $LBRuleObject.Protocol `
                        -FrontendPort $LBRuleObject.FrontendPort `
                        -BackendPort  $LBRuleObject.BackEndPort `
                        -IdleTimeoutInMinutes  $LBRuleObject.IdleTimeoutInMinutes `
                        -BackendAddressPoolId  $CurrentBEID `
                        -LoadDistribution $LBRuleLoadDisto `
                        -EnableTcpReset -EnableFloatingIP `
                        -ProbeID $LBRuleObject.Probe.ID -Verbose -ErrorAction `
                        'Stop' | Out-Null                                                   # Changes the rule floating IP
                }                                                                           # End if ($LBRuleObject.EnableTcpReset -eq $True -and $FloatingIP -eq 'Enabled')
                elseif ($LBRuleObject.EnableFloatingIP -eq $false `
                    -and $FloatingIP -eq 'Enabled') {                                       # Else if $LBRuleObject.EnableFloatingIP equals $false -and $FloatingIP equals 'Enabled'
                    Write-Host 'Enabling Floating IP'                                       # Write message to screen
                    Set-AzLoadBalancerRuleConfig `
                        -LoadBalancer $LoadBalancerObject `
                        -Name $LBRuleObject.Name `
                        -FrontendIpConfigurationId `
                        $LBRuleObject.FrontendIpConfiguration.ID `
                        -Protocol $LBRuleObject.Protocol `
                        -FrontendPort $LBRuleObject.FrontendPort `
                        -BackendPort  $LBRuleObject.BackEndPort `
                        -IdleTimeoutInMinutes  $LBRuleObject.IdleTimeoutInMinutes `
                        -BackendAddressPoolId  $CurrentBEID `
                        -LoadDistribution $LBRuleLoadDisto `
                        -EnableFloatingIP `
                        -ProbeID $LBRuleObject.Probe.ID -Verbose -ErrorAction `
                        'Stop' | Out-Null                                                   # Changes the rule floating IP
                }                                                                           # End elseif ($LBRuleObject.EnableFloatingIP -eq $false -and $FloatingIP -eq 'Enabled')
                elseif ($LBRuleObject.EnableTcpReset -eq $true `
                    -and $FloatingIP -eq 'Disabled') {                                      # Else if $LBRuleObject.EnableFloatingIP equals $true -and $FloatingIP equals 'Disabled'
                    Write-Host 'Disabling Floating IP'                                      # Write message to screen
                    Set-AzLoadBalancerRuleConfig `
                        -LoadBalancer $LoadBalancerObject `
                        -Name $LBRuleObject.Name `
                        -FrontendIpConfigurationId `
                        $LBRuleObject.FrontendIpConfiguration.ID `
                        -Protocol $LBRuleObject.Protocol `
                        -FrontendPort $LBRuleObject.FrontendPort `
                        -BackendPort  $LBRuleObject.BackEndPort `
                        -IdleTimeoutInMinutes  $LBRuleObject.IdleTimeoutInMinutes `
                        -BackendAddressPoolId  $CurrentBEID `
                        -LoadDistribution $LBRuleLoadDisto `
                        -EnableTcpReset `
                        -ProbeID $LBRuleObject.Probe.ID -Verbose -ErrorAction `
                        'Stop' | Out-Null                                                   # Changes the rule floating IP    
                }                                                                           # End elseif ($LBRuleObject.EnableTcpReset -eq $true -and $FloatingIP -eq 'Disabled')
                else {                                                                      # Else if $LBRuleObject.EnableFloatingIP equals $false -and $FloatingIP equals 'Disabled'
                    Write-Host 'Disabling Floating IP'                                      # Write message to screen
                    Set-AzLoadBalancerRuleConfig `
                        -LoadBalancer $LoadBalancerObject `
                        -Name $LBRuleObject.Name `
                        -FrontendIpConfigurationId `
                        $LBRuleObject.FrontendIpConfiguration.ID `
                        -Protocol $LBRuleObject.Protocol `
                        -FrontendPort $LBRuleObject.FrontendPort `
                        -BackendPort  $LBRuleObject.BackEndPort `
                        -IdleTimeoutInMinutes  $LBRuleObject.IdleTimeoutInMinutes `
                        -BackendAddressPoolId  $CurrentBEID `
                        -LoadDistribution $LBRuleLoadDisto `
                        -ProbeID $LBRuleObject.Probe.ID -Verbose -ErrorAction `
                        'Stop' | Out-Null                                                   # Changes the rule floating IP
                }                                                                           # End else (if ($LBRuleObject.EnableTcpReset -eq $True -and $FloatingIP -eq 'Enabled'))
                Write-Host 'Saving the load balancer configuration'                         # Write message to screen
                $LoadBalancerObject | Set-AzLoadBalancer -ErrorAction 'Stop' | Out-Null     # Saves the changes to $LoadBalancerObject
            }                                                                               # End try
            Catch {                                                                         # If try fails
                Clear-Host                                                                  # Clears screen
                Write-Host 'An error has occured'                                           # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break SetAzureLBRuleFloatingIP                                              # Breaks :SetAzureLBRuleFloatingIP
            }                                                                               # End catch
            Clear-Host                                                                      # Clears screen
            Write-Host 'Requested changes have been made'                                   # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            Pause                                                                           # Pauses all actions for operator input
            Break SetAzureLBRuleFloatingIP                                                  # Breaks :SetAzureLBRuleFloatingIP
        }                                                                                   # End :SetAzureLBRuleFloatingIP while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function SetAzLBRuleFloatingIP
# Additional functions required for ManageAzLBRuleConfig
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