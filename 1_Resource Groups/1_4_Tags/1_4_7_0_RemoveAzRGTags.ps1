# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Microsoft docs links
    Update-AzTag:               https://docs.microsoft.com/en-us/powershell/module/az.resources/update-aztag?view=azps-5.2.0             
    Get-AzResourceGroup:        https://docs.microsoft.com/en-us/powershell/module/az.resources/get-azresourcegroup?view=azps-5.1.0
} #>
<# Required Functions Links: {
    GetAzResourceGroup:         https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/Resource%20Groups/GetAzResourceGroup.ps1
} #>
<# Functions Description: {
    RemoveAzRGTags:             Removes all tags from a resource group
    GetAzResourceGroup:         Collects resource group object
} #>
<# Variables: { 
    :RemoveAzureRGTag           Outer loop for managing function
    $CallingFunction:           Name of this function
    $RGObject:                  Resource group object 
    $TagsNames:                 All tag names on $RGObject
    $TagsValues:                All tag values on $RGObject
    $ObjectNumber:              Number used to list and select item from array
    $NameArray:                 Array used to store all tag names
    $ObjectInput:               $var used to load items into $NameArray and $ListArray
    $ValueArray:                Array used to store all tag values
    $Number:                    Current item .Number
    $TagsArray:                 Combines current item .name and .value
    $TagsList:                  List of all tags currently applied to $RGObject
    GetAzResourceGroup{}        Gets $RGObject
} #>
<# Process Flow {
    Function
        Call RemoveAzRGTags > Get $null
            Call GetAzResourceGroup > Get $RGObject
            End GetAzResourceGroup
                Return RemoveAzRGTags > Send $RGObject
        End RemoveAzRGTags
            Return function > Send $null
}#>
function RemoveAzRGTags {                                                                   # Function to remove all tags on a resource group
    Begin {                                                                                 # Begin function
        $CallingFunction = 'RemoveAzRGTags'                                                 # Creates $CallingFunction
        :RemoveAzureRGTag while ($true) {                                                   # Outer loop for managing function
            $RGObject = GetAzResourceGroup ($CallingFunction)                               # Calls function and assigns output to $var
            if (!$RGObject) {                                                               # If $RGObject does not have a value
                Break RemoveAzureRGTag                                                      # Breaks :RemoveAzureRGTag
            }                                                                               # End if (!$RGObject)
            $TagsNames = `
                (Get-AzTag -ResourceId $RGObject.ResourceId).Properties.TagsProperty.Keys   # Gets all tag names on $RGObject
            $TagsValues = `
                (Get-AzTag -ResourceId $RGObject.ResourceId).Properties.TagsProperty.Values # Gets all tag values on $RGObject
            if (!$TagsNames) {                                                              # If $TagsNames does not have a value
                Write-Host 'The resource group does not have any tags'                      # Write message to screen
                Pause                                                                       # Pauses for operator input to continue
                Break RemoveAzureRGTag                                                      # Breaks :RemoveAzureRGTag
            }                                                                               # End if (!$TagsNames)
            else {                                                                          # If $TagsNames does have a value
                $ObjectNumber = 1                                                           # Sets $ObjectNumber to 1
                [System.Collections.ArrayList]$ValueArray = @()                             # Creates the values list array
                foreach ($_ in $TagsValues) {                                               # For each $_ in $TagValues
                    $ObjectInput = [PSCustomObject]@{'Value' = $_; `
                        'Number' = $ObjectNumber}                                           # Creates the item to loaded into array
                    $ValueArray.Add($ObjectInput) | Out-Null                                # Loads item into array, out-null removes write to screen
                    $ObjectNumber = $ObjectNumber + 1                                       # Increments $ObjectNumber by 1
                }                                                                           # End foreach ($_ in $TagValues)
                $ObjectNumber = 1                                                           # Sets $ObjectNumber to 1
                [System.Collections.ArrayList]$NameArray = @()                              # Creates the name list array
                foreach ($_ in $TagsNames) {                                                # For each $_ in $TagsNames
                    $TagValue = $ValueArray | Where-Object {$_.Number -eq $ObjectNumber}    # Selects the matching tag value from $ValueArray
                    $TagValue = $TagValue.Value                                             # Isolates the tag value
                    $ObjectInput = [PSCustomObject]@{'Name' = $_; `
                        'Number' = $ObjectNumber;'Value'=$TagValue}                         # Creates the item to loaded into array
                    $NameArray.Add($ObjectInput) | Out-Null                                 # Loads item into array, out-null removes write to screen
                    $ObjectNumber = $ObjectNumber + 1                                       # Increments $ObjectNumber by 1
                }                                                                           # End foreach ($_ in $TagNames)
            }                                                                               # End else (if (!$TagsNames))
            Write-Host 'Removing tags'                                                      # Write message to screen
            foreach ($_ in $NameArray) {                                                    # For each item in $TagsNames
                $TagsArray = @{$_.Name=$_.Value}                                            # Creates $TagArray
                try {                                                                       # Try the following
                    $TagsList = Update-AzTag -ResourceID $RGObject.ResourceID -Operation `
                    'Delete' -Tag $TagsArray -ErrorAction 'Stop'                            # Removes the named tag from the resource group 
                }                                                                           # End try
                catch {                                                                     # If try fails
                    Write-Host 'An error has occured'                                       # Write message to screen
                    Write-Host 'There maybe a policy that'                                  # Write message to screen
                    Write-Host 'prevents the removal of the tags'                           # Write message to screen
                    $TagsList = `
                        (Get-AzResourceGroup -resourceID $RGObject.ResourceID).TagsTable    # Gets the current tags assigned to $RGObject
                    Write-Host ''                                                           # Write message to screen
                    Write-Host 'The following tags are currently set on'$RGObject.Name      # Write message to screen
                    Write-Host $TagsList                                                    # Write message to screen
                    Pause                                                                   # Pauses for operator input to continue
                    Break RemoveAzureRGTag                                                  # Breaks :RemoveAzureRGTag
                }                                                                           # End catch   
            } 
            Write-Host 'All tags removed from'$RGObject.Name                                # Write message to screen
            Pause                                                                           # Pauses for operator input to continue
            Break RemoveAzureRGTag                                                          # Breaks :RemoveAzureRGTag
        }                                                                                   # End :RemoveAzureRGTags while ($true)
        Clear-Host                                                                          # Clears screen
        Return                                                                              # Returns to the calling function with $null
    }                                                                                       # End begin
}                                                                                           # End function RemoveAzRGTags