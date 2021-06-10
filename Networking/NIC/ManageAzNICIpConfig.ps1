# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Mircosoft docs links
    New-AzNetworkInterface:     https://docs.microsoft.com/en-us/powershell/module/az.network/new-aznetworkinterface?view=azps-5.6.0
    Get-AzNetworkInterface:     https://docs.microsoft.com/en-us/powershell/module/az.network/get-aznetworkinterface?view=azps-5.4.0
    Remove-AzNetworkInterface:  https://docs.microsoft.com/en-us/powershell/module/az.network/remove-aznetworkinterface?view=azps-5.6.0
    Get-AzVirtualNetwork:       https://docs.microsoft.com/en-us/powershell/module/az.network/get-azvirtualnetwork?view=azps-5.4.0
    Add-AzNetworkInterface:     https://docs.microsoft.com/en-us/powershell/module/az.network/add-aznetworkinterface?view=azps-5.6.0
    Set-AzNetworkInterface:     https://docs.microsoft.com/en-us/powershell/module/az.network/set-aznetworkinterface?view=azps-5.6.0
    Get-AzNetworkInterfaceIPConfig: https://docs.microsoft.com/en-us/powershell/module/az.network/get-aznetworkinterfaceipconfig?view=azps-5.6.0
    Remove-AzNetworkInterfaceIPConfig: https://docs.microsoft.com/en-us/powershell/module/az.network/Remove-aznetworkinterfaceipconfig?view=azps-5.6.0
    New-AzPublicIpAddress:      https://docs.microsoft.com/en-us/powershell/module/az.network/new-azpublicipaddress?view=azps-5.5.0
    Get-AzPublicIpAddress:      https://docs.microsoft.com/en-us/powershell/module/az.network/get-azpublicipaddress?view=azps-5.5.0 
    Get-AzVirtualNetwork:       https://docs.microsoft.com/en-us/powershell/module/az.network/get-azvirtualnetwork?view=azps-5.4.0
    Get-AzResourceGroup:        https://docs.microsoft.com/en-us/powershell/module/az.resources/get-azresourcegroup?view=azps-5.1.0
    Get-AzLocation:             https://docs.microsoft.com/en-us/powershell/module/az.resources/get-azlocation?view=azps-5.4.0
    Get-AzVirtualNetworkSubnetConfig: https://docs.microsoft.com/en-us/powershell/module/az.network/get-azvirtualnetworksubnetconfig?view=azps-5.4.0
    Get-AzVirtualNetwork:       https://docs.microsoft.com/en-us/powershell/module/az.network/get-azvirtualnetwork?view=azps-5.4.0
} #>
<# Required Functions Links: {
    NewAzNetworkInterface:      https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/NIC/NewAzNetworkInterface.ps1
    GetAzNetworkInterface:      https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/NIC/GetAzNetworkInterface.ps1
    RemoveAzNetworkInterface:   https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/NIC/RemoveAzNetworkInterface.ps1   
    AddAzNICIpConfig:           https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/NIC/AddAzNICIpConfig.ps1
    ListAzNICIpConfig:          https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/NIC/ListAzNICIpConfig.ps1
    SetAzNICIpConfig:           https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/NIC/SetAzNICIpConfig.ps1
    RemoveAzNICIpConfig:        https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/NIC/RemoveAzNICIpConfig.ps1
    NewAzPublicIPAddress:       https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/Public%20IP/NewAzPublicIpAddress.ps1
    GetAzPublicIpAddress:       https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/Public%20IP/GetAzPublicIpAddress.ps1
    GetAzResourceGroup:         https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/GetAzResourceGroup.ps1
    GetAzLocation:              https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/GetAzLocation.ps1
    GetAzVNetSubnetConfig:      https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/SubNet/GetAzVNetSubnetConfig.ps1
} #>
<# Functions Description: {
    ManageAzNetworkInterface:   Management function for network interfaces
    NewAzNetworkInterface:      Creates new network interfaces
    GetAzNetworkInterface:      Gets an existing network interface
    RemoveAzNetworkInterface:   Removes a network interface   
    AddAzNICIpConfig:           Creates a new empty IP config
    SetAzNICIpConfig:           Applies settings to existing IP config
    RemoveAzNICIpConfig:        Removes a NIC IP configuration
    NewAzPublicIPAddress:       Creates a new public IP address
    GetAzPublicIpAddress:       Gets a new public IP address
    GetAzVNetSubnetConfig:      Gets an azure virtual network subnet
    GetAzResourceGroup:         Gets a resource group
    GetAzLocation:              Gets an azure location
    
} #>
<# Variables: {
    :ManageAzureNicIPConfig     Outer loop for managing function
    $OpSelect:                  Operator input for selecting function
} #>
<# Process Flow {
    Function
        Call ManageAzNetworkInterface > Get $SubnetObject
            Call NewAzNetworkInterface > Get $NicObject
                Call GetAzResourceGroup > Get $RGObject
                End GetAzResourceGroup
                    Return NewAzNetworkInterface > Send $RGObject
                Call GetAzLocation > Get $LocationObject
                End GetAzLocation
                    Return NewAzNetworkInterface > Send $LocationObject
                Call GetAzVNetSubnetConfig > Get $SubnetObject
                End GetAzVNetSubnetConfig
                    Return NewAzNetworkInterface > Send $SubnetObject
                End NewAzNetworkInterface
                    Return ManageAzNetworkInterface > Send $NicObject
            Call GetAzNetworkInterface > Get $NicObject
            End GetAzNetworkInterface
                Return ManageAzNetworkInterface > Send $NicObject
            Call RemoveAzNetworkInterface > Get $null
                Call GetAzNetworkInterface > Get $NicObject
                End GetAzNetworkInterface
                    Return RemoveAzNetworkInterface > Send $NicObject
            End RemoveAzNetworkInterface
                Return ManageAzNetworkInterface > Send $null
            Call AddAzNICIpConfig > Get $NicObject
                Call NewAzNetworkInterface > Get $NicObject
                    Call GetAzResourceGroup > Get $RGObject
                    End GetAzResourceGroup
                        Return NewAzNetworkInterface > Send $RGObject
                    Call GetAzLocation > Get $LocationObject
                    End GetAzLocation
                        Return NewAzNetworkInterface > Send $LocationObject
                    Call GetAzVNetSubnetConfig > Get $SubnetObject
                    End GetAzVNetSubnetConfig
                        Return NewAzNetworkInterface > Send $SubnetObject
                End NewAzNetworkInterface
                    Return AddAzNICIpConfig > Send $NicObject
                Call GetAzNetworkInterface > Get $NicObject
                End GetAzNetworkInterface
                    Return AddAzNICIpConfig > $NicObject
            End AddAzNICIpConfig
                Return ManageAzNetworkInterface > Send $NicObject
            Call ListAzNICIpConfig > Get $null
            End ListAzNICIpConfig
                Return ManageAzNetworkInterface > Send $Null
            Call SetAzNICIpConfig > Get $NicObject
                Call NewAzNetworkInterface > Get $NicObject
                    Call GetAzResourceGroup > Get $RGObject
                    End GetAzResourceGroup
                        Return NewAzNetworkInterface > Send $RGObject
                    Call GetAzLocation > Get $LocationObject
                    End GetAzLocation
                        Return NewAzNetworkInterface > Send $LocationObject
                    Call GetAzVNetSubnetConfig > Get $SubnetObject
                    End GetAzVNetSubnetConfig
                        Return NewAzNetworkInterface > Send $SubnetObject
                End NewAzNetworkInterface
                    Return SetAzNICIpConfig > Send $NicObject
                Call GetAzNetworkInterface > Get $NicObject
                End GetAzNetworkInterface
                    Return SetAzNICIpConfig > $NicObject
                Call NewAzPublicIpAddress > Get $PublicIPObject
                    Call GetAzResourceGroup > Get $RGObject
                    End GetAzResourceGroup
                        Return NewAzPublicIpAddress > Send $RGObject
                End NewAzPublicIpAddress
                    Return SetAzNICIpConfig > Send $PublicIPObject
                Call GetAzPublicIpAddress{}      Gets $PublicIPObject
                End NewAzPublicIpAddress
                    Return SetAzNICIpConfig > Send $PublicIPObject
            End SetAzNICIpConfig
                Return function > Send $NicObject
            Call RemoveAzNICIpConfig > Get $NicObject
                Call GetAzNetworkInterface > Get $NicObject
                End GetAzNetworkInterface
                    Return RemoveAzNICIpConfig > $NicObject
            End RemoveAzNICIpConfig
                Return ManageAzNetworkInterface > Send $NicObject
        End ManageAzNetworkInterface
            Return function > Send $NicObject
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
            Try {                                                                           # Try the following
                Write-Host 'Addinging the IP config'                                        # Write message to screen
                Add-AzNetworkInterfaceIpConfig -Name $NicIPConfigName -NetworkInterface `
                    $NicObject -SubnetId $SubnetObject.ID                                   # Adds the new config
                $NicObject | Set-AzNetworkInterface                                         # Saves the changes
            }                                                                               # End try
            catch {                                                                         # If Try fails
                Clear-Host                                                                  # Clears screen
                Write-Host 'An error has occured'                                           # Write message to the screen
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
function GetAzNICIpConfig {                                                                 # Function to get network interface config
    Begin {                                                                                 # Begin function
        :GetAzureNICIpConfig while ($true) {                                                # Outer loop for managing function
            $ObjectList = Get-AzNetworkInterface                                            # Gets a list of all NICs
            $ObjectNumber = 1                                                               # Creates $ObjectNumber
            [System.Collections.ArrayList]$ObjectArray = @()                                # Array that all info is loaded into
            foreach ($_ in $ObjectList) {                                                   # For each item in $ObjectList
                $NICName = $_.Name                                                          # $NICName is equal to current item .Name
                $NicRG = $_.ResourceGroupName
                $IPConfigList = $_.IPConfigurations                                         # IPConfigList is equal to current item .IPConfigurations
                foreach ($_ in $IPConfigList) {                                             # For each item in $IPConfigList
                    $ObjectInput = [PSCustomObject]@{                                       # Creates $ObjectInput
                        'Number'=$ObjectNumber;'Name'=$_.Name;`
                        'PrivIP'=$_.PrivateIPAddress;`
                        'PrivIPAllo'=$_.PrivateIpAllocationMethod;`
                        'PubIP'=$_.PublicIPAddress;'Pri'=$_.Primary;`
                        'NICName'=$NICName;'NICRG'=$NicRG                                   # Collects the information for the array
                    }                                                                       # End $ObjectInput = [PSCustomObject]
                    $ObjectArray.Add($ObjectInput) | Out-Null                               # Loads item into array, out-null removes write to screen
                    $ObjectNumber = $ObjectNumber +1                                        # Increments $ObjectNumber up by 1
                }                                                                           # End foreach ($_ in $IPConfigList)
            }                                                                               # End foreach ($_ in $ObjectList)
            :SelectAzureNICIpConfig while ($true) {                                         # Inner loop for selecting the NIC IP config
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
                elseif ($OpSelect -in $ObjectArray.Number) {
                    $OpSelect = $ObjectArray | Where-Object {$_.Number -eq $OpSelect}       # $ObjectSelect is equal to $ObjectArray where $ObjectArray.Number equals $OpSelect
                    $NicObject = Get-AzNetworkInterface -Name $OpSelect.NicName `
                        -ResourceGroupName $OpSelect.NicRG                                  # Gets the $NicObject
                    $NicIPConfigObject = Get-AzNetworkInterfaceIpConfig -NetworkInterface `
                        $NicObject -Name $OpSelect.Name                                     # Gets the NicIPConfigObject
                    Return $NicIPConfigObject,$NicObject                                    # Returns to calling function with $vars
                }                                                                           # End elseif ($OpSelect -in $ObjectArray.Number)
                else {                                                                      # All other inputs for $OpSelect
                    Write-Host 'That was not a valid input'                                 # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Clear-Host                                                              # Clears screen
                }                                                                           # End else (if ($OpSelect -eq '0'))
            }                                                                               # End :SelectAzureNICIpConfig while ($true)
        }                                                                                   # End :GetAzureNICIpConfig while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function GetAzNICIpConfig
function SetAzNICIpConfig {                                                                 # Function to add change the config private IP
    Begin {                                                                                 # Begin function
        if (!$CallingFunction) {                                                            # If $CallingFunction is $null
            $CallingFunction = 'SetAzNICIpConfig'                                           # Creates $CallingFunction
        }                                                                                   # End if (!$CallingFunction)
        :SetAzureNICIpConfig while($true) {                                                 # Outer loop for managing function
            $NicIPConfigObject,$NicObject = GetAzNICIpConfig                                # Calls function and assigns output to $vars
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
            Write-Host 'Gathering current subnet info'                                      # Write message to screen
            $SubnetID = $NicIPConfigObject.Subnet.ID                                        # Isolates the subnet ID
            $VNetName = $SubnetID.Split('/')[8]                                             # Gets the virtual network name
            $VNetObject = Get-AzVirtualNetwork -Name $VNetName                              # Pulls the virtual network object
            $SubnetObject = Get-AzVirtualNetworkSubnetConfig -VirtualNetwork $VNetObject `
                | Where-Object {$_.ID -eq $SubnetID}                                        # Pulls the full subnet object
            $NicList = (Get-AzNetworkInterface | Where-Object `
                {$_.IpConfigurations.Subnet.ID -eq $SubnetID}).IpConfigurations             # Gets a list of all nic ip configurations on subnetID
            Clear-Host                                                                      # Clears screen
            :SetAzureNICIP while ($true) {                                                  # Inner loop to set the IP address
                Write-Host 'Subnet Prefix:'$SubnetObject.AddressPrefix                      # Write message to screen
                Write-Host 'The following IPs are in use:'                                  # Write message to screen
                foreach ($_ in $NicList) {                                                  # For each item in $NicList
                    Write-Host 'IP:'$_.PrivateIpAddress                                     # Write message to screen
                }                                                                           # End foreach ($_ in $NicList)
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
            $NicIPConfigObject,$NicObject = GetAzNICIpConfig                                # Calls function and assigns output to $vars
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
            $NicIPConfigObject,$NicObject = GetAzNICIpConfig                                # Calls function and assigns output to $vars
            if (!$NicIPConfigObject) {                                                      # If $NicIPConfigObject is $null
                Break SetAzureNICIpConfig                                                   # Breaks :SetAzureNICIpConfig
            }                                                                               # End if (!$NicIPConfigObject)
            $PublicIPObject = GetAzPublicIpAddress ($CallingFunction)                       # Calls function and assigns output to $var
            if (!$PublicIPObject) {                                                         # If $PublicIPObject is $null
                Break SetAzureNICIpConfig                                                   # Breaks :SetAzureNICIpConfig
            }                                                                               # End if (!$PublicIPObject)
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
            Try {                                                                           # Try the following
                $NicObject | Set-AzNetworkInterfaceIpConfig -Name $NicIPConfigObject.Name `
                    -PublicIpAddressId $PublicIPObject.ID -SubnetId `
                    $NicIPConfigObject.Subnet.ID -ErrorAction 'Stop' | Out-Null             # Adds $PublicIPObject to $NicIPConfigObject
                $NicObject | Set-AzNetworkInterface -ErrorAction 'Stop' | Out-Null          # Saves $NicObject config
            }                                                                               # End try
            catch {                                                                         # If try fails
                Write-Host 'An error has occured'                                           # Write message to screen
                Write-Host 'You may not have the permissions to do this'                    # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break SetAzureNICIpConfig                                                   # Breaks :SetAzureNICIpConfig
            }                                                                               # End catch
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
            $NicIPConfigObject,$NicObject = GetAzNICIpConfig                                # Calls function and assigns output to $vars
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
            Write-Host 'Remove the public IP from'                                          # Write message to screen
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
                $NicObject | Set-AzNetworkInterfaceIpConfig -Name $NicIPConfigObject.Name `
                    -PublicIpAddressId $null -SubnetId $SubnetID -ErrorAction 'Stop' `
                    | Out-Null                                                              # Removed $PublicIPObject to $NicIPConfigObject
                $NicObject | Set-AzNetworkInterface -ErrorAction 'Stop' | Out-Null          # Saves $NicObject config
            }                                                                               # End try
            catch {                                                                         # If try fails
                Write-Host 'An error has occured'                                           # Write message to screen
                Write-Host 'You may not have the permissions to do this'                    # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break SetAzureNICIpConfig                                                   # Breaks :SetAzureNICIpConfig
            }                                                                               # End catch
            Write-Host 'Nic IP configuration has been updated'                              # Write message to screen
            Pause                                                                           # Pauses all actions for operator input
            Break SetAzureNICIpConfig                                                       # Breaks :SetAzureNICIpConfig
        }                                                                                   # End :SetAzureNICIpConfig while($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function RemoveAzNICIpConPublicIP
function RemoveAzNICIpConfig {                                                              # Function to Remove a NIC IP config
    Begin {                                                                                 # Begin function
        :RemoveAzureNICIpConfig while($true) {                                              # Outer loop for managing function
            if (!$CallingFunction) {                                                        # If $CallingFunction is $null
                $CallingFunction = 'RemoveAzNICIpConfig'                                    # Creates $CallingFunction
            }                                                                               # End if (!$CallingFunction)
            if (!$NicObject) {                                                              # If $NicObject is $null
                $NicObject, $SubnetObject, $VnetObject = GetAzNetworkInterface `
                        ($CallingFunction)                                                  # Calls function and assigns output to $var
                if (!$NicObject) {                                                          # If $NicObject is $null
                    Break RemoveAzureNICIpConfig                                            # Breaks :RemoveAzureNICIpConfig
                }                                                                           # End if (!$NicObject)    
            }                                                                               # End if (!$NicObject)
            :GetAzureNicIPConfig while ($true) {                                            # Inner loop for selecting the nic IP config
                $NicIPList = $NicObject.IPConfigurations                                    # Gets list of all existing IP configs
                $ListNumber = 1                                                             # Sets list number for $ListArray
                [System.Collections.ArrayList]$ListArray = @()                              # Array used to present information
                foreach ($_ in $NicIPList) {                                                # For each item in $NicIPList
                    $ListInput = [PSCustomObject]@{'Number'=$ListNumber;'Primary' `
                        =$_.Primary;'name'=$_.Name;'PrivIP'=$_.PrivateIPAddress; `
                        'PrivAllo'=$_.PrivateIpAllocationMethod}                            # Adds info to $ListInput   
                    $ListArray.Add($ListInput) | Out-Null                                   # Loads content of $ListInput into $ListArray
                    $ListNumber = $ListNumber + 1                                           # Increments $ListNumber up by one
                }                                                                           # End foreach ($_ in $NicIPList)
                Write-Host '[ 0 ] Exit'                                                     # Write message to screen
                Write-Host ''                                                               # Write message to screen
                foreach ($_ in $ListArray) {                                                # For each item in $ListArray
                    Write-Host '['$_.Number']'                                              # Write message to screen
                    Write-Host 'Name:    '$_.Name                                           # Write message to screen
                    Write-Host 'Primary: '$_.Primary                                        # Write message to screen
                    Write-Host 'PrivIP:  '$_.PrivIP                                         # Write message to screen
                    Write-Host 'PrivAllo:'$_.PrivAllo                                       # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                }                                                                           # End foreach ($_ in $ListArray)
                :SelectAzureNicIPConfig while ($true) {                                     # Inner loop for selecting the IP configuration
                    $OperatorSelect = Read-Host 'Select [#] of Nic IP config'               # Operator input for selecting the IP config
                    if ($OperatorSelect -eq '0') {                                          # If $OperatorSelect equals '0'
                        Break RemoveAzureNICIpConfig                                        # Breaks :RemoveAzureNICIpConfig
                    }                                                                       # End if ($OperatorSelect -eq '0')
                    elseif ($OperatorSelect -in $ListArray.Number) {                        # Else if $OperatorSelect in $ListArray.Number
                        $NicIPCon = $ListArray | Where-Object {$_.Number -eq `
                            $OperatorSelect}                                                # Sets $NicIPCon
                        Break GetAzureNicIPConfig                                           # Breaks :GetAzureNicIPConfig
                    }                                                                       # End elseif ($OperatorSelect -in $ListArray.Number)
                    else {                                                                  # All other inputs for $OperatorSelect
                        Write-Host 'That was not a valid selection'                         # Write message to screen
                    }                                                                       # End else (if ($OperatorSelect -eq '0'))
                }                                                                           # End :SelectAzureNicIPConfig while ($true)
            }                                                                               # End :GetAzureNicIPConfig while ($true)
            Try {                                                                           # Try the following
                $NicObject = Remove-AzNetworkInterfaceIpConfig -Name $NicIPCon.Name `
                    -NetworkInterface $NicObject                                            # Removes the selected configuration
                $NicObject | Set-AzNetworkInterface  -ErrorAction 'Stop' | Out-Null         # Saves the settings
            }                                                                               # End try
            Catch {                                                                         # If try fails
                Write-Host 'An error has occured'                                           # Write message to screen
                Break RemoveAzureNICIpConfig                                                # Breaks RemoveAzureNICIpConfig
            }                                                                               # End catch                                                                      
            Write-Host 'The IP has been set'                                                # Write message to screen
            Return $NicObject                                                               # Returns to calling function with $Var
        }                                                                                   # End :RemoveAzureNICIpConfig while($true)
        Return                                                                              # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function RemoveAzNICIpConfig