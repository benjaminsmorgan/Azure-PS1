function RemoveAzNSGNIC {                                                                   # Function to add a NSG to NIC
    Begin {                                                                                 # Begin function
        if ($CallingFunction) {                                                             # If $CallingFunction is $null
            $CallingFunction = 'RemoveAzNSGNIC'                                             # Creates $CallingFunction
        }                                                                                   # End if ($CallingFunction)
        :RemoveAzureNSGNic while ($true) {                                                  # Outer loop for managing function
            $NicObject,$SubnetObject,$VnetObject = GetAzNetworkInterface ($CallingFunction) # Calls function and assigns output to $vars
            if (!$NicObject) {                                                              # If $NicObject is $null
                Break RemoveAzureNSGNic                                                     # Breaks :RemoveAzureNSGNic
            }                                                                               # End if (!$NicObject) 
            if ($NicObject.NetworkSecurityGroup.ID) {                                       # If $NicObject.NetworkSecurityGroup.ID has a value
                $CurrentNSG = $NicObject.NetworkSecurityGroup.ID                            # Isolates the current NSG ID
                $CurrentNSG = $CurrentNSG.Split('/')[-1]                                    # Isolates the current NSG name
                Write-Host 'Remove:  '$CurrentNSG                                           # Write message to screen
                Write-Host 'From NIC:'$NicObject.name                                       # Write message to screen
                Write-Host ''                                                               # Write message to screen
            }                                                                               # End if ($NicObject.NetworkSecurityGroup.ID)
            else {                                                                          # Else if $NicObject.NetworkSecurityGroup.ID is $null
                Write-Host 'No NSG associated to:'$NicObject.name                           # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break RemoveAzureNSGNic                                                     # Breaks :RemoveAzureNSGNic
            }                                                                               # End else (if ($NicObject.NetworkSecurityGroup.ID) )
            $OpConfirm = Read-Host '[Y] Yes [N] No'                                         # Operator confirmation to add the NSG to the NIC
            Clear-Host                                                                      # Clears screen
            if ($OpConfirm -eq 'y') {                                                       # If $OpConfirm equals 'y'
                Try {                                                                       # Try the following
                    Write-Host 'Updating the NIC config'                                    # Write message to screen
                    $NicObject.NetworkSecurityGroup = $null                                 # Removes $NSGObject to $NICObject
                    Write-Host 'Saving the NIC config'                                      # Write message to screen
                    $NicObject | Set-AzNetworkInterface -ErrorAction 'Stop' | Out-null      # Saves $NicObject
                }                                                                           # End Try
                Catch {                                                                     # If Try fails
                    Clear-Host                                                              # Clears screen
                    Write-Host 'An error has occured'                                       # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Break RemoveAzureNSGNic                                                 # Breaks :RemoveAzureNSGNic
                }                                                                           # End Catch
                Clear-Host                                                                  # Clears screen
                Write-Host 'The NSG has been removed from the NIC'                          # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break RemoveAzureNSGNic                                                     # Breaks :RemoveAzureNSGNic
            }                                                                               # End if ($OpConfirm -eq 'y')
            else {                                                                          # All other inputs for $OpConfirm
                Write-Host 'No changes have been made'                                      # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break RemoveAzureNSGNic                                                     # Breaks :RemoveAzureNSGNic
            }                                                                               # End if ($OpConfirm -eq 'y')
        }                                                                                   # End :RemoveAzureNSGNic while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function RemoveAzNSGNIC
function GetAzNetworkInterface {                                                            # function to get a network interface
    Begin {                                                                                 # Begin function
        :GetAzureNIC while ($true) {                                                        # Outer loop for managing function
            Write-Host 'Gathering network info, this a take a moment'                       # Write message to screen
            $VNetList = Get-AzVirtualNetwork                                                # Gets a list of all virtual networks
            if (!$VNetList) {                                                               # If $VNetList is $null
                Write-Host 'No virtual networks present in this subscription'               # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break GetAzureNIC                                                           # Breaks :GetAzureNIC
            }                                                                               # End if (!$VNetList)
            Clear-Host                                                                      # Clears screen
            $ListNumber = 1                                                                 # List number used for subnet selection
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
                        if ($_.NetworkSecurityGroup.ID) {                                   # If current item .NetworkSecurityGroup.ID has a value
                            $NSGName = $_.NetworkSecurityGroup.ID                           # Isloates the network security group ID
                            $NSGName = $NSGName.Split('/')[-1]                              # Isolates the network security group name
                        }                                                                   # End if ($_.NetworkSecurityGroup.ID)
                        $ObjectInput = [PSCustomObject]@{                                   # Creates $ObjectInput
                            'Number'=$ListNumber;                                           # List number
                            'NicName'=$_.Name;                                              # Nic name
                            'NicRG'=$_.ResourceGroupName;                                   # Nic resource group name
                            'SubName'=$Subnetname;                                          # Subnet name
                            'SubPFX'=$SubnetPFX;                                            # Subnet address prefix
                            'VNetName'=$VNet;                                               # Virtual network name
                            'VnetPFX'=$VnetPFX;                                             # Virtual network address prefix
                            'VnetRG'= $VNetRG;                                              # Virtual network resource group
                            'VM'=$_.VirtualMachine.ID;                                      # VM ID
                            'IPCon'=$_.IpConfigurations;                                    # IP configurations
                            'Type'='NIC';                                                   # Object Type
                            'NSG'=$NSGName                                                  # Network security group                  
                        }                                                                   # Creates the item to loaded into array
                        $ObjectArray.Add($ObjectInput) | Out-Null                           # Loads item into array, out-null removes write to screen
                        $ListNumber = $ListNumber + 1                                       # Increments $ListNumber by 1
                        $NSGName = $null                                                    # Clears $var
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
                        if ($_.NetworkSecurityGroup.ID) {                                   # If current item .NetworkSecurityGroup.ID has a value
                            $NSGName = $_.NetworkSecurityGroup.ID                           # Isloates the network security group ID
                            $NSGName = $NSGName.Split('/')[-1]                              # Isolates the network security group name
                        }                                                                   # End if ($_.NetworkSecurityGroup.ID)       
                        $ObjectInput = [PSCustomObject]@{                                   # Creates $ObjectInput
                            'Number'=$ListNumber;                                           # List number
                            'NicName'=$_.Name;                                              # Nic name
                            'NicRG'=$_.ResourceGroupName;                                   # Nic resource group name
                            'SubName'=$Subnetname;                                          # Subnet name
                            'SubPFX'=$SubnetPFX;                                            # Subnet address prefix
                            'VNetName'=$VNet;                                               # Virtual network name
                            'VnetPFX'=$VnetPFX;                                             # Virtual network address prefix
                            'VnetRG'= $VNetRG;                                              # Virtual network resource group
                            'VM'=$_.VirtualMachine.ID;                                      # VM ID
                            'IPCon'=$_.IpConfigurations;                                    # Ip configuration
                            'Type'='Scaleset';                                              # Object type
                            'VmssName'=$VmssName;                                           # VMSS name
                            'VmssRg'=$VmssRG;                                               # VMSS resource group
                            'NSG'=$NSGName                                                  # Network security group     
                        }                                                                   # Creates the item to loaded into array
                        $ObjectArray.Add($ObjectInput) | Out-Null                           # Loads item into array, out-null removes write to screen
                        $ListNumber = $ListNumber + 1                                       # Increments $ListNumber by 1
                        $NSGName = $null                                                    # Clears $var
                    }                                                                       # End foreach ($_ in $NicList)
                }                                                                           # End foreach ($_ in $VmssObject)
            }                                                                               # End if ($VmssObject)
            Clear-Host                                                                      # Clears screen
            if (!$ObjectArray) {                                                            # If $ObjectArray is $null
                Write-Host 'No network interfaces present in this subscription'             # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break GetAzureNIC                                                           # Breaks :GetAzureNIC
            }                                                                               # End if (!$ObjectArray)
            Write-Host ''                                                                   # Write message to screen
            :SelectAzureNic while ($true) {                                                 # Inner loop for selecting the nic
                Write-Host '[0] Exit'                                                       # Write message to screen
                Write-Host ''                                                               # Write message to screen
                foreach ($_ in $ObjectArray) {                                              # For each item in $ObjectArray
                    $Number = $_.Number                                                     # $Number is equal to current item .number
                    if ($Number -le 9) {                                                    # If $Number is 9 or less
                        Write-Host "[$Number]             "$_.NicName                       # Write message to screen
                    }                                                                       # End if ($Number -le 9)
                    else {                                                                  # If $Number is greater then 9
                        Write-Host "[$Number]            "$_.NicName                        # Write message to screen
                    }                                                                       # End else (if ($Number -le 9))
                    foreach ($IP in $_.IPCon) {                                             # For each item in .IPCon
                        Write-Host 'IP Config Name: '$IP.Name                               # Write message to screen
                        Write-Host 'Private Address:'$IP.PrivateIpAddress                   # Write message to screen
                        if ($IP.publicIPAddress) {                                          # If current item .PublicAddres has a value
                            $PubID = $IP.publicIPAddress.ID                                 # Isolates the public IP sku ID
                            $PubIP = Get-AzPublicIpAddress | Where-Object `
                                {$_.ID -eq $PubID}                                          # Gets the public IP sku
                            Write-Host 'Public Address: '$PubIP.IpAddress                   # Write message to screen
                        }                                                                   # End if ($IP.PublicAddress)
                    }                                                                       # End foreach ($IP in $_.IPCon)
                    Write-Host 'NIC RG:         '$_.NicRG                                   # Write message to screen
                    Write-Host 'Subnet Name:    '$_.Subname                                 # Write message to screen
                    Write-Host 'Subnet Prefix:  '$_.SubPFX                                  # Write message to screen
                    Write-Host 'VNet Name:      '$_.VnetName                                # Write message to screen
                    Write-Host 'VNet Prefix:    '$_.VnetPFX                                 # Write message to screen
                    Write-Host 'VNet RG:        '$_.VnetRG                                  # Write message to screen
                    if ($_.VM) {                                                            # If $_.VM has a value
                        $VM = $_.VM                                                         # VM is equal to current item .VM
                        if ($VM -like '*virtualMachineScaleSets*') {                        # If $VM is like '*virtualMachineScaleSets*'
                            $Vmss = $VM.Split('/')[-3]                                      # Collects the Vmss name
                            $VM = $VM.Split('/')[-1]                                        # Collects the instance name
                            $VM = $Vmss+'/virtualMachines/'+$VM                             # Combines the Vmss name and the instance name
                        }                                                                   # End if ($VM -like '*virtualMachineScaleSets*')
                        else {                                                              # Else If $VM is not like '*virtualMachineScaleSets*'
                            $VM = $VM.Split('/')[-1]                                        # Collects the VM name
                        }                                                                   # End else (if ($VM -like '*virtualMachineScaleSets*'))
                        Write-Host 'Attached VM:    '$VM                                    # Write message to screen
                        $VM = $null                                                         # Clears $VM                                            
                    }                                                                       # End if ($_.VM)
                    else {                                                                  # If $_.VM does not have a value
                        Write-Host 'Attached VM:     N/A'                                   # Write message to screen
                    }                                                                       # End else (if ($_.VM))
                    if ($_.NSG) {                                                           # If $_.NSG has a value
                        Write-Host 'Net Sec Group  :'$_.NSG                                 # Write message to screen
                    }                                                                       # End if ($_.NSG)
                    else {                                                                  # Else if $_.NSG is $null
                        Write-Host 'Net Sec Group  : N/A'                                   # Write message to screen    
                    }                                                                       # End else if ($_.NSG)
                    Write-Host ''                                                           # Write message to screen
                }                                                                           # End foreach ($_ in $ObjectArray)
                    if ($CallingFunction) {                                                 # If $CallingFunction has a value
                    Write-Host 'The nic is being selected for:'$CallingFunction             # Write message to screen
                }                                                                           # End if ($CallingFunction)
                $OpSelect = Read-Host 'Option [#]'                                          # Operator input for selecting the nic
                Clear-Host                                                                  # Clears screen
                if ($OpSelect -eq '0') {                                                    # If $OpSelect equals 0
                    Break GetAzureNic                                                       # Breaks :GetAzureNic
                }                                                                           # End if ($OpSelect -eq '0')
                elseif ($OpSelect -in $ObjectArray.Number) {                                # If $OpSelect in $ObjectArray.Number
                    $OpSelect = $ObjectArray | Where-Object {$_.Number -eq `
                        $OpSelect}                                                          # $OpSelect equals $ObjectArray where $OpSelect is equal to $ObjectArray.Number
                    $VNetObject = Get-AzVirtualNetwork -Name $OpSelect.VnetName `
                        -ResourceGroupName $OpSelect.VNetRG                                 # Pulls the $Subnet Vnet
                    $SubnetObject = Get-AzVirtualNetworkSubnetConfig -VirtualNetwork `
                        $VNetObject -Name $OpSelect.Subname                                 # Pulls the $NicObject subnet
                    if ($OpSelect.Type -eq 'Nic') {                                         # If $OpSelect.Type equals 'Nic'
                        $NicObject = Get-AzNetworkInterface -Name $OpSelect.NicName |`
                            Where-Object {$_.IpConfigurations.Subnet.ID -eq `
                            $SubnetObject.ID}                                               # Pulls the full $NicObject
                    }                                                                       # End if ($OpSelect.Type -eq 'Nic')
                    else {                                                                  # Else if $OpSelect.Type does not equal 'Nic'
                        $NicObject = Get-AzNetworkInterface -VirtualMachineScaleSetName `
                            $OpSelect.VmssName -ResourceGroupName $OpSelect.VmssRg `
                            | Where-Object {$_.Name -eq $OpSelect.NicName}                  # Pulls the full $NicObject
                    }                                                                       # End else (if ($OpSelect.Type -eq 'Nic'))
                    Return $NicObject,$SubnetObject,$VnetObject                             # Returns $vars to calling function
                }                                                                           # End elseif ($OpSelect -in $ObjectArray.Number)
                else {                                                                      # All other inputs for $OpSelect
                    Write-Host 'That was not a valid input'                                 # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Clear-Host                                                              # Clears screen
                }                                                                           # End else (if ($OpSelect -eq '0'))
            }                                                                               # End :SelectAzureNic while ($true)
        }                                                                                   # End :GetAzureNIC while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function GetAzNetworkInterface