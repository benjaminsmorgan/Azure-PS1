# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Mircosoft docs links
    Add-AzVirtualNetworkSubnetConfig: https://docs.microsoft.com/en-us/powershell/module/az.network/add-azvirtualnetworksubnetconfig?view=azps-5.4.0
    Get-AzVirtualNetwork:       https://docs.microsoft.com/en-us/powershell/module/az.network/get-azvirtualnetwork?view=azps-5.4.0
} #>
<# Required Functions Links: {
    GetAzVirtualNetwork:        https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Networking/VNet/GetAzVirtualNetwork.ps1
} #>
<# Functions Description: {
    AddAzVNetSubnetConfig:      Adds an azure virtual network subnet
    GetAzVirtualNetwork:        Gets an azure virtual network
} #>
<# Variables: {
    :AddAzureSubnet             Outer loop for managing function
    :SetAzureSubNetName         Inner loop for setting the subnet name
    :SetAzureSubnetAddress      Inner loop for setting the subnet address
    $VNetObject:                Virtual network object
    $SubnetName:                Operator input for the subnet name
    $AddressPrefix:             Operator input for the subnet prefix
    $OperatorConfirm:           Operator confirmation of values
    $SubnetObject:              The created subnet object
    GetAzVirtualNetwork{}       Gets $VNetObject
} #>
<# Process Flow {
    Function
        Call AddAzVNetSubnetConfig > Get $SubnetObject
            Call GetAzVirtualNetwork > Get $VNetObject
            End GetAzVirtualNetwork
                Return AddAzVNetSubnetConfig > Send $VNetObject
        End AddAzVNetSubnetConfig
            Return Function > Send $SubnetObject
}#>
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