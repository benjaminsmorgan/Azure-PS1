# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Microsoft docs links
    Get-AzStorageAccount:       https://docs.microsoft.com/en-us/powershell/module/az.storage/get-azstorageaccount?view=azps-5.2.0
    Get-AzResourceGroup:        https://docs.microsoft.com/en-us/powershell/module/az.resources/get-azresourcegroup?view=azps-5.1.0
} #>
<# Required Functions Links: {
    None
} #>
<# Functions Description: {
    GetAzStorageAccount:        Collects the storage account object
} #>
<# Variables: {
    :ListAzureStorageAcc        Outer loop for managing funciton
    $RGObject:                  List of all resource groups
    $CurrentRG:                 Current item .ResourceGroupName
    $ObjectList:                List of all storage accounts on $CurrentRG
    $ObjectArray:               Array listing all the storage accounts on $RGObject
    $ObjectInput:               $var used to load items into $ObjectArray
} #>
<# Process Flow {
    function
        Call ListAzStorageAccount > Get $null
        End ListAzStorageAccount 
            Return Function > Send $null
}#>
function ListAzStorageAccount {                                                             # Function to list storage accounts
    Begin {                                                                                 # Begin function
        :ListAzureStorageAcc while ($true) {                                                # Outer loop for managing function
            Write-Host 'Getting storage account info'                                       # Write message to screen
            Write-Host 'This may take a moment'                                             # Write message to screen
            [System.Collections.ArrayList]$ObjectArray = @()                                # Creates the object array
            $RGObject = Get-AzResourceGroup                                                 # List of all resource groups
            foreach ($_ in $RGObject) {                                                     # For each item in $RGObject
                $CurrentRG = $_.ResourceGroupName                                           # Isolates the current item .ResourceGroupName
                $ObjectList = Get-AzStorageAccount -ResourceGroupName `
                    $CurrentRG                                                              # Collects all storage accounts in $CurrentRG and assigns to $ObjectList
                foreach ($_ in $ObjectList) {                                               # For each $_ in $ObjectListList
                    $ObjectInput = [PSCustomObject]@{'Name' = $_.StorageAccountName; `
                        'Number' = $ObjectNumber;'Sku'=$_.Sku.Name;`
                        'AccTier'=$_.AccessTier;'Location'=$_.PrimaryLocation;`
                        'RG'=$CurrentRG}                                                    # Creates the item to loaded into array
                    $ObjectArray.Add($ObjectInput) | Out-Null                               # Loads item into array, out-null removes write to screen
                }                                                                           # End foreach ($_ in $ObjectList)
            }                                                                               # End foreach ($_ in $RGObject)
            Write-Host ''                                                                   # Write message to screen
            foreach ($_ in $ObjectArray) {                                                  # For each $_ in $ObjectArray
                Write-Host 'Store Acc Name:'$_.Name                                         # Write message to screen
                Write-Host 'Resource Group:'$_.RG                                           # Write message to screen
                Write-Host 'Primary Loc:   '$_.Location                                     # Write message to screen
                Write-Host 'Sku Name:      '$_.Sku                                          # Write message to screen
                Write-Host 'Access Tier:   '$_.AccTier                                      # Write message to screen
                Write-Host ''                                                               # Write message to screen
            }                                                                               # End foreach ($_ in $ObjectArray)
            Pause                                                                           # Pauses for operator
            Break ListAzureStorageAcc                                                       # Breaks :ListAzureStorageAcc  
        }                                                                                   # End :ListAzureStorageAcc while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End begin 
}                                                                                           # End function GetAzStorageAccount