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
        :GetAzureVnet while ($true) {                                                       # Outer loop for managing function
            $VNetList = Get-AzVirtualNetwork                                                # pulls all items into list for selection
            $VNetListNumber = 1                                                             # $var used for selecting the virtual network
            [System.Collections.ArrayList]$VNetArray = @()                                  # Creates the RG list array
            foreach ($_ in $VNetList) {                                                     # For each $_ in $RGListList
                $ArrayInput = [PSCustomObject]@{'Number' = $VNetListNumber; `
                'Name' = $_.Name; 'RG' = $_.ResourceGroupName; 'Location' = $_.Location; `
                'ASpace' = $_.AddressSpace.AddressPrefixes}                                 # Creates the item to loaded into array
                $VNetArray.Add($ArrayInput) | Out-Null                                      # Loads item into array, out-null removes write to screen
                $VNetListNumber = $VNetListNumber + 1                                       # Increments $RGListNumber by 1
            }                                                                               # End foreach ($_ in $RGList)
            Write-Host "0 Exit"                                                             # Write message to screen
            foreach ($_ in $VNetArray) {                                                    # For each name in $VNetList
                Write-Host '['$_.Number']'                                                  # Write message to screen
                Write-Host 'Name:    '$_.Name                                               # Write message to screen
                Write-Host 'RG:      '$_.RG                                                 # Write message to screen
                Write-Host 'Loc:     '$_.Location                                           # Write message to screen
                Write-Host 'A Space: '$_.ASpace                                             # Write message to screen
                Write-Host ''                                                               # Write message to screen
            }                                                                               # End foreach ($Name in $Array)
            :GetAzureVNetName while ($true) { # Inner loop for selecting the Vnet
                $VNetListSelect = Read-Host "Please enter the number of the virtual network" # Operator input for the VNet selection
                if ($VNetListSelect -eq '0') {
                    Break GetAzureVNet
                }
                elseif ($VNetListSelect -in $VNetArray.Number) {
                    $VNetListSelect = $VNetArray | Where-Object {$_.Number -eq `
                        $VNetListSelect}
                    $VNetObject = Get-AzVirtualNetwork -Name $VNetListSelect.Name `
                        -ResourceGroupName $VNetListSelect.RG
                        Return $VNetObject # Returns to calling function with $var
                }
                else {
                    Write-Host 'That was not a valid option'
                }
            } # End :GetAzureVNetName while ($true)
        } # End :GetAzureVnet while ($true)
        Return # Returns to calling function with $null
    } # End Begin
} # End function GetAzVirtualNetwork