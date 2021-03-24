# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Mircosoft docs links
    Get-AzNetworkInterface:     https://docs.microsoft.com/en-us/powershell/module/az.network/get-aznetworkinterface?view=azps-5.4.0
    Get-AzVirtualNetworkSubnetConfig: https://docs.microsoft.com/en-us/powershell/module/az.network/get-azvirtualnetworksubnetconfig?view=azps-5.4.0
    Get-AzVirtualNetwork:       https://docs.microsoft.com/en-us/powershell/module/az.network/get-azvirtualnetwork?view=azps-5.4.0
} #>
<# Required Functions Links: {
    None
} #>
<# Functions Description: {
    GetAzNetworkInterface:      Gets an azure network interface
} #>
<# Variables: {
    :GetAzureNic                Outer loop for managing function
    :SelectAzureNic             Inner loop for selecting the nic
    $VNetList:                  List of all Vnets
    $ListNumber:                $var used to list and select the nic
    $ListArray:                 Array used to hold info for nic identification
    $Vnet:                      The current Vnet name (GetAzureNic)
    $VnetPFX:                   The current Vnet prefix
    $VnetRG:                    The current Vnet resource group
    $SubnetList:                List of all subnets under the current Vnet
    $Subnet:                    The current subnet ID
    $SubnetName:                The current subnet name 
    $SubnetPFX:                 The current subnet prefix
    $NicList:                   List of all nics under the current subnet
    $ListInput:                 $var used to load info into $ListArray
    $CallingFunction:           Name of the function that called this function
    $OperatorSelect:            Operator input to select the nic
    $VnetObject:                Virtual network object
    $SubnetObject:              SubnetObject
    $NicObject:                 Network interface object
} #>
<# Process Flow {
    Function
        Call GetAzNetworkInterface > Get $NicObject
        End GetAzNetworkInterface
            Return function > Send $NicObject
}#>
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