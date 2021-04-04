# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Mircosoft docs links
    Get-AzResourceGroup:        https://docs.microsoft.com/en-us/powershell/module/az.resources/get-azresourcegroup?view=azps-5.1.0
    Get-AzResource:             https://docs.microsoft.com/en-us/powershell/module/az.resources/get-azresource?view=azps-5.1.0
    Get-AzTag:                  https://docs.microsoft.com/en-us/powershell/module/az.resources/get-azTag?view=azps-5.2.0
} #>
<# Required Functions Links: {
    SearchAzResourceTag:        https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/Resources/SearchAzResourceTag.ps1
} #>    
<# Function Description: {
    SearchAzResourceGroupTag:   Searchs for resource group using tag matches on the group, or a contained resource
    SearchAzResourceTag:        Gets a resource object from tag 
} #>
<# Variables: {
    :SearchAzureRGByTag:        Outer loop for managing function
    :SelectTagName:             Inner loop for selecting the tag name
    :SelectTagValue:            Inner loop for selecting the tag value
    :SelectAzureResourceGroup:  Inner loop for selecting the resource if more than 1 match
    $CallingFunction:           Name of this function
    $RSObject:                  The resource object
    $RGObject:                  The resource group object
    $RGList:                    List of all resource groups, used to narrow tag selection
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
    $RSSelect:                  Operator input to select the resource if more than 1 match
    SearchAzResourceTag{}       Gets $RSObject
} #>
<# Process Flow {
    Function
        Call SearchAzResourceGroupLoc > Get $RGObject
            Call SearchAzResourceTag  > Get $RSObject
            End SearchAzResourceTag
                Return SearchAzResourceGroupLoc > Send $RSObject
        End SearchAzResourceGroupLoc
            Return Function > Send $RGObject
}#>
function SearchAzResourceGroupTag {                                                         # Function to find a resource group from container tag 
    Begin {                                                                                 # Begin function
        $ErrorActionPreference='silentlyContinue'                                           # Disables Errors
        :SearchAzureRGByTag while($true) {                                                  # :SearchAzureRGByTag loop finds a resource group off tag values
            $CallingFunction = 'SearchAzResourceGroupTag'                                   # Creates $CallingFunction
            Write-Host "Resource Group Search By Tag"                                       # Write message to screen
            Write-Host "[1] Search by resource tag"                                         # Write message to screen
            Write-Host "[2] Search by group tag"                                            # Write message to screen
            $OperatorSearchOption = Read-Host "Option?"                                     # Operator input for $OperatorSearchOption
            if ($OperatorSearchOption -eq 'exit') {                                         # If $OperatorSearchOption equals 'exit'
                Break SearchAzureRGByTag                                                    # Breaks :SearchAzureRGByTag 
            }                                                                               # End if ($OperatorSearchOption -eq 'exit')
            elseif ($OperatorSearchOption -eq '1') {                                        # Else if $OperatorSearchOption equals '1'
                $RSObject = SearchAzResourceTag ($CallingFunction)                          # Calls function and assigns output to $var
                if (!$RSObject) {                                                           # If $RSObject does not have a value
                    Break SearchAzureRGByTag                                                # Breaks :SearchAzureRGByTag
                }                                                                           # if (!$RSObject)
                else {
                    $RGObject = Get-AzResourceGroup | Where-Object `
                        {$_.ResourceGroupName -eq $RSObject.ResourceGroupName}              # Pulls the resource group object holding $RSObject
                    Return $RGObject                                                        # Returns $RGObject to calling function
                }                                                                           # End (if (!$RSObject))
            }                                                                               # End elseif ($OperatorSearchOption -eq '1')
            elseif ($OperatorSearchOption -eq '2') {                                        # Else if $OperatorSearchOption equals '2'
                $RGList = Get-AzResourceGroup                                               # Creates a list of all resource groups
                $ObjectList = Get-AzTag | Where-Object {$_.Name -in $RGList.Tags.Keys}      # Pulls list of all tags in $RGList and assigns to $var
                $ObjectNumber = 1                                                           # Sets $ObjectNumber to 1
                [System.Collections.ArrayList]$ObjectArray = @()                            # Creates the object array
                foreach ($_ in $ObjectList) {                                               # For each $_ in $ObjectList
                    $ObjectInput = [PSCustomObject]@{'Name' = $_.Name; `
                        'Number' = $ObjectNumber}                                           # Creates the item to loaded into array
                    $ObjectArray.Add($ObjectInput) | Out-Null                               # Loads item into array, out-null removes write to screen
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
                :SelectTagName while ($true) {                                              # Loop for getting $TagNameInput
                    $TagNameInput = Read-Host "Enter the tag [#]"                           # Operator input for the Tag
                    if ($TagNameInput -eq '0') {                                            # If $TagNameInput equals '0'
                        Break SearchAzureRGByTag                                            # Breaks :SearchAzureRGByTag
                    }                                                                       # End if ($TagNameInput -eq '0')
                    elseif ($TagNameInput -in $ObjectArray.Number) {                        # If $TagNameInput in $ObjectArray.Number
                        $TagName = $ObjectArray | Where-Object `
                            {$_.Number -eq $TagNameInput}                                   # Pulls the tag name from $ObjectArray
                            $TagName = $TagName.Name                                        # Isolates .Name in $TagName
                            Break SelectTagName                                             # Breaks :SelectTagName
                    }                                                                       # End elseif ($TagNameInput -in $ObjectArray.Number)
                    else {                                                                  # All other inputs for $TagNameInput
                        Write-Host 'That was not a valid option'                            # Write message to screen
                    }                                                                       # End else (if ($TagNameInput -eq '0'))
                }                                                                           # End :SelectTagName while ($true)
                Write-Host "Include a tag value in search"                                  # Write message to screen
                $OperatorGearchOption = Read-Host '[Y] or [N]'                              # Operator input for searching just by tag name, or adding a tag value
                if ($OperatorGearchOption -eq 'y') {                                        # If statement for adding a tag value
                    $ObjectList = (Get-AzTag -Name $TagName).values | Where-Object `
                        {$_.Name -in $RGList.Tags.Values}                                   # Gets all tag values under the tag name $TagName and in $RGList
                    $ObjectNumber = 1                                                       # Sets $ObjectNumber to 1
                    [System.Collections.ArrayList]$ObjectArray = @()                        # Creates the object array
                    foreach ($_ in $ObjectList) {                                           # For each $_ in $ObjectList
                        $ListInput = [PSCustomObject]@{'Name' = $_.Name; `
                            'Number' = $ObjectNumber}                                       # Creates the item to loaded into array
                        $ObjectArray.Add($ListInput) | Out-Null                             # Loads item into array, out-null removes write to screen
                        $ObjectNumber = $ObjectNumber + 1                                   # Increments $ObjectNumber by 1
                    }                                                                       # End foreach ($_ in $ObjectList)
                    Write-Host "[0]  Exit"                                                  # Write message to screen
                    foreach ($_ in $ObjectArray) {                                          # For each $_ in $ObjectArray
                        $Number = $_.Number                                                 # Sets $Number to current item .number
                        if ($_.Number -le 9) {                                              # If current item .number is 9 or less
                            Write-Host "[$Number] "$_.Name                                  # Write message to screen
                        }                                                                   # End if ($_.Number -le 9) 
                        else {                                                              # If current item .number is greater then 9
                            Write-Host "[$Number]"$_.Name                                   # Write message to screen
                        }                                                                   # End else (if ($_.Number -le 9) )
                    }                                                                       # End foreach ($_ in $ObjectArray)
                    :SelectTagValue while ($true) {                                         # Loop for getting $TagNameValue
                        $TagValueInput = Read-Host "Enter the tag value [#]"                # Operator input for the Tag value
                        if ($TagValueInput -eq '0') {                                       # If $TagValueInput equals '0'
                            Break SearchAzureRGByTag                                        # Breaks :SearchAzureRGByTag
                        }                                                                   # End if ($TagValueInput -eq '0')
                        elseif ($TagValueInput -in $ObjectArray.Number) {                   # If $TagValueInput in $ObjectArray.Number
                            $TagValue = $ObjectArray | Where-Object `
                                {$_.Number -eq $TagValueInput}                              # Pulls the tag value from $ObjectArray
                            $TagValue = $TagValue.Name                                      # Isolates the tag value name
                            Break SelectTagValue                                            # Breaks :SelectTagValue
                        }                                                                   # End elseif ($TagValueInput -in $ObjectArray.Number)
                        else {                                                              # All other inputs for $TagValueInput
                            Write-Host 'That was not a valid option'                        # Write message to screen
                        }                                                                   # End else (if ($TagValueInput -eq '0'))
                    }                                                                       # End :SelectTagValue while ($true)
                }                                                                           # End if ($OperatorGearchOption -eq 'y') 
                if ($TagValue) {                                                            # If statement for $TagValue having a value
                    $RGObject = Get-AzResourceGroup -Tag @{$TagName=$TagValue}              # Collects all resource groups where tag name and value matches $TagName and TagValue
                    if (!$RGObject) {                                                       # $RGObject does not have a value
                        Write-Host `
                            "No resource group found for the Tag Value"$TagValue.Name       # Write message to screen
                        Break SearchAzureRGByTag                                            # Breaks :SearchAzureRGByTag 
                    }                                                                       # End if (!$RGObject)
                }                                                                           # End if ($TagValue)
                else {                                                                      # Else statement for $TagValueInput not having a value
                    $RGObject = Get-AzResourceGroup -Tag @{$TagName=''}                     # Collects all resource groups where tag name matches $TagName
                    if (!$RGObject) {                                                       # $RGObject does not have a value
                        Write-Host "No resource group found for the Tag name"$TagName       # Write message to screen
                        Break SearchAzureRGByTag                                            # Breaks :SearchAzureRGByTag 
                    }                                                                       # End if (!$RGObject)
                }                                                                           # End else if (($TagValue))
                if ($RGObject.count -gt 1) {                                                # If $RGObject has more than 1 value
                    $ObjectNumber = 1                                                       # Sets $ObjectNumber to 1
                    [System.Collections.ArrayList]$ObjectArray = @()                        # Creates the object array
                    foreach ($_ in $RGObject) {                                             # For each $_ in $RGListList
                        $ListInput = [PSCustomObject]@{'Name'=$_.Name; `
                        'RG' = $_.ResourceGroupName;'Number' = $ObjectNumber; `
                        'Location' = $_.Location}                                           # Creates the item to loaded into array
                        $ObjectArray.Add($ListInput) | Out-Null                             # Loads item into array, out-null removes write to screen
                        $ObjectNumber = $ObjectNumber + 1                                   # Increments $ObjectNumber by 1
                    }                                                                       # End foreach ($_ in $RGObject)
                    Write-Host "[0]  Exit"                                                  # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    foreach ($_ in $ObjectArray) {                                          # For each $_ in $ObjectArray
                        $Number = $_.Number                                                 # Sets $Number to current item .Number
                        if ($_.Number -le 9) {                                              # If current item .number is 9 or less
                            Write-Host "[$Number]   "$_.RG                                  # Write message to screen
                        }                                                                   # End if ($_.Number -le 9)
                        else {                                                              # If current item .number is more than 9
                            Write-Host "[$Number]  "$_.RG                                   # Write message to screen
                        }                                                                   # End else (if ($_.Number -le 9))
                        Write-Host 'Loc:  '$_.Location                                      # Write message to screen
                        Write-Host ''                                                       # Write message to screen
                    }                                                                       # End foreach ($_ in $ObjectArray)
                    :SelectAzureResourceGroup while ($true) {                               # Inner loop to select the resource group
                        if ($CallingFunction) {                                             # If $CallingFunction exists
                            Write-Host `
                                "You are selecting the resource group for"$CallingFunction  # Write message to screen
                        }                                                                   # End if ($CallingFunction)
                        $RGSelect = Read-Host "Enter the resource group [#]"                # Operator input for the resource selection
                        if ($RGSelect -eq '0') {                                            # If $RGSelect equals 0
                            Break SearchAzureRGByTag                                          # Breaks :SearchAzureRGByTag
                        }                                                                   # End if ($RGSelect -eq '0')
                        elseif ($RGSelect -in $ObjectArray.Number) {                        # If $RGSelect is in $ObjectArray
                            $RGSelect = $ObjectArray | Where-Object `
                                {$_.Number -eq $RGSelect}                                   # $RGSelect is equal to $ObjectArray where $ObjectArray.Number is equal to $RGSelect                                  
                            $RGObject = Get-AzResourceGroup -name $RGSelect.RG `
                                | Where-Object {$_.Name -eq $RGSelect.Name}                 # Pulls the full resource object
                            Return $RGObject                                                # Returns $RGObject to calling function
                        }                                                                   # End if ($RGSelect -in $ObjectArray)
                        else {                                                              # If $RGObject does not have a value
                            Write-Host "That was not a valid option"                        # Write message to screen
                        }                                                                   # End else (if ($RGSelect -eq '0')))
                    }                                                                       # End :SelectAzureResourceGroup while ($true)
                }                                                                           # End if ($RGObject.count -eq 1) 
                else {                                                                      # If $RGObject has a single value
                    Write-Host 'A single matching resource group is named:'$RGObject.Name   # Write message to screen
                    Return $RGObject                                                        # Returns $RGObject to calling function       
                }                                                                           # End else (if ($RGObject.count -eq 1))
            }                                                                               # End elseif ($OperatorSearchOption -eq '2')
            else {                                                                          # All other inputs for $OperatorSearchOption
                Write-Host 'That was not a valid option'                                    # Write message to screen
            }                                                                               # End else (if ($OperatorSearchOption -eq 'exit'))
        }                                                                                   # End :SearchAzureRGByTag while($true)
        Return                                                                              # Returns to calling function with $null
    }                                                                                       # End begin
}                                                                                           # End function SearchAzResourceGroupTag