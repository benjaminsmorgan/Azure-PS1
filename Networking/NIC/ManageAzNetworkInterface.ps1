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
            $CallingFunction = 'NewAzNetworkInterface'                                      # Creates $CallingFunction
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
            Return $NICObject                                                               # Returns NicObject to calling function
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
                        $VNet = Get-AzVirtualNetwork -Name $OperatorSelect.VnetName `
                            -ResourceGroupName $OperatorSelect.VNetRG                       # Pulls the $Subnet Vnet
                        $Subnet = Get-AzVirtualNetworkSubnetConfig -VirtualNetwork $VNet `
                            -Name $OperatorSelect.Subname                                   # Pulls the $NicObject subnet
                        $NicObject = Get-AzNetworkInterface -Name $OperatorSelect.NicName |`
                            Where-Object {$_.IpConfigurations.Subnet.ID -eq $Subnet.ID}     # Pulls the full $NicObject
                    }                                                                       # End try
                    Catch {                                                                 # If try fails
                        Write-Host 'An error has occured'                                   # Write message to screen
                        Break GetAzureNic                                                   # Breaks :GetAzureNic
                    }                                                                       # End Catch
                    Return $NicObject                                                       # Returns $NicObject to calling function
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