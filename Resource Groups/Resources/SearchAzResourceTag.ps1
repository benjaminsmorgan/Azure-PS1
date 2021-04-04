# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Mircosoft docs links
    Get-AzResource:             https://docs.microsoft.com/en-us/powershell/module/az.resources/get-azresource?view=azps-5.1.0
    Get-AzTag:                  https://docs.microsoft.com/en-us/powershell/module/az.resources/get-azTag?view=azps-5.2.0
} #>
<# Required Functions Links: {
    None
} #>    
<# Function Description: {
    SearchAzResourceTag:        Searchs for resource using tag matches on a resource
} #>
<# Variables: {
    :SearchAzureResource:       Outer loop for managing function
    :SelectTagName:             Inner loop for selecting the tag name
    :SelectTagValue:            Inner loop for selecting the tag value
    :SelectAzureResource:       Inner loop for selecting the resource if more than 1 match
    $RSList:                    List of all resources, used to narrow tag selection
    $ObjectList:                List of objects to be loaded into array
    $ObjectNumber:              $var used to list and select an object in $ObjectArray
    $ObjectArray:               Array of object to select from
    $ObjectInput:               $var used to load objects into $ObjectArray
    $Number:                    Current item .Number, used to format write-host
    $TagNameInput:              Operator input for the tag name
    $TagName:                   The tag name for selecting the resource
    $OperatorSearchOption:      Operator input for adding a tag value to search
    $TagValueInput:             Operator input for the tag value
    $TagValue:                  The tag value for selecting the resource
    $RSObject:                  The resource object
    $CallingFunction:           Name of the function that called this one if present
    $RSSelect:                  Operator input to select the resource if more than 1 match
} #>
<# Process Flow {
    Function
        Call SearchAzResourceTag  > Get $RSObject
        End SearchAzResourceTag
            Return Function > Send $RSObject
}#>
function SearchAzResourceTag {                                                              # Function to find a resource from attached tag
    Begin {
        :SearchAzureResource while ($true) {                                                # Outer loop for managing function
            $RSList = Get-AzResource                                                        # Creates a list of all resource
            $ObjectList = Get-AzTag | Where-Object {$_.Name -in $RSList.Tags.Keys}          # Pulls list of all tags in $RSList and assigns to $var
            $ObjectNumber = 1                                                               # Sets $ObjectNumber to 1
            [System.Collections.ArrayList]$ObjectArray = @()                                # Creates the object array
            foreach ($_ in $ObjectList) {                                                   # For each $_ in $ObjectList
                $ObjectInput = [PSCustomObject]@{'Name' = $_.Name; `
                    'Number' = $ObjectNumber}                                               # Creates the item to loaded into array
                $ObjectArray.Add($ObjectInput) | Out-Null                                   # Loads item into array, out-null removes write to screen
                $ObjectNumber = $ObjectNumber + 1                                           # Increments $ObjectNumber by 1
            }                                                                               # End foreach ($_ in $ObjectList)
            Write-Host "[0]  Exit"                                                          # Write message to screen
            foreach ($_ in $ObjectArray) {                                                  # For each $_ in $ObjectArray
                $Number = $_.Number                                                         # Sets $Number to current item .number
                if ($_.Number -le 9) {                                                      # If current item .number is 9 or less
                    Write-Host "[$Number] "$_.Name                                          # Write message to screen
                }                                                                           # End if ($_.Number -le 9) 
                else {                                                                      # If current item .number is greater then 9
                    Write-Host "[$Number]"$_.Name                                           # Write message to screen
                }                                                                           # End else (if ($_.Number -le 9) )
            }                                                                               # End foreach ($_ in $ObjectArray)
            :SelectTagName while ($true) {                                                  # Loop for getting $TagNameInput
                $TagNameInput = Read-Host "Enter the tag [#]"                               # Operator input for the Tag
                if ($TagNameInput -eq '0') {                                                # If $TagNameInput equals '0'
                    Break SearchAzureResource                                               # Breaks :SearchAzureResource
                }                                                                           # End if ($TagNameInput -eq '0')
                elseif ($TagNameInput -in $ObjectArray.Number) {                            # If $TagNameInput in $ObjectArray.Number
                    $TagName = $ObjectArray | Where-Object `
                        {$_.Number -eq $TagNameInput}                                       # Pulls the tag name from $ObjectArray
                        $TagName = $TagName.Name                                            # Isolates .Name in $TagName
                        Break SelectTagName                                                 # Breaks :SelectTagName
                }                                                                           # End elseif ($TagNameInput -in $ObjectArray.Number)
                else {                                                                      # All other inputs for $TagNameInput
                    Write-Host 'That was not a valid option'                                # Write message to screen
                }                                                                           # End else (if ($TagNameInput -eq '0'))
            }                                                                               # End :SelectTagName while ($true)
            Write-Host "Include a tag value in search"                                      # Write message to screen
            $OperatorSearchOption = Read-Host '[Y] or [N]'                                  # Operator input for searching just by tag name, or adding a tag value
            if ($OperatorSearchOption -eq 'y') {                                            # If statement for adding a tag value
                $ObjectList = (Get-AzTag -Name $TagName).values | Where-Object `
                    {$_.Name -in $RSList.Tags.Values}                                       # Gets all tag values under the tag name $TagName and in $RSList
                $ObjectNumber = 1                                                           # Sets $ObjectNumber to 1
                [System.Collections.ArrayList]$ObjectArray = @()                            # Creates the object array
                foreach ($_ in $ObjectList) {                                               # For each $_ in $ObjectList
                    $ListInput = [PSCustomObject]@{'Name' = $_.Name; `
                        'Number' = $ObjectNumber}                                           # Creates the item to loaded into array
                    $ObjectArray.Add($ListInput) | Out-Null                                 # Loads item into array, out-null removes write to screen
                    $ObjectNumber = $ObjectNumber + 1                                       # Increments $ObjectNumber by 1
                }                                                                           # End foreach ($_ in $ObjectList)
                Write-Host "[0]  Exit"                                                      # Write message to screen
                foreach ($_ in $ObjectArray) {                                              # For each $_ in $ObjectArray
                    $Number = $_.Number                                                     # Sets $Number to current item .number
                    if ($_.Number -le 9) {                                                  # If current item .number is 9 or less
                        Write-Host "[$Number] "$_.Name                                      # Write message to screen
                    }                                                                       # End if ($_.Number -le 9) 
                    else {                                                                  # If current item .number is greater then 9
                        Write-Host "[$Number]"$_.Name                                       # Write message to screen
                    }                                                                       # End else (if ($_.Number -le 9) )
                }                                                                           # End foreach ($_ in $ObjectArray)
                :SelectTagValue while ($true) {                                             # Loop for getting $TagNameValue
                    $TagValueInput = Read-Host "Enter the tag value [#]"                    # Operator input for the Tag value
                    if ($TagValueInput -eq '0') {                                           # If $TagValueInput equals '0'
                        Break SearchAzureResource                                           # Breaks :SearchAzureResource
                    }                                                                       # End if ($TagValueInput -eq '0')
                    elseif ($TagValueInput -in $ObjectArray.Number) {                       # If $TagValueInput in $ObjectArray.Number
                        $TagValue = $ObjectArray | Where-Object `
                            {$_.Number -eq $TagValueInput}                                  # Pulls the tag value from $ObjectArray
                        $TagValue = $TagValue.Name                                          # Isolates the tag value name
                        Break SelectTagValue                                                # Breaks :SelectTagValue
                    }                                                                       # End elseif ($TagValueInput -in $ObjectArray.Number)
                    else {                                                                  # All other inputs for $TagValueInput
                        Write-Host 'That was not a valid option'                            # Write message to screen
                    }                                                                       # End else (if ($TagValueInput -eq '0'))
                }                                                                           # End :SelectTagValue while ($true)
            }                                                                               # End if ($OperatorSearchOption -eq 'y') 
            if ($TagValue) {                                                                # If statement for $TagValue having a value
                $RSObject = Get-AzResource -TagName $TagName -TagValue `
                    $TagValue.Name                                                          # Collects all resource objects where tag name and value matches $TagNameInput and TagValueInput
                if (!$RSObject) {                                                           # $RSObject does not have a value
                    Write-Host "No resources found for the Tag Value"$TagValue.Name         # Write message to screen
                    Break SearchAzureResource                                               # Breaks :SearchAzureResource 
                }                                                                           # End if (!$RSObject)
            }                                                                               # End if ($TagValue)
            else {                                                                          # Else statement for $TagValueInput not having a value
                $RSObject = Get-AzResource -TagName $TagName                                # Collects all resource objects where tag name matches $TagNameInput
                if (!$RSObject) {                                                           # $RSObject does not have a value
                    Write-Host "No resources found for the Tag name"$TagName                # Write message to screen
                    Break SearchAzureResource                                               # Breaks :SearchAzureResource 
                }                                                                           # End if (!$RSObject)
            }                                                                               # End else if (($TagValue))
            if ($RSObject.count -gt 1) {                                                    # If $RSObject has more than 1 value
                $ObjectNumber = 1                                                           # Sets $ObjectNumber to 1
                [System.Collections.ArrayList]$ObjectArray = @()                            # Creates the object array
                foreach ($_ in $RSObject) {                                                 # For each $_ in $RSListList
                    $ListInput = [PSCustomObject]@{'Name'=$_.Name; `
                    'RG' = $_.ResourceGroupName;'Number' = $ObjectNumber; `
                    'Location' = $_.Location}                                               # Creates the item to loaded into array
                    $ObjectArray.Add($ListInput) | Out-Null                                 # Loads item into array, out-null removes write to screen
                    $ObjectNumber = $ObjectNumber + 1                                       # Increments $ObjectNumber by 1
                }                                                                           # End foreach ($_ in $RSObject)
                Write-Host "[0]  Exit"                                                      # Write message to screen
                Write-Host ''                                                               # Write message to screen
                foreach ($_ in $ObjectArray) {                                              # For each $_ in $ObjectArray
                    $Number = $_.Number                                                     # Sets $Number to current item .Number
                    if ($_.Number -le 9) {                                                  # If current item .number is 9 or less
                        Write-Host "[$Number] "$_.Name                                      # Write message to screen
                    }                                                                       # End if ($_.Number -le 9)
                    else {                                                                  # If current item .number is more than 9
                        Write-Host "[$Number]"$_.Name                                       # Write message to screen
                    }                                                                       # End else (if ($_.Number -le 9))
                    Write-Host 'RG: '$_.RG                                                  # Write message to screen
                    Write-Host 'Loc:'$_.Location                                            # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                }                                                                           # End foreach ($_ in $ObjectArray)
                :SelectAzureResource while ($true) {                                        # Inner loop to select the resource 
                    if ($CallingFunction) {                                                 # If $CallingFunction exists
                        Write-Host `
                            "You are selecting the resource for"$CallingFunction            # Write message to screen
                    }                                                                       # End if ($CallingFunction)
                    $RSSelect = Read-Host "Enter the resource [#]"                          # Operator input for the resource selection
                    if ($RSSelect -eq '0') {                                                # If $RSSelect equals 0
                        Break GetAzureResource                                              # Breaks :GetAzureResource
                    }                                                                       # End if ($RSSelect -eq '0')
                    elseif ($RSSelect -in $ObjectArray.Number) {                            # If $RSSelect is in $ObjectArray
                        $RSSelect = $ObjectArray | Where-Object `
                            {$_.Number -eq $RSSelect}                                       # $RSSelect is equal to $ObjectArray where $ObjectArray.Number is equal to $RSSelect                                  
                        $RSObject = Get-AzResource -ResourceGroup $RSSelect.RG `
                            | Where-Object {$_.Name -eq $RSSelect.Name}                     # Pulls the full resource object
                        Return $RSObject                                                    # Returns $RSObject to calling function
                    }                                                                       # End if ($RSSelect -in $ObjectArray)
                    else {                                                                  # If $RGObject does not have a value
                        Write-Host "That was not a valid option"                            # Write message to screen
                    }                                                                       # End else (if ($RSSelect -eq '0')))
                }                                                                           # End :SelectAzureResource while ($true)
            }                                                                               # End if ($RSObject.count -eq 1) 
            else {                                                                          # If $RSObject has a single value
                Write-Host 'A single matching resource is named:'$RSObject.Name             # Write message to screen
                Return $RSObject                                                            # Returns $RGObject to calling function       
            }                                                                               # End else (if ($RSObject.count -eq 1))
        }                                                                                   # End :SearchAzureResource while ($true)
        return                                                                              # Returns to calling function with $null    
    }                                                                                       # End Begin
}                                                                                           # End function SearchAzResourceTag