# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Mircosoft docs links
    New-AzLoadBalancer:         https://docs.microsoft.com/en-us/powershell/module/az.network/new-azloadbalancer?view=azps-5.5.0  
    New-AzLoadBalancerFrontendIpConfig: https://docs.microsoft.com/en-us/powershell/module/az.network/new-azloadbalancerfrontendipconfig?view=azps-5.5.0
    New-AzPublicIpAddress:      https://docs.microsoft.com/en-us/powershell/module/az.network/new-azpublicipaddress?view=azps-5.5.0
    Get-AzPublicIpAddress:      https://docs.microsoft.com/en-us/powershell/module/az.network/get-azpublicipaddress?view=azps-5.5.0
    New-AzLoadBalancerBackendAddressPoolConfig: https://docs.microsoft.com/en-us/powershell/module/az.network/new-azloadbalancerbackendaddresspoolconfig?view=azps-5.5.0
    New-AzLoadBalancerProbeConfig:  https://docs.microsoft.com/en-us/powershell/module/az.network/new-azloadbalancerbackendaddresspoolconfig?view=azps-5.5.0
    New-AzLoadBalancerRuleConfig:  https://docs.microsoft.com/en-us/powershell/module/az.network/new-azloadbalancerruleconfig?view=azps-5.5.0
    Get-AzResourceGroup:        https://docs.microsoft.com/en-us/powershell/module/az.resources/get-azresourcegroup?view=azps-5.1.0     
} #>
<# Required Functions Links: {
    NewAzLoadBalancer:          https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/Load%20Balancer/NewAzLoadBalancer.ps1
    ListAzLoadBalancer:         https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/Load%20Balancer/ListAzLoadBalancer.ps1
    GetAzLoadBalancer:          https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/Load%20Balancer/GetAzLoadBalancer.ps1
    RemoveAzLoadBalancer:       https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/Load%20Balancer/RemoveAzLoadBalancer.ps1
    NewAzLBFrontendIpConfig:    https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/Load%20Balancer/NewAzLBFrontendIpConfig.ps1
    NewAzPublicIpAddress:       https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/Public%20IP/NewAzPublicIpAddress.ps1
    GetAzPublicIpAddress:       https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/Public%20IP/GetAzPublicIpAddress.ps1
    NewAzLBBackendIpConfig:     https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/Load%20Balancer/NewAzLBBackendIpConfig.ps1
    NewAzLBProbeConfig:         https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/Load%20Balancer/NewAzLBProbeConfig.ps1
    NewAzLBIBNatPoolConfig:     https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/Load%20Balancer/NewAzLBIBNatPoolConfig.ps1
    NewAzLBRuleConfig:          https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/Load%20Balancer/NewAzLBRuleConfig.ps1
    GetAzResourceGroup:         https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/GetAzResourceGroup.ps1
} #>
<# Functions Description: {
    ManageAzLoadBalancer:       Function for managing load balancers
    NewAzLoadBalancer:          Creates a new load balancer    
    ListAzLoadBalancer:         Lists all existing load balancers
    GetAzLoadBalancer:          Gets an existing load balancer
    RemoveAzLoadBalancer:       Removes an existing load balancer
    NewAzLBFrontendIpConfig:    Creates a load balancer front end IP configuration
    NewAzPublicIpAddress:       Creates a new public IP addres
    GetAzPublicIpAddress:       Gets an existing IP address
    NewAzLBBackendIpConfig:     Creates a load balancer back end configuration
    NewAzLBProbeConfig:         Creates a load balancer probe configuration
    NewAzLBIBNatPoolConfig:     Creates inbound pool configuration for load balancer
    NewAzLBRuleConfig:          Creates a new load balancer rule
    GetAzResourceGroup:         Gets an existing resource group
} #>
<# Variables: {      
    :ManageAzureLoadBalancer    Outer loop for managing function
    $LoadBalancerObject:        Load balancer object
    $OperatorSelect:            Operator input for selecting the management function
    NewAzLoadBalancer{}         Creates $LoadBalancerObject
        NewAzLBFrontendIpConfig{}   Gets $FrontEndIPConfigObject
        NewAzPublicIpAddress{}      Creates $PublicIPObject
            GetAzResourceGroup{}        Gets $RGObject
        GetAzPublicIpAddress{}      Gets $PublicIPObject
        NewAzLBBackendIpConfig{}    Gets $BackEndIPConfigObject
        NewAzLBProbeConfig{}        Gets $HealthProbeObject
        NewAzLBIBNatPoolConfig{}    Gets $InboundNatPoolObject
        NewAzLBRuleConfig{}         Gets $LoadBalanceRule 
    ListAzLoadBalancer{}        Lists $LoadBalancerObject
    GetAzLoadBalancer{}         Gets $LoadBalancerObject
    RemoveAzLoadBalancer{}      Removes $LoadBalancerObject
        GetAzLoadBalancer{}         Gets $LoadBalancerObject
} #>
<# Process Flow {
    function
        Call ManageAzLoadBalancer > Get $LoadBalancerObject
            Call NewAzLoadBalancer > Get $LoadBalancerObject
                Call GetAzResourceGroup > Get $RGObject
                End GetAzResourceGroup
                    Return NewAzLoadBalancer > Send $RGObject          
                Call NewAzLBFrontendIpConfig > Get $FrontEndIPConfigObject
                    Call NewAzPublicIpAddress > Get $PublicIPObject
                        Call GetAzResourceGroup > Get RGObject
                        End GetAzResourceGroup
                            Return NewAzPublicIpAddress > Send RGObject
                    End NewAzPublicIpAddress
                        Return NewAzLBFrontendIpConfig > Send $PublicIPObject
                    Call GetAzPublicIpAddress > Get $PublicIPObject
                    End GetAzPublicIpAddress
                        Return NewAzLBFrontendIpConfig > Send $PublicIPObject        
                End NewAzLBFrontendIpConfig
                    Return NewAzLoadBalancer > Send $FrontEndIPConfigObject    
                Call NewAzLBBackendIpConfig > Get $BackEndIPConfigObject
                End NewAzLBBackendIpConfig
                    Return NewAzLoadBalancer > Send $BackEndIPConfigObject            
                Call NewAzLBProbeConfig > Get $HealthProbeObject
                End NewAzLBProbeConfig
                    Return NewAzLoadBalancer > Send $HealthProbeObject           
                Call NewAzLBIBNatPoolConfig > Get $InboundNatPoolObject
                End NewAzLBIBNatPoolConfig
                    Return NewAzLoadBalancer > Send $InboundNatPoolObject
                Call NewAzLBRuleConfig > Get $LoadBalanceRule
                End NewAzLBRuleConfig
                    Return NewAzLoadBalancer > Send $LoadBalanceRule
            End NewAzLoadBalancer
                Return ManageAzLoadBalancer > Send $LoadBalancerObject
            Call ListAzLoadBalancer > Get $null
            End ListAzLoadBalancer
                Return ManageAzLoadBalancer > Send $null
            Call GetAzLoadBalancer > Get $LoadBalancerObject
            End GetAzLoadBalancer
                Return ManageAzLoadBalancer > Send $LoadBalancerObject
            Call RemoveAzPublicIPAddres > Get $null
                Call GetAzLoadBalancer > Get $LoadBalancerObject
                End GetAzLoadBalancer
                    Return RemoveAzLoadBalancer > Send $LoadBalancerObject
            End RemoveAzLoadBalancer
                Return ManageAzLoadBalancer > Send $null
        End ManageAzLoadBalancer
            Return function > Send $LoadBalancerObject
}#>
function ManageAzLoadBalancer {                                                             # Function to manage load balancer Skus
    Begin {                                                                                 # Begin function
        :ManageAzureLoadBalancer while ($true) {                                            # Outer loop for managing function
            if ($LoadBalancerObject) {                                                      # If $LoadBalancerObject has a value
                Write-Host 'The current load balancer is'$LoadBalancerObject.Name           # Write message to screen
            }                                                                               # End if ($LoadBalancerObject)
            Write-Host '[0] Clear "$LoadBalancerObject"'                                    # Write message to screen
            Write-Host '[1] New load balancer'                                              # Write message to screen
            Write-Host '[2] List load balancers'                                            # Write message to screen
            Write-Host '[3] Get load balancer'                                              # Write message to screen
            Write-Host '[4] Remove load balancer'                                           # Write message to screen
            $OperatorSelect = Read-Host 'Enter the option [#]'                              # Operator input for the function selection
            if ($OperatorSelect -eq 'exit') {                                               # $OperatorSelect equals 'exit'    
                Break ManageAzureLoadBalancer                                               # Breaks :ManageAzureLoadBalancer
            }                                                                               # End if ($OperatorSelect -eq 'exit')
            elseif ($OperatorSelect -eq '0') {                                              # $OperatorSelect equals '0'
                if ($LoadBalancerObject){                                                   # If $LoadBalancerObject has a value
                    $LoadBalancerObject = $null                                             # Clears $LoadBalancerObject
                    Write-Host '$LoadBalancerObject has been cleared'                       # Write message to screen
                }                                                                           # End if ($LoadBalancerObject)
                else {                                                                      # If $LoadBalancerObject does not have a value
                    Write-Host '$LoadBalancerObject was already empty'                      # Write message to screen
                }                                                                           # End else (if ($LoadBalancerObject))
            }                                                                               # elseif ($OperatorSelect -eq '0')
            elseif ($OperatorSelect -eq '1') {                                              # $OperatorSelect equals '1'
                $LoadBalancerObject = NewAzLoadBalancer                                     # Calls function and assigns output to $var
            }                                                                               # elseif ($OperatorSelect -eq '1')
            elseif ($OperatorSelect -eq '2') {                                              # $OperatorSelect equals '2'
                ListAzLoadBalancer                                                          # Calls function
            }                                                                               # elseif ($OperatorSelect -eq '2')
            elseif ($OperatorSelect -eq '3') {                                              # $OperatorSelect equals '3'
                $LoadBalancerObject = GetAzLoadBalancer                                     # Calls function and assigns output to $var
            }                                                                               # elseif ($OperatorSelect -eq '3')
            elseif ($OperatorSelect -eq '4') {                                              # $OperatorSelect equals '4'
                RemoveAzLoadBalancer ($LoadBalancerObject)                                  # Calls function and assigns output to $var
            }                                                                               # elseif ($OperatorSelect -eq '4')
            else {                                                                          # All other inputs for $OperatorSelect
                Write-Host 'That was not a valid option'                                    # Write message to screen
            }                                                                               # End else (if ($OperatorSelect -eq 'exit'))
        }                                                                                   # End :ManageAzureLoadBalancer while ($true)
        return $LoadBalancerObject                                                          # Returns to calling function with $LoadBalancerObject
    }                                                                                       # End Begin
}                                                                                           # End function ManageAzLoadBalancer
function NewAzLoadBalancer {                                                                # Function to create a new load balancer
    Begin {                                                                                 # Begin function
        :NewAzureLoadBalancer while ($true) {                                               # Outer loop for managing function
            if (!$RGObject) {                                                               # If $RGObject is $null
                $RGObject = GetAzResourceGroup                                              # Calls function and assigns output to $var
                if (!$RGObject) {                                                           # If $RGObject is $null
                    Break NewAzureLoadBalancer                                              # Breaks :NewAzureLoadBalancer
                }                                                                           # End if (!$RGObject)
            }                                                                               # End if (!$RGObject)
            $FrontEndIPConfigObject = NewAzLBFrontendIpConfig                               # Calls function and assigns output to $var
            if (!$FrontEndIPConfigObject) {                                                 # If $FrontEndIPConfigObject is $null
                Break NewAzureLoadBalancer                                                  # Breaks :NewAzureLoadBalancer
            }                                                                               # End if (!$FrontEndIPConfigObject)
            $BackEndIPConfigObject = NewAzLBBackendIpConfig                                 # Calls function and assigns output to $var
            if (!$BackEndIPConfigObject) {                                                  # If $BackEndIPConfigObject is $null
                Break NewAzureLoadBalancer                                                  # Breaks :NewAzureLoadBalancer
            }                                                                               # End if (!$BackEndIPConfigObject)
            $HealthProbeObject = NewAzLBProbeConfig                                         # Calls function and assigns output to $var
            if (!$HealthProbeObject) {                                                      # If $HealthProbeObject is $null
                Break NewAzureLoadBalancer                                                  # Breaks :NewAzureLoadBalancer
            }                                                                               # End if (!$HealthProbeObject)
            $InboundNatPoolObject = NewAzLBIBNatPoolConfig ($FrontEndIPConfigObject)        # Calls function and assigns output to $var
            if (!$InboundNatPoolObject) {                                                   # If $InboundNatPoolObject is $null
                Break NewAzureLoadBalancer                                                  # Breaks :NewAzureLoadBalancer
            }                                                                               # End if (!$InboundNatPoolObject)
            $LoadBalanceRule = NewAzLBRuleConfig ($FrontEndIPConfigObject, `
                $BackEndIPConfigObject, $HealthProbeObject)                                 # Calls function and assigns output to $var
            if (!$LoadBalanceRule) {                                                        # If $LoadBalanceRule is $null
                Break NewAzureLoadBalancer                                                  # Breaks :NewAzureLoadBalancer
            }                                                                               # End if (!$LoadBalanceRule)
            :SetAzureLBName while ($true) {                                                 # Inner loop for setting the balancer name
                $LBNameObject = Read-Host "Load balancer Name"                              # Operator input for the balancer name
                if ($LBNameObject -eq 'exit') {                                             # If $LBNameObject equals $exit
                    Break NewAzureLoadBalancer                                              # Breaks :NewAzureLoadBalancer
                }                                                                           # End if ($LBNameObject -eq 'exit')
                Write-Host $LBNameObject                                                    # Writes message to screen
                $OperatorConfirm = Read-Host "Use as the balancer name? [Y] or [N]"         # Operator confirmation of the balancer name
                if ($OperatorConfirm -eq 'y') {                                             # If $OperatorConfirm equals 'y'
                    Break SetAzureLBName                                                    # Breaks :SetAzureLBName
                }                                                                           # End if ($OperatorConfirm -eq 'y')
            }                                                                               # End :SetAzureLBName while ($true)
            $LoadBalancerObject = New-AzLoadBalancer -Name $LBNameObject `
                -ResourceGroupName $RGObject.ResourceGroupName -Location `
                $RGObject.Location -FrontendIpConfiguration $FrontEndIPConfigObject `
                -BackendAddressPool $BackEndIPConfigObject -Probe $HealthProbeObject `
                -LoadBalancingRule $LBRule -InboundNatPool $InboundNatPoolObject            # Creates the load balancer
            if ($LoadBalancerObject) {                                                      # If $LoadBalancerObject has a value
                Return $LoadBalancerObject                                                  # Returns $LoadBalancerObject to calling function
            }                                                                               # End if ($LoadBalancerObject)
            else {                                                                          # If $LoadBalancerObject does not have a value
                Write-Host "An error has occured"                                           # Write message to screen
                Break NewAzureLoadBalancer                                                  # Breaks :NewAzureLoadBalancer
            }                                                                               # End else(if ($LoadBalancerObject))
        }                                                                                   # End :NewAzureLoadBalancer while ($true)
        Return                                                                              # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function NewAzLoadBalancer
function NewAzLBFrontendIpConfig {                                                          # Function to set up the front end IP for a load balancer
    Begin {                                                                                 # Begin function
        :NewAzureLBFEIpConfig while ($true) {                                               # Outer loop for managing the function
            :GetAzurePublicIP while ($true) {                                               # Inner loop for getting the public IP
                Write-Host "[0] Exit"                                                       # Write message to screen
                Write-Host "[1] New Public IP"                                              # Write message to screen
                Write-Host "[2] Existing public IP"                                         # Write message to screen
                $PublicIPType = Read-Host "[0], [1], or [2]"                                # Operator input for getting the public IP
                if ($PublicIPType -eq '0') {                                                # If $PublicIPType equals '0'
                    Break NewAzureLBFEIpConfig                                              # Breaks :NewAzureLPFEIpConfig
                }                                                                           # End if ($PublicIPType -eq '0')
                elseif ($PublicIPType -eq '1') {                                            # If $PublicIPType equals 1
                    $PublicIPObject = NewAzPublicIpAddress                                  # Calls function and assigns output to $var
                    if (!$PublicIPObject) {                                                 # If $var is $null
                        Break NewAzureLBFEIpConfig                                          # Breaks :NewAzureLPFEIpConfig
                    }                                                                       # End if (!$PublicIPObject)
                    Break GetAzurePublicIP                                                  # Breaks :GetAzurePublicIP
                }                                                                           # End elseif ($PublicIPType -eq '1')
                elseif ($PublicIPType -eq '2') {                                            # If $PublicIPType equals 2
                    $PublicIPObject = GetAzPublicIpAddress                                  # Calls function and assigns output to $var
                    if (!$PublicIPObject) {                                                 # If $var is $null
                        Break NewAzureLBFEIpConfig                                          # Breaks :NewAzureLPFEIpConfig
                    }                                                                       # End if (!$PublicIPObject)
                    Break GetAzurePublicIP                                                  # Breaks :GetAzurePublicIP
                }                                                                           # End elseif ($PublicIPType -eq '2')
                else {                                                                      # All other inputs
                    Write-Host "That was not a valid option"                                # Write message to screen
                }                                                                           # End else(if ($PublicIPType -eq '0'))
            }                                                                               # End :GetAzurePublicIP while ($true)
            :SetAzureLBFEName while ($true) {                                               # Inner loop for setting the front end name
                $FrontEndNameObject = Read-Host "Front end Name"                            # Operator input for the front end name
                if ($FrontEndNameObject -eq 'exit') {                                       # If $FrontEndNameObject equals $null
                    Break NewAzureLBFEIpConfig                                              # Breaks :NewAzureLBFEIpConfig
                }                                                                           # End if ($FrontEndNameObject -eq 'exit')
                Write-Host $FrontEndNameObject                                              # Writes message to screen
                $OperatorConfirm = Read-Host "Use as the front end name? [Y] or [N]"        # Operator confirmation of the front end name
                if ($OperatorConfirm -eq 'y') {                                             # If $OperatorConfirm equals 'y'
                    Break SetAzureLBFEName                                                  # Breaks :SetAzureLBFEName
                }                                                                           # End if ($OperatorConfirm -eq 'y')
            }                                                                               # End :SetAzureLBFEName while ($true)
            $FrontEndIPConfigObject = New-AzLoadBalancerFrontendIpConfig -Name `
                $FrontEndNameObject -PublicIpAddress $PublicIPObject                        # Creates the load balancer front end pool
            if ($FrontEndIPConfigObject) {                                                  # If $FrontEndIPConfigObject has a value
                Return $FrontEndIPConfigObject                                              # Returns to calling function with $
            }                                                                               # End if ($FrontEndIPConfigObject)
            else {                                                                          # If $FrontEndIPConfigObject does not have a value
                Write-Host "An error has occured"                                           # Write message to screen
                Break NewAzureLBFEIpConfig                                                  # Breaks :NewAzureLBFEIpConfig
            }                                                                               # End else (if ($FrontEndIPConfigObject))
        }                                                                                   # End :NewAzureLBFEIpConfig while ($true)
        Return                                                                              # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function NewAzLBFrontendIpConfig
function NewAzLBBackendIpConfig {                                                           # Function to set up the Back end IP for a load balancer
    Begin {                                                                                 # Begin function
        :NewAzureLBBEIpConfig while ($true) {                                               # Outer loop for managing the function
            :SetAzureLBBEName while ($true) {                                               # Inner loop for setting the back end name
                $BackEndNameObject = Read-Host "Back end name"                              # Operator input for the back end name
                if ($BackEndNameObject -eq 'exit') {                                        # If $BackEndNameObject equals $null
                    Break NewAzureLBBEIpConfig                                              # Breaks :NewAzureLBBEIpConfig
                }                                                                           # End if ($BackEndNameObject -eq 'exit')
                Write-Host $BackEndNameObject                                               # Writes message to screen
                $OperatorConfirm = Read-Host "Use as the Back end name? [Y] or [N]"         # Operator confirmation of the back end name
                if ($OperatorConfirm -eq 'y') {                                             # If $OperatorConfirm equals 'y'
                    Break SetAzureLBBEName                                                  # Breaks :SetAzureLBBEName
                }                                                                           # End if ($OperatorConfirm -eq 'y')
            }                                                                               # End :SetAzureLBBEName while ($true)
            $BackEndIPConfigObject = New-AzLoadBalancerBackendAddressPoolConfig -Name `
                $BackEndNameObject                                                          # Creates the load balancer back end pool
            if ($BackEndIPConfigObject) {                                                   # If $BackEndIPConfigObject has a value
                Return $BackEndIPConfigObject                                               # Returns to calling function with $
            }                                                                               # End if ($BackEndIPConfigObject)
            else {                                                                          # If $BackEndIPConfigObject does not have a value
                Write-Host "An error has occured"                                           # Write message to screen
                Break NewAzureLBBEIpConfig                                                  # Breaks :NewAzureLBBEIpConfig
            }                                                                               # End else (if ($BackEndIPConfigObject))
        }                                                                                   # End :NewAzureLBBEIpConfig while ($true)
        Return                                                                              # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function NewAzLBBackendIpConfig
function NewAzLBProbeConfig {                                                               # Function to sett up load balancer health probes
    Begin {
        :NewAzureLBProbeConfig while ($true) {
            :SetAzureProbeName while ($true) {                                              # Inner loop for setting the probe name
                $ProbeNameObject = Read-Host "Probe Name"                                   # Operator input for the probe name
                if ($ProbeNameObject -eq 'exit') {                                          # If $ProbeNameObject equals $null
                    Break NewAzureLBProbeConfig                                             # Breaks :NewAzureLBProbeConfig
                }                                                                           # End if ($ProbeNameObject -eq 'exit')
                Write-Host $ProbeNameObject                                                 # Writes message to screen
                $OperatorConfirm = Read-Host "Use as the probe name? [Y] or [N]"            # Operator confirmation of the probe name
                if ($OperatorConfirm -eq 'y') {                                             # If $OperatorConfirm equals 'y'
                    Break SetAzureProbeName                                                 # Breaks :SetAzureProbeName
                }                                                                           # End if ($OperatorConfirm -eq 'y')
            }                                                                               # End :SetAzureProbeName while ($true)
            :SetAzureProbeProtocol while ($true) {                                          # Inner loop for setting the probe type
                Write-Host '[0] Exit'                                                       # Write message to screen
                Write-Host '[1] Http (80)'                                                  # Write message to screen
                Write-host '[2] Https(443)'                                                 # Write message to screen
                $ProbeTypeObject = Read-Host '[0], [1], or [2]'                             # Operator input for the probe type object
                if ($ProbeTypeObject -eq '0') {                                             # If $ProbeTypeObject equals 0
                    Break NewAzureLBProbeConfig                                             # Breaks :NewAzureLBProbeConfig 
                }                                                                           # End if ($ProbeTypeObject -eq '0')
                elseif ($ProbeTypeObject -eq '1') {                                         # Elseif $ProbeTypeObject equals 1
                    [System.Collections.ArrayList]$ProbeProtocol = @()                      # Creates array for list to be loaded into
                    $ProbeProtocolInput = [PSCustomObject]@{'Protocol' = 'http';`
                        'port' = '80'}                                                      # Creates the item to loaded into array
                    $ProbeProtocol.Add($ProbeProtocolInput) | Out-Null                      # Loads item into array, out-null removes write to screen         
                    Break SetAzureProbeProtocol                                             # Breaks :SetAzureProbeProtocol 
                }                                                                           # End elseif ($ProbeTypeObject -eq '1')
                elseif ($ProbeTypeObject -eq '2') {                                         # Elseif $ProbeTypeObject equals 1
                    [System.Collections.ArrayList]$ProbeProtocol = @()                      # Creates array for list to be loaded into
                    $ProbeProtocolInput = [PSCustomObject]@{'Protocol' = 'https';`
                        'port' = '443'}                                                     # Creates the item to loaded into array
                    $ProbeProtocol.Add($ProbeProtocolInput) | Out-Null                      # Loads item into array, out-null removes write to screen         
                    Break SetAzureProbeProtocol                                             # Breaks :SetAzureProbeProtocol 
                }                                                                           # End elseif ($ProbeTypeObject -eq '2')
                else {                                                                      # All other inputs 
                    Write-Host "That was not a valid option"                                # Write message to screen
                }                                                                           # End else 
            }                                                                               # End :SetAzureProbeProtocol while ($true)
            :SetAzureProbeInterval while ($true) {                                          # Inner loop for setting the probe interval time
                Try {                                                                       # Try the following
                    [int]$ProbeIntervalObject = Read-Host "Probe interval in seconds"       # Operator input for the probe interval
                }                                                                           # End try
                Catch {}                                                                    # If try fails
                if ($ProbeIntervalObject -le 0) {                                           # If $ProbeIntervalObject is less than or equal to 0
                    Write-Host "Please enter a number"                                      # Write message to screen
                }                                                                           # End if ($ProbeIntervalObject -le 0) 
                elseif ($ProbeIntervalObject -ge 1) {                                       # If $ProbeIntervalObject is greater than or equal to `
                    $OperatorConfirm = Read-Host 'Probe interval will be set at' `
                    $ProbeIntervalObject 'seconds [Y] or [N]'                               # Operator confirmation of the probe interval
                    if ($OperatorConfirm -eq 'y') {                                         # If $OperatorConfrim equals 'y'
                        Break SetAzureProbeInterval                                         # Breaks :SetAzureProbeInterval        
                    }                                                                       # End if ($OperatorConfirm -eq 'y')
                }                                                                           # End elseif ($ProbeIntervalObject -ge 1)
            }                                                                               # End :SetAzureProbeInterval while ($true)
            :SetAzureProbeCount while ($true) {                                             # Inner loop for setting the probe count
                Try {                                                                       # Try the following
                    [int]$ProbeCountObject = Read-Host "Probe count"                        # Operator input for the probe count
                }                                                                           # End try
                Catch {}                                                                    # If try fails
                if ($ProbeCountObject -le 0) {                                              # If $ProbeCountObject is less than or equal to 0
                    Write-Host "Please enter a number"                                      # Write message to screen
                }                                                                           # End if ($ProbeCountObject -le 0) 
                elseif ($ProbeCountObject -ge 1) {                                          # If $ProbeCountObject is greater than or equal to `
                    $OperatorConfirm = Read-Host 'Probe count will be set at' `
                    $ProbeCountObject  '[Y] or [N]'                                         # Operator confirmation of the probe count
                    if ($OperatorConfirm -eq 'y') {                                         # If $OperatorConfrim equals 'y'
                        Break SetAzureProbeCount                                            # Breaks :SetAzureProbeCount        
                    }                                                                       # End if ($OperatorConfirm -eq 'y')
                }                                                                           # End elseif ($ProbeCountObject -ge 1)
            }                                                                               # End :SetAzureProbeCount while ($true)
            $HealthProbeObject = New-AzLoadBalancerProbeConfig -Name $ProbeNameObject `
                -RequestPath healthcheck.aspx -Protocol $ProbeProtocol.Protocol `
                -Port $ProbeProtocol.Port -IntervalInSeconds $ProbeIntervalObject `
                -ProbeCount $ProbeCountObject                                               # Creates the Health probe object
            if ($HealthProbeObject) {                                                       # If $HealthProbeObject has a value
                Return $HealthProbeObject                                                   # Returns $HealthProbeObject to calling function
            }                                                                               # End if ($HealthProbeObject)
            else {                                                                          # If $HealthProbeObject does not have a value
                Write-Host "An error has occured while setting the probe"                   # Write message to screen
                Break NewAzureLBProbeConfig                                                 # Breaks :NewAzureLBProbeConfig
            }                                                                               # End else (if ($HealthProbeObject))
        }                                                                                   # End :NewAzureLBProbeConfig while ($true)
        Return                                                                              # Returns to calling function with $null
    }                                                                                       # End begin
}                                                                                           # End function NewAzLBProbeConfig
function NewAzLBIBNatPoolConfig {                                                           # Creates inbound pool configuration for load balancer
    begin {                                                                                 # Begin function
        :NewAzureLBIBNatPoolConfig while ($true) {                                          # Outer loop for managing function
            :NewAzureLBIBNatPoolName while ($true) {                                        # Inner loop for setting the nat pool name
                $NatPoolNameObject = Read-Host "Pool Name"                                  # Operator input for the pool name
                if ($NatPoolNameObject -eq 'exit') {                                        # If $NatPoolNameObject equals $null
                    Break NewAzureLBIBNatPoolConfig                                         # Breaks :NewAzureLBIBNatPoolConfig
                }                                                                           # End if ($NatPoolNameObject -eq 'exit')
                Write-Host $NatPoolNameObject                                               # Writes message to screen
                $OperatorConfirm = Read-Host "Use as the pool name? [Y] or [N]"             # Operator confirmation of the pool name
                if ($OperatorConfirm -eq 'y') {                                             # If $OperatorConfirm equals 'y'
                    Break NewAzureLBIBNatPoolName                                           # Breaks :NewAzureLBIBNatPoolName
                }                                                                           # End if ($OperatorConfirm -eq 'y')
            }                                                                               # End :NewAzureLBIBNatPoolName while ($true) {
            :NewAzureLBIBNPProtocol while ($true) {                                         # Inner loop for setting the nat pool protocol
                Write-Host '[0] Exit'                                                       # Write message to screen
                Write-Host '[1] TCP'                                                        # Write message to screen
                Write-Host '[2] UDP'                                                        # Write message to screen
                $NatPoolProtocolObject = Read-Host '[0], [1], or [2]'                       # Operator input for the protocol object
                if ($NatPoolProtocolObject -eq '0') {                                       # If $NatPoolProtocolObject equals '0'
                    Break NewAzureLBIBNatPoolConfig                                         # Breaks :NewAzureLBIBNatPoolConfig
                }                                                                           # End if ($NatPoolProtocolObject -eq '0')
                elseif ($NatPoolProtocolObject -eq '1') {                                   # If $NatPoolProtocolObject equals '1'
                    $NatPoolProtocolObject = 'TCP'                                          # Sets $NatPoolProtocolObject to 'TCP'
                    Break NewAzureLBIBNPProtocol                                            # Breaks :NewAzureLBIBNPProtocol
                }                                                                           # End elseif ($NatPoolProtocolObject -eq '1')
                elseif ($NatPoolProtocolObject -eq '2') {                                   # If $NatPoolProtocolObject equals '2'
                    $NatPoolProtocolObject = 'UDP'                                          # Sets $NatPoolProtocolObject to 'UDP'
                    Break NewAzureLBIBNPProtocol                                            # Breaks :NewAzureLBIBNPProtocol
                }                                                                           # End elseif ($NatPoolProtocolObject -eq '2')
                else {                                                                      # All other inputs
                    Write-Host "That was not a valid entry"                                 # Write message to screen
                }                                                                           # End else (if ($NatPoolProtocolObject -eq '0')) 
            }                                                                               # End :NewAzureLBIBNPProtocol while ($true)
            :NewAzureLBFEPortStart while ($true) {                                          # Inner loop for setting the front end port range start
                Try {                                                                       # Try the following
                    [int]$FrontEndPortStart = Read-Host "Pool front end port start"         # Operator input for the front end port start
                }                                                                           # End try
                Catch {}                                                                    # If try fails
                if ($FrontEndPortStart -le 0) {                                             # If $FrontEndPortStart is less than or equal to 0
                    Write-Host "Please enter a number"                                      # Write message to screen
                }                                                                           # End if ($FrontEndPortStart -le 0) 
                elseif ($FrontEndPortStart -ge 1) {                                         # If $FrontEndPortStart is greater than or equal to `
                    $OperatorConfirm = Read-Host 'Front end port start will be' `
                    $FrontEndPortStart '[Y], [N], or [E] to exit'                           # Operator confirmation of the front end port start
                    if ($OperatorConfirm -eq 'e') {                                         # If $OperatorConfrim equals 'e'
                        Break NewAzureLBIBNatPoolConfig                                     # Breaks :NewAzureLBIBNatPoolConfig
                    }                                                                       # End if ($OperatorConfirm -eq 'e')
                    if ($OperatorConfirm -eq 'y') {                                         # If $OperatorConfrim equals 'y'
                        Break NewAzureLBFEPortStart                                         # Breaks :NewAzureLBFEPortStart        
                    }                                                                       # End if ($OperatorConfirm -eq 'y')
                }                                                                           # End elseif ($FrontEndPortStart -ge 1)
            }                                                                               # End :NewAzureLBFEPortStart while ($true)
            :NewAzureLBFEPortEnd while ($true) {                                            # Inner loop for setting the front end port range end
                Try {                                                                       # Try the following
                    [int]$FrontEndPortEnd = Read-Host "Pool front end port end"             # Operator input for the front end port end
                }                                                                           # End try
                Catch {}                                                                    # If try fails
                if ($FrontEndPortEnd -le 0) {                                               # If $FrontEndPortEnd is less than or equal to 0
                    Write-Host "Please enter a number"                                      # Write message to screen
                }                                                                           # End if ($FrontEndPortEnd -le 0) 
                elseif ($FrontEndPortEnd -ge 1) {                                           # If $FrontEndPortEnd is greater than or equal to `
                    $OperatorConfirm = Read-Host 'Front end port end will be' `
                    $FrontEndPortEnd '[Y], [N], or [E] to exit'                             # Operator confirmation of the front end port end
                    if ($OperatorConfirm -eq 'e') {                                         # If $OperatorConfrim equals 'e'
                        Break NewAzureLBIBNatPoolConfig                                     # Breaks :NewAzureLBIBNatPoolConfig
                    }                                                                       # End if ($OperatorConfirm -eq 'e')
                    if ($OperatorConfirm -eq 'y') {                                         # If $OperatorConfrim equals 'y'
                        Break NewAzureLBFEPortEnd                                           # Breaks :NewAzureLBFEPortEnd        
                    }                                                                       # End if ($OperatorConfirm -eq 'y')
                }                                                                           # End elseif ($FrontEndPortEnd -ge 1)
            }                                                                               # End :NewAzureLBFEPortEnd while ($true)
            :NewAzureLBBEPort while ($true) {                                               # Inner loop for setting the back end port
                Try {                                                                       # Try the following
                    [int]$BackEndPort = Read-Host "Pool Back end port"                      # Operator input for the front end port end
                }                                                                           # End try
                Catch {}                                                                    # If try fails
                if ($BackEndPort -le 0) {                                                   # If $BackEndPort is less than or equal to 0
                    Write-Host "Please enter a number"                                      # Write message to screen
                }                                                                           # End if ($BackEndPort -le 0) 
                elseif ($BackEndPort -ge 1) {                                               # If $BackEndPort is greater than or equal to `
                    $OperatorConfirm = Read-Host 'Back end port will be' `
                    $BackEndPort '[Y], [N], or [E] to exit'                                 # Operator confirmation of the back end port
                    if ($OperatorConfirm -eq 'e') {                                         # If $OperatorConfrim equals 'e'
                        Break NewAzureLBIBNatPoolConfig                                     # Breaks :NewAzureLBIBNatPoolConfig
                    }                                                                       # End if ($OperatorConfirm -eq 'e')
                    if ($OperatorConfirm -eq 'y') {                                         # If $OperatorConfrim equals 'y'
                        Break NewAzureLBBEPort                                              # Breaks :NewAzureLBBEPort        
                    }                                                                       # End if ($OperatorConfirm -eq 'y')
                }                                                                           # End elseif ($BackEndPort -ge 1)
            }                                                                               # End :NewAzureLBBEPort while ($true)
            
            $InboundNatPoolObject = New-AzLoadBalancerInboundNatPoolConfig -Name `
                $NatPoolNameObject -FrontendIpConfigurationId $FrontEndIPConfigObject.ID `
                -Protocol $NatPoolProtocolObject -FrontendPortRangeStart $FrontEndPortStart `
                -FrontendPortRangeEnd $FrontEndPortEnd -BackendPort $BackEndPort            # Creates the inbound pool object
            if ($InboundNatPoolObject) {                                                    # If $InboundNatPoolObject has a value
                Return $InboundNatPoolObject                                                # Returns $InboundNatPoolObject to calling function
            }                                                                               # End if ($InboundNatPoolObject)
            else {                                                                          # If $InboundNatPoolObject does not have a value
                Write-Host "An error has occured"                                           # Write message to screen
                Break NewAzureLBIBNatPoolConfig                                             # Breaks :NewAzureLBIBNatPoolConfig
            }                                                                               # End else (if ($InboundNatPoolObject))
        }                                                                                   # End :NewAzureLBIBNatPoolConfig while ($true)
        Return                                                                              # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function NewAzLBInboundNatPoolConfig
function NewAzLBRuleConfig {                                                                # Function to create a new load balancer rule
    Begin {                                                                                 # Begin function
        :NewAzureLBRuleConfig while ($true) {                                               # Outer loop for managing function
            :NewAzureLBRCName while ($true) {                                               # Inner loop for setting the rule name
                $LBRuleNameObject = Read-Host "Rule Name"                                   # Operator input for the pool name
                if ($LBRuleNameObject -eq 'exit') {                                         # If $LBRuleNameObject equals $null
                    Break NewAzureLBRuleConfig                                              # Breaks :NewAzureLBRuleConfig
                }                                                                           # End if ($LBRuleNameObject -eq 'exit')
                Write-Host $LBRuleNameObject                                                # Writes message to screen
                $OperatorConfirm = Read-Host "Use as the rule name? [Y] or [N]"             # Operator confirmation of the rule name
                if ($OperatorConfirm -eq 'y') {                                             # If $OperatorConfirm equals 'y'
                    Break NewAzureLBRCName                                                  # Breaks :NewAzureLBRCName
                }                                                                           # End if ($OperatorConfirm -eq 'y')
            }                                                                               # End :NewAzureLBRCName while ($true) {
            :NewAzureLBRuleProtocol while ($true) {                                         # Inner loop for setting the rule protocol
                Write-Host '[0] Exit'                                                       # Write message to screen
                Write-Host '[1] TCP'                                                        # Write message to screen
                Write-Host '[2] UDP'                                                        # Write message to screen
                $LBRuleProtocolObject = Read-Host '[0], [1], or [2]'                        # Operator input for the protocol object
                if ($LBRuleProtocolObject -eq '0') {                                        # If $LBRuleProtocolObject equals '0'
                    Break NewAzureLBRuleConfig                                              # Breaks :NewAzureLBRuleConfig
                }                                                                           # End if ($LBRuleProtocolObject -eq '0')
                elseif ($LBRuleProtocolObject -eq '1') {                                    # If $LBRuleProtocolObject equals '1'
                    $LBRuleProtocolObject = 'TCP'                                           # Sets $LBRuleProtocolObject to 'TCP'
                    Break NewAzureLBRuleProtocol                                            # Breaks :NewAzureLBRuleProtocol
                }                                                                           # End elseif ($LBRuleProtocolObject -eq '1')
                elseif ($LBRuleProtocolObject -eq '2') {                                    # If $LBRuleProtocolObject equals '2'
                    $LBRuleProtocolObject = 'UDP'                                           # Sets $LBRuleProtocolObject to 'UDP'
                    Break NewAzureLBRuleProtocol                                            # Breaks :NewAzureLBRuleProtocol
                }                                                                           # End elseif ($LBRuleProtocolObject -eq '2')
                else {                                                                      # All other inputs
                    Write-Host "That was not a valid entry"                                 # Write message to screen
                }                                                                           # End else (if ($LBRuleProtocolObject -eq '0')) 
            }                                                                               # End :NewAzureLBRuleProtocol while ($true)
            :NewAzureLBRuleFrontEndPort while ($true) {                                     # Inner loop for setting the rule front end port
                Try {                                                                       # Try the following
                    [int]$LBRuleFrontEndPort = Read-Host "Rule front end port"              # Operator input for the front end port 
                }                                                                           # End try
                Catch {}                                                                    # If try fails
                if ($LBRuleFrontEndPort -le 0) {                                            # If $LBRuleFrontEndPort is less than or equal to 0
                    Write-Host "Please enter a number"                                      # Write message to screen
                }                                                                           # End if ($LBRuleFrontEndPort -le 0) 
                elseif ($LBRuleFrontEndPort -ge 1) {                                        # If $LBRuleFrontEndPort is greater than or equal to 1
                    $OperatorConfirm = Read-Host 'Front end port will be' `
                    $LBRuleFrontEndPort '[Y], [N], or [E] to exit'                          # Operator confirmation of the front end port
                    if ($OperatorConfirm -eq 'e') {                                         # If $OperatorConfrim equals 'e'
                        Break NewAzureLBRuleConfig                                          # Breaks :NewAzureLBRuleConfig
                    }                                                                       # End if ($OperatorConfirm -eq 'e')
                    if ($OperatorConfirm -eq 'y') {                                         # If $OperatorConfrim equals 'y'
                        Break NewAzureLBRuleFrontEndPort                                    # Breaks :NewAzureLBRuleFrontEndPort        
                    }                                                                       # End if ($OperatorConfirm -eq 'y')
                }                                                                           # End elseif ($LBRuleFrontEndPort -ge 1)
            }                                                                               # End :NewAzureLBRuleFrontEndPort while ($true)
            :NewAzureLBRuleBackEndPort while ($true) {                                      # Inner loop for setting the rule back end port
                Try {                                                                       # Try the following
                    [int]$LBRuleBackEndPort = Read-Host "Rule back end port"                # Operator input for the back end port 
                }                                                                           # End try
                Catch {}                                                                    # If try fails
                if ($LBRuleBackEndPort -le 0) {                                             # If $LBRuleBackEndPort is less than or equal to 0
                    Write-Host "Please enter a number"                                      # Write message to screen
                }                                                                           # End if ($LBRuleBackEndPort -le 0) 
                elseif ($LBRuleBackEndPort -ge 1) {                                         # If $LBRuleBackEndPort is greater than or equal to 1
                    $OperatorConfirm = Read-Host 'Back end port will be' `
                    $LBRuleBackEndPort '[Y], [N], or [E] to exit'                           # Operator confirmation of the back end port
                    if ($OperatorConfirm -eq 'e') {                                         # If $OperatorConfrim equals 'e'
                        Break NewAzureLBRuleConfig                                          # Breaks :NewAzureLBRuleConfig
                    }                                                                       # End if ($OperatorConfirm -eq 'e')
                    if ($OperatorConfirm -eq 'y') {                                         # If $OperatorConfrim equals 'y'
                        Break NewAzureLBRuleBackEndPort                                     # Breaks :NewAzureLBRuleBackEndPort        
                    }                                                                       # End if ($OperatorConfirm -eq 'y')
                }                                                                           # End elseif ($LBRuleBackEndPort -ge 1)
            }                                                                               # End :NewAzureLBRuleBackEndPort while ($true)
            :NewAzureLBRuleIdleTO while ($true) {                                           # Inner loop for setting the rule idle timeout
                Try {                                                                       # Try the following
                    [int]$LBRuleIdleTO = Read-Host "Rule idle time out"                     # Operator input for the rule idle timeout
                }                                                                           # End try
                Catch {}                                                                    # If try fails
                if ($LBRuleIdleTO -le 0) {                                                  # If $LBRuleIdleTO is less than or equal to 0
                    Write-Host "Please enter a number"                                      # Write message to screen
                }                                                                           # End if ($LBRuleIdleTO -le 0) 
                elseif ($LBRuleIdleTO -ge 1) {                                              # If $LBRuleIdleTO is greater than or equal to 1
                    $OperatorConfirm = Read-Host 'Load balancer idle timeout will be' `
                    $LBRuleIdleTO '[Y], [N], or [E] to exit'                                # Operator confirmation of the rule idle timeout
                    if ($OperatorConfirm -eq 'e') {                                         # If $OperatorConfrim equals 'e'
                        Break NewAzureLBRuleConfig                                          # Breaks :NewAzureLBRuleConfig
                    }                                                                       # End if ($OperatorConfirm -eq 'e')
                    if ($OperatorConfirm -eq 'y') {                                         # If $OperatorConfrim equals 'y'
                        Break NewAzureLBRuleIdleTO                                          # Breaks :NewAzureLBRuleIdleTO        
                    }                                                                       # End if ($OperatorConfirm -eq 'y')
                }                                                                           # End elseif ($LBRuleIdleTO -ge 1)
            }                                                                               # End :NewAzureLBRuleIdleTO while ($true)
            $LoadBalanceRule = New-AzLoadBalancerRuleConfig -Name $LBRuleNameObject `
                -FrontendIPConfiguration $FrontEndIPConfigObject -BackendAddressPool `
                $BackEndIPConfigObject -Probe $HealthProbeObject -Protocol `
                $LBRuleProtocolObject -FrontendPort $LBRuleFrontEndPort -BackendPort `
                $LBRuleBackEndPort -IdleTimeoutInMinutes $LBRuleIdleTO -EnableFloatingIP `
                -LoadDistribution SourceIP                                                  # Creates the load balancer rule
            if ($LoadBalanceRule) {                                                         # If $LoadBalanceRule has a value
                Return $LoadBalanceRule                                                     # Returns to calling function with $LoadBalanceRule
            }                                                                               # End if ($LoadBalanceRule)
            else {                                                                          # If $LoadBalanceRule does not have a value
                Write-Host "An error has occured"                                           # Write message to screen
                Break NewAzLBRuleConfig                                                     # Breaks :NewAzLBRuleConfig     
            }                                                                               # End else (if ($LoadBalanceRule))
        }                                                                                   # End :NewAzureLBRuleConfig while ($true)
        Return                                                                              # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function NewAzLBRuleConfig
function ListAzLoadBalancer {                                                               # Function to get an existing load balancer
    Begin {                                                                                 # Begin function
        :ListAzureLoadBalancer while ($true) {                                              # Outer loop to manage function
            $LoadBalancerList = Get-AzLoadBalancer                                          # Generates the load balancer list
            [System.Collections.ArrayList]$LoadBalancerArray = @()                          # Creates the load balancer array
            foreach ($_ in $LoadBalancerList) {                                             # For each item in $LoadBalancerList
                if ($_.FrontendIpConfigurations.publicIPaddress.id) {                       # If the current item .FrontendIpConfigurations.publicIPaddress.id  has a value
                    $PubIPID = $_.FrontendIpConfigurations.publicIPaddress.id               # Sets $PubIPID to the current item .FrontendIpConfigurations.publicIPaddress.id 
                    $PublicIPObject = Get-AzPublicIpAddress | Where-Object `
                        {$_.ID -eq $PubIPID}                                                # Pulls the attached public IP sku info
                }                                                                           # End if ($_.FrontendIpConfigurations.publicIPaddress.id)
                $LoadBalancerInput = [PSCustomObject]@{'Name'= $_.Name;'RGName'=`
                    $_.ResourceGroupName;'Loc'=$_.Location;'Sku'=$_.Sku.Name;`
                    'PubAllocation'=$PublicIPObject.PublicIpAllocationMethod;`
                    'PubAddress'=$PublicIPObject.IpAddress;'Pubname'=`
                    $PublicIPObject.Name}                                                   # Creates the item to loaded into array
                $LoadBalancerArray.Add($LoadBalancerInput) | Out-Null                       # Loads item into array, out-null removes write to screen
                $PubIPID = $null                                                            # Clears $var
                $PublicIPObject = $null                                                     # Clears $var
            }                                                                               # End foreach ($_ in $LoadBalancerList)
            foreach ($_ in $LoadBalancerArray) {                                            # For each $_ in $LoadBalancerArray
                Write-Host 'Balancer name: '$_.Name                                         # Write message to screen
                Write-Host 'Balancer loc:  '$_.loc                                          # Write message to screen
                Write-Host 'Balancer RG:   '$_.RGName                                       # Write message to screen
                Write-Host 'Balancer sku:  '$_.Sku                                          # Write message to screen
                if ($_.Pubname) {                                                           # If $_.Pubname exists
                    Write-Host 'Public IP name:'$_.Pubname                                  # Write message to screen
                    Write-Host 'Public IP add: '$_.PubAddress                               # Write message to screen
                    Write-Host 'Public IP allo:'$_.PubAllocation                            # Write message to screen
                }                                                                           # End if ($_.Pubname)
                Write-Host ''                                                               # Write message to screen
            }                                                                               # End foreach ($_ in $LoadBalancerArray)
            Break ListAzureLoadBalancer                                                     # Breaks :ListAzureLoadBalancer
        }                                                                                   # End :ListAzureLoadBalancer while ($true)
        Return                                                                              # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function ListAzLoadBalancer    
function GetAzLoadBalancer {                                                                # Function to get an existing load balancer
    Begin {                                                                                 # Begin function
        :GetAzureLoadBalancer while ($true) {                                               # Outer loop to manage function
            $LoadBalancerList = Get-AzLoadBalancer                                          # Generates the load balancer list
            $LoadBalancerNumber = 1                                                         # Sets $LoadBalancerNumber to 1
            [System.Collections.ArrayList]$LoadBalancerArray = @()                          # Creates the load balancer array
            foreach ($_ in $LoadBalancerList) {                                             # For each $Offer in $LoadBalancerList
                $LoadBalancerInput = [PSCustomObject]@{'Name' = $_.Name; `
                    'Number' = $LoadBalancerNumber;'RGName'=$_.ResourceGroupName}           # Creates the item to loaded into array
                $LoadBalancerArray.Add($LoadBalancerInput) | Out-Null                       # Loads item into array, out-null removes write to screen
                $LoadBalancerNumber = $LoadBalancerNumber + 1                               # Increments $LoadBalancerNumber by 1
            }                                                                               # End foreach ($_ in $LoadBalancerList)
            Write-Host "0 Exit"                                                             # Write message to screen
            Write-Host ""                                                                   # Write message to screen
            foreach ($_ in $LoadBalancerArray) {                                            # For each $_ in $LoadBalancerArray
                Write-Host $_.Number                                                        # Write message to screen
                Write-Host $_.Name                                                          # Write message to screen
                Write-Host $_.RGName                                                        # Write message to screen
                Write-Host ""                                                               # Write message to screen
            }                                                                               # End foreach ($_ in $LoadBalancerArray)
            :SelectAzureLoadBalancer while ($true) {                                        # Inner loop to select the load balancer
                $OperatorSelect = Read-Host "Enter the load balancer number"                # Operator input for the load balancer selection
                if ($OperatorSelect -eq '0') {                                              # If $OperatorSelect equals 0
                    Break GetAzureLoadBalancer                                              # Breaks :GetAzureLoadBalancer
                }                                                                           # End if ($OperatorSelect -eq '0')
                $LoadBalancerObject = $LoadBalancerArray | Where-Object {$_.Number -eq `
                    $OperatorSelect}                                                        # $LoadBalancerObject is equal to $LoadBalancerArray where $LoadBalancerArray.Number equals $OperatorSelect
                if ($LoadBalancerObject) {                                                  # If $LoadBalancerObject has a value
                    $LoadBalancerObject = Get-AzLoadBalancer -Name `
                        $LoadBalancerObject.Name -ResourceGroupName `
                        $LoadBalancerObject.RGName                                          # Repulls the full load balancer object
                    Return $LoadBalancerObject                                              # Returns to calling function with $LoadBalancerObject
                }                                                                           # End if ($LoadBalancerObject)
                else {                                                                      # If $LoadBalancerObject does not have a value
                    Write-Host "That was not a valid option"                                # Write message to screen
                }                                                                           # End else (if ($LoadBalancerObject))
            }                                                                               # End :SelectAzureLoadBalancer while ($true)
        }                                                                                   # End :GetAzureLoadBalancer while ($true)
        Return                                                                              # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function GetAzLoadBalancer    
function RemoveAzLoadBalancer {                                                             # Function to remove a network interface
    Begin {                                                                                 # Begin function
        :RemoveAzureLoadBalancer while ($true) {                                            # Outer loop for managing function
            if (!$LoadBalancerObject) {                                                     # If $LoadBalancerObject does not have a value
                $CallingFunction = 'RemoveAzLoadBalancer'                                   # Sets $CallingFunction
                $LoadBalancerObject=GetAzLoadBalancer ($CallingFunction)                    # Calls function and assigns output to $var
                if (!$LoadBalancerObject) {                                                 # If $LoadBalancerObject does not have a value
                    Break RemoveAzureLoadBalancer                                           # Breaks :RemoveAzureLoadBalancer
                }                                                                           # End if (!$LoadBalancerObject)
            }                                                                               # End if (!$LoadBalancerObject)
            Write-Host 'Remove the load balancer named:'$LoadBalancerObject.name            # Write message to screen
            Write-Host 'from the resource group:'$LoadBalancerObject.ResourceGroupName      # Write message to screen
            $OperatorConfirm = Read-Host '[Y] or [N]'                                       # Operator confirmation to remove the Nic
            if ($OperatorConfirm -eq 'y') {                                                 # If $OperatorConfirm equals 'y;
                Try {                                                                       # Try the following
                    Remove-AzLoadBalancer -Name $LoadBalancerObject.Name -ResourceGroupName `
                        $LoadBalancerObject.ResourceGroupName -Force -ErrorAction 'Stop'    # Removes the selected load balancer
                }                                                                           # End try
                Catch {                                                                     # If try fails
                    Write-Host 'An error has occured'                                       # Write message to screen
                    Write-Host 'No changes have been made'                                  # Write message to screen
                    Break RemoveAzureLoadBalancer                                           # Breaks :RemoveAzureLoadBalancer
                }                                                                           # End catch
                Write-Host 'The selected load balancer has been removed'                    # Write message to screen
                Break RemoveAzureLoadBalancer                                               # Breaks :RemoveAzureLoadBalancer
            }                                                                               # End if ($OperatorConfirm -eq 'y')
            else {                                                                          # All other inputs for $OperatorConfirm
                Break RemoveAzureLoadBalancer                                               # Breaks :RemoveAzureLoadBalancer
            }                                                                               # End else (If ($OperatorConfirm -eq 'y'))
        }                                                                                   # End :RemoveAzureLoadBalancer while ($true)
        Return                                                                              # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function RemoveAzLoadBalancer
# Additional functions for ManageAzLoadBalancer
function NewAzPublicIpAddress {                                                             # Creates a new public IP address
    Begin {                                                                                 # Begin function
        $ErrorActionPreference='silentlyContinue'                                           # Turns off error reporting
        :NewAzurePublicIP while ($true) {                                                   # Outer loop for managing function
            if (!$RGObject) {                                                               # If $RGObject is $null
                $RGObject = GetAzResourceGroup                                              # Calls function and assigns output to $var
                if (!$RGObject) {                                                           # If $RGObject is $null
                    Break NewAzurePublicIP                                                  # Breaks :NewAzurePublicIP
                }                                                                           # End if (!$RGObject)
            }                                                                               # End if (!$RGObject)
            :SetAzurePublicIPName while ($true) {                                           # Inner loop for setting the public IP name
                Try {                                                                       # Try the following
                    [ValidatePattern('^[a-z][a-z0-9-]{1,61}[a-z0-9]$')]$PublicIPNameObject `
                    = [string](Read-Host "Enter the public IP name").ToLower()              # Operator input for the public IP name
                }                                                                           # End try
                catch {                                                                     # Error reporting for try statement
                    Write-Host "! That enty was not valid"                                  # Write message to screen
                    Write-Host "! Valid entries are 1-61 characters"                        # Write message to screen
                    Write-Host "! The name must start with a letter"                        # Write message to screen
                    Write-Host "! Special charaters are not allowed"                        # Write message to screen
                    Write-Host ""                                                           # Write message to screen
                }                                                                           # End catch
                if ($PublicIPNameObject) {
                    if ($PublicIPNameObject -eq 'exit') {                                   # IF $PublicIPNameObject equals 'exit'
                        Break NewAzurePublicIP                                              # Breaks :NewAzurePublicIP
                    }                                                                       # End if ($PublicIPNameObject -eq 'exit')
                    Write-Host $PublicIPNameObject                                          # Write message to screen
                    $OperatorConfirm = Read-Host "Use this name [Y] or [N]"                 # Operator confirmation of the name
                    if ($OperatorConfirm -eq 'y') {                                         # If $OperatorConfirm equals 'y'
                        Break SetAzurePublicIPName                                          # Breaks :SetAzurePublicIPName
                    }                                                                       # End if ($OperatorConfirm -eq 'y')
                    else {                                                                  # If $OperatorConfirm does not equal 'y'
                        Remove-Variable PublicIPNameObject                                  # Removes $PublicIPNameObject
                    }                                                                       # End else if ($OperatorConfirm -eq 'y')
                }                                                                           # End if ($PublicIPNameObject) 
            }                                                                               # End :SetAzurePublicIPName while ($true)
            :SetAzurePublicIPAlloc while ($true) {                                          # Inner loop for setting the public IP allocation method
                Write-Host '[0] Exit'                                                       # Write message to screen
                Write-Host '[1] Dynamic'                                                    # Write message to screen
                Write-Host '[2] Static'                                                     # Write message to screen
                $PublicIPAllocationObject = Read-Host "[0], [1], or [2]"                    # Operator input for the allocation method
                if ($PublicIPAllocationObject -eq '0') {                                    # If $PublicIPAllocationObject equals '0'
                    Break NewAzurePublicIP                                                  # Breaks :NewAzurePublicIP
                }                                                                           # End if ($PublicIPAllocationObject -eq '0')
                elseif ($PublicIPAllocationObject -eq '1') {                                # Elseif $PublicIPAllocationObject equals 1
                    $PublicIPAllocationObject = 'dynamic'                                   # Reassigns value of $PublicIPAllocationObject
                    Break SetAzurePublicIPAlloc                                             # Breaks :SetAzurePublicIPAlloc    
                }                                                                           # End elseif ($PublicIPAllocationObject -eq '1')
                elseif ($PublicIPAllocationObject -eq '2') {                                # Elseif $PublicIPAllocationObject equals 2
                    $PublicIPAllocationObject = 'static'                                    # Reassigns value of $PublicIPAllocationObject
                    Break SetAzurePublicIPAlloc                                             # Breaks :SetAzurePublicIPAlloc
                }                                                                           # End elseif ($PublicIPAllocationObject -eq '2')
                else {                                                                      # All other inputs
                    Write-Host "That was not a valid option"                                # Write message to screen
                }                                                                           # End else (($PublicIPAllocationObject -eq '0'))
            }                                                                               # End :SetAzurePublicIPAlloc while ($true)
            $PublicIPObject = New-AzPublicIpAddress -Name $PublicIPNameObject `
                -ResourceGroupName $RGObject.ResourceGroupName -Location `
                $RGObject.Location -AllocationMethod $PublicIPAllocationObject `
                -DomainNameLabel $PublicIPNameObject -Force                                 # Creates the new public IP address
            if ($PublicIPObject) {                                                          # If $PublicIPObject is not $null
                Return $PublicIPObject                                                      # Returns to calling function with $PublicIPObject
            }                                                                               # End if ($PublicIPObject)
            else {                                                                          # If $PublicIPObject is $null 
                Write-Host "An error has occured"                                           # Write message to screen
                Break NewAzurePublicIP                                                      # Breaks :NewAzurePublicIP
            }                                                                               # End else (if ($PublicIPObject))
        }                                                                                   # End :NewAzurePublicIP while ($true)
        Return                                                                              # Returns to calling function with # null
    }                                                                                       # End Begin
}                                                                                           # End function NewAzPublicIpAddress
function GetAzPublicIpAddress {                                                             # Function for getting a public IP sku
    Begin {                                                                                 # Begin function
        :GetAzurePublicIP while ($true) {                                                   # Outer loop for managing function
            $PublicIPList = Get-AzPublicIpAddress                                           # Gets a list of all public IP address
            [System.Collections.ArrayList]$PublicIPArray = @()                              # Creates array for list to be loaded into
            $PublicIPNumber = 1                                                             # Creates #var used for list selection
            foreach ($_ in $PublicIPList) {                                                 # For each item in list
                if ($_.IpConfiguration.Id) {                                                # If current item .IpConfiguration.Id has a value
                    $AttachedNIC = ($_.IpConfiguration.Id).Split('/')[-3]                   # Gets the attached NIC name
                    $AttachedNICIPConfig = ($_.IpConfiguration.Id).Split('/')[-1]           # Gets the attached NIC IP config name
                }                                                                           # End if ($_.IpConfiguration.Id) 
                $PublicIPInput = [PSCustomObject]@{'Number'=$PublicIPNumber;`
                    'Name' = $_.Name;'RG'=$_.ResourceGroupName;'Sku'=$_.Sku.Name;`
                    'Allocation'=$_.PublicIpAllocationMethod;'Address'=$_.IPAddress;'NIC'=`
                    $AttachedNIC;'IPconfig'=$AttachedNICIPConfig}                           # Creates the item to loaded into array
                $PublicIPArray.Add($PublicIPInput) | Out-Null                               # Loads item into array, out-null removes write to screen
                $PublicIPNumber = $PublicIPNumber + 1                                       # Increments $var up by 1
                $AttachedNIC = $null                                                        # Clears $var
                $AttachedNICIPConfig = $null                                                # Clears $var
            }                                                                               # End foreach ($_ in $PublicIPArray)
            Write-Host "[0] to exit"                                                        # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            foreach ($_ in $PublicIPArray) {                                                # For each item in list
                $Number = $_.Number                                                         # Creats $Number (Used for formating)
                Write-Host "[$Number]         "$_.Name                                      # Write message to screen
                Write-Host "RG Name:    "$_.RG                                              # Write message to screen
                Write-Host "Allocation: "$_.Allocation                                      # Write message to screen
                Write-Host "IP Address: "$_.address                                         # Write message to screen
                Write-Host "SKU Type:   "$_.Sku                                             # Write message to screen
                if ($_.Nic) {                                                               # If current item .Nic has a value
                    Write-Host "NIC Name:   "$_.Nic                                         # Write message to screen
                    Write-Host "NIC Config: "$_.IPConfig                                    # Write message to screen
                }                                                                           # End if ($_.Nic)                                 
                Write-Host ""                                                               # Write message to screen
            }                                                                               # End foreach ($_ in $PublicIPArray) 
            :SelectAzurePublicIP while ($true) {                                            # Inner loop for selecting the public IP
                if ($CallingFunction) {                                                     # If $Calling function has a value
                    Write-Host 'You are selecting the Public IP Sku for:'$CallingFunction   # Write message to screen
                }                                                                           # End if ($CallingFunction)
                $SelectPublicIP = Read-Host "Enter the list number for public IP"           # Operator input for the public IP selection
                if ($SelectPublicIP -eq '0') {                                              # If $var equals 0
                    Break GetAzurePublicIP                                                  # Breaks :GetAzurePublicIP
                }                                                                           # End if ($SelectPublicIP -eq '0')
                elseif ($SelectPublicIP -in $PublicIPArray.Number) {                        # If $SelectPublicIP in $PublicIPArray.Number list
                    $SelectPublicIP = $PublicIPArray | Where-Object `
                        {$_.Number -eq $SelectPublicIP}                                     # SelectPublicIP is equal to $PublicIPArray where $PublicIPArray.Number equals $SelectPublicIP
                    $PublicIPObject = Get-AzPublicIpAddress -Name $SelectPublicIP.Name `
                        -ResourceGroupName $SelectPublicIP.RG                               # Pulls $PublicIPObject
                    if ($PublicIPObject) {                                                  # If $PublicIPObject has a value
                        Return $PublicIPObject                                              # Returns to calling function with $PublicIPObject
                    }                                                                       # End if ($PublicIPObject)
                    else {                                                                  # If $PublicIPObject is $null
                        Write-Host "An error has occured"                                   # Write message to screen
                        Break GetAzurePublicIP                                              # Breaks :GetAzurePublicIP
                    }                                                                       # End else (if ($PublicIPObject))
                }                                                                           # End elseif ($SelectPublicIP -in $PublicIPArray.Number)
                else {                                                                      # All other values
                    Write-Host "That was not a valid option"                                # Write message to screen
                }                                                                           # End else (if ($SelectPublicIP -eq '0'))
            }                                                                               # End :SelectAzurePublicIP while ($true)
        }                                                                                   # End :GetAzurePublicIP while ($true)
        Return                                                                              # Returns to calling function with $null
    }                                                                                       # End begin
}                                                                                           # End function GetAzPublicIpAddress
function GetAzResourceGroup {                                                               # Function to get a resource group, can pipe $RGObject to another function
    Begin {                                                                                 # Begin function
        $ErrorActionPreference = 'silentlyContinue'                                         # Disables error reporting
        :GetAzureResourceGroup while ($true) {                                              # Outer loop for managing function
            $RGList = Get-AzResourceGroup                                                   # Gets all resource groups and assigns to $RGList
            $RGListNumber = 1                                                               # Sets $RGListNumber to 1
            [System.Collections.ArrayList]$RGListArray = @()                                # Creates the RG list array
            foreach ($_ in $RGList) {                                                       # For each $_ in $RGListList
                $RGListInput = [PSCustomObject]@{'Name' = $_.ResourceGroupName; `
                    'Number' = $RGListNumber; 'Location' = $_.Location}                     # Creates the item to loaded into array
                $RGListArray.Add($RGListInput) | Out-Null                                   # Loads item into array, out-null removes write to screen
                $RGListNumber = $RGListNumber + 1                                           # Increments $RGListNumber by 1
            }                                                                               # End foreach ($_ in $RGList)
            Write-Host "0 Exit"                                                             # Write message to screen
            foreach ($_ in $RGListArray) {                                                  # For each $_ in $RGListArray
                Write-Host $_.Number $_.Name "|" $_.Location                                # Writes RG number, name, and location to screen
            }                                                                               # End foreach ($_ in $RGListArray)
            :SelectAzureRGList while ($true) {                                              # Inner loop to select the resource group
                if ($CallingFunction) {                                                     # If $CallingFunction exists
                    Write-Host "You are selecting the resource group for"$CallingFunction   # Write message to screen
                }                                                                           # End if ($CallingFunction)
                $RGSelect = Read-Host "Enter the resource group number"                     # Operator input for the RG selection
                if ($RGSelect -eq '0') {                                                    # If $RGSelect equals 0
                    Break GetAzureResourceGroup                                             # Breaks :GetAzureResourceGroup
                }                                                                           # End if ($RGSelect -eq '0')
                $RGSelect = $RGListArray | Where-Object {$_.Number -eq $RGSelect}           # $RGSelect is equal to $RGArray where $RGArray.Number is equal to $RGSelect                                  
                $RGObject = Get-AzResourceGroup | Where-Object `
                    {$_.ResourceGroupName -eq $RGSelect.Name}                               # Pulls the full resource group object
                if ($RGObject) {                                                            # If $RGObject has a value
                    Return $RGObject                                                        # Returns to calling function with $RGObject
                }                                                                           # End if ($RGObject)
                else {                                                                      # If $RGObject does not have a value
                    Write-Host "That was not a valid option"                                # Write message to screen
                }                                                                           # End else (if ($RGObject))
            }                                                                               # End :SelectAzureRGList while ($true)
        }                                                                                   # End :GetAzureResourceGroup while ($true)
    }                                                                                       # End begin statement
}                                                                                           # End function GetAzResourceGroup