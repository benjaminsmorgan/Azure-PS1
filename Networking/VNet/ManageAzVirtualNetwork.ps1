# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Mircosoft docs links
    New-AzVirtualNetwork:       https://docs.microsoft.com/en-us/powershell/module/az.network/new-azvirtualnetwork?view=azps-5.4.0
    Get-AzVirtualNetwork:       https://docs.microsoft.com/en-us/powershell/module/az.network/get-azvirtualnetwork?view=azps-5.4.0
    Remove-AzVirtualNetwork:    https://docs.microsoft.com/en-us/powershell/module/az.network/remove-azvirtualnetwork?view=azps-5.4.0
    Get-AzResourceGroup:        https://docs.microsoft.com/en-us/powershell/module/az.resources/get-azresourcegroup?view=azps-5.1.0
    Get-AzLocation:             https://docs.microsoft.com/en-us/powershell/module/az.resources/get-azlocation?view=azps-5.4.0
} #>
<# Required Functions Links: {
    NewAzVirtualNetwork:        https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/VNet/NewAzVirtualNetwork.ps1
    ListAzVirtualNetwork:       https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/VNet/ListAzVirtualNetwork.ps1
    GetAzVirtualNetwork:        https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/VNet/GetAzVirtualNetwork.ps1
    RemoveAzVirtualNetwork:     https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/VNet/RemoveAzVirtualNetwork.ps1
    GetAzResourceGroup:         https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/GetAzResourceGroup.ps1
    GetAzLocation:              https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/GetAzLocation.ps1
    AddAzVNetSubnetConfig:      https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/SubNet/AddAzVNetSubnetConfig.ps1
} #>
<# Functions Description: {
    ManageAzVirtualNetwork:     Management function for azure virtual networks
    NewAzVirtualNetwork:        Creates a new azure virtual network
    ListAzVirtualNetwork:       Lists all existing azure virtual networks
    GetAzVirtualNetwork:        Gets an existing azure virtual network
    RemoveAzVirtualNetwork:     Removes an azure virtual network
    NewAzSubnet:                Creates a new subnet in an Azure virtual network
    GetAzResourceGroup:         Gets a resource group object
    GetAzLocation:              Gets an Azure location
} #>
<# Variables: {
    :ManageAzureVirtualNetwork  Outer loop for managing function
    $RGObject:                  Resource group object
    $VNetObject:                Virtual network object
    $ManageAzVirtualNetwork:    Operator input to select management function
    NewAzVirtualNetwork{}       Creates $VNetObject
        GetAzResourceGroup{}        Gets $RGObject
        GetAzLocation{}             Gets $LocationObject
        AddAzVNetSubnetConfig{}     Adds subnets to $VNetObject
    ListAzVirtualNetwork{}      Lists Vnets
    GetAzVirtualNetwork{}       Gets $VNetObject
    RemoveAzVirtualNetwork{}   Removes $VnetObject
        GetAzVirtualNetwork{}       Gets $VNetObject
} #>
<# Process Flow {
    Function
        Call ManageAzVirtualNetwork > Get $VNetObject
            Call NewAzVirtualNetwork > Get $VNetObject
                Call GetAzResourceGroup > Get $RGObject
                End GetAzResourceGoup
                    Return NewAzVirtualNetwork > Send $RGObject
                Call GetAzLocation > Get $LocationObject
                End GetAzLocation
                    Return NewAzVirtualNetwork > Send $LocationObject
                Call AddAzVNetSubnetConfig > Get $VNetObject
                End AddAzVNetSubnetConfig
                    Return NewAzVirtualNetwork > Send $VNetObject 
            End NewAzVirtualNetwork
                Return Function > Send $VNetObject
            Call ListAzVirtualNetwork > Get $null 
            End ListAzVirtualNetwork
                Return ManageAzVirtualNetwork > Send $null
            Call GetAzVirtualNetwork > Get $VNetObject
            End GetAzVirtualNetwork
                Return ManageAzVirtualNetwork > Send $VNetObject
            Call RemoveAzVirtualNetwork > Get $null
                Call GetAzVirtualNetwork > Get $VNetObject
                End GetAzVirtualNetwork
                    Return RemoveAzVirtualNetwork > Send $VNetObject
            End RemoveAzVirtualNetwork
                Return ManageAzVirtualNetwork > Send $null
        End ManageAzVirtualNetwork
            Return function > Send $VNetObject
}#>
function ManageAzVirtualNetwork {                                                           # Function for managing azure virtual networks
    Begin {                                                                                 # Begin function
        :ManageAzureVirtualNetwork while($true) {                                           # Outer loop for managing function
            if ($RGObject) {                                                                # If $RGObject has a value
                Write-Host 'The current RG is:' $RGObject.ResourceGroupName                 # Write message to screen
            }                                                                               # End if ($RGObject)
            if ($VNetObject) {                                                              # If $VNetObject has a value
                Write-Host 'The current Vnet is:' $VNetObject.name                          # Write message to screen
            }                                                                               # End if ($VNetObject)
            Write-Host "Azure Virtual Network Management"                                   # Write message to screen
            Write-Host '0 Clear "$VNetObject"'                                              # Write message to screen
            Write-Host '00 Clear $RGObject'                                                 # Write message to screen
            Write-Host '1 New virtual network'                                              # Write message to screen
            Write-Host '2 List virtual networks'                                            # Write message to screen
            Write-Host '3 Get virtual network'                                              # Write message to screen
            Write-Host '4 Remove virtual network'                                           # Write message to screen
            Write-Host "'Exit to return'"                                                   # Write message to screen
            $ManageAzVirtualNetwork = Read-Host "Option?"                                   # Collects operator input on $ManageAzContainerGroup option
            if ($ManageAzVirtualNetwork -eq 'exit') {                                       # If $ManageAzureVirtualNetwork equals 'exit'
                Break ManageAzureVirtualNetwork                                             # End Break ManageAzureVirtualNetwork
            }                                                                               # End if ($ManageAzVirtualNetwork -eq 'exit')
            if ($ManageAzVirtualNetwork -eq '0') {                                          # If $ManageAzVirtualNetwork equals '0'
                if ($VNetObject) {                                                          # If $VNetObject has a value
                    $VNetObject = $null                                                     # Clears $VNetObject
                    Write-Host '"$VNetObject" has been cleared'                             # Write message to screen
                }                                                                           # End if ($VNetObject)
                else {                                                                      # If $VNetObject does not have a value
                    Write-Host '"$VNetObject is already $null'                              # Write message to screen
                }                                                                           # End else (if ($VNetObject))
            }                                                                               # End if ($ManageAzVirtualNetwork -eq '0')
            elseif ($ManageAzVirtualNetwork -eq '00') {                                     # Else if $ManageAzVirtualNetwork equals '00'
                if ($RGObject) {                                                            # If $RGObject has a value
                    $RGObject = $null                                                       # Clears $RGObject
                    Write-Host '"$RGObject" has been cleared'                               # Write message to screen
                }                                                                           # End if ($RGObject)
                else {                                                                      # If $RGObject does not have a value
                    Write-Host '"$RGObject is already $null'                                # Write message to screen
                }                                                                           # End else (if ($RGObject))
            }                                                                               # End elseif ($ManageAzVirtualNetwork -eq '00')
            elseif ($ManageAzVirtualNetwork -eq '1') {                                      # Else if $ManageAzVirtualNetwork equals '1'
                Write-Host 'New virtual network'                                            # Write message to screen
                $VNetObject = NewAzVirtualNetwork ($RGObject)                               # Calls function and assigns output to $var
            }                                                                               # End elseif ($ManageAzVirtualNetwork -eq '1')
            elseif ($ManageAzVirtualNetwork -eq '2') {                                      # Else if $ManageAzVirtualNetwork equals '2'
                Write-Host 'List virtual networks'                                          # Write message to screen
                ListAzVirtualNetwork                                                        # Calls function
            }                                                                               # End elseif ($ManageAzVirtualNetwork -eq '2')
            elseif ($ManageAzVirtualNetwork -eq '3') {                                      # Else if $ManageAzVirtualNetwork equals '3'
                Write-Host 'Get virtual network'                                            # Write message to screen
                $VNetObject = GetAzVirtualNetwork                                           # Calls function and assigns output to $var
            }                                                                               # End elseif ($ManageAzVirtualNetwork -eq '3')
            elseif ($ManageAzVirtualNetwork -eq '4') {                                      # Else if $ManageAzVirtualNetwork equals '4'
                Write-Host 'Remove virtual network'                                         # Write message to screen
                RemoveAzVirtualNetwork ($VNetObject)                                        # Calls function
            }                                                                               # End elseif ($ManageAzVirtualNetwork -eq '4')
            else {                                                                          # Else for all other inputs for $ManageAzVirtualNetwork
                Write-Host 'That was not a valid option'                                    # Write message to screen
            }                                                                               # End else (if ($ManageAzVirtualNetwork -eq '0'))
        }                                                                                   # End :ManageAzureVirtualNetwork while($true)
        Return $VNetObject                                                                  # Returns to calling function with $VNetObject
    }                                                                                       # End Begin
}                                                                                           # End function ManageAzNetwork
function NewAzVirtualNetwork {                                                              # Creates a new Vnet
    Begin {                                                                                 # Begin function
        :NewAzureVNet while ($true) {                                                       # Outer loop for managing function
            if (!$RGObject) {                                                               # If $RGObject is $null
                $CallingFunction = 'NewAzVirtualNetwork'                                    # Creates $CallingFunction for network to display this functions name
                $RGObject = GetAzResourceGroup ($CallingFunction)                           # Calls function and assigns output to $var
                if (!$RGObject) {                                                           # If $RGObject is $null
                    Break NewAzureVNet                                                      # Breaks :NewAzureVnet
                }                                                                           # End if (!$RGObject)
            }                                                                               # End if (!$RGObject)
            if (!$LocationObject) {                                                         # If $LocationObject is $null
                $LocationObject = GetAzLocation ($CallingFunction)                          # Calls function and assigns output to $var
                if (!$LocationObject) {                                                     # If $LocationObject is $null
                    Break NewAzureVNet                                                      # Breaks :NewAzureVnet
                }                                                                           # End if (!$LocationObject)
            }                                                                               # End if (!$LocationObject)
            :SetAzureVNetName while ($true) {                                               # Inner loop for setting the vnet name
                $VNetName = Read-Host "Virtual network name"                                # Operator input for the vnet name
                if ($VNetName -eq 'exit') {                                                 # If $VnetName is 'exit'
                    Break NewAzureVNet                                                      # Breaks :NewAzureVnet
                }                                                                           # End if ($VNetName -eq 'exit')
                $OperatorConfirm = Read-Host "Set" $VNetName "as the VNet name [Y] or [N]"  # Operator confirmation of the name
                if ($OperatorConfirm -eq 'y') {                                             # If $OperatorConfirm equals 'y'
                    Break SetAzureVNetName                                                  # Breaks :SetAzureVNetName
                }                                                                           # End if ($OperatorConfirm -eq 'y')
            }                                                                               # End :SetAzureVNetName while ($true)
            :SetAzureVnetAddress while ($true) {                                            # Inner loop for setting the vnet prefix
                $AddressPrefix = Read-Host "Address Prefix (E.X. 10.0.0.0/16)"              # Operator input for the Vnet prefix
                $OperatorConfirm = Read-Host `
                    "Use" $AddressPrefix "as the Vnet address prefix [Y] or [N]"            # Operator confirmation of the address prefix
                if ($OperatorConfirm -eq 'y') {                                             # If $OperatorConfirm equals 'y'
                    Break SetAzureVnetAddress                                               # Breaks :SetAzureVnetAddress
                }                                                                           # End if ($OperatorConfirm -eq 'y')
            }                                                                               # End :SetAzureVnetAddress while ($true)
            $VNetObject = New-AzVirtualNetwork -Name $VNetName -ResourceGroupName `
                $RGObject.ResourceGroupName -Location $LocationObject.location `
                -AddressPrefix $AddressPrefix                                               # Creats the new Vnet
            $OperatorSelect = Read-Host "Add subnets [Y] or [N]"                            # Operator prompt for creating subnets
            if ($OperatorSelect -eq 'y') {                                                  # If $OperatorSelect equals yes
                AddAzVNetSubnetConfig ($VNetObject, $RGObject, $LocationObject)             # Calls function and passes new $VNetObject
            }                                                                               # End if ($OperatorSelect -eq 'y')
            Return $VNetObject                                                              # Returns to calling function with $VNetObject
        }                                                                                   # End :NewAzureVNet while ($true) 
        Return                                                                              # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function NewAzVirtualNetwork
function ListAzVirtualNetwork {                                                             # Function to list all virtual networks
    Begin {                                                                                 # Begin function
        $VNetList = Get-AzVirtualNetwork                                                    # Gets a list of all virtual networks
        foreach ($_ in $VNetList) {                                                         # For each item in $VNetList
            Write-Host 'Name:    '$_.Name                                                   # Write message to screen
            Write-Host 'RG:      '$_.ResourceGroupName                                      # Write message to screen
            Write-Host 'Loc:     '$_.Location                                               # Write message to screen
            Write-Host 'A Space: '$_.AddressSpace.AddressPrefixes                           # Write message to screen
            Write-Host ''                                                                   # Write message to screen
        }                                                                                   # End foreach ($_ in $VNetList)
        return                                                                              # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function ListAzVirtualNetwork
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
function RemoveAzVirtualNetwork {                                                           # Function to remove an Azure virtual network
    Begin {                                                                                 # Being function
        :RemoveAzureVnet while ($true) {                                                    # Outer loop for managing function
            if (!$VNetObject) {                                                             # If $VNetObject is $null
                $VNetObject = GetAzVirtualNetwork                                           # Calls function and assigns output to $var
                if (!$VNetObject) {                                                         # If $VNetObject is $null
                    Break RemoveAzureVnet                                                   # Breaks :RemoveAzureVnet
                }                                                                           # End if (!$VNetObject)
            }                                                                               # End if (!$VNetObject)
            Write-Host 'Remove the virtual network named'$VNetObject.Name                   # Write message to screen
            Write-Host 'from the resource group'$VNetObject.ResourceGroupName               # Write message to screen
            $OperatorConfirm = Read-Host '[Y] or [N]'                                       # Operator confirmation to remove the selected VNet
            if ($OperatorConfirm -eq 'y') {                                                 # If $OperatorConfirm equals 'y'
                Try {                                                                       # Try the following
                    Remove-AzVirtualNetwork -Name $VNetObject.Name -ResourceGroupName `
                        $VNetObject.ResourceGroupName -Force -ErrorAction 'Stop'            # Removes the virtual network
                }                                                                           # End Try
                Catch {                                                                     # If Try fails
                    Write-Host 'An error has occured'                                       # Write message to screen
                    Write-Host 'You may not have the'                                       # Write message to screen 
                    Write-Host 'required permissions'                                       # Write message to screen
                    Write-Host 'No changes have been made'                                  # Write message to screen
                    Break RemoveAzureVnet                                                   # Breaks :RemoveAzureVnet
                }                                                                           # End catch
                Write-Host 'The selected virtual network has been removed'                  # Write message to screen
                Break RemoveAzureVnet                                                       # Breaks :RemoveAzureVnet
            }                                                                               # End if ($OperatorConfirm -eq 'y')
            else {                                                                          # If $OperatorConfirm does not equal 'y'
                Write-Host 'No changes made'                                                # Write message to screen
                Break RemoveAzureVnet                                                       # Breaks :RemoveAzureVnet
            }                                                                               # End else (if ($OperatorConfirm -eq 'y'))
        }                                                                                   # End :RemoveAzureVnet while ($true)
        Return                                                                              # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function RemoveAzVirtualNetwork
# Additional functions required for ManageAzVirtualNetwork
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
function GetAzLocation { # Gets azure location
    Begin {
        :GetAzureLocation while ($true) { # Outer loop for managing function
            $LocationList = Get-AzLocation # Gets a list of all Azure locations
            $LocationListNumber = 1 # $Var for selecting the location
            Write-Host "0. Exit" # Write message to screen
            foreach ($Location in $LocationList) { # For each item in $LocationList
                Write-Host $LocationListNumber"." $Location.DisplayName # Writes list to screen
                $LocationListNumber = $LocationListNumber + 1 # Increments $LocationListNumber by 1
            } # End foreach ($Location in $LocationList)
            :GetAzureLocationName while ($true) { # Inner loop for selecting location from list
                $LocationSelect = Read-Host "Please enter the number of the location" # Operator input for the selection
                if ($LocationSelect -eq '0') { # If $LocationSelect is 0
                    Break GetAzureLocation # Breaks :GetAzureLocation
                } # End if ($LocationSelect -eq '0')
                $LocationListNumber = 1 # Resets $LocationListNumber
                foreach ($Location in $LocationList) { # For each item in $locationList
                    if ($LocationSelect -eq $LocationListNumber) { # If $LocationSelect equals $LocationListNumber
                        $LocationObject = Get-AzLocation | Where-Object {$_.Location -eq $Location.Location} # Collects the current location and assigns to $Location
                        Break GetAzureLocationName # Breaks :GetAzureLocationName 
                    } # End if ($LocationSelect -eq $LocationListNumber)
                    else { # If $locationSelect does not equal $LocationListNumber
                        $LocationListNumber = $LocationListNumber + 1 # Increments $LocationListNumber by 1
                    } # End else if ($LocationSelect -eq $LocationListNumber)
                } # End foreach ($Location in $LocationList)
                Write-Host "That was not a valid selection" # Write message to screen
            } # End :GetAzureLocationName while ($true)
            Return $LocationObject # Returns $Location to calling function
        } # End :GetAzureLocation while ($true)
        Return # Returns with $null 
    } # End Begin
} # End function GetAzLocation
function AddAzVNetSubnetConfig {
    begin {
        :AddAzureSubnet while ($true) { # Outer loop for managing function
            if (!$VNetObject) { # if $VNetObject is $null
                $VNetObject = GetAzVirtualNetwork # Calls function and assigns output to $Var
                if (!$VNetObject) { # if $VNetObject is $null
                    Break AddAzureSubnet # Breaks :AddAzureSubnet
                } # End if (!$VNetObject)
            } # End if (!$VNetObject)
            :SetAzureSubNetName while ($true) { # Inner loop for setting the subnet name
                $SubnetName = Read-Host "Subnet name" # Operator input for the subnet name
                if ($SubnetName -eq 'exit') { # If $SubnetName is 'exit'
                    Break AddAzureSubnet # Breaks :AddAzureSubnet
                } # End if ($SubnetName -eq 'exit')
                $OperatorConfirm = Read-Host "Set" $SubnetName "as the subnet name [Y] or [N]" # Operator confirmation of the name
                if ($OperatorConfirm -eq 'y') { # If $OperatorConfirm equals 'y'
                    Break SetAzureSubNetName # Breaks :SetAzureSubNetName
                } # End if ($OperatorConfirm -eq 'y')
            } # End :SetAzureSubNetName while ($true)
            :SetAzureSubnetAddress while ($true) { # Inner loop for setting the subnet prefix
                $AddressPrefix = Read-Host "Address Prefix (E.X. 10.0.0.0/16)" # Operator input for the subnet prefix
                $OperatorConfirm = Read-Host "Use" $AddressPrefix "as the subnet address prefix [Y] or [N]" # Operator confirmation of the address prefix
                if ($OperatorConfirm -eq 'y') { # If $OperatorConfirm equals 'y'
                    Break SetAzureSubnetAddress # Breaks :SetAzureSubnetAddress
                } # End if ($OperatorConfirm -eq 'y')
            } # End :SetAzureSubnetAddress while ($true)
            Add-AzVirtualNetworkSubnetConfig -Name $SubnetName -VirtualNetwork $VNetObject -AddressPrefix $AddressPrefix | Set-AzVirtualNetwork # Creates the new subnet config and adds to $VNetObject
            $OperatorSelect = Read-Host "Add another subnet" # Operator input to add more subnets
            if (!($OperatorSelect -eq 'y')) { # if $OperatorSelect does not equal 'y'
                Break AddAzureSubnet # Breaks :AddAzureSubnetAgain
            } # End if (!($OperatorSelect -eq 'y'))
        } # End :AddAzureSubnet while ($true)
        Return # Returns to calling function with $Null
    } # End Begin
} # End function AddAzVNetSubnetConfig