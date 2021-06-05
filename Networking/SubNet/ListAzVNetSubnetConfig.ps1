# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Mircosoft docs links
    Get-AzVirtualNetworkSubnetConfig: https://docs.microsoft.com/en-us/powershell/module/az.network/get-azvirtualnetworksubnetconfig?view=azps-5.4.0
    Get-AzVirtualNetwork:       https://docs.microsoft.com/en-us/powershell/module/az.network/get-azvirtualnetwork?view=azps-5.4.0
} #>
<# Required Functions Links: {
    None
} #>
<# Functions Description: {
    ListAzVNetSubnetConfig:      Gets an azure virtual network subnet
} #>
<# Variables: {
    :ListAzureSubnet             Outer loop for managing function
    $ObjectList:                List of all virtual networks
    $ObjectArray:               Array of subnet object
    $VNet:                      $Var holding the current Vnet name
    $VnetPFX:                   $Var holding the current Vnet prefix
    $VNetRG:                    $Var holding the current Vnet resource group name
    $SubnetList:                List of subnets in the current vnet
    $ListInput:                 $Var used to load items into $ObjectArray
} #>
<# Process Flow {
    Function
        Call ListAzVNetSubnetConfig > Get $null
        End ListAzVNetSubnetConfig
            Return Function > Send $null
}#>
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
            Write-Host 'Gathering subnets, this may take a moment'                          # Write message to screen
            [System.Collections.ArrayList]$ObjectArray = @()                                # Array that all info is loaded into
            foreach ($_ in $ObjectList) {                                                   # For each object in $ObjectList
                $VNet = $_.Name                                                             # Sets $Vnet as the current object Vnet name
                $VnetPFX = $_.AddressSpace.AddressPrefixes                                  # Sets $VnetPFX as the current object Vnet prefix
                $VNetRG = $_.ResourceGroupName                                              # Sets $VnetRG as the current object Vnet resource group
                $SubnetList = Get-AzVirtualNetworkSubnetConfig -VirtualNetwork $_           # Creates a list of subnets on the current object vnet
                if (!$SubnetList) {                                                         # If $SubnetList is $null
                    Write-Host ''                                                           # Write message to screen
                    Write-Host 'No Subnets present in:'$VNet                                # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                }                                                                           # End if (!$SubnetList)
                foreach ($_ in $SubnetList) {                                               # For each $_ in $SubnetList
                    $ListInput = [PSCustomObject]@{
                        'Name'=$_.Name;'Vnet'=$VNet;'PFX'=$_.AddressPrefix;`
                        'VnetPFX'=$VnetPFX;'RG'=$VNetRG}                                    # Creates the item to loaded into array
                    $ObjectArray.Add($ListInput) | Out-Null                                 # Loads item into array, out-null removes write to screen
                }                                                                           # End foreach ($_ in $SubnetList)                                        
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