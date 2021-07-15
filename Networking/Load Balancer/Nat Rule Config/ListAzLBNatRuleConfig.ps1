# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Mircosoft docs links
    Get-AzLoadBalancerInboundNatRuleConfig:     https://docs.microsoft.com/en-us/powershell/module/az.network/get-azloadbalancerinboundnatruleconfig?view=azps-6.1.0
    Get-AzLoadBalancer:                         https://docs.microsoft.com/en-us/powershell/module/az.network/gew-azloadbalancer?view=azps-5.5.0  
    Get-AzPublicIpAddress:                      https://docs.microsoft.com/en-us/powershell/module/az.network/get-azpublicipaddress?view=azps-5.5.0
    Get-AzLoadBalancerFrontendIpConfig:         https://docs.microsoft.com/en-us/powershell/module/az.network/get-azloadbalancerfrontendipconfig?view=azps-6.1.0
    Get-AzNetworkInterface:                     https://docs.microsoft.com/en-us/powershell/module/az.network/get-aznetworkinterface?view=azps-6.1.0
    Get-AzNetworkInterfaceIpConfig:             https://docs.microsoft.com/en-us/powershell/module/az.network/get-aznetworkinterfaceipconfig?view=azps-6.1.0
    Get-AzVM:                                   https://docs.microsoft.com/en-us/powershell/module/az.compute/get-azvm?view=azps-6.2.0
} #>
<# Required Functions Links: {
    None
} #>
<# Functions Description: {
    ListAzLBNatRuleConfig:      Function for listing load balancer nat rules
} #>
<# Variables: {      
    :ListAzureLBNatRule         Outer loop for managing function
    $LBList:                    List of all load balancers
    $LoadBalancerObject:        Current $LBList object
    $ObjectArray:               Array used to list and select nat rule
    $LBRuleList:                List of all nat rules on current load balancer
    $FrontEndID:                Current rule load balancer front end ID
    $FrontEnd:                  Current rule load balancer front end
    $FrontEndSub:               Current rule load balancer front end subnet
    $PubIPID:                   Current rule load balancer front end public IP ID
    $FEPublicIPObject:          Current rule load balancer front end public IP object
    $BackEndID:                 Current rule load balancer back end ID
    $BackEndNic:                Current rule load balancer back end nic object
    $BackEndConfig:             Current rule load balancer back end nic IP config object
    $BackEndSub:                Current rule load balancer back end nic IP config subnet
    $VMObject:                  Current rule load balancer target VM
} #>
<# Process Flow {
    function
        Call ListAzLBNatRuleConfig > Get $null
        End ListAzLBNatRuleConfig
            Return function > Send $null
}#>
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
                            'ETCPR'=$_.EnableTCPReset;                                      # Nat rule TCP reset setting
                            'EFIP'=$_.EnableFloatingIP;                                     # Nat rule floating IP setting
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
                Write-Host 'TCP Reset:     '$_.ETCPR                                        # Write message to screen
                Write-Host 'Floating IP:   '$_.EFIP                                         # Write message to screen
                Write-Host ''                                                               # Write message to screen
            }                                                                               # End foreach ($_ in $ObjectArray)
            Pause                                                                           # Pauses all actions for operator input
            Break ListAzureLBNatRule                                                        # Breaks :ListAzureLBNatRule
        }                                                                                   # End :ListAzureLBNatRule while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function ListAzLBNatRuleConfig