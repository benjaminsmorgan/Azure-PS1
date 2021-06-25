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
function ManageAzLBNatRuleConfig {                                                          # Function to manage nat rule configurations
    Begin {                                                                                 # Begin function
        :ManageAzureLBNatRuleConfig while ($true) {                                         # Outer loop for managing function
            Write-Host 'Manage Load Balancer Nat Rules'                                     # Write message to screen
            Write-Host '[0] Exit'                                                           # Write message to screen
            Write-Host '[1] Add Nat Rule Config'                                            # Write message to screen
            Write-Host '[2] List Nat Rule Configs'                                          # Write message to screen
            Write-Host '[3] Change Nat Rule Config'                                         # Write message to screen
            Write-Host '[4] Remove Nat Rule Config'                                         # Write message to screen
            $OpSelect = Read-Host 'Option [#]'                                              # Operator input for the function selection
            Clear-Host                                                                      # Clears screen
            if ($OpSelect -eq '0') {                                                        # If $OpSelect equals '0'    
                Break ManageAzureLBNatRuleConfig                                            # Breaks :ManageAzureLBNatRuleConfig
            }                                                                               # End if ($OpSelect -eq '0')
            elseif ($OpSelect -eq '1') {                                                    # Else if $OpSelect equals '1'
                Write-Host 'Add Nat Rule Config'                                            # Write message to screen
                #AddAzLBFEPrivateConfig                                                      # Calls function
            }                                                                               # End elseif ($OpSelect -eq '1')
            elseif ($OpSelect -eq '2') {                                                    # Else if $OpSelect equals '2'
                Write-Host 'List Nat Rule Configs'                                          # Write message to screen
                ListAzLBNatRuleConfig                                                       # Calls function
            }                                                                               # End elseif ($OpSelect -eq '2')
            elseif ($OpSelect -eq '3') {                                                    # Else if $OpSelect equals '3'
                Write-Host 'Change Nat Rule Config'                                         # Write message to screen
                #ListAzLBFEConfigs                                                           # Calls function
            }                                                                               # End elseif ($OpSelect -eq '3')
            elseif ($OpSelect -eq '4') {                                                    # Else if $OpSelect equals '4'
                Write-Host 'Remove Nat Rule Config'                                         # Write message to screen
                RemoveAzLBNatRuleConfig                                                     # Calls function
            }                                                                               # End elseif ($OpSelect -eq '4')
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
                        }                                                                   # End if ($_.BackendIpConfiguration.ID) 
                        $ObjectList = [PSCustomObject]@{                                    # Var used to load items into $ObjectArray
                            'Name'=$_.Name;'Proto'=$_.Protocol;`
                            'LBName'=$LoadBalancerObject.Name;`
                            'FEPort'=$_.FrontendPort;'BEPort'=$_.BackEndPort;`
                            'Idle'=$_.IdleTimeoutInMinutes;'FEName'=$FrontEnd.Name;`
                            'FEPriIP'=$FrontEnd.PrivateIpAddress;`
                            'FEPriAll'=$FrontEnd.PrivateIpAllocationMethod;`
                            'FESub'=$FrontEndSub;`
                            'FEPubIPName'=$FEPublicIPObject.Name;`
                            'FEPubIPAdd'=$FEPublicIPObject.IpAddress;`
                            'FEPubIPAll'=$FEPublicIPObject.PublicIpAllocationMethod;`
                            'BEPriIP'=$BackEndConfig.PrivateIpAddress;`
                            'BEPriIPAll'=$BackEndConfig.PrivateIpAllocationMethod;`
                            'BESub'=$BackEndSub                                             # Assoicates the items to $ObjectList         
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
                        }                                                                   # End if ($_.BackendIpConfiguration.ID) 
                        $ObjectList = [PSCustomObject]@{                                    # Var used to load items into $ObjectArray
                            'Number'=$ObjectNumber;'Name'=$_.Name;'Proto'=$_.Protocol;`
                            'LBName'=$LoadBalancerObject.Name;`
                            'FEPort'=$_.FrontendPort;'BEPort'=$_.BackEndPort;`
                            'Idle'=$_.IdleTimeoutInMinutes;'FEName'=$FrontEnd.Name;`
                            'FEPriIP'=$FrontEnd.PrivateIpAddress;`
                            'FEPriAll'=$FrontEnd.PrivateIpAllocationMethod;`
                            'FESub'=$FrontEndSub;`
                            'FEPubIPName'=$FEPublicIPObject.Name;`
                            'FEPubIPAdd'=$FEPublicIPObject.IpAddress;`
                            'FEPubIPAll'=$FEPublicIPObject.PublicIpAllocationMethod;`
                            'BEPriIP'=$BackEndConfig.PrivateIpAddress;`
                            'BEPriIPAll'=$BackEndConfig.PrivateIpAllocationMethod;`
                            'BESub'=$BackEndSub                                             # Assoicates the items to $ObjectList         
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
Function RemoveAzLBNatRuleConfig {                                                          # Function to remove a load balancer nat rule configuration
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