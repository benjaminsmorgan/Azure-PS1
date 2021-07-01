# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Mircosoft docs links
    New-AzLoadBalancer:                         https://docs.microsoft.com/en-us/powershell/module/az.network/new-azloadbalancer?view=azps-5.5.0  
    New-AzLoadBalancerFrontendIpConfig:         https://docs.microsoft.com/en-us/powershell/module/az.network/new-azloadbalancerfrontendipconfig?view=azps-5.5.0
    Get-AzVirtualNetworkSubnetConfig:           https://docs.microsoft.com/en-us/powershell/module/az.network/get-azvirtualnetworksubnetconfig?view=azps-5.4.0
    Get-AzVirtualNetwork:                       https://docs.microsoft.com/en-us/powershell/module/az.network/get-azvirtualnetwork?view=azps-5.4.0
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
    NewAzLBFEPriDynamicIpCon:   https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/Load%20Balancer/NewAzLBFEPriDynamicIpCon.ps1
    NewAzLBFEPriStaticIpCon:    https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/Load%20Balancer/NewAzLBFEPriStaticIpCon.ps1
    NewAzLBFEPubIPCon:          https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/Load%20Balancer/NewAzLBFEPubIPCon.ps1
    GetAzVNetSubnetConfig:      https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/SubNet/GetAzVNetSubnetConfig.ps1    
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
    NewAzLBFEPriDynamicIpCon:   Creates a load balancer front end private dynamic IP configuration
    NewAzLBFEPriStaticIpCon:    Creates a load balancer front end private static IP configuration
    NewAzLBFEPubIPCon:          Creates a load balancer front end public IP configuration
    GetAzVNetSubnetConfig:      Gets an azure virtual network subnet
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
            Write-Host '[1] New Load Balancer'                                              # Write message to screen
            Write-Host '[2] List Load Balancers'                                            # Write message to screen
            Write-Host '[3] Remove Load Balancer'                                           # Write message to screen
            Write-Host '[4] Manage Load Balancer Configs'                                   # Write message to screen
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
            elseif ($OpSelect -eq '3') {                                                    # Else if $OpSelect equals '4'
                Write-Host 'Manage Load Balancer Configs'                                   # Write message to screen
                ManageAzLBConfig                                                            # Calls function
            }                                                                               # elseif ($OpSelect -eq '4')    
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
            Try{                                                                            # Try the following
                Write-Host 'Creating the load balancer'                                     # Write message to screen
                New-AzLoadBalancer -Name $LBNameObject -ResourceGroupName `
                    $RGObject.ResourceGroupName -Location $RGObject.Location `
                    -ErrorAction 'Stop' | Out-Null                                          # Creates the load balancer
            }                                                                               # End Try
            catch {                                                                         # If Try fails
                Clear-Host                                                                  # Clears screen
                Write-Host 'An error has occured'                                           # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break NewAzureLoadBalancer                                                  # Breaks :NewAzureLoadBalancer
            }                                                                               # End catch
            Clear-Host                                                                      # Clears screen
            Write-Host 'The load balancer has been made'                                    # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            Pause                                                                           # Pauses all actions for operator input
            Break NewAzureLoadBalancer                                                      # Breaks :NewAzureLoadBalancer
        }                                                                                   # End :NewAzureLoadBalancer while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function NewAzLoadBalancer
function NewAzLBFEPriDynamicIpCon {                                                         # Function to set up a private dynamic front end IP for a load balancer
    Begin {                                                                                 # Begin function
        :NewAzureLBFEIpConfig while ($true) {                                               # Outer loop for managing the function
            if ($LoadBalancerObject) {                                                      # If $LoadBalancerObject has a value
                $CurrentConfig = Get-AzLoadBalancerFrontendIpConfig `
                -LoadBalancer $LoadBalancerObject                                           # Gets the load balancer front end configurations
                if ($CurrentConfig.PrivateIpAllocationMethod) {                             # If $CurrentConfig.PrivateIpAllocationMethod has a value
                    Write-Host 'A subnet is currently in use by this load balancer'         # Write message to screen
                    Write-Host 'Getting subnet information'                                 # Write message to screen
                    $SubnetID = $CurrentConfig.Subnet.ID                                    # Isolates the subnet ID
                    $SubnetName = $SubnetID.Split('/')[-1]                                  # Isloates the subnet name
                    $VnetName = $SubnetID.Split('/')[8]                                     # Isloates the vnet name 
                    $VnetObject = Get-AzVirtualNetwork -Name $VnetName                      # Collects vnet object
                    $SubnetObject =  Get-AzVirtualNetworkSubnetConfig -VirtualNetwork `
                        $VnetObject -Name $SubnetName                                       # Collects subnet object
                    Clear-Host                                                              # Clears screen
                }                                                                           # End if ($CurrentConfig.PrivateIpAllocationMethod)
            }                                                                               # End if ($LoadBalancerObject)
            if (!$SubnetObject) {                                                           # If $SubnetObject is $null                                              
                $SubnetObject, $VNetObject = GetAzVNetSubnetConfig ($CallingFunction)       # Calls function and assigns output to $var
                if (!$SubnetObject) {                                                       # If $var is $null
                    Break NewAzureLBFEIpConfig                                              # Breaks :NewAzureLPFEIpConfig
                }                                                                           # End if (!$SubnetObject) | Inner
            }                                                                               # End if (!$SubnetObject) | Outer
            $SubnetID = $SubnetObject.ID                                                    # Isloates the subnet id
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
                    $FrontEndNameObject -SubnetId $SubnetID -ErrorAction 'Stop'             # Creates the load balancer front end config
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
}                                                                                           # End function NewAzLBFEPriDynamicIpCon
function NewAzLBFEPriStaticIpCon {                                                          # Function to set up a private static front end IP for a load balancer
    Begin {                                                                                 # Begin function
        :NewAzureLBFEIpConfig while ($true) {                                               # Outer loop for managing the function
            if ($LoadBalancerObject) {                                                      # If $LoadBalancerObject has a value
                $CurrentConfig = Get-AzLoadBalancerFrontendIpConfig `
                    -LoadBalancer $LoadBalancerObject                                       # Gets the load balancer front end configurations
                if ($CurrentConfig.PrivateIpAllocationMethod) {                             # If $CurrentConfig.PrivateIpAllocationMethod has a value
                    Write-Host 'A subnet is currently in use by this load balancer'         # Write message to screen
                    Write-Host 'Getting subnet information'                                 # Write message to screen
                    $SubnetID = $CurrentConfig.Subnet.ID                                    # Isolates the subnet ID
                    $SubnetName = $SubnetID.Split('/')[-1]                                  # Isloates the subnet name
                    $VnetName = $SubnetID.Split('/')[8]                                     # Isloates the vnet name 
                    $VnetObject = Get-AzVirtualNetwork -Name $VnetName                      # Collects vnet object
                    $SubnetObject =  Get-AzVirtualNetworkSubnetConfig -VirtualNetwork `
                        $VnetObject -Name $SubnetName                                       # Collects subnet object
                    Clear-Host                                                              # Clears screen
                }                                                                           # End if ($CurrentConfig.PrivateIpAllocationMethod)
            }                                                                               # End if ($LoadBalancerObject)
            if (!$SubnetObject) {                                                           # If $SubnetObject is $null                                              
                $SubnetObject, $VNetObject = GetAzVNetSubnetConfig ($CallingFunction)       # Calls function and assigns output to $var
                if (!$SubnetObject) {                                                       # If $var is $null
                    Break NewAzureLBFEIpConfig                                              # Breaks :NewAzureLPFEIpConfig
                }                                                                           # End if (!$SubnetObject) | Inner
            }                                                                               # End if (!$SubnetObject) | Outer
            $SubnetID = $SubnetObject.ID                                                    # Isloates the subnet id
            Write-Host 'Getting list of IPs already in use'                                 # Write message to screen
            $NicList = (Get-AzNetworkInterface | Where-Object `
                {$_.IpConfigurations.Subnet.ID -eq $SubnetID}).IpConfigurations             # Gets a list of all nic ip configurations on $SubnetID
            $LBList = (get-azloadbalancer | Where-Object `
                {$_.FrontendIpConfigurations.subnet.ID -eq $SubnetID})                      # Gets a list of all load balancers configurations on $SubnetID
            $LBList = $LBList.FrontendIpConfigurations
            Clear-Host                                                                      # Clears screen
            :SetAzureLBIP while ($true) {                                                   # Inner loop to set the IP address
                Write-Host 'Subnet Prefix:'$SubnetObject.AddressPrefix                      # Write message to screen
                Write-Host 'The following IPs are in use:'                                  # Write message to screen
                foreach ($_ in $NicList) {                                                  # For each item in $NicList
                    Write-Host 'IP:'$_.PrivateIpAddress                                     # Write message to screen
                }                                                                           # End foreach ($_ in $NicList)
                foreach ($_ in $LBList) {                                                   # End foreach ($_ in $LBList)
                    Write-Host 'IP:'$_.PrivateIpAddress                                     # Write message to screen
                }                                                                           # End foreach ($_ in $LBList)
                Write-Host ''                                                               # Write message to screen
                Write-Host 'Other unlisted IP addresses may be reserved'                    # Write message to screen
                Write-Host 'Unlisted and unavailable addresses will be'                     # Write message to screen
                Write-Host 'checked after submitting the requested IP'                      # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Write-Host 'Enter the static IP address:'                                   # Write message to screen
                $IPInput = Read-Host 'IP'                                                   # Operator input for the new IP address
                Clear-Host                                                                  # Clears screen
                Try {                                                                       # Try the following
                    $IPAvailable = Test-AzPrivateIPAddressAvailability -VirtualNetwork `
                        $VnetObject -IPAddress $IPInput -ErrorAction 'Stop'                 # Checks IP availability
                }                                                                           # End try
                Catch {                                                                     # If Try fails
                    $IPInput = $null                                                        # Clears $IPInput
                    Write-Host 'That does not appear to be a valid IP'                      # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Clear-Host                                                              # Clears screen
                }                                                                           # End catch
                $IPAvailable = $IPAvailable.Available                                       # Isolates Available
                if ($IPInput -and $IPAvailable -eq $false) {                                # If $IPInput has a value and $IPAvailable is equal to $false
                    Write-Host 'That IP address is already in use'                          # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Clear-Host                                                              # Clears screen
                }                                                                           # End if ($IPInput -and $IPAvailable -eq $false)
                elseif($IPInput) {                                                          # Else if $IPInput has a value
                    Write-Host 'Use:'$IPInput ' for the load balancer front end'            # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    $OpConfirm = Read-Host '[Y] Yes [N] No [E] Exit'                        # Operator confirmation of the IP address
                    Clear-Host                                                              # Clears screen
                    if ($OpConfirm -eq 'e') {                                               # If $OpConfirm equals 'e'
                        Break NewAzureLBFEIpConfig                                          # Breaks :NewAzureLBFEIpConfig
                    }                                                                       # End if ($OpConfirm -eq 'e')
                    elseif ($OpConfirm -eq 'y') {                                           # Else if $OpConfirm -eq 'y'
                        Break SetAzureLBIP                                                  # Breaks :SetAzureLBIP
                    }                                                                       # End elseif ($OpConfirm -eq 'y')
                }                                                                           # End else (If $IPInput is not like '*.*.*.*'))
            }                                                                               # End :SetAzureLBIP while ($true)
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
                    $FrontEndNameObject -SubnetId $SubnetID -PrivateIpAddress $IPInput `
                    -ErrorAction 'Stop'                                                     # Creates the load balancer front end config
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
}                                                                                           # End function NewAzLBFEPriStaticIpCon
function NewAzLBFEPubIPCon {                                                                # Function to set up the front end public IP for a load balancer
    Begin {                                                                                 # Begin function
        :NewAzureLBFEIpConfig while ($true) {                                               # Outer loop for managing the function
            :SetAzurePublicIP while ($true) {                                               # Inner loop for selecting the public IP sku
                $PublicIPObject = GetAzPublicIpAddress ($CallingFunction)                   # Calls function and assigns output to $var
                if (!$PublicIPObject) {                                                     # If $var is $null
                    Break NewAzureLBFEIpConfig                                              # Breaks :NewAzureLPFEIpConfig
                }                                                                           # End if (!$PublicIPObject)
                if ($PublicIPObject.Sku.Name -ne $LBSkuObject) {                            # If $PublicIPObject.Sku.Name does not equal $LBSkuObject 
                    if ($LBSkuObject -eq 'Basic') {                                         # If $LBSkuObject equals 'Basic
                        Write-Host 'The load balancer being built'                          # Write message to screen
                        Write-Host 'is a basic sku and requires a'                          # Write message to screen
                        Write-Host 'basic public IP sku'                                    # Write message to screen
                    }                                                                       # End if ($LBSkuObject -eq 'Basic')
                    else {                                                                  # Else if $LBSkuObject equals 'standard'
                        Write-Host 'The load balancer being built'                          # Write message to screen
                        Write-Host 'is a standard sku and requires a'                       # Write message to screen
                        Write-Host 'standard public IP sku'                                 # Write message to screen 
                    }                                                                       # End else (if ($LBSkuObject -eq 'Basic'))
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
                }                                                                           # End if ($PublicIPObject.Sku.Name -ne $LBSkuObject)
                else {                                                                      # if $PublicIPObject.IpConfiguration.Id is $null
                    Break SetAzurePublicIP                                                  # Breaks :SetAzurePublicIP
                }                                                                           # End else (if ($PublicIPObject.Sku.Name -ne $LBSkuObject))
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
}                                                                                           # End function NewAzLBFEPubIPCon
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
            [System.Collections.ArrayList]$ProbeProtocol = @()                              # Creates array for list to be loaded into
            if ($LBSkuObject -eq 'Basic') {                                                 # If $LBSkuObject equals 'Basic'                                  
                $ProbeProtocolInput = [PSCustomObject]@{'Protocol' = 'http';`
                    'port' = '80'}                                                          # Creates the item to loaded into array
                $ProbeProtocol.Add($ProbeProtocolInput) | Out-Null                          # Loads item into array, out-null removes write to screen
            }                                                                               # End if ($LBSkuObject -eq 'Basic')
            else {                                                                          # Else if $LBSkuObject does not equal 'Basic'
                :SetAzureProbeProtocol while ($true) {                                      # Inner loop for setting the probe type
                    Write-Host 'Load balanacer health probe protocol'                       # Write message to screen
                    Write-Host '[0] Exit'                                                   # Write message to screen
                    Write-Host '[1] Http (80)'                                              # Write message to screen
                    Write-host '[2] Https(443)'                                             # Write message to screen
                    Write-Host ''                                                           # Writes message to screen
                    $OpSelect = Read-Host 'Option[#]'                                       # Operator input for the probe type object
                    Clear-Host                                                              # Clears screen
                    if ($OpSelect -eq '0') {                                                # If $OpSelect equals '0'
                        Break NewAzureLBProbeConfig                                         # Breaks :NewAzureLBProbeConfig 
                    }                                                                       # End if ($OpSelect -eq '0')
                    elseif ($OpSelect -eq '1') {                                            # Elseif $OpSelect equals '1'
                        $ProbeProtocolInput = [PSCustomObject]@{'Protocol' = 'http';`
                            'port' = '80'}                                                  # Creates the item to loaded into array
                        $ProbeProtocol.Add($ProbeProtocolInput) | Out-Null                  # Loads item into array, out-null removes write to screen         
                        Break SetAzureProbeProtocol                                         # Breaks :SetAzureProbeProtocol 
                    }                                                                       # End elseif ($OpSelect -eq '1')
                    elseif ($OpSelect -eq '2') {                                            # Elseif $OpSelect equals '2'
                        [System.Collections.ArrayList]$ProbeProtocol = @()                  # Creates array for list to be loaded into
                        $ProbeProtocolInput = [PSCustomObject]@{'Protocol' = 'https';`
                            'port' = '443'}                                                 # Creates the item to loaded into array
                        $ProbeProtocol.Add($ProbeProtocolInput) | Out-Null                  # Loads item into array, out-null removes write to screen         
                        Break SetAzureProbeProtocol                                         # Breaks :SetAzureProbeProtocol 
                    }                                                                       # End elseif ($OpSelect -eq '2')
                    else {                                                                  # All other inputs for $OpSelect
                        Write-Host 'That was not a valid input'                             # Write message to screen
                        Write-Host ''                                                       # Write message to screen
                        Pause                                                               # Pauses all actions for operator input
                        Clear-Host                                                          # Clears screen
                    }                                                                       # End else (If $OpSelect -eq '0')
                }                                                                           # End :SetAzureProbeProtocol while ($true)
            }                                                                               # End else (if ($LBSkuObject -eq 'Basic'))
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
                if ($_.BackendAddressPools.BackendIpConfigurations.id) {                    # If current item .BackendAddressPools.BackendIpConfigurations.id has a value
                    $VmssID = $_.BackendAddressPools.BackendIpConfigurations.id             # Isolates .BackendAddressPools.BackendIpConfigurations.id
                    $VmssRG = $VmssID.Split('/')[4]                                         # Isolates the Vmss resource group
                    $VmssName = $VmssID.Split('/')[8]                                       # Isolates the Vmss name
                }                                                                           # End if ($_.BackendAddressPools.BackendIpConfigurations.id)
                $ObjectInput = [PSCustomObject]@{                                           # Creates the item to loaded into array
                    'Name'= $_.Name;'RG'=$_.ResourceGroupName;'Loc'=$_.Location;`
                    'Sku'=$_.Sku.Name;'PubAllocation'=`
                    $PublicIPObject.PublicIpAllocationMethod;'PubAddress'=`
                    $PublicIPObject.IpAddress;'Pubname'=$PublicIPObject.Name;`
                    'VmssName'=$VmssName;'VmssRG'=$VmssRG                                   # Creates the item to loaded into array
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
                if ($_.VmssName) {                                                          # If $_.VmssName has a value
                    Write-Host 'Vmss name:     '$_.VmssName                                 # Write message to screen
                    Write-Host 'Vmss RG:       '$_.VmssRG                                   # Write message to screen
                }                                                                           # End if ($_.VmssName)
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
function RemoveAzLoadBalancer {                                                             # Function to remove a load balancer
    Begin {                                                                                 # Begin function
        if (!$CallingFunction) {                                                            # If $CallingFunction is $null
            $CallingFunction = 'RemoveAzLoadBalancer'                                       # Creates $CallingFunction
        }                                                                                   # End if (!$CallingFunction)
        :RemoveAzureLoadBalancer while ($true) {                                            # Outer loop for managing function
            $LoadBalancerObject = GetAzLoadBalancer ($CallingFunction)                      # Calls function and assigns output to $var
            if (!$LoadBalancerObject) {                                                     # If $LoadBalancerObject does not have a value
                Break RemoveAzureLoadBalancer                                               # Breaks :RemoveAzureLoadBalancer
            }                                                                               # End if (!$LoadBalancerObject)
            if ($LoadBalancerObject.BackendAddressPools.BackendIpConfigurations.id) {       # If current item .BackendAddressPools.BackendIpConfigurations.id has a value
                $VmssID = `
                    $LoadBalancerObject.BackendAddressPools.BackendIpConfigurations.id      # Isolates .BackendAddressPools.BackendIpConfigurations.id
                $VmssRG = $VmssID.Split('/')[4]                                             # Isolates the Vmss resource group
                $VmssName = $VmssID.Split('/')[8]                                           # Isolates the Vmss name
                Write-Host 'This load balancer is in use, disconnect'                       # Write message to screen
                Write-Host 'the following to remove the load balancer:'                     # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Write-Host 'Vmss name:'$VmssName                                            # Write message to screen
                Write-Host 'Vmss RG:  '$VmssRG                                              # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Write-Host 'No changes have been made'                                      # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break RemoveAzureLoadBalancer                                               # Breaks :RemoveAzureLoadBalancer    
            }                                                                               # End if ($_.BackendAddressPools.BackendIpConfigurations.id)
            Write-Host 'Remove the following:'                                              # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            Write-Host 'Load balancer: '$LoadBalancerObject.name                            # Write message to screen
            Write-Host 'Resource group:'$LoadBalancerObject.ResourceGroupName               # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            $OpConfirm = Read-Host '[Y] Yes [N] No'                                         # Operator confirmation to remove the load balancer
            Clear-Host                                                                      # Clears screen
            if ($OpConfirm -eq 'y') {                                                       # If $OpConfirm equals 'y'
                Try {                                                                       # Try the following
                    Write-Host 'Removing load balancer'
                    Remove-AzLoadBalancer -Name $LoadBalancerObject.Name -ResourceGroupName `
                        $LoadBalancerObject.ResourceGroupName -Force -ErrorAction 'Stop'    # Removes the selected load balancer
                }                                                                           # End try
                Catch {                                                                     # If try fails
                    Clear-Host                                                              # Clears screen
                    Write-Host 'An error has occured'                                       # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    Write-Host 'You may not have the permissions to do this'                # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Break RemoveAzureLoadBalancer                                           # Breaks :RemoveAzureLoadBalancer
                }                                                                           # End catch
                Clear-Host                                                                  # Clears screen
                Write-Host 'The load balancer has been removed'                             # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break RemoveAzureLoadBalancer                                               # Breaks :RemoveAzureLoadBalancer
            }                                                                               # End if ($OpConfirm -eq 'y')
            else {                                                                          # All other inputs for $OpConfirm
                Write-Host 'No changes have been made'                                      # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break RemoveAzureLoadBalancer                                               # Breaks :RemoveAzureLoadBalancer
            }                                                                               # End else (if ($OpConfirm -eq 'y'))
        }                                                                                   # End :RemoveAzureLoadBalancer while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function RemoveAzLoadBalancer
# Functions for ManageAzLBConfig
function ManageAzLBConfig {                                                                 # Function to manage load balancer config
    Begin {                                                                                 # Begin function
        :ManageAzureLoadBalancer while ($true) {                                            # Outer loop for managing function
            Write-Host '[0] Exit'                                                           # Write message to screen
            Write-Host '[1] Manage Front End Config'                                        # Write message to screen
            Write-Host '[2] Manage Back End Config'                                         # Write message to screen
            Write-Host '[3] Manage Probe Config'                                            # Write message to screen
            Write-Host '[4] Mange Rule Config'                                              # Write message to screen
            Write-Host '[5] Mange Nat Pool Config'                                          # Write message to screen
            Write-Host '[6] Mange Nat Rule Config'                                          # Write message to screen
            $OpSelect = Read-Host 'Option [#]'                                              # Operator input for the function selection
            Clear-Host                                                                      # Clears screen
            if ($OpSelect -eq '0') {                                                        # If $OpSelect equals '0'    
                Break ManageAzureLoadBalancer                                               # Breaks :ManageAzureLoadBalancer
            }                                                                               # End if ($OpSelect -eq '0')
            elseif ($OpSelect -eq '1') {                                                    # Else if $OpSelect equals '1'
                ManageAzLBFEConfig                                                          # Calls function
            }                                                                               # elseif ($OpSelect -eq '1')
            elseif ($OpSelect -eq '2') {                                                    # Else if $OpSelect equals '2'
                Write-Host 'Manage Back End Config'                                         # Write message to screen
                ManageAzLBBEConfig                                                          # Calls function
            }                                                                               # elseif ($OpSelect -eq '2')
            elseif ($OpSelect -eq '3') {                                                    # Else if $OpSelect equals '3'
                Write-Host 'Manage Probe Config'                                            # Write message to screen
                ManageAzLBProbeConfig                                                       # Calls function
            }                                                                               # elseif ($OpSelect -eq '3')
            elseif ($OpSelect -eq '4') {                                                    # Else if $OpSelect equals '4'
                Write-Host 'New Rule Config'                                                # Write message to screen
                #NewAzLoadBalancer                                                           # Calls function
            }                                                                               # elseif ($OpSelect -eq '4')
            elseif ($OpSelect -eq '5') {                                                    # Else if $OpSelect equals '5'
                Write-Host 'New Nat Pool Config'                                            # Write message to screen
                #NewAzLoadBalancer                                                           # Calls function
            }                                                                               # elseif ($OpSelect -eq '5')
            elseif ($OpSelect -eq '6') {                                                    # Else if $OpSelect equals '6'
                Write-Host 'Mange Nat Rule Config'                                          # Write message to screen
                ManageAzLBNatRuleConfig                                                     # Calls function
            }                                                                               # elseif ($OpSelect -eq '6')
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
}                                                                                           # End function ManageAzLBConfig
# Functions for ManageAzLBFEConfig
function ManageAzLBFEConfig {                                                               # Function to manage front end configurations
    Begin {                                                                                 # Begin function
        :ManageAzureLBFEConfig while ($true) {                                              # Outer loop for managing function
            Write-Host 'Manage Load Balancer Front End'                                     # Write message to screen
            Write-Host '[0] Exit'                                                           # Write message to screen
            Write-Host '[1] Add Private IP Config'                                          # Write message to screen
            Write-Host '[2] Add Public IP Config'                                           # Write message to screen
            Write-Host '[3] List IP configs'                                                # Write message to screen
            Write-Host '[4] Remove IP config'                                               # Write message to screen
            $OpSelect = Read-Host 'Option [#]'                                              # Operator input for the function selection
            Clear-Host                                                                      # Clears screen
            if ($OpSelect -eq '0') {                                                        # If $OpSelect equals '0'    
                Break ManageAzureLBFEConfig                                                 # Breaks :ManageAzureLBFEConfig
            }                                                                               # End if ($OpSelect -eq '0')
            elseif ($OpSelect -eq '1') {                                                    # Else if $OpSelect equals '1'
                Write-Host 'Add Private IP Config'                                          # Write message to screen
                AddAzLBFEPrivateConfig                                                      # Calls function
            }                                                                               # End elseif ($OpSelect -eq '1')
            elseif ($OpSelect -eq '2') {                                                    # Else if $OpSelect equals '2'
                Write-Host 'Add Public IP Config'                                           # Write message to screen
                AddAzLBFEPublicConfig                                                       # Calls function
            }                                                                               # End elseif ($OpSelect -eq '2')
            elseif ($OpSelect -eq '3') {                                                    # Else if $OpSelect equals '3'
                Write-Host 'List IP configs'                                                # Write message to screen
                ListAzLBFEConfigs                                                           # Calls function
            }                                                                               # End elseif ($OpSelect -eq '3')
            elseif ($OpSelect -eq '4') {                                                    # Else if $OpSelect equals '4'
                Write-Host 'Remove IP config'                                               # Write message to screen
                RemoveAzLBFEConfig                                                          # Calls function
            }                                                                               # End elseif ($OpSelect -eq '4')
            else {                                                                          # All other inputs for $OpSelect
                Write-Host 'That was not a valid input'                                     # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Clear-Host                                                                  # Clears screen
            }                                                                               # End else (if ($OpSelect -eq '0'))
        }                                                                                   # End :ManageAzureLBFEConfig while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function ManageAzLBFEConfig
function AddAzLBFEPrivateConfig {                                                           # Function to add a load balancer public IP front end config
    Begin {                                                                                 # Begin function
        if (!$CallingFunction) {                                                            # If $CallingFunction is $null
            $CallingFunction = 'AddAzLBFEPrivateConfig'                                     # Creates $CallingFunction
        }                                                                                   # End if (!$CallingFunction)
        :SetAzureLoadBalancer while ($true) {                                               # Outer loop for managing function
            $LoadBalancerObject = GetAzLoadBalancer ($CallingFunction)                      # Calls function and assigns output to $var
            if (!$LoadBalancerObject) {                                                     # If $LoadBalancerObject does not have a value
                Break SetAzureLoadBalancer                                                  # Breaks :SetAzureLoadBalancer
            }                                                                               # End if (!$LoadBalancerObject)
            if ($LoadBalancerObject.FrontendIpConfigurations.PublicIpAddress.ID) {          # If $LoadBalancerObject.FrontendIpConfigurations.PublicIpAddress.ID has a value
                Write-Host 'This load balancer is currently referencing a public IP'        # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Write-Host 'It is not possible to add a private config to a load'           # Write message to screen
                Write-Host 'balancer configured with a public IP front end'                 # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break SetAzureLoadBalancer                                                  # Breaks :SetAzureLoadBalancer
            }                                                                               # End if ($LoadBalancerObject.FrontendIpConfigurations.PublicIpAddress.ID)
            :NewAzureLBFrontEnd while ($true) {                                             # Inner loop for setting the type of front end config
                Write-Host 'Select type of front end config'                                # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Write-Host '[0] Exit'                                                       # Write message to screen
                Write-Host '[1] Private Dynamic'                                            # Write message to screen
                Write-Host '[2] Private Static'                                             # Write message to screen
                Write-Host ''                                                               # Write message to screen
                $OpSelect = Read-Host 'Option [#]'                                          # Operator input to select the IP type for front end config
                Clear-Host                                                                  # Clears screen
                if ($OpSelect -eq '0') {                                                    # If $OpSelect equals '0'
                    Break SetAzureLoadBalancer                                              # Breaks :SetAzureLoadBalancer  
                }                                                                           # End if ($OpSelect -eq '0')
                elseif ($OpSelect -eq '1') {                                                # Else if $OpSelect equals '1'
                    $FrontEndIPConfigObject = NewAzLBFEPriDynamicIpCon ($CallingFunction)   # Calls function and assigns output to $var
                    if (!$FrontEndIPConfigObject) {                                         # If $FrontEndIPConfigObject is $null
                        Break SetAzureLoadBalancer                                          # Breaks :SetAzureLoadBalancer
                    }                                                                       # End if (!$FrontEndIPConfigObject)
                }                                                                           # End elseif ($OpSelect -eq '1')
                elseif ($OpSelect -eq '2') {                                                # Else if $OpSelect equals '2'
                    $FrontEndIPConfigObject = NewAzLBFEPriStaticIpCon ($CallingFunction)    # Calls function and assigns output to $var
                    if (!$FrontEndIPConfigObject) {                                         # If $FrontEndIPConfigObject is $null
                        Break SetAzureLoadBalancer                                          # Breaks :SetAzureLoadBalancer
                    }                                                                       # End if (!$FrontEndIPConfigObject)
                }                                                                           # End elseif ($OpSelect -eq '2')
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
            $SubnetName = $FrontEndIPConfigObject.Subnet.ID                                 # Isolates the subnet ID
            $SubnetName = $SubnetName.Split('/')[-1]                                        # Isolates the subnet name
            Write-Host 'Add the following:'                                                 # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            Write-Host 'Load balancer: '$LoadBalancerObject.name                            # Write message to screen
            Write-Host 'Resource group:'$LoadBalancerObject.ResourceGroupName               # Write message to screen
            Write-Host 'Front end name:'$FrontEndIPConfigObject.Name                        # Write message to screen
            Write-Host 'Private IP add:'$FrontEndIPConfigObject.PrivateIpAddress            # Write message to screen
            Write-Host 'Private IP all:'$FrontEndIPConfigObject.PrivateIpAllocationMethod   # Write message to screen
            Write-Host 'Subnet Name:   '$SubnetName                                         # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            $OpConfirm = Read-Host '[Y] Yes [N] No'                                         # Operator confirmation to remove the load balancer
            Clear-Host                                                                      # Clears screen
            if ($OpConfirm -eq 'y') {                                                       # If $OpConfirm equals 'y'
                Try {                                                                       # Try the following
                    Write-Host 'Adding load balancer front end config'                      # Write message to screen    
                    if ($FrontEndIPConfigObject.PrivateIpAllocationMethod -eq 'Dynamic') {  # If $FrontEndIPConfigObject.PrivateIpAllocationMethod equals 'Dynamic'                  
                        $LoadBalancerObject | Add-AzLoadBalancerFrontendIpConfig -Name `
                            $FrontEndIPConfigObject.Name -SubnetId `
                            $FrontEndIPConfigObject.Subnet.ID -ErrorAction 'Stop' `
                            | Out-Null                                                      # Adds the load balancer config
                        Write-Host 'Saving load balancer front end config'                  # Write message to screen
                        $LoadBalancerObject | Set-AzLoadBalancerFrontendIpConfig -Name `
                            $FrontEndIPConfigObject.Name -SubnetId `
                            $FrontEndIPConfigObject.Subnet.ID -ErrorAction 'Stop' `
                            | Out-Null                                                      # Saves the load balancer config
                    }                                                                       # End if ($FrontEndIPConfigObject.PrivateIpAllocationMethod -eq 'Dynamic')
                    else {                                                                  # Else if $FrontEndIPConfigObject.PrivateIpAllocationMethod does not equal 'Dynamic'
                        $LoadBalancerObject | Add-AzLoadBalancerFrontendIpConfig -Name `
                            $FrontEndIPConfigObject.Name -SubnetId `
                            $FrontEndIPConfigObject.Subnet.ID -PrivateIpAddress `
                            $FrontEndIPConfigObject.PrivateIpAddress -ErrorAction 'Stop' `
                            | Out-Null                                                      # Adds the load balancer config
                        Write-Host 'Saving load balancer front end config'                  # Write message to screen
                        $LoadBalancerObject | Set-AzLoadBalancerFrontendIpConfig -Name `
                            $FrontEndIPConfigObject.Name -SubnetId `
                            $FrontEndIPConfigObject.Subnet.ID -PrivateIpAddress `
                            $FrontEndIPConfigObject.PrivateIpAddress -ErrorAction 'Stop' `
                            | Out-Null                                                      # Adds the load balancer config
                    }                                                                       # End else (if ($FrontEndIPConfigObject.PrivateIpAllocationMethod -eq 'Dynamic'))
                    Write-Host 'Saving load balancer config'                                # Write message to screen
                    $LoadBalancerObject | Set-AzLoadBalancer -ErrorAction 'Stop' | Out-Null # Saves the load balancer state
                }                                                                           # End try
                Catch {                                                                     # If try fails
                    Clear-Host                                                              # Clears screen
                    Write-Host 'An error has occured'                                       # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    Write-Host 'You may not have the permissions to do this'                # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Break SetAzureLoadBalancer                                              # Breaks :SetAzureLoadBalancer
                }                                                                           # End catch
                Clear-Host                                                                  # Clears screen
                Write-Host 'The front end config has been added'                            # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break SetAzureLoadBalancer                                                  # Breaks :SetAzureLoadBalancer
            }                                                                               # End if ($OpConfirm -eq 'y')
            else {                                                                          # All other inputs for $OpConfirm
                Write-Host 'No changes have been made'                                      # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break SetAzureLoadBalancer                                                  # Breaks :SetAzureLoadBalancer
            }                                                                               # End else (if ($OpConfirm -eq 'y'))
        }                                                                                   # End :SetAzureLoadBalancer while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function AddAzLBFEPrivateConfig
function AddAzLBFEPublicConfig {                                                            # Function to add a load balancer public IP front end config
    Begin {                                                                                 # Begin function
        if (!$CallingFunction) {                                                            # If $CallingFunction is $null
            $CallingFunction = 'AddAzLBFEPublicConfig'                                      # Creates $CallingFunction
        }                                                                                   # End if (!$CallingFunction)
        :SetAzureLoadBalancer while ($true) {                                               # Outer loop for managing function
            $LoadBalancerObject = GetAzLoadBalancer ($CallingFunction)                      # Calls function and assigns output to $var
            if (!$LoadBalancerObject) {                                                     # If $LoadBalancerObject does not have a value
                Break SetAzureLoadBalancer                                                  # Breaks :SetAzureLoadBalancer
            }                                                                               # End if (!$LoadBalancerObject)
            if ($LoadBalancerObject.FrontendIpConfigurations.Subnet.ID) {                   # If $LoadBalancerObject.FrontendIpConfigurations.Subnet.ID has a value
                Write-Host 'This load balancer is currently referencing a subnet'           # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Write-Host 'It is not possible to add a public config to a load'            # Write message to screen
                Write-Host 'balancer configured with a private IP front end'                # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break SetAzureLoadBalancer                                                  # Breaks :SetAzureLoadBalancer
            }                                                                               # End if ($LoadBalancerObject.FrontendIpConfigurations.Subnet.ID)
            $FrontEndIPConfigObject = NewAzLBFEPubIPCon ($CallingFunction)                  # Calls function and assigns the output to $var
            if (!$FrontEndIPConfigObject) {                                                 # If $FrontEndIPConfigObject is $null
                Break SetAzureLoadBalancer                                                  # Breaks :SetAzureLoadBalancer
            }                                                                               # End if (!$FrontEndIPConfigObject)
            $LBSku =  $LoadBalancerObject.Sku.name                                          # Gets the current load balance sku
            $PubIPID = $FrontEndIPConfigObject.PublicIPAddress.Id                           # Isloates the public IP ID
            $PubIPObject = Get-AzPublicIpAddress | Where-Object {$_.ID -eq $PubIPID}        # Gets the public IP object
            $PubIPSku = $PubIPObject.Sku.Name                                               # Isloates the sku
            if ($PubIPObject.IpConfiguration.Id) {                                          # If $PubIPObject.IpConfiguration.Id has a value
                Write-Host 'This public IP sku is already in use'                           # Write message to screen
                Write-Host 'Please select an unused public IP sku'                          # Write message to screen
                Write-Host 'No changes made'                                                # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break SetAzureLoadBalancer                                                  # Breaks :SetAzureLoadBalancer
            }
            if ($LBSku -ne $PubIPSku) {                                                     # If $LBSku does not equal $PubIPSku
                if ($LBSku -eq 'Basic') {                                                   # If $LBSku equals 'Basic'
                    Write-Host 'The load balancer is a basic SKU and'                       # Write message to screen
                    Write-Host 'can only use a basic public IP sku'                         # Write message to screen
                }                                                                           # End   
                else {                                                                      # If $LBSku does not equal 'Basic'                              
                    Write-Host 'The load balancer is a standard SKU and'                    # Write message to screen
                    Write-Host 'can only use a standard public IP sku'                      # Write message to screen
                }                                                                           # End else (if ($LBSku -eq 'Basic'))
                Write-Host ''                                                               # Write message to screen
                Write-Host 'No changes made'                                                # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break SetAzureLoadBalancer                                                  # Breaks :SetAzureLoadBalancer
            }                                                                               # End if ($LBSku -ne $PubIPSku)
            Write-Host 'Add the following:'                                                 # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            Write-Host 'Load balancer: '$LoadBalancerObject.name                            # Write message to screen
            Write-Host 'Resource group:'$LoadBalancerObject.ResourceGroupName               # Write message to screen
            Write-Host 'Front end name:'$FrontEndIPConfigObject.Name                        # Write message to screen
            Write-Host 'Public IP name:'$PubIPObject.Name                                   # Write message to screen
            Write-Host 'Public IP add: '$PubIPObject.IpAddress                              # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            $OpConfirm = Read-Host '[Y] Yes [N] No'                                         # Operator confirmation to remove the load balancer
            Clear-Host                                                                      # Clears screen
            if ($OpConfirm -eq 'y') {                                                       # If $OpConfirm equals 'y'
                Try {                                                                       # Try the following
                    Write-Host 'Adding load balancer front end config'                      # Write message to screen                         
                    $LoadBalancerObject | Add-AzLoadBalancerFrontendIpConfig -Name `
                        $FrontEndIPConfigObject.Name -PublicIpAddressId `
                        $FrontEndIPConfigObject.PublicIPAddress.ID -ErrorAction 'Stop' `
                        | Out-Null                                                          # Adds the load balancer config
                    Write-Host 'Saving load balancer front end config'                      # Write message to screen
                    $LoadBalancerObject | Set-AzLoadBalancerFrontendIpConfig -Name `
                        $FrontEndIPConfigObject.Name -PublicIpAddressId `
                        $FrontEndIPConfigObject.PublicIPAddress.ID -ErrorAction 'Stop' `
                        | Out-Null                                                          # Saves the load balancer config
                    Write-Host 'Saving load balancer config'                                # Write message to screen
                    $LoadBalancerObject | Set-AzLoadBalancer -ErrorAction 'Stop' | Out-Null # Saves the load balancer state
                }                                                                           # End try
                Catch {                                                                     # If try fails
                    Clear-Host                                                              # Clears screen
                    Write-Host 'An error has occured'                                       # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    Write-Host 'You may not have the permissions to do this'                # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Break SetAzureLoadBalancer                                              # Breaks :SetAzureLoadBalancer
                }                                                                           # End catch
                Clear-Host                                                                  # Clears screen
                Write-Host 'The front end config has been added'                            # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break SetAzureLoadBalancer                                                  # Breaks :SetAzureLoadBalancer
            }                                                                               # End if ($OpConfirm -eq 'y')
            else {                                                                          # All other inputs for $OpConfirm
                Write-Host 'No changes have been made'                                      # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break SetAzureLoadBalancer                                                  # Breaks :SetAzureLoadBalancer
            }                                                                               # End else (if ($OpConfirm -eq 'y'))
        }                                                                                   # End :SetAzureLoadBalancer while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function AddAzLBFEPublicConfig
function ListAzLBFEConfigs {                                                                # Function to list all load balancer front end configs
    Begin {                                                                                 # Begin function
        :ListAzureLBFEConfigs while ($true) {                                               # Outer loop for managing function
            Write-Host 'Gathering load balancer info'                                       # Write message to screen
            Write-Host 'This may take a moment'                                             # Write message to screen
            $ObjectList = Get-AzLoadBalancer                                                # Gets a list of all load balancers
            if (!$ObjectList) {                                                             # If $ObjectList is $null
                Clear-Host                                                                  # Clears screen
                Write-Host 'There are no load balancers in this subscription'               # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break ListAzureLBFEConfigs                                                  # Breaks ListAzureLBFEConfigs
            }                                                                               # if (!$ObjectList)
            [System.Collections.ArrayList]$ObjectArray = @()                                # Creates object list array
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
                }                                                                           # End foreach ($_ in $ObjectList2)
            }                                                                               # End foreach ($_ in $ObjectList)
            Clear-Host                                                                      # Clears screen
            foreach ($_ in $ObjectArray) {                                                  # For each item in $ObjectArray
                Write-Host 'Config Name:'$_.Name                                            # Write message to screen
                Write-Host 'LB Name:    '$_.LB                                              # Write message to screen
                if ($_.PubIP) {                                                             # If current item .PubIP has a value
                    Write-host 'Config Type: Public'                                        # Write message to screen
                    Write-Host 'IP Address: '$_.PubIP                                       # Write message to screen
                    Write-Host 'Allocation: '$_.PubIP2                                      # Write message to screen
                    Write-Host 'Sku Name:   '$_.PubIP3                                      # Write message to screen
                }                                                                           # End if ($_.PubIP)
                else {                                                                      # Else if current item .PubIP is $null
                    Write-host 'Config Type: Private'                                       # Write message to screen
                    if ($_.PriIP) {                                                         # if current item .priIP has a value
                        Write-Host 'IP Address: '$_.PriIP                                   # Write message to screen
                    }                                                                       # End if ($_.PriIP)
                    Write-Host 'Allocation: '$_.PriIP2                                      # Write message to screen
                    Write-Host 'Subnet:     '$_.Sub                                         # Write message to screen
                }                                                                           # End else (if ($_.PubIP))
                Write-Host ''                                                               # Write message to screen                                                               # Write message to screen
            }                                                                               # End foreach ($_ in $ObjectArray)
            Pause                                                                           # Pauses all actions for operator input
            Break ListAzureLBFEConfigs                                                      # Breaks :ListAzureLBFEConfigs
        }                                                                                   # End :ListAzureLBFEConfigs while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function ListAzLBFEConfigs
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
            $ObjectNumber = 1
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
function RemoveAzLBFEConfig {                                                               # Function to remove a load balancer front end config
    Begin {                                                                                 # Begin function
        if (!$CallingFunction) {                                                            # If $CallingFunction is $null
            $CallingFunction = 'RemoveAzLBFEConfig'                                         # Creates $CallingFunction
        }                                                                                   # End if (!$CallingFunction)
        :RemoveAzureLBFEConfig while ($true) {                                              # Outer loop for managing function
            $FrontEndIPConfigObject,$LoadBalancerObject = GetAzLBFEConfig `
                ($CallingFunction)                                                          # Calls function and assigns output to $var
            if (!$FrontEndIPConfigObject) {                                                 # If $FrontEndIPConfigObject is $null
                Break RemoveAzureLBFEConfig                                                 # Breaks :RemoveAzureLBFEConfig
            }                                                                               # End if (!$FrontEndIPConfigObject)
            Write-Host 'Remove the following:'                                              # Write message to screen
            Write-Host 'Config Name:'$FrontEndIPConfigObject.Name                           # Write message to screen
            Write-Host 'LB Name:    '$LoadBalancerObject.Name                               # Write message to screen
            $OpConfirm = Read-Host '[Y] Yes [N] No'                                         # Operator confirmation to remove the config
            if ($OpConfirm -eq 'y') {                                                       # If $OpConfirm equals 'y'
                Try {                                                                       # Try the following
                    Write-Host 'Removing the config'
                    Remove-AzLoadBalancerFrontendIpConfig -LoadBalancer `
                        $LoadBalancerObject -Name $FrontEndIPConfigObject `
                        -ErrorAction 'Stop' | Out-Null                                      # Removes the config
                }                                                                           # End Try
                Catch {                                                                     # If Try fails
                    Clear-Host                                                              # Clears screen
                    Write-Host 'An error has occured'                                       # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    Write-Host 'You may not have the permissions'                           # Write message to screen
                    Write-Host 'to perform this action'                                     # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Break RemoveAzureLBFEConfig                                             # Breaks :RemoveAzureLBFEConfig
                }                                                                           # End catch
                Clear-Host                                                                  # Clears screen
                Write-Host 'The configuration has been removed'                             # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break RemoveAzureLBFEConfig                                                 # Breaks :RemoveAzureLBFEConfig
            }                                                                               # End if ($OpConfirm -eq 'y')
            else {                                                                          # All other inputs for $OpConfirm
                Write-Host 'No changes have been made'                                      # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break RemoveAzureLBFEConfig                                                 # Breaks :RemoveAzureLBFEConfig
            }                                                                               # End else (if ($OpConfirm -eq 'y'))
        }                                                                                   # End :RemoveAzureLBFEConfig while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function RemoveAzLBFEConfig
# End ManageAzLBFEConfig
# Functions for ManageAzLBBEConfig
function ManageAzLBBEConfig {                                                               # Function to manage back end configurations
    Begin {                                                                                 # Begin function
        :ManageAzureLBBEConfig while ($true) {                                              # Outer loop for managing function
            Write-Host 'Manage Load Balancer Back End'                                      # Write message to screen
            Write-Host '[0] Exit'                                                           # Write message to screen
            Write-Host '[1] Add Back End Pool'                                              # Write message to screen
            Write-Host '[2] List Back End Pools'                                            # Write message to screen
            Write-Host '[3] Add VM to Back End Pool'                                        # Write message to screen
            Write-Host '[4] Remove VM from Back End Pool'                                   # Write message to screen
            Write-Host '[5] Remove Back End Pool'                                           # Write message to screen
            $OpSelect = Read-Host 'Option [#]'                                              # Operator input for the function selection
            Clear-Host                                                                      # Clears screen
            if ($OpSelect -eq '0') {                                                        # If $OpSelect equals '0'    
                Break ManageAzureLBBEConfig                                                 # Breaks :ManageAzureLBBEConfig
            }                                                                               # End if ($OpSelect -eq '0')
            elseif ($OpSelect -eq '1') {                                                    # Else if $OpSelect equals '1'
                Write-Host 'Add Back End Pool'                                              # Write message to screen
                AddAzLBBEPoolConfig                                                         # Calls function
            }                                                                               # End elseif ($OpSelect -eq '1')
            elseif ($OpSelect -eq '2') {                                                    # Else if $OpSelect equals '2'
                Write-Host 'List Back End Pools'                                            # Write message to screen
                ListAzLBBEPoolConfig                                                        # Calls function
            }                                                                               # End elseif ($OpSelect -eq '2')
            elseif ($OpSelect -eq '3') {                                                    # Else if $OpSelect equals '3'
                Write-Host 'Add VM to Back End Pool'                                        # Write message to screen
                SetAzLBBEPoolVM                                                             # Calls function
            }                                                                               # End elseif ($OpSelect -eq '3')
            elseif ($OpSelect -eq '4') {                                                    # Else if $OpSelect equals '4'
                Write-Host 'Remove VM from Back End Pool'                                   # Write message to screen
                RemoveAzLBBEPoolVM                                                          # Calls function
            }                                                                               # End elseif ($OpSelect -eq '4')
            elseif ($OpSelect -eq '5') {                                                    # Else if $OpSelect equals '5'
                Write-Host 'Remove Back End Pool'                                           # Write message to screen
                RemoveAzLBBEConfig                                                          # Calls function
            }                                                                               # End elseif ($OpSelect -eq '5')
            else {                                                                          # All other inputs for $OpSelect
                Write-Host 'That was not a valid input'                                     # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Clear-Host                                                                  # Clears screen
            }                                                                               # End else (if ($OpSelect -eq '0'))
        }                                                                                   # End :ManageAzureLBBEConfig while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function ManageAzLBBEConfig
function AddAzLBBEPoolConfig {                                                              # Function to add a new load balancer back end pool
    Begin {                                                                                 # Begin function
        if (!$CallingFunction) {                                                            # If $CallingFunction is $null
            $CallingFunction = 'AddAzLBBEPoolConfig'                                        # Creates $CallingFunction
        }                                                                                   # End if (!$CallingFunction)
        :AddAzureLBBEPool while ($true) {                                                   # Outer loop for managing function
            $LoadBalancerObject = GetAzLoadBalancer ($CallingFunction)                      # Calls function and assigns output to $var
            if (!$LoadBalancerObject) {                                                     # If $LoadBalancerObject is $null
                Break AddAzureLBBEPool                                                      # Breaks :AddAzureLBBEPool
            }                                                                               # End if (!$LoadBalancerObject)
            $VName1st = 'abcdefghijklmnopqrstuvwxyz0123456789'                              # Valid name first character
            $VName1st = $VName1st.ToCharArray()                                             # Converts $var to character array
            $VNameElse = 'abcdefghijklmnopqrstuvwxyz0123456789.-_'                          # Valid name body characters
            $VNameElse = $VNameElse.ToCharArray()                                           # Converts $var to character array
            $VNameLast = 'abcdefghijklmnopqrstuvwxyz0123456789_'                            # Valid name last character
            $VNameLast = $VNameLast.ToCharArray()                                           # Converts $var to character array
            :SetAzureLBBEPoolName while ($true) {                                           # Inner loop for setting the name
                Write-Host 'Back End name rules:'                                           # Write message to screen
                Write-Host 'The name can be up to 80 characters long'                       # Write message to screen
                Write-Host 'It must begin with a word character (A-9)'                      # Write message to screen
                Write-Host 'The name may contain word characters or . - _'                  # Write message to screen
                Write-Host 'It must end with a word character (A-9) or with _'              # Write message to screen
                Write-Host ''                                                               # Write message to screen
                $BackEndPoolName = Read-Host 'Name'                                         # Operator input for the back end pool name
                $BackEndPoolArray = $BackEndPoolName.ToCharArray()                          # Converts $var to character array
                Clear-Host                                                                  # Clears screen
                if ($BackEndPoolName.Length -gt 80) {                                       # If $BackEndPoolName.Length is greater than 80
                    Write-Host 'The input is to long and cannot be used'                    # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    $BackEndPoolName = $null                                                # Clears $var
                }                                                                           # End if ($BackEndPoolName.Length -gt 80)
                if ($BackEndPoolArray[0] -notin $VName1st) {                                # If 0 position of $BackEndPoolArray is not in $VName1st
                    Write-Host  $BackEndPoolArray[-1]' is not a valid character'            # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    $BackEndPoolName = $null                                                # Clears $BackEndPoolName
                }                                                                           # End if ($BackEndPoolArray[0] -notin $VName1st)
                foreach ($_ in $BackEndPoolArray) {                                         # For each item in $BackEndPoolArray
                    if ($_ -notin $VNameElse) {                                             # If current item is not in $VNameElse
                        if ($_ -eq ' ') {                                                   # If current item equals 'space'
                            Write-Host 'Back end name cannot include any spaces'            # Write message to screen
                            Write-Host ''                                                   # Write message to screen    
                        }                                                                   # End if ($_ -eq ' ')
                        else {                                                              # If current item is not equal to 'space'    
                            Write-Host $_' is not a valid character'                        # Write message to screen
                            Write-Host ''                                                   # Write message to screen
                        }                                                                   # End else (if ($_ -eq ' '))
                        $BackEndPoolName = $null                                            # Clears $BackEndPoolName
                    }                                                                       # End if ($_ -notin $BackEndPoolArray)
                }                                                                           # End foreach ($_ in $LBNameArray)
                if ($BackEndPoolArray[-1] -notin $VNameLast) {                              # If last position of $BackEndPoolArray is not in $VNameLast
                    Write-Host  $BackEndPoolArray[-1]' is not a valid character'            # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    $BackEndPoolName = $null                                                # Clears $BackEndPoolName
                }                                                                           # End if ($BackEndPoolArray[0] -notin $VNameLast)
                if ($BackEndPoolName) {                                                     # If $BackEndPoolName has a value
                    Write-Host 'Use:'$BackEndPoolName' as the back end pool name'           # Write message to screen
                    $OpConfirm = Read-Host '[Y] Yes [N] No [E] Exit'                        # Operator confirmation of the back end pool name
                    Clear-Host                                                              # Clears screen
                    if ($OpConfirm -eq 'e') {                                               # If $OpConfirm equals 'e'
                        Break AddAzureLBBEPool                                              # Breaks :AddAzureLBBEPool
                    }                                                                       # End if ($OpConfirm -eq 'e')
                    elseif ($OpConfirm -eq 'y') {                                           # Else if $OpConfirm equals 'y'
                        Break SetAzureLBBEPoolName                                          # Breaks :SetAzureLBBEPoolName
                    }                                                                       # End elseif ($OpConfirm -eq 'y')
                }                                                                           # End if ($BackEndPoolName)
                else {                                                                      # Else if $BackEndPoolName is $null
                    Pause                                                                   # Pauses all actions for operator input
                    Clear-Host                                                              # Clears screen
                }                                                                           # End else (if ($BackEndPoolName))
            }                                                                               # End :SetAzureLBBEPoolName while ($true)
            Try {                                                                           # Try the following
                Write-Host 'Building back end configuration'                                # Write message to screen
                $LoadBalancerObject | Add-AzLoadBalancerBackendAddressPoolConfig -Name `
                    $BackEndPoolName -ErrorAction 'Stop' | Out-Null                         # Creates the back end pool
                Write-Host 'Saving load balancer configuration'                             # Write message to screen
                $LoadBalancerObject | Set-AzLoadBalancer -ErrorAction 'Stop' | Out-Null     # Saves the load balancer
            }                                                                               # End Try
            Catch {                                                                         # If Try fails
                Clear-Host                                                                  # Clears screen
                Write-Host 'An error has occured'                                           # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break AddAzureLBBEPool                                                      # Breaks :AddAzureLBBEPool
            }                                                                               # End catch
            Clear-Host                                                                      # Clears screen
            Write-Host 'The back end pool has been created'                                 # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            Pause                                                                           # Pauses all actions for operator input
            Break AddAzureLBBEPool                                                          # Breaks :AddAzureLBBEPool
        }                                                                                   # End :AddAzureLBBEPool while ($true)                                                     
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End begin
}                                                                                           # End function AddAzLBBEPoolConfig
function ListAzLBBEPoolConfig {                                                             # Function to list existing load balancer back end pool configs
    Begin {                                                                                 # Begin function
        :ListAzureLBBEPoolConfig while ($true) {                                            # Outer loop to manage function
            Write-Host 'Gathering load balancer info'                                       # Write message to screen
            Write-Host 'This may take a moment'                                             # Write message to screen
            $ObjectList = Get-AzLoadBalancer                                                # Generates the load balancer list
            if (!$ObjectList) {                                                             # If $ObjectList is $null 
                Clear-Host                                                                  # Clears screen
                Write-Host 'No load balancers are in this subscription'                     # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break ListAzureLBBEPoolConfig                                               # Breaks ListAzureLBBEPoolConfig
            }                                                                               # End if (!$ObjectList)
            [System.Collections.ArrayList]$ObjectArray = @()                                # Creates the load balancer array
            foreach ($_ in $ObjectList) {                                                   # For each item in $ObjectList
                $LBObject = $_                                                              # Isolates the current item
                $PoolConfigList = Get-AzLoadBalancerBackendAddressPool -LoadBalancer $_     # Gets a list of all back end pools on $LBObject
                foreach ($_ in $PoolConfigList) {                                           # For each item in $PoolConfigList
                    $ObjectInput = [PSCustomObject]@{                                       # Creates the item to loaded into array
                        'Name'=$_.Name;'LBName'=$LBObject.Name;`
                        'RGName'=$LBObject.ResourceGroupName;`
                        'BackEndAddresses'=$_.LoadBalancerBackendAddresses                  # Gets current item info
                    }                                                                       # End $ObjectInput = [PSCustomObject]@
                    $ObjectArray.Add($ObjectInput) | Out-Null                               # Loads item into array
                }                                                                           # End foreach ($_ in $PoolConfigList)
            }                                                                               # End foreach ($_ in $ObjectList)
            Clear-Host                                                                      # Clears screen
            if (!$ObjectArray) {                                                            # If $ObjectArray is $null    
                Write-Host 'No load balancer back end configs exist in this subscription'   # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break ListAzureLBBEPoolConfig                                               # Breaks :ListAzureLBBEPoolConfig
            }                                                                               # End if (!$ObjectArray)
            foreach ($_ in $ObjectArray) {                                                  # For each $_ in $ObjectArray
                Write-Host 'Back End Pool: '$_.Name                                         # Write message to screen
                Write-Host 'LB Name:       '$_.LBName                                       # Write message to screen
                Write-Host 'LB RG:         '$_.RGName                                       # Write message to screen
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
            Pause                                                                           # Pauses all actions for operator input
            Break ListAzureLBBEPoolConfig                                                   # Breaks :ListAzureLBBEPoolConfig
        }                                                                                   # End :ListAzureLBBEPoolConfig while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function ListAzLBBEPoolConfig
function GetAzLBBEPoolConfig {                                                              # Function to get an existing load balancer back end pool config
    Begin {                                                                                 # Begin function
        :GetAzureLBBEPoolConfig while ($true) {                                             # Outer loop to manage function
            Write-Host 'Gathering load balancer info'                                       # Write message to screen
            Write-Host 'This may take a moment'                                             # Write message to screen
            $ObjectList = Get-AzLoadBalancer                                                # Generates the load balancer list
            if (!$ObjectList) {                                                             # If $ObjectList is $null 
                Clear-Host                                                                  # Clears screen
                Write-Host 'No load balancers are in this subscription'                     # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break GetAzureLBBEPoolConfig                                                # Breaks GetAzureLBBEPoolConfig
            }                                                                               # End if (!$ObjectList)
            $ObjectNumber = 1                                                               # Sets $ObjectNumber to 1
            [System.Collections.ArrayList]$ObjectArray = @()                                # Creates the load balancer array
            foreach ($_ in $ObjectList) {                                                   # For each item in $ObjectList
                $LBObject = $_                                                              # Isolates the current item
                $PoolConfigList = Get-AzLoadBalancerBackendAddressPool -LoadBalancer $_     # Gets a list of all back end pools on $LBObject
                foreach ($_ in $PoolConfigList) {                                           # For each item in $PoolConfigList
                    $ObjectInput = [PSCustomObject]@{                                       # Creates the item to loaded into array
                        'Number'=$ObjectNumber;'Name'=$_.Name;`
                        'LBName'=$LBObject.Name;`
                        'RGName'=$LBObject.ResourceGroupName;`
                        'BackEndAddresses'=$_.LoadBalancerBackendAddresses                  # Gets current item info
                    }                                                                       # End $ObjectInput = [PSCustomObject]@
                    $ObjectArray.Add($ObjectInput) | Out-Null                               # Loads item into array
                    $ObjectNumber = $ObjectNumber + 1                                       # Increments $ObjectNumber by 1
                }                                                                           # End foreach ($_ in $PoolConfigList)
            }                                                                               # End foreach ($_ in $ObjectList)
            Clear-Host                                                                      # Clears screen
            if (!$ObjectArray) {                                                            # If $ObjectArray is $null    
                Write-Host 'No load balancer back end configs exist in this subscription'   # Write message to screen
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
                Write-Host 'LB Name:       '$_.LBName                                       # Write message to screen
                Write-Host 'LB RG:         '$_.RGName                                       # Write message to screen
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
                    $LoadBalancerObject = Get-AzLoadBalancer -Name $OpSelect.LBName `
                        -ResourceGroupName $OPSelect.RGName                                 # Pulls the full load balancer object
                    $LBBackEndObject = Get-AzLoadBalancerBackendAddressPool -LoadBalancer `
                        $LoadBalancerObject -Name $OpSelect.Name                            # Pulls the load balancer back end config object
                    Clear-Host                                                              # Clears screen
                    Return $LBBackEndObject, $LoadBalancerObject                            # Returns to calling function with $vars
                }                                                                           # End elseif ($OpSelect -in $ObjectArray.Number) 
                else {                                                                      # All other inputs for $OpSelect
                    Write-Host 'That was not a valid input'                                 # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                }                                                                           # End else (if ($OpSelect -eq '0'))
            }                                                                               # End :SelectAzureLBBeConfig while ($true)
        }                                                                                   # End :GetAzureLBBEPoolConfig while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function GetAzLBBEPoolConfig
function SetAzLBBEPoolVM {                                                                  # Function to associate a VM to a back end pool
    Begin {                                                                                 # Begin function
        if (!$CallingFunction) {                                                            # If $CallingFunction is $null
            $CallingFunction  = 'SetAzLBBEPoolVM'                                           # Creates $CallingFunction
        }                                                                                   # End if (!$CallingFunction)
        :SetAzureLBBEPoolVM while ($true) {                                                 # Outer loop for managing function
            $LBBackEndObject, $LoadBalancerObject = GetAzLBBEPoolConfig `
                ($CallingFunction)                                                          # Calls function and assigns output to $var
            if (!$LBBackEndObject) {                                                        # If $LBBackEndObject is $null
                Break SetAzureLBBEPoolVM                                                    # Breaks :SetAzureLBBEPoolVM
            }                                                                               # End if (!$LBBackEndObject)
            $NicIPConfigObject,$NicObject = GetAzNICIpConfig ($CallingFunction)             # Calls function and assigns output to $var
            if (!$NicIPConfigObject) {                                                      # If $NicIPConfigObject is $null
                Break SetAzureLBBEPoolVM                                                    # Breaks :SetAzureLBBEPoolVM
            }                                                                               # End if (!$NicIPConfigObject)
            if (!$NicObject.VirtualMachine.ID) {                                            # If $NicObject.VirtualMachine.ID is $null
                Write-Host 'The selecting NIC config does not have an associated VM'        # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Write-Host 'No changes have been made'                                      # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break SetAzureLBBEPoolVM                                                    # Breaks :SetAzureLBBEPoolVM
            }                                                                               # End if (!$NicObject.VirtualMachine.ID)
            if ($NicIPConfigObject.Subnet.ID -ne `
                $LoadBalancerObject.FrontendIpConfigurations.Subnet.ID) {                   # If $NicIPConfigObject.Subnet.ID does not equal $LoadBalancerObject.FrontendIpConfigurations.Subnet.ID
                Write-Host 'The selected NIC config is not in '                             # Write message to screen
                Write-Host 'the same subnet as the load balancer'                           # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Write-Host 'No changes have been made'                                      # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break SetAzureLBBEPoolVM                                                    # Breaks :SetAzureLBBEPoolVM    
            }                                                                               # End if ($NicIPConfigObject.Subnet.ID -ne $LoadBalancerObject.FrontendIpConfigurations.Subnet.ID)
            if ($NicIPConfigObject.PublicIPAddress.ID) {                                    # If ($NicIPConfigObject.PublicIPAddress.ID has a value    
                $PubIPID = $NicIPConfigObject.PublicIPAddress.ID                            # Isolated the public IP ID
                $PubIPObject = Get-AzPublicIpAddress | Where-Object {$_.ID -eq $PubIPID}    # Gets the public IP sku
                if ($PubIPObject.Sku.Name -eq 'Basic') {                                    # If $PubIPObject.Sku.Name equals 'Basic'
                    Write-Host 'The selected NIC config has a basic sku public IP'          # Write message to screen
                    Write-Host 'You will need to replace the public IP with a standard sku' # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    Write-Host 'No changes have been made'                                  # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Break SetAzureLBBEPoolVM                                                # Breaks :SetAzureLBBEPoolVM
                }                                                                           # End if ($PubIPObject.Sku.Name -eq 'Basic')
            }                                                                               # End if ($NicIPConfigObject.PublicIPAddress.ID)
            if ($NicIPConfigObject.ID -in $LBBackEndObject.BackendIpConfigurations.ID) {    # If ($NicIPConfigObject.ID is in $LBBackEndObject.BackendIpConfigurations.ID 
                Write-Host 'That IP config is already associated to this pool'              # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Write-Host 'No changes have been made'                                      # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break SetAzureLBBEPoolVM                                                    # Breaks :SetAzureLBBEPoolVM    
            }                                                                               # End if ($NicIPConfigObject.ID -in $LBBackEndObject.BackendIpConfigurations.ID)
            $VMName = $NicObject.VirtualMachine.ID.Split('/')[-1]                           # Isloates the VM name
            Write-Host 'Make the following change:'                                         # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            Write-Host 'Add:'                                                               # Write message to screen
            Write-Host 'VM Name:      '$VMName                                              # Write message to screen
            Write-Host 'Nic Name:     '$NicObject.name                                      # Write message to screen
            Write-Host 'Config Name:  '$NicIPConfigObject.Name                              # Write message to screen
            Write-Host 'Private IP:   '$NicIPConfigObject.PrivateIPAddress                  # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            Write-Host 'To:'                                                                # Write message to screen
            Write-Host 'Load Balancer:'$LoadBalancerObject.name                             # Write message to screen
            Write-Host 'BE Pool:      '$LBBackEndObject.name                                # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            $OpConfirm = Read-Host '[Y] Yes [N] No'                                         # Operator confirmation to make the change
            Clear-Host                                                                      # Clears screen
            if ($OpConfirm -eq 'y') {                                                       # If $OpConfirm equals 'y'
                Try {                                                                       # Try the following
                    Write-Host 'Adding the IP config to back end pool'                      # Write message to screen
                    $NicObject | Set-AzNetworkInterfaceIpConfig -Name `
                        $NicIPConfigObject.Name -LoadBalancerBackendAddressPoolId `
                        $LBBackEndObject.ID -ErrorAction 'Stop' | Out-Null                  # Adds the load balancer back end pool
                }                                                                           # End Try
                catch {                                                                     # If Try fails
                    Clear-Host                                                              # Clears screen
                    Write-Host 'An error has occured'                                       # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Break SetAzureLBBEPoolVM                                                # Breaks :SetAzureLBBEPoolVM
                }                                                                           # End catch
                Write-Host 'Saving nic configuration, This may take a moment'               # Write message to screen
                $NicObject | Set-AzNetworkInterface                                         # Saves the nic config
                Clear-Host                                                                  # Clears screen
                Write-Host 'The changes have been made'                                     # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break SetAzureLBBEPoolVM                                                    # Breaks :SetAzureLBBEPoolVM
            }                                                                               # End if ($OpConfirm -eq 'y') 
            else {                                                                          # All other inputs for $OpSelect
                Write-Host 'No changes have been made'                                      # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break SetAzureLBBEPoolVM                                                    # Breaks :SetAzureLBBEPoolVM
            }                                                                               # End else (if ($OpConfirm -eq 'y'))
        }                                                                                   # End :SetAzureLBBEPoolVM while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function SetAzLBBEPoolVM
function RemoveAzLBBEPoolVM {                                                               # Function to remove a VM from a back end pool
    Begin {                                                                                 # Begin function
        if (!$CallingFunction) {                                                            # If $CallingFunction is $null
            $CallingFunction  = 'RemoveAzLBBEPoolVM'                                        # Creates $CallingFunction
        }                                                                                   # End if (!$CallingFunction)
        :SetAzureLBBEPoolVM while ($true) {                                                 # Outer loop for managing function
            $NicIPConfigObject,$NicObject = GetAzNICIpConfig ($CallingFunction)             # Calls function and assigns output to $var
            if (!$NicIPConfigObject) {                                                      # If $NicIPConfigObject is $null
                Break SetAzureLBBEPoolVM                                                    # Breaks :SetAzureLBBEPoolVM
            }                                                                               # End if (!$NicIPConfigObject)
            if (!$NicIPConfigObject.LoadBalancerBackendAddressPools.ID) {                   # If $NicIPConfigObject.LoadBalancerBackendAddressPools.ID is $null
                Write-Host 'The selected NIC config is not associated with a back end pool' # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Write-Host 'No changes have been made'                                      # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break SetAzureLBBEPoolVM                                                    # Breaks :SetAzureLBBEPoolVM
            }                                                                               # End if (!$NicIPConfigObject.LoadBalancerBackendAddressPools.ID)
            $BackEndPoolID = $NicIPConfigObject.LoadBalancerBackendAddressPools.ID          # Isolates the back end pool ID
            $LoadBalancerObject = Get-AzLoadBalancer | Where-Object `
                {$_.BackendAddressPools.ID -eq $BackEndPoolID}                              # Gets the load balancer object
            $LBBackEndObject = $BackEndPoolID.Split('/')[-1]                                # Isolates the back end pool name
            if ($NicObject.VirtualMachine.ID) {                                             # If $NicObject.VirtualMachine.ID has a value
                $VMName = $NicObject.VirtualMachine.ID.Split('/')[-1]                       # Isloates the VM name
            }                                                                               # End if ($NicObject.VirtualMachine.ID)
            Write-Host 'Make the following change:'                                         # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            Write-Host 'Remove:'                                                            # Write message to screen
            if ($VMName) {                                                                  # If $VMName has a value
                Write-Host 'VM Name:      '$VMName                                          # Write message to screen
            }                                                                               # End if ($VMName)
            Write-Host 'Nic Name:     '$NicObject.name                                      # Write message to screen
            Write-Host 'Config Name:  '$NicIPConfigObject.Name                              # Write message to screen
            Write-Host 'Private IP:   '$NicIPConfigObject.PrivateIPAddress                  # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            Write-Host 'From:'                                                              # Write message to screen
            Write-Host 'Load Balancer:'$LoadBalancerObject.name                             # Write message to screen
            Write-Host 'BE Pool:      '$LBBackEndObject                                     # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            $OpConfirm = Read-Host '[Y] Yes [N] No'                                         # Operator confirmation to make the change
            Clear-Host                                                                      # Clears screen
            if ($OpConfirm -eq 'y') {                                                       # If $OpConfirm equals 'y'
                Try {                                                                       # Try the following
                    Write-Host 'Removing the IP config from back end pool'                  # Write message to screen
                    $NicObject | Set-AzNetworkInterfaceIpConfig -Name `
                        $NicIPConfigObject.Name -LoadBalancerBackendAddressPoolId `
                        $null -ErrorAction 'Stop' | Out-Null                                # Removes the nic from load balancer back end pool
                }                                                                           # End Try
                catch {                                                                     # If Try fails
                    Clear-Host                                                              # Clears screen
                    Write-Host 'An error has occured'                                       # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Break SetAzureLBBEPoolVM                                                # Breaks :SetAzureLBBEPoolVM
                }                                                                           # End catch
                Write-Host 'Saving nic configuration, This may take a moment'               # Write message to screen
                $NicObject | Set-AzNetworkInterface                                         # Saves the nic config
                Clear-Host                                                                  # Clears screen
                Write-Host 'The changes have been made'                                     # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break SetAzureLBBEPoolVM                                                    # Breaks :SetAzureLBBEPoolVM
            }                                                                               # End if ($OpConfirm -eq 'y') 
            else {                                                                          # All other inputs for $OpSelect
                Write-Host 'No changes have been made'                                      # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break SetAzureLBBEPoolVM                                                    # Breaks :SetAzureLBBEPoolVM
            }                                                                               # End else (if ($OpConfirm -eq 'y'))
        }                                                                                   # End :SetAzureLBBEPoolVM while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function RemoveAzLBBEPoolVM
function RemoveAzLBBEConfig {                                                               # Function to remove a load balancer back end pool config
    Begin {                                                                                 # Begin function
        if (!$CallingFunction) {                                                            # If $CallingFunction is $null
            $CallingFunction = 'RemoveAzLBBEConfig'                                         # Creates $CallingFunction
        }                                                                                   # End if (!$CallingFunction)
        :RemoveAzureLBBEConfig while ($true) {                                              # Outer loop for managing function
            $LBBackEndObject, $LoadBalancerObject = GetAzLBBEPoolConfig `
                ($CallingFunction)                                                          # Calls function and assigns output to $var
            if (!$LBBackEndObject) {                                                        # If $LBBackEndObject is $null
                Break RemoveAzureLBBEConfig                                                 # Breaks :RemoveAzureLBBEConfig
            }                                                                               # End if (!$LBBackEndObject)
            Write-Host 'Remove the following:'                                              # Write message to screen
            Write-Host 'Config Name:'$LBBackEndObject.Name                                  # Write message to screen
            Write-Host 'LB Name:    '$LoadBalancerObject.Name                               # Write message to screen
            $OpConfirm = Read-Host '[Y] Yes [N] No'                                         # Operator confirmation to remove the config
            if ($OpConfirm -eq 'y') {                                                       # If $OpConfirm equals 'y'
                Try {                                                                       # Try the following
                    Write-Host 'Removing the config'
                    Remove-AzLoadBalancerBackendAddressPool -LoadBalancer `
                        $LoadBalancerObject -Name $LBBackEndObject.name `
                        -ErrorAction 'Stop' | Out-Null                                      # Removes the config
                }                                                                           # End Try
                Catch {                                                                     # If Try fails
                    Clear-Host                                                              # Clears screen
                    Write-Host 'An error has occured'                                       # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    Write-Host 'You may not have the permissions'                           # Write message to screen
                    Write-Host 'to perform this action'                                     # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Break RemoveAzureLBBEConfig                                             # Breaks :RemoveAzureLBBEConfig
                }                                                                           # End catch
                Clear-Host                                                                  # Clears screen
                Write-Host 'The configuration has been removed'                             # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break RemoveAzureLBBEConfig                                                 # Breaks :RemoveAzureLBBEConfig
            }                                                                               # End if ($OpConfirm -eq 'y')
            else {                                                                          # All other inputs for $OpConfirm
                Write-Host 'No changes have been made'                                      # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break RemoveAzureLBBEConfig                                                 # Breaks :RemoveAzureLBBEConfig
            }                                                                               # End else (if ($OpConfirm -eq 'y'))
        }                                                                                   # End :RemoveAzureLBBEConfig while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function RemoveAzLBBEConfig
# End ManageAzLBBEConfig
# Functions for ManageAzLBProbeConfig
function ManageAzLBProbeConfig {                                                            # Function to manage load balancer probe configurations
    Begin {                                                                                 # Begin function
        :ManageAzureLBProbeConfig while ($true) {                                           # Outer loop for managing function
            Write-Host 'Manage Load Balancer Back End'                                      # Write message to screen
            Write-Host '[0] Exit'                                                           # Write message to screen
            Write-Host '[1] Add Probe Config'                                               # Write message to screen
            Write-Host '[2] List Probe Configs'                                             # Write message to screen
            Write-Host '[3] Remove ProbeConfig'                                             # Write message to screen
            $OpSelect = Read-Host 'Option [#]'                                              # Operator input for the function selection
            Clear-Host                                                                      # Clears screen
            if ($OpSelect -eq '0') {                                                        # If $OpSelect equals '0'    
                Break ManageAzureLBProbeConfig                                              # Breaks :ManageAzureLBProbeConfig
            }                                                                               # End if ($OpSelect -eq '0')
            elseif ($OpSelect -eq '1') {                                                    # Else if $OpSelect equals '1'
                Write-Host 'Add Probe Config'                                               # Write message to screen
                AddAzLBProbeConfig                                                          # Calls function
            }                                                                               # End elseif ($OpSelect -eq '1')
            elseif ($OpSelect -eq '2') {                                                    # Else if $OpSelect equals '2'
                Write-Host 'List Probe Configs'                                             # Write message to screen
                ListAzLBProbeConfig                                                         # Calls function
            }                                                                               # End elseif ($OpSelect -eq '2')
            elseif ($OpSelect -eq '3') {                                                    # Else if $OpSelect equals '3'
                Write-Host 'Remove ProbeConfig'                                             # Write message to screen
                #SetAzLBBEPoolVM                                                             # Calls function
            }                                                                               # End elseif ($OpSelect -eq '3')
            else {                                                                          # All other inputs for $OpSelect
                Write-Host 'That was not a valid input'                                     # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Clear-Host                                                                  # Clears screen
            }                                                                               # End else (if ($OpSelect -eq '0'))
        }                                                                                   # End :ManageAzureLBProbeConfig while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function ManageAzLBProbeConfig
function AddAzLBProbeConfig {                                                               # Function to add a new load balancer probe config
    Begin {                                                                                 # Begin function
        if (!$CallingFunction) {                                                            # If $CallingFunction is $null
            $CallingFunction = 'AddAzLBProbeConfig'                                         # Creates $CallingFunction
        }                                                                                   # End if (!$CallingFunction)
        :AddAzureLBProbe while ($true) {                                                    # Outer loop for managing function
            $LoadBalancerObject = GetAzLoadBalancer ($CallingFunction)                      # Calls function and assigns output to $var
            if (!$LoadBalancerObject) {                                                     # If $LoadBalancerObject is $null
                Break AddAzureLBProbe                                                       # Breaks :AddAzureLBProbe
            }                                                                               # End if (!$LoadBalancerObject)
            $VName1st = 'abcdefghijklmnopqrstuvwxyz0123456789'                              # Valid name first character
            $VName1st = $VName1st.ToCharArray()                                             # Converts $var to character array
            $VNameElse = 'abcdefghijklmnopqrstuvwxyz0123456789.-_'                          # Valid name body characters
            $VNameElse = $VNameElse.ToCharArray()                                           # Converts $var to character array
            $VNameLast = 'abcdefghijklmnopqrstuvwxyz0123456789_'                            # Valid name last character
            $VNameLast = $VNameLast.ToCharArray()                                           # Converts $var to character array
            :SetAzureLBProbeName while ($true) {                                            # Inner loop for setting the name
                Write-Host 'Probe name rules:'                                              # Write message to screen
                Write-Host 'The name can be up to 80 characters long'                       # Write message to screen
                Write-Host 'It must begin with a word character (A-9)'                      # Write message to screen
                Write-Host 'The name may contain word characters or . - _'                  # Write message to screen
                Write-Host 'It must end with a word character (A-9) or with _'              # Write message to screen
                Write-Host ''                                                               # Write message to screen
                if ($LoadBalancerObject.Probes.Name) {                                      # If $LoadBalancerObject.Probes.Name has a value
                    Write-Host 'The following names are already in use'                     # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    foreach ($_ in $LoadBalancerObject.Probes.Name) {                       # For each item in $LoadBalancerObject.Probes.Name
                        Write-Host $_                                                       # Write message to screen
                    }                                                                       # End foreach ($_ in $LoadBalancerObject.Probes.Name)
                    Write-Host ''                                                           # Write message to screen
                }                                                                           # End if ($LoadBalancerObject.Probes.Name)
                $ProbeName = Read-Host 'Name'                                               # Operator input for the back end pool name
                $ProbeNameArray = $ProbeName.ToCharArray()                                  # Converts $var to character array
                Clear-Host                                                                  # Clears screen
                if ($ProbeName.Length -gt 80) {                                             # If $ProbeName.Length is greater than 80
                    Write-Host 'The input is to long and cannot be used'                    # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    $ProbeName = $null                                                      # Clears $var
                }                                                                           # End if ($ProbeName.Length -gt 80)
                if ($ProbeNameArray[0] -notin $VName1st) {                                  # If 0 position of $ProbeNameArray is not in $VName1st
                    Write-Host  $ProbeNameArray[-1]' is not a valid character'              # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    $ProbeName = $null                                                      # Clears $ProbeName
                }                                                                           # End if ($ProbeNameArray[0] -notin $VName1st)
                foreach ($_ in $ProbeNameArray) {                                           # For each item in $ProbeNameArray
                    if ($_ -notin $VNameElse) {                                             # If current item is not in $VNameElse
                        if ($_ -eq ' ') {                                                   # If current item equals 'space'
                            Write-Host 'Back end name cannot include any spaces'            # Write message to screen
                            Write-Host ''                                                   # Write message to screen    
                        }                                                                   # End if ($_ -eq ' ')
                        else {                                                              # If current item is not equal to 'space'    
                            Write-Host $_' is not a valid character'                        # Write message to screen
                            Write-Host ''                                                   # Write message to screen
                        }                                                                   # End else (if ($_ -eq ' '))
                        $ProbeName = $null                                                  # Clears $ProbeName
                    }                                                                       # End if ($_ -notin $ProbeNameArray)
                }                                                                           # End foreach ($_ in $LBNameArray)
                if ($ProbeNameArray[-1] -notin $VNameLast) {                                # If last position of $ProbeNameArray is not in $VNameLast
                    Write-Host  $ProbeNameArray[-1]' is not a valid character'              # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    $ProbeName = $null                                                      # Clears $ProbeName
                }                                                                           # End if ($ProbeNameArray[0] -notin $VNameLast)
                if ($ProbeName -in $LoadBalancerObject.Probes.Name) {                       # If $ProbeName is in $LoadBalancerObject.Probes.Name
                    Write-Host 'That name is already in use'                                # Write message to screen
                    Write-Host 'Please use a new name'                                      # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    $ProbeName = $null                                                      # Clears $ProbeName
                }                                                                           # End if ($ProbeName -in $LoadBalancerObject.Probes.Name) 
                if ($ProbeName) {                                                           # If $ProbeName has a value
                    Write-Host 'Use:'$ProbeName' as the back end pool name'                 # Write message to screen
                    $OpConfirm = Read-Host '[Y] Yes [N] No [E] Exit'                        # Operator confirmation of the back end pool name
                    Clear-Host                                                              # Clears screen
                    if ($OpConfirm -eq 'e') {                                               # If $OpConfirm equals 'e'
                        Break AddAzureLBProbe                                               # Breaks :AddAzureLBProbe
                    }                                                                       # End if ($OpConfirm -eq 'e')
                    elseif ($OpConfirm -eq 'y') {                                           # Else if $OpConfirm equals 'y'
                        Break SetAzureLBProbeName                                           # Breaks :SetAzureLBProbeName
                    }                                                                       # End elseif ($OpConfirm -eq 'y')
                }                                                                           # End if ($ProbeName)
                else {                                                                      # Else if $ProbeName is $null
                    Pause                                                                   # Pauses all actions for operator input
                    Clear-Host                                                              # Clears screen
                }                                                                           # End else (if ($ProbeName))
            }                                                                               # End :SetAzureLBProbeName while ($true)
            [System.Collections.ArrayList]$ProbeProtocol = @()                              # Creates array for list to be loaded into
            if ($LoadBalancerObject.Sku.Name -eq 'Basic') {                                 # If $LoadBalancerObject.Sku.Name equals 'Basic'                                  
                $ProbeProtocolInput = [PSCustomObject]@{'Protocol' = 'http';`
                    'port' = '80'}                                                          # Creates the item to loaded into array
                $ProbeProtocol.Add($ProbeProtocolInput) | Out-Null                          # Loads item into array, out-null removes write to screen
            }                                                                               # End if ($LoadBalancerObject.Sku.Name -eq 'Basic')
            else {                                                                          # Else if $LoadBalancerObject.Sku.Name does not equal 'Basic'
                :SetAzureProbeProtocol while ($true) {                                      # Inner loop for setting the probe type
                    Write-Host 'Load balanacer health probe protocol'                       # Write message to screen
                    Write-Host '[0] Exit'                                                   # Write message to screen
                    Write-Host '[1] Http (80)'                                              # Write message to screen
                    Write-host '[2] Https(443)'                                             # Write message to screen
                    Write-Host ''                                                           # Writes message to screen
                    $OpSelect = Read-Host 'Option[#]'                                       # Operator input for the probe type object
                    Clear-Host                                                              # Clears screen
                    if ($OpSelect -eq '0') {                                                # If $OpSelect equals '0'
                        Break AddAzureLBProbe                                               # Breaks :AddAzureLBProbe 
                    }                                                                       # End if ($OpSelect -eq '0')
                    elseif ($OpSelect -eq '1') {                                            # Elseif $OpSelect equals '1'
                        $ProbeProtocolInput = [PSCustomObject]@{'Protocol' = 'http';`
                            'port' = '80'}                                                  # Creates the item to loaded into array
                        $ProbeProtocol.Add($ProbeProtocolInput) | Out-Null                  # Loads item into array, out-null removes write to screen         
                        Break SetAzureProbeProtocol                                         # Breaks :SetAzureProbeProtocol 
                    }                                                                       # End elseif ($OpSelect -eq '1')
                    elseif ($OpSelect -eq '2') {                                            # Elseif $OpSelect equals '2'
                        [System.Collections.ArrayList]$ProbeProtocol = @()                  # Creates array for list to be loaded into
                        $ProbeProtocolInput = [PSCustomObject]@{'Protocol' = 'https';`
                            'port' = '443'}                                                 # Creates the item to loaded into array
                        $ProbeProtocol.Add($ProbeProtocolInput) | Out-Null                  # Loads item into array, out-null removes write to screen         
                        Break SetAzureProbeProtocol                                         # Breaks :SetAzureProbeProtocol 
                    }                                                                       # End elseif ($OpSelect -eq '2')
                    else {                                                                  # All other inputs for $OpSelect
                        Write-Host 'That was not a valid input'                             # Write message to screen
                        Write-Host ''                                                       # Write message to screen
                        Pause                                                               # Pauses all actions for operator input
                        Clear-Host                                                          # Clears screen
                    }                                                                       # End else (If $OpSelect -eq '0')
                }                                                                           # End :SetAzureProbeProtocol while ($true)
            }                                                                               # End else (if ($LBSkuObject -eq 'Basic'))
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
                        Break AddAzureLBProbe                                               # Breaks :AddAzureLBProbe
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
                $ProbeCountObject = Read-Host 'Unhealthy threshold'                         # Operator input for the probe count
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
                        Break AddAzureLBProbe                                               # Breaks :AddAzureLBProbe
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
                Add-AzLoadBalancerProbeConfig -LoadBalancer $LoadBalancerObject `
                    -Name $ProbeName -RequestPath healthcheck.aspx -Protocol `
                    $ProbeProtocol.Protocol -Port $ProbeProtocol.port `
                    -IntervalInSeconds $ProbeIntervalObject -ProbeCount $ProbeCountObject `
                    -ErrorAction 'Stop'                                                     # Creates the probe config
                Clear-Host                                                                  # Clears screen  
                Write-Host 'Saving the health probe config'                                 # Write message to screen
                $LoadBalancerObject | Set-AzLoadBalancer -ErrorAction 'Stop'                # Saves the probe config to $LoadBalancerObject
                Clear-Host                                                                  # Clears screen
            }                                                                               # End try
            Catch {                                                                         # If Try fails
                Write-Host 'An error has occured'                                           # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break AddAzureLBProbe                                                       # Breaks :AddAzureLBProbe
            }                                                                               # End catch    
            Write-Host 'Health probe config has been added'                                 # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            Pause                                                                           # Pauses all actions for operator input
            Break AddAzureLBProbe                                                           # Breaks :AddAzureLBProbe
        }                                                                                   # End :AddAzureLBProbe while ($true)                                                     
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End begin
}                                                                                           # End function AddAzLBProbeConfig
function ListAzLBProbeConfig {                                                              # Function to list all load balancer probe configs
    Begin {                                                                                 # Begin function
        :ListAzureLBProbeConfig while ($true) {                                             # Outer loop to manage function
            Write-Host 'Gathering load balancer info'                                       # Write message to screen
            Write-Host 'This may take a moment'                                             # Write message to screen
            $ObjectList = Get-AzLoadBalancer                                                # Generates the load balancer list
            if (!$ObjectList) {                                                             # If $ObjectList is $null 
                Clear-Host                                                                  # Clears screen
                Write-Host 'No load balancers are in this subscription'                     # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break ListAzureLBProbeConfig                                                 # Breaks ListAzureLBProbeConfig
            }                                                                               # End if (!$ObjectList)
            [System.Collections.ArrayList]$ObjectArray = @()                                # Creates the load balancer array
            foreach ($_ in $ObjectList) {                                                   # For each item in $ObjectList
                $LBObject = $_                                                              # Isolates the current item
                $ProbeConfigList = Get-AzLoadBalancerProbeConfig -LoadBalancer $_           # Gets a list of all probes on $LBObject
                foreach ($_ in $ProbeConfigList) {                                          # For each item in $ProbeConfigList
                    $ObjectInput = [PSCustomObject]@{                                       # Creates the item to loaded into array
                        'Name'=$_.Name;                                                     # Rule name
                        'LBName'=$LBObject.Name;                                            # Load balancer name
                        'RGName'=$LBObject.ResourceGroupName;                               # Load balancer resource group
                        'Proto'=$_.Protocol;                                                # Probe protocol
                        'Port'=$_.Port;                                                     # Probe port
                        'Int'=$_.IntervalInSeconds;                                         # Probe interval
                        'Count'=$_.NumberOfProbes;                                          # Probe count
                        'RPath'=$_.RequestPath;                                             # Request path
                        'Rule'=$_.LoadBalancingRules.ID                                     # Probe rules if any
                    }                                                                       # End $ObjectInput = [PSCustomObject]@
                    $ObjectArray.Add($ObjectInput) | Out-Null                               # Loads item into array
                }                                                                           # End foreach ($_ in $ProbeConfigList)
            }                                                                               # End foreach ($_ in $ObjectList)
            Clear-Host                                                                      # Clears screen
            if (!$ObjectArray) {                                                            # If $ObjectArray is $null    
                Write-Host 'No load balancer probe configs exist in this subscription'      # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break ListAzureLBProbeConfig                                                # Breaks :ListAzureLBProbeConfig
            }                                                                               # End if (!$ObjectArray)
            foreach ($_ in $ObjectArray) {                                                  # For each $_ in $ObjectArray
                Write-Host 'Probe Name:    '$_.Name                                         # Write message to screen
                Write-Host 'LB Name:       '$_.LBName                                       # Write message to screen
                Write-Host 'LB RG:         '$_.RGName                                       # Write message to screen
                Write-Host 'Probe Protocol:'$_.Proto                                        # Write message to screen
                Write-Host 'Probe Port:    '$_.Port                                         # Write message to screen
                Write-Host 'Probe Interval:'$_.Int                                          # Write message to screen
                Write-Host 'Probe Count:   '$_.Count                                        # Write message to screen
                if ($_.RPath) {                                                             # If current item .RPath has a value
                    Write-Host 'Probe RPath:   '$_.Rpath                                    # Write message to screen
                }                                                                           # End if ($_.RPath)
                else {                                                                      # Else if current item .RPath does not have value
                    Write-Host 'Probe RPath:    N/A'                                        # Write message to screen         
                }                                                                           # End else (if ($_.RPath))
                Write-Host 'Rule count:    '$_.Rule.Count                                   # Write message to screen
                Write-Host ''                                                               # Write message to screen         
            }                                                                               # End foreach ($_ in $ObjectArray)
            Pause                                                                           # Pauses all actions for operator input
            Break ListAzureLBProbeConfig                                                    # Breaks :ListAzureLBProbeConfig
        }                                                                                   # End :ListAzureLBProbeConfig while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function ListAzLBProbeConfig
function GetAzLBProbeConfig {                                                               # Function to get an existing load balancer probe config
    Begin {                                                                                 # Begin function
        :GetAzureLBProbeConfig while ($true) {                                              # Outer loop to manage function
            Write-Host 'Gathering load balancer info'                                       # Write message to screen
            Write-Host 'This may take a moment'                                             # Write message to screen
            $ObjectList = Get-AzLoadBalancer                                                # Generates the load balancer list
            if (!$ObjectList) {                                                             # If $ObjectList is $null 
                Clear-Host                                                                  # Clears screen
                Write-Host 'No load balancers are in this subscription'                     # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break GetAzureLBProbeConfig                                                 # Breaks GetAzureLBProbeConfig
            }                                                                               # End if (!$ObjectList)
            $ObjectNumber = 1                                                               # Sets $ObjectNumber to 1
            [System.Collections.ArrayList]$ObjectArray = @()                                # Creates the load balancer array
            foreach ($_ in $ObjectList) {                                                   # For each item in $ObjectList
                $LBObject = $_                                                              # Isolates the current item
                $ProbeConfigList = Get-AzLoadBalancerProbeConfig -LoadBalancer $_           # Gets a list of all probes on $LBObject
                foreach ($_ in $ProbeConfigList) {                                          # For each item in $ProbeConfigList
                    $ObjectInput = [PSCustomObject]@{                                       # Creates the item to loaded into array
                        'Number'=$ObjectNumber;                                             # Object number
                        'Name'=$_.Name;                                                     # Rule name
                        'LBName'=$LBObject.Name;                                            # Load balancer name
                        'RGName'=$LBObject.ResourceGroupName;                               # Load balancer resource group
                        'Proto'=$_.Protocol;                                                # Probe protocol
                        'Port'=$_.Port;                                                     # Probe port
                        'Int'=$_.IntervalInSeconds;                                         # Probe interval
                        'Count'=$_.NumberOfProbes;                                          # Probe count
                        'RPath'=$_.RequestPath;                                             # Request path
                        'Rule'=$_.LoadBalancingRules.ID                                     # Probe rules if any
                    }                                                                       # End $ObjectInput = [PSCustomObject]@
                    $ObjectArray.Add($ObjectInput) | Out-Null                               # Loads item into array
                    $ObjectNumber = $ObjectNumber + 1                                       # Increments $ObjectNumber by 1
                }                                                                           # End foreach ($_ in $ProbeConfigList)
            }                                                                               # End foreach ($_ in $ObjectList)
            Clear-Host                                                                      # Clears screen
            if (!$ObjectArray) {                                                            # If $ObjectArray is $null    
                Write-Host 'No load balancer probe configs exist in this subscription'      # Write message to screen
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
                    Write-Host 'LB Name:       '$_.LBName                                   # Write message to screen
                    Write-Host 'LB RG:         '$_.RGName                                   # Write message to screen
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
                    Write-Host 'You are selecting the back end config for:'$CallingFunction # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                }                                                                           # End if ($CallingFunction)
                $OpSelect = Read-Host 'Option [#]'                                          # Operator input to select the load balancer
                if ($OpSelect -eq '0') {                                                    # If $OpSelect equals 0
                    Break GetAzureLBProbeConfig                                             # Breaks :GetAzureLBProbeConfig
                }                                                                           # End if ($OpSelect -eq '0')
                elseif ($OpSelect -in $ObjectArray.Number) {                                # If $OpSelect in $ObjectArray.Number
                    $OpSelect = $ObjectArray | Where-Object {$_.Number -eq $OpSelect}       # $OpSelect is equal to $ObjectArray where $ObjectArray.Number equals $OpSelect
                    $LoadBalancerObject = Get-AzLoadBalancer -Name $OpSelect.LBName `
                        -ResourceGroupName $OPSelect.RGName                                 # Pulls the full load balancer object
                    $LBProbeObject = Get-AzLoadBalancerProbeConfig -LoadBalancer `
                        $LoadBalancerObject -Name $OpSelect.Name                            # Pulls the load balancer probe config object
                    Clear-Host                                                              # Clears screen
                    Return $LBProbeObject, $LoadBalancerObject                              # Returns to calling function with $vars
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
}                                                                                           # End function GetAzLBProbeConfig
# End ManageAzLBProbeConfig
# End ManageAzLBConfig
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