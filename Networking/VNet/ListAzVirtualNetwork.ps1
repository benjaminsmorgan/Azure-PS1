# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Mircosoft docs links
    Get-AzVirtualNetwork:       https://docs.microsoft.com/en-us/powershell/module/az.network/get-azvirtualnetwork?view=azps-5.4.0
} #>
<# Required Functions Links: {
    None
} #>
<# Functions Description: {
    ListAzVirtualNetwork:       Lists all virtual networks
} #>
<# Variables: {
    $VNetList:                  List of virtual networks
} #>
<# Process Flow {
    Function
        Call ListAzVirtualNetwork > Get $null 
        End ListAzVirtualNetwork
            Return Function > Send $null
}#>
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