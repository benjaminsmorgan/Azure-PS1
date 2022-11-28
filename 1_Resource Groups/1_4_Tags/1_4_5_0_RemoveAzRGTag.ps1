# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Microsoft docs links
    Update-AzTag:               https://docs.microsoft.com/en-us/powershell/module/az.resources/update-aztag?view=azps-5.2.0             
    Get-AzResourceGroup:        https://docs.microsoft.com/en-us/powershell/module/az.resources/get-azresourcegroup?view=azps-5.1.0
} #>
<# Required Functions Links: {
    GetAzResourceGroup:         https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/Resource%20Groups/GetAzResourceGroup.ps1
} #>
<# Functions Description: {
    RemoveAzRGTag:              Remove a tag from a resource group
    GetAzResourceGroup:         Collects resource group object
} #>
<# Variables: { 
    :RemoveAzureRGTag           Outer loop for managing function
    :SelectAzureObjectList      Inner loop for selecting the tag
    $CallingFunction:           Name of this function
    $RGObject:                  Resource group object
    $TagsNames:                 All tag names on $RGObject
    $TagsValues:                All tag values on $RGObject
    $ObjectNumber:              Number used to list and select item from array
    $NameArray:                 Array used to store all tag names
    $ObjectInput:               $var used to load items into $NameArray and $ListArray
    $ValueArray:                Array used to store all tag values
    $Number:                    Current item .Number
    $TagSelect:                 Operator input for the tag selection
    $TagName:                   Selected item tag name
    $TagValue:                  Selected item tag value
    $TagsArray:                 Combines $TagName and $TagValue
    $TagsList:                  List of all tags currently applied to $RGObject
    GetAzResourceGroup{}        Gets $RGObject
} #>
<# Process Flow {
    Function
        Call RemoveAzRGTag > Get $null
            Call GetAzResourceGroup > Get $RGObject
            End GetAzResourceGroup
                Return RemoveAzRGTag > Send $RGObject
        End RemoveAzRGTag
            Return function > Send $null
}#>
function RemoveAzRGTag {                                                                    # Function to remove tags from a resource group
    Begin {                                                                                 # Begin function
        $CallingFunction = 'RemoveAzRGTag'                                                  # Creates calling function
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
                Pause                                                                       # Pauses for user input to continue
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
                Write-Host "[0]  Exit"                                                      # Write message to screen
                foreach ($_ in $NameArray) {                                                # For each $_ in $NameArray
                    $Number = $_.Number                                                     # Sets $Number to current item .number
                    if ($_.Number -le 9) {                                                  # If current item .number is 9 or less
                        if ($_.Value) {                                                     # If $_.value has a value
                            Write-Host "[$Number]  Name:"$_.Name'| Value:'$_.Value          # Write message to screen
                        }                                                                   # End if ($_.Value)
                        else {                                                              # If $_.value is $null
                            Write-Host "[$Number]  Name:"$_.Name'| Value: None'             # Write message to screen
                        }                                                                   # End else (if ($_.Value))
                    }                                                                       # End if ($_.Number -le 9) 
                    else {                                                                  # If current item .number is greater then 9
                        if ($_.Value) {                                                     # If $_.value has a value
                            Write-Host "[$Number]  Name:"$_.Name'| Value:'$_.Value          # Write message to screen
                        }                                                                   # End if ($_.Value)
                        else {                                                              # If $_.value is $null
                            Write-Host "[$Number]  Name:"$_.Name'| Value: None'             # Write message to screen
                        }                                                                   # End else (if ($_.Value))
                    }                                                                       # End else (if ($_.Number -le 9) )
                }                                                                           # End foreach ($_ in $NameArray)
                :SelectAzureObjectList while ($true) {                                      # Inner loop to select the tag
                    $TagSelect = Read-Host "Enter the tag group number"                     # Operator input for the RG selection
                    if ($TagSelect -eq '0') {                                               # If $TagSelect equals 0
                        Break RemoveAzureRGTag                                              # Breaks :RemoveAzureRGTag
                    }                                                                       # End if ($TagSelect -eq '0')
                    elseif ($TagSelect -in $NameArray.Number) {                             # If $TagSelect in $NameArray.Number
                        $TagName = $NameArray | Where-Object {$_.Number -eq $TagSelect}     # Selects the matching tag name from $NameArray                                  
                        $TagName = $TagName.name                                            # Isolates the tag name
                        $TagValue = $NameArray | Where-Object {$_.Number -eq $TagSelect}    # Selects the matching tag value from $NameArray
                        $TagValue = $TagValue.Value                                         # Isolates the tag value
                        $TagsArray =@{$TagName=$TagValue}                                   # Creates the tag array to be removed
                        Break SelectAzureObjectList                                         # Breaks :SelectAzureObjectList
                    }                                                                       # End elseif ($RGSelect -in $ListArray.Number)
                    else {                                                                  # All other entries for $TagSelect 
                        Write-Host "That was not a valid option"                            # Write message to screen
                        Pause                                                               # Pauses for user input to continue
                        Clear-Host                                                          # Clears screen
                    }                                                                       # End else (if ($TagSelect -eq '0') )
                }                                                                           # End :SelectAzureObjectList while ($true)
            }                                                                               # End else (if (!$TagsNames))
            try {                                                                           # Try the following
                $TagsList = Update-AzTag -ResourceID $RGObject.ResourceID -Operation `
                'Delete' -Tag $TagsArray                                                    # Removes the named tag from the resource group 
            }                                                                               # End try
            catch {                                                                         # If try fails
                Write-Host 'An error has occured'                                           # Write message to screen
                Write-Host 'There maybe a policy that'                                      # Write message to screen
                Write-Host 'prevents the removal of this tag'                               # Write message to screen
                Pause                                                                       # Pauses for user input to continue
                Break RemoveAzureRGTag                                                      # Breaks :RemoveAzureRGTag
            }                                                                               # End catch    
            $TagsList = (Get-AzResourceGroup -resourceID $RGObject.ResourceID).TagsTable    # Gets the current tags assigned to $RGObject
            Write-Host 'The following tags are currently set on'$RGObject.ResourceGroupName # Write message to screen
            Write-Host $TagsList                                                            # Write message to screen
            Pause                                                                           # Pauses for user input to continue
            Break RemoveAzureRGTag                                                          # Breaks :RemoveAzureRGTag
        }                                                                                   # End :RemoveAzureRGTag while ($true)
        Clear-Host                                                                          # Clears screen
        Return                                                                              # Returns to the calling function with $null
    }                                                                                       # End begin
}                                                                                           # End function RemoveAzResouceGroupTag