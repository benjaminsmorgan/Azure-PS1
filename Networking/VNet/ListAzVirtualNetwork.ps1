# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Microsoft docs links
    Get-AzVirtualNetwork:       https://docs.microsoft.com/en-us/powershell/module/az.network/get-azvirtualnetwork?view=azps-5.4.0
} #>
<# Required Functions Links: {
    None
} #>
<# Functions Description: {
    ListAzVirtualNetwork:       Lists all virtual networks
} #>
<# Variables: {
    :ListAzureVNetwork          Outer loop for managing function
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
        :ListAzureVNetwork while ($true) {                                                  # Outer loop for managing function
            $VNetList = Get-AzVirtualNetwork                                                # Gets a list of all virtual networks
            if (!$VNetList) {                                                               # If $VNetList is $null
                Write-Host 'No virtual networks in this subscription'                       # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break ListAzureVNetwork                                                     # Breaks ListAzureVNetwork
            }                                                                               # End if (!$VNetList)
            foreach ($_ in $VNetList) {                                                     # For each item in $VNetList
                Write-Host ''                                                               # Write message to screen
                Write-Host 'Name:    '$_.Name                                               # Write message to screen
                Write-Host 'RG:      '$_.ResourceGroupName                                  # Write message to screen
                Write-Host 'Loc:     '$_.Location                                           # Write message to screen
                Write-Host 'A Space: '$_.AddressSpace.AddressPrefixes                       # Write message to screen
            }                                                                               # End foreach ($_ in $VNetList)
            Write-Host ''                                                                   # Write message to screen
            Pause                                                                           # Pauses all actions for operator input
            Break ListAzureVNetwork                                                         # Breaks ListAzureVNetwork
        }                                                                                   # End :ListAzureVNetwork while ($true)
        Clear-Host                                                                          # Clears screen
        return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function ListAzVirtualNetwork