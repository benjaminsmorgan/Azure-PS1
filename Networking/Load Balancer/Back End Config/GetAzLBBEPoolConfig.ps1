# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Mircosoft docs links
    Get-AzLoadBalancer:                         https://docs.microsoft.com/en-us/powershell/module/az.network/get-azloadbalancer?view=azps-5.5.0 
    Get-AzLoadBalancerBackendAddressPool:       https://docs.microsoft.com/en-us/powershell/module/az.network/get-azloadbalancerbackendaddresspool?view=azps-6.1.0
    Get-AzNetworkInterface:                     https://docs.microsoft.com/en-us/powershell/module/az.network/get-aznetworkinterface?view=azps-6.1.0
    Get-AzNetworkInterfaceIpConfig:             https://docs.microsoft.com/en-us/powershell/module/az.network/get-aznetworkinterfaceipconfig?view=azps-6.1.0
    Get-AzVM:                                   https://docs.microsoft.com/en-us/powershell/module/az.compute/get-azvm?view=azps-6.1.0
} #>
<# Required Functions Links: {
    None
} #>
<# Functions Description: {
    GetAzLBBEPoolConfig:        Function to get an existing load balancer back end pool config
} #>
<# Variables: {      
    :GetAzureLBBEPoolConfig     Outer loop for managing function
    :SelectAzureLBBeConfig      Inner loop for selecting the back end address pool
    $ObjectList:                List of all load balanacers
    $ObjectNumber:              $var used for selecting and listing items
    $ObjectArray:               Array used to hold item info
    $LBObject:                  Current load balancer
    $PoolConfigList:            List of all back end pools on $LBObject
    $ObjectInput:               $var used to load info into $ObjectArray
    $Number:                    Current item .number
    $BackEndAddresses:          Current item .backendaddress
    $BackEndName:               Current back end address
    $BackEndIPCon:              $BackEndName.NetworkInterfaceIpConfiguration.ID
    $BackEndNic:                Nic where ipconfiguration.ID is $BackEndIPCon
    $BackEndConfig:             Nic IP config where ID is $BackEndIPCon
    $BackEndVM:                 VM where ID is $BackEndNic.VirtuualMachine
    $CallingFunction:           Name of the function that called this one
    $OpSelect:                  Operator input to select the back end config
    $LoadBalancerObject:        Load balancer object
    $LBBackEndObject:           Load balancer back end object
} #>
<# Process Flow {
    function
        Call GetAzLBBEPoolConfig > Get $LBBackEndObject, $LoadBalancerObject
        End GetAzLBBEPoolConfig
            Return function > Send $LBBackEndObject, $LoadBalancerObject
}#>
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