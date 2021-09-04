# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Microsoft docs links
    Get-AzVM:                                   https://docs.microsoft.com/en-us/powershell/module/az.compute/get-azvm?view=azps-5.4.0
    Get-AzNetworkInterface:                     https://docs.microsoft.com/en-us/powershell/module/az.network/get-aznetworkinterface?view=azps-6.3.0
} #>
<# Required Functions Links: {
    None
} #>
<# Functions Description: {
    ListAzVM:                   Function to list VM objects
} #>
<# Variables: {
    :ListAzureVM                Outer loop for managing function
    $VMList:                    List of all VMs
    $VMArray:                   Array used to list VM info
    $ArrayInput:                $Var used to load items into array
    $NicArray:                  Array to hold current VM network interfaces
    $NicIDs:                    Current item network interface IDs
    $PriIP:                     Private IP address on interface primary config
    $PriIPAll:                  Private IP address allocation on interface primary config
} #>
<# Process Flow {
    ListAzVM
}#>
function AddAzVMNic {                                                                       # Function to add a NIC to an existing VM
    Begin {                                                                                 # Begin function
        if (!$CallingFunction) {                                                            # If $CallingFunction is $null
            $CallingFunction = 'AddAzVMNic'                                                 # Creates $CallingFunction
        }                                                                                   # End if (!$CallingFunction)
        :AddAzureVMNic while ($true) {                                                      # Outer loop for managing function
            $VMObject = GetAzVM ($CallingFunction)                                          # Calls function and assigns output to $var
            if (!$VMObject) {                                                               # If $VMObject is $null
                Break AddAzureVMNic                                                         # Breaks :AddAzureVMNic
            }                                                                               # End if (!$VMObject)
            $VMSize = Get-AzComputeResourceSku -Location $VMObject.Location  | `
                Where-Object {$_.Name -eq $VMObject.HardwareProfile.VmSize}                 # Gets the VM size
            $MaxNics = $VMSize.Capabilities[26].value                                       # Isolates the max number of nics available for VM size
            if ($VMObject.NetworkProfile.NetworkInterfaces.ID.Count -eq $MaxNics) {         # If $VMObject.NetworkProfile.NetworkInterfaces.ID.Count -equals $MaxNics
                Write-Host 'This VM already has the max number'                             # Write message ot screen
                Write-Host 'of NICs supported by the VM size'                               # Write message ot screen
                Write-Host ''                                                               # Write message ot screen
                Write-Host 'Please remove an existing nic '                                 # Write message ot screen
                Write-Host 'before adding a new one, or please'                             # Write message ot screen
                Write-Host 'change the VM size'                                             # Write message ot screen
                Write-Host ''                                                               # Write message ot screen
                Pause                                                                       # Pauses all actions for operator input
                Break AddAzureVMNic                                                         # Breaks :AddAzureVMNic    
            }                                                                               # End if ($VMObject.NetworkProfile.NetworkInterfaces.ID.Count -eq $MaxNics)
            $VMStatus = (Get-AzVM -Name $VMObject.Name -ResourceGroupName `
                $VMObject.ResourceGroupName -Status).Statuses[1].Code                       # Pulls $VMObjects power state
            if ($VMStatus -ne 'PowerState/deallocated') {                                   # If $VMStatus does not equal 'PowerState/deallocated'
                Write-Host 'This VM must be powered off (Deallocated)'                      # Write message ot screen
                Write-Host 'prior to any changes to the network interfaces'                 # Write message ot screen
                Write-Host ''                                                               # Write message ot screen
                Write-Host 'Please power down this VM and try again'                        # Write message ot screen
                Write-Host ''                                                               # Write message ot screen
                Pause                                                                       # Pauses all actions for operator input
                Break AddAzureVMNic                                                         # Breaks :AddAzureVMNic        
            }                                                                               # End if ($VMStatus -ne 'PowerState/deallocated')
            if ($VMObject.NetworkProfile.NetworkInterfaces.ID.Count -gt 1) {                # If $VMObject.NetworkProfile.NetworkInterfaces.ID.Count is greater than 1
                $VMSubID = $VMObject.NetworkProfile.NetworkInterfaces.ID[0]                 # Isloates the first NIC ID
            }                                                                               # End if ($VMObject.NetworkProfile.NetworkInterfaces.ID.Count -gt 1)
            else {                                                                          # Else If$VMObject.NetworkProfile.NetworkInterfaces.ID.Count is 1 or less
                $VMSubID = $VMObject.NetworkProfile.NetworkInterfaces.ID                    # Isolates the NIC ID
            }                                                                               # End else (if ($VMObject.NetworkProfile.NetworkInterfaces.ID.Count -gt 1))
            $ExistingNic = Get-AzNetworkInterface | Where-Object {$_.ID -eq $VMSubID}       # Pulls the existing primary Nic object
            if ($ExistingNic.IpConfigurations.Count -gt 1) {                                # If $ExistingNic.IpConfigurations.Count greater than 1 
                $SubnetID = $ExistingNic.IpConfigurations[0].Subnet.ID                      # Isolates the subnet ID    
            }                                                                               # End if ($ExistingNic.IpConfigurations.Count -gt 1) 
            else {                                                                          # Else if $ExistingNic.IpConfigurations.Count equals 1 
                $SubnetID = $ExistingNic.IpConfigurations.Subnet.ID                         # Isolates the subnet ID
            }                                                                               # End else (if ($ExistingNic.IpConfigurations.Count -gt 1) )
            :SelectAzureNIC while ($true) {                                                 # Inner loop for selecting the additional nic
                $NicObject,$SubnetObject,$VnetObject = GetAzNetworkInterface `
                    ($CallingFunction)                                                      # Calls function and assigns output to $var
                if (!$NicObject) {                                                          # If $NicObject is $null
                    Break AddAzureVMNic                                                     # Breaks :AddAzureVMNic
                }                                                                           # End if (!$NicObject)
                if ($NicObject.IpConfigurations.Subnet.ID -ne $SubnetID) {                  # If $NicObject.IpConfigurations.Subnet.ID does not equal $SubnetID 
                    Write-Host 'The selected NIC is on a different subnet'                  # Write message to screen
                    Write-Host 'Please chose a different NIC'                               # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Clear-Host                                                              # Clears screen
                    $NicObject = $null                                                      # Clears $var
                }                                                                           # End if ($NicObject.IpConfigurations.Subnet.ID -ne $SubnetID) 
                else {                                                                      # Else if $NicObject.IpConfigurations.Subnet.ID equals $SubnetID
                    Break SelectAzureNIC                                                    # Breaks :SelectAzureNIC
                }                                                                           # End else (if ($NicObject.IpConfigurations.Subnet.ID -ne $SubnetID))
            }                                                                               # End :SelectAzureNIC while ($true)
            :Confirm while ($true) {                                                        # Inner loop for confirming change
                Write-Host 'Add the following'                                              # Write message to screen
                Write-Host 'Name:      '$NicObject.Name                                     # Write message to screen
                if ($NicObject.IpConfigurations.Count -gt 1) {                              # If $NicObject.IpConfigurations.Count is greater than 1
                    $PriIP = $NicObject.IpConfigurations.PrivateIPAddress[0]                # Isolates the private IP address
                    $PriIPAll = $NicObject.IpConfigurations.PrivateIpAllocationMethod[0]    # Isolates the private IP allocation method
                }                                                                           # End if ($NicObject.IpConfigurations.Count -gt 1)
                else {                                                                      # Else if $NicObject.IpConfigurations.Count is 1 or less
                    $PriIP = $NicObject.IpConfigurations.PrivateIPAddress                   # Isolates the private IP address
                    $PriIPAll = $NicObject.IpConfigurations.PrivateIpAllocationMethod       # Isolates the private IP allocation method
                }                                                                           # End else (if ($NicObject.IpConfigurations.Count -gt 1))
                Write-Host 'Private IP:'$PriIP                                              # Write message to screen
                Write-Host 'Allocation:'$PriIPAll                                           # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Write-Host 'To the following VM'                                            # Write message to screen
                Write-Host 'Name:      '$VMObject.Name                                      # Write message to screen
                Write-Host 'RG:        '$VMObject.ResourceGroupName                         # Write message to screen
                if ($VMObject.OS.WindowsConfiguration) {                                    # If $VMObject.OS.WindowsConfiguration has a value
                    Write-Host 'OS Type:    Windows'                                        # Write message to screen
                }                                                                           # End if ($VMObject.OS.WindowsConfiguration)
                elseif ($VMObject.OS.LinuxConfiguration) {                                  # If $VMObject.OS.LinuxConfiguration has a value
                    Write-Host 'OS Type:    Linux'                                          # Write message to screen
                }                                                                           # End elseif ($_.OS.LinuxConfiguration)
                Write-Host ''                                                               # Write message to screen
                $OpConfirm = Read-Host '[Y] Yes [N]'                                        # Operator confirmation to make the change
                Clear-Host                                                                  # Clears screen
                if ($OpConfirm -eq 'y') {                                                   # If $OpConfirm equals 'y'
                    Break Confirm                                                           # Breaks :Confirm
                }                                                                           # End if ($OpConfirm -eq 'y')
                elseif ($OpConfirm -eq 'n') {                                               # Else if $OpConfirm equals 'n'
                    Break AddAzureVMNic                                                     # Breaks :AddAzureVMNic
                }                                                                           # End elseif ($OpConfirm -eq 'n') 
                else {                                                                      # All other inputs for $OpConfirm
                    Write-Host 'That was not a valid input'                                 # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Clear-Host                                                              # Clears screen 
                }                                                                           # End else (if ($OpConfirm -eq 'y'))
            }                                                                               # End :Confirm while ($true) 
            Try {                                                                           # Try the following
                Write-Host 'Making the requested changes'                                   # Write message to screen
                Write-Host 'This may take a moment'                                         # Write message to screen
                if (!$VMObject.NetworkProfile.NetworkInterfaces[0].Primary) {               # If the first interface is not flagged as primary
                    $VMObject.NetworkProfile.NetworkInterfaces[0].Primary = $true           # Sets the first interface primary flag to $true
                }                                                                           # End if (!$VMObject.NetworkProfile.NetworkInterfaces[0].Primary)
                $VMNicCount = $VMObject.NetworkProfile.NetworkInterfaces.count              # Gets the current number of interfaces
                Add-AzVMNetworkInterface -VM $VMObject -NetworkInterface $NicObject  `
                    -ErrorAction 'Stop' | Out-Null                                          # Adds the additional interface
                $VMObject.NetworkProfile.NetworkInterfaces[$VMNicCount].Primary = $false
                Update-AzVM -VM $VMObject -ResourceGroupName $VMObject.ResourceGroupName `
                    -ErrorAction 'Stop'  | Out-Null
            }                                                                               # End try
            catch {                                                                         # If try fails
                Clear-Host                                                                  # Clears screen
                Write-Host 'An error has occured'                                           # Write message to screen
                Write-Host ''                                                               # Write message to screen
                $MSG = $Error[0]                                                            # Gets the error message
                if ($MSG.Exception.InnerException.Body.Message) {                           # If $MSG.Exception.InnerException.Body.Message has a value             
                    $MSG = $MSG.Exception.InnerException.Body.Message                       # Isolates the error message
                    Write-Warning $MSG                                                      # Write message to screen
                    Write-Host ''                                                           # Write message to screen    
                }                                                                           # End if ($MSG.Exception.InnerException.Body.Message)
                else {                                                                      # Else if $MSG.Exception.InnerException.Body.Message is $null
                    Write-Warning $MSG                                                      # Write message to screen
                    Write-Host ''                                                           # Write message to screen        
                }                                                                           # End else (if ($MSG.Exception.InnerException.Body.Message))
                Write-Host 'No changes have been made'                                      # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break AddAzureVMNic                                                         # Breaks :AddAzureVMNic    
            }                                                                               # End catch
            Clear-Host                                                                      # Clears screen
            Write-Host 'The selected NIC has been added to the VM'                          # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            Pause                                                                           # Pauses all actions for operator input
            Break AddAzureVMNic                                                             # Breaks :AddAzureVMNic    
        }                                                                                   # End :AddAzureVMNic while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function AddAzVMNic
function GetAzVM {                                                                          # Gets $VMObject from list
    Begin {                                                                                 # Begin function
        :GetAzureVM while ($true) {                                                         # Outer loop for managing function
            Write-Host 'Gathering VM info, this may take a momement'                        # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            $VMList = Get-AzVM -status                                                      # Gets a list
            if (!$VMList) {                                                                 # If $VMList is $null
                Clear-Host                                                                  # Clears screen
                Write-Host 'No VMs in this subscription'                                    # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break GetAzureVM                                                            # Breaks :GetAzureVM
            }                                                                               # End if (!$VMList)
            $ListNumber = 1                                                                 # $Var for selecting the VM
            [System.Collections.ArrayList]$VMArray = @()                                    # $VMArray creation
            foreach ($_ in $VMList) {                                                       # For each item in $var
                $NicArray = @()                                                             # Creates $NicArray
                $NicIDs = $_.NetworkProfile.NetworkInterfaces.ID                            # Isolates the IDs
                foreach ($ID in $NicIDs) {                                                  # For each item in $NicIDs
                    $NicObject = Get-AzNetworkInterface | Where-Object {$_.ID -eq $ID}      # Pulls the full NIC object
                    $NicArray += $NicObject                                                 # Adds $NicObject to $NicArray
                    $NicObject = $null                                                      # Clears $var
                }                                                                           # End foreach ($ID in $NicIDs) 
                $ArrayInput = [PSCustomObject]@{                                            # Creates the PS custom object used to load info into array
                    'Number'=$ListNumber;                                                   # List number
                    'Name'=$_.Name;                                                         # VM name
                    'RG'=$_.ResourceGroupName;                                              # Resource group name
                    'Status' = $_.PowerState;                                               # VM power state
                    'LOC'=$_.Location;                                                      # VM location
                    'OS'=$_.OsProfile;                                                      # Os profile
                    'NIC'=$NicArray                                                         # VM Nic info
                }                                                                           # End creating $ArrayInput
                $VMArray.Add($ArrayInput) | Out-Null                                        # Loads items into the array
                $ListNumber = $ListNumber + 1                                               # Increments $listNumber up by 1
                $NicArray = $null                                                           # Clears $var
                $NicIDs = $null                                                             # Clears $var
            }                                                                               # End foreach ($_ in $VMList)
            Clear-Host                                                                      # Clears screen
            :SelectAzureVM while ($true) {                                                  # Inner loop for selecting VM from list
                Write-Host '[0]  Exit'                                                      # Write message to screen
                Write-Host ''                                                               # Write message to screen
                foreach ($_ in $VMArray) {                                                  # For each item in $VMArray
                    $Number = $_.Number                                                     # Number is equal to current item .number
                    if ($Number -le 9) {                                                    # If $Number is 9 or less
                        Write-Host "[$Number]      "$_.Name                                 # Write message to screen
                    }                                                                       # End if ($Number -le 9)
                    else {                                                                  # If $number is greater than 9
                        Write-Host "[$Number]     "$_.Name                                  # Write message to screen
                    }                                                                       # End else (if ($Number -le 9))                     
                    Write-Host 'RG:      '$_.RG                                             # Write message to screen
                    Write-Host 'Location:'$_.LOC                                            # Write message to screen
                    if ($_.OS.WindowsConfiguration) {                                       # If current item .OS.WindowsConfiguration has a value
                        Write-Host 'OS Type:  Windows'                                      # Write message to screen
                    }                                                                       # End if ($_.OS.WindowsConfiguration)
                    elseif ($_.OS.LinuxConfiguration) {                                     # If current item .OS.LinuxConfiguration has a value
                        Write-Host 'OS Type:  Linux'                                        # Write message to screen
                    }                                                                       # End elseif ($_.OS.LinuxConfiguration)
                    Write-Host 'Status:  '$_.Status                                         # Write message to screen
                    foreach ($NIC in $_.Nic) {                                              # For each item in current item .nic
                        Write-Host 'Nic Name:'$NIC.Name                                     # Write message to screen
                        if ($NIC.IPConfigurations.Count -gt 1) {                            # If $NIC.IPConfigurations.Count is greater than 1
                            $PriIP = $NIC.IpConfigurations.PrivateIpAddress[0]              # $PriIP is equal $NIC.IpConfigurations.PrivateIpAddress 1st value
                            $PriIPAll = $NIC.IpConfigurations.PrivateIpAllocationMethod[0]  # $PriIPAll is equal $NIC.IpConfigurations.PrivateIpAllocationMethod 1st value
                            Write-Host '  Pri IP:  '$PriIP                                  # Write message to screen
                            Write-Host '  Pri Allo:'$PriIPAll                               # Write message to screen
                        }                                                                   # End if ($NIC.IPConfigurations.Count -gt 1)
                        else {                                                              # Else If $NIC.IPConfigurations.Count is 1 or less
                            $PriIP = $NIC.IpConfigurations.PrivateIpAddress                 # $PriIP is equal $NIC.IpConfigurations.PrivateIpAddress
                            $PriIPAll = $NIC.IpConfigurations.PrivateIpAllocationMethod     # $PriIPAll is equal to $NIC.IpConfigurations.PrivateIpAllocationMethod 
                            Write-Host '  Pri IP:  '$PriIP                                  # Write message to screen
                            Write-Host '  Pri Allo:'$PriIPAll                               # Write message to screen
                        }                                                                   # End else (if ($NIC.IPConfigurations.Count -gt 1))
                    }                                                                       # End foreach ($NIC in $_.Nic)
                    Write-Host ''                                                           # Write message to screen
                }                                                                           # End foreach ($_ in $VMList)
                if ($CallingFunction) {                                                     # If $CallingFunction has a value
                    Write-Host 'You are selecting the VM for:'$CallingFunction              # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                }                                                                           # End if ($CallingFunction) 
                $OpSelect = Read-Host 'Option [#]'                                          # Operator input for the selection
                Clear-Host                                                                  # Clears screen
                if ($OpSelect -eq '0') {                                                    # If $OpSelect equals '0'
                    Break GetAzureVM                                                        # Breaks :GetAzureVM
                }                                                                           # End if ($_Select -eq '0')
                elseif ($OpSelect -in $VMArray.Number) {
                    $OpSelect = $VMArray | Where-Object {$_.Number -eq $OpSelect}           # $OpSelect equals $VMArray where $VMArray.Number equals $OpSelect
                    $VMObject = Get-AzVM -ResourceGroupName $OpSelect.RG `
                        -Name $OpSelect.Name                                                # Pulls full $VMObject
                    Return $VMObject                                                        # Returns to calling function with $VMObject
                }                                                                           # End elseif ($OpSelect -in $VMArray.Number)
                else {                                                                      # All other inputs for $OpSelect
                    Write-Host 'That was not a valid input'                                 # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Clear-Host                                                              # Clears screen
                }                                                                           # End else (if ($OpSelect -eq '0'))
            }                                                                               # End :SelectAzureVM while ($true)
        }                                                                                   # End :GetAzureVM while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null 
    }                                                                                       # End Begin
}                                                                                           # End function GetAzVM
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