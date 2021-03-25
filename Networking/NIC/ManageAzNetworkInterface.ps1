# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Mircosoft docs links
    New-AzNetworkInterface:     https://docs.microsoft.com/en-us/powershell/module/az.network/new-aznetworkinterface?view=azps-5.6.0
    Get-AzNetworkInterface:     https://docs.microsoft.com/en-us/powershell/module/az.network/get-aznetworkinterface?view=azps-5.4.0
    Remove-AzNetworkInterface:  https://docs.microsoft.com/en-us/powershell/module/az.network/remove-aznetworkinterface?view=azps-5.6.0
    Get-AzResourceGroup:        https://docs.microsoft.com/en-us/powershell/module/az.resources/get-azresourcegroup?view=azps-5.1.0
    Get-AzLocation:             https://docs.microsoft.com/en-us/powershell/module/az.resources/get-azlocation?view=azps-5.4.0
    Get-AzVirtualNetworkSubnetConfig: https://docs.microsoft.com/en-us/powershell/module/az.network/get-azvirtualnetworksubnetconfig?view=azps-5.4.0
    Get-AzVirtualNetwork:       https://docs.microsoft.com/en-us/powershell/module/az.network/get-azvirtualnetwork?view=azps-5.4.0
} #>
<# Required Functions Links: {
    NewAzNetworkInterface:      https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/NIC/NewAzNetworkInterface.ps1
    GetAzNetworkInterface:      https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/NIC/GetAzNetworkInterface.ps1
    RemoveAzNetworkInterface:   https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/NIC/RemoveAzNetworkInterface.ps1   
    GetAzResourceGroup:         https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/GetAzResourceGroup.ps1
    GetAzLocation:              https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/GetAzLocation.ps1
    GetAzVNetSubnetConfig:      https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/SubNet/GetAzVNetSubnetConfig.ps1
} #>
<# Functions Description: {
    ManageAzNetworkInterface:   Management function for network interfaces
    NewAzNetworkInterface:      Creates new network interfaces
    GetAzNetworkInterface:      Gets an existing network interface
    RemoveAzNetworkInterface:   Removes a network interface   
    GetAzVNetSubnetConfig:      Gets an azure virtual network subnet
    GetAzResourceGroup:         Gets a resource group
    GetAzLocation:              Gets an azure location
} #>
<# Variables: {
    :ManageAzureNic             Outer loop for managing function
    $RGetObject:                Resource group object
    $SubnetObject:              Subnet object
    $NicObject:                 Network interface object
    $ManageAzNic:               Operator input for selecting function
    NewAzNetworkInterface{}     Creates $NicObject
        GetAzResourceGroup{}        Gets $RGObject
        GetAzLocation{}             Gets $LocationObject
        GetAzVNetSubnetConfig{}     Gets $SubnetObject
    GetAzNetworkInterface{}     Get $NicObject
    RemoveAzNetworkInterface{}  Removes $NicObject
        GetAzNetworkInterface{}     Get $NicObject
    
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
        End ManageAzNetworkInterface
            Return function > Send $NicObject
}#>
function ManageAzNetworkInterface {                                                         # Function for managing azure nic resources
    Begin {                                                                                 # Begin function   
        :ManageAzureNic while ($true) {                                                     # Outer loop for managing function
            if ($RGObject) {                                                                # If $RGObject has a value
                Write-Host 'The currently selected RG is:'$RGObject.ResourceGroupName       # Write message to screen
            }                                                                               # End if ($RGObject)
            if ($SubnetObject) {                                                            # If $SubnetObject has a value
                Write-Host 'The currently selected Subnet is:'$SubnetObject.name            # Write message to screen
            }                                                                               # End if ($SubnetObject)
            if ($NicObject) {                                                               # If $NicObject has a value
                Write-Host 'The currently selected Nic is:'$NicObject.name                  # Write message to screen
            }                                                                               # End if ($NicObject)
            Write-Host "Azure Nic Management"                                               # Write message to screen
            Write-Host '0 Clear "$vars"'                                                    # Write message to screen
            Write-Host '1 Add Nic'                                                          # Write message to screen
            Write-Host '2 Get Nic'                                                          # Write message to screen
            Write-Host '3 Remove Nic'                                                       # Write message to screen
            Write-Host "'Exit to return'"                                                   # Write message to screen
            $ManageAzNic = Read-Host "Option?"                                              # Collects operator input on $ManageAzNic option
            if ($ManageAzNic -eq 'exit') {                                                  # If $ManageAzNic equals 'exit'
                Break ManageAzureNic                                                        # Breaks :ManageAzureNic
            }                                                                               # End if ($ManageAzNic -eq 'exit')
            elseif ($ManageAzNic -eq '0') {                                                 # Elseif $ManageAzNic equals 0
                if ($RGObject) {                                                            # If $RGObject has a value
                    Write-Host 'Clearing "$RGObject'                                        # Write message to screen
                    $RGObject = $null                                                       # Clears $RGObject
                }                                                                           # End if ($RGObject)
                else {                                                                      # If $RGObject does not have a value
                    Write-Host '$RGObject is already clear'                                 # Write message to screen
                }                                                                           # End else (if ($RGObject))
                if ($SubnetObject) {                                                        # If $SubnetObject has a value
                    Write-Host 'Clearing "$SubnetObject'                                    # Write message to screen
                    $SubnetObject = $null                                                   # Clears $SubnetObject
                }                                                                           # End if ($SubnetObject)
                else {                                                                      # If $SubnetObject does not have a value
                    Write-Host '$SubnetObject is already clear'                             # Write message to screen
                }                                                                           # End else (if ($subnetObject))
                if ($NicObject) {                                                           # If $NicObject has a value
                    Write-Host 'Clearing "$NicObject'                                       # Write message to screen
                    $NicObject = $null                                                      # Clears $NicObject
                }                                                                           # End if ($NicObject)
                else {                                                                      # If $NicObject does not have a value
                    Write-Host '$NicObject is already clear'                                # Write message to screen
                }                                                                           # End else (if ($NicObject))
            }                                                                               # End elseif ($ManageAzNic -eq '0')
            elseif ($ManageAzNic -eq '1') {                                                 # Elseif $ManageAzNic equals 1
                Write-Host 'Add Nic'                                                        # Write message to screen
                $NicObject = NewAzNetworkInterface ($SubnetObject, $RGobject)               # Calls function and assigns output to $var
            }                                                                               # End elseif ($ManageAzNic -eq '1')
            elseif ($ManageAzNic -eq '2') {                                                 # Elseif $ManageAzNic equals 2
                Write-Host 'Get Nic'                                                        # Write message to screen
                $NicObject = GetAzNetworkInterface                                          # Calls function and assigns output to $var
            }                                                                               # End elseif ($ManageAzNic -eq '2')
            elseif ($ManageAzNic -eq '3') {                                                 # Elseif $ManageAzNic equals 3
                Write-Host 'Remove Nic'                                                     # Write message to screen
                RemoveAzNetworkInterface ($NicObject)                                       # Calls function
            }                                                                               # End elseif ($ManageAzNic -eq '3')
            else {                                                                          # If $ManageAzNic do not match any if or elseif     
                Write-Host "That was not a valid option"                                    # Write message to screen
            }                                                                               # End else (if ($ManageAzNic -eq 'exit'))
        }                                                                                   # End :ManageAzureNic while ($true)
        Return $NicObject                                                                   # Returns $var to calling function
    }                                                                                       # End Begin
}                                                                                           # End function ManageAzNetworkInterface
function NewAzNetworkInterface {                                                            # Creates a new network interface
    Begin {                                                                                 # Begin function
        :NewAzureNIC while ($true) {                                                        # Outer loop for managing function
            if (!$CallingFunction) {                                                        # If $CallingFunction is $null
                $CallingFunction = 'NewAzNetworkInterface'                                  # Creates $CallingFunction
            }                                                                               # End if (!$CallingFunction)
            if (!$RGObject) {                                                               # If $RGObject is $null
                $RGObject = GetAzResourceGroup ($CallingFunction)                           # Calls function and assigns output to $var
                if (!$RGObject) {                                                           # If $RGObject is $null
                    Break NewAzureNIC                                                       # Breaks :NewAzureNIC
                }                                                                           # End if (!$RGObject)
            }                                                                               # End if (!$RGObject)
            if (!$LocationObject) {                                                         # If $LocationObject is $null
                $LocationObject = GetAzLocation ($CallingFunction)                          # Calls function and assigns output to $var
                if (!$LocationObject) {                                                     # If $LocationObject is $null
                    Break NewAzureNIC                                                       # Breaks :NewAzureNIC
                }                                                                           # End if (!$LocationObject)
            }                                                                               # End if (!$LocationObject)
            if (!$SubnetObject) {                                                           # If $SubnetObject is $null
                $SubnetObject, $VNetObject = GetAzVNetSubnetConfig ($CallingFunction)       # Calls function and assigns output to $var
                if (!$SubnetObject) {                                                       # If $SubnetObject is $null
                    Break NewAzureNic                                                       # Breaks :NewAzureNic
                }                                                                           # End if (!$SubnetObject)
            }                                                                               # End if (!$SubnetObject)
            :SetAzureNicName while ($true) {                                                # Inner loop for setting the nic name
                $NicName = Read-Host "Nic name"                                             # Operator input for the nic name
                if ($NicName -eq 'exit') {                                                  # If $NicName is 'exit'
                    Break NewAzureNic                                                       # Breaks :NewAzureNic
                }                                                                           # End if ($NicName -eq 'exit')
                $OperatorConfirm = Read-Host "Set" $NicName "as the Nic name [Y] or [N]"    # Operator confirmation of the name
                if ($OperatorConfirm -eq 'y') {                                             # If $OperatorConfirm equals 'y'
                    Break SetAzureNicName                                                   # Breaks :SetAzureNicName
                }                                                                           # End if ($OperatorConfirm -eq 'y')
            }                                                                               # End :SetAzureNicName while ($true)
            Try {                                                                           # Try the following
                $NICObject = New-AzNetworkInterface -Name $NicName -ResourceGroupName `
                    $RGObject.ResourceGroupName -Location $LocationObject.location `
                    -Subnet $SubnetObject  -ErrorAction 'Stop'                              # Creates the object and assigns to $var
            }                                                                               # End Try
            Catch {                                                                         # If try fails
                Write-Host "An error has occured"                                           # Write mesage to screen
                Write-Host "You may not have permissions to create this object"             # Write mesage to screen
                Write-Host "The resource group maybe locked"                                # Write mesage to screen
                Write-Host "The name provided may not be valid"                             # Write mesage to screen
                Break NewAzureNIC                                                           # Breaks :NewAzureNIC
            }                                                                               # End Catch
            Return $NICObject, $SubnetObject, $VNetObject                                   # Returns $vars to calling function
        }                                                                                   # End :NewAzureNIC while ($true)
        Return                                                                              # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End funciton NewAzNetworkInterface
function GetAzNetworkInterface {                                                            # function to get a network interface
    Begin {                                                                                 # Begin function
        :GetAzureNIC while ($true) {                                                        # Outer loop for managing function
            $VNetList = Get-AzVirtualNetwork                                                # Gets a list of all virtual networks
            $ListNumber = 1                                                                 # List number used for subnet selection
            [System.Collections.ArrayList]$ListArray = @()                                  # Array that all info is loaded into
            foreach ($_ in $VNetList) {                                                     # For each object in $VnetList
                $VNet = $_.Name                                                             # Sets $Vnet as the current object Vnet name
                $VnetPFX = $_.AddressSpace.AddressPrefixes                                  # Sets $VnetPFX as the current object Vnet prefix
                $VNetRG = $_.ResourceGroupName                                              # Sets $VnetRG as the current object Vnet resource group
                $SubnetList = Get-AzVirtualNetworkSubnetConfig -VirtualNetwork $_           # Creates a list of subnets on the current object vnet
                foreach ($_ in $SubnetList) {                                               # For each item in $SubnetList
                    $Subnet = $_.ID                                                         # $Subnet equals $currentitem.ID
                    $SubnetName = $_.Name                                                   # Pulls $CurrentItem.Name into $var
                    $SubnetPFX = $_.AddressPrefix                                           # Pulls $CurrentItem.AddressPrefix nto $var
                    $NicList = Get-AzNetworkInterface | Where-Object `
                        {$_.IpConfigurations.Subnet.ID -eq $Subnet}                         # Gets a list of all nics on subnet
                    foreach ($_ in $NicList) {                                              # For each item in $NicList
                        $ListInput = [PSCustomObject]@{'Number'=$ListNumber;'NicName' `
                            =$_.Name;'NicRG'=$_.ResourceGroupName;'SubName'=$Subnetname; `
                            'SubPFX'=$SubnetPFX;'VNetName'=$VNet;'VnetPFX'=$VnetPFX; `
                            'VnetRG'= $VNetRG}                                              # Creates the item to loaded into array
                        $ListArray.Add($ListInput) | Out-Null                               # Loads item into array, out-null removes write to screen
                        $ListNumber = $ListNumber + 1                                       # Increments $ListNumber by 1
                    }                                                                       # End foreach ($_ in $NicList)
                }                                                                           # End foreach ($_ in $SubnetList)
            }                                                                               # End foreach ($_ in $VnetList)
            Write-Host '[ 0 ]'                                                              # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            foreach ($_ in $ListArray) {                                                    # For each item in $List array
                Write-Host '['$_.Number']'                                                  # Write message to screen
                Write-Host 'NIC Name:     '$_.NicName                                       # Write message to screen
                Write-Host 'NIC RG:       '$_.NicRG                                         # Write message to screen
                Write-Host 'Subnet Name:  '$_.Subname                                       # Write message to screen
                Write-Host 'Subnet Prefix:'$_.SubPFX                                        # Write message to screen
                Write-Host 'VNet Name:    '$_.VnetName                                      # Write message to screen
                Write-Host 'VNet Prefix:  '$_.VnetPFX                                       # Write message to screen
                Write-Host 'VNet RG:      '$_.VnetRG                                        # Write message to screen
                Write-Host ''                                                               # Write message to screen
            }                                                                               # End foreach ($_ in $ListArray)
            :SelectAzureNic while ($true) {                                                 # Inner loop for selecting the nic
                if ($CallingFunction) {                                                     # If $CallingFunction has a value
                    Write-Host 'The nic is being selected for'$CallingFunction              # Write message to screen
                }                                                                           # End if ($CallingFunction)
                $OperatorSelect = Read-Host 'Enter the [#] of the NIC'                      # Operator input for selecting the nic
                if ($OperatorSelect -eq '0') {                                              # If $OperatorSelect equals 0
                    Break GetAzureNic                                                       # Breaks :GetAzureNic
                }                                                                           # End if ($OperatorSelect -eq '0')
                elseif ($OperatorSelect -in $ListArray.Number) {                            # If $OperatorSelect in $ListArray.Number
                    $OperatorSelect = $ListArray | Where-Object {$_.Number -eq `
                        $OperatorSelect}                                                    # $OperatorSelect equals $ListArray where $OperatorSelect is equal to $ListArray.Number
                    Try {                                                                   # Try the following
                        $VNetObject = Get-AzVirtualNetwork -Name $OperatorSelect.VnetName `
                            -ResourceGroupName $OperatorSelect.VNetRG                       # Pulls the $Subnet Vnet
                        $SubnetObject = Get-AzVirtualNetworkSubnetConfig -VirtualNetwork `
                            $VNetObject -Name $OperatorSelect.Subname                       # Pulls the $NicObject subnet
                        $NicObject = Get-AzNetworkInterface -Name $OperatorSelect.NicName |`
                            Where-Object {$_.IpConfigurations.Subnet.ID -eq `
                            $SubnetObject.ID}                                               # Pulls the full $NicObject
                    }                                                                       # End try
                    Catch {                                                                 # If try fails
                        Write-Host 'An error has occured'                                   # Write message to screen
                        Break GetAzureNic                                                   # Breaks :GetAzureNic
                    }                                                                       # End Catch
                    Return $NicObject, $SubnetObject, $VnetObject                           # Returns $vars to calling function
                }                                                                           # End elseif ($OperatorSelect -in $ListArray.Number)
                else {                                                                      # All other inputs for $OperatorSelect
                    Write-Host 'That was not a valid option'                                # Write message to screen
                }                                                                           # End else (if ($OperatorSelect -eq '0'))
            }                                                                               # End :SelectAzureNic while ($true)
        }                                                                                   # End :GetAzureNIC while ($true)
        Return                                                                              # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function GetAzNetworkInterface
function RemoveAzNetworkInterface {                                                         # Function to remove a network interface
    Begin {                                                                                 # Begin function
        :RemoveAzureNic while ($true) {                                                     # Outer loop for managing function
            if (!$NicObject) {                                                              # If $NicObject does not have a value
                $CallingFunction = 'RemoveAzNetworkInterface'                               # Sets $CallingFunction
                $NicObject = GetAzNetworkInterface ($CallingFunction)                       # Calls function and assigns output to $var
                if (!$NicObject) {                                                          # If $NicObject does not have a value
                    Break RemoveAzureNic                                                    # Breaks :RemoveAzureNic
                }                                                                           # End if (!$NicObject)
            }                                                                               # End if (!$NicObject)
            Write-Host 'Remove the network interface named:'$NicObject.name                 # Write message to screen
            Write-Host 'from the resource group:'$NicObject.ResourceGroupName               # Write message to screen
            $OperatorConfirm = Read-Host '[Y] or [N]'                                       # Operator confirmation to remove the Nic
            if ($OperatorConfirm -eq 'y') {                                                 # If $OperatorConfirm equals 'y;
                Try {                                                                       # Try the following
                    Remove-AzNetworkInterface -Name $NicObject.Name -ResourceGroupName `
                        $NicObject.ResourceGroupName -Force -ErrorAction 'Stop'             # Removes the selected NIC
                }                                                                           # End try
                Catch {                                                                     # If try fails
                    Write-Host 'An error has occured'                                       # Write message to screen
                    Write-Host 'No changes have been made'                                  # Write message to screen
                    Break RemoveAzureNic                                                    # Breaks :RemoveAzureNic
                }                                                                           # End catch
                Write-Host 'The selected Nic has been removed'                              # Write message to screen
                Break RemoveAzureNic                                                        # Breaks :RemoveAzureNic
            }                                                                               # End if ($OperatorConfirm -eq 'y')
            else {                                                                          # All other inputs for $OperatorConfirm
                Break RemoveAzureNic                                                        # Breaks :RemoveAzureNic
            }                                                                               # End else (If ($OperatorConfirm -eq 'y'))
        }                                                                                   # End :RemoveAzureNic while ($true)
        Return                                                                              # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function RemoveAzNetworkInterface
function SetAzNICIpConfig {                                                                 # Function to add a NIC IP config
    Begin {                                                                                 # Begin function
        :SetAzureNICIpConfig while($true) {                                                 # Outer loop for managing function
            if (!$CallingFunction) {                                                        # If $CallingFunction is $null
                $CallingFunction = 'NewAzNetworkInterface'                                  # Creates $CallingFunction
            }                                                                               # End if (!$CallingFunction)
            :SelectAzureNic while ($true) {                                                 # Inner loop for selecting a NIC
                Write-Host '[0] Exit'                                                       # Write message to screen
                Write-Host '[1] New NIC'                                                    # Write message to screen
                Write-Host '[2] Existing NIC'                                               # Write message to screen
                $OperatorSelect = Read-Host 'Select [#] option'                             # Operator input for a new or existing NIC
                if ($OperatorSelect -eq '0') {                                              # If $OperatorSelect equals '0'
                    Break SetAzureNICIpConfig                                               # Breaks :SetAzureNICIpConfig
                }                                                                           # End if ($OperatorSelect -eq '0')
                elseif ($OperatorSelect -eq '1') {                                          # Else if $OperatorSelect equals '1'
                    $NicObject, $SubnetObject, $VnetObject = NewAzNetworkInterface `
                        ($CallingFunction)                                                  # Calls function and assigns output to $var
                    if (!$NicObject -or !$SubnetObject -or !$VnetObject) {                  # If $NicObject, $SubnetObject, or $VnetObject is $null
                        Break SetAzureNICIpConfig                                           # Breaks :SetAzureNICIpConfig
                    }                                                                       # End if (!$NicObject -or !$SubnetObject -or !$VnetObject)
                    else {                                                                  # If $NicObject, $SubnetObject, and $VnetObject have a value
                        Break SelectAzureNic                                                # Breaks :SelectAzureNic
                    }                                                                       # End else (if (!$NicObject -or !$SubnetObject -or !$VnetObject))
                }                                                                           # End elseif ($OperatorSelect -eq '1')
                elseif ($OperatorSelect -eq '2') {                                          # Else if $OperatorSelect equals '1'
                    $NicObject, $SubnetObject, $VnetObject = GetAzNetworkInterface `
                        ($CallingFunction)                                                  # Calls function and assigns output to $var
                    if (!$NicObject -or !$SubnetObject -or !$VnetObject) {                  # If $NicObject, $SubnetObject, or $VnetObject is $null
                        Break SetAzureNICIpConfig                                           # Breaks :SetAzureNICIpConfig
                    }                                                                       # End if (!$NicObject -or !$SubnetObject -or !$VnetObject)
                    else {                                                                  # If $NicObject, $SubnetObject, and $VnetObject have a value
                        Break SelectAzureNic                                                # Breaks :SelectAzureNic
                    }                                                                       # End else (if (!$NicObject -or !$SubnetObject -or !$VnetObject))
                }                                                                           # End elseif ($OperatorSelect -eq '2')
                else {                                                                      # All other inputs for $OperatorSelect
                    Write-Host 'That was not a valid option'                                # Write message to screen
                }                                                                           # End else (if ($OperatorSelect -eq '0'))
            }                                                                               # Inner loop for selecting a new or existing nic
            :GetAzureNicIPConfig while ($true) {                                            # Inner loop for selecting the nic IP config
                $NicIPList = $NicObject.IPConfigurations                                    # Gets list of all existing IP configs
                $ListNumber = 0                                                             # Sets list number for $ListArray
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
                        Break SetAzureNICIpConfig                                           # Breaks :SetAzureNICIpConfig
                    }                                                                       # End if ($OperatorSelect -eq '0')
                    elseif ($OperatorSelect -in $ListArray.Number) {                        # Else if $OperatorSelect in $ListArray.Number
                        $NicIPCon = $OperatorSelect                                         # Sets $NicIPCon
                        Break GetAzureNicIPConfig                                           # Breaks :GetAzureNicIPConfig
                    }                                                                       # End elseif ($OperatorSelect -in $ListArray.Number)
                    else {                                                                  # All other inputs for $OperatorSelect
                        Write-Host 'That was not a valid selection'                         # Write message to screen
                    }                                                                       # End else (if ($OperatorSelect -eq '0'))
                }                                                                           # End :SelectAzureNicIPConfig while ($true)
            }                                                                               # End :GetAzureNicIPConfig while ($true)
            :SelectAzureIPType while ($true) {                                              # Inner loop for setting the IP type
                Write-Host '[0] Exit'                                                       # Write message to screen
                Write-Host '[1] Private IP'                                                 # Write message to screen
                Write-Host '[2] Public IP'                                                  # Write message to screen
                $OperatorSelect = Read-Host 'Select [#] option'                             # Operator input for the IP type
                if ($OperatorSelect -eq '0') {                                              # If $OperatorSelect equals '0'
                    Break SetAzureNICIpConfig                                               # Breaks :SetAzureNICIpConfig
                }                                                                           # End if ($OperatorSelect -eq '0')
                elseif ($OperatorSelect -eq '1') {                                          # Else if $OperatorSelect equals '1'
                    :SelectAzurePrivateIP while ($true) {                                   # Inner loop for setting the private IP allocation
                        Write-Host '[0] Exit'                                               # Write message to screen
                        Write-Host '[1] Dynamic'                                            # Write message to screen
                        Write-Host '[2] Static'                                             # Write message to screen
                        $OperatorSelect = Read-Host 'Select [#] option'                     # Operator input for selecting the private IP allocation
                        if ($OperatorSelect -eq '0') {                                      # If $OperatorSelect equals 0
                            Break SelectAzurePrivateIP                                      # Breaks :SelectAzurePrivateIP
                        }                                                                   # End if ($OperatorSelect -eq '0')
                        elseif ($OperatorSelect -eq '1') {                                  # Else if $OperatorSelect equals '1'
                            $NicObject.IpConfigurations[$NicIPCon].PrivateIpAllocationMethod `
                            = 'dynamic'                                                     # Sets Nic private to dynamic
                                Break SelectAzureIPType                                     # Breaks :SelectAzureIPType
                        }                                                                   # End elseif ($OperatorSelect -eq '1')
                        elseif ($OperatorSelect -eq '2') {                                  # Else if $OperatorSelect equals '2'
                            :SetAzurePrivateIP while ($true) {                              # Inner loop for setting the static IP
                                $PrivateIPObject = Read-Host 'Please enter the new IP'      # Operator input for the static IP
                                if ($PrivateIPObject -eq 'exit') {                          # If $PriveIPObject equals 'exit'
                                    Break SetAzureNICIpConfig                               # Breaks :SetAzureNICIpConfig
                                }                                                           # End if ($PrivateIPObject -eq 'exit')
                                Write-Host `
                                    'Use'$PrivateIPObject' as the new private IP address'   # Write message to screen
                                $OperatorConfirm = Read-Host '[Y] or [N]'                   # Operator confirmation of the private IP
                                if ($OperatorConfirm -eq 'y') {                             # If $OperatorConfirm equals 'y'
                                    $NicObject.IpConfigurations[$NicIPCon].PrivateIpAddress `
                                        = $PrivateIPObject                                  # Assigns the static IP
                                    $NicObject.IpConfigurations[$NicIPCon].PrivateIpAllocationMethod `
                                        = 'static'                                          # Assigns the allocation method
                                    Break SelectAzureIPType                                 # Breaks :SelectAzureIPType
                                }                                                           # End if ($OperatorConfirm -eq 'y')
                            }                                                               # End :SetAzurePrivateIP while ($true)
                        }                                                                   # End elseif ($OperatorSelect -eq '2')
                        else {                                                              # All other inputs for $OperatorSelect
                            Write-Host 'That was not a valid option'                        # Write message to screen
                        }                                                                   # End else (if ($OperatorSelect -eq '0'))
                    }                                                                       # End :SelectAzurePrivateIP while ($true)
                }                                                                           # End elseif ($OperatorSelect -eq '1')
                elseif ($OperatorSelect -eq '2') {                                          # Else if $OperatorSelect equals '1'
                    :SelectAzurePublicIP while ($true) {                                    # Inner loop for getting a public IP
                        Write-Host '[0] Exit'                                               # Write message to screen
                        Write-Host '[1] New public IP'                                      # Write message to screen
                        Write-Host '[2] Existing public IP'                                 # Write message to screen
                        $OperatorSelect = Read-Host 'Select [#] option'                     # Operator input for selecting a new or existing public IP
                        if ($OperatorSelect -eq '0') {                                      # If $OperatorSelect equals 0
                            Break SelectAzurePublicIP                                       # Breaks :SelectAzurePublicIP
                        }                                                                   # End if ($OperatorSelect -eq '0')
                        elseif ($OperatorSelect -eq '1') {                                  # Else if $OperatorSelect equals 1
                            $PublicIPObject = NewAzPublicIpAddress ($CallingFunction)       # Calls function and assigns output to $var
                            if (!$PublicIPObject) {                                         # If $PublicIPObject is $null
                                Break SelectAzurePublicIP                                   # Breaks :SelectAzurePublicIP
                            }                                                               # End if (!$PublicIPObject)
                            else {                                                          # If $PublicIPAddress has a value
                                $NicObject.IpConfigurations[$NicIPCon].PublicIPAddress = `
                                    $PublicIPObject                                         # Assigns the public IP to the IP configuration
                                Break SelectAzureIPType                                     # Breaks :SelectAzureIPType
                            }                                                               # End else (if (!$PublicIPObject))
                        }                                                                   # End elseif ($OperatorSelect -eq '1')
                        elseif ($OperatorSelect -eq '2') {                                  # Else if $OperatorSelect equals 1
                            $PublicIPObject = GetAzPublicIpAddress ($CallingFunction)       # Calls function and assigns output to $var
                            if (!$PublicIPObject) {                                         # If $PublicIPObject is $null
                                Break SelectAzurePublicIP                                   # Breaks :SelectAzurePublicIP
                            }                                                               # End if (!$PublicIPObject)
                            else {                                                          # If $PublicIPAddress has a value
                                $NicObject.IpConfigurations[$NicIPCon].PublicIPAddress = `
                                    $PublicIPObject                                         # Assigns the public IP to the IP configuration
                                Break SelectAzureIPType                                     # Breaks :SelectAzureIPType
                            }                                                               # End else (if (!$PublicIPObject))
                        }                                                                   # End elseif ($OperatorSelect -eq '2')
                        else {                                                              # All other inputs for $OperatorSelect
                            Write-Host 'That was not a valid option'                        # Write message to screen
                        }                                                                   # End else (if ($OperatorSelect -eq '0'))
                    }                                                                       # End :SelectAzurePublicIP while ($true)
                }                                                                           # End elseif ($OperatorSelect -eq '2')
                else {                                                                      # All other inputs for $OperatorSelect
                    Write-Host 'That was not a valid option'                                # Write message to screen
                }                                                                           # End else (if ($OperatorSelect -eq '0'))
            }                                                                               # End :SelectAzureIPType while ($true)
            Try {                                                                           # Try the following
                $NicObject | Set-AzNetworkInterface # -ErrorAction 'Stop'                   # Saves the settings
            }                                                                               # End try
            Catch {                                                                         # If try fails
                Write-Host 'An error has occured'                                           # Write message to screen
                Break SetAzureNICIpConfig                                                   # Breaks SetAzureNICIpConfig
            }                                                                               # End catch                                                                      
            Write-Host 'The IP has been set'                                                # Write message to screen
            Return $NicObject                                                               # Returns to calling function with $Var
        }                                                                                   # End :SetAzureNICIpConfig while($true)
        Return                                                                              # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function SetAzNICIpConfig
# Additional functions required for ManageAzNetworkInterface
function NewAzPublicIpAddress {                                                             # Creates a new public IP address
    Begin {                                                                                 # Begin function
        $ErrorActionPreference='silentlyContinue'                                           # Turns off error reporting
        :NewAzurePublicIP while ($true) {                                                   # Outer loop for managing function
            if (!$RGObject) {                                                               # If $RGObject is $null
                $RGObject = GetAzResourceGroup                                              # Calls function and assigns output to $var
                if (!$RGObject) {                                                           # If $RGObject is $null
                    Break NewAzurePublicIP                                                  # Breaks :NewAzurePublicIP
                }                                                                           # End if (!$RGObject)
            }                                                                               # End if (!$RGObject)
            :SetAzurePublicIPName while ($true) {                                           # Inner loop for setting the public IP name
                Try {                                                                       # Try the following
                    [ValidatePattern('^[a-z][a-z0-9-]{1,61}[a-z0-9]$')]$PublicIPNameObject `
                    = [string](Read-Host "Enter the public IP name").ToLower()              # Operator input for the public IP name
                }                                                                           # End try
                catch {                                                                     # Error reporting for try statement
                    Write-Host "! That enty was not valid"                                  # Write message to screen
                    Write-Host "! Valid entries are 1-61 characters"                        # Write message to screen
                    Write-Host "! The name must start with a letter"                        # Write message to screen
                    Write-Host "! Special charaters are not allowed"                        # Write message to screen
                    Write-Host ""                                                           # Write message to screen
                }                                                                           # End catch
                if ($PublicIPNameObject) {
                    if ($PublicIPNameObject -eq 'exit') {                                   # IF $PublicIPNameObject equals 'exit'
                        Break NewAzurePublicIP                                              # Breaks :NewAzurePublicIP
                    }                                                                       # End if ($PublicIPNameObject -eq 'exit')
                    Write-Host $PublicIPNameObject                                          # Write message to screen
                    $OperatorConfirm = Read-Host "Use this name [Y] or [N]"                 # Operator confirmation of the name
                    if ($OperatorConfirm -eq 'y') {                                         # If $OperatorConfirm equals 'y'
                        Break SetAzurePublicIPName                                          # Breaks :SetAzurePublicIPName
                    }                                                                       # End if ($OperatorConfirm -eq 'y')
                    else {                                                                  # If $OperatorConfirm does not equal 'y'
                        Remove-Variable PublicIPNameObject                                  # Removes $PublicIPNameObject
                    }                                                                       # End else if ($OperatorConfirm -eq 'y')
                }                                                                           # End if ($PublicIPNameObject) 
            }                                                                               # End :SetAzurePublicIPName while ($true)
            :SetAzurePublicIPAlloc while ($true) {                                          # Inner loop for setting the public IP allocation method
                Write-Host '[0] Exit'                                                       # Write message to screen
                Write-Host '[1] Dynamic'                                                    # Write message to screen
                Write-Host '[2] Static'                                                     # Write message to screen
                $PublicIPAllocationObject = Read-Host "[0], [1], or [2]"                    # Operator input for the allocation method
                if ($PublicIPAllocationObject -eq '0') {                                    # If $PublicIPAllocationObject equals '0'
                    Break NewAzurePublicIP                                                  # Breaks :NewAzurePublicIP
                }                                                                           # End if ($PublicIPAllocationObject -eq '0')
                elseif ($PublicIPAllocationObject -eq '1') {                                # Elseif $PublicIPAllocationObject equals 1
                    $PublicIPAllocationObject = 'dynamic'                                   # Reassigns value of $PublicIPAllocationObject
                    Break SetAzurePublicIPAlloc                                             # Breaks :SetAzurePublicIPAlloc    
                }                                                                           # End elseif ($PublicIPAllocationObject -eq '1')
                elseif ($PublicIPAllocationObject -eq '2') {                                # Elseif $PublicIPAllocationObject equals 2
                    $PublicIPAllocationObject = 'static'                                    # Reassigns value of $PublicIPAllocationObject
                    Break SetAzurePublicIPAlloc                                             # Breaks :SetAzurePublicIPAlloc
                }                                                                           # End elseif ($PublicIPAllocationObject -eq '2')
                else {                                                                      # All other inputs
                    Write-Host "That was not a valid option"                                # Write message to screen
                }                                                                           # End else (($PublicIPAllocationObject -eq '0'))
            }                                                                               # End :SetAzurePublicIPAlloc while ($true)
            $PublicIPObject = New-AzPublicIpAddress -Name $PublicIPNameObject `
                -ResourceGroupName $RGObject.ResourceGroupName -Location `
                $RGObject.Location -AllocationMethod $PublicIPAllocationObject `
                -DomainNameLabel $PublicIPNameObject -Force                                 # Creates the new public IP address
            if ($PublicIPObject) {                                                          # If $PublicIPObject is not $null
                Return $PublicIPObject                                                      # Returns to calling function with $PublicIPObject
            }                                                                               # End if ($PublicIPObject)
            else {                                                                          # If $PublicIPObject is $null 
                Write-Host "An error has occured"                                           # Write message to screen
                Break NewAzurePublicIP                                                      # Breaks :NewAzurePublicIP
            }                                                                               # End else (if ($PublicIPObject))
        }                                                                                   # End :NewAzurePublicIP while ($true)
        Return                                                                              # Returns to calling function with # null
    }                                                                                       # End Begin
}                                                                                           # End function NewAzPublicIpAddress
function GetAzPublicIpAddress {                                                             # Function for 
    Begin {                                                                                 # Begin function
        :GetAzurePublicIP while ($true) {                                                   # Outer loop for managing function
            $PublicIPList = Get-AzPublicIpAddress                                           # Gets a list of all public IP address
            [System.Collections.ArrayList]$PublicIPArray = @()                              # Creates array for list to be loaded into
            $PublicIPNumber = 1                                                             # Creates #var used for list selection
            Write-Host "[ 0 ] to exit"                                                      # Write message to screen
            foreach ($_ in $PublicIPList) {                                                 # For each item in list
                $PublicIPInput = [PSCustomObject]@{'Name' = $_.Name;'Number' `
                    = $PublicIPNumber;'RG' = $_.ResourceGroupName;'Sku'=$_.Sku.Name `
                ;'Allocation'=$_.PublicIpAllocationMethod;'Address'=$_.IPAddress}           # Creates the item to loaded into array
                $PublicIPArray.Add($PublicIPInput) | Out-Null                               # Loads item into array, out-null removes write to screen
                $PublicIPNumber = $PublicIPNumber + 1                                       # Increments $var up by 1
            }                                                                               # End foreach ($_ in $PublicIPArray)
            foreach ($_ in $PublicIPArray) {                                                # For each item in list
                Write-Host "["$_.Number"]"                                                  # Write message to screen
                Write-Host "Name "$_.Name                                                   # Write message to screen
                Write-Host "RG:  "$_.RG                                                     # Write message to screen
                Write-Host "Type:"$_.Allocation                                             # Write message to screen
                Write-Host "Add: "$_.address                                                # Write message to screen
                Write-Host "Sku: "$_.Sku                                                    # Write message to screen                            
                Write-Host ""                                                               # Write message to screen
            }                                                                               # End foreach ($_ in $PublicIPArray) 
            :SelectAzurePublicIP while ($true) {                                            # Inner loop for selecting the public IP
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
function GetAzResourceGroup {                                                               # Function to get a resource group, can pipe $RGObject to another function
    Begin {                                                                                 # Begin function
        $ErrorActionPreference = 'silentlyContinue'                                         # Disables error reporting
        :GetAzureResourceGroup while ($true) {                                              # Outer loop for managing function
            $RGList = Get-AzResourceGroup                                                   # Gets all resource groups and assigns to $RGList
            $RGListNumber = 1                                                               # Sets $RGListNumber to 1
            [System.Collections.ArrayList]$RGListArray = @()                                # Creates the RG list array
            foreach ($_ in $RGList) {                                                       # For each $_ in $RGListList
                $RGListInput = [PSCustomObject]@{'Name' = $_.ResourceGroupName; `
                    'Number' = $RGListNumber; 'Location' = $_.Location}                     # Creates the item to loaded into array
                $RGListArray.Add($RGListInput) | Out-Null                                   # Loads item into array, out-null removes write to screen
                $RGListNumber = $RGListNumber + 1                                           # Increments $RGListNumber by 1
            }                                                                               # End foreach ($_ in $RGList)
            Write-Host "0 Exit"                                                             # Write message to screen
            foreach ($_ in $RGListArray) {                                                  # For each $_ in $RGListArray
                Write-Host $_.Number $_.Name "|" $_.Location                                # Writes RG number, name, and location to screen
            }                                                                               # End foreach ($_ in $RGListArray)
            :SelectAzureRGList while ($true) {                                              # Inner loop to select the resource group
                if ($CallingFunction) {                                                     # If $CallingFunction exists
                    Write-Host "You are selecting the resource group for"$CallingFunction   # Write message to screen
                }                                                                           # End if ($CallingFunction)
                $RGSelect = Read-Host "Enter the resource group number"                     # Operator input for the RG selection
                if ($RGSelect -eq '0') {                                                    # If $RGSelect equals 0
                    Break GetAzureResourceGroup                                             # Breaks :GetAzureResourceGroup
                }                                                                           # End if ($RGSelect -eq '0')
                $RGSelect = $RGListArray | Where-Object {$_.Number -eq $RGSelect}           # $RGSelect is equal to $RGArray where $RGArray.Number is equal to $RGSelect                                  
                $RGObject = Get-AzResourceGroup | Where-Object `
                    {$_.ResourceGroupName -eq $RGSelect.Name}                               # Pulls the full resource group object
                if ($RGObject) {                                                            # If $RGObject has a value
                    Return $RGObject                                                        # Returns to calling function with $RGObject
                }                                                                           # End if ($RGObject)
                else {                                                                      # If $RGObject does not have a value
                    Write-Host "That was not a valid option"                                # Write message to screen
                }                                                                           # End else (if ($RGObject))
            }                                                                               # End :SelectAzureRGList while ($true)
        }                                                                                   # End :GetAzureResourceGroup while ($true)
    }                                                                                       # End begin statement
}                                                                                           # End function GetAzResourceGroup