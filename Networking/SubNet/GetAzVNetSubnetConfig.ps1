# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Mircosoft docs links
    Get-AzVirtualNetworkSubnetConfig: https://docs.microsoft.com/en-us/powershell/module/az.network/get-azvirtualnetworksubnetconfig?view=azps-5.4.0
    Get-AzVirtualNetwork:       https://docs.microsoft.com/en-us/powershell/module/az.network/get-azvirtualnetwork?view=azps-5.4.0
} #>
<# Required Functions Links: {
    None
} #>
<# Functions Description: {
    GetAzVNetSubnetConfig:      Gets an azure virtual network subnet
} #>
<# Variables: {
    :GetAzureSubnet             Outer loop for managing function
    :SelectAzureSubNet          Inner loop for selecting the subnet
    $ObjectList:                List of all virtual networks
    $ObjectNumber:              $var used to number an item in $ObjectArray
    $ObjectArray:               Array of subnet object
    $VNet:                      $Var holding the current Vnet name
    $VnetPFX:                   $Var holding the current Vnet prefix
    $VNetRG:                    $Var holding the current Vnet resource group name
    $SubnetList:                List of subnets in the current vnet
    $ListInput:                 $Var used to load items into $ObjectArray
    $Number:                    The current item .number, used for formating
    $OpSelect:                  Operator input to select the subnet
    $VNetObject:                The Vnet holding the selected subnet
    $SubnetObject:              The subnet object
} #>
<# Process Flow {
    Function
        Call GetAzVNetSubnetConfig > Get $SubnetObject
        End GetAzVNetSubnetConfig
            Return Function > Send $SubnetObject
}#>
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
                    Write-Host 'Vnet Prefix:'$_.VnetPFX                                     # Write message to screen
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