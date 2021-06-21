# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Mircosoft docs links
    Get-AzNetworkInterface:                     https://docs.microsoft.com/en-us/powershell/module/az.network/get-aznetworkinterface?view=azps-5.4.0
    Get-AzVirtualNetworkSubnetConfig:           https://docs.microsoft.com/en-us/powershell/module/az.network/get-azvirtualnetworksubnetconfig?view=azps-5.4.0
    Get-AzVirtualNetwork:                       https://docs.microsoft.com/en-us/powershell/module/az.network/get-azvirtualnetwork?view=azps-5.4.0
    Get-AzVmss:                                 https://docs.microsoft.com/en-us/powershell/module/az.compute/get-azvmss?view=azps-6.1.0
} #>
<# Required Functions Links: {
    None
} #>
<# Functions Description: {
    ListAzNetworkInterface:     Lists network interfaces
} #>
<# Variables: {
    :ListAzureNic               Outer loop for managing function
    $VNetList:                  List of all Vnets
    $ObjectArray:               Array used to hold info for nic identification
    $Vnet:                      The current Vnet name (ListAzureNic)
    $VnetPFX:                   The current Vnet prefix
    $VnetRG:                    The current Vnet resource group
    $SubnetList:                List of all subnets under the current Vnet
    $Subnet:                    The current subnet ID
    $SubnetName:                The current subnet name 
    $SubnetPFX:                 The current subnet prefix
    $NicList:                   List of all nics under the current subnet
    $ObjectInput:               $var used to load info into $ObjectArray
    $VM:                        Current item .VM, used for formatting
    $VmssObject:                List of Vmss objects if present
    $VmssName:                  Current item .Name
    $VmssRG:                    Current item .ResourceGroupName
} #>
<# Process Flow {
    Function
        Call ListAzNetworkInterface > Get $null
        End ListAzNetworkInterface
            Return function > Send $null
}#>
function ListAzNetworkInterface {                                                           # function to list all network interfaces
    Begin {                                                                                 # Begin function
        :ListAzureNIC while ($true) {                                                       # Outer loop for managing function
            Write-Host 'Gathering network info, this a take a moment'                       # Write message to screen
            $VNetList = Get-AzVirtualNetwork                                                # Gets a list of all virtual networks
            if (!$VNetList) {                                                               # If $VNetList is $null
                Write-Host 'No virtual networks present in this subscription'               # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break GetAzureNIC                                                           # Breaks :GetAzureNIC
            }                                                                               # End if (!$VNetList)
            Clear-Host                                                                      # Clears screen
            [System.Collections.ArrayList]$ObjectArray = @()                                # Array that all info is loaded into
            foreach ($_ in $VNetList) {                                                     # For each object in $VnetList
                $VNet = $_.Name                                                             # Sets $Vnet as the current object Vnet name
                $VnetPFX = $_.AddressSpace.AddressPrefixes                                  # Sets $VnetPFX as the current object Vnet prefix
                $VNetRG = $_.ResourceGroupName                                              # Sets $VnetRG as the current object Vnet resource group
                Write-Host 'Gathering subnets in:'$VNet' | '$VNet                           # Write message to screen
                $SubnetList = Get-AzVirtualNetworkSubnetConfig -VirtualNetwork $_           # Creates a list of subnets on the current object vnet
                foreach ($_ in $SubnetList) {                                               # For each item in $SubnetList
                    $Subnet = $_.ID                                                         # $Subnet equals $currentitem.ID
                    $SubnetName = $_.Name                                                   # Pulls $CurrentItem.Name into $var
                    $SubnetPFX = $_.AddressPrefix                                           # Pulls $CurrentItem.AddressPrefix nto $var
                    Write-Host 'Gathering NICs in:'$SubnetName                              # Write message to screen
                    $NicList = Get-AzNetworkInterface | Where-Object `
                        {$_.IpConfigurations.Subnet.ID -eq $Subnet}                         # Gets a list of all nics on subnet
                    foreach ($_ in $NicList) {                                              # For each item in $NicList
                        $ObjectInput = [PSCustomObject]@{
                            'NicName'=$_.Name;'NicRG'=$_.ResourceGroupName;`
                            'SubName'=$Subnetname;'SubPFX'=$SubnetPFX;`
                            'VNetName'=$VNet;'VnetPFX'=$VnetPFX;'VnetRG'= $VNetRG;`
                            'VM'=$_.VirtualMachine.ID;'IPCon'=$_.IpConfigurations;`
                            'Type'='NIC'
                        }                                                                   # Creates the item to loaded into array
                        $ObjectArray.Add($ObjectInput) | Out-Null                           # Loads item into array, out-null removes write to screen
                    }                                                                       # End foreach ($_ in $NicList)
                }                                                                           # End foreach ($_ in $SubnetList)
            }                                                                               # End foreach ($_ in $VnetList)
            Write-Host 'Checking for virtual machine scale sets'                            # Write message to screen
            $VmssObject = Get-AzVmss                                                        # Gets a list of Vmss objects if present
            if ($VmssObject) {                                                              # If $VmssObject has a value
                Write-Host 'Gathering scale set instance interfaces'                        # Write message to screen
                foreach ($_ in $VmssObject) {                                               # For each item in $VmssObject
                    Write-Host 'Gathering NICs on:'$_.name                                  # Writ message to screen
                    $VmssName = $_.name                                                     # Isloates the Vmss name
                    $VmssRG = $_.ResourceGroupName                                          # Isolates the Vmss resource group
                    $NicList = Get-AzNetworkInterface -VirtualMachineScaleSetName `
                        $VmssName -ResourceGroupName $VmssRG                                # Gets a list of nics attached to current vmss object
                    foreach ($_ in $NicList) {                                              # For each item in $NicList
                        $SubnetID = $_.IpConfigurations.Subnet.ID                           # Isolates the subnet
                        $VnetName = $SubnetID.Split('/')[8]                                 # Isolates the Vnet name
                        $Vnet = Get-AzVirtualNetwork -Name $VnetName                        # Gets the virtual network
                        $VnetName = $Vnet.name                                              # Isolates the vnet name
                        $VnetPFX = $Vnet.AddressSpace.AddressPrefixes                       # Isolates the vnet prefix
                        $VNetRG = $Vnet.ResourceGroupName                                   # Isolates the vnet resource group
                        $Subnet = Get-AzVirtualNetworkSubnetConfig -VirtualNetwork $Vnet `
                            | Where-Object {$_.ID -eq $SubnetID}                            # Gets the subnet
                        $SubnetName = $Subnet.Name                                          # Isolates the subnet name
                        $SubnetPFX = $Subnet.AddressPrefix                                  # Isolates the subnet addressPrefix         
                        $ObjectInput = [PSCustomObject]@{
                            'NicName'=$_.Name;'NicRG'=$_.ResourceGroupName;`
                            'SubName'=$Subnetname;'SubPFX'=$SubnetPFX;`
                            'VNetName'=$VNetname;'VnetPFX'=$VnetPFX;'VnetRG'= $VNetRG;`
                            'VM'=$_.VirtualMachine.ID;'IPCon'=$_.IpConfigurations;`
                            'Type'='Scaleset';'VmssName'=$VmssName;'VmssRg'=$VmssRG
                        }                                                                   # Creates the item to loaded into array
                        $ObjectArray.Add($ObjectInput) | Out-Null                           # Loads item into array, out-null removes write to screen
                    }                                                                       # End foreach ($_ in $NicList)
                }                                                                           # End foreach ($_ in $VmssObject)
            }                                                                               # End if ($VmssObject)
            Clear-Host                                                                      # Clears screen
            if (!$ObjectArray) {                                                            # If $ObjectArray is $null
                Write-Host 'No network interfaces present in this subscription'             # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break ListAzureNIC                                                          # Breaks :ListAzureNIC
            }                                                                               # End if (!$ObjectArray)
            Write-Host ''                                                                   # Write message to screen
            foreach ($_ in $ObjectArray) {                                                  # For each item in $ObjectArray
                Write-Host 'Nic Name:       '$_.NicName                                     # Write message to screen
                foreach ($IP in $_.IPCon) {                                                 # For each item in .IPCon
                    Write-Host 'IP Config Name: '$IP.Name                                   # Write message to screen
                    Write-Host 'Private Address:'$IP.PrivateIpAddress                       # Write message to screen
                    if ($IP.publicIPAddress) {                                              # If current item .PublicAddres has a value
                        $PubID = $IP.publicIPAddress.ID                                     # Isolates the public IP sku ID
                        $PubIP = Get-AzPublicIpAddress | Where-Object `
                            {$_.ID -eq $PubID}                                              # Gets the public IP sku
                        Write-Host 'Public Address: '$PubIP.IpAddress                       # Write message to screen
                    }                                                                       # End if ($IP.PublicAddress)
                }                                                                           # End foreach ($IP in $_.IPCon)
                Write-Host 'NIC RG:         '$_.NicRG                                       # Write message to screen
                Write-Host 'Subnet Name:    '$_.Subname                                     # Write message to screen
                Write-Host 'Subnet Prefix:  '$_.SubPFX                                      # Write message to screen
                Write-Host 'VNet Name:      '$_.VnetName                                    # Write message to screen
                Write-Host 'VNet Prefix:    '$_.VnetPFX                                     # Write message to screen
                Write-Host 'VNet RG:        '$_.VnetRG                                      # Write message to screen
                if ($_.VM) {                                                                # If $_.VM has a value
                    $VM = $_.VM                                                             # VM is equal to current item .VM
                    if ($VM -like '*virtualMachineScaleSets*') {                            # If $VM is like '*virtualMachineScaleSets*'
                        $Vmss = $VM.Split('/')[-3]                                          # Collects the Vmss name
                        $VM = $VM.Split('/')[-1]                                            # Collects the instance name
                        $VM = $Vmss+'/virtualMachines/'+$VM                                 # Combines the Vmss name and the instance name
                    }                                                                       # End if ($VM -like '*virtualMachineScaleSets*')
                    else {                                                                  # Else If $VM is not like '*virtualMachineScaleSets*'
                        $VM = $VM.Split('/')[-1]                                            # Collects the VM name
                    }                                                                       # End else (if ($VM -like '*virtualMachineScaleSets*'))
                    Write-Host 'Attached VM:    '$VM                                        # Write message to screen
                    $VM = $null                                                             # Clears $VM                                            
                }                                                                           # End if ($_.VM)
                else {                                                                      # If $_.VM does not have a value
                    Write-Host 'Attached VM:     N/A'                                       # Write message to screen
                }                                                                           # End else (if ($_.VM))
                Write-Host ''                                                               # Write message to screen
            }                                                                               # End foreach ($_ in $ObjectArray)
            Pause                                                                           # Pauses all actions for operator input
            Break ListAzureNIC                                                              # Breaks :ListAzureNIC
        }                                                                                   # End :ListAzureNIC while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function ListAzNetworkInterface