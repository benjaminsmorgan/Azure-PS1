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
    $VNetList:                  List of all virtual networks
    $ListNumber:                $var used to number an item in $ListArray
    $ListArray:                 Array of subnet object
    $VNet:                      $Var holding the current Vnet name
    $VnetPFX:                   $Var holding the current Vnet prefix
    $VNetRG:                    $Var holding the current Vnet resource group name
    $SubnetList:                List of subnets in the current vnet
    $ListInput:                 $Var used to load items into $ListArray
    $Number:                    The current item .number, used for formating
    $SubnetSelect:              Operator input to select the subnet
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
            Write-Host '[0] Exit'                                                           # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            foreach ($_ in $ListArray) {                                                    # For each item in $ListArray
                $Number = $_.Number                                                         # Creates $number from $_.Number
                Write-Host "[$Number]"   $_.name                                            # Write message to screen
                Write-Host 'Sub Prefix: '$_.PFX                                             # Write message to screen
                Write-Host 'VNet Name:  '$_.Vnet                                            # Write message to screen
                Write-Host 'Vnet Prefix:'$_.VnetPFX                                         # Write message to screen
                Write-Host ''                                                               # Write message to screen
            }                                                                               # End foreach ($_ in $ListArray)
            :SelectAzureSubNet while ($true) {                                              # Inner loop for selecting the subnet
                if ($CallingFunction) {                                                     # If $Calling function exists
                    Write-Host 'You are selecting the subnet for'$CallingFunction           # Write message to screen
                }                                                                           # End if ($CallingFunction)
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