# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Mircosoft docs links
    Get-AzResourceGroup:        https://docs.microsoft.com/en-us/powershell/module/az.resources/get-azresourcegroup?view=azps-5.1.0
} #>
<# Required Functions Links: {
    None
} #>
<# Functions Description: {
    ListAzResourceGroup:         Lists all resource group objects
} #>
<# Variables: {
    :ListAzureResourceGroup     Outer loop for managing function
    $ObjectList:                List of all resource groups
    $ObjectArray:               Array containing the list number, name, and location of each resource group
    $ObjectInput:               $var used to load items into $RGListArray
} #>
<# Process Flow {
    Function
        Call ListAzResourceGroup > Get $null
        End ListAzResourceGroup
            Return Function > Send $null
}#>
function ListAzResourceGroup {                                                              # Function to list all resource groups
    Begin {                                                                                 # Begin function
        $ErrorActionPreference = 'silentlyContinue'                                         # Disables error reporting
        :ListAzureResourceGroup while ($true) {                                             # Outer loop for managing function
            $ObjectList = Get-AzResourceGroup                                               # Gets all resource groups and assigns to $ObjectList
            if (!$ObjectList) {                                                             # If $ObjectList is $null
                Write-Host 'No resource groups in this subscription'                        # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break ListAzureResourceGroup                                                # Breaks :ListAzureResourceGroup    
            }                                                                               # End if (!$ObjectList)
            [System.Collections.ArrayList]$ObjectArray = @()                                # Creates $ObjectListArray
            foreach ($_ in $ObjectList) {                                                   # For each $_ in $ObjectListList
                $ObjectInput = [PSCustomObject]@{                                           # PSCustom object to load items into array
                    'Name'=$_.ResourceGroupName;'Location'=$_.Location;'Tags'=$_.Tags}      # Creates the item to loaded into array
                $ObjectArray.Add($ObjectInput) | Out-Null                                   # Loads item into array, out-null removes write to screen
            }                                                                               # End foreach ($_ in $ObjectList)
            foreach ($_ in $ObjectArray) {                                                  # For each $_ in $ObjectArray
                Write-Host 'Name:      '$_.Name                                             # Write message to screen
                Write-Host 'Location   '$_.Location                                         # Write message to screen
                Write-Host 'Tag Names: '$_.Tags.Keys                                        # Write message to screen
                Write-Host 'Tag Values:'$_.Tags.Values                                      # Write message to screen
                Write-Host ''                                                               # Write message to screen
            }                                                                               # End foreach ($_ in $ObjectArray)
            Pause                                                                           # Pauses all actions for operator input
            Break ListAzureResourceGroup                                                    # Breaks :ListAzureResourceGroup
        }                                                                                   # End :ListAzureResourceGroup while ($true)
        Clear-Host                                                                          # Clears screen
        Return                                                                              # Returns to calling function with $null
    }                                                                                       # End begin statement
}                                                                                           # End function ListAzResourceGroup