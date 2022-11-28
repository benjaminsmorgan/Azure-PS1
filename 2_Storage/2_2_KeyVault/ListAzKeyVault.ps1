# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Microsoft docs links
    Get-AzKeyVault:             https://docs.microsoft.com/en-us/powershell/module/az.keyvault/get-azkeyvault?view=azps-5.3.0
} #>
<# Required Functions Links: {
    None
} #>
<# Functions Description: {
    ListAzKeyVault:             Lists all key vaults in subscription
} #>
<# Variables: {      
    :ListAzureKeyVault          Outer loop for managing function
    $ObjectList:                List of all key vaults
    $ObjectArray:               Array containing the key vault items
    $ObjectInput:               $Var used to load items into $ObjectArray
} #>
<# Process Flow {
    function
        Call ListAzKeyVault > Get $null
        End ListAzKeyVault     
            Return Function > Send $null
}#>
function ListAzKeyVault {                                                                   # Function to list a key vault objects
    Begin {                                                                                 # Begin function
        :ListAzureKeyVault while ($true) {                                                  # Outer loop for managing function
            $ObjectList = Get-AzKeyVault                                                    # Gets all key vaults and assigns to $ObjectList
            [System.Collections.ArrayList]$ObjectArray = @()                                # Creates the object list array
            foreach ($_ in $ObjectList) {                                                   # For each $_ in $ObjectListList
                $ObjectInput = [PSCustomObject]@{'Name'=$_.VaultName; `
                'RG'=$_.ResourceGroupName;'Loc' = $_.Location}                              # Creates the item to loaded into array
                $ObjectArray.Add($ObjectInput) | Out-Null                                   # Loads item into array, out-null removes write to screen
                $ObjectNumber = $ObjectNumber + 1                                           # Increments $ObjectNumber by 1
            }                                                                               # End foreach ($_ in $ObjectList)
            foreach ($_ in $ObjectArray) {                                                  # For each $_ in $ObjectArray
                Write-Host 'Vault name:'$_.Name                                             # Write message to screen
                Write-Host 'RG Name:   '$_.RG                                               # Write message to screen
                Write-Host 'Location:  '$_.Loc                                              # Write message to screen
                Write-Host ''                                                               # Write message to screen
            }                                                                               # End foreach ($_ in $ObjectArray)
            Pause                                                                           # Pauses all actions for operator input
            Break ListAzureKeyVault                                                         # Breaks :ListAzureKeyVault
        }                                                                                   # End :ListAzureKeyVault while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function ListAzKeyVault