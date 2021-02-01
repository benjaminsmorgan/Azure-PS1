# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Mircosoft docs links
    Get-AzVirtualNetwork:       https://docs.microsoft.com/en-us/powershell/module/az.network/get-azvirtualnetwork?view=azps-5.4.0
} #>
<# Required Functions Links: {
    None
} #>
<# Functions Description: {
    GetAzVirtualNetwork:        Gets an azure virtual network
} #>
<# Variables: {
    :GetAzureVnet               Outer loop for managing function
    $VNetList:                  List of all virtual networks
    $VNetListNumber:            $Var used for $VNetObject list selection
    $VNetListSelect:            Operator input for for $VNetObject selection
    $VNetObject:                Virtual network object
} #>
<# Process Flow {
    Function
        Call GetAzVirtualNetwork > Get $VNetObject
        End GetAzVirtualNetwork
            Return GetAzVirtualNetwork > Send $VNetObject
}#>
function GetAzVirtualNetwork {
    Begin {
        :GetAzureVnet while ($true) { # Outer loop for managing function
            $VNetList = Get-AzVirtualNetwork # pulls all items into list for selection
            $VNetListNumber = 1 # $var used for selecting the virtual network
            foreach ($Name in $VNetList) { # For each name in $VNetList
                Write-Host $VNetListNumber"." $Name.Name $Name.AddressSpace.AddressPrefixes # Writes items from list to screen
                $VNetListNumber = $VNetListNumber + 1 # Increments $var up by 1
            } # End foreach ($Name in $VNetList)
            :GetAzureVNetName while ($true) { # Inner loop for selecting the Vnet
                $VNetListNumber = 1 # Resets $VNetListNumber
                $VNetListSelect = Read-Host "Please enter the number of the virtual network" # Operator input for the VNet selection
                foreach ($Name in $VNetList) { # For each name in $VnetList
                    if ($VNetListSelect -eq $VNetListNumber) { # If $VnetListSelect equals current $VnetListNumber
                        $VNetObject = Get-AzVirtualNetwork -Name $Name.Name # Pulls the selected object and assigns to $var
                        Break GetAzureVnetName # Breaks :GetAzureVnetName
                    } # End if ($VNetListSelect -eq $VNetListNumber)
                    else { # If $VnetListSelect does not equal the current $VnetListNumber
                        $VNetListNumber = $VNetListNumber + 1 # Increments $var up by 1
                    } # End else (if ($VNetListSelect -eq $VNetListNumber))
                } # End foreach ($Name in $VNetList)
                Write-Host "That was not a valid option" # Write message to screen
            } # End :GetAzureVNetName while ($true)
            Return $VNetObject # Returns to calling function with $var
        } # End :GetAzureVnet while ($true)
        Return # Returns to calling function with $null
    } # End Begin
} # End function GetAzVirtualNetwork