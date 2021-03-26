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
    $CurrentNicIPConfig         Current IP config
    $CurrentPubIP               Attached public IP Sku if attached to $CurrentNicIPConfig
} #>
<# Process Flow {
    function
        Call ListAzNICIpConfig > Get $NicObject
        End ListAzNICIpConfig
            Return function > Send $NicObject
}#>
function ListAzNICIpConfig {                                                                # Function to list NIC IP configs
    Begin {                                                                                 # Begin function
        :ListAzureNICIpConfig while($true) {                                                # Outer loop for managing function
            $VNetList = Get-AzVirtualNetwork                                                # Gets lists of all Vnets
            foreach ($_ in $VNetList) {                                                     # For each item in $var
                $CurrentVNet = $_                                                           # Pulls current object into $var
                Write-Host 'Vnet Name:     '$CurrentVNet.Name                               # Write message to screen
                Write-Host 'Vnet Prefix:   '$CurrentVnet.AddressSpace.AddressPrefixes       # Write message to screen
                $SubnetList = Get-AzVirtualNetworkSubnetConfig -VirtualNetwork `
                    $CurrentVNet                                                            # Gets a list of all subnets in Vnet
                foreach ($_ in $SubnetList) {                                               # For each item in $var
                    $CurrentSubnet = $_                                                     # Pulls current object into $var
                    Write-Host ' Sub Name:      '$CurrentSubnet.name                        # Write message to screen
                    Write-Host ' Sub Prefix:    '$CurrentSubnet.AddressPrefix               # Write message to screen
                    $NicList = Get-AzNetworkInterface | Where-Object `
                        {$_.IpConfigurations.Subnet.ID -eq $CurrentSubnet.ID}               # Gets a list of all nics attached to subnet
                    foreach ($_ in $NicList) {                                              # For each item in $var
                        $CurrentNic = $_                                                    # Pulls current object into $var
                        Write-Host '   Nic Name:      '$CurrentNic.Name                     # Write message to screen
                        $NicIPList = $CurrentNic.IPConfigurations                           # Gets a list of all IP configs on Nic
                        foreach ($_ in $NicIPList) {                                        # For each item in $var
                            $CurrentNicIPConfig = $_                                        # Pulls current object into $var
                            if ($CurrentNicIPConfig.PublicIPaddress.ID) {                   # If a public IP sku is attached
                                $CurrentPubIP = Get-AzPublicIpAddress | Where-Object `
                                    {$_.ID -eq $CurrentNicIPConfig.PublicIPaddress.ID}      # Pulls the public IP sku info
                            }                                                               # End if ($CurrentNicIPConfig.PublicIPaddress.ID)
                            Write-Host '    Config Name:   '$CurrentNicIPConfig.Name        # Write message to screen
                            Write-Host '    Is Primary:    '$CurrentNicIPConfig.Primary     # Write message to screen
                            Write-Host '    PrivIPAddress: '`
                                $CurrentNicIPConfig.PrivateIPAddress                        # Write message to screen
                            Write-Host '    PrivAllocation:'`
                                $CurrentNicIPConfig.PrivateIpAllocationMethod               # Write message to screen
                            if ($CurrentPubIP) {
                                Write-Host '    PubIPName:     '$CurrentPubIP.Name          # Write message to screen
                                Write-Host '    PubIPAddress:  '$CurrentPubIP.IpAddress     # Write message to screen
                                Write-Host '    PubAllocation: '`
                                    $CurrentPubIP.PublicIpAllocationMethod                  # Write message to screen
                            }                                                               # End if ($CurrentPubIP) 
                            $CurrentPubIP = $null                                           # Clears $var
                        }                                                                   # End foreach ($_ in $NicIPList)
                    }                                                                       # End foreach ($_ in $NicList)
                }                                                                           # End foreach ($_ in $SubnetList)
                Write-Host ''                                                               # Write message to screen (Splits the text by Vnets)
            }                                                                               # End foreach ($_ in $VNetList)
            Break ListAzureNICIpConfig                                                      # Breaks :ListAzureNICIpConfig
        }                                                                                   # End :ListAzureNICIpConfig while($true)
        Return                                                                              # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function ListAzNICIpConfig