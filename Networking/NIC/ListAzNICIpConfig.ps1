# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Mircosoft docs links
    Get-AzVirtualNetwork:       https://docs.microsoft.com/en-us/powershell/module/az.network/get-azvirtualnetwork?view=azps-5.4.0Get-AzVirtualNetworkSubnetConfig
    Get-AzVirtualNetworkSubnetConfig: https://docs.microsoft.com/en-us/powershell/module/az.network/get-azvirtualnetworksubnetconfig?view=azps-5.4.0
    Get-AzNetworkInterface:     https://docs.microsoft.com/en-us/powershell/module/az.network/get-aznetworkinterface?view=azps-5.4.0
    Get-AzPublicIpAddress:      https://docs.microsoft.com/en-us/powershell/module/az.network/get-azpublicipaddress?view=azps-5.5.0 
} #>
<# Required Functions Links: {
    None
} #>
<# Functions Description: {
    ListAzNICIpConfig:          Lists all NIC IP configurations
} #>
<# Variables: {      
    :ListAzureNICIpConfig       Outer loop for managing function
    $VNetList:                  List of all virtual networks
    $CurrentVNet:               Current Vnet
    $SubnetList                 List of all subnets under $CurrentVnet
    $CurrentSubnet              Current Subnet
    $NicList                    List of all NICs attached to $CurrentSubnet
    $CurrentNic                 Current NIC
    $NicIPList                  List of all IP configs on $CurrentNic
    $NicCon                     Current IP config
    $PubIP                      Attached public IP Sku if attached to $NicCon
} #>
<# Process Flow {
    function
        Call ListAzNICIpConfig > Get $null
        End ListAzNICIpConfig
            Return function > Send $null
}#>
function ListAzNICIpConfig {                                                                # Function to list NIC IP configs
    Begin {                                                                                 # Begin function
        :ListAzureNICIpConfig while($true) {                                                # Outer loop for managing function
            $VNetList = Get-AzVirtualNetwork                                                # Gets lists of all Vnets
            if (!$VNetList) {                                                               # If $VNetList is $null
                Write-Host 'No virtual networks exist in this subscription'                 # Write message to screen
                Pause                                                                       # Pauses all action for operator input
                Break ListAzureNICIpConfig                                                  # Breaks :ListAzureNICIpConfig
            }                                                                               # End if (!$VNetList)
            foreach ($_ in $VNetList) {                                                     # For each item in $var
                $CurrentVNet = $_                                                           # Pulls current object into $var
                Write-Host 'Vnet Name:     '$CurrentVNet.Name                               # Write message to screen
                Write-Host 'Vnet Prefix:   '$CurrentVnet.AddressSpace.AddressPrefixes       # Write message to screen
                Write-Host ''                                                               # Write message to screen
                $SubnetList = Get-AzVirtualNetworkSubnetConfig -VirtualNetwork `
                    $CurrentVNet                                                            # Gets a list of all subnets in Vnet
                if (!$SubnetList) {                                                         # If $SubnetList is $null
                    Write-Host 'No subnets exist in this virtual network'                   # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                }                                                                           # End if (!$SubnetList)
                foreach ($_ in $SubnetList) {                                               # For each item in $var
                    $CurrentSubnet = $_                                                     # Pulls current object into $var
                    Write-Host 'Sub Name:      '$CurrentSubnet.name                        # Write message to screen
                    Write-Host 'Sub Prefix:    '$CurrentSubnet.AddressPrefix               # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    $NicList = Get-AzNetworkInterface | Where-Object `
                        {$_.IpConfigurations.Subnet.ID -eq $CurrentSubnet.ID}               # Gets a list of all nics attached to subnet
                    if (!$NicList) {                                                        # If $NicList is $null
                        Write-Host 'No NICs exist in this subnet'                           # Write message to screen
                        Write-Host ''                                                       # Write message to screen
                    }                                                                       # End if (!$NicList)
                    foreach ($_ in $NicList) {                                              # For each item in $var
                        $CurrentNic = $_                                                    # Pulls current object into $var
                        Write-Host 'Nic Name:      '$CurrentNic.Name                        # Write message to screen
                        Write-Host ''                                                       # Write message to screen
                        $NicIPList = $CurrentNic.IPConfigurations                           # Gets a list of all IP configs on Nic
                        foreach ($_ in $NicIPList) {                                        # For each item in $var
                            $NicCon = $_                                                    # Pulls current object into $var
                            if ($NicCon.PublicIPaddress.ID) {                               # If a public IP sku is attached
                                $PubIP = Get-AzPublicIpAddress | Where-Object `
                                    {$_.ID -eq $NicCon.PublicIPaddress.ID}                  # Pulls the public IP sku info
                            }                                                               # End if ($NicCon.PublicIPaddress.ID)
                            Write-Host 'Config Name:   '$NicCon.Name                        # Write message to screen
                            Write-Host 'Is Primary:    '$NicCon.Primary                     # Write message to screen
                            Write-Host 'PrivIPAddress: '$NicCon.PrivateIPAddress            # Write message to screen
                            Write-Host 'PrivAllocation:'$NicCon.PrivateIpAllocationMethod   # Write message to screen
                            if ($PubIP) {
                                Write-Host 'PubIPName:     '$PubIP.Name                     # Write message to screen
                                Write-Host 'PubIPAddress:  '$PubIP.IpAddress                # Write message to screen
                                Write-Host 'PubAllocation: '$PubIP.PublicIpAllocationMethod # Write message to screen
                                $PubIP = $null                                              # Clears $PubIP
                            }                                                               # End if ($PubIP) 
                            Write-Host ''                                                   # Write message to screen
                        }                                                                   # End foreach ($_ in $NicIPList)
                        Write-Host ''                                                       # Write message to screen
                    }                                                                       # End foreach ($_ in $NicList)
                    Write-Host ''                                                           # Write message to screen
                }                                                                           # End foreach ($_ in $SubnetList)
                Write-Host ''                                                               # Write message to screen
            }                                                                               # End foreach ($_ in $VNetList)
            Pause                                                                           # Pauses all actions for operator input
            Break ListAzureNICIpConfig                                                      # Breaks :ListAzureNICIpConfig
        }                                                                                   # End :ListAzureNICIpConfig while($true)
        Clear-Host                                                                          # Clears screen
        Return                                                                              # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function ListAzNICIpConfig