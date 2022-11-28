# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Microsoft docs links
    Get-AzVirtualNetwork:                       https://docs.microsoft.com/en-us/powershell/module/az.network/get-azvirtualnetwork?view=azps-5.4.0Get-AzVirtualNetworkSubnetConfig
    Get-AzVirtualNetworkSubnetConfig:           https://docs.microsoft.com/en-us/powershell/module/az.network/get-azvirtualnetworksubnetconfig?view=azps-5.4.0
    Get-AzNetworkInterface:                     https://docs.microsoft.com/en-us/powershell/module/az.network/get-aznetworkinterface?view=azps-5.4.0
    Get-AzPublicIpAddress:                      https://docs.microsoft.com/en-us/powershell/module/az.network/get-azpublicipaddress?view=azps-5.5.0 
    Get-AzVmss:                                 https://docs.microsoft.com/en-us/powershell/module/az.compute/get-azvmss?view=azps-6.1.0
} #>
<# Required Functions Links: {
    None
} #>
<# Functions Description: {
    ListAzNICIpConfig:          Lists all NIC IP configurations
} #>
<# Variables: {      
    :ListAzureNICIpConfig       Outer loop for managing function
    $ObjectList:                List of all NICs
    $NICName:                   Current item .Name
    $NicRG:                     Current item .ResourceGroupName
    $NicVM:                     Current item .VirtualMachine.ID
    $VMObject:                  Virtual machine object if present
    $NSGObject:                 NSG object if present
    $IPConfigList:              Current item .IPConfigurations
    $ASGName:                   Array holding all app sec group names
    $ASGID:                     Current item .ApplicationSecurityGroups.ID 
    $ASGIDSplit:                $ASGID current item split
    $ObjectArray:               Array holding all NIC IP configs 
    $ObjectInput:               $var used to load items into $ObjectArray
    $PubID:                     Current item .PubIP.ID
    $PubIP:                     IP currently used by attached public IP sku
    $VmssObject:                List of virtual machine scale sets if present
    $VmssName:                  Current item .Name
    $VmssRG:                    Current item .ResourceGroupName
} #>
<# Process Flow {
    function
        Call ListAzNICIpConfig > Get $null
        End ListAzNICIpConfig
            Return function > Send $null
}#>
function ListAzNICIpConfig {                                                                # Function to list network interface configs
    Begin {                                                                                 # Begin function
        :ListAzureNICIpConfig while ($true) {                                               # Outer loop for managing function
            [System.Collections.ArrayList]$ObjectArray = @()                                # Array that all info is loaded into
            Write-Host 'Gathering network interfaces'                                       # Write message to screen
            $ObjectList = Get-AzNetworkInterface                                            # Gets a list of all NICs
            if (!$ObjectList) {                                                             # If $ObjectList is $null
                Clear-Host                                                                  # Clears screen
                Write-Host 'No Nics are present in this subscription'                       # Write message to screen
                Write-Host ''                                                               # Write message to screen
            }                                                                               # End if (!$ObjectList)
            else {                                                                          # If $ObjectList has a value
                foreach ($_ in $ObjectList) {                                               # For each item in $ObjectList
                    $NICName = $_.Name                                                      # $NICName is equal to current item .Name
                    $NicRG = $_.ResourceGroupName                                           # Gets the NIC resource group
                    $NicVM = $_.VirtualMachine.ID                                           # Gets the NIC VM if attached
                    $NicNSG = $_.NetworkSecurityGroup.ID                                    # Gets the NIC NSG if attached
                    if ($NicVM) {                                                           # If $NicVM has a value 
                        $VMObject = Get-AzVM | Where-Object {$_.ID -eq $NICVM}              # Gets the currently attached VM
                    }                                                                       # End if ($NicVM)
                    if ($NicNSG) {                                                          # If $NicNSG has a value
                        $NSGObject = Get-AzNetworkSecurityGroup | Where-Object `
                            {$_.ID -eq $NicNSG}                                             # Gets the currently attached NSG
                    }                                                                       # End if ($NicNSG)
                    $IPConfigList = $_.IPConfigurations                                     # IPConfigList is equal to current item .IPConfigurations
                    foreach ($_ in $IPConfigList) {                                         # For each item in $IPConfigList
                        $ASGName = @()                                                      # Creates ASGName array
                        if ($_.ApplicationSecurityGroups.ID) {                              # If current item .ApplicationSecurityGroups.ID has a value
                            $ASGID = $_.ApplicationSecurityGroups.ID                        # Isolates the ASG IDs
                            foreach ($ID in $ASGID) {                                       # For each item in $ASGID
                                $ASGIDSplit = $ID                                           # ASGID is equal to current item
                                $ASGIDSplit = $ASGIDSplit.Split('/')[-1]                    # Isolates the ASG name
                                $ASGName += $ASGIDSplit                                     # Adds ASGIDSplit to $ASGName
                                $ASGIDSplit = $null                                         # Clears $var                      
                            }                                                               # End foreach ($_ in $ASGID)
                            $ASGID = $null                                                  # Clears $var
                        }                                                                   # End if ($_.ApplicationSecurityGroups.ID)          
                        $ObjectInput = [PSCustomObject]@{                                   # Creates $ObjectInput            
                            'Name'=$_.Name;                                                 # Nic IP config name
                            'PrivIP'=$_.PrivateIPAddress;                                   # Nic IP config private IP address
                            'PrivIPAllo'=$_.PrivateIpAllocationMethod;                      # Nic IP config private IP allocation method
                            'PubIP'=$_.PublicIPAddress;                                     # Nic IP config public IP address
                            'Pri'=$_.Primary;                                               # Nic IP config primary status
                            'NICName'=$NICName;                                             # Nic name
                            'NICRG'=$NicRG;                                                 # Nic RG name
                            'NICVM'=$VMObject.Name;                                         # Nic VM name
                            'NICNSG'=$NSGObject.Name;                                       # Nic NSG name
                            'NICASG'=$ASGName                                               # Nic IP config ASGs
                        }                                                                   # End $ObjectInput = [PSCustomObject]
                        $ObjectArray.Add($ObjectInput) | Out-Null                           # Loads item into array, out-null removes write to screen
                        $ASGName = $null                                                    # Clears $var
                    }                                                                       # End foreach ($_ in $IPConfigList)
                    $NICName = $null                                                        # Clears $var
                    $NicRG = $null                                                          # Clears $var
                    $NicVM = $null                                                          # Clears $var
                    $VMObject = $null                                                       # Clears $var
                    $NicNSG = $null                                                         # Clears $var
                    $NSGObject = $null                                                      # Clears $var
                }                                                                           # End foreach ($_ in $ObjectList)
            }                                                                               # End else (if (!$ObjectList))
            Write-Host 'Gathering scale set interfaces'                                     # Write message to screen
            $VmssObject = Get-AzVmss                                                        # Gets a list of Vmss objects if present
            if ($VmssObject) {                                                              # If $VmssObject has a value
                foreach ($_ in $VmssObject) {                                               # For each item in $VmssObject
                    Write-Host 'Gathering NICs on:'$_.name                                  # Writ message to screen
                    $VmssName = $_.name                                                     # Isloates the Vmss name
                    $VmssRG = $_.ResourceGroupName                                          # Isolates the Vmss resource group
                    $NicList = Get-AzNetworkInterface -VirtualMachineScaleSetName `
                        $VmssName -ResourceGroupName $VmssRG                                # Gets a list of nics attached to current vmss object
                    foreach ($_ in $NicList) {                                              # For each item in $NicList
                        $NicName = $_.Name                                                  # $NicName is equal to current item .Name
                        $NicRG = $_.ResourceGroupName                                       # $NicRG is equal to current item .ResourceGroupName
                        $NicNSG = $_.NetworkSecurityGroup.ID                                # Gets the NIC NSG if attached
                        if ($NicNSG) {                                                      # If $NicNSG has a value
                            $NSGObject = Get-AzNetworkSecurityGroup | Where-Object `
                                {$_.ID -eq $NicNSG}                                         # Gets the currently attached NSG
                        }                                                                   # End if ($NicNSG)    
                        $IPConfigList = $_.IPConfigurations                                 # IPConfigList is equal to current item .IPConfigurations
                        foreach ($_ in $IPConfigList) {                                     # For each item in $IPConfigList
                            $ASGName = @()                                                  # Creates ASGName array
                            if ($_.ApplicationSecurityGroups.ID) {                          # If current item .ApplicationSecurityGroups.ID has a value
                                $ASGID = $_.ApplicationSecurityGroups.ID                    # Isolates the ASG IDs
                                foreach ($ID in $ASGID) {                                   # For each item in $ASGID
                                    $ASGIDSplit = $ID                                       # ASGID is equal to current item
                                    $ASGIDSplit = $ASGIDSplit.Split('/')[-1]                # Isolates the ASG name
                                    $ASGName += $ASGIDSplit                                 # Adds ASGIDSplit to $ASGName
                                    $ASGIDSplit = $null                                     # Clears $var                      
                                }                                                           # End foreach ($_ in $ASGID)
                                $ASGID = $null                                              # Clears $var
                            }                                                               # End if ($_.ApplicationSecurityGroups.ID) 
                            $ObjectInput = [PSCustomObject]@{                               # Creates $ObjectInput            
                                'Name'=$_.Name;                                             # Nic IP config name
                                'PrivIP'=$_.PrivateIPAddress;                               # Nic IP config private IP address
                                'PrivIPAllo'=$_.PrivateIpAllocationMethod;                  # Nic IP config private allocation method
                                'PubIP'=$_.PublicIPAddress;                                 # Nic IP config public IP
                                'Pri'=$_.Primary;                                           # Nic IP config primary status
                                'NICName'=$NICName;                                         # Nic name
                                'NICRG'=$NicRG;                                             # Nic rg name
                                'Type'='ScaleSetNic';                                       # Nic IP config type
                                'VmssName'=$VmssName;                                       # Vmss Name
                                'VmssRG'=$VmssRG;                                           # Vmss RG
                                'Etag'=$_.Etag;                                             # Nic IP config Etag
                                'NICNSG'=$NSGObject.Name;                                   # Nic NSG name
                                'NICASG'=$ASGName                                           # Nic IP config ASGs
                            }                                                               # End $ObjectInput = [PSCustomObject]
                            $ObjectArray.Add($ObjectInput) | Out-Null                       # Loads item into array, out-null removes write to screen
                            $ASGName = $null                                                # Clears $var
                        }                                                                   # End foreach ($_ in $IPConfigList)
                        $NicName = $null                                                    # Clears $var
                        $NicRG = $null                                                      # Clears $var
                        $NicNSG = $null                                                     # Clears $var
                    }                                                                       # End foreach ($_ in $NicList)
                }                                                                           # End foreach ($_ in $VmssObject)
            }                                                                               # End if ($VmssObject)
            else {                                                                          # If $VmssObject is $null
                Clear-Host 'No scale sets present in this subscription'                     # Write message to screen
            }                                                                               # End else (if ($VmssObject))
            if (!$ObjectArray) {                                                            # If $ObjectArray is $null
                Clear-Host                                                                  # Clears screen
                Write-Host 'No network interfaces or scale set interfaces are present'      # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break ListAzureNICIpConfig                                                  # Breaks :ListAzureNICIpConfig
            }                                                                               # End if (!$ObjectArray)
            Clear-Host                                                                      # Clears screen
            Write-Host ''                                                                   # Write message to screen
            foreach ($_ in $ObjectArray) {                                                  # For each item in $ObjectArray
                Write-Host 'Config Name:          '$_.Name                                  # Write message to screen
                Write-Host 'Private IP Address:   '$_.PrivIP                                # Write message to screen 
                Write-Host 'Private IP Allocation:'$_.PrivIPAllo                            # Write message to screen
                if ($_.PubIP) {                                                             # If current item .PubIP has a value
                    $PubID = $_.PubIP.ID                                                    # Isolates the public IP sku ID
                    $PubIP = Get-AzPublicIpAddress | Where-Object {$_.ID -eq $PubID}        # Gets the public IP sku
                    Write-Host 'Public IP Address:    '$PubIP.IpAddress                     # Write message to screen
                    Write-Host 'Public IP Allocation: '$PubIP.PublicIpAllocationMethod      # Write message to screen
                }                                                                           # End if ($_.PubIP)
                Write-Host 'Is primary:           '$_.Pri                                   # Write message to screen
                Write-Host 'Nic Name:             '$_.NicName                               # Write message to screen
                if ($_.NICVM) {                                                             # If current item .NICVM has a value
                    Write-Host 'Attached VM:          '$_.NicVM                             # Write message to screen
                }                                                                           # End if ($_.NICVM)
                if ($_.NicNSG) {                                                            # If current item .NicNSG has a value
                    Write-Host 'Attached NSG:         '$_.NicNSG                            # Write message to screen
                }                                                                           # End if ($_.NicNSG)
                else {                                                                      # Else if current item .NicNSG is $null
                    Write-Host 'Attached NSG:          N/A'                                 # Write message to screen
                }                                                                           # End else (if ($_.NicNSG))
                if ($_.NICASG) {                                                            # If current item .NICASG has a value
                    Write-Host 'App Security Groups:  '$_.NicASG                            # Write message to screen
                }                                                                           # End if ($_.NICASG)
                else {                                                                      # Else if current item .NICASG is $null
                    Write-Host 'App Security Groups:   N/A'                                 # Write message to screen
                }                                                                           # End else (if ($_.NICASG))
                Write-Host ''                                                               # Write message to screen
            }                                                                               # End foreach ($_ in $ObjectArray)
            Pause                                                                           # Pauses all actions for operator input
            Break ListAzureNICIpConfig                                                      # Breaks :ListAzureNICIpConfig
        }                                                                                   # End :ListAzureNICIpConfig while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function ListAzNICIpConfig