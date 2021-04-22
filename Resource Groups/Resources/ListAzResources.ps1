# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Mircosoft docs links
    Get-AzResourceGroup:        https://docs.microsoft.com/en-us/powershell/module/az.resources/get-azresourcegroup?view=azps-5.1.0
    Get-AzResource:             https://docs.microsoft.com/en-us/powershell/module/az.resources/get-azresource?view=azps-5.1.0
} #>
<# Required Functions Links: {
    None
} #>    
<# Function Description: {
    ListAzResources:            Lists all resources by resource group
} #>
<# Variables: {
    :ListAzureResources         Outer loop for managing function
    $RGObject:                  Current item
    $RGName:                    $RGObject.ResourceGroupName
    $ListArray:                 Array all objects are loaded into for write to screen
    $ListObject:                List of all resources with $RGObject
    $ListInput:                 $var used to load objects into $ListArray
} #>
<# Process Flow {
    Function
        Call ListAzResources > Get $null
        End ListAzResources
            Return Function > Send $null
}#>
function ListAzResources {                                                                  # Function to list all resources within a resource group
    Begin {                                                                                 # Begin function
        :ListAzureResources while ($true) {                                                 # Outer loop for managing function
            [System.Collections.ArrayList]$ListArray = @()                                  # Creates the list array
            $RGList = Get-AzResourceGroup                                                   # Gets a list of all resource groups
            foreach ($_ in $RGList) {                                                       # For each item in $RGList
                $RGObject = $_                                                              # Isolates the current item
                $RGName = $RGObject.ResourceGroupName                                       # Isolates the resource group name
                $ListObject = Get-AzResource | Where-Object `
                    {$_.ResourceGroupName -eq $RGName}                                      # Creates a list of all resources within $RGObject
                foreach ($_ in $ListObject) {                                               # For each $_ in $ListObject
                    $ListInput = [PSCustomObject]@{'Name'=$_.Name;'RG' = $RGName;`
                        'Location'=$_.Location;'Type'=$_.ResourceType}                      # Creates the item to loaded into array
                    $ListArray.Add($ListInput) | Out-Null                                   # Loads item into array, out-null removes write to screen
                }                                                                           # End foreach ($_ in $ListObject)    
            }                                                                               # End foreach ($_ in $RGList)
            foreach ($_ in $ListArray) {                                                    # For each item in $ListArray
                Write-Host 'Name:'$_.Name                                                   # Write message to screen
                Write-Host 'RG:  '$_.RG                                                     # Write message to screen
                Write-Host 'Loc: '$_.Location                                               # Write message to screen
                Write-Host 'Type:'$_.Type                                                   # Write message to screen
                Write-Host ''                                                               # Write message to screen
            }                                                                               # End foreach ($_ in $ListArray)
            Pause                                                                           # Pauses for operator input
            Break ListAzureResources                                                        # Breaks :ListAzureResources
        }                                                                                   # End :ListAzureResources while ($true)
        Clear-Host                                                                          # Clears screen
        return                                                                              # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function ListAzResources