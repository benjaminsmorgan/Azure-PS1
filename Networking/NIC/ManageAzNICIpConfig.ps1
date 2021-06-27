# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Mircosoft docs links
    Add-AzNetworkInterfaceIpConfig:             https://docs.microsoft.com/en-us/powershell/module/az.network/add-aznetworkinterfaceipconfig?view=azps-6.0.0
    Get-AzNetworkInterfaceIPConfig:             https://docs.microsoft.com/en-us/powershell/module/az.network/get-aznetworkinterfaceipconfig?view=azps-5.6.0
    Remove-AzNetworkInterfaceIPConfig:          https://docs.microsoft.com/en-us/powershell/module/az.network/Remove-aznetworkinterfaceipconfig?view=azps-5.6.0
    Set-AzNetworkInterfaceIPConfig:             https://docs.microsoft.com/en-us/powershell/module/az.network/set-aznetworkinterfaceipconfig?view=azps-5.6.0
    Set-AzNetworkInterface:                     https://docs.microsoft.com/en-us/powershell/module/az.network/set-aznetworkinterface?view=azps-5.6.0
    Get-AzNetworkInterface:                     https://docs.microsoft.com/en-us/powershell/module/az.network/get-aznetworkinterface?view=azps-5.4.0
    Get-AzVirtualNetworkSubnetConfig:           https://docs.microsoft.com/en-us/powershell/module/az.network/get-azvirtualnetworksubnetconfig?view=azps-5.4.0
    Get-AzVirtualNetwork:                       https://docs.microsoft.com/en-us/powershell/module/az.network/get-azvirtualnetwork?view=azps-5.4.0
    Get-AzPublicIpAddress:                      https://docs.microsoft.com/en-us/powershell/module/az.network/get-azpublicipaddress?view=azps-5.5.0 
    Get-AzVM:                                   https://docs.microsoft.com/en-us/powershell/module/az.compute/get-azvm?view=azps-6.0.0  
} #>
<# Required Functions Links: {
    AddAzNICIpConfig:           https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/NIC/AddAzNICIpConfig.ps1
    ListAzNICIpConfig:          https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/NIC/ListAzNICIpConfig.ps1
    GetAzNICIpConfig:           https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/NIC/GetAzNICIpConfig.ps1
    RemoveAzNICIpConfig:        https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/NIC/RemoveAzNICIpConfig.ps1
    SetAzNICIpConfig:           https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/NIC/SetAzNICIpConfig.ps1
    SetAzNICPriIPConfig:        https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/NIC/SetAzNICPriIPConfig.ps1
    SetAzNICIpConfigPublicIP:   https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/NIC/SetAzNICIpConfigPublicIP.ps1
    RemoveAzNICIpConPublicIP:   https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/NIC/RemoveAzNICIpConPublicIP.ps1
    GetAzPublicIpAddress:       https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/Public%20IP/GetAzPublicIpAddress.ps1
    GetAzNetworkInterface:      https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/NIC/GetAzNetworkInterface.ps1
} #>
<# Functions Description: {
    ManageAzNICIpConfig:        Management function for network interfaces ip configs
    AddAzNICIpConfig:           Creates a NIC IP configuration
    ListAzNICIpConfig:          Lists all NIC IP configurations
    GetAzNICIpConfig:           Gets a NIC IP configuration
    RemoveAzNICIpConfig:        Removes a network interface config
    SetAzNICIpConfig:           Updates a NIC IP configuration
    SetAzNICPriIPConfig:        Updates a NIC IP primary configuration
    SetAzNICIpConfigPublicIP:   Adds a public IP sku to a network interface config
    RemoveAzNICIpConPublicIP:   Removes a public IP sku to a network interface config
    GetAzPublicIpAddress:       Gets a public IP address sku  
    GetAzNetworkInterface:      Gets an existing network interface
} #>
<# Variables: {
    :ManageAzureNicIPConfig     Outer loop for managing function
    $OpSelect:                  Operator input for selecting function
    AddAzNICIpConfig{}          Adds $NicIPConfigObject
        GetAzNetworkInterface{}     Gets $NicObject,$SubnetObject,$VnetObject
    ListAzNICIpConfig{}         Lists $NicIPConfigObject
    RemoveAzNICIpConfig{}       Removes $NicIPConfigObject
        GetAzNICIpConfig{}          Gets $NicIPConfigObject, $NicObject
    SetAzNICIpConfig{}          Updates $NicIPConfigObject
        GetAzNICIpConfig{}          Gets $NicIPConfigObject,$NicObject
    SetAzNICPriIPConfig{}       Updates $NicIPConfigObject
        GetAzNICIpConfig{}          Gets $NicIPConfigObject,$NicObject
    SetAzNICIpConfigPublicIP{}  Updates $NicIPConfigObject
        GetAzNICIpConfig{}          Gets $NicIPConfigObject, $NicObject
        GetAzPublicIpAddress{}      Gets $PublicIPObject
    RemoveAzNICIpConPublicIP{}  Removes $NicIPConfigObject
        GetAzNICIpConfig{}          Gets $NicIPConfigObject, $NicObject
} #>
<# Process Flow {
    Function
        Call ManageAzNICIpConfig > Get $null
            Call AddAzNICIpConfig > Get $null
                Call GetAzNetworkInterface > Get $NicObject,$SubnetObject,$VnetObject
                End GetAzNetworkInterface
                    Return AddAzNICIpConfig > Send $NicObject,$SubnetObject,$VnetObject
            End AddAzNICIpConfig
                Return ManageAzNICIpConfig > Send $null
            Call ListAzNICIpConfig > Get $null
            End ListAzNICIpConfig
                Return ManageAzNICIpConfig > Send $null
            Call RemoveAzNICIpConfig > Get $null
                Call GetAzNICIpConfig > Get $NicIPConfigObject, $NicObject
                End GetAzNICIpConfig
                    Return RemoveAzNICIpConfig > Send $NicIPConfigObject, $NicObject
            End RemoveAzNICIpConfig
                Return ManageAzNICIpConfig > Send $null
            Call SetAzNICIpConfig > Get $null
                Call GetAzNICIpConfig > Get $NicIPConfigObject,$NicObject
                End GetAzNICIpConfig
                    Return SetAzNICIpConfig > Send $NicIPConfigObject,$NicObject
            End SetAzNICIpConfig
                Return ManageAzNICIpConfig > Send $null
            Call SetAzNICPriIPConfig > Get $null
                Call GetAzNICIpConfig > Get $NicIPConfigObject,$NicObject
                End GetAzNICIpConfig
                    Return SetAzNICPriIPConfig > Send $NicIPConfigObject,$NicObject
            End SetAzNICPriIPConfig
                Return ManageAzNICIpConfig > Send $null
            Call SetAzNICIpConfigPublicIP > Get $null
                Call GetAzNICIpConfig > Get $NicIPConfigObject, $NicObject
                End GetAzNICIpConfig
                    Return SetAzNICIpConfigPublicIP > Send $NicIPConfigObject, $NicObject
                Call GetAzPublicIpAddress > Get $PublicIPObject
                End GetAzPublicIpAddress
                    Return SetAzNICIpConfigPublicIP > Send $PublicIPObject
            End SetAzNICIpConfigPublicIP
                Return ManageAzNICIpConfig > Send $null
            Call RemoveAzNICIpConPublicIP > Get $null
                Call GetAzNICIpConfig > Get $NicIPConfigObject, $NicObject
                End GetAzNICIpConfig
                    Return RemoveAzNICIpConPublicIP > Send $NicIPConfigObject, $NicObject
            End RemoveAzNICIpConPublicIP
                Return ManageAzNICIpConfig > Send $null
        End ManageAzNICIpConfig
            Return function > Send $null
}#>
function ManageAzNICIpConfig {                                                              # Function for managing azure nic ip configs
    Begin {                                                                                 # Begin function   
        :ManageAzureNicIPConfig while ($true) {                                             # Outer loop for managing function
            Write-Host 'Azure Nic IP Config Management'                                     # Write message to screen
            Write-Host '[0] Exit'                                                           # Write message to screen
            Write-Host '[1] Add Nic IP Config'                                              # Write message to screen
            Write-Host '[2] List Nic IP Configs'                                            # Write message to screen
            Write-Host '[3] Remove Nic IP Config'                                           # Write message to screen
            Write-Host '[4] Change Private IP Config'                                       # Write message to screen
            Write-Host '[5] Change Primary IP Config'                                       # Write message to screen
            Write-Host '[6] Add NIC Public IP config'                                       # Write message to screen
            Write-Host '[7] Remove NIC Public IP config'                                    # Write message to screen
            $OpSelect = Read-Host 'Option [#]'                                              # Operator input to select management function
            Clear-Host                                                                      # Clears screen
            if ($OpSelect -eq '0') {                                                        # If $OpSelect equals '0'
                Break ManageAzureNicIPConfig                                                # Breaks :ManageAzureNicIPConfig
            }                                                                               # End if ($OpSelect -eq '0')
            elseif ($OpSelect -eq '1') {                                                    # Elseif $OpSelect equals 1
                Write-Host 'Add Nic IP Config'                                              # Write message to screen
                AddAzNICIpConfig                                                            # Calls function 
            }                                                                               # End elseif ($OpSelect -eq '1')
            elseif ($OpSelect -eq '2') {                                                    # Elseif $OpSelect equals '2'
                Write-Host 'List Nic IP Configs'                                            # Write message to screen
                ListAzNICIpConfig                                                           # Calls function 
            }                                                                               # End elseif ($OpSelect -eq '2')
            elseif ($OpSelect -eq '3') {                                                    # Elseif $OpSelect equals '3'
                Write-Host 'Remove Nic IP Config'                                           # Write message to screen
                RemoveAzNICIpConfig                                                         # Calls function 
            }                                                                               # End elseif ($OpSelect -eq '3')
            elseif ($OpSelect -eq '4') {                                                    # Elseif $OpSelect equals '4'
                Write-Host 'Change Private IP Config'                                       # Write message to screen
                SetAzNICIpConfig                                                            # Calls function 
            }                                                                               # End elseif ($OpSelect -eq '4')
            elseif ($OpSelect -eq '5') {                                                    # Elseif $OpSelect equals '5'
                Write-Host 'Change Primary IP Config'                                       # Write message to screen
                SetAzNICPriIPConfig                                                         # Calls function 
            }                                                                               # End elseif ($OpSelect -eq '5')
            elseif ($OpSelect -eq '6') {                                                    # Elseif $OpSelect equals '6'
                Write-Host 'Add NIC Public IP config'                                       # Write message to screen
                SetAzNICIpConPublicIP                                                       # Calls function 
            }                                                                               # End elseif ($OpSelect -eq '6')
            elseif ($OpSelect -eq '7') {                                                    # Elseif $OpSelect equals '7'
                Write-Host 'Remove NIC Public IP config'                                    # Write message to screen
                RemoveAzNICIpConPublicIP                                                    # Calls function 
            }                                                                               # End elseif ($OpSelect -eq '7')
            else {                                                                          # All other inputs for $OpSelect     
                Write-Host 'That was not a valid input'                                     # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Clear-Host                                                                  # Clears screen
            }                                                                               # End else (if ($OpSelect -eq 'exit'))
        }                                                                                   # End :ManageAzureNicIPConfig while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function ManageAzNICIpConfig
function AddAzNICIpConfig {                                                                 # Function to add a NIC IP config
    Begin {                                                                                 # Begin function
        if (!$CallingFunction) {                                                            # If $CallingFunction is $null
            $CallingFunction = 'AddAzNICIpConfig'                                           # Sets $CallingFunction
        }                                                                                   # End if (!$CallingFunction)
        :AddAzureNicIPConfig while ($true) {                                                # Outer loop for managing function
            $NicObject,$SubnetObject,$VnetObject = GetAzNetworkInterface ($CallingFunction) # Calls function and assigns output to $var
            if (!$NicObject) {                                                              # If $NicObject is $null
                Break AddAzureNICIpConfig                                                   # Breaks :AddAzureNICIpConfig
            }                                                                               # End if (!$NicObject)
            :SetAzureIPConfigName while ($true) {                                           # Inner loop for setting the new IP config name
                Write-Host 'Please enter the name of the IP config name'                    # Write message to screen
                $NicIPConfigName = Read-Host 'Name'                                         # Operator input for the new IP config name
                Clear-Host                                                                  # Clears screen
                Write-Host 'Use:'$NicIPConfigName' as the IP name'                          # Write message to screen
                $OpConfirm = Read-Host '[Y] Yes [N] No [E] Exit'                            # Operator confirmation of the IP config name
                Clear-Host                                                                  # Clears screen
                if ($OpConfirm -eq 'y') {                                                   # If $OpConfirm equals 'y'
                    Break SetAzureIPConfigName                                              # Breaks :SetAzureIPConfigName  
                }                                                                           # End if ($OpConfirm -eq 'y')
                elseif ($OpConfirm -eq 'e') {                                               # Else if $OpConfirm equals 'e'
                    Break AddAzureNICIpConfig                                               # Breaks :AddAzureNICIpConfig
                }                                                                           # End elseif ($OpConfirm -eq 'e')
            }                                                                               # End :SetAzureIPConfigName while ($true)
            $SubnetID = $SubnetObject.ID                                                    # Isolates the subnet ID
            Try {                                                                           # Try the following
                Write-Host 'Addinging the IP config'                                        # Write message to screen
                Add-AzNetworkInterfaceIpConfig -Name $NicIPConfigName -NetworkInterface `
                    $NicObject -SubnetId $SubnetID -ErrorAction 'Stop' | Out-Null           # Adds the new config
                $NicObject | Set-AzNetworkInterface -erroraction'Stop' | Out-Null           # Saves the changes
            }                                                                               # End try
            catch {                                                                         # If Try fails
                Clear-Host                                                                  # Clears screen
                Write-Host 'An error has occured'                                           # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Write-Host 'You may not have the permissions'                               # Write message to screen
                Write-Host 'to complete this action or'                                     # Write message to screen
                Write-Host 'the resource or resource group'                                 # Write message to screen
                Write-Host 'may be locked preventing changes'                               # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break AddAzureNicIPConfig                                                   # Breaks :AddAzureNicIPConfig
            }                                                                               # End catch
            Clear-Host                                                                      # Clears screen
            Write-Host 'IP config has been added to:'$NicObject.Name                        # Write message to the screen
            Pause                                                                           # Pauses all actions for operator input
            Break AddAzureNicIPConfig                                                       # Breaks :AddAzureNicIPConfig
        }                                                                                   # End :AddAzureNicIPConfig while ($true)
        Clear-Host                                                                          # Clears screen
        return $null                                                                        # Returns to calling function with $null 
    }                                                                                       # End Begin
}                                                                                           # End function AddAzNICIpConfig
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
                    if ($NicVM) {                                                           # If $NicVM has a value 
                        $VMObject = Get-AzVM | Where-Object {$_.ID -eq $NICVM}              # Gets the currently attached VM
                    }                                                                       # End if ($NicVM)
                    $IPConfigList = $_.IPConfigurations                                     # IPConfigList is equal to current item .IPConfigurations
                    foreach ($_ in $IPConfigList) {                                         # For each item in $IPConfigList
                        $ObjectInput = [PSCustomObject]@{                                   # Creates $ObjectInput            
                            'Name'=$_.Name;'PrivIP'=$_.PrivateIPAddress;`
                            'PrivIPAllo'=$_.PrivateIpAllocationMethod;`
                            'PubIP'=$_.PublicIPAddress;'Pri'=$_.Primary;`
                            'NICName'=$NICName;'NICRG'=$NicRG;'NICVM'=$VMObject.Name        # Collects the information for the array
                        }                                                                   # End $ObjectInput = [PSCustomObject]
                        $ObjectArray.Add($ObjectInput) | Out-Null                           # Loads item into array, out-null removes write to screen
                    }                                                                       # End foreach ($_ in $IPConfigList)
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
                        $IPConfigList = $_.IPConfigurations                                 # IPConfigList is equal to current item .IPConfigurations
                        foreach ($_ in $IPConfigList) {                                     # For each item in $IPConfigList
                            $ObjectInput = [PSCustomObject]@{                               # Creates $ObjectInput            
                                'Name'=$_.Name;'PrivIP'=$_.PrivateIPAddress;`
                                'PrivIPAllo'=$_.PrivateIpAllocationMethod;`
                                'PubIP'=$_.PublicIPAddress;'Pri'=$_.Primary;`
                                'NICName'=$NICName;'NICRG'=$NicRG;'NICVM'=$VMObject.Name;`
                                'Type'='ScaleSetNic';'VmssName'=$VmssName;'VmssRG'=$VmssRG  # Collects the information for the array
                            }                                                               # End $ObjectInput = [PSCustomObject]
                            $ObjectArray.Add($ObjectInput) | Out-Null                       # Loads item into array, out-null removes write to screen
                        }                                                                   # End foreach ($_ in $IPConfigList)
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
                Write-Host ''                                                               # Write message to screen
            }                                                                               # End foreach ($_ in $ObjectArray)
            Pause                                                                           # Pauses all actions for operator input
            Break ListAzureNICIpConfig                                                      # Breaks :ListAzureNICIpConfig
        }                                                                                   # End :ListAzureNICIpConfig while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function ListAzNICIpConfig
function GetAzNICIpConfig {                                                                 # Function to get network interface config
    Begin {                                                                                 # Begin function
        :GetAzureNICIpConfig while ($true) {                                                # Outer loop for managing function
            $ObjectNumber = 1                                                               # Creates $ObjectNumber
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
                    if ($NicVM) {                                                           # If $NicVM has a value 
                        $VMObject = Get-AzVM | Where-Object {$_.ID -eq $NICVM}              # Gets the currently attached VM
                    }                                                                       # End if ($NicVM)
                    $IPConfigList = $_.IPConfigurations                                     # IPConfigList is equal to current item .IPConfigurations
                    foreach ($_ in $IPConfigList) {                                         # For each item in $IPConfigList
                        $ObjectInput = [PSCustomObject]@{                                   # Creates $ObjectInput            
                            'Number'=$ObjectNumber;'Name'=$_.Name;`
                            'PrivIP'=$_.PrivateIPAddress;`
                            'PrivIPAllo'=$_.PrivateIpAllocationMethod;`
                            'PubIP'=$_.PublicIPAddress;'Pri'=$_.Primary;`
                            'NICName'=$NICName;'NICRG'=$NicRG;'NICVM'=$VMObject.Name        # Collects the information for the array
                        }                                                                   # End $ObjectInput = [PSCustomObject]
                        $ObjectArray.Add($ObjectInput) | Out-Null                           # Loads item into array, out-null removes write to screen
                        $ObjectNumber = $ObjectNumber +1                                    # Increments $ObjectNumber up by 1
                    }                                                                       # End foreach ($_ in $IPConfigList)
                    $NICName = $null                                                        # Clears $var
                    $NicRG = $null                                                          # Clears $var
                    $NicVM = $null                                                          # Clears $var
                    $VMObject = $null                                                       # Clears $var
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
                        $IPConfigList = $_.IPConfigurations                                 # IPConfigList is equal to current item .IPConfigurations
                        foreach ($_ in $IPConfigList) {                                     # For each item in $IPConfigList
                            $ObjectInput = [PSCustomObject]@{                               # Creates $ObjectInput            
                                'Number'=$ObjectNumber;'Name'=$_.Name;`
                                'PrivIP'=$_.PrivateIPAddress;`
                                'PrivIPAllo'=$_.PrivateIpAllocationMethod;`
                                'PubIP'=$_.PublicIPAddress;'Pri'=$_.Primary;`
                                'NICName'=$NICName;'NICRG'=$NicRG;'NICVM'=$VMObject.Name;`
                                'Type'='ScaleSetNic';'VmssName'=$VmssName;'VmssRG'=$VmssRG;`
                                'Etag'=$_.Etag                                              # Collects the information for the array
                            }                                                               # End $ObjectInput = [PSCustomObject]
                            $ObjectArray.Add($ObjectInput) | Out-Null                       # Loads item into array, out-null removes write to screen
                            $ObjectNumber = $ObjectNumber +1                                # Increments $ObjectNumber up by 1
                        }                                                                   # End foreach ($_ in $IPConfigList)
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
                Break GetAzureNICIpConfig                                                   # Breaks :GetAzureNICIpConfig
            }                                                                               # End if (!$ObjectArray)
            :SelectAzureNICIpConfig while ($true) {                                         # Inner loop for selecting the NIC IP config
                Clear-Host                                                                  # Clears screen
                Write-Host ''                                                               # Write message to screen
                Write-Host '[0]   Exit'                                                     # Write message to screen
                Write-Host ''                                                               # Write message to screen
                foreach ($_ in $ObjectArray) {                                              # For each item in $ObjectArray
                    $Number = $_.Number                                                     # $Number is equal to current item .Number
                    if ($Number -le 9) {                                                    # If $Number is 9 or less
                        Write-Host "[$Number]                   "$_.Name                    # Write message to screen
                    }                                                                       # End if ($Number -le 9)
                    else {                                                                  # If $Number is more than 9
                        Write-Host "[$Number]                  "$_.Name                     # Write message to screen
                    }                                                                       # End else (if ($Number -le 9))
                    Write-Host 'Private IP Address:   '$_.PrivIP                            # Write message to screen 
                    Write-Host 'Private IP Allocation:'$_.PrivIPAllo                        # Write message to screen
                    if ($_.PubIP) {                                                         # If current item .PubIP has a value
                        $PubID = $_.PubIP.ID                                                # Isolates the public IP sku ID
                        $PubIP = Get-AzPublicIpAddress | Where-Object {$_.ID -eq $PubID}    # Gets the public IP sku
                        Write-Host 'Public IP Address:    '$PubIP.IpAddress                 # Write message to screen
                        Write-Host 'Public IP Allocation: '$PubIP.PublicIpAllocationMethod  # Write message to screen
                    }                                                                       # End if ($_.PubIP)
                    Write-Host 'Is primary:           '$_.Pri                               # Write message to screen
                    Write-Host 'Nic Name:             '$_.NicName                           # Write message to screen
                    if ($_.NICVM) {                                                         # If current item .NICVM has a value
                        Write-Host 'Attached VM:          '$_.NicVM                         # Write message to screen
                    }                                                                       # End if ($_.NICVM)
                    Write-Host ''                                                           # Write message to screen
                }                                                                           # End foreach ($_ in $ObjectArray)
                if ($CallingFunction) {                                                     # If $CallingFunction has a value
                    Write-Host 'You are selecting the IP config for:'$CallingFunction       # Write message to screen
                }                                                                           # End if ($CallingFunction)
                $OpSelect = Read-Host 'Option [#]'                                          # Operator input to select the network config
                Clear-Host                                                                  # Clears screen
                if ($OpSelect -eq '0') {                                                    # If $OpSelect equals '0'
                    Break GetAzureNICIpConfig                                               # Breaks :GetAzureNICIpConfig
                }                                                                           # End if ($OpSelect -eq '0')
                elseif ($OpSelect -in $ObjectArray.Number) {                                # Else if $OpSelect in $ObjectArray.Name
                    $OpSelect = $ObjectArray | Where-Object {$_.Number -eq $OpSelect}       # $ObjectSelect is equal to $ObjectArray where $ObjectArray.Number equals $OpSelect
                    if ($OpSelect.Type -eq 'ScaleSetNic') {                                 # If $OpSelect.Type equals 'ScaleSetNic'
                        $NicObject = Get-AzNetworkInterface -VirtualMachineScaleSetName `
                            $OpSelect.VmssName -ResourceGroupName $OpSelect.VmssRG          # Gets the $NicObject
                        $NicIPConfigObject = $NicObject.IpConfigurations | Where-Object `
                        {$_.Etag -eq $OpSelect.Etag}                                        # Isolates NicIPConfigObject
                    }                                                                       # End if ($OpSelect.Type -eq 'ScaleSetNic')
                    else {                                                                  # Else if $OpSelect.Type does not equal 'ScaleSetNic'
                        $NicObject = Get-AzNetworkInterface -Name $OpSelect.NicName `
                            -ResourceGroupName $OpSelect.NicRG                              # Gets the $NicObject
                        $NicIPConfigObject = Get-AzNetworkInterfaceIpConfig `
                            -NetworkInterface $NicObject -Name $OpSelect.Name               # Gets the NicIPConfigObject
                    }                                                                       # End else (if ($OpSelect.Type -eq 'ScaleSetNic'))
                    Return $NicIPConfigObject,$NicObject                                    # Returns to calling function with $vars
                }                                                                           # End elseif ($OpSelect -in $ObjectArray.Number)
                else {                                                                      # All other inputs for $OpSelect
                    Write-Host 'That was not a valid input'                                 # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                }                                                                           # End else (if ($OpSelect -eq '0'))
            }                                                                               # End :SelectAzureNICIpConfig while ($true)
        }                                                                                   # End :GetAzureNICIpConfig while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function GetAzNICIpConfig
function RemoveAzNICIpConfig {                                                              # Function to Remove a NIC IP config
    Begin {                                                                                 # Begin function
        if (!$CallingFunction) {                                                            # If $CallingFunction is $null
            $CallingFunction = 'RemoveAzNICIpConfig'                                        # Creates $CallingFunction
        }                                                                                   # End if (!$CallingFunction)
        :RemoveAzureNICIpConfig while($true) {                                              # Outer loop for managing function
            $NicIPConfigObject,$NicObject = GetAzNICIpConfig ($CallingFunction)             # Calls function and assigns output to $vars
            if (!$NicIPConfigObject) {                                                      # If $NicIPConfigObject is $null
                Break RemoveAzureNICIpConfig                                                # Breaks :RemoveAzureNICIpConfig
            }                                                                               # End if (!$NicIPConfigObject) 
            if ($NICIPConfigObject.Primary -eq 'true') {                                    # If $NICIPConfigObject.Primary equals 'true'
                Write-Host ''                                                               # Write message to screen
                Write-Host 'This config is primary and cannot be removed'                   # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break RemoveAzureNICIpConfig                                                # Breaks :RemoveAzureNICIpConfig
            }                                                                               # End if ($NICIPConfigObject.Primary -eq 'true')
            Write-Host 'Remove the following:'                                              # Write message to screen
            Write-Host ''                                                                   # Write message to screen 
            Write-Host 'Config:'$NicIPConfigObject.name                                     # Write message to screen
            Write-Host 'NIC:   '$NicObject.Name                                             # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            $OpConfirm = Read-Host '[Y] Yes [N] No'                                         # Operator confirmation to remove the public IP sku
            Clear-Host                                                                      # Clears screen
            if ($OpConfirm -ne 'y') {                                                       # If $OpConfirm does not equal 'y'
                Write-Host 'No changes have been made'                                      # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break RemoveAzureNICIpConfig                                                # Breaks :RemoveAzureNICIpConfig
            }                                                                               # End if ($OpConfirm -ne 'y')
            Try {                                                                           # Try the following
                Write-Host 'Removing the IP configuration'                                  # Write message to screen
                Remove-AzNetworkInterfaceIpConfig -Name $NicIPConfigObject.Name `
                    -NetworkInterface $NicObject -ErrorAction 'Stop' | Out-Null             # Removes the selected configuration
                $NicObject | Set-AzNetworkInterface  -ErrorAction 'Stop' | Out-Null         # Saves the settings
            }                                                                               # End try
            Catch {                                                                         # If try fails
                Clear-Host                                                                  # Clears host
                Write-Host 'An error has occured'                                           # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Write-Host 'You may not have the permissions'                               # Write message to screen
                Write-Host 'to complete this action or'                                     # Write message to screen
                Write-Host 'the resource or resource group'                                 # Write message to screen
                Write-Host 'may be locked preventing changes'                               # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break RemoveAzureNICIpConfig                                                # Breaks RemoveAzureNICIpConfig
            }                                                                               # End catch            
            Clear-Host                                                                      # Clears host                                                          
            Write-Host 'The IP configuration has been removed'                              # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            Pause                                                                           # Pauses all actions for operator input
            Break RemoveAzureNICIpConfig                                                    # Breaks RemoveAzureNICIpConfig
        }                                                                                   # End :RemoveAzureNICIpConfig while($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function RemoveAzNICIpConfig
function SetAzNICIpConfig {                                                                 # Function to change the config private IP
    Begin {                                                                                 # Begin function
        if (!$CallingFunction) {                                                            # If $CallingFunction is $null
            $CallingFunction = 'SetAzNICIpConfig'                                           # Creates $CallingFunction
        }                                                                                   # End if (!$CallingFunction)
        :SetAzureNICIpConfig while($true) {                                                 # Outer loop for managing function
            $NicIPConfigObject,$NicObject = GetAzNICIpConfig ($CallingFunction)             # Calls function and assigns output to $vars
            if (!$NicIPConfigObject) {                                                      # If $NicIPConfigObject is $null
                Break SetAzureNICIpConfig                                                   # Breaks :SetAzureNICIpConfig
            }                                                                               # End if (!$NicIPConfigObject) 
            Write-Host 'Gathering current subnet info'                                      # Write message to screen
            [System.Collections.ArrayList]$ObjectArray = @()                                # Array that all info is loaded into
            $SubnetID = $NicIPConfigObject.Subnet.ID                                        # Isolates the subnet ID
            $VNetName = $SubnetID.Split('/')[8]                                             # Gets the virtual network name
            $VNetObject = Get-AzVirtualNetwork -Name $VNetName                              # Pulls the virtual network object
            $SubnetObject = Get-AzVirtualNetworkSubnetConfig -VirtualNetwork $VNetObject `
                | Where-Object {$_.ID -eq $SubnetID}                                        # Pulls the full subnet object
            $NicList = (Get-AzNetworkInterface | Where-Object `
                {$_.IpConfigurations.Subnet.ID -eq $SubnetID}).IpConfigurations             # Gets a list of all nic ip configurations on subnetID
            foreach ($_ in $NicList) {                                                      # For each item in $NicList
                $ObjectInput = [PSCustomObject]@{                                           # Creates $ObjectInput
                    'IP'=$_.PrivateIpAddress                                                # Adds vaules to $ObjectInput
                }                                                                           # End $ObjectInput = [PSCustomObject]@{
                $ObjectArray.Add($ObjectInput) | Out-Null                                   # Adds $ObjectInput to $ObjectArray
            }                                                                               # End foreach ($_ in $NicList)
            $NicList = $null                                                                # Clears $NicList
            $VmssList = Get-AzVmss                                                          # Gets a list of all virtual machine scale sets
            if ($VmssList) {                                                                # If $VmssList has a value
                foreach ($_ in $VmssList) {                                                 # For each item in $VmssList
                    $NicList = Get-AzNetworkInterface -VirtualMachineScaleSetName `
                        $_.Name -ResourceGroupName $_.ResourceGroupName                     # Gets a list of all nics on current item .Name
                    foreach ($_ in $NicList) {                                              # For each item in $NicList
                        if ($_.IpConfigurations.Subnet.ID -eq $SubnetID) {                  # If current item .IpConfigurations.Subnet.ID equals $SubnetID
                            $ObjectInput = [PSCustomObject]@{                               # Creates $ObjectInput
                                'IP'=$_.IPConfigurations.PrivateIPAddress                   # Adds vaules to $ObjectInput
                            }                                                               # End $ObjectInput = [PSCustomObject]@{
                            $ObjectArray.Add($ObjectInput) | Out-Null                       # Adds $ObjectInput to $ObjectArray
                        }                                                                   # End if ($_.IpConfigurations.Subnet.ID -eq $SubnetID)
                    }                                                                       # End foreach ($_ in $NicList)
                }                                                                           # End foreach ($_ in $VmssList)
            }                                                                               # End if ($VmssList)
            $LBList = Get-AzLoadBalancer | Where-Object `
                {$_.FrontendIpConfigurations.Subnet.ID -eq $SubnetID}                       # Gets a list of all load balancers with a front end in the $SubnetID
            if ($LBList) {                                                                  # If $LBList has a value
                foreach ($_ in $LBList) {                                                   # For each item in $LBList
                    $ObjectInput = [PSCustomObject]@{                                       # Creates $ObjectInput
                        'IP'=$_.FrontendIpConfigurations.PrivateIPAddress                   # Adds vaules to $ObjectInput
                    }                                                                       # End $ObjectInput = [PSCustomObject]@{
                    $ObjectArray.Add($ObjectInput) | Out-Null                               # Adds $ObjectInput to $ObjectArray
                }                                                                           # End foreach ($_ in $LBList)
            }                                                                               # End if ($LBList)
            Clear-Host                                                                      # Clears screen
            :SetAzureNICIP while ($true) {                                                  # Inner loop to set the IP address
                Write-Host 'Subnet Prefix:'$SubnetObject.AddressPrefix                      # Write message to screen
                Write-Host 'The following IPs are in use:'                                  # Write message to screen
                foreach ($_ in $ObjectArray) {                                              # For each item in $ObjectArray
                    Write-Host $_.IP                                                        # Write message to screen
                }                                                                           # End foreach ($_ in $ObjectArray)
                Write-Host ''                                                               # Write message to screen
                Write-Host 'Enter the IP address for:'$NicIPConfigObject.name               # Write message to screen
                $IPInput = Read-Host 'IP'                                                   # Operator input for the new IP addres
                Clear-Host                                                                  # Clears screen
                if ($IPInput -in $NicList.PrivateIPAddress) {                               # If $IPInput is in $NicList.PrivateIPAddress 
                    Write-Host 'That IP address is already in use'                          # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Clear-Host                                                              # Clears screen
                }                                                                           # End if ($IPInput -in $NicList.PrivateIPAddress)
                elseif ($IPInput -notlike '*.*.*.*') {                                      # Else if $IPInput is not like '*.*.*.*'
                    Write-Host 'That does not appear to be a valid IP'                      # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Clear-Host                                                              # Clears screen
                }                                                                           # End elseif ($IPInput -notlike '*.*.*.*')
                else {                                                                      # All other inputs for $IPInput
                    Write-Host 'Use:'$IPInput                                               # Write message to screen
                    Write-Host 'For:'$NicIPConfigObject.name                                # Write message to screen
                    $OpConfirm = Read-Host '[Y] Yes [N] No [E] Exit'                        # Operator confirmation of the IP address
                    Clear-Host                                                              # Clears screen
                    if ($OpConfirm -eq 'e') {                                               # If $OpConfirm equals 'e'
                        Break SetAzureNICIpConfig                                           # Breaks :SetAzureNICIpConfig
                    }                                                                       # End if ($OpConfirm -eq 'e')
                    elseif ($OpConfirm -eq 'y') {                                           # Else if $OpConfirm -eq 'y'
                        Break SetAzureNICIP                                                 # Breaks :SetAzureNICIP
                    }                                                                       # End elseif ($OpConfirm -eq 'y')
                }                                                                           # End else (if ($IPInput -in $NicList.PrivateIPAddress))
            }                                                                               # End :SetAzureNICIP while ($true)
            Try {                                                                           # Try the following
                Write-Host 'Setting IP config'                                              # Write message to screen
                $NicObject | Set-AzNetworkInterfaceIpConfig -Name $NicIPConfigObject.Name `
                    -PrivateIpAddress $IPInput -SubnetId $SubnetID -ErrorAction 'Stop'`
                    | Out-Null                                                              # Changes the config
                $NicObject | Set-AzNetworkInterface -ErrorAction 'Stop' | Out-Null          # Saves the config
            }                                                                               # End try
            Catch {                                                                         # If try fails
                Clear-Host                                                                  # Clears screen
                Write-Host 'An error has occured'                                           # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Write-Host 'The provided IP may fall into the'                              # Write message to screen
                Write-Host 'reserved range of the subnet'                                   # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Write-Host 'The provided IP may not be valid'                               # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Write-Host 'No changes made'                                                # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break SetAzureNICIpConfig                                                   # Breaks :SetAzureNICIpConfig
            }                                                                               # End catch
            Clear-Host                                                                      # Clears screen
            Write-Host 'The NIC IP config has been updated'                                 # Write message to screen
            Pause                                                                           # Pauses all actions for operator input
            Break SetAzureNICIpConfig                                                       # Breaks :SetAzureNICIpConfig
        }                                                                                   # End :SetAzureNICIpConfig while($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function SetAzNICIpConfig
function SetAzNICPriIPConfig {                                                              # Function to set the primary config
    Begin {                                                                                 # Begin function
        if (!$CallingFunction) {                                                            # If $CallingFunction is $null
            $CallingFunction = 'SetAzNICPriIPConfig'                                        # Creates $CallingFunction
        }                                                                                   # End if (!$CallingFunction)
        :SetAzureNICIpConfig while ($true) {                                                # Outer loop for managing function
            $NicIPConfigObject,$NicObject = GetAzNICIpConfig ($CallingFunction)             # Calls function and assigns output to $vars
            if (!$NicIPConfigObject) {                                                      # If $NicIPConfigObject is $null
                Break SetAzureNICIpConfig                                                   # Breaks :SetAzureNICIpConfig
            }                                                                               # End if (!$NicIPConfigObject)
            if ($NicObject.VirtualMachine) {                                                # If $NicObject.VirtualMachine has a value 
                $VMID = $NicObject.VirtualMachine.Id                                        # Isolates the VM ID
                $VMObject = Get-AzVM | Where-Object {$_.ID -eq $VMID}                       # Gets the currently attached VM
                Write-Host ''                                                               # Write message to screen
                Write-Host 'This nic is currently attached to the following:'               # Write message to screen
                Write-Host 'VM Name:'$VMObject.Name                                         # Write message to screen
                Write-Host 'VM RG  :'$VMObject.ResourceGroupName                            # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Write-Host 'This NIC cannot be updated while attached'                      # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break SetAzureNICIpConfig                                                   # Breaks :SetAzureNICIpConfig
            }                                                                               # End if ($NicObject.VirtualMachine)
            if ($NicIPConfigObject.Primary -eq 'True') {                                    # If $NicIPConfigObject.Primary equals 'True'
                Write-Host 'This configuration is already the primary'                      # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break SetAzureNICIpConfig                                                   # Breaks :SetAzureNICIpConfig
            }                                                                               # End if ($NicIPConfigObject.Primary -eq 'True')
            Write-Host 'Set the following as the primary config'                            # Write message to screen
            Write-Host 'Config:'$NicIPConfigObject.Name                                     # Write message to screen
            Write-Host 'On Nic:'$NicObject.Name                                             # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            $OpConfirm = Read-Host '[Y] Yes [N] No'                                         # Operator confirmation of change
            Clear-Host                                                                      # Clears screen
            if ($OpConfirm -ne 'y') {                                                       # If $OpConfirm does not equal 'y'
                Break SetAzureNICIpConfig                                                   # Breaks :SetAzureNICIpConfig
            }                                                                               # End if ($OpConfirm -ne 'y')
            $SubnetID = $NicIPConfigObject.Subnet.ID                                        # Isolates the subnet ID
            Try {                                                                           # Try the following
                Write-Host 'Updating primary config on:'$NicObject.Name                     # Write message to screen
                $NicObject | Set-AzNetworkInterfaceIpConfig -Name $NicIPConfigObject.Name `
                    -SubnetId $SubnetID -Primary -ErrorAction 'Stop' | Out-Null             # Changes the config
                $NicObject | Set-AzNetworkInterface -ErrorAction 'Stop' | Out-Null          # Saves the config
            }                                                                               # End Try
            Catch {                                                                         # If Try fails
                Clear-Host                                                                  # Clears screen
                Write-Host 'An error has occured'                                           # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break SetAzureNICIpConfig                                                   # Breaks SetAzureNICIpConfig
            }                                                                               # End Catch
            Clear-Host                                                                      # Clears screen
            Write-Host 'The primary config has been changed'                                # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            Pause                                                                           # Pauses all actions for operator input
            Break SetAzureNICIpConfig                                                       # Breaks :SetAzureNICIpConfig
        }                                                                                   # End :SetAzureNICIpConfig while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin       
}                                                                                           # End function SetAzNICPriIPConfig
function SetAzNICIpConPublicIP {                                                            # Function to change the config public IP
    Begin {                                                                                 # Begin function
        if (!$CallingFunction) {                                                            # If $CallingFunction is $null
            $CallingFunction = 'SetAzNICIpConPublicIP'                                      # Creates $CallingFunction
        }                                                                                   # End if (!$CallingFunction)
        :SetAzureNICIpConfig while($true) {                                                 # Outer loop for managing function
            $NicIPConfigObject,$NicObject = GetAzNICIpConfig ($CallingFunction)             # Calls function and assigns output to $vars
            if (!$NicIPConfigObject) {                                                      # If $NicIPConfigObject is $null
                Break SetAzureNICIpConfig                                                   # Breaks :SetAzureNICIpConfig
            }                                                                               # End if (!$NicIPConfigObject)
            $PublicIPObject = GetAzPublicIpAddress ($CallingFunction)                       # Calls function and assigns output to $var
            if (!$PublicIPObject) {                                                         # If $PublicIPObject is $null
                Break SetAzureNICIpConfig                                                   # Breaks :SetAzureNICIpConfig
            }                                                                               # End if (!$PublicIPObject)
            Try {                                                                           # Try the following
                Write-Host 'Adding the public IP'                                           # Write message to screen
                $NicObject | Set-AzNetworkInterfaceIpConfig -Name $NicIPConfigObject.Name `
                    -PublicIpAddressId $PublicIPObject.ID -SubnetId `
                    $NicIPConfigObject.Subnet.ID -ErrorAction 'Stop' | Out-Null             # Adds $PublicIPObject to $NicIPConfigObject
                $NicObject | Set-AzNetworkInterface -ErrorAction 'Stop' | Out-Null          # Saves $NicObject config
            }                                                                               # End try
            catch {                                                                         # If try fails
                Clear-Host                                                                  # Clears screen
                Write-Host 'An error has occured'                                           # Write message to screen
                Write-Host 'You may not have the permissions to do this'                    # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break SetAzureNICIpConfig                                                   # Breaks :SetAzureNICIpConfig
            }                                                                               # End catch
            Clear-Host                                                                      # Clears screen
            Write-Host 'Nic IP configuration has been updated'                              # Write message to screen
            Pause                                                                           # Pauses all actions for operator input
            Break SetAzureNICIpConfig                                                       # Breaks :SetAzureNICIpConfig
        }                                                                                   # End :SetAzureNICIpConfig while($true)
        Clear-Host                                                                          # Clears screen
        Return                                                                              # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function SetAzNICIpConPublicIP
function RemoveAzNICIpConPublicIP {                                                         # Function to remove the config public IP
    Begin {                                                                                 # Begin function
        if (!$CallingFunction) {                                                            # If $CallingFunction is $null
            $CallingFunction = 'RemoveAzNICIpConPublicIP'                                   # Creates $CallingFunction
        }                                                                                   # End if (!$CallingFunction)
        :SetAzureNICIpConfig while($true) {                                                 # Outer loop for managing function
            $NicIPConfigObject,$NicObject = GetAzNICIpConfig ($CallingFunction)             # Calls function and assigns output to $vars
            if (!$NicIPConfigObject) {                                                      # If $NicIPConfigObject is $null
                Break SetAzureNICIpConfig                                                   # Breaks :SetAzureNICIpConfig
            }                                                                               # End if (!$NicIPConfigObject)
            elseif (!$NicIPConfigObject.PublicIPAddress) {                                  # Else if $NicIPConfigObject.PublicIPAddress is $null
                Write-Host 'This IP config does not have an associated public IP sku'       # Write message to screen
                Write-Host 'No changes have been made'                                      # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break SetAzureNICIpConfig                                                   # Breaks :SetAzureNICIpConfig
            }                                                                               # End elseif (!$NicIPConfigObject.PublicIPAddress)
            Write-Host ''                                                                   # Write message to screen 
            Write-Host 'Config:'$NicIPConfigObject.name                                     # Write message to screen
            Write-Host 'NIC:   '$NicObject.Name                                             # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            $OpConfirm = Read-Host '[Y] Yes [N] No'                                         # Operator confirmation to remove the public IP sku
            Clear-Host                                                                      # Clears screen
            if ($OpConfirm -ne 'y') {                                                       # If $OpConfirm does not equal 'y'
                Write-Host 'No changes have been made'                                      # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break SetAzureNICIpConfig                                                   # Breaks :SetAzureNICIpConfig
            }                                                                               # End if ($OpConfirm -ne 'y')
            $SubnetID = $NicIPConfigObject.Subnet.ID                                        # Isolates the subnet ID
            Try {                                                                           # Try the following
                Write-Host 'Removing the public IP from this config'                        # Write message to screen
                $NicObject | Set-AzNetworkInterfaceIpConfig -Name $NicIPConfigObject.Name `
                    -PublicIpAddressId $null -SubnetId $SubnetID -ErrorAction 'Stop' `
                    | Out-Null                                                              # Removed $PublicIPObject to $NicIPConfigObject
                $NicObject | Set-AzNetworkInterface -ErrorAction 'Stop' | Out-Null          # Saves $NicObject config
            }                                                                               # End try
            catch {                                                                         # If try fails                
                Clear-Host                                                                 # Clears screen
                Write-Host 'An error has occured'                                           # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Write-Host 'You may not have the permissions'                               # Write message to screen
                Write-Host 'to complete this action or'                                     # Write message to screen
                Write-Host 'the resource or resource group'                                 # Write message to screen
                Write-Host 'may be locked preventing changes'                               # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break SetAzureNICIpConfig                                                   # Breaks :SetAzureNICIpConfig
            }                                                                               # End catch
            Clear-Host                                                                      # Clears screen
            Write-Host 'Nic IP configuration has been updated'                              # Write message to screen
            Pause                                                                           # Pauses all actions for operator input
            Break SetAzureNICIpConfig                                                       # Breaks :SetAzureNICIpConfig
        }                                                                                   # End :SetAzureNICIpConfig while($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function RemoveAzNICIpConPublicIP
# Additional functions required for ManageAzNICIpConfig
function GetAzPublicIpAddress {                                                             # Function for getting a public IP sku
    Begin {                                                                                 # Begin function
        :GetAzurePublicIP while ($true) {                                                   # Outer loop for managing function
            $PublicIPList = Get-AzPublicIpAddress                                           # Gets a list of all public IP address
            [System.Collections.ArrayList]$PublicIPArray = @()                              # Creates array for list to be loaded into
            $PublicIPNumber = 1                                                             # Creates #var used for list selection
            foreach ($_ in $PublicIPList) {                                                 # For each item in list
                if ($_.IpConfiguration.Id) {                                                # If current item .IpConfiguration.Id has a value
                    $AttachedNIC = ($_.IpConfiguration.Id).Split('/')[-3]                   # Gets the attached NIC name
                    $AttachedNICIPConfig = ($_.IpConfiguration.Id).Split('/')[-1]           # Gets the attached NIC IP config name
                }                                                                           # End if ($_.IpConfiguration.Id) 
                $PublicIPInput = [PSCustomObject]@{'Number'=$PublicIPNumber;`
                    'Name' = $_.Name;'RG'=$_.ResourceGroupName;'Sku'=$_.Sku.Name;`
                    'Allocation'=$_.PublicIpAllocationMethod;'Address'=$_.IPAddress;'NIC'=`
                    $AttachedNIC;'IPconfig'=$AttachedNICIPConfig}                           # Creates the item to loaded into array
                $PublicIPArray.Add($PublicIPInput) | Out-Null                               # Loads item into array, out-null removes write to screen
                $PublicIPNumber = $PublicIPNumber + 1                                       # Increments $var up by 1
                $AttachedNIC = $null                                                        # Clears $var
                $AttachedNICIPConfig = $null                                                # Clears $var
            }                                                                               # End foreach ($_ in $PublicIPArray)
            Write-Host "[0] to exit"                                                        # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            foreach ($_ in $PublicIPArray) {                                                # For each item in list
                $Number = $_.Number                                                         # Creats $Number (Used for formating)
                Write-Host "[$Number]         "$_.Name                                      # Write message to screen
                Write-Host "RG Name:    "$_.RG                                              # Write message to screen
                Write-Host "Allocation: "$_.Allocation                                      # Write message to screen
                Write-Host "IP Address: "$_.address                                         # Write message to screen
                Write-Host "SKU Type:   "$_.Sku                                             # Write message to screen
                if ($_.Nic) {                                                               # If current item .Nic has a value
                    Write-Host "NIC Name:   "$_.Nic                                         # Write message to screen
                    Write-Host "NIC Config: "$_.IPConfig                                    # Write message to screen
                }                                                                           # End if ($_.Nic)                                 
                Write-Host ""                                                               # Write message to screen
            }                                                                               # End foreach ($_ in $PublicIPArray) 
            :SelectAzurePublicIP while ($true) {                                            # Inner loop for selecting the public IP
                if ($CallingFunction) {                                                     # If $Calling function has a value
                    Write-Host 'You are selecting the Public IP Sku for:'$CallingFunction   # Write message to screen
                }                                                                           # End if ($CallingFunction)
                $SelectPublicIP = Read-Host "Enter the list number for public IP"           # Operator input for the public IP selection
                if ($SelectPublicIP -eq '0') {                                              # If $var equals 0
                    Break GetAzurePublicIP                                                  # Breaks :GetAzurePublicIP
                }                                                                           # End if ($SelectPublicIP -eq '0')
                elseif ($SelectPublicIP -in $PublicIPArray.Number) {                        # If $SelectPublicIP in $PublicIPArray.Number list
                    $SelectPublicIP = $PublicIPArray | Where-Object `
                        {$_.Number -eq $SelectPublicIP}                                     # SelectPublicIP is equal to $PublicIPArray where $PublicIPArray.Number equals $SelectPublicIP
                    $PublicIPObject = Get-AzPublicIpAddress -Name $SelectPublicIP.Name `
                        -ResourceGroupName $SelectPublicIP.RG                               # Pulls $PublicIPObject
                    if ($PublicIPObject) {                                                  # If $PublicIPObject has a value
                        Return $PublicIPObject                                              # Returns to calling function with $PublicIPObject
                    }                                                                       # End if ($PublicIPObject)
                    else {                                                                  # If $PublicIPObject is $null
                        Write-Host "An error has occured"                                   # Write message to screen
                        Break GetAzurePublicIP                                              # Breaks :GetAzurePublicIP
                    }                                                                       # End else (if ($PublicIPObject))
                }                                                                           # End elseif ($SelectPublicIP -in $PublicIPArray.Number)
                else {                                                                      # All other values
                    Write-Host "That was not a valid option"                                # Write message to screen
                }                                                                           # End else (if ($SelectPublicIP -eq '0'))
            }                                                                               # End :SelectAzurePublicIP while ($true)
        }                                                                                   # End :GetAzurePublicIP while ($true)
        Return                                                                              # Returns to calling function with $null
    }                                                                                       # End begin
}                                                                                           # End function GetAzPublicIpAddress
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
                        $ObjectInput = [PSCustomObject]@{
                            'Number'=$ListNumber;'NicName'=$_.Name;'NicRG'=`
                            $_.ResourceGroupName;'SubName'=$Subnetname;'SubPFX'=$SubnetPFX;`
                            'VNetName'=$VNet;'VnetPFX'=$VnetPFX;'VnetRG'= $VNetRG;`
                            'VM'=$_.VirtualMachine.ID;'IPCon'=$_.IpConfigurations;`
                            'Type'='NIC'
                        }                                                                   # Creates the item to loaded into array
                        $ObjectArray.Add($ObjectInput) | Out-Null                           # Loads item into array, out-null removes write to screen
                        $ListNumber = $ListNumber + 1                                       # Increments $ListNumber by 1
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
                            'Number'=$ListNumber;'NicName'=$_.Name;'NicRG'=`
                            $_.ResourceGroupName;'SubName'=$Subnetname;'SubPFX'=$SubnetPFX;`
                            'VNetName'=$VNetname;'VnetPFX'=$VnetPFX;'VnetRG'= $VNetRG;`
                            'VM'=$_.VirtualMachine.ID;'IPCon'=$_.IpConfigurations;`
                            'Type'='Scaleset';'VmssName'=$VmssName;'VmssRg'=$VmssRG
                        }                                                                   # Creates the item to loaded into array
                        $ObjectArray.Add($ObjectInput) | Out-Null                           # Loads item into array, out-null removes write to screen
                        $ListNumber = $ListNumber + 1                                       # Increments $ListNumber by 1
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