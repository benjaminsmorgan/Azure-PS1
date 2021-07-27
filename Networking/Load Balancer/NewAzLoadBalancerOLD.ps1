# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Microsoft docs links
    New-AzLoadBalancer:                         https://docs.microsoft.com/en-us/powershell/module/az.network/new-azloadbalancer?view=azps-5.5.0  
    New-AzLoadBalancerFrontendIpConfig:         https://docs.microsoft.com/en-us/powershell/module/az.network/new-azloadbalancerfrontendipconfig?view=azps-5.5.0
    Get-AzPublicIpAddress:                      https://docs.microsoft.com/en-us/powershell/module/az.network/get-azpublicipaddress?view=azps-5.5.0
    New-AzLoadBalancerBackendAddressPoolConfig: https://docs.microsoft.com/en-us/powershell/module/az.network/new-azloadbalancerbackendaddresspoolconfig?view=azps-5.5.0
    New-AzLoadBalancerProbeConfig:              https://docs.microsoft.com/en-us/powershell/module/az.network/new-azloadbalancerbackendaddresspoolconfig?view=azps-5.5.0
    New-AzLoadBalancerRuleConfig:               https://docs.microsoft.com/en-us/powershell/module/az.network/new-azloadbalancerruleconfig?view=azps-5.5.0
    Get-AzVirtualNetworkSubnetConfig:           https://docs.microsoft.com/en-us/powershell/module/az.network/get-azvirtualnetworksubnetconfig?view=azps-5.4.0
    Get-AzVirtualNetwork:                       https://docs.microsoft.com/en-us/powershell/module/az.network/get-azvirtualnetwork?view=azps-5.4.0
    Get-AzResourceGroup:                        https://docs.microsoft.com/en-us/powershell/module/az.resources/get-azresourcegroup?view=azps-5.1.0   
} #>
<# Required Functions Links: {
    NewAzLBFEPriDynamicIpCon:   https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/Load%20Balancer/NewAzLBFEPriDynamicIpCon.ps1
    NewAzLBFEPriStaticIpCon:    https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/Load%20Balancer/NewAzLBFEPriStaticIpCon.ps1
    NewAzLBFEPubIPCon:          https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/Load%20Balancer/NewAzLBFEPubIPCon.ps1
    GetAzVNetSubnetConfig:      https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/SubNet/GetAzVNetSubnetConfig.ps1    
    GetAzPublicIpAddress:       https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/Public%20IP/GetAzPublicIpAddress.ps1
    NewAzLBBackendIpConfig:     https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/Load%20Balancer/NewAzLBBackendIpConfig.ps1
    NewAzLBProbeConfig:         https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/Load%20Balancer/NewAzLBProbeConfig.ps1
    NewAzLBIBNatPoolConfig:     https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/Load%20Balancer/NewAzLBIBNatPoolConfig.ps1
    NewAzLBRuleConfig:          https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/Load%20Balancer/NewAzLBRuleConfig.ps1
    GetAzResourceGroup:         https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/GetAzResourceGroup.ps1
} #>
<# Functions Description: {
    NewAzLoadBalancer:          Creates a new load balancer
    NewAzLBFEPriDynamicIpCon:   Creates a load balancer front end private dynamic IP configuration
    NewAzLBFEPriStaticIpCon:    Creates a load balancer front end private static IP configuration
    NewAzLBFEPubIPCon:          Creates a load balancer front end public IP configuration
    GetAzVNetSubnetConfig:      Gets an azure virtual network subnet
    GetAzPublicIpAddress:       Gets an existing IP address
    NewAzLBBackendIpConfig:     Creates a load balancer back end configuration
    NewAzLBProbeConfig:         Creates a load balancer probe configuration
    NewAzLBIBNatPoolConfig:     Creates inbound pool configuration for load balancer
    NewAzLBRuleConfig:          Creates a new load balancer rule
    GetAzResourceGroup:         Gets an existing resource group
} #>
<# Variables: {      
    :NewAzureLoadBalancer       Outer loop to manage function   
    :SetAzureLBName             Inner loop for setting the load balancer name
    :SetAzureLoadBalancerSku    Inner loop for setting the load balancer sku
    :NewAzureLBFrontEnd         Inner loop for setting the load balancer front end IP config
    $CallingFunction:           Name of this function or the one that called it
    $ValidArray:                Array of valid non first/last characters to load balancer config
    $Valid1stChar:              Array of valid first characters to load balancer config
    $ValidLastChar:             Array of valid last characters to load balancer config
    $LBNameArray:               $LBNameObject converted to array
    $LBNameObject:              Load balancer name object
    $RGObject:                  Resource group object
    $OpSelect:                  Opertor input to select options
    $LBSkuObject:               Load balancer sku object
    $FrontEndIPConfigObject:    Front end configuration object
    $BackEndIPConfigObject:     Back end configuration object
    $HealthProbeObject:         Health probe configuration object
    $InboundNatPoolObject:      Inbound nat pool configuration object
    $LoadBalanceRule:           Load balancer rule object
    $OpConfirm:                 Operator confirmation of $LBNameObject
    $LoadBalancerObject:        The load balancer object
    GetAzResourceGroup{}        Gets $RGObject
    NewAzLBFEPriDynamicIpCon{}  Gets $FrontEndIPConfigObject
        GetAzVNetSubnetConfig{}     Gets $SubnetObject
    NewAzLBFEPriStaticIpCon{}   Gets $FrontEndIPConfigObject
        GetAzVNetSubnetConfig{}     Gets $SubnetObject
    NewAzLBFEPubIPCon{}         Gets $FrontEndIPConfigObject
        GetAzPublicIpAddress{}      Gets $PublicIPObject
    NewAzLBBackendIpConfig{}    Gets $BackEndIPConfigObject
    NewAzLBProbeConfig{}        Gets $HealthProbeObject
    NewAzLBIBNatPoolConfig{}    Gets $InboundNatPoolObject
    NewAzLBRuleConfig{}         Gets $LoadBalanceRule 
} #>
<# Process Flow {
    function
        Call NewAzLoadBalancer > Get $null
            Call GetAzResourceGroup > Get $RGObject
            End GetAzResourceGroup
                Return NewAzLoadBalancer > Send $RGObject          
            Call NewAzLBFEPriDynamicIpCon > Get $FrontEndIPConfigObject
                Call GetAzVNetSubnetConfig > Get $SubnetObject, $VNetObject
                End GetAzVNetSubnetConfig 
                    Return NewAzLBFEPriDynamicIpCon > Send $SubnetObject, $VNetObject
            End NewAzLBFEPriDynamicIpCon
                Return NewAzLoadBalancer > Send $FrontEndIPConfigObject
            Call NewAzLBFEPriStaticIpCon > Get $FrontEndIPConfigObject
                Call GetAzVNetSubnetConfig > Get $SubnetObject, $VNetObject
                End GetAzVNetSubnetConfig 
                    Return NewAzLBFEPriStaticIpCon > Send $SubnetObject, $VNetObject
            End NewAzLBFEPriStaticIpCon
                Return NewAzLoadBalancer > Send $FrontEndIPConfigObject
            Call NewAzLBFEPubIPCon > Get $FrontEndIPConfigObject    
                Call GetAzPublicIpAddress > Get $PublicIPObject
                End GetAzPublicIpAddress
                    Return NewAzLBFEPubIPCon > Send $PublicIPObject        
            End NewAzLBFEPubIPCon
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
            Return function > Send $null
}#>
function NewAzLoadBalancer {                                                                # Function to create a new load balancer
    Begin {                                                                                 # Begin function
        if (!$CallingFunction) {                                                            # If $CallingFunction is $null
            $CallingFunction = 'NewAzLoadBalancer'                                          # Creates $CallingFunction
        }                                                                                   # End if (!$CallingFunction)
        :NewAzureLoadBalancer while ($true) {                                               # Outer loop for managing function
            :SetAzureLoadBalancerSku while ($true) {                                        # Inner loop to set the load balancer sku
                Write-Host 'Select the load balancer sku'                                   # Write message to screen
                Write-Host '------------------------------------------'                     # Write message to screen
                Write-Host ' Sku                | Basic | Standard   |'                     # Write message to screen
                Write-Host '------------------------------------------'                     # Write message to screen
                Write-Host 'Back End pool size  | < 301 | < 1001     |'                     # Write message to screen
                Write-Host '------------------------------------------'                     # Write message to screen
                Write-Host 'Health Probes       | HTTP  | HTTP/HTTPS |'                     # Write message to screen
                Write-Host '------------------------------------------'                     # Write message to screen
                Write-Host 'Secure by default   | No    | Yes        |'                     # Write message to screen
                Write-Host '------------------------------------------'                     # Write message to screen
                Write-Host 'Availability Zones  | N/A   | Yes        |'                     # Write message to screen
                Write-Host '------------------------------------------'                     # Write message to screen
                Write-Host 'SLA                 | N/A   | 99.99%     |'                     # Write message to screen
                Write-Host '------------------------------------------'                     # Write message to screen
                Write-Host '[0] Exit'                                                       # Write message to screen
                Write-Host '[1] Basic'                                                      # Write message to screen
                Write-Host '[2] Standard'                                                   # Write message to screen
                $OpSelect = Read-Host 'Option [#]'                                          # Operator input for the allocation method
                Clear-Host                                                                  # Clears screen
                if ($OpSelect -eq '0') {                                                    # If $OpSelect equals '0'
                    Break NewAzureLoadBalancer                                              # Breaks :NewAzureLoadBalancer
                }                                                                           # End if ($OpSelect -eq '0')
                elseif ($OpSelect -eq '1') {                                                # Elseif $OpSelect equals 1
                    $LBSkuObject = 'Basic'                                                  # Creates $LBSkuObject
                    Break SetAzureLoadBalancerSku                                           # Breaks :SetAzureLoadBalancerSku    
                }                                                                           # End elseif ($OpSelect -eq '1')
                elseif ($OpSelect -eq '2') {                                                # Elseif $OpSelect equals 2
                    $LBSkuObject = 'Standard'                                               # Creates $LBSkuObject
                    Break SetAzureLoadBalancerSku                                           # Breaks :SetAzureLoadBalancerSku
                }                                                                           # End elseif ($OpSelect -eq '2')
                else {                                                                      # All other inputs for $OpSelect
                    Write-Host 'That was not a valid input'                                 # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Clear-Host                                                              # Clears screen
                }                                                                           # End else (($OpSelect -eq '0'))
            }                                                                               # End :SetAzureLoadBalancerSku while ($true)
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
            :NewAzureLBFrontEnd while ($true) {                                             # Inner loop for setting the type of front end config
                Write-Host 'Select type of front end config'                                # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Write-Host '[0] Exit'                                                       # Write message to screen
                Write-Host '[1] Private Dynamic'                                            # Write message to screen
                Write-Host '[2] Private Static'                                             # Write message to screen
                Write-Host '[3] Public'                                                     # Write message to screen
                Write-Host ''                                                               # Write message to screen
                $OpSelect = Read-Host 'Option [#]'                                          # Operator input to select the IP type for front end config
                Clear-Host                                                                  # Clears screen
                if ($OpSelect -eq '0') {                                                    # If $OpSelect equals '0'
                    Break NewAzureLoadBalancer                                              # Breaks :NewAzureLoadBalancer  
                }                                                                           # End if ($OpSelect -eq '0')
                elseif ($OpSelect -eq '1') {                                                # Else if $OpSelect equals '1'
                    $FrontEndIPConfigObject = NewAzLBFEPriDynamicIpCon ($CallingFunction)   # Calls function and assigns output to $var
                    if (!$FrontEndIPConfigObject) {                                         # If $FrontEndIPConfigObject is $null
                        Break NewAzureLoadBalancer                                          # Breaks :NewAzureLoadBalancer
                    }                                                                       # End if (!$FrontEndIPConfigObject)
                }                                                                           # End elseif ($OpSelect -eq '1')
                elseif ($OpSelect -eq '2') {                                                # Else if $OpSelect equals '2'
                    $FrontEndIPConfigObject = NewAzLBFEPriStaticIpCon ($CallingFunction)    # Calls function and assigns output to $var
                    if (!$FrontEndIPConfigObject) {                                         # If $FrontEndIPConfigObject is $null
                        Break NewAzureLoadBalancer                                          # Breaks :NewAzureLoadBalancer
                    }                                                                       # End if (!$FrontEndIPConfigObject)
                }                                                                           # End elseif ($OpSelect -eq '2')
                elseif ($OpSelect -eq '3') {                                                # Else if $OpSelect equals '3'
                    $FrontEndIPConfigObject = NewAzLBFEPubIPCon `
                        ($CallingFunction, $LBSkuObject)                                    # Calls function and assigns output to $var
                    if (!$FrontEndIPConfigObject) {                                         # If $FrontEndIPConfigObject is $null
                        Break NewAzureLoadBalancer                                          # Breaks :NewAzureLoadBalancer
                    }                                                                       # End if (!$FrontEndIPConfigObject)
                }                                                                           # End elseif ($OpSelect -eq '3')
                else {                                                                      # All other inputs for $OpSelect
                    Write-Host 'That was not a valid input'                                 # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Clear-Host                                                              # Clears screen
                }                                                                           # End else (if ($OpSelect -eq '0'))
                if ($FrontEndIPConfigObject) {                                              # If $FrontEndIPConfigObject has a value
                    Break NewAzureLBFrontEnd                                                # Breaks :NewAzureLBFrontEnd
                }                                                                           # End if ($FrontEndIPConfigObject)
            }                                                                               # End :NewAzureLBFrontEnd while ($true)
            :SetRuleType while ($true) {                                                    # Inner loop for setting the rule type
                Write-Host 'Load balancer rule type'                                        # Write message to screen
                Write-Host '[0] Exit'                                                       # Write message to screen
                Write-Host '[1] Generic rule'                                               # Write message to screen
                Write-Host '[2] Nat forwarding rule'                                        # Write message to screen
                Write-Host ''                                                               # Write message to screen
                $OpSelect = Read-Host 'Option [#]'                                          # Operator input for selecting the rule type
                Clear-Host                                                                  # Clears screen
                if ($OpSelect -eq '0') {                                                    # If $OpSelect equals '0'
                    Break NewAzureLoadBalancer                                              # Breaks :NewAzureLoadBalancer
                }                                                                           # End if ($OpSelect -eq '0')
                elseif ($OpSelect -eq '1') {                                                # Else if $OpSelect equals '1'
                    $BackEndIPConfigObject = NewAzLBBackendIpConfig                         # Calls function and assigns output to $var
                    if (!$BackEndIPConfigObject) {                                          # If $BackEndIPConfigObject is $null
                        Break NewAzureLoadBalancer                                          # Breaks :NewAzureLoadBalancer
                    }                                                                       # End if (!$BackEndIPConfigObject)
                    $HealthProbeObject = NewAzLBProbeConfig ($LBSkuObject)                  # Calls function and assigns output to $var
                    if (!$HealthProbeObject) {                                              # If $HealthProbeObject is $null
                        Break NewAzureLoadBalancer                                          # Breaks :NewAzureLoadBalancer
                    }                                                                       # End if (!$HealthProbeObject)
                    $LoadBalanceRule = NewAzLBRuleConfig ($FrontEndIPConfigObject, `
                        $BackEndIPConfigObject, $HealthProbeObject, $CallingFunction)       # Calls function and assigns output to $var
                    if (!$LoadBalanceRule) {                                                # If $LoadBalanceRule is $null
                        Break NewAzureLoadBalancer                                          # Breaks :NewAzureLoadBalancer
                    }                                                                       # End if (!$LoadBalanceRule)
                    Try{                                                                    # Try the following
                        Write-Host 'Creating the load balancer'                             # Write message to screen
                        New-AzLoadBalancer -Name $LBNameObject -ResourceGroupName `
                            $RGObject.ResourceGroupName -Location $RGObject.Location `
                            -FrontendIpConfiguration $FrontEndIPConfigObject `
                            -BackendAddressPool $BackEndIPConfigObject -Probe `
                            $HealthProbeObject -LoadBalancingRule $LBRule -Sku `
                            $LBSkuObject -ErrorAction 'Stop' | Out-Null                     # Creates the load balancer
                    }                                                                       # End Try
                    catch {                                                                 # If Try fails
                        Clear-Host                                                          # Clears screen
                        Write-Host 'An error has occured'                                   # Write message to screen
                        Write-Host ''                                                       # Write message to screen
                        Pause                                                               # Pauses all actions for operator input
                        Break NewAzureLoadBalancer                                          # Breaks :NewAzureLoadBalancer
                    }                                                                       # End catch
                    Clear-Host                                                              # Clears screen
                    Write-Host 'The load balancer has been made'                            # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Break NewAzureLoadBalancer                                              # Breaks :NewAzureLoadBalancer
                }                                                                           # End elseif ($OpSelect -eq '1')
                elseif ($OpSelect -eq '2') {                                                # Else if $OpSelect equals '2'
                    $HealthProbeObject = NewAzLBProbeConfig ($LBSkuObject)                  # Calls function and assigns output to $var
                    if (!$HealthProbeObject) {                                              # If $HealthProbeObject is $null
                        Break NewAzureLoadBalancer                                          # Breaks :NewAzureLoadBalancer
                    }                                                                       # End if (!$HealthProbeObject)    
                    $InboundNatPoolObject = NewAzLBIBNatPoolConfig `
                        ($FrontEndIPConfigObject, $CallingFunction)                         # Calls function and assigns output to $var
                    if (!$InboundNatPoolObject) {                                           # If $InboundNatPoolObject is $null
                        Break NewAzureLoadBalancer                                          # Breaks :NewAzureLoadBalancer
                    }                                                                       # End if (!$InboundNatPoolObject)
                    $InboundNatRuleObject = NewAzLBRuleConfig ($FrontEndIPConfigObject, `
                    $InboundNatPoolObject, $HealthProbeObject, $CallingFunction)            # Calls function and assigns output to $var
                    Try{                                                                    # Try the following
                        Write-Host 'Creating the load balancer'                             # Write message to screen
                        New-AzLoadBalancer -Name $LBNameObject -ResourceGroupName `
                            $RGObject.ResourceGroupName -Location $RGObject.Location `
                            -FrontendIpConfiguration $FrontEndIPConfigObject `
                            -BackendAddressPool $BackEndIPConfigObject -Probe `
                            $HealthProbeObject -InboundNatPool $InboundNatPoolObject `
                            -InboundNatRule $InboundNatRuleObject -Sku $LBSkuObject `
                            -ErrorAction 'Stop' | Out-Null                                  # Creates the load balancer
                    }                                                                       # End Try
                    catch {                                                                 # If Try fails
                        Clear-Host                                                          # Clears screen
                        Write-Host 'An error has occured'                                   # Write message to screen
                        Write-Host ''                                                       # Write message to screen
                        Pause                                                               # Pauses all actions for operator input
                        Break NewAzureLoadBalancer                                          # Breaks :NewAzureLoadBalancer
                    }                                                                       # End catch
                    Clear-Host                                                              # Clears screen
                    Write-Host 'The load balancer has been made'                            # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Break NewAzureLoadBalancer                                              # Breaks :NewAzureLoadBalancer
                }                                                                           # End elseif ($OpSelect -eq '2')
                else {                                                                      # All other inputs for $OpSelect
                    Write-Host 'That was not a valid input'                                 # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Clear-Host                                                              # Clears screen
                }                                                                           # End else (if ($OpSelect -eq '0'))
            }                                                                               # End :SetRuleType while ($true)
        }                                                                                   # End :NewAzureLoadBalancer while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function NewAzLoadBalancer