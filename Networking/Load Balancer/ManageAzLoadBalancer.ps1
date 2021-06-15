# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Mircosoft docs links
    New-AzLoadBalancer:                         https://docs.microsoft.com/en-us/powershell/module/az.network/new-azloadbalancer?view=azps-5.5.0  
    New-AzLoadBalancerFrontendIpConfig:         https://docs.microsoft.com/en-us/powershell/module/az.network/new-azloadbalancerfrontendipconfig?view=azps-5.5.0
    New-AzPublicIpAddress:                      https://docs.microsoft.com/en-us/powershell/module/az.network/new-azpublicipaddress?view=azps-5.5.0
    Get-AzPublicIpAddress:                      https://docs.microsoft.com/en-us/powershell/module/az.network/get-azpublicipaddress?view=azps-5.5.0
    New-AzLoadBalancerBackendAddressPoolConfig: https://docs.microsoft.com/en-us/powershell/module/az.network/new-azloadbalancerbackendaddresspoolconfig?view=azps-5.5.0
    New-AzLoadBalancerProbeConfig:              https://docs.microsoft.com/en-us/powershell/module/az.network/new-azloadbalancerbackendaddresspoolconfig?view=azps-5.5.0
    New-AzLoadBalancerRuleConfig:               https://docs.microsoft.com/en-us/powershell/module/az.network/new-azloadbalancerruleconfig?view=azps-5.5.0
    Get-AzResourceGroup:                        https://docs.microsoft.com/en-us/powershell/module/az.resources/get-azresourcegroup?view=azps-5.1.0     
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
    $OpSelect:                  Operator input for selecting the management function
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
        Call ManageAzLoadBalancer > Get $null
            Call NewAzLoadBalancer > Get $null
                Call GetAzResourceGroup > Get $RGObject
                End GetAzResourceGroup
                    Return NewAzLoadBalancer > Send $RGObject          
                Call NewAzLBFrontendIpConfig > Get $FrontEndIPConfigObject
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
                Return ManageAzLoadBalancer > Send $null
            Call ListAzLoadBalancer > Get $null
            End ListAzLoadBalancer
                Return ManageAzLoadBalancer > Send $null
            Call RemoveAzPublicIPAddres > Get $null
                Call GetAzLoadBalancer > Get $LoadBalancerObject
                End GetAzLoadBalancer
                    Return RemoveAzLoadBalancer > Send $LoadBalancerObject
            End RemoveAzLoadBalancer
                Return ManageAzLoadBalancer > Send $null
        End ManageAzLoadBalancer
            Return function > Send $null
}#>
function ManageAzLoadBalancer {                                                             # Function to manage load balancer Skus
    Begin {                                                                                 # Begin function
        :ManageAzureLoadBalancer while ($true) {                                            # Outer loop for managing function
            Write-Host '[0] Exit'                                                           # Write message to screen
            Write-Host '[1] New load balancer'                                              # Write message to screen
            Write-Host '[2] List load balancers'                                            # Write message to screen
            Write-Host '[3] Remove load balancer'                                           # Write message to screen
            $OpSelect = Read-Host 'Option [#]'                                              # Operator input for the function selection
            Clear-Host                                                                      # Clears screen
            if ($OpSelect -eq '0') {                                                        # If $OpSelect equals '0'    
                Break ManageAzureLoadBalancer                                               # Breaks :ManageAzureLoadBalancer
            }                                                                               # End if ($OpSelect -eq '0')
            elseif ($OpSelect -eq '1') {                                                    # Else if $OpSelect equals '1'
                Write-Host 'New load balancer'                                              # Write message to screen
                NewAzLoadBalancer                                                           # Calls function
            }                                                                               # elseif ($OpSelect -eq '1')
            elseif ($OpSelect -eq '2') {                                                    # Else if $OpSelect equals '2'
                Write-Host 'List load balancers'                                            # Write message to screen
                ListAzLoadBalancer                                                          # Calls function
            }                                                                               # elseif ($OpSelect -eq '2')
            elseif ($OpSelect -eq '3') {                                                    # Else if $OpSelect equals '3'
                Write-Host 'Remove load balancer'                                           # Write message to screen
                RemoveAzLoadBalancer                                                        # Calls function
            }                                                                               # elseif ($OpSelect -eq '3')
            else {                                                                          # All other inputs for $OpSelect
                Write-Host 'That was not a valid input'                                     # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Clear-Host                                                                  # Clears screen
            }                                                                               # End else (if ($OpSelect -eq 'exit'))
        }                                                                                   # End :ManageAzureLoadBalancer while ($true)
        Clear-Host                                                                          # Clears screen
        return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function ManageAzLoadBalancer
function NewAzLoadBalancer {                                                                # Function to create a new load balancer
    Begin {                                                                                 # Begin function
        if (!$CallingFunction) {                                                            # If $CallingFunction is $null
            $CallingFunction = 'NewAzLoadBalancer'                                          # Creates $CallingFunction
        }                                                                                   # End if (!$CallingFunction)
        :NewAzureLoadBalancer while ($true) {                                               # Outer loop for managing function
            $ValidArray = 'abcdefghijklmnopqrstuvwxyz0123456789-_.'                         # Creates a string of valid characters
            $ValidArray = $ValidArray.ToCharArray()                                         # Loads all valid characters into array
            $Valid1stChar = 'abcdefghijklmnopqrstuvwxyz0123456789'                          # Creates a string of valid first character
            $Valid1stChar = $Valid1stChar.ToCharArray()                                     # Loads all valid characters into array
            $ValidLastChar = 'abcdefghijklmnopqrstuvwxyz0123456789_'                        # Creates a string of valid last character
            $ValidLastChar = $ValidLastChar.ToCharArray()                                   # Loads all valid characters into array
            :SetAzureLBName while ($true) {                                                 # Inner loop for setting the balancer name
                Write-Host 'Enter the load balancer name'                                   # Write message to screen
                Write-Host ''                                                               # Writes message to screen
                $LBNameObject = Read-Host 'Name'                                            # Operator input for the balancer name
                $LBNameArray = $LBNameObject.ToCharArray()                                  # Loads $LBNameObject into array
                Clear-Host                                                                  # Clears screen
                if ($LBNameObject.Length -ge 81) {                                          # If $PublicNameInput.Length is greater or equal to 81
                    Write-Host 'The load balancer name is to long'                          # Write message to screen
                    Write-Host 'Max length of the name is 80 characters'                    # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    $LBNameObject = $null                                                   # Clears $LBNameObject
                }                                                                           # End if ($LBNameObject.Length -ge 80)
                if ($LBNameArray[0] -notin $Valid1stChar) {                                 # If 0 position of $LBNameArray is not in $Valid1stChar
                    Write-Host 'The first character of the name must be a letter or number' # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    $LBNameObject = $null                                                   # Clears $LBNameObject
                }                                                                           # End if ($LBNameArray[0] -notin $Valid1stChar)
                if ($LBNameArray[-1] -notin $ValidLastChar) {                               # If last position of $LBNameArray is not in $ValidLastChar
                    Write-Host `
                        'The last character of the name must be a letter, number or _ '     # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    $LBNameObject = $null                                                   # Clears $LBNameObject
                }                                                                           # End if ($LBNameArray[0] -notin $Valid1stChar)
                foreach ($_ in $LBNameArray) {                                              # For each item in $LBNameArray
                    if ($_ -notin $ValidArray) {                                            # If current item is not in $ValidArray
                        if ($_ -eq ' ') {                                                   # If current item equals 'space'
                            Write-Host ''                                                   # Write message to screen    
                            Write-Host 'Load balancer name cannot include any spaces'       # Write message to screen
                        }                                                                   # End if ($_ -eq ' ')
                        else {                                                              # If current item is not equal to 'space'
                            Write-Host ''                                                   # Write message to screen    
                            Write-Host $_' is not a valid character'                        # Write message to screen
                        }                                                                   # End else (if ($_ -eq ' '))
                        $LBNameObject = $null                                               # Clears $LBNameObject
                    }                                                                       # End if ($_ -notin $ValidArray)
                }                                                                           # End foreach ($_ in $LBNameArray)
                if ($LBNameObject) {                                                        # If $LBNameObject has a value
                    Write-Host 'Use:'$LBNameObject' as the balancer name'                   # Writes message to screen
                    Write-Host ''                                                           # Writes message to screen
                    $OpConfirm = Read-Host '[Y] Yes [N] No [E] Exit'                        # Operator confirmation of the balancer name
                    Clear-Host                                                              # Clears screen
                    if ($OpConfirm -eq 'e') {                                               # If $OpConfirm equals 'e'
                        Break NewAzureLoadBalancer                                          # Breaks :NewAzureLoadBalancer
                    }                                                                       # End if ($OpConfirm -eq 'e')
                    if ($OpConfirm -eq 'y') {                                               # If $OpConfirm equals 'y'
                        Break SetAzureLBName                                                # Breaks :SetAzureLBName
                    }                                                                       # End if ($OpConfirm -eq 'y')
                }                                                                           # End if ($LBNameObject)
                else {                                                                      # If $LBNameObject does not have a value
                    Pause                                                                   # Pauses all actions for operator input
                    Clear-Host                                                              # Clears screen
                }                                                                           # End else (if ($LBNameObject))
            }                                                                               # End :SetAzureLBName while ($true)
            $RGObject = GetAzResourceGroup ($CallingFunction)                               # Calls function and assigns output to $var
            if (!$RGObject) {                                                               # If $RGObject is $null
                Break NewAzureLoadBalancer                                                  # Breaks :NewAzureLoadBalancer
            }                                                                               # End if (!$RGObject)
            $FrontEndIPConfigObject = NewAzLBFrontendIpConfig ($CallingFunction)            # Calls function and assigns output to $var
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
            $InboundNatPoolObject = NewAzLBIBNatPoolConfig `
                ($FrontEndIPConfigObject, $CallingFunction)                                 # Calls function and assigns output to $var
            if (!$InboundNatPoolObject) {                                                   # If $InboundNatPoolObject is $null
                Break NewAzureLoadBalancer                                                  # Breaks :NewAzureLoadBalancer
            }                                                                               # End if (!$InboundNatPoolObject)
            $LoadBalanceRule = NewAzLBRuleConfig ($FrontEndIPConfigObject, `
                $BackEndIPConfigObject, $HealthProbeObject, $CallingFunction)               # Calls function and assigns output to $var
            if (!$LoadBalanceRule) {                                                        # If $LoadBalanceRule is $null
                Break NewAzureLoadBalancer                                                  # Breaks :NewAzureLoadBalancer
            }                                                                               # End if (!$LoadBalanceRule)
            Try {                                                                           # Try the following
                Write-Host 'Creating the load balanacer'                                    # Write message to screen
                New-AzLoadBalancer -Name $LBNameObject -ResourceGroupName `
                    $RGObject.ResourceGroupName -Location $RGObject.Location `
                    -FrontendIpConfiguration $FrontEndIPConfigObject -BackendAddressPool `
                    $BackEndIPConfigObject -Probe $HealthProbeObject -LoadBalancingRule `
                    $LBRule -InboundNatPool $InboundNatPoolObject -ErrorAction 'Stop' `
                    | Out-Null                                                              # Creates the load balancer
            }                                                                               # End try
            Catch {                                                                         # If Try fails
                Clear-Host                                                                  # Clears screen
                Write-Host 'An error has occured'                                           # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Write-Host 'The provided ports configuratiob may not be valid'              # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Write-Host 'You may not have the permissions to do this'                    # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Write-Host 'The resource group maybe locked'                                # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break NewAzureLoadBalancer                                                  # Breaks :NewAzureLoadBalancer
            }                                                                               # End Catch
            Clear-Host                                                                      # Clears screen
            Write-Host 'The load balancer has been created'                                 # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            Pause                                                                           # Pauses all actions for operator input
            Break NewAzureLoadBalancer                                                      # Breaks :NewAzureLoadBalancer
        }                                                                                   # End :NewAzureLoadBalancer while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function NewAzLoadBalancer
function NewAzLBFrontendIpConfig {                                                          # Function to set up the front end IP for a load balancer
    Begin {                                                                                 # Begin function
        :NewAzureLBFEIpConfig while ($true) {                                               # Outer loop for managing the function
            :SetAzurePublicIP while ($true) {                                               # Inner loop for selecting the public IP sku
                $PublicIPObject = GetAzPublicIpAddress ($CallingFunction)                   # Calls function and assigns output to $var
                if (!$PublicIPObject) {                                                     # If $var is $null
                    Break NewAzureLBFEIpConfig                                              # Breaks :NewAzureLPFEIpConfig
                }                                                                           # End if (!$PublicIPObject)
                if ($PublicIPObject.IpConfiguration.Id) {                                   # If $PublicIPObject.IpConfiguration.Id has a value
                    Write-Host 'The selected public IP sku is already in use'               # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    Write-Host 'Select a different public IP sku?'                          # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    $OpSelect = Read-Host '[Y] Yes [N] No'                                  # Operator selection to choose a new public IP sku
                    Clear-Host                                                              # Clears screen
                    if ($OpSelect -eq 'y') {                                                # If $OpSelect equals 'y'
                        $PublicIPObject = $null                                             # Clears $PublicIPObject
                    }                                                                       # End if ($OpSelect -eq 'y')
                    else {                                                                  # Else if $OpSelect does not equal 'y'
                        Break NewAzureLBFEIpConfig                                          # Breaks :NewAzureLPFEIpConfig
                    }                                                                       # End if ($OpSelect -eq 'y')
                }                                                                           # End if ($PublicIPObject.IpConfiguration.Id)
                else {                                                                      # if $PublicIPObject.IpConfiguration.Id is $null
                    Break SetAzurePublicIP                                                  # Breaks :SetAzurePublicIP
                }                                                                           # End else (if ($PublicIPObject.IpConfiguration.Id))
            }                                                                               # End :SetAzurePublicIP while ($true)
            $ValidArray = 'abcdefghijklmnopqrstuvwxyz0123456789-_.'                         # Creates a string of valid characters
            $ValidArray = $ValidArray.ToCharArray()                                         # Loads all valid characters into array
            $Valid1stChar = 'abcdefghijklmnopqrstuvwxyz0123456789'                          # Creates a string of valid first character
            $Valid1stChar = $Valid1stChar.ToCharArray()                                     # Loads all valid characters into array
            $ValidLastChar = 'abcdefghijklmnopqrstuvwxyz0123456789_'                        # Creates a string of valid last character
            $ValidLastChar = $ValidLastChar.ToCharArray()                                   # Loads all valid characters into array
            :SetAzureLBFEName while ($true) {                                               # Inner loop for setting the front end name
                Write-Host 'Enter the load balancer front end name'                         # Write message to screen
                Write-Host ''                                                               # Writes message to screen
                $FrontEndNameObject = Read-Host 'Name'                                      # Operator input for the front end name
                $FrontEndNameArray = $FrontEndNameObject.ToCharArray()                      # Loads $FrontEndNameArray into array
                Clear-Host                                                                  # Clears screen
                if ($FrontEndNameObject.Length -ge 81) {                                    # If $FrontEndNameObject.Length is greater or equal to 81
                    Write-Host 'The front end name is to long'                              # Write message to screen
                    Write-Host 'Max length of the name is 80 characters'                    # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    $FrontEndNameObject = $null                                             # Clears $FrontEndNameObject
                }                                                                           # End if ($LBNameObject.Length -ge 80)
                if ($FrontEndNameArray[0] -notin $Valid1stChar) {                           # If 0 position of $FrontEndNameArray is not in $Valid1stChar
                    Write-Host 'The first character of the name must be a letter or number' # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    $FrontEndNameObject = $null                                             # Clears $FrontEndNameObject
                }                                                                           # End if ($FrontEndNameArray[0] -notin $Valid1stChar)
                if ($FrontEndNameArray[-1] -notin $ValidLastChar) {                         # If last position of $FrontEndNameArray is not in $ValidLastChar
                    Write-Host `
                        'The last character of the name must be a letter, number or _ '     # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    $FrontEndNameObject = $null                                             # Clears $FrontEndNameObject
                }                                                                           # End if ($FrontEndNameArray[0] -notin $Valid1stChar)
                foreach ($_ in $FrontEndNameArray) {                                        # For each item in $FrontEndNameArray
                    if ($_ -notin $ValidArray) {                                            # If current item is not in $ValidArray
                        if ($_ -eq ' ') {                                                   # If current item equals 'space'
                            Write-Host ''                                                   # Write message to screen    
                            Write-Host 'Front end name cannot include any spaces'           # Write message to screen
                        }                                                                   # End if ($_ -eq ' ')
                        else {                                                              # If current item is not equal to 'space'
                            Write-Host ''                                                   # Write message to screen    
                            Write-Host $_' is not a valid character'                        # Write message to screen
                        }                                                                   # End else (if ($_ -eq ' '))
                        $FrontEndNameObject = $null                                         # Clears $FrontEndNameObject
                    }                                                                       # End if ($_ -notin $ValidArray)
                }                                                                           # End foreach ($_ in $LBNameArray)
                if ($FrontEndNameObject) {                                                  # $FrontEndNameObject has a value
                    Write-Host 'Use:'$FrontEndNameObject' as the front end name'            # Writes message to screen
                    Write-Host ''                                                           # Writes message to screen
                    $OpConfirm = Read-Host '[Y] Yes [N] No [E] Exit'                        # Operator confirmation of the front end name
                    Clear-Host                                                              # Clears screen
                    if ($OpConfirm -eq 'e') {                                               # If $OpConfirm equals 'e''
                        Break NewAzureLBFEIpConfig                                          # Breaks :NewAzureLBFEIpConfig
                    }                                                                       # End if ($OpConfirm -eq 'e')
                    if ($OpConfirm -eq 'y') {                                               # If $OpConfirm equals 'y'
                        Break SetAzureLBFEName                                              # Breaks :SetAzureLBFEName
                    }                                                                       # End if ($OpConfirm -eq 'y')
                }                                                                           # End if ($FrontEndNameObject)
                else {                                                                      # If $FrontEndNameObject does not have a value
                    Pause                                                                   # Pauses all actions for operator input
                    Clear-Host                                                              # Clears screen
                }                                                                           # End else (if ($FrontEndNameObject))
            }                                                                               # End :SetAzureLBFEName while ($true)
            Try {                                                                           # Try the following
                Write-Host 'Building the load balancer front end config'                    # Write message to screen
                $FrontEndIPConfigObject = New-AzLoadBalancerFrontendIpConfig -Name `
                    $FrontEndNameObject -PublicIpAddress $PublicIPObject -ErrorAction `
                    'Stop'                                                                  # Creates the load balancer front end pool
            }                                                                               # End try
            Catch {                                                                         # If try fails
                Clear-Host                                                                  # Clears screen
                Write-Host 'An error has occured'                                           # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break NewAzureLBFEIpConfig                                                  # Breaks :NewAzureLBFEIpConfig
            }                                                                               # End catch
            Clear-Host                                                                      # Clears screen
            Write-Host 'Front end config has been built'                                    # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            Pause                                                                           # Pauses all actions for operator input
            Clear-Host                                                                      # Clears screen
            Return $FrontEndIPConfigObject                                                  # Returns to calling function with $var
        }                                                                                   # End :NewAzureLBFEIpConfig while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function NewAzLBFrontendIpConfig
function NewAzLBBackendIpConfig {                                                           # Function to set up the Back end IP for a load balancer
    Begin {                                                                                 # Begin function
        :NewAzureLBBEIpConfig while ($true) {                                               # Outer loop for managing the function
            $ValidArray = 'abcdefghijklmnopqrstuvwxyz0123456789-_.'                         # Creates a string of valid characters
            $ValidArray = $ValidArray.ToCharArray()                                         # Loads all valid characters into array
            $Valid1stChar = 'abcdefghijklmnopqrstuvwxyz0123456789'                          # Creates a string of valid first character
            $Valid1stChar = $Valid1stChar.ToCharArray()                                     # Loads all valid characters into array
            $ValidLastChar = 'abcdefghijklmnopqrstuvwxyz0123456789_'                        # Creates a string of valid last character
            $ValidLastChar = $ValidLastChar.ToCharArray()                                   # Loads all valid characters into array
            :SetAzureLBBEName while ($true) {                                               # Inner loop for setting the back end name
                Write-Host 'Enter the load balancer back end name'                          # Write message to screen
                Write-Host ''                                                               # Writes message to screen
                $BackEndNameObject = Read-Host 'Name'                                       # Operator input for the back end name
                $BackEndNameArray = $BackEndNameObject.ToCharArray()                        # Loads $BackEndNameArray into array
                Clear-Host                                                                  # Clears screen
                if ($BackEndNameObject.Length -ge 81) {                                     # If $BackEndNameObject.Length is greater or equal to 81
                    Write-Host 'The back end name is to long'                               # Write message to screen
                    Write-Host 'Max length of the name is 80 characters'                    # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    $BackEndNameObject = $null                                              # Clears $BackEndNameObject
                }                                                                           # End if ($LBNameObject.Length -ge 80)
                if ($BackEndNameArray[0] -notin $Valid1stChar) {                            # If 0 position of $BackEndNameArray is not in $Valid1stChar
                    Write-Host 'The first character of the name must be a letter or number' # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    $BackEndNameObject = $null                                              # Clears $BackEndNameObject
                }                                                                           # End if ($BackEndNameArray[0] -notin $Valid1stChar)
                if ($BackEndNameArray[-1] -notin $ValidLastChar) {                          # If last position of $BackEndNameArray is not in $ValidLastChar
                    Write-Host `
                        'The last character of the name must be a letter, number or _ '     # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    $BackEndNameObject = $null                                              # Clears $BackEndNameObject
                }                                                                           # End if ($BackEndNameArray[0] -notin $Valid1stChar)
                foreach ($_ in $BackEndNameArray) {                                         # For each item in $BackEndNameArray
                    if ($_ -notin $ValidArray) {                                            # If current item is not in $ValidArray
                        if ($_ -eq ' ') {                                                   # If current item equals 'space'
                            Write-Host ''                                                   # Write message to screen    
                            Write-Host 'Back end name cannot include any spaces'            # Write message to screen
                        }                                                                   # End if ($_ -eq ' ')
                        else {                                                              # If current item is not equal to 'space'
                            Write-Host ''                                                   # Write message to screen    
                            Write-Host $_' is not a valid character'                        # Write message to screen
                        }                                                                   # End else (if ($_ -eq ' '))
                        $BackEndNameObject = $null                                          # Clears $BackEndNameObject
                    }                                                                       # End if ($_ -notin $ValidArray)
                }                                                                           # End foreach ($_ in $LBNameArray)
                if ($BackEndNameObject) {                                                   # $BackEndNameObject has a value
                    Write-Host 'Use:'$BackEndNameObject' as the back end name'              # Writes message to screen
                    Write-Host ''                                                           # Writes message to screen
                    $OpConfirm = Read-Host '[Y] Yes [N] No [E] Exit'                        # Operator confirmation of the back end name
                    Clear-Host                                                              # Clears screen
                    if ($OpConfirm -eq 'e') {                                               # If $OpConfirm equals 'e''
                        Break NewAzureLBBEIpConfig                                          # Breaks :NewAzureLBBEIpConfig
                    }                                                                       # End if ($OpConfirm -eq 'e')
                    if ($OpConfirm -eq 'y') {                                               # If $OpConfirm equals 'y'
                        Break SetAzureLBBEName                                              # Breaks :SetAzureLBBEName
                    }                                                                       # End if ($OpConfirm -eq 'y')
                }                                                                           # End if ($BackEndNameObject)
                else {                                                                      # If $BackEndNameObject does not have a value
                    Pause                                                                   # Pauses all actions for operator input
                    Clear-Host                                                              # Clears screen
                }                                                                           # End else (if ($BackEndNameObject))
            }                                                                               # End :SetAzureLBBEName while ($true)
            Try {                                                                           # Try the following
                Write-Host 'Building the load balancer back end config'                     # Write message to screen
                $BackEndIPConfigObject = New-AzLoadBalancerBackendAddressPoolConfig -Name `
                    $BackEndNameObject -ErrorAction 'Stop'                                  # Creates the load balancer back end pool
            }                                                                               # End try
            Catch {                                                                         # If try fails
                Clear-Host                                                                  # Clears screen
                Write-Host 'An error has occured'                                           # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break NewAzureLBBEIpConfig                                                  # Breaks :NewAzureLBBEIpConfig
            }                                                                               # End catch
            Clear-Host                                                                      # Clears screen    
            Write-Host 'Back end config has been built'                                     # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            Pause                                                                           # Pauses all actions for operator input
            Clear-Host                                                                      # Clears screen
            Return $BackEndIPConfigObject                                                   # Returns to calling function with $var
        }                                                                                   # End :NewAzureLBBEIpConfig while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function NewAzLBBackendIpConfig
function NewAzLBProbeConfig {                                                               # Function to sett up load balancer health probes
    Begin {                                                                                 # Begin function
        :NewAzureLBProbeConfig while ($true) {                                              # Out loop for managing function
            $ValidArray = 'abcdefghijklmnopqrstuvwxyz0123456789-_.'                         # Creates a string of valid characters
            $ValidArray = $ValidArray.ToCharArray()                                         # Loads all valid characters into array
            $Valid1stChar = 'abcdefghijklmnopqrstuvwxyz0123456789'                          # Creates a string of valid first character
            $Valid1stChar = $Valid1stChar.ToCharArray()                                     # Loads all valid characters into array
            $ValidLastChar = 'abcdefghijklmnopqrstuvwxyz0123456789_'                        # Creates a string of valid last character
            $ValidLastChar = $ValidLastChar.ToCharArray()                                   # Loads all valid characters into array
            :SetAzureProbeName while ($true) {                                              # Inner loop for setting the probe name
                Write-Host 'Enter the load balancer probe name'                             # Write message to screen
                Write-Host ''                                                               # Writes message to screen
                $ProbeNameObject = Read-Host 'Name'                                         # Operator input for the probe name
                $ProbeNameArray = $ProbeNameObject.ToCharArray()                            # Loads $ProbeNameArray into array
                Clear-Host                                                                  # Clears screen
                if ($ProbeNameObject.Length -ge 81) {                                       # If $ProbeNameObject.Length is greater or equal to 81
                    Write-Host 'The probe name is to long'                                  # Write message to screen
                    Write-Host 'Max length of the name is 80 characters'                    # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    $ProbeNameObject = $null                                                # Clears $ProbeNameObject
                }                                                                           # End if ($ProbeNameObject.Length -ge 80)
                if ($ProbeNameArray[0] -notin $Valid1stChar) {                              # If 0 position of $ProbeNameArray is not in $Valid1stChar
                    Write-Host 'The first character of the name must be a letter or number' # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    $ProbeNameObject = $null                                                # Clears $ProbeNameObject
                }                                                                           # End if ($ProbeNameArray[0] -notin $Valid1stChar)
                if ($ProbeNameArray[-1] -notin $ValidLastChar) {                            # If last position of $ProbeNameArray is not in $ValidLastChar
                    Write-Host `
                        'The last character of the name must be a letter, number or _ '     # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    $ProbeNameObject = $null                                                # Clears $ProbeNameObject
                }                                                                           # End if ($ProbeNameArray[0] -notin $Valid1stChar)
                foreach ($_ in $ProbeNameArray) {                                           # For each item in $ProbeNameArray
                    if ($_ -notin $ValidArray) {                                            # If current item is not in $ValidArray
                        if ($_ -eq ' ') {                                                   # If current item equals 'space'
                            Write-Host ''                                                   # Write message to screen    
                            Write-Host 'Probe name cannot include any spaces'               # Write message to screen
                        }                                                                   # End if ($_ -eq ' ')
                        else {                                                              # If current item is not equal to 'space'
                            Write-Host ''                                                   # Write message to screen    
                            Write-Host $_' is not a valid character'                        # Write message to screen
                        }                                                                   # End else (if ($_ -eq ' '))
                        $ProbeNameObject = $null                                            # Clears $ProbeNameObject
                    }                                                                       # End if ($_ -notin $ValidArray)
                }                                                                           # End foreach ($_ in $LBNameArray)
                if ($ProbeNameObject) {                                                     # If $ProbeNameObject has a value
                    Write-Host 'Use:'$ProbeNameObject' as the probe name'                   # Writes message to screen
                    Write-Host ''                                                           # Writes message to screen
                    $OpConfirm = Read-Host '[Y] Yes [N] No [E] Exit'                        # Operator confirmation of the probe name
                    Clear-Host                                                              # Clears screen
                    if ($OpConfirm -eq 'e') {                                               # If $OpConfirm equals 'e'
                        Break NewAzureLBProbeConfig                                         # Breaks :NewAzureLBProbeConfig
                    }                                                                       # End if ($OpConfirm -eq 'e')
                    if ($OpConfirm -eq 'y') {                                               # If $OpConfirm equals 'y'
                        Break SetAzureProbeName                                             # Breaks :SetAzureProbeName
                    }                                                                       # End if ($OpConfirm -eq 'y')
                }                                                                           # End $ProbeNameObject
                else {                                                                      # If $ProbeNameObject does not have a value
                    Pause                                                                   # Pauses all actions for operator input
                    Clear-Host                                                              # Clears screen
                }                                                                           # End else $ProbeNameObject
            }                                                                               # End :SetAzureProbeName while ($true)
            :SetAzureProbeProtocol while ($true) {                                          # Inner loop for setting the probe type
                Write-Host 'Load balanacer health probe protocol'                           # Write message to screen
                Write-Host '[0] Exit'                                                       # Write message to screen
                Write-Host '[1] Http (80)'                                                  # Write message to screen
                Write-host '[2] Https(443)'                                                 # Write message to screen
                Write-Host ''                                                               # Writes message to screen
                $OpSelect = Read-Host 'Option[#]'                                           # Operator input for the probe type object
                Clear-Host                                                                  # Clears screen
                if ($OpSelect -eq '0') {                                                    # If $OpSelect equals '0'
                    Break NewAzureLBProbeConfig                                             # Breaks :NewAzureLBProbeConfig 
                }                                                                           # End if ($OpSelect -eq '0')
                elseif ($OpSelect -eq '1') {                                                # Elseif $OpSelect equals '1'
                    [System.Collections.ArrayList]$ProbeProtocol = @()                      # Creates array for list to be loaded into
                    $ProbeProtocolInput = [PSCustomObject]@{'Protocol' = 'http';`
                        'port' = '80'}                                                      # Creates the item to loaded into array
                    $ProbeProtocol.Add($ProbeProtocolInput) | Out-Null                      # Loads item into array, out-null removes write to screen         
                    Break SetAzureProbeProtocol                                             # Breaks :SetAzureProbeProtocol 
                }                                                                           # End elseif ($OpSelect -eq '1')
                elseif ($OpSelect -eq '2') {                                                # Elseif $OpSelect equals '2'
                    [System.Collections.ArrayList]$ProbeProtocol = @()                      # Creates array for list to be loaded into
                    $ProbeProtocolInput = [PSCustomObject]@{'Protocol' = 'https';`
                        'port' = '443'}                                                     # Creates the item to loaded into array
                    $ProbeProtocol.Add($ProbeProtocolInput) | Out-Null                      # Loads item into array, out-null removes write to screen         
                    Break SetAzureProbeProtocol                                             # Breaks :SetAzureProbeProtocol 
                }                                                                           # End elseif ($OpSelect -eq '2')
                else {                                                                      # All other inputs for $OpSelect
                    Write-Host 'That was not a valid input'                                 # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Clear-Host                                                              # Clears screen
                }                                                                           # End else (If $OpSelect -eq '0')
            }                                                                               # End :SetAzureProbeProtocol while ($true)
            $ValidArray = '0123456789'                                                      # Creates a string of valid characters
            $ValidArray = $ValidArray.ToCharArray()                                         # Loads all valid characters into array
            :SetAzureProbeInterval while ($true) {                                          # Inner loop for setting the probe interval time
                Write-Host 'Enter the probe interval in seconds'                            # Write message to screen
                Write-Host ''                                                               # Writes message to screen
                $ProbeIntervalObject = Read-Host 'Probe interval'                           # Operator input for the probe interval
                $ProbeIntervalArray = $ProbeIntervalObject.ToCharArray()                    # Loads $ProbeIntervalObject into array
                Clear-Host                                                                  # Clears screen
                foreach ($_ in $ProbeIntervalArray) {                                       # For each item in $ProbeIntervalArray
                    if ($_ -notin $ValidArray) {                                            # If current item is not in $ValidArray
                        $ProbeIntervalObject = $null                                        # Clears $ProbeIntervalObject
                    }                                                                       # End if ($_ -notin $ValidArray)
                }                                                                           # End foreach ($_ in $ProbeIntervalArray)
                $ProbeIntervalArray = $null                                                 # Clears $ProbeIntervalArray
                if ($ProbeIntervalObject) {                                                 # If $ProbeIntervalObject has a value
                    Write-Host 'Set probe interval at:'$ProbeIntervalObject' Seconds'       # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    $OpConfirm = Read-Host '[Y] Yes [N] No [E] Exit'                        # Operator confirmation of the probe interval
                    Clear-Host                                                              # Clears screen
                    if ($OpConfirm -eq 'e') {                                               # If $OpConfirm equals 'e'
                        Break NewAzureLBProbeConfig                                         # Breaks :NewAzureLBProbeConfig
                    }                                                                       # End if ($OpConfirm -eq 'e')
                    if ($OpConfirm -eq 'y') {                                               # If $OpConfirm equals 'y'
                        Break SetAzureProbeInterval                                         # Breaks :SetAzureProbeInterval        
                    }                                                                       # End if ($OpConfirm -eq 'y')
                }                                                                           # End if ($ProbeIntervalObject)
                else {                                                                      # Else if $ProbeIntervalObject is $null
                    Write-Host 'That was not a valid input'                                 # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Clear-Host                                                              # Clears screen
                }                                                                           # End else (if ($ProbeIntervalObject))
            }                                                                               # End :SetAzureProbeInterval while ($true)
            :SetAzureProbeCount while ($true) {                                             # Inner loop for setting the probe count
                Write-Host 'Enter the number of probes required to'                         # Write message to screen
                Write-Host 'report node is no longer functioning'                           # Write message to screen
                Write-Host ''                                                               # Write message to screen
                $ProbeCountObject = Read-Host 'Probe count'                                 # Operator input for the probe count
                $ProbeCountArray = $ProbeCountObject.ToCharArray()                          # Loads $ProbeCountObject into array
                Clear-Host                                                                  # Clears screen
                foreach ($_ in $ProbeCountArray) {                                          # For each item in $ProbeIntervalArray
                    if ($_ -notin $ValidArray) {                                            # If current item is not in $ValidArray
                        $ProbeCountObject = $null                                           # Clears $ProbeCountObject
                    }                                                                       # End if ($_ -notin $ValidArray)
                }                                                                           # End foreach ($_ in $ProbeIntervalArray)
                $ProbeIntervalArray = $null                                                 # Clears $ProbeIntervalArray
                if ($ProbeCountObject) {                                                    # If $ProbeCountObject has a value
                    Write-Host 'Set probe count at:'$ProbeCountObject                       # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    $OpConfirm = Read-Host '[Y] Yes [N] No [E] Exit'                        # Operator confirmation of the probe interval
                    Clear-Host                                                              # Clears screen
                    if ($OpConfirm -eq 'e') {                                               # If $OpConfirm equals 'e'
                        Break NewAzureLBProbeConfig                                         # Breaks :NewAzureLBProbeConfig
                    }                                                                       # End if ($OpConfirm -eq 'e')
                    if ($OpConfirm -eq 'y') {                                               # If $OpConfirm equals 'y'
                        Break SetAzureProbeCount                                            # Breaks :SetAzureProbeCount        
                    }                                                                       # End if ($OpConfirm -eq 'y')
                }                                                                           # End if ($ProbeCountObject)
                else {                                                                      # All other inputs for $ProbeCountObject
                    Write-Host 'That was not a valid input'                                 # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Clear-Host                                                              # Clears screen
                }                                                                           # End else (if ($ProbeCountObject))
            }                                                                               # End :SetAzureProbeCount while ($true)
            Try {                                                                           # Try the following
                Write-Host 'Building health probe configuration'                            # Write message to screen
                $HealthProbeObject = New-AzLoadBalancerProbeConfig -Name $ProbeNameObject `
                    -RequestPath healthcheck.aspx -Protocol $ProbeProtocol.Protocol `
                    -Port $ProbeProtocol.Port -IntervalInSeconds $ProbeIntervalObject `
                    -ProbeCount $ProbeCountObject -ErrorAction 'Stop'                       # Creates the Health probe object
            }                                                                               # End try
            Catch {                                                                         # If Try fails
                Clear-Host                                                                  # Clears screen
                Write-Host 'An error has occured'                                           # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break NewAzureLBProbeConfig                                                 # Breaks :NewAzureLBProbeConfig
            }                                                                               # End catch
            Clear-Host                                                                      # Clears screen    
            Write-Host 'Health probe config has been built'                                 # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            Pause                                                                           # Pauses all actions for operator input
            Clear-Host                                                                      # Clears screen
            Return $HealthProbeObject                                                       # Returns to calling function with $var
        }                                                                                   # End :NewAzureLBProbeConfig while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End begin
}                                                                                           # End function NewAzLBProbeConfig
function NewAzLBIBNatPoolConfig {                                                           # Function to create inbound pool configuration for load balancer
    begin {                                                                                 # Begin function
        :NewAzureLBIBNatPoolConfig while ($true) {                                          # Outer loop for managing function
            $ValidArray = 'abcdefghijklmnopqrstuvwxyz0123456789-_.'                         # Creates a string of valid characters
            $ValidArray = $ValidArray.ToCharArray()                                         # Loads all valid characters into array
            $Valid1stChar = 'abcdefghijklmnopqrstuvwxyz0123456789'                          # Creates a string of valid first character
            $Valid1stChar = $Valid1stChar.ToCharArray()                                     # Loads all valid characters into array
            $ValidLastChar = 'abcdefghijklmnopqrstuvwxyz0123456789_'                        # Creates a string of valid last character
            $ValidLastChar = $ValidLastChar.ToCharArray()                                   # Loads all valid characters into array
            :NewAzureLBIBNatPoolName while ($true) {                                        # Inner loop for setting the nat pool name
                Write-Host 'Enter the load balancer nat pool name'                          # Write message to screen
                Write-Host ''                                                               # Writes message to screen    
                $NatPoolNameObject = Read-Host 'Name'                                       # Operator input for the pool name
                $NatPoolNameArray = $NatPoolNameObject.ToCharArray()                        # Loads $NatPoolNameArray into array
                Clear-Host                                                                  # Clears screen
                if ($NatPoolNameObject.Length -ge 81) {                                     # If $NatPoolNameObject.Length is greater or equal to 81
                    Write-Host 'The pool name is to long'                                   # Write message to screen
                    Write-Host 'Max length of the name is 80 characters'                    # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    $NatPoolNameObject = $null                                              # Clears $NatPoolNameObject
                }                                                                           # End if ($NatPoolNameObject.Length -ge 80)
                if ($NatPoolNameArray[0] -notin $Valid1stChar) {                            # If 0 position of $NatPoolNameArray is not in $Valid1stChar
                    Write-Host 'The first character of the name must be a letter or number' # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    $NatPoolNameObject = $null                                              # Clears $NatPoolNameObject
                }                                                                           # End if ($NatPoolNameArray[0] -notin $Valid1stChar)
                if ($NatPoolNameArray[-1] -notin $ValidLastChar) {                          # If last position of $NatPoolNameArray is not in $ValidLastChar
                    Write-Host `
                        'The last character of the name must be a letter, number or _ '     # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    $NatPoolNameObject = $null                                              # Clears $NatPoolNameObject
                }                                                                           # End if ($NatPoolNameArray[0] -notin $Valid1stChar)
                foreach ($_ in $NatPoolNameArray) {                                         # For each item in $NatPoolNameArray
                    if ($_ -notin $ValidArray) {                                            # If current item is not in $ValidArray
                        if ($_ -eq ' ') {                                                   # If current item equals 'space'
                            Write-Host ''                                                   # Write message to screen    
                            Write-Host 'Pool name cannot include any spaces'                # Write message to screen
                        }                                                                   # End if ($_ -eq ' ')
                        else {                                                              # If current item is not equal to 'space'
                            Write-Host ''                                                   # Write message to screen    
                            Write-Host $_' is not a valid character'                        # Write message to screen
                        }                                                                   # End else (if ($_ -eq ' '))
                        $NatPoolNameObject = $null                                          # Clears $NatPoolNameObject
                    }                                                                       # End if ($_ -notin $ValidArray)
                }                                                                           # End foreach ($_ in $LBNameArray)
                if ($NatPoolNameObject) {                                                   # If $NatPoolNameObject has a value
                    Write-Host 'Use:'$NatPoolNameObject' as the pool name'                  # Writes message to screen
                    Write-Host ''                                                           # Writes message to screen
                    $OpConfirm = Read-Host '[Y] Yes [N] No [E] Exit'                        # Operator confirmation of the pool name
                    Clear-Host                                                              # Clears screen
                    if ($OpConfirm -eq 'e') {                                               # If $OpConfirm equals 'e'
                        Break NewAzureLBIBNatPoolConfig                                     # Breaks :NewAzureLBIBNatPoolConfig
                    }                                                                       # End if ($OpConfirm -eq 'e')
                    if ($OpConfirm -eq 'y') {                                               # If $OpConfirm equals 'y'
                        Break NewAzureLBIBNatPoolName                                       # Breaks :NewAzureLBIBNatPoolName
                    }                                                                       # End if ($OpConfirm -eq 'y')
                }                                                                           # End if ($NatPoolNameObject)
                else {                                                                      # If $NatPoolNameObject is $null
                    Pause                                                                   # Pauses all actions for operator input
                    Clear-Host                                                              # Clears screen
                }                                                                           # End else (if ($NatPoolNameObject))
            }                                                                               # End :NewAzureLBIBNatPoolName while ($true) {
            :NewAzureLBIBNPProtocol while ($true) {                                         # Inner loop for setting the nat pool protocol
                Write-Host 'Load balancer nat pool protocol'                                # Write message to screen
                Write-Host '[0] Exit'                                                       # Write message to screen
                Write-Host '[1] TCP'                                                        # Write message to screen
                Write-Host '[2] UDP'                                                        # Write message to screen
                Write-Host ''                                                               # Writes message to screen
                $OpSelect = Read-Host 'Option [#]'                                          # Operator input for the protocol object
                Clear-Host                                                                  # Clears screen
                if ($OpSelect -eq '0') {                                                    # If $OpSelect equals '0'
                    Break NewAzureLBIBNatPoolConfig                                         # Breaks :NewAzureLBIBNatPoolConfig
                }                                                                           # End if ($OpSelect -eq '0')
                elseif ($OpSelect -eq '1') {                                                # If $OpSelect equals '1'
                    $NatPoolProtocolObject = 'TCP'                                          # Sets $NatPoolProtocolObject to 'TCP'
                    Break NewAzureLBIBNPProtocol                                            # Breaks :NewAzureLBIBNPProtocol
                }                                                                           # End elseif ($OpSelect -eq '1')
                elseif ($OpSelect -eq '2') {                                                # If $OpSelect equals '2'
                    $NatPoolProtocolObject = 'UDP'                                          # Sets $NatPoolProtocolObject to 'UDP'
                    Break NewAzureLBIBNPProtocol                                            # Breaks :NewAzureLBIBNPProtocol
                }                                                                           # End elseif ($OpSelect -eq '2')
                else {                                                                      # All other inputs for $OpSelect
                    Write-Host 'That was not a valid input'                                 # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Clear-Host                                                              # Clears screen
                }                                                                           # End else (if ($OpSelect -eq '0')) 
            }                                                                               # End :NewAzureLBIBNPProtocol while ($true)
            $ValidArray = '0123456789'                                                      # Creates a string of valid characters
            $ValidArray = $ValidArray.ToCharArray()                                         # Loads all valid characters into array
            :NewAzureLBFEPortStart while ($true) {                                          # Inner loop for setting the front end port range start
                Write-Host 'Enter the nat pool front end port start'                        # Write message to screen
                Write-Host ''                                                               # Writes message to screen
                $FrontEndPortStart = Read-Host 'Starting port #'                            # Operator input for the front end port start
                $FrontEndPortArray = $FrontEndPortStart.ToCharArray()                       # Adds $FrontEndPortStart to array
                Clear-Host                                                                  # Clears screen
                foreach ($_ in $FrontEndPortArray) {                                        # For each item in $FrontEndPortArray
                    if ($_ -notin $ValidArray) {                                            # If current item is not in $ValidArray
                        $FrontEndPortStart = $null                                          # Clears $FrontEndPortStart
                    }                                                                       # End if ($_ -notin $ValidArray)
                }                                                                           # End foreach ($_ in $FrontEndPortArray)
                $FrontEndPortArray = $null                                                  # Clears $FrontEndPortArray
                if ($FrontEndPortStart) {                                                   # If $FrontEndPortStart has a value
                    Write-Host 'Use:'$FrontEndPortStart' as the front end pool start'       # Write message to screen
                    Write-Host ''                                                           # Writes message to screen
                    $OpConfirm = Read-Host '[Y] Yes [N] No [E] Exit'                        # Operator confirmation of the front end port start
                    Clear-Host                                                              # Clears screen
                    if ($OpConfirm -eq 'e') {                                               # If $OpConfirm equals 'e'
                        Break NewAzureLBIBNatPoolConfig                                     # Breaks :NewAzureLBIBNatPoolConfig
                    }                                                                       # End if ($OpConfirm -eq 'e')
                    if ($OpConfirm -eq 'y') {                                               # If $OpConfirm equals 'y'
                        Break NewAzureLBFEPortStart                                         # Breaks :NewAzureLBFEPortStart        
                    }                                                                       # End if ($OpConfirm -eq 'y')
                }                                                                           # End if ($FrontEndPortStart)
                else {                                                                      # Else if $FrontEndPortStart is $null
                    Write-Host 'That was not a valid input'                                 # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Clear-Host                                                              # Clears screen
                }                                                                           # End else (if ($FrontEndPortStart))
            }                                                                               # End :NewAzureLBFEPortStart while ($true)
            :NewAzureLBFEPortEnd while ($true) {                                            # Inner loop for setting the front end port range end
                Write-Host 'Enter the nat pool front end port end'                          # Write message to screen
                Write-Host ''                                                               # Writes message to screen
                $FrontEndPortEnd = Read-Host 'Ending port #'                                # Operator input for the front end port start
                $FrontEndPortArray = $FrontEndPortEnd.ToCharArray()                         # Adds $FrontEndPortEnd to array
                Clear-Host                                                                  # Clears screen
                foreach ($_ in $FrontEndPortArray) {                                        # For each item in $FrontEndPortArray
                    if ($_ -notin $ValidArray) {                                            # If current item is not in $ValidArray
                        $FrontEndPortEnd = $null                                            # Clears $FrontEndPortEnd
                    }                                                                       # End if ($_ -notin $ValidArray)
                }                                                                           # End foreach ($_ in $FrontEndPortArray)
                $FrontEndPortArray = $null                                                  # Clears $FrontEndPortArray
                if ($FrontEndPortEnd) {                                                     # If $FrontEndPortEnd has a value
                    Write-Host 'Use:'$FrontEndPortEnd' as the front end pool end'           # Write message to screen
                    Write-Host ''                                                           # Writes message to screen
                    $OpConfirm = Read-Host '[Y] Yes [N] No [E] Exit'                        # Operator confirmation of the front end port end
                    Clear-Host                                                              # Clears screen
                    if ($OpConfirm -eq 'e') {                                               # If $OpConfirm equals 'e'
                        Break NewAzureLBIBNatPoolConfig                                     # Breaks :NewAzureLBIBNatPoolConfig
                    }                                                                       # End if ($OpConfirm -eq 'e')
                    if ($OpConfirm -eq 'y') {                                               # If $OpConfirm equals 'y'
                        Break NewAzureLBFEPortEnd                                           # Breaks :NewAzureLBFEPortEnd        
                    }                                                                       # End if ($OpConfirm -eq 'y')
                }                                                                           # End if ($FrontEndPortEnd)
                else {                                                                      # Else if $FrontEndPortEnd is $null
                    Write-Host 'That was not a valid input'                                 # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Clear-Host                                                              # Clears screen
                }                                                                           # End else (if ($FrontEndPortEnd))
            }                                                                               # End :NewAzureLBFEPortEnd while ($true)
            :NewAzureLBBEPort while ($true) {                                               # Inner loop for setting the back end port
                Write-Host 'Enter the nat pool back end port'                               # Write message to screen
                Write-Host ''                                                               # Writes message to screen
                $BackEndPort = Read-Host 'Back end port #'                                  # Operator input for the back end port
                $BackEndPortArray = $BackEndPort.ToCharArray()                              # Adds $BackEndPort to array
                Clear-Host                                                                  # Clears screen
                foreach ($_ in $BackEndPortArray) {                                         # For each item in $BackEndPortArray
                    if ($_ -notin $ValidArray) {                                            # If current item is not in $ValidArray
                        $BackEndPort = $null                                                # Clears $BackEndPort
                    }                                                                       # End if ($_ -notin $ValidArray)
                }                                                                           # End foreach ($_ in $BackEndPortArray)
                $BackEndPortArray = $null                                                   # Clears $BackEndPortArray
                if ($BackEndPort) {                                                         # If $BackEndPort has a value
                    Write-Host 'Use:'$BackEndPort' as the back end port'                    # Write message to screen
                    Write-Host ''                                                           # Writes message to screen
                    $OpConfirm = Read-Host '[Y] Yes [N] No [E] Exit'                        # Operator confirmation of the back end port
                    Clear-Host                                                              # Clears screen 
                    if ($OpConfirm -eq 'e') {                                               # If $OpConfirm equals 'e'
                        Break NewAzureLBIBNatPoolConfig                                     # Breaks :NewAzureLBIBNatPoolConfig
                    }                                                                       # End if ($OpConfirm -eq 'e')
                    if ($OpConfirm -eq 'y') {                                               # If $OpConfirm equals 'y'
                        Break NewAzureLBBEPort                                              # Breaks :NewAzureLBBEPort        
                    }                                                                       # End if ($OpConfirm -eq 'y')
                }                                                                           # End if ($BackEndPort)
                else {                                                                      # Else if $BackEndPort is $null
                    Write-Host 'That was not a valid input'                                 # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Clear-Host                                                              # Clears screen
                }                                                                           # End else (if ($BackEndPort))
            }                                                                               # End :NewAzureLBBEPort while ($true)
            Try {                                                                           # Try the following
                Write-Host 'Creating the nat pool'                                          # Write message to screen
                $InboundNatPoolObject = New-AzLoadBalancerInboundNatPoolConfig -Name `
                    $NatPoolNameObject -FrontendIpConfigurationId `
                    $FrontEndIPConfigObject.ID -Protocol $NatPoolProtocolObject `
                    -FrontendPortRangeStart $FrontEndPortStart -FrontendPortRangeEnd `
                    $FrontEndPortEnd -BackendPort $BackEndPort -ErrorAction 'Stop'          # Creates the inbound pool object
            }                                                                               # End try
            Catch {                                                                         # If Try fails
                Clear-Host                                                                  # Clears screen
                Write-Host 'An error has occured'                                           # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break NewAzureLBIBNatPoolConfig                                             # Breaks :NewAzureLBIBNatPoolConfig
            }                                                                               # End catch
            Clear-Host                                                                      # Clears screen
            Write-Host 'The nat pool has been created'                                      # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            Pause                                                                           # Pauses all actions for operator input
            Clear-Host                                                                      # Clears screen
            Return $InboundNatPoolObject                                                    # Returns $InboundNatPoolObject to calling function
        }                                                                                   # End :NewAzureLBIBNatPoolConfig while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function NewAzLBInboundNatPoolConfig
function NewAzLBRuleConfig {                                                                # Function to create a new load balancer rule
    Begin {                                                                                 # Begin function
        :NewAzureLBRuleConfig while ($true) {                                               # Outer loop for managing function
            $ValidArray = 'abcdefghijklmnopqrstuvwxyz0123456789-_.'                         # Creates a string of valid characters
            $ValidArray = $ValidArray.ToCharArray()                                         # Loads all valid characters into array
            $Valid1stChar = 'abcdefghijklmnopqrstuvwxyz0123456789'                          # Creates a string of valid first character
            $Valid1stChar = $Valid1stChar.ToCharArray()                                     # Loads all valid characters into array
            $ValidLastChar = 'abcdefghijklmnopqrstuvwxyz0123456789_'                        # Creates a string of valid last character
            $ValidLastChar = $ValidLastChar.ToCharArray()                                   # Loads all valid characters into array
            :NewAzureLBRCName while ($true) {                                               # Inner loop for setting the rule name
                Write-Host 'Enter a load balancer rule name'                                # Write message to screen
                Write-Host ''                                                               # Writes message to screen
                $LBRuleNameObject = Read-Host 'Name'                                        # Operator input for the pool name
                Clear-Host                                                                  # Clears screen
                $LBRuleNameArray = $LBRuleNameObject.ToCharArray()                          # Loads $LBRuleNameArray into array
                Clear-Host                                                                  # Clears screen
                if ($LBRuleNameObject.Length -ge 81) {                                      # If $LBRuleNameObject.Length is greater or equal to 81
                    Write-Host 'The rule name is to long'                                   # Write message to screen
                    Write-Host 'Max length of the name is 80 characters'                    # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    $LBRuleNameObject = $null                                               # Clears $LBRuleNameObject
                }                                                                           # End if ($LBRuleNameObject.Length -ge 80)
                if ($LBRuleNameArray[0] -notin $Valid1stChar) {                             # If 0 position of $LBRuleNameArray is not in $Valid1stChar
                    Write-Host 'The first character of the name must be a letter or number' # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    $LBRuleNameObject = $null                                               # Clears $LBRuleNameObject
                }                                                                           # End if ($LBRuleNameArray[0] -notin $Valid1stChar)
                if ($LBRuleNameArray[-1] -notin $ValidLastChar) {                           # If last position of $LBRuleNameArray is not in $ValidLastChar
                    Write-Host `
                        'The last character of the name must be a letter, number or _ '     # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    $LBRuleNameObject = $null                                               # Clears $LBRuleNameObject
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
                        $LBRuleNameObject = $null                                           # Clears $LBRuleNameObject
                    }                                                                       # End if ($_ -notin $ValidArray)
                }                                                                           # End foreach ($_ in $LBNameArray)
                if ($LBRuleNameObject) {                                                    # If $LBRuleNameObject has a value
                    Write-Host 'Use:'$LBRuleNameObject' as the rule name'                   # Writes message to screen
                    Write-Host ''                                                           # Writes message to screen
                    $OpConfirm = Read-Host '[Y] Yes [N] No [E] Exit'                        # Operator confirmation of the rule name
                    Clear-Host                                                              # Clears screen
                    if ($OpConfirm -eq 'e') {                                               # If $OpConfirm equals 'e'
                        Break NewAzureLBRuleConfig                                          # Breaks :NewAzureLBRuleConfig
                    }                                                                       # End if ($OpConfirm -eq 'e')
                    if ($OpConfirm -eq 'y') {                                               # If $OpConfirm equals 'y'
                        Break NewAzureLBRCName                                              # Breaks :NewAzureLBRCName
                    }                                                                       # End if ($OpConfirm -eq 'y')
                }                                                                           # End if ($LBRuleNameObject)
                else {                                                                      # If $LBRuleNameObject is $null
                    Pause                                                                   # Pauses all actions for operator input
                    Clear-Host                                                              # Clears screen
                }                                                                           # End else (if ($LBRuleNameObject))
            }                                                                               # End :NewAzureLBRCName while ($true) {
            :NewAzureLBRuleProtocol while ($true) {                                         # Inner loop for setting the rule protocol
                Write-Host 'Load balancer rule protocol'                                    # Write message to screen
                Write-Host '[0] Exit'                                                       # Write message to screen
                Write-Host '[1] TCP'                                                        # Write message to screen
                Write-Host '[2] UDP'                                                        # Write message to screen
                Write-Host ''                                                               # Writes message to screen
                $OpSelect = Read-Host 'Option [#]'                                          # Operator input for the protocol object
                Clear-Host                                                                  # Clears screen
                if ($OpSelect -eq '0') {                                                    # If $OpSelect equals '0'
                    Break NewAzureLBRuleConfig                                              # Breaks :NewAzureLBRuleConfig
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
            :NewAzureLBRuleFrontEndPort while ($true) {                                     # Inner loop for setting the rule front end port
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
                        Break NewAzureLBRuleConfig                                          # Breaks :NewAzureLBRuleConfig
                    }                                                                       # End if ($OpConfirm -eq 'e')
                    if ($OpConfirm -eq 'y') {                                               # If $OpConfirm equals 'y'
                        Break NewAzureLBRuleFrontEndPort                                    # Breaks :NewAzureLBRuleFrontEndPort        
                    }                                                                       # End if ($OpConfirm -eq 'y')
                }                                                                           # End if ($LBRuleFrontEndPort)
                else {                                                                      # Else if $LBRuleFrontEndPort is $null
                    Write-Host 'That was not a valid input'                                 # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Clear-Host                                                              # Clears screen
                }                                                                           # End else (if ($LBRuleFrontEndPort))
            }                                                                               # End :NewAzureLBRuleFrontEndPort while ($true)
            :NewAzureLBRuleBackEndPort while ($true) {                                      # Inner loop for setting the rule back end port
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
                        Break NewAzureLBRuleConfig                                          # Breaks :NewAzureLBRuleConfig
                    }                                                                       # End if ($OpConfirm -eq 'e')
                    if ($OpConfirm -eq 'y') {                                               # If $OpConfirm equals 'y'
                        Break NewAzureLBRuleBackEndPort                                     # Breaks :NewAzureLBRuleBackEndPort        
                    }                                                                       # End if ($OpConfirm -eq 'y')
                }                                                                           # End if ($LBRuleBackEndPort)
                else {                                                                      # Else if $LBRuleBackEndPort is $null
                    Write-Host 'That was not a valid input'                                 # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Clear-Host                                                              # Clears screen
                }                                                                           # End else (if ($LBRuleBackEndPort))
            }                                                                               # End :NewAzureLBRuleBackEndPort while ($true)
            :NewAzureLBRuleIdleTO while ($true) {                                           # Inner loop for setting the rule idle timeout
                Write-Host 'Enter the idle time out in seconds for this rule'               # Write message to screen
                Write-Host ''                                                               # Writes message to screen
                $LBRuleIdleTO = Read-Host 'Idle timeout'                                    # Operator input for the rule idle timeout 
                $LBRuleArray = $LBRuleIdleTO.ToCharArray()                                  # Adds $LBRuleIdleTO to array
                Clear-Host                                                                  # Clears screen
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
                        Break NewAzureLBRuleConfig                                          # Breaks :NewAzureLBRuleConfig
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
                Write-Host 'Creating the load balancer rule'                                # Write message to screen
                $LoadBalanceRule = New-AzLoadBalancerRuleConfig -Name $LBRuleNameObject `
                    -FrontendIPConfiguration $FrontEndIPConfigObject -BackendAddressPool `
                    $BackEndIPConfigObject -Probe $HealthProbeObject -Protocol `
                    $LBRuleProtocolObject -FrontendPort $LBRuleFrontEndPort -BackendPort `
                    $LBRuleBackEndPort -IdleTimeoutInMinutes $LBRuleIdleTO `
                    -EnableFloatingIP -LoadDistribution SourceIP -ErrorAction 'Stop'        # Creates the load balancer rule
            }                                                                               # End try
            Catch {                                                                         # If Try fails
                Clear-Host                                                                  # Clears screen
                Write-Host 'An error has occured'                                           # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break NewAzureLBRuleConfig                                                  # Breaks :NewAzureLBRuleConfig
            }                                                                               # End catch
            Clear-Host                                                                      # Clears screen
            Write-Host 'The rule has been created'                                          # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            Pause                                                                           # Pauses all actions for operator input
            Clear-Host                                                                      # Clears screen
            Return $LoadBalanceRule                                                         # Returns $LoadBalanceRule to calling function
        }                                                                                   # End :NewAzureLBRuleConfig while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function NewAzLBRuleConfig
function ListAzLoadBalancer {                                                               # Function to list all existing load balancers
    Begin {                                                                                 # Begin function
        :ListAzureLoadBalancer while ($true) {                                              # Outer loop to manage function
            Write-Host 'Gathering load balancer info'                                       # Write message to screen
            Write-Host 'This may take a moment'                                             # Write message to screen
            $ObjectList = Get-AzLoadBalancer                                                # Generates the load balancer list
            if (!$ObjectList) {                                                             # If $ObjectList is $null 
                Clear-Host                                                                  # Clears screen
                Write-Host 'No load balancers are in this subscription'                     # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break ListAzureLoadBalancer                                                 # Breaks :ListAzureLoadBalancer
            }                                                                               # End if (!$ObjectList)
            [System.Collections.ArrayList]$ObjectArray = @()                                # Creates the load balancer array
            foreach ($_ in $ObjectList) {                                                   # For each item in $ObjectList
                if ($_.FrontendIpConfigurations.publicIPaddress.id) {                       # If the current item .FrontendIpConfigurations.publicIPaddress.id  has a value
                    $PubIPID = $_.FrontendIpConfigurations.publicIPaddress.id               # Sets $PubIPID to the current item .FrontendIpConfigurations.publicIPaddress.id 
                    $PublicIPObject = Get-AzPublicIpAddress | Where-Object `
                        {$_.ID -eq $PubIPID}                                                # Pulls the attached public IP sku info
                }                                                                           # End if ($_.FrontendIpConfigurations.publicIPaddress.id)
                $ObjectInput = [PSCustomObject]@{                                           # Creates the item to loaded into array
                    'Name'= $_.Name;'RG'=$_.ResourceGroupName;'Loc'=$_.Location;`
                    'Sku'=$_.Sku.Name;'PubAllocation'=`
                    $PublicIPObject.PublicIpAllocationMethod;'PubAddress'=`
                    $PublicIPObject.IpAddress;'Pubname'=$PublicIPObject.Name                # Creates the item to loaded into array
                }                                                                           # End $ObjectInput = [PSCustomObject]@
                $ObjectArray.Add($ObjectInput) | Out-Null                                   # Loads item into array
            }                                                                               # End foreach ($_ in $ObjectList)
            Clear-Host                                                                      # Clears screen
            foreach ($_ in $ObjectArray) {                                                  # For each $_ in $ObjectArray
                Write-Host 'LB name:       '$_.Name                                         # Write message to screen
                Write-Host 'LB loc:        '$_.loc                                          # Write message to screen
                Write-Host 'LB RG:         '$_.RG                                           # Write message to screen
                Write-Host 'LB SKU:        '$_.Sku                                          # Write message to screen
                if ($_.Pubname) {                                                           # If $_.Pubname exists
                    Write-Host 'Pub IP name:   '$_.Pubname                                  # Write message to screen
                    Write-Host 'Pub IP address:'$_.PubAddress                               # Write message to screen
                    Write-Host 'Pub IP allocat:'$_.PubAllocation                            # Write message to screen
                }                                                                           # End if ($_.Pubname)
                Write-Host ''                                                               # Write message to screen
            }                                                                               # End foreach ($_ in $LoadBalancerArray)
            Pause                                                                           # Pauses all actions for operator input
            Break ListAzureLoadBalancer                                                     # Breaks :ListAzureLoadBalancer
        }                                                                                   # End :ListAzureLoadBalancer while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function ListAzLoadBalancer       
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
                if ($_.FrontendIpConfigurations.publicIPaddress.id) {                       # If the current item .FrontendIpConfigurations.publicIPaddress.id  has a value
                    $PubIPID = $_.FrontendIpConfigurations.publicIPaddress.id               # Sets $PubIPID to the current item .FrontendIpConfigurations.publicIPaddress.id 
                    $PublicIPObject = Get-AzPublicIpAddress | Where-Object `
                        {$_.ID -eq $PubIPID}                                                # Pulls the attached public IP sku info
                }                                                                           # End if ($_.FrontendIpConfigurations.publicIPaddress.id)
                $ObjectInput = [PSCustomObject]@{                                           # Creates the item to loaded into array
                    'Number'=$ObjectNumber;'Name'=$_.Name;'RGName'=$_.ResourceGroupName;`
                    'LOC'=$_.Location;'Sku'=$_.Sku.Name;'PubAllocation'=`
                    $PublicIPObject.PublicIpAllocationMethod;`
                    'PubAddress'=$PublicIPObject.IpAddress;'Pubname'=$PublicIPObject.Name   # Gets current item info
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
                    if ($_.Pubname) {                                                       # If $_.Pubname exists
                        Write-Host 'Pub IP name:   '$_.Pubname                              # Write message to screen
                        Write-Host 'Pub IP address:'$_.PubAddress                           # Write message to screen
                        Write-Host 'Pub IP allocat:'$_.PubAllocation                        # Write message to screen
                    }                                                                       # End if ($_.Pubname)
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
            $OpConfirm = Read-Host '[Y] or [N]'                                       # Operator confirmation to remove the Nic
            if ($OpConfirm -eq 'y') {                                                 # If $OpConfirm equals 'y;
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
            }                                                                               # End if ($OpConfirm -eq 'y')
            else {                                                                          # All other inputs for $OpConfirm
                Break RemoveAzureLoadBalancer                                               # Breaks :RemoveAzureLoadBalancer
            }                                                                               # End else (If ($OpConfirm -eq 'y'))
        }                                                                                   # End :RemoveAzureLoadBalancer while ($true)
        Return                                                                              # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function RemoveAzLoadBalancer
# Additional functions for ManageAzLoadBalancer

function GetAzPublicIpAddress {                                                             # Function for getting a public IP sku
    Begin {                                                                                 # Begin function
        :GetAzurePublicIP while ($true) {                                                   # Outer loop for managing function
            $ObjectList = Get-AzPublicIpAddress                                             # Gets a list of all public IP address
            if (!$ObjectList) {                                                             # If $ObjectList is $null
                Write-Host 'No public IP skus are present in this subscription'             # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break GetAzurePublicIP                                                      # Breaks :GetAzurePublicIP
            }                                                                               # End if (!$ObjectList)
            [System.Collections.ArrayList]$ObjectArray = @()                                # Creates array for list to be loaded into
            $ObjectNumber = 1                                                               # Creates #var used for list selection
            foreach ($_ in $ObjectList) {                                                   # For each item in $ObjectList
                if ($_.IpConfiguration.Id) {                                                # If current item .IpConfiguration.Id has a value
                    $AttachedNIC = ($_.IpConfiguration.Id).Split('/')[-3]                   # Gets the attached NIC name
                    $AttachedNICIPConfig = ($_.IpConfiguration.Id).Split('/')[-1]           # Gets the attached NIC IP config name
                }                                                                           # End if ($_.IpConfiguration.Id) 
                $ObjectInput = [PSCustomObject]@{                                           # Custom item to load into array
                    'Number'=$ObjectNumber;'Name'=$_.Name;'RG'=$_.ResourceGroupName;`
                    'Sku'=$_.Sku.Name;'Allocation'=$_.PublicIpAllocationMethod;`
                    'Address'=$_.IPAddress;'NIC'=$AttachedNIC;`
                    'IPconfig'=$AttachedNICIPConfig                                         # Creates the item list to load int array
                }                                                                           # End $ObjectInput = [PSCustomObject]@
                $ObjectArray.Add($ObjectInput) | Out-Null                                   # Loads item into array, out-null removes write to screen
                $ObjectNumber = $ObjectNumber + 1                                           # Increments $var up by 1
                $AttachedNIC = $null                                                        # Clears $var
                $AttachedNICIPConfig = $null                                                # Clears $var
            }                                                                               # End foreach ($_ in $ObjectList)
            :SelectAzurePublicIP while ($true) {                                            # Inner loop for selecting the public IP
                Write-Host ''                                                               # Write message to screen
                Write-Host '[0]          Exit'                                              # Write message to screen
                Write-Host ''                                                               # Write message to screen
                foreach ($_ in $ObjectArray) {                                              # For each item in $ObjectArray
                    $Number = $_.Number                                                     # Creats $Number (Used for formating)
                    if ($Number -le 9) {                                                    # If $Number is 9 or less
                        Write-Host "[$Number]         "$_.Name                              # Write message to screen
                    }                                                                       # End if ($Number -le 9)
                    else {                                                                  # If $Number is greater than 9
                        Write-Host "[$Number]        "$_.Name                               # Write message to screen    
                    }                                                                       # End else if ($Number -le 9)
                    Write-Host 'RG Name:    '$_.RG                                          # Write message to screen
                    Write-Host 'Allocation: '$_.Allocation                                  # Write message to screen
                    Write-Host 'IP Address: '$_.address                                     # Write message to screen
                    Write-Host 'SKU Type:   '$_.Sku                                         # Write message to screen
                    if ($_.Nic) {                                                           # If current item .Nic has a value
                        Write-Host 'NIC Name:   '$_.Nic                                     # Write message to screen
                        Write-Host 'NIC Config: '$_.IPConfig                                # Write message to screen
                    }                                                                       # End if ($_.Nic)                                 
                    Write-Host ''                                                           # Write message to screen
                }                                                                           # End foreach ($_ in $ObjectArray) 
                if ($CallingFunction) {                                                     # If $Calling function has a value
                    Write-Host 'You are selecting the Public IP Sku for:'$CallingFunction   # Write message to screen
                }                                                                           # End if ($CallingFunction)
                $OpSelect = Read-Host 'Option [#]'                                          # Operator input for the public IP selection
                Clear-Host                                                                  # Clears screen
                if ($OpSelect -eq '0') {                                                    # If $var equals 0
                    Break GetAzurePublicIP                                                  # Breaks :GetAzurePublicIP
                }                                                                           # End if ($OpSelect -eq '0')
                elseif ($OpSelect -in $ObjectArray.Number) {                                # If $OpSelect in $ObjectArray.Number list
                    $OpSelect = $ObjectArray | Where-Object `
                        {$_.Number -eq $OpSelect}                                           # $OpSelect is equal to $ObjectArray where $ObjectArray.Number equals $OpSelect
                    $PublicIPObject = Get-AzPublicIpAddress -Name $OpSelect.Name `
                        -ResourceGroupName $OpSelect.RG                                     # Pulls $PublicIPObject
                    Return $PublicIPObject                                                  # Returns to calling function with $PublicIPObject
                }                                                                           # End elseif ($OpSelect -in $ObjectArray.Number)
                else {                                                                      # All other values
                    Write-Host 'That was not a valid input'                                 # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Clear-Host                                                              # Clears screen
                }                                                                           # End else (if ($OpSelect -eq '0'))
            }                                                                               # End :SelectAzurePublicIP while ($true)
        }                                                                                   # End :GetAzurePublicIP while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End begin
}                                                                                           # End function GetAzPublicIpAddress
function GetAzResourceGroup {                                                               # Function to get a resource group
    Begin {                                                                                 # Begin function
        $ErrorActionPreference = 'silentlyContinue'                                         # Disables error reporting
        :GetAzureResourceGroup while ($true) {                                              # Outer loop for managing function
            $ObjectList = Get-AzResourceGroup                                               # Gets all resource groups and assigns to $ObjectList
            $ObjectNumber = 1                                                               # Sets $ObjectNumber to 1
            [System.Collections.ArrayList]$ObjectArray = @()                                # Creates the RG list array
            foreach ($_ in $ObjectList) {                                                   # For each $_ in $ObjectListList
                $ObjectInput = [PSCustomObject]@{'Name' = $_.ResourceGroupName; `
                    'Number' = $ObjectNumber; 'Location' = $_.Location}                     # Creates the item to loaded into array
                $ObjectArray.Add($ObjectInput) | Out-Null                                   # Loads item into array, out-null removes write to screen
                $ObjectNumber = $ObjectNumber + 1                                           # Increments $ObjectNumber by 1
            }                                                                               # End foreach ($_ in $ObjectList)
            :SelectAzureObjectList while ($true) {                                          # Inner loop to select the resource group
                Write-Host '[0]  Exit'                                                      # Write message to screen
                foreach ($_ in $ObjectArray) {                                              # For each $_ in $ObjectArray
                    $Number = $_.Number                                                     # Sets $Number to current item .number
                    if ($_.Number -le 9) {                                                  # If current item .number is 9 or less
                        Write-Host "[$Number] "$_.Name '|' $_.Location                      # Write message to screen
                    }                                                                       # End if ($_.Number -le 9) 
                    else {                                                                  # If current item .number is greater then 9
                        Write-Host "[$Number]"$_.Name '|' $_.Location                       # Write message to screen
                    }                                                                       # End else (if ($_.Number -le 9) )
                }                                                                           # End foreach ($_ in $ObjectArray)
                if ($CallingFunction) {                                                     # If $CallingFunction exists
                    Write-Host 'You are selecting the resource group for:'$CallingFunction  # Write message to screen
                }                                                                           # End if ($CallingFunction)
                $OpSelect = Read-Host 'Option [#]'                                          # Operator input for the RG selection
                if ($OpSelect -eq '0') {                                                    # If $OpSelect equals 0
                    Break GetAzureResourceGroup                                             # Breaks :GetAzureResourceGroup
                }                                                                           # End if ($OpSelect -eq '0')
                elseif ($OpSelect -in $ObjectArray.Number) {                                # If $OpSelect in $ObjectArray.Number
                    $OpSelect = $ObjectArray | Where-Object {$_.Number -eq $OpSelect}       # $OpSelect is equal to $ObjectArray where $ObjectArray.Number is equal to $OpSelect                                  
                    $RGObject = Get-AzResourceGroup | Where-Object `
                        {$_.ResourceGroupName -eq $OpSelect.Name}                           # Pulls the full resource group object
                    Clear-Host                                                              # Clears screen
                    Return $RGObject                                                        # Returns to calling function with $RGObject
                }                                                                           # End elseif ($OpSelect -in $ListArray.Number)
                else {                                                                      # If $RGObject does not have a value
                    Write-Host 'That was not a valid input'                                 # Write message to screen
                }                                                                           # End else (if ($RGObject))
            }                                                                               # End :SelectAzureObjectList while ($true)
        }                                                                                   # End :GetAzureResourceGroup while ($true)
        Clear-Host                                                                          # Clears screen
        Return                                                                              # Returns to calling function with $null
    }                                                                                       # End begin statement
}                                                                                           # End function GetAzResourceGroup