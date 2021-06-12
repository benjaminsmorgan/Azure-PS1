# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Mircosoft docs links
    Add-AzVirtualNetworkSubnetConfig:           https://docs.microsoft.com/en-us/powershell/module/az.network/add-azvirtualnetworksubnetconfig?view=azps-5.4.0
    Get-AzVirtualNetworkSubnetConfig:           https://docs.microsoft.com/en-us/powershell/module/az.network/get-azvirtualnetworksubnetconfig?view=azps-5.4.0
    Remove-AzVirtualNetworkSubnetConfig:        https://docs.microsoft.com/en-us/powershell/module/az.network/remove-azvirtualnetworksubnetconfig?view=azps-5.6.0
    Get-AzVirtualNetwork:                       https://docs.microsoft.com/en-us/powershell/module/az.network/get-azvirtualnetwork?view=azps-5.4.0
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
    GetAzVirtualNetwork:        Gets a virutal network
} #>
<# Variables: {
    :ManageAzureSubnet          Outer loop for managing function
    $VNetObject:                Virtual network object
    $SubnetObject:              Subnet object
    $OpSelect:                  Operator input for selecting function
    AddAzVNetSubnetConfig{}     Creates $SubnetObject
        GetAzVirtualNetwork{}       Gets $VnetObject
    ListAzVNetSubnetConfig{}    Lists subnets
    RemoveAzVNetSubnetConfig{}  Removes $SubnetObject
        GetAzVNetSubnetConfig{}     Gets $SubnetObject, $VnetObject
} #>
<# Process Flow {
    Function
        Call ManageAzVnetSubnetConfig > Get $null
            Call AddAzVNetSubnetConfig > Get $null
                Call GetAzVirtualNetwork > Get $VNetObject
                End GetAzVirtualNetwork
                    Return AddAzVNetSubnetConfig > Send $VNetObject
            End AddAzVNetSubnetConfig
                Return ManageAzVnetSubnetConfig > Send $null
            Call ListAzVNetSubnetConfig > Get $null
            End ListAzVNetSubnetConfig
                Return ManageAzVnetSubnetConfig > Send $null
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
            Write-Host 'Azure Subnet Management'                                            # Write message to screen
            Write-Host '[0] Exit'                                                           # Write message to screen
            Write-Host '[1] Add subnet'                                                     # Write message to screen
            Write-Host '[2] List subnets'                                                   # Write message to screen
            Write-Host '[3] Remove subnet'                                                  # Write message to screen
            $OpSelect = Read-Host 'Option [#]'                                              # Operator input to select management function
            Clear-Host                                                                      # Clears screen
            if ($OpSelect -eq '0') {                                                        # If $OpSelect equals '0'
                Break ManageAzureSubnet                                                     # Breaks :ManageAzureSubnet
            }                                                                               # End if ($OpSelect -eq '0')
            elseif ($OpSelect -eq '1') {                                                    # Elseif $OpSelect equals 1
                Write-Host 'Add subnet'                                                     # Write message to screen
                AddAzVNetSubnetConfig                                                       # Calls function 
            }                                                                               # End elseif ($OpSelect -eq '1')
            elseif ($OpSelect -eq '2') {                                                    # Elseif $OpSelect equals 2
                Write-Host 'List subnets'                                                   # Write message to screen
                ListAzVNetSubnetConfig                                                      # Calls function
            }                                                                               # End elseif ($OpSelect -eq '2')
            elseif ($OpSelect -eq '3') {                                                    # Elseif $OpSelect equals 3
                Write-Host 'Remove subnet'                                                  # Write message to screen
                RemoveAzVNetSubnetConfig                                                    # Calls function
            }                                                                               # End elseif ($OpSelect -eq '3')
            else {                                                                          # All other inputs for $OpSelect     
                Write-Host 'That was not a valid input'                                     # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Clear-Host                                                                  # Clears screen
            }                                                                               # End else (if ($OpSelect -eq 'exit'))
        }                                                                                   # End :ManageAzureSubnet while ($true)
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function ManageAzVNetSubnetConfig
function AddAzVNetSubnetConfig {                                                            # Function to create a subnet
    begin {                                                                                 # Begin function
        if (!$CallingFunction) {                                                            # If $CallingFunction is $null
            $CallingFunction = 'AddAzVNetSubnetConfig'                                      # Creates $CallingFunction
        }                                                                                   # End if (!$CallingFunction)
        :AddAzureSubnet while ($true) {                                                     # Outer loop for managing function
            $VNetObject = GetAzVirtualNetwork ($CallingFunction)                            # Calls function and assigns output to $Var
            if (!$VNetObject) {                                                             # if $VNetObject is $null
                Break AddAzureSubnet                                                        # Breaks :AddAzureSubnet
            }                                                                               # End if (!$VNetObject)
            :SetAzureSubNetName while ($true) {                                             # Inner loop for setting the subnet name
                Write-Host 'Enter the subnet name'                                          # Write message to screen
                $SubnetName = Read-Host 'Name'                                              # Operator input for the subnet name
                Clear-Host                                                                  # Clears screen
                Write-Host 'Use:'$SubnetName' as the subnet name'                           # Write message to screen
                $OpConfirm = Read-Host '[Y] Yes [N] No [E] Exit'                            # Operator confirmation of the name
                Clear-Host                                                                  # Clears screen
                if ($OpConfirm -eq 'y') {                                                   # If $OpConfirm equals 'y'
                    Break SetAzureSubNetName                                                # Breaks :SetAzureSubNetName
                }                                                                           # End if ($OpConfirm -eq 'y')
                if ($OpConfirm -eq 'e') {                                                   # If $OpConfirm is 'e'
                    Break AddAzureSubnet                                                    # Breaks :AddAzureSubnet
                }                                                                           # End if ($OpConfirm -eq 'e')
            }                                                                               # End :SetAzureSubNetName while ($true)
            :SetAzureSubnetAddress while ($true) {                                          # Inner loop for setting the subnet prefix
                Write-Host 'Enter the address prefix (E.X. 10.0.1.0/24)'                    # Write message to screen
                $AddressPrefix = Read-Host 'Prefix'                                         # Operator input for the subnet prefix
                Clear-Host                                                                  # Clears screen
                Write-Host 'Use:'$AddressPrefix' as the subnet address prefix'              # Write message to screen
                $OpConfirm = Read-Host '[Y] Yes [N] No [E] Exit'                            # Operator confirmation of the name
                Clear-Host                                                                  # Clears screen
                if ($OpConfirm -eq 'y') {                                                   # If $OpConfirm equals 'y'
                    Break SetAzureSubnetAddress                                             # Breaks :SetAzureSubnetAddress
                }                                                                           # End if ($OpConfirm -eq 'y')
                if ($OpConfirm -eq 'e') {                                                   # If $OpConfirm is 'e'
                    Break AddAzureSubnet                                                    # Breaks :AddAzureSubnet
                }                                                                           # End if ($OpConfirm -eq 'e')
            }                                                                               # End :SetAzureSubnetAddress while ($true)
            try {                                                                           # Try the following
                Write-Host 'Creating the subnet'                                            # Write message to screen
                Add-AzVirtualNetworkSubnetConfig -Name $SubnetName -VirtualNetwork `
                $VNetObject -AddressPrefix $AddressPrefix | Set-AzVirtualNetwork `
                -ErrorAction 'Stop'                                                         # Creates the new subnet config and adds to $VNetObject
            }                                                                               # End Try
            catch {                                                                         # If try fails
                Clear-Host                                                                  # Clears screen
                Write-Host 'An error has occured'                                           # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Write-Host 'The address prefix may not be valid'                            # Write message to screen
                Write-Host 'or the address prefix may already be in use'                    # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Write-Host 'The resource group may have a read only lock'                   # Write message to screen
                Write-Host 'or you may not have the permissions to do this'                 # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break AddAzureSubnet                                                        # Breaks :AddAzureSubnet
            }                                                                               # End catch
            Clear-Host                                                                      # Clears screen
            Write-Host 'The subnet has been created'                                        # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            Pause                                                                           # Pauses all actions for operator input
            Break AddAzureSubnet                                                            # Breaks :AddAzureSubnet
        }                                                                                   # End :AddAzureSubnet while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $Null
    }                                                                                       # End Begin
}                                                                                           # End function AddAzVNetSubnetConfig
function ListAzVNetSubnetConfig {                                                           # Function to list all subnets
    Begin{                                                                                  # Begin function
        :ListAzureSubnet while ($true) {                                                    # Outer loop for managing function
            Write-Host 'Gathering network info, this a take a moment'                       # Write message to screen
            $ObjectList = Get-AzVirtualNetwork                                              # Gets a list of all virtual networks
            Clear-Host                                                                      # Clears screen
            if (!$ObjectList) {                                                             # If $ObjectList is $null
                Write-Host ''                                                               # Write message to screen
                Write-Host 'No virtual networks present in this subscription'               # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break ListAzureSubnet                                                       # Breaks :ListAzureSubnet 
            }                                                                               # End if (!$ObjectList)
            [System.Collections.ArrayList]$ObjectArray = @()                                # Array that all info is loaded into
            foreach ($_ in $ObjectList) {                                                   # For each object in $ObjectList
                $VNet = $_.Name                                                             # Sets $Vnet as the current object Vnet name
                $VnetPFX = $_.AddressSpace.AddressPrefixes                                  # Sets $VnetPFX as the current object Vnet prefix
                $VNetRG = $_.ResourceGroupName                                              # Sets $VnetRG as the current object Vnet resource group
                $SubnetList = Get-AzVirtualNetworkSubnetConfig -VirtualNetwork $_           # Creates a list of subnets on the current object vnet
                Write-Host 'Gathering subnets in:'$VNet                                     # Write message to screen
                if (!$SubnetList) {                                                         # If $SubnetList is $null
                    Write-Host 'No Subnets present in:'$VNet                                # Write message to screen
                }                                                                           # End if (!$SubnetList)
                foreach ($_ in $SubnetList) {                                               # For each $_ in $SubnetList
                    $ListInput = [PSCustomObject]@{
                        'Name'=$_.Name;'Vnet'=$VNet;'PFX'=$_.AddressPrefix;`
                        'VnetPFX'=$VnetPFX;'RG'=$VNetRG}                                    # Creates the item to loaded into array
                    $ObjectArray.Add($ListInput) | Out-Null                                 # Loads item into array, out-null removes write to screen
                }                                                                           # End foreach ($_ in $SubnetList)
                Write-Host ''                                                               # Write message to screen                                        
            }                                                                               # End foreach ($_ in $ObjectList)
            if (!$ObjectArray) {                                                            # If $ObjectArray is $null
                Clear-Host                                                                  # Clears screen
                Write-Host ''                                                               # Write message to screen
                Write-Host 'No subnets present in this subscription'                        # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break ListAzureSubnet                                                       # Breaks :ListAzureSubnet 
            }                                                                               # End if (!$ObjectArray)
            Write-Host ''                                                                   # Write message to screen
            foreach ($_ in $ObjectArray) {                                                  # For each item in $ObjectArray
                Write-Host 'Sub Name:   '$_.name                                            # Write message to screen
                Write-Host 'Sub Prefix: '$_.PFX                                             # Write message to screen
                Write-Host 'VNet Name:  '$_.Vnet                                            # Write message to screen
                Write-Host 'VNet Prefix:'$_.VnetPFX                                         # Write message to screen
                Write-Host 'VNet RG:    '$_.RG                                              # Write message to screen
                Write-Host ''                                                               # Write message to screen
            }                                                                               # End foreach ($_ in $ObjectArray)  
            Pause                                                                           # Pauses all actions for operator input
            Break ListAzureSubnet                                                           # Breaks :ListAzureSubnet 
        }                                                                                   # End :ListAzureSubnet while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function ListAzVNetSubnetConfig
function GetAzVNetSubnetConfig {                                                            # Function to get a subnet
    Begin{                                                                                  # Begin function
        :GetAzureSubnet while ($true) {                                                     # Outer loop for managing function
            Write-Host 'Gathering network info, this a take a moment'                       # Write message to screen
            $ObjectList = Get-AzVirtualNetwork                                              # Gets a list of all virtual networks
            Clear-Host                                                                      # Clears screen
            Write-Host 'Gathering subnets, this may take a moment'                          # Write message to screen
            $ObjectNumber = 1                                                               # List number used for subnet selection
            [System.Collections.ArrayList]$ObjectArray = @()                                # Array that all info is loaded into
            foreach ($_ in $ObjectList) {                                                   # For each object in $ObjectList
                $VNet = $_.Name                                                             # Sets $Vnet as the current object Vnet name
                $VnetPFX = $_.AddressSpace.AddressPrefixes                                  # Sets $VnetPFX as the current object Vnet prefix
                $VNetRG = $_.ResourceGroupName                                              # Sets $VnetRG as the current object Vnet resource group
                $SubnetList = Get-AzVirtualNetworkSubnetConfig -VirtualNetwork $_           # Creates a list of subnets on the current object vnet
                foreach ($_ in $SubnetList) {                                               # For each $_ in $SubnetList
                    $ListInput = [PSCustomObject]@{
                        'Number'=$ObjectNumber;'Name'=$_.Name;'Vnet'=$VNet;'PFX'= `
                        $_.AddressPrefix;'VnetPFX'=$VnetPFX;'RG'=$VNetRG}                   # Creates the item to loaded into array
                    $ObjectArray.Add($ListInput) | Out-Null                                 # Loads item into array, out-null removes write to screen
                    $ObjectNumber = $ObjectNumber + 1                                       # Increments $ObjectNumber by 1
                }                                                                           # End foreach ($_ in $SubnetList)                                        
            }                                                                               # End foreach ($_ in $ObjectList)
            Clear-Host                                                                      # Clears screen
            :SelectAzureSubNet while ($true) {                                              # Inner loop for selecting the subnet
                Write-Host '[0] Exit'                                                       # Write message to screen
                Write-Host ''                                                               # Write message to screen
                foreach ($_ in $ObjectArray) {                                              # For each item in $ObjectArray
                    $Number = $_.Number                                                     # Creates $number from $_.Number
                    Write-Host "[$Number]"   $_.name                                        # Write message to screen
                    Write-Host 'Sub Prefix: '$_.PFX                                         # Write message to screen
                    Write-Host 'VNet Name:  '$_.Vnet                                        # Write message to screen
                    Write-Host 'VNet Prefix:'$_.VnetPFX                                     # Write message to screen
                    Write-Host 'VNet RG:    '$_.RG                                          # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                }                                                                           # End foreach ($_ in $ObjectArray)    
                if ($CallingFunction) {                                                     # If $Calling function exists
                    Write-Host 'You are selecting the subnet for:'$CallingFunction          # Write message to screen
                }                                                                           # End if ($CallingFunction)
                $OpSelect = Read-Host 'Option [#]'                                          # Operator input for the subnet selection
                Clear-Host                                                                  # Clears screen
                if ($OpSelect -eq '0') {                                                    # If $OpSelect equals '0'
                    Break GetAzureSubnet                                                    # Breaks :GetAzureSubnet   
                }                                                                           # End if ($OpSelect -eq '0')
                elseif ($OpSelect -in $ObjectArray.Number) {                                # If $OpSelect is in $ObjectArray.Number
                    $OpSelect = $ObjectArray | Where-Object {$_.Number -eq $OpSelect}       # $Subnet select is equal to object in $ObjectArray
                    $VNetObject = Get-AzVirtualNetwork -Name $OpSelect.Vnet `
                        -ResourceGroupName $OpSelect.RG                                     # Pulls the $VnetObject
                    $SubnetObject = Get-AzVirtualNetworkSubnetConfig -VirtualNetwork `
                        $VNetObject -Name $OpSelect.Name                                    # Pulls the $SubnetObject
                    Return $SubnetObject, $VNetObject                                       # Returns to calling function with $SubnetObject and $VNetObject
                }                                                                           # End elseif ($OpSelect -in $ObjectArray.Number)
                else {                                                                      # All other inputs for $OpSelect
                    Write-Host 'That was not a valid input'                                 # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Clear-Host                                                              # Clears screen
                }                                                                           # End else (if ($OpSelect -eq '0'))
            }                                                                               # End :SelectAzureSubNet while ($true)
        }                                                                                   # End :GetAzureSubnet while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function GetAzVNetSubnetConfig
function RemoveAzVNetSubnetConfig {                                                         # Function to remove a subnet
    Begin {                                                                                 # Begin function
        :RemoveAzureSubnet while ($true) {                                                  # Outer loop for managing function
            $SubnetObject, $VNetObject = GetAzVNetSubnetConfig                              # Call function and assign output to $var
            if (!$SubnetObject) {                                                           # If $SubnetObject is $null
                Break RemoveAzureSubnet                                                     # Breaks :RemoveAzureSubnet
            }                                                                               # End if (!$SubnetObject)
            $NICList = Get-AzNetworkInterface | Where-Object `
                {$_.IpConfigurations.Subnet.ID -eq $SubnetObject.ID}                        # Gets a list of all NICs on this subnet if present
            if ($NICList) {                                                                 # If $NICList has a value
                Write-Host 'This subnet cannot be deleted'                                  # Write message to screen
                Write-Host 'until all NICs are removed from it'                             # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break RemoveAzureSubnet                                                     # Breaks :RemoveAzureSubnet
            }                                                                               # End if ($NICList)
            Write-Host 'Remove Subnet: '$SubnetObject.Name                                  # Write message to screen
            Write-Host 'From VNet:     '$VNetObject.Name                                    # Write message to screen
            $OpConfirm = Read-Host '[Y] Yes [N] No'                                         # Operator confirmation for removing the subnet
            Clear-Host                                                                      # Clears screen
            if ($OpConfirm -eq 'y') {                                                       # If $OpConfirm equals 'y'
                Try {                                                                       # Try the following
                    Write-Host 'Removing subnet:'$SubnetObject.Name                         # Write message to screen
                    Remove-AzVirtualNetworkSubnetConfig -Name $SubnetObject.Name `
                        -VirtualNetwork $VNetObject | Set-AzVirtualNetwork `
                        -ErrorAction 'Stop'                                                 # Removes the subnet
                }                                                                           # End try
                catch {                                                                     # If try fails
                    Clear-Host                                                              # Clears screen
                    write-Host 'An error has occured'                                       # Write message to screen
                    Write-Host 'No changes have been made'                                  # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Break RemoveAzureSubnet                                                 # Breaks :RemoveAzureSubnet
                }                                                                           # End catch
                Clear-Host                                                                  # Clears screen
                Write-Host 'The subnet:'$SubnetObject.Name' has been removed'               # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break RemoveAzureSubnet                                                     # Breaks :RemoveAzureSubnet
            }                                                                               # End if ($OpConfirm -eq 'y') 
            else {                                                                          # If $OpConfirm does not equal 'y'
                Clear-Host                                                                  # Clears screen
                Write-Host 'No changes have been made'                                      # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break RemoveAzureSubnet                                                     # Breaks :RemoveAzureSubnet
            }                                                                               # End else (if ($OpConfirm -eq 'y'))
        }                                                                                   # End :RemoveAzureSubnet while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function RemoveAzVNetSubnetConfig
# Additional functions required for ManageAzVNetSubnetConfig
function GetAzVirtualNetwork {                                                              # Function for getting an Azure virtual network
    Begin {                                                                                 # Begin function
        :GetAzureVnet while ($true) {                                                       # Outer loop for managing function
            $ObjectList = Get-AzVirtualNetwork                                              # pulls all items into list for selection
            if (!$ObjectList) {                                                             # If $ObjectList is $null
                Write-Host ''                                                               # Write message to screen
                Write-Host 'No virtual networks present in this subscription'               # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break GetAzureVnet                                                          # Breaks :GetAzureVnet
            }                                                                               # End if (!$ObjectList)
            $ListNumber = 1                                                                 # $var used for selecting the virtual network
            [System.Collections.ArrayList]$ObjectArray = @()                                # Creates the RG list array
            foreach ($_ in $ObjectList) {                                                   # For each $_ in $RGListList
                $ArrayInput = [PSCustomObject]@{'Number' = $ListNumber; 'Name' = $_.Name; `
                    'RG' = $_.ResourceGroupName; 'Location' = $_.Location; 'ASpace' = `
                    $_.AddressSpace.AddressPrefixes}                                        # Creates the item to loaded into array
                $ObjectArray.Add($ArrayInput) | Out-Null                                    # Loads item into array, out-null removes write to screen
                $ListNumber = $ListNumber + 1                                               # Increments $RGListNumber by 1
            }                                                                               # End foreach ($_ in $RGList)
            :SelectAzureVNet while ($true) {                                                # Inner loop for selecting the Vnet
                Write-Host '[0]  Exit'                                                      # Write message to screen
                Write-Host ''                                                               # Write message to screen
                foreach ($_ in $ObjectArray) {                                              # For each item in $ObjectArray
                    $Number = $_.Number                                                     # $Number is equal to current item .number
                    if ($Number -le 9) {                                                    # If $number is 9 or less
                        Write-Host "[$Number]      "$_.Name                                 # Write message to screen
                    }                                                                       # End if ($Number -le 9)
                    else {                                                                  # If $number is greater than 9
                        Write-Host "[$Number]     "$_.Name                                  # Write message to screen
                    }                                                                       # End else (if ($Number -le 9))
                    Write-Host 'RG:      '$_.RG                                             # Write message to screen
                    Write-Host 'Loc:     '$_.Location                                       # Write message to screen
                    Write-Host 'A Space: '$_.ASpace                                         # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                }                                                                           # End foreach ($Name in $Array)    
                if ($CallingFunction) {                                                     # If $CallingFunction has a value
                    Write-Host 'Selecting the VNet for:'$CallingFunction                    # Write message to screen
                }                                                                           # End if ($CallingFunction)
                $OpSelect = Read-Host 'Option [#]'                                          # Operator input for the VNet selection
                Clear-Host                                                                  # Clears screen
                if ($OpSelect -eq '0') {                                                    # If $OpSelect equals 0
                    Break GetAzureVNet                                                      # Breaks :GetAzureVNet
                }                                                                           # End if ($OpSelect -eq '0')
                elseif ($OpSelect -in $ObjectArray.Number) {                                # Else if $OpSelect is in $ObjectArray.Number
                    $OpSelect = $ObjectArray | Where-Object {$_.Number -eq $OpSelect}       # $OpSelect is equal to $ObjectArray where $OpSelect equals $ObjectArray.Number
                    $VNetObject = Get-AzVirtualNetwork -Name $OpSelect.Name `
                        -ResourceGroupName $OpSelect.RG                                     # Pulls the full object and assigns to $var
                        Return $VNetObject                                                  # Returns to calling function with $var
                }                                                                           # End elseif ($OpSelect -in $ObjectArray.Number)
                else {                                                                      # All other inputs for $OpSelect
                    Write-Host 'That was not a valid input'                                 # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Clear-Host                                                              # Clears screen
                }                                                                           # End else (if ($OpSelect -eq '0'))
            }                                                                               # End :SelectAzureVNet while ($true)
        }                                                                                   # End :GetAzureVnet while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function GetAzVirtualNetwork