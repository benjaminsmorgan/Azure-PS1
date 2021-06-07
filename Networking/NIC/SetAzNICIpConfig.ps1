# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Mircosoft docs links
    Set-AzNetworkInterface:     https://docs.microsoft.com/en-us/powershell/module/az.network/set-aznetworkinterface?view=azps-5.6.0
    Get-AzNetworkInterfaceIPConfig: https://docs.microsoft.com/en-us/powershell/module/az.network/get-aznetworkinterfaceipconfig?view=azps-5.6.0
    New-AzNetworkInterface:     https://docs.microsoft.com/en-us/powershell/module/az.network/new-aznetworkinterface?view=azps-5.6.0
    Get-AzNetworkInterface:     https://docs.microsoft.com/en-us/powershell/module/az.network/get-aznetworkinterface?view=azps-5.4.0
    New-AzPublicIpAddress:      https://docs.microsoft.com/en-us/powershell/module/az.network/new-azpublicipaddress?view=azps-5.5.0
    Get-AzPublicIpAddress:      https://docs.microsoft.com/en-us/powershell/module/az.network/get-azpublicipaddress?view=azps-5.5.0 
    Get-AzResourceGroup:        https://docs.microsoft.com/en-us/powershell/module/az.resources/get-azresourcegroup?view=azps-5.1.0
    Get-AzLocation:             https://docs.microsoft.com/en-us/powershell/module/az.resources/get-azlocation?view=azps-5.4.0
    Get-AzVirtualNetworkSubnetConfig: https://docs.microsoft.com/en-us/powershell/module/az.network/get-azvirtualnetworksubnetconfig?view=azps-5.4.0
    Get-AzVirtualNetwork:       https://docs.microsoft.com/en-us/powershell/module/az.network/get-azvirtualnetwork?view=azps-5.4.0
} #>
<# Required Functions Links: {
    NewAzNetworkInterface:      https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/NIC/NewAzNetworkInterface.ps1
    GetAzNetworkInterface:      https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/NIC/GetAzNetworkInterface.ps1
    NewAzPublicIPAddress:       https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/Public%20IP/NewAzPublicIpAddress.ps1
    GetAzPublicIpAddress:       https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/Public%20IP/GetAzPublicIpAddress.ps1
    GetAzResourceGroup:         https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/GetAzResourceGroup.ps1
    GetAzLocation:              https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/GetAzLocation.ps1
    GetAzVNetSubnetConfig:      https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/SubNet/GetAzVNetSubnetConfig.ps1
} #>
<# Functions Description: {
    SetAzNICIpConfig:           Updates a NIC IP configuration
    NewAzNetworkInterface:      Creates new network interfaces
    GetAzNetworkInterface:      Gets an existing network interface
    RemoveAzNetworkInterface:   Removes a network interface   
    GetAzVNetSubnetConfig:      Gets an azure virtual network subnet
    GetAzResourceGroup:         Gets a resource group
    GetAzLocation:              Gets an azure location
    NewAzPublicIpAddress:       Creates a new public IP address
    GetAzPublicIpAddress:       Gets an existing public IP address
} #>
<# Variables: {      
    :SetAzureNICIpConfig        Outer loop for managing function
    :SelectAzureNic             Inner loop for getting or creating a nic
    :GetAzureNicIPConfig        Inner loop for getting the nic ip config
    :SelectAzureNicIPConfig     Inner loop for selecting the nic ip config
    :SelectAzureIPType          Inner loop for selecting private or public IP
    :SelectAzurePrivateIP       Inner loop for selecting a static or dynamic IP
    :SelectAzurePublicIP        Inner loop for creating or getting a public IP
    $CallingFunction:           Name of this function
    $OperatorSelect:            Operator selection option
    $NicObject:                 The nic whos configuration is being changed
    $SubnetObject:              Subnet of the nic (Not used)
    $VnetObject:                Vnet holding the subnet (Not used)
    $NicIPList:                 List of all IP configs on nic
    $CurrentPubIPId:            Current object in $NicIPList public IP sku id if existing             
    $CurrentPubIP:              The public IP sku object of the current $NicIPList if existing 
    $ListNumber:                Number used in $ListArray
    $ListArray:                 Used to display nic ip configs
    $ListInput:                 $var used to load info into $ListArray
    $NicIPCon:                  $var used to apply the changes to a selected config
    $PrivateIPObject:           Operator input for the new private IP address
    $PublicIPObject:            Public IP object
    NewAzNetworkInterface{}     Creates $NicObject
        GetAzResourceGroup{}        Gets $RGObject
        GetAzLocation{}             Gets $LocationObject
        GetAzVNetSubnetConfig{}     Gets $SubnetObject
    GetAzNetworkInterface{}     Gets $NicObject
    NewAzPublicIpAddress{}      Creates $PublicIPObject
        GetAzResourceGroup{}        Gets $RGObject
    GetAzPublicIpAddress{}      Gets $PublicIPObject
} #>
<# Process Flow {
    function
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
}#>
function SetAzNICIpConfig {                                                                 # Function to add a NIC IP config
    Begin {                                                                                 # Begin function
        :SetAzureNICIpConfig while($true) {                                                 # Outer loop for managing function
            if (!$CallingFunction) {                                                        # If $CallingFunction is $null
                $CallingFunction = 'SetAzNICIpConfig'                                       # Creates $CallingFunction
            }                                                                               # End if (!$CallingFunction)
            $NicIPConfigObject,$NicObject = GetAzNICIpConfig                                # Calls function and assigns output to $vars
            if (!$NicIPConfigObject) {                                                      # If $NicIPConfigObject is $null
                Break SetAzureNICIpConfig                                                   # Breaks :SetAzureNICIpConfig
            }                                                                               # End if (!$NicIPConfigObject) 
            $NicObject | Set-AzNetworkInterfaceIpConfig -Name $NicIPConfigObject.Name -PrivateIpAddress '10.0.1.100' -SubnetId $NicIPConfigObject.Subnet.ID
            $NicObject | Set-AzNetworkInterface
            Return
        }                                                                                   # End :SetAzureNICIpConfig while($true)
        Return                                                                              # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function SetAzNICIpConfig
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
                        Write-Host "[$Number]                "$_.Name                       # Write message to screen
                    }                                                                       # End if ($Number -le 9)
                    else {                                                                  # If $Number is more than 9
                        Write-Host "[$Number]               "$_.Name                        # Write message to screen
                    }                                                                       # End else (if ($Number -le 9))
                    Write-Host 'Private IP Address:'$_.PrivIP                               # Write message to screen
                    if ($_.PubIP) {                                                         # If current item .PubIP has a value
                        $PubID = $_.PubIP.ID                                                # Isolates the public IP sku ID
                        $PubIP = Get-AzPublicIpAddress | Where-Object {$_.ID -eq $PubID}    # Gets the public IP sku
                        Write-Host 'Public IP Address: '$PubIP.IpAddress                    # Write message to screen
                    }                                                                       # End if ($_.PubIP)
                    Write-Host 'Is primary:        '$_.Pri                                  # Write message to screen
                    Write-Host 'Nic Name:          '$_.NicName                              # Write message to screen
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