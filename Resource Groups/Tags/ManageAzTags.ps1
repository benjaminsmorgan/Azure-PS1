# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Mircosoft docs links
    Get-AzTag:                  https://docs.microsoft.com/en-us/powershell/module/az.resources/get-aztag?view=azps-5.2.0
    Update-AzTag:               https://docs.microsoft.com/en-us/powershell/module/az.resources/update-aztag?view=azps-5.2.0             
    Remove-AzTag:               https://docs.microsoft.com/en-us/powershell/module/az.resources/remove-aztag?view=azps-5.2.0
    Get-AzResourceGroup:        https://docs.microsoft.com/en-us/powershell/module/az.resources/get-azresourcegroup?view=azps-5.1.0
    Get-AzResource:             https://docs.microsoft.com/en-us/powershell/module/az.resources/get-azresource?view=azps-5.1.0
} #>
<# Required Functions Links: {
    SetAzTagPair:               https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/Tags/SetAzTagPair.ps1
    AddAzResourceGroupTag:      https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/Tags/AddAzResourceGroupTag.ps1
    AddAzResourceTag:           https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/Tags/AddAzResourceTag.ps1
    GetAzResourceGroupTags:     https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/Tags/GetAzResourceGroupTags.ps1
    GetAzResourceTags:          https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/Tags/GetAzResourceTags.ps1
    RemoveAzResourceGroupTag:   https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/Tags/RemoveAzResourceGroupTag.ps1
    RemoveAzResourceTag:        https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/Tags/RemoveAzResourceTag.ps1
    RemoveAzResourceGroupTags:  https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/Tags/RemoveAzResourceGroupTags.ps1
    RemoveAzResourceTags:       https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/Tags/RemoveAzResourceTags.ps1
    GetAzResourceGroup:         https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/GetAzResourceGroup.ps1
    GetAzResource:              https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/GetAzResource.ps1
} #>
<# Functions Description: {
    ManageAzTags:  Management function for tags functions
    SetAzTagPair:               Create a tag for multiple uses
    AddAzResourceGroupTag:      Create a new resource tag on a resource group
    AddAzResourceTag:           Create a new resource tag on a resource
    GetAzResourceGroupTags:     Get all tags on a resource group
    GetAzResourceTags:          Get all tags on a resource
    RemoveAzResourceGroupTag:   Remove a named tag from a resource group
    RemoveAzResourceTag:        Remove a named tag from a resource
    RemoveAzResourceGroupTags:  Remove all tags from a resource group
    RemoveAzResourceTags:       Remove all tags from a resource
    GetAzResourceGroup:         Collects resource group object
    GetAzResource:              Collects resources within a resource group
} #>
<# ManageAzTags { 
    :ManageAzureTag             Outer loop for function
    $OpSelect:      Operator input for the management function
    $TagNameInput:              Operator input for the tag name
    $TagValueInput:             Operator input for the tag value
    $TagsList:                  Write-Host writable tag name and value list
    $RGObject:                  Resource group object
    $RSObject:                  Resource object
    SetAzTagPair { 
        :SetAzureTagPair            Outer loop for function
        :SetAzureTagName            Inner loop for setting the tag name
        :SetAzureTagValue           Inner loop for setting the tag value
        $TagNameInput:              Operator input for the tag name
        $TagValueInput:             Operator input for the tag value 
        $OperatorConfirm:           Operator confirmation on tag name and value 
    }  End SetAzTagPair    
    AddAzResourceGroupTag {
        :AddAzureRGTag              Outer loop for function
        :SetAzureTagArray           Inner loop for setting the tag name and value 
        $RGObject:                  Resource group object
        $TagNameInput:              Operator input for the tag name
        $TagValueInput:             Operator input for the tag value
        $TagsArray:                 Hashable value of $TagNameInput and $TagValueInput
        $TagsList:                  Write-Host writable tag name and value list
    } End AddAzResourceGroupTag 
    AddAzResourceTag {
        :AddAzureRSTag              Outer loop for function
        :SetAzureTagArray           Inner loop for setting the tag name and value
        $RGObject:                  Resource group object
        $RSObject:                  Resource object
        $TagNameInput:              Operator input for the tag name
        $TagValueInput:             Operator input for the tag value
        $TagsArray:                 Hashable value of $TagNameInput and $TagValueInput
        $TagsList:                  Write-Host writable tag name and value list
    } End AddAzResourceTag
    GetAzResourceGroupTags { 
        :GetAzureRGTag              Outer loop for function
        $RGObject:                  Resource group object
        $TagsList:                  Write-Host writable tag name and value list
    } End GetAzResourceGroupTags
    GetAzResourceTags {
        :GetAzureRSTag              Outer loop for function
        $RGObject:                  Resource group object
        $RSObject:                  Resource object
        $TagsList:                  Write-Host writable tag name and value list
    } End GetAzResourceTags    
    RemoveAzResourceGroupTag { 
        :RemoveAzureRGTag           Outer loop for function
        :SetAzureTagArray           Inner loop for setting the tag name and value 
        $RGObject:                  Resource group object
        $ValidTagName:              List of all tag names on resource group
        $TagNameInput:              Operator input for the tag name
        $TagsArray:                 Hashable value of $TagNameInput and $TagValueInput
        $TagsList:                  Write-Host writable tag name and value list
    } End RemoveAzResouceGroupTag 
    RemoveAzResourceTag { 
        :RemoveAzureRSTag           Outer loop for function
        :SetAzureTagArray           Inner loop for setting the tag name and value
        $RGObject:                  Resource group object
        $RSObject:                  Resource object
        $ValidTagName:              List of all tag names on resource
        $TagNameInput:              Operator input for the tag name
        $TagsArray:                 Hashable value of $TagNameInput and $TagValueInput
        $TagsList:                  Write-Host writable tag name and value list
    } End RemoveAzResouceTag    
    RemoveAzResourceGroupTags {
        :RemoveAzureRGTags          Outer loop for function
        $RGObject:                  Resource group object
        $TagsList:                  Write-Host writable tag name and value list
    } End RemoveAzResourceGroupTags 
    RemoveAzResourceTags {
        :RemoveAzureRSTags          Outer loop for function
        $RGObject:                  Resource group object
        $RSObject:                  Resource object
        $TagsList:                  Write-Host writable tag name and value list
    } End RemoveAzResourceTags
    GetAzResourceGroup { 
        :GetAzureResourceGroup      Outer loop for function
        $RGObject:                  Resource group object 
        $RGObjectInput:             Resource group object input
        $RGList:                    List of all availiable resource groups
    } End GetAzResourceGroup 
    GetAzResource { 
        $RSObject:                  Resource object
        $RGObject:                  Resource group object
        $RSObjectInput:             Resource object input
        $RSList:                    List of all availiable resources
    } End GetAzResource 
} End ManageAzTags 
#>
<# Process Flow {
    Function
        Call ManageAzTags > Send $RGObject, $RSObject
            Call SetAzTagPair > Get $TagNameInput, $TagValueInput
                Return ManageAzTags > Send $TagNameInput, $TagValueInput
            Call AddAzResourceGroupTag > Get $TagList
                Call GetAzResourceGroup > Get $RGObject
                    Return AddAzResourceGroupTag > Send $RGObject
                End function
                Return ManageAzTags > Send $TagList
            Call AddAzResourceTag > Get $TagList
                Call GetAzResourceGroup > Get $RGObject
                    Return AddAzResourceTag > Send $RGObject
                Call GetAzResource > Get $RSObject
                    Return AddAzResourceTag > Send $RSObject
                End function
                Return ManageAzTags > Send $TagList
            Call GetAzResourceGroupTags > Get $TagList
                Call GetAzResourceGroup > Get $RGObject
                    Return GetAzResourceGroupTags > Send $RGObject
                End function
                Return ManageAzTags > Send $TagList
            Call GetAzResourceTags > Get $TagList
                Call GetAzResourceGroup > Get $RGObject
                    Return GetAzResourceTags > Send $RGObject
                Call GetAzResource > Get $RSObject
                    Return GetAzResourceTags > Send $RSObject
                End function
                Return ManageAzTags > Send $TagList
            Call RemoveAzResourceGroupTag > Get $TagList
                Call GetAzResourceGroup > Get $RGObject
                    Return RemoveAzResourceGroupTag > Send $RGObject
                End function
                Return ManageAzTags > Send $TagList
            Call RemoveAzResourceTag  > Get $TagList
                Call GetAzResourceGroup > Get $RGObject
                    Return RemoveAzResourceTag > Send $RGObject
                Call GetAzResource > Get $RSObject
                    Return RemoveAzResourceTag > Send $RSObject
                End function
                Return ManageAzTags > Send $TagList
            Call RemoveAzResourceGroupTags > Get $TagList
                Call GetAzResourceGroup > Get $RGObject
                    Return RemoveAzResourceGroupTags > Send $RGObject
                End function
                Return ManageAzTags > Send $TagList
            Call RemoveAzResourceTags > Get $TagList
                Call GetAzResourceGroup > Get $RGObject
                    Return RemoveAzResourceTags > Send $RGObject
                Call GetAzResource > Get $RSObject
                    Return RemoveAzResourceTags > Send $RSObject
                End function
                Return ManageAzTags > Send $TagList
            End ManageAzTags
                Return Function > Send $null
}#>
function ManageAzTags {                                                                     # Management function for tags
    Begin {                                                                                 # Begin function
        :ManageAzureTag while($true) {                                                      # Outer loop for managing function
            if ($TagNameInput -or $RGObject -or $RSObject) {                                # If $TagNameInput, $RGObject, or $RSObject object has a value
                if ($TagNameInput) {                                                        # If $TagsName has a value
                    Write-Host $TagNameInput 'is the currently selected Tag'                # Write message to screen
                }                                                                           # End if if ($TagNameInput)
                if ($RGObject) {                                                            # If $RGObject has a value
                    Write-Host `
                        $RGObject.ResourceGroupName `
                        "is the currently selected resource group"                          # Write message to screen
                }                                                                           # End if ($RGObject)
                if ($RSObject) {                                                            # If $RSObject has a value
                    Write-Host $RSObject.Name "is the currently selected resource"          # Write message to screen
                }                                                                           # End if ($RSObject)
            }                                                                               # End if ($TagNameInput -or $RGObject -or $RSObject) 
            Write-Host 'Resource Group Tag Management'                                      # Write message to screen
            Write-Host '[1] Set Tag Info For Multiple Use'                                  # Write message to screen
            Write-Host '[2] Add Resource Group Tag'                                         # Write message to screen
            Write-Host '[3] Add Resource Tag'                                               # Write message to screen
            Write-Host '[4] Get All Resource Group Tags'                                    # Write message to screen
            Write-Host '[5] Get All Resource Tags'                                          # Write message to screen
            Write-Host '[6] Remove Named Resource Group Tag'                                # Write message to screen
            Write-Host '[7] Remove Named Resource Tag'                                      # Write message to screen
            Write-Host '[8] Remove All Resource Group Tags'                                 # Write message to screen
            Write-Host '[9] Remove All Resource Tags'                                       # Write message to screen
            Write-Host '[Exit] to return'                                                   # Write message to screen
            $OpSelect = Read-Host 'Option [#]'                                              # Operator input to select management function
            if ($OpSelect -eq 'exit') {                                                     # If $OpSelect equals 'exit'
                Break ManageAzureTag                                                        # Breaks :ManageAzureTag  
            }                                                                               # End if ($OpSelect -eq 'exit')
            elseif ($OpSelect -eq '1') {                                                    # Else if $OpSelect equals '1'
                Write-Host "Set Tag Info For Multiple Use"                                  # Write message to screen
                $TagNameInput, $TagValueInput = SetAzTagPair                                # Calls function and assigns output to $var
            }                                                                               # End elseif ($OpSelect -eq '1')
            elseif ($OpSelect -eq '2') {                                                    # Else if $OpSelect equals '2'
                Write-Host "Add Resource Group Tag"                                         # Write message to screen
                $TagsList = AddAzResourceGroupTag `
                    ($RGObject, $TagNameInput, $TagValueInput)                              # Calls function and assigns output to $var
            }                                                                               # End elseif ($OpSelect -eq '2')
            elseif ($OpSelect -eq '3') {                                                    # Else if $OpSelect equals '3'
                Write-Host "Add Resource Tag"                                               # Write message to screen
                $TagsList = AddAzResourceTag `
                    ($RGObject, $RSObject, $TagNameInput, $TagValueInput)                   # Calls function and assigns output to $var
            }                                                                               # End elseif ($OpSelect -eq '3')
            elseif ($OpSelect -eq '4') {                                                    # Else if $OpSelect equals '4'
                Write-Host "Get Resource Group Tag"                                         # Write message to screen
                $TagsList = GetAzResourceGroupTags ($RGObject)                              # Calls function and assigns output to $var
            }                                                                               # End elseif ($OpSelect -eq '4')
            elseif ($OpSelect -eq '5') {                                                    # Else if $OpSelect equals '5'
                Write-Host "Get Resource Tag"                                               # Write message to screen
                $TagsList = GetAzResourceTags ($RGObject, $RSObject)                        # Calls function and assigns output to $var
            }                                                                               # End elseif ($OpSelect -eq '5')
            elseif ($OpSelect -eq '6') {                                                    # Else if $OpSelect equals '6'
                Write-Host "Remove Named Resource Group Tag"                                # Write message to screen
                $TagsList = RemoveAzResourceGroupTag `
                    ($RGObject, $TagNameInput, $TagValueInput)                              # Calls function and assigns output to $var
            }                                                                               # End elseif ($OpSelect -eq '6')
            elseif ($OpSelect -eq '7') {                                                    # Else if $OpSelect equals '7'
                Write-Host "Remove Named Resource Tag"                                      # Write message to screen
                $TagsList = RemoveAzResourceTag `
                    ($RGObject, $RSObject, $TagNameInput, $TagValueInput)                   # Calls function and assigns output to $var
            }                                                                               # End elseif ($OpSelect -eq '7')
            elseif ($OpSelect -eq '8') {                                                    # Else if $OpSelect equals '8'
                Write-Host "Remove Resource Group Tag"                                      # Write message to screen
                $TagsList = RemoveAzResourceGroupTags ($RGObject)                           # Calls function and assigns output to $var
            }                                                                               # End elseif ($OpSelect -eq '8')
            elseif ($OpSelect -eq '9') {                                                    # Else if $OpSelect equals '9'
                Write-Host "Remove Resource Tag"                                            # Write message to screen
                $TagsList = RemoveAzResourceTags ($RGObject, $RSObject)                     # Calls function and assigns output to $var
            }                                                                               # End elseif ($OpSelect -eq '9')
            elseif ($OpSelect -eq '0') {                                                    # Else if $OpSelect equals '0'
                Write-Host '[0] Clear all $vars'                                            # Write message to screen
                Write-Host '[1] Clear $Tags'                                                # Write message to screen
                Write-Host '[2] Clear $RGObject'                                            # Write message to screen
                Write-Host '[3] Clear $RSObject'                                            # Write message to screen
                $OpSelect = Read-Host 'Option [#]'                                          # Operator input for removing a value from $var
                if ($OpSelect -eq '0'){                                                     # If $OpSelect has a value
                    if ($TagNameInput) {                                                    # If $TagsNameInput has a value
                        $TagNameInput = $null                                               # Clears $var
                        Write-Host '$TagNameInput has been cleared'                         # Write message to screen
                    }                                                                       # End if ($TagNameInput)
                    else {                                                                  # If $TagNameInput does not have a value
                        Write-Host '$TagNameInput is already clear'                         # Write message to screen
                    }                                                                       # End else (if ($TagNameInput))
                    if ($RGObject) {                                                        # If $RGObject has a value
                        $RGObject = $null                                                   # Clears $var
                        Write-Host '$RGObject has been cleared'                             # Write message to screen
                    }                                                                       # End if ($RGObject)
                    else {                                                                  # If $RGObject does not have a value
                        Write-Host '$RGObject is already clear'                             # Write message to screen
                    }                                                                       # End else (if ($RGObject))
                    if ($RsObject) {                                                        # If $RSObject has a value
                        $RsObject = $null                                                   # Clears $var
                        Write-Host '$RsObject has been cleared'                             # Write message to screen
                    }                                                                       # End if ($RSObject)
                    else {                                                                  # If $SGObject does not have a value
                        Write-Host '$RsObject is already clear'                             # Write message to screen
                    }                                                                       # End else (if ($RSObject))
                }                                                                           # End if ($OpSelect -eq '0') 
                elseif ($OpSelect -eq '1') {                                                # Else if $OpSelect equals '1'
                    if ($TagNameInput) {                                                    # If $TagsNameInput has a value
                        $TagNameInput = $null                                               # Clears $var
                        Write-Host '$TagNameInput has been cleared'                         # Write message to screen
                    }                                                                       # End if ($TagNameInput)
                    else {                                                                  # If $TagNameInput does not have a value
                        Write-Host '$TagNameInput is already clear'                         # Write message to screen
                    }                                                                       # End else (if ($TagNameInput))
                }                                                                           # End elseif ($OpSelect -eq '1') 
                elseif ($OpSelect -eq '2') {                                                # Else if $OpSelect equals '2'
                    if ($RGObject) {                                                        # If $RGObject has a value
                        $RGObject = $null                                                   # Clears $var
                        Write-Host '$RGObject has been cleared'                             # Write message to screen
                    }                                                                       # End if ($RGObject)
                    else {                                                                  # If $RGObject does not have a value
                        Write-Host '$RGObject is already clear'                             # Write message to screen
                    }                                                                       # End else (if ($RGObject))
                }                                                                           # End elseif ($OpSelect -eq '2') 
                elseif ($OpSelect -eq '3') {                                                # Else if $OpSelect equals '3'
                    if ($RsObject) {                                                        # If $RSObject has a value
                        $RsObject = $null                                                   # Clears $var
                        Write-Host '$RsObject has been cleared'                             # Write message to screen
                    }                                                                       # End if ($RSObject)
                    else {                                                                  # If $SGObject does not have a value
                        Write-Host '$RsObject is already clear'                             # Write message to screen
                    }                                                                       # End else (if ($RSObject))
                }                                                                           # End elseif ($OpSelect -eq '3')
                else {                                                                      # All other inputs for $OpSelect
                    Write-Host 'That was not a valid option'                                # Write message to screen
                }                                                                           # End else (if ($OpSelect -eq '0'))
            }                                                                               # End elseif ($OpSelect -eq '0')
            else {                                                                          # All other inputs for $OpSelect
                Write-Host 'That was not a valid option'                                    # Write message to screen
            }                                                                               # End else (if ($OpSelect -eq '0'))
        }                                                                                   # End :ManageAzureTag while loop
        Return                                                                              # Returns to calling function with $null
    }                                                                                       # End begin
}                                                                                           # End function ManageAzTags
function GetAzResourceGroup {                                                               # Function to get a resource group
    Begin {                                                                                 # Begin function
        $ErrorActionPreference = 'silentlyContinue'                                         # Disables error reporting
        :GetAzureResourceGroup while ($true) {                                              # Outer loop for managing function
            $ObjectList = Get-AzResourceGroup                                               # Gets all resource groups and assigns to $ObjectList
            $ObjectNumber = 1                                                               # Sets $ObjectNumber to 1
            [System.Collections.ArrayList]$ObjectArray = @()                                # Creates the RG list array
            foreach ($_ in $ObjectList) {                                                   # For each $_ in $ObjectListList
                $ObjectInput = [PSCustomObject]@{'Name' = $_.ResourceGroupName; `
                    'Number' = $ObjectNumber; 'Location' = $_.Location}                     # Creates the item to loaded into array
                $ObjectArray.Add($ObjectInput) | Out-Null                                   # Loads item into array, out-null removes write to screen
                $ObjectNumber = $ObjectNumber + 1                                           # Increments $ObjectNumber by 1
            }                                                                               # End foreach ($_ in $ObjectList)
            Write-Host "[0]  Exit"                                                          # Write message to screen
            foreach ($_ in $ObjectArray) {                                                  # For each $_ in $ObjectArray
                $Number = $_.Number                                                         # Sets $Number to current item .number
                if ($_.Number -le 9) {                                                      # If current item .number is 9 or less
                    Write-Host "[$Number] "$_.Name "|" $_.Location                          # Write message to screen
                }                                                                           # End if ($_.Number -le 9) 
                else {                                                                      # If current item .number is greater then 9
                    Write-Host "[$Number]"$_.Name "|" $_.Location                           # Write message to screen
                }                                                                           # End else (if ($_.Number -le 9) )
            }                                                                               # End foreach ($_ in $ObjectArray)
            :SelectAzureObjectList while ($true) {                                          # Inner loop to select the resource group
                if ($CallingFunction) {                                                     # If $CallingFunction exists
                    Write-Host "You are selecting the resource group for"$CallingFunction   # Write message to screen
                }                                                                           # End if ($CallingFunction)
                $RGSelect = Read-Host "Enter the resource group number"                     # Operator input for the RG selection
                if ($RGSelect -eq '0') {                                                    # If $RGSelect equals 0
                    Break GetAzureResourceGroup                                             # Breaks :GetAzureResourceGroup
                }                                                                           # End if ($RGSelect -eq '0')
                elseif ($RGSelect -in $ObjectArray.Number) {                                # If $RGSelect in $ObjectArray.Number
                    $RGSelect = $ObjectArray | Where-Object {$_.Number -eq $RGSelect}       # $RGSelect is equal to $ObjectArray where $ObjectArray.Number is equal to $RGSelect                                  
                    $RGObject = Get-AzResourceGroup | Where-Object `
                        {$_.ResourceGroupName -eq $RGSelect.Name}                           # Pulls the full resource group object
                    Clear-Host                                                              # Clears screen
                    Return $RGObject                                                        # Returns to calling function with $RGObject
                }                                                                           # End elseif ($RGSelect -in $ListArray.Number)
                else {                                                                      # If $RGObject does not have a value
                    Write-Host "That was not a valid option"                                # Write message to screen
                }                                                                           # End else (if ($RGObject))
            }                                                                               # End :SelectAzureObjectList while ($true)
        }                                                                                   # End :GetAzureResourceGroup while ($true)
        Clear-Host                                                                          # Clears screen
        Return                                                                              # Returns to calling function with $null
    }                                                                                       # End begin statement
}                                                                                           # End function GetAzResourceGroup
function SetAzTagPair { # Function for setting the tag name and value pair
    Begin {
        :SetAzureTagPair while ($true) { # :SetAzureTagPairLoop
            :SetAzureTagName while ($true) { # :SetAzureTagNameLoop
                $TagNameInput = Read-Host "Tag Name" # Operator input for the tag name
                if ($TagNameInput -eq 'exit') { # If $TagNameInput equals 'exit'
                    Break SetAzureTagPair # Breaks :SetAzureTagPair loop
                } # End if ($TagNameInput -eq 'exit')
                $OperatorConfirm = Read-Host $TagNameInput "is correct" # Operator confirmation that the name entered is correct
                if ($OperatorConfirm -eq 'y' -or $OperatorConfirm -eq 'yes') { # If $OperatorConfirm is equal to 'y' or 'yes'
                    Break SetAzureTagName # Breaks :setAzureTagName
                } # End if ($OperatorConfirm -eq 'y' -or $OperatorConfirm -eq 'yes')
            } # End :SetAzureTagName while ($true)
            :SetAzureTagValue while ($true) { # :SetAzureTagValue loop
                $TagValueInput = Read-Host "Tag Value" # Operator input for the tag value
                if ($TagValueInput -eq 'exit') { # If $TagValueInput equals 'exit'
                    Break SetAzureTagPair # Breaks :SetAzureTagPair loop
                } # End if ($TagVlaueInput -eq 'exit')
                $OperatorConfirm = Read-Host $TagValueInput "is correct" # Operator confirmation that the value entered is correct
                if ($OperatorConfirm -eq 'y' -or $OperatorConfirm -eq 'yes') { # If $OperatorConfirm is equal to 'y' or 'yes'
                    Break SetAzureTagValue # Breaks :SetAzureTagName
                } # End if ($OperatorConfirm -eq 'y' -or $OperatorConfirm -eq 'yes')
            } # End :SetAzureTagValue while ($true)
            Return $TagNameInput, $TagValueInput # Returns $TagNameInput and $TagValueInput to the calling function
        } # End :SetAzureTagPair while ($true)
        Return # Retruns to calling function with $null
    } # End begin
} # End function SetAzTagPair
function AddAzResourceGroupTag { # Function to add a new tag to a resource group
    Begin {
        :AddAzureRGTag while ($true) { # :AddAzureRGTag loop for adding a new tag on a resource group
            if (!$RGObject) { # If $RGObject is $null
                $RGObject = GetAzResourceGroup # Calls GetAzResourceGroup and assigns output to $RGObject
                if (!$RGObject) { # If called function returns empty
                    Break AddAzureRGTag # Breaks :AddAzureRSTag loop
                } # End if (!$RGObject)
            } # End if (!$RGObject)
            if (!$TagNameInput) { # If $TagNameInput is $null
                :SetAzureTagArray while ($true) { # :SetAzureTagArray loop
                    $TagNameInput, $TagValueInput = SetAzTagPair # Calls function
                    if (!$TagNameInput) { # if SetAzTagPair returns $null
                        Break AddAzureRGTag # Breaks :AddAzureRGTag loop
                    } # End if (!$TagNameInput)
                    $TagsArray = @{$TagNameInput=$TagValueInput} # Builds the tag array to be applied 
                    Break SetAzureTagArray # Breaks :SetAzureTagArray
                } # End :SetAzureTagArray while ($true)
            } # End if (!$TagNameInput)
            Update-AzTag -ResourceID $RGObject.ResourceID -Operation 'Merge' -Tag $TagsArray # Adds the new tag to the resource group without changing the others
            $TagsList = (Get-AzResourceGroup -resourceID $RGObject.ResourceID).TagsTable | Out-String # Formats hashable array into string
            Return $TagsList # Returns $TagsList to the calling function
        } # End :AddAzureRGTag while ($true) {
        Return # Returns to the calling function with $null
    } # End begin
} # End function AddAzResourceGroupTag
function AddAzResourceTag { # Function to add a new tag to a resource
    Begin {
        :AddAzureRSTag while ($true) { # :AddAzureRSTag loop for adding a new tag on a resource group
            if (!$RGObject) { # If $RGObject is $null
                $RGObject = GetAzResourceGroup # Calls GetAzResourceGroup and assigns output to $RGObject
                if (!$RGObject) { # If called function returns empty
                    Break AddAzureRSTag # Breaks :AddAzureRSTag loop
                } # End if (!$RGObject)
            } # End if (!$RGObject)
            if (!$RSObject) { # If $RSObject is $null
                $RSObject = GetAzResource # Calls GetAzResource and assigns output to $RSObject
                if (!$RSObject) { # If called function returns empty
                    Break AddAzureRSTag # Breaks :AddAzureRSTag loop
                } # End if (!$RSObject)
            } # End if (!$RSObject)
            if (!$TagNameInput) { # If $TagNameInput is $null
                :SetAzureTagArray while ($true) { # :SetAzureTagArray loop
                    $TagNameInput, $TagValueInput = SetAzTagPair # Calls function
                    if (!$TagNameInput) { # if SetAzTagPair returns $null
                        Break AddAzureRSTag # Breaks :AddAzureRSTag loop
                    } # End if (!$TagNameInput)
                    $TagsArray = @{$TagNameInput=$TagValueInput} # Builds the tag array to be applied 
                    Break SetAzureTagArray # Breaks :SetAzureTagArray
                } # End :SetAzureTagArray while ($true)
            } # End if (!$TagNameInput)
            Update-AzTag -ResourceID $RSObject.ResourceID -Operation 'Merge' -Tag $TagsArray # Adds the new tag to the resource group without changing the others
            $TagsList = (Get-AzResource -resourceID $RSObject.ResourceID).TagsTable | Out-String
            Return $TagsList # Returns $Tags to the calling function
        } # End :AddAzureRSTag while ($true) {
        Return # Returns to the calling function with $null
    } # End begin
} # End function AddAzResourceTag
function GetAzResourceGroupTags { # Gets all resource group tags and writes them to screen with values
    Begin {
        :GetAzureRGTag while ($true) { # :GetAzureRGTag loop for removing named tag on a resource
            if (!$RGObject) { # If $RGObject is $null
                $RGObject = GetAzResourceGroup # Calls GetAzResourceGroup and assigns output to $RGObject
                if (!$RGObject) { # If called function returns empty
                    Break GetAzureRGTag # Breaks :GetAzureRGTag loop
                } # End if (!$RGObject)
            } # End if (!$RGObject)
            $TagsList = (Get-AzResourceGroup -resourceID $RGObject.ResourceID).TagsTable | Out-String # Formats hashable array into 
            if (!$TagsList) { # If $TagsList is $null
                Write-Host "No tags exist on this resource" # Write message to screen
            } # End if (!$TagsList)
            Return $TagsList # Returns $TagsList to the calling function
        } # End :GetAzureRGTag while ($true) {
        Return # Returns to the calling function with $null
    } # End begin
} # End function GetAzResourceGroupTags
function GetAzResourceTags {
    Begin {
        :GetAzureRSTag while ($true) { # :GetAzureRSTag loop for removing named tag on a resource
            if (!$RGObject) { # If $RGObject is $null
                $RGObject = GetAzResourceGroup # Calls GetAzResourceGroup and assigns output to $RGObject
                if (!$RGObject) { # If called function returns empty
                    Break GetAzureRSTag # Breaks :GetAzureRSTag loop
                } # End if (!$RGObject)
            } # End if (!$RGObject)
            if (!$RSObject) { # If $RSObject is $null
                $RSObject = GetAzResource # Calls GetAzResource and assigns output to $RSObject
                if (!$RSObject) { # If called function returns empty
                    Break GetAzureRSTag # Breaks :GetAzureRSTag loop
                } # End if (!$RSObject)
            } # End if (!$RSObject)
            $TagsList = (Get-AzResource -resourceID $RSObject.ResourceID).TagsTable | Out-String # Formats hashable array into string
            if (!$TagsList) { # If $TagsList is $null
                Write-Host "No tags exist on this resource" # Write message to screen
            } # End if (!$TagsList)
            Return $TagsList # Returns $TagsList to the calling function
        } # End :GetAzureRSTag while ($true) {
        Return # Returns to the calling function with $null
    } # End begin
} # End function GetAzResourceTags
function RemoveAzResourceGroupTag { # Function to remove all tags from a resource
    Begin {
        :RemoveAzureRGTag while ($true) { # :RemoveAzureRGTag loop for removing named tag on a resource
            if (!$RGObject) { # If $RGObject is $null
                $RGObject = GetAzResourceGroup # Calls GetAzResourceGroup and assigns output to $RGObject
                if (!$RGObject) { # If called function returns empty
                    Break RemoveAzureRGTag # Breaks :RemoveAzureRGTag loop
                } # End if (!$RGObject)
            } # End if (!$RGObject)
            $ValidTagName = (Get-AzResourceGroup -ResourceId $RGObject.ResourceId).Tags.Keys # Collects current tag names on resource group and lists them in $ValidTagName
            if ($TagNameInput -notin $ValidTagName) { # Checks passed $TagNameInput against $ValidTagName
                $TagNameInput = $null # Clears $TagNameInput
            } # End if ($TagNameInput -notin $ValidTagName)
            if (!$TagNameInput) { # If $TagNameInput is $null
                :SetAzureTagArray while ($true) { # :SetAzureTagArray loop      
                    $TagNameInput = Read-Host "Tag name to be removed"
                    if (!$TagNameInput -or $TagNameInput -eq 'exit') { # if SetAzTagPair is $null or 'exit'
                        Break RemoveAzureRGTag # Breaks :RemoveAzureRGTag loop
                    } # End if (!$TagNameInput)
                    elseif ($TagNameInput -iin $ValidTagName) { # If $TagNameInput is in $ValidTagName
                        $TagsArray = @{$TagNameInput=""} # Builds the tag array to be removed
                        Break SetAzureTagArray # Breaks :SetAzureTagArray
                    } # End elseif ($TagNameInput -iin $ValidTagName) 
                    else { # All other inputs for $TagNameInput
                        Write-Host "The Tag name provided does not exist" # Write message to screen
                        Write-Host "Please select from the following" # Write message to screen
                        Write-Host $ValidTagName -Separator `n # Write $ValidTagName list to screen
                    } # End else (if (!$TagNameInput -or $TagNameInput -eq 'exit'))
                } # End :SetAzureTagArray while ($true)
            } # End if (!$TagNameInput)
            else { # If $TagNameInput is not $null and is in $ValidTagName build the array
                $TagsArray = @{$TagNameInput=""} # Builds the tag array to be removed
            } # End else (if (!$TagNameInput))
            Update-AzTag -ResourceID $RGObject.ResourceID -Operation 'Delete' -Tag $TagsArray # Removes the named tag from the resource group without changing the others
            $TagsList = (Get-AzResourceGroup -resourceID $RGObject.ResourceID).TagsTable | Out-String # Formats hashable array into string
            if (!$TagsList) { # If $TagsList is $null
                Write-Host "No tags exist on this resource group" # Write message to screen
            } # End if (!$TagsList)
            Return $TagsList # Returns $TagsList to the calling function
        } # End :RemoveAzureRGTag while ($true) {
        Return # Returns to the calling function with $null
    } # End begin
} # End function RemoveAzResouceGroupTag
function RemoveAzResourceTag { # Function to remove all tags from a resource
    Begin {
        :RemoveAzureRSTag while ($true) { # :RemoveAzureRSTag loop for removing named tag on a resource
            if (!$RGObject) { # If $RGObject is $null
                $RGObject = GetAzResourceGroup # Calls GetAzResourceGroup and assigns output to $RGObject
                if (!$RGObject) { # If called function returns empty
                    Break RemoveAzureRSTag # Breaks :RemoveAzureRSTag loop
                } # End if (!$RGObject)
            } # End if (!$RGObject)
            if (!$RSObject) { # If $RSObject is $null
                $RSObject = GetAzResource # Calls GetAzResource and assigns output to $RSObject
                if (!$RSObject) { # If called function returns empty
                    Break RemoveAzureRSTag # Breaks :RemoveAzureRSTag loop
                } # End if (!$RSObject)
            } # End if (!$RSObject)
            $ValidTagName = (Get-AzResource -ResourceId $RSObject.ResourceId).Tags.Keys # Collects current tag names on resource and lists them in $ValidTagName
            if ($TagNameInput -notin $ValidTagName) {
                $TagNameInput = $null
            } # End if ($TagNameInput -notin $ValidTagName)
            if (!$TagNameInput) { # If $TagNameInput is $null
                :SetAzureTagArray while ($true) { # :SetAzureTagArray loop      
                    $TagNameInput = Read-Host "Tag name to be removed"
                    if (!$TagNameInput -or $TagNameInput -eq 'exit') { # if SetAzTagPair is $null or 'exit'
                        Break RemoveAzureRSTag # Breaks :RemoveAzureRSTag loop
                    } # End if (!$TagNameInput)
                    elseif ($TagNameInput -iin $ValidTagName) { # If $TagNameInput is in $ValidTagName
                        $TagsArray = @{$TagNameInput=""} # Builds the tag array to be removed
                        Break SetAzureTagArray # Breaks :SetAzureTagArray
                    } # End elseif ($TagNameInput -iin $ValidTagName) 
                    else { # All other inputs for $TagNameInput
                        Write-Host "The Tag name provided does not exist" # Write message to screen
                        Write-Host "Please select from the following" # Write message to screen
                        Write-Host $ValidTagName -Separator `n # Write $ValidTagName list to screen
                    } # End else (if (!$TagNameInput -or $TagNameInput -eq 'exit'))
                } # End :SetAzureTagArray while ($true)
            } # End if (!$TagNameInput)
            else { # If $TagNameInput is not $null and is in $ValidTagName, build the array
                $TagsArray = @{$TagNameInput=""} # Builds the tag array to be removed
            } # End else (if (!$TagNameInput))
            Update-AzTag -ResourceID $RSObject.ResourceID -Operation 'Delete' -Tag $TagsArray # Removes the named tag from the resource without changing the others
            $TagsList = (Get-AzResource -resourceID $RSObject.ResourceID).TagsTable | Out-String # Formats hashable array into string
            if (!$TagsList) { # If $TagsList is $null
                Write-Host "No tags exist on this resource" # Write message to screen
            } # End if (!$TagsList)
            Return $TagsList # Returns $Tags to the calling function
        } # End :RemoveAzureRSTag while ($true) {
        Return # Returns to the calling function with $null
    } # End begin
} # End function RemoveAzResouceTags
function RemoveAzResourceGroupTags {
    Begin { 
        :RemoveAzureRGTags while ($true) { # :RemoveAzureRGTag loop for removing named tag on a resource
            if (!$RGObject) { # If $RGObject is $null
                $RGObject = GetAzResourceGroup # Calls GetAzResourceGroup and assigns output to $RGObject
                if (!$RGObject) { # If called function returns empty
                    Break RemoveAzureRGTags # Breaks :RemoveAzureRGTags loop
                } # End if (!$RGObject)
            } # End if (!$RGObject)
        Remove-AzTag -ResourceId $RGObject.ResourceID -PassThru # Removes all tags on the resource group
        $TagsList = (Get-AzResourceGroup -resourceID $RGObject.ResourceID).TagsTable | Out-String # Formats hashable array into string
        if (!$TagsList) { # If $TagsList is $null
            Write-Host "No tags exist on this resource group" # Write message to screen
        } # End if (!$TagsList)
        Return $TagsList # Returns $TagsList to the calling function
    } # End :RemoveAzureRGTags while ($true) {
    Return # Returns to the calling function with $null
    } # End begin
} # End function RemoveAzResourceGroupTags
function RemoveAzResourceTags {
    Begin {
        :RemoveAzureRSTags while ($true) { # :RemoveAzureRSTag loop for removing named tag on a resource
            if (!$RGObject) { # If $RGObject is $null
                $RGObject = GetAzResourceGroup # Calls GetAzResourceGroup and assigns output to $RGObject
                if (!$RGObject) { # If called function returns empty
                    Break RemoveAzureRSTags # Breaks :RemoveAzureRSTags loop
                } # End if (!$RGObject)
            } # End if (!$RGObject)
            if (!$RSObject) { # If $RSObject is $null
                $RSObject = GetAzResource # Calls GetAzResource and assigns output to $RSObject
                if (!$RSObject) { # If called function returns empty
                    Break RemoveAzureRSTags # Breaks :RemoveAzureRSTags loop
                } # End if (!$RSObject)
            } # End if (!$RSObject)
            Remove-AzTag -ResourceId $RSObject.ResourceID -PassThru # Removes all tags on the resource
            $TagsList = (Get-AzResource -resourceID $RSObject.ResourceID).TagsTable | Out-String # Formats hashable array into string
            if (!$TagsList) { # If $TagsList is $null
                Write-Host "No tags exist on this resource" # Write message to screen
            } # End if (!$TagsList)
            Return $TagsList # Returns $Tags to the calling function
        } # End :RemoveAzureRSTags while ($true) {
        Return # Returns to the calling function with $null
    } # End begin
} # End function RemoveAzResourceTags