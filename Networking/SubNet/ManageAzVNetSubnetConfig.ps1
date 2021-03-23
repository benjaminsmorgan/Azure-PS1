# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Mircosoft docs links
    Add-AzVirtualNetworkSubnetConfig: https://docs.microsoft.com/en-us/powershell/module/az.network/add-azvirtualnetworksubnetconfig?view=azps-5.4.0
    Get-AzVirtualNetworkSubnetConfig: https://docs.microsoft.com/en-us/powershell/module/az.network/get-azvirtualnetworksubnetconfig?view=azps-5.4.0
    Remove-AzVirtualNetworkSubnetConfig: https://docs.microsoft.com/en-us/powershell/module/az.network/remove-azvirtualnetworksubnetconfig?view=azps-5.6.0
    Get-AzVirtualNetwork:       https://docs.microsoft.com/en-us/powershell/module/az.network/get-azvirtualnetwork?view=azps-5.4.0
} #>
<# Required Functions Links: {
    AddAzVNetSubnetConfig:      https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/SubNet/AddAzVNetSubnetConfig.ps1
    GetAzVNetSubnetConfig:      https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/SubNet/GetAzVNetSubnetConfig.ps1
    RemoveAzVNetSubnetConfig:   https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/SubNet/RemoveAzVNetSubnetConfig.ps1
    GetAzVirtualNetwork:        https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/VNet/GetAzVirtualNetwork.ps1
} #>
<# Functions Description: {
    ManageAzVNetSubnetConfig:   Management function for subnets    
    AddAzVNetSubnetConfig:      Adds an azure virtual network subnet
    GetAzVNetSubnetConfig:      Gets an azure virtual network subnet
    RemoveAzVNetSubnetConfig:   Removes an azure virtual network subnet
    GetAzVirtualNetwork:        Gets an azure virtual network
} #>
<# Variables: {
    :ManageAzureSubnet          Outer loop for managing function
    $VNetObject:                Virtual network object
    $SubnetObject:              Subnet object
    $ManageAzSubnet:            Operator input for selecting function
    AddAzVNetSubnetConfig{}     Creates $SubnetObject
        GetAzVirtualNetwork{}       Gets $VnetObject
    GetAzVNetSubnetConfig{}     Gets $SubnetObject, $VnetObject
    RemoveAzVNetSubnetConfig{}  Removes $SubnetObject
        GetAzVNetSubnetConfig{}     Gets $SubnetObject, $VnetObject
} #>
<# Process Flow {
    Function
        Call ManageAzVnetSubnetConfig > Get $SubnetObject
            Call AddAzVNetSubnetConfig > Get $SubnetObject
                Call GetAzVirtualNetwork > Get $VNetObject
                End GetAzVirtualNetwork
                    Return AddAzVNetSubnetConfig > Send $VNetObject
            End AddAzVNetSubnetConfig
                Return ManageAzVnetSubnetConfig > Send $SubnetObject
            Call GetAzVNetSubnetConfig > Get $SubnetObject
            End GetAzVNetSubnetConfig
                Return ManageAzVnetSubnetConfig > Send $SubnetObject
            Call RemoveAzVNetSubnetConfig > Get $null
                Call GetAzVNetSubnetConfig > Get $SubnetObject
                End GetAzVNetSubnetConfig
                    Return RemoveAzVNetSubnetConfig > Send $SubnetObject
            End RemoveAzVNetSubnetConfig
                Return ManageAzVnetSubnetConfig > Send $null
        End ManageAzVnetSubnetConfig
            Return function > Send $SubnetObject
}#>
function ManageAzVNetSubnetConfig {                                                         # Function for managing azure Subnet resources
    Begin {                                                                                 # Begin function   
        :ManageAzureSubnet while ($true) {                                                  # Outer loop for managing function
            if ($VNetObject) {                                                              # If $VnetObject has a value
                Write-Host 'The currently selected Vnet is:'$VNetObject.name                # Write message to screen
            }                                                                               # End if ($VNetObject)
            if ($SubnetObject) {                                                            # If $subnetObject has a value
                Write-Host 'The currently selected Subnet is:'$SubnetObject.name            # Write message to screen
            }                                                                               # End if ($SubnetObject)
            Write-Host "Azure Subnet Management"                                            # Write message to screen
            Write-Host '0 Clear "$vars"'                                                    # Write message to screen
            Write-Host '1 Add subnet'                                                       # Write message to screen
            Write-Host '2 Get subnet'                                                       # Write message to screen
            Write-Host '3 Remove subnet'                                                    # Write message to screen
            Write-Host "'Exit to return'"                                                   # Write message to screen
            $ManageAzSubnet = Read-Host "Option?"                                           # Collects operator input on $ManageAzSubnet option
            if ($ManageAzSubnet -eq 'exit') {                                               # If $ManageAzSubnet equals 'exit'
                Break ManageAzureSubnet                                                     # Breaks :ManageAzureSubnet
            }                                                                               # End if ($ManageAzSubnet -eq 'exit')
            elseif ($ManageAzSubnet -eq '0') {                                              # Elseif $ManageAzSubnet equals 0
                if ($VNetObject) {                                                          # If $VNetObject has a value
                    Write-Host 'Clearing "$VNetObject'                                      # Write message to screen
                    $VNetObject = $null                                                     # Clears $VNetObject
                }                                                                           # End if ($VNetObject)
                else {                                                                      # If $VNetObject does not have a value
                    Write-Host '$VNetObject is already clear'                               # Write message to screen
                }                                                                           # End else (if ($VnetObject))
                if ($SubnetObject) {                                                        # If $SubnetObject has a value
                    Write-Host 'Clearing "$SubnetObject'                                    # Write message to screen
                    $SubnetObject = $null                                                   # Clears $SubnetObject
                }                                                                           # End if ($SubnetObject)
                else {                                                                      # If $SubnetObject does not have a value
                    Write-Host '$SubnetObject is already clear'                             # Write message to screen
                }                                                                           # End else (if ($SubnetObject))
            }                                                                               # End elseif ($ManageAzSubnet -eq '0')
            elseif ($ManageAzSubnet -eq '1') {                                              # Elseif $ManageAzSubnet equals 1
                Write-Host 'Add subnet'                                                     # Write message to screen
                $SubnetObject = AddAzVNetSubnetConfig ($VNetObject)                         # Calls function and assigns output to $var
            }                                                                               # End elseif ($ManageAzSubnet -eq '1')
            elseif ($ManageAzSubnet -eq '2') {                                              # Elseif $ManageAzSubnet equals 2
                Write-Host 'Get subnet'                                                     # Write message to screen
                $SubnetObject, $VNetObject = GetAzVNetSubnetConfig                          # Calls function and assigns output to $var
            }                                                                               # End elseif ($ManageAzSubnet -eq '2')
            elseif ($ManageAzSubnet -eq '3') {                                              # Elseif $ManageAzSubnet equals 3
                Write-Host 'Remove subnet'                                                  # Write message to screen
                RemoveAzVNetSubnetConfig ($SubnetObject, $VNetObject)                       # Calls function
            }                                                                               # End elseif ($ManageAzSubnet -eq '3')
            else {                                                                          # If $ManageAzSubnet do not match any if or elseif     
                Write-Host "That was not a valid option"                                    # Write message to screen
            }                                                                               # End else (if ($ManageAzSubnet -eq 'exit'))
        }                                                                                   # End :ManageAzureSubnet while ($true)
        Return $VNetObject, $SubnetObject                                                   # Returns $vars to calling function
    }                                                                                       # End Begin
}                                                                                           # End function ManageAzVNetSubnetConfig
function AddAzVNetSubnetConfig {                                                            # Function to create a subnet
    begin {                                                                                 # Begin function
        :AddAzureSubnet while ($true) {                                                     # Outer loop for managing function
            if (!$VNetObject) {                                                             # if $VNetObject is $null
                $VNetObject = GetAzVirtualNetwork                                           # Calls function and assigns output to $Var
                if (!$VNetObject) {                                                         # if $VNetObject is $null
                    Break AddAzureSubnet                                                    # Breaks :AddAzureSubnet
                }                                                                           # End if (!$VNetObject)
            }                                                                               # End if (!$VNetObject)
            :SetAzureSubNetName while ($true) {                                             # Inner loop for setting the subnet name
                $SubnetName = Read-Host "Subnet name"                                       # Operator input for the subnet name
                if ($SubnetName -eq 'exit') {                                               # If $SubnetName is 'exit'
                    Break AddAzureSubnet                                                    # Breaks :AddAzureSubnet
                }                                                                           # End if ($SubnetName -eq 'exit')
                $OperatorConfirm = Read-Host `
                    "Set" $SubnetName "as the subnet name [Y] or [N]"                       # Operator confirmation of the name
                if ($OperatorConfirm -eq 'y') {                                             # If $OperatorConfirm equals 'y'
                    Break SetAzureSubNetName                                                # Breaks :SetAzureSubNetName
                }                                                                           # End if ($OperatorConfirm -eq 'y')
            }                                                                               # End :SetAzureSubNetName while ($true)
            :SetAzureSubnetAddress while ($true) {                                          # Inner loop for setting the subnet prefix
                $AddressPrefix = Read-Host "Address Prefix (E.X. 10.0.1.0/24)"              # Operator input for the subnet prefix
                if ($AddressPrefix -eq 'exit') {                                            # If $AddressPrefix equals 'exit'
                    Break AddAzureSubnet                                                    # Breaks :AddAzureSubnet
                }                                                                           # End if ($AddressPrefix -eq 'exit')
                $OperatorConfirm = Read-Host `
                    "Use" $AddressPrefix "as the subnet address prefix [Y] or [N]"          # Operator confirmation of the address prefix
                if ($OperatorConfirm -eq 'y') {                                             # If $OperatorConfirm equals 'y'
                    Break SetAzureSubnetAddress                                             # Breaks :SetAzureSubnetAddress
                }                                                                           # End if ($OperatorConfirm -eq 'y')
            }                                                                               # End :SetAzureSubnetAddress while ($true)
            try {                                                                           # Try the following
                $SubnetObject = Add-AzVirtualNetworkSubnetConfig -Name $SubnetName `
                    -VirtualNetwork $VNetObject -AddressPrefix $AddressPrefix | `
                    Set-AzVirtualNetwork -ErrorAction 'Stop'                                # Creates the new subnet config and adds to $VNetObject
            }                                                                               # End Try
            catch {                                                                         # If try fails
                Write-Host 'An error has occured'                                           # Write message to screen
                Break AddAzVNetSubnetConfig                                                 # Breaks :AddAzVNetSubnetConfig
            }                                                                               # End catch
            Return $SubnetObject                                                            # Returns to calling function with $var
        }                                                                                   # End :AddAzureSubnet while ($true)
        Return                                                                              # Returns to calling function with $Null
    }                                                                                       # End Begin
}                                                                                           # End function AddAzVNetSubnetConfig
function GetAzVNetSubnetConfig {                                                            # Function to get a subnet
    Begin{                                                                                  # Begin function
        :GetAzureSubnet while ($true) {                                                     # Outer loop for managing function
            $VNetList = Get-AzVirtualNetwork                                                # Gets a list of all virtual networks
            $ListNumber = 1                                                                 # List number used for subnet selection
            [System.Collections.ArrayList]$ListArray = @()                                  # Array that all info is loaded into
            foreach ($_ in $VNetList) {                                                     # For each object in $VnetList
                $VNet = $_.Name                                                             # Sets $Vnet as the current object Vnet name
                $VnetPFX = $_.AddressSpace.AddressPrefixes                                  # Sets $VnetPFX as the current object Vnet prefix
                $VNetRG = $_.ResourceGroupName                                              # Sets $VnetRG as the current object Vnet resource group
                $SubnetList = Get-AzVirtualNetworkSubnetConfig -VirtualNetwork $_           # Creates a list of subnets on the current object vnet
                foreach ($_ in $SubnetList) {                                               # For each $_ in $RGListList
                        $ListInput = [PSCustomObject]@{'Name' = $_.Name; `
                            'Number' = $ListNumber; 'Vnet' = $VNet; 'PFX' = `
                            $_.AddressPrefix; 'VnetPFX' = $VnetPFX; 'RG' = $VNetRG}         # Creates the item to loaded into array
                        $ListArray.Add($ListInput) | Out-Null                               # Loads item into array, out-null removes write to screen
                        $ListNumber = $ListNumber + 1                                       # Increments $ListNumber by 1
                }                                                                           # End foreach ($_ in $SubnetList)                                        
            }                                                                               # End foreach ($_ in $VNetList)
            Write-Host '[ 0 ] Exit'                                                         # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            foreach ($_ in $ListArray) {                                                    # For each item in $ListArray
                Write-Host '['$_.Number']'                                                  # Write message to screen
                Write-Host 'Sub Name:   '$_.name                                            # Write message to screen
                Write-Host 'Add Prefix: '$_.PFX                                             # Write message to screen
                Write-Host 'VNet Name:  '$_.Vnet                                            # Write message to screen
                Write-Host 'Vnet Prefix:'$_.VnetPFX                                         # Write message to screen
                Write-Host ''                                                               # Write message to screen
            }                                                                               # End foreach ($_ in $ListArray)
            :SelectAzureSubNet while ($true) {                                              # Inner loop for selecting the subnet
                $SubnetSelect = Read-Host 'Enter [#] of the subnet'                         # Operator input for the subnet selection
                if ($SubnetSelect -eq '0') {                                                # If $SubnetSelect equals '0'
                    Break GetAzureSubnet                                                    # Breaks :GetAzureSubnet   
                }                                                                           # End if ($SubnetSelect -eq '0')
                elseif ($SubnetSelect -in $ListArray.Number) {                              # If $SubnetSelect is in $ListArray.Number
                    $SubnetSelect = $ListArray | Where-Object {$_.Number -eq $SubnetSelect} # $Subnet select is equal to object in $ListArray
                    Try {                                                                   # Try the following
                        $VNetObject = Get-AzVirtualNetwork -Name $SubnetSelect.Vnet `
                            -ResourceGroupName $SubnetSelect.RG                             # Pulls the $VnetObject
                        $SubnetObject = Get-AzVirtualNetworkSubnetConfig -VirtualNetwork `
                            $VNetObject -Name $SubnetSelect.Name                            # Pulls the $SubnetObject
                    }                                                                       # End Try
                    catch {                                                                 # If Try fails
                        Write-Host 'An error has occured'                                   # Write message to screen
                        Break GetAzureSubnet                                                # Breaks :GetAzureSubnet
                    }                                                                       # End catch   
                    Return $SubnetObject, $VNetObject                                       # Returns to calling function with $SubnetObject and $VNetObject
                }                                                                           # End elseif ($SubnetSelect -in $ListArray.Number)
                else {                                                                      # All other inputs for $SubnetSelect
                    Write-Host 'That was not a valid option'                                # Write message to screen
                }                                                                           # End else (if ($SubnetSelect -eq '0'))
            }                                                                               # End :SelectAzureSubNet while ($true)
        }                                                                                   # End :GetAzureSubnet while ($true)
        Return                                                                              # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function GetAzVNetSubnetConfig
function RemoveAzVNetSubnetConfig {                                                         # Function to remove a subnet
    Begin {                                                                                 # Begin function
        :RemoveAzureSubnet while ($true) {                                                  # Outer loop for managing function
            if (!$SubnetObject) {                                                           # If $SubnetObject is $null
                $SubnetObject, $VNetObject = GetAzVNetSubnetConfig                          # Call function and assign output to $var
                if (!$SubnetObject) {                                                       # If $SubnetObject is $null
                    Break RemoveAzureSubnet                                                 # Breaks :RemoveAzureSubnet
                }                                                                           # End if (!$SubnetObject)
            }                                                                               # End if (!$SubnetObject)
            Write-Host 'Remove the subnet'$SubnetObject.Name                                # Write message to screen
            $OperatorConfirm = Read-Host '[Y] or [N]'                                       # Operator confirmation for removing the subnet
            if ($OperatorConfirm -eq 'y') {                                                 # If $OperatorConfirm equals 'y'
                Try {                                                                       # Try the following
                    Remove-AzVirtualNetworkSubnetConfig -Name $SubnetObject.Name `
                        -VirtualNetwork $VNetObject | Set-AzVirtualNetwork `
                        -ErrorAction 'Stop'                                                 # Removes the subnet
                }                                                                           # End try
                catch {                                                                     # If try fails
                    write-Host 'An error has occured'                                       # Write message to screen
                    Write-Host 'No changes have been made'                                  # Write message to screen
                    Break RemoveAzureSubnet                                                 # Breaks :RemoveAzureSubnet
                }                                                                           # End catch
                Write-Host 'The subnet has been removed'                                    # Write message to screen
                Break RemoveAzureSubnet                                                     # Breaks :RemoveAzureSubnet
            }                                                                               # End if ($OperatorConfirm -eq 'y') 
            else {                                                                          # If $OperatorConfirm does not equal 'y'
                Break RemoveAzureSubnet                                                     # Breaks :RemoveAzureSubnet
            }                                                                               # End else (if ($OperatorConfirm -eq 'y'))
        }                                                                                   # End :RemoveAzureSubnet while ($true)
        Return                                                                              # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function RemoveAzVNetSubnetConfig
# Additional functions required for Manage
function GetAzVirtualNetwork {                                                              # Function for getting an Azure virtual network
    Begin {                                                                                 # Begin function
        :GetAzureVnet while ($true) {                                                       # Outer loop for managing function
            $ObjectList = Get-AzVirtualNetwork                                              # pulls all items into list for selection
            $ListNumber = 1                                                                 # $var used for selecting the virtual network
            [System.Collections.ArrayList]$ObjectArray = @()                                # Creates the RG list array
            foreach ($_ in $ObjectList) {                                                   # For each $_ in $RGListList
                $ArrayInput = [PSCustomObject]@{'Number' = $ListNumber; 'Name' = $_.Name; `
                    'RG' = $_.ResourceGroupName; 'Location' = $_.Location; 'ASpace' = `
                    $_.AddressSpace.AddressPrefixes}                                        # Creates the item to loaded into array
                $ObjectArray.Add($ArrayInput) | Out-Null                                    # Loads item into array, out-null removes write to screen
                $ListNumber = $ListNumber + 1                                               # Increments $RGListNumber by 1
            }                                                                               # End foreach ($_ in $RGList)
            Write-Host '[ 0  ]    Exit'                                                     # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            foreach ($_ in $ObjectArray) {                                                  # For each name in $ObjectList
                Write-Host '['$_.Number']'                                                  # Write message to screen
                Write-Host 'Name:    '$_.Name                                               # Write message to screen
                Write-Host 'RG:      '$_.RG                                                 # Write message to screen
                Write-Host 'Loc:     '$_.Location                                           # Write message to screen
                Write-Host 'A Space: '$_.ASpace                                             # Write message to screen
                Write-Host ''                                                               # Write message to screen
            }                                                                               # End foreach ($Name in $Array)
            :SelectAzureVNet while ($true) {                                                # Inner loop for selecting the Vnet
                $VNetSelect = Read-Host `
                    "Please enter the number of the virtual network"                        # Operator input for the VNet selection
                if ($VNetSelect -eq '0') {                                                  # If $VNetSelect equals 0
                    Break GetAzureVNet                                                      # Breaks :GetAzureVNet
                }                                                                           # End if ($VNetSelect -eq '0')
                elseif ($VNetSelect -in $ObjectArray.Number) {                              # Else if $VNetSelect is in $ObjectArray.Number
                    $VNetSelect = $ObjectArray | Where-Object {$_.Number -eq $VNetSelect}   # $VNetSelect is equal to $ObjectArray where $VNetSelect equals $ObjectArray.Number
                    $VNetObject = Get-AzVirtualNetwork -Name $VNetSelect.Name `
                        -ResourceGroupName $VNetSelect.RG                                   # Pulls the full object and assigns to $var
                        Return $VNetObject                                                  # Returns to calling function with $var
                }                                                                           # End elseif ($VNetSelect -in $ObjectArray.Number)
                else {                                                                      # All other inputs for $VNetSelect
                    Write-Host 'That was not a valid option'                                # Write message to screen
                }                                                                           # End else (if ($VNetSelect -eq '0'))
            }                                                                               # End :SelectAzureVNet while ($true)
        }                                                                                   # End :GetAzureVnet while ($true)
        Return                                                                              # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function GetAzVirtualNetwork