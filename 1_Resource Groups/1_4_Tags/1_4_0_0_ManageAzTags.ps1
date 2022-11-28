# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Microsoft docs links
    Update-AzTag:               https://docs.microsoft.com/en-us/powershell/module/az.resources/update-aztag?view=azps-5.2.0
    Get-AzTag:                  https://docs.microsoft.com/en-us/powershell/module/az.resources/get-azTag?view=azps-5.2.0             
    Get-AzResourceGroup:        https://docs.microsoft.com/en-us/powershell/module/az.resources/get-azresourcegroup?view=azps-5.1.0
    Get-AzResource:             https://docs.microsoft.com/en-us/powershell/module/az.resources/get-azresource?view=azps-5.1.0
} #>
<# Required Functions Links: {
    AddAzRGTag:                 https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/Tags/AddAzRGTag.ps1
        GetAzResourceGroup:         https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/Resource%20Groups/GetAzResourceGroup.ps1
        SetAzTagPair:               https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/Tags/SetAzTagPair.ps1
    AddAzRSTag:                 https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/Tags/AddAzRSTag.ps1
        SetAzTagPair:               https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/Tags/SetAzTagPair.ps1
        GetAzResource:              https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/GetAzResource.ps1
    ListAzRGTags:               https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/Tags/ListAzRGTags.ps1
        GetAzResourceGroup:         https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups//Resource%20Groups/GetAzResourceGroup.ps1
    ListAzRSTags:               https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/Tags/ListAzRSTags.ps1
        GetAzResource:              https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/Resources/GetAzResource.ps1
    RemoveAzRGTag:              https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/Tags/RemoveAzRGTag.ps1
        GetAzResourceGroup:         https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/Resource%20Groups/GetAzResourceGroup.ps1
    RemoveAzRSTag:              https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/Tags/RemoveAzRSTag.ps1
        GetAzResource:              https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/Resources/GetAzResource.ps1
    RemoveAzRGTags:             https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/Tags/RemoveAzRGTags.ps1
        GetAzResourceGroup:         https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/Resource%20Groups/GetAzResourceGroup.ps1
    RemoveAzRSTags:             https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/Tags/RemoveAzRSTags.ps1
        GetAzResource:              https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/Resources/GetAzResource.ps1
} #>
<# Functions Description: {
    ManageAzTags:               Function for managing tag functions
    AddAzRGTag:                 Adds a new tag to a resource group
    AddAzRSTag:                 Adds a new tag to a resource 
    ListAzRGTags:               Lists all tags on a resource group
    ListAzRSTags:               Lists all tags on a resource
    RemoveAzRGTag:              Removes a tag on a resource group
    RemoveAzRSTag:              Removes a tag on a resource
    RemoveAzRGTags:             Removes all tags on a resource group
    RemoveAzRSTags:             Removes all tags on a resource 
    SetAzTagPair:               Creates a list of tags to apply to a resource or group
    GetAzResourceGroup:         Collects a resource group
    GetAzResource:              Collects a resource
} #>
<# Variables: { 
    :ManageAzureTag             Outer loop for managing function
    $OpSelect:                  Operator input for selecting the management function
    AddAzRGTag{}                Gets $null
        GetAzResourceGroup{}        Gets $RGObject
        SetAzTagPair                Gets $TagArray
    AddAzRSTag{}                Gets $null
        GetAzResource{}             Gets $RSObject
        SetAzTagPair                Gets $TagArray
    ListAzRGTags{}              Gets $null
        GetAzResourceGroup{}        Gets $RGObject
    ListAzRSTags{}              Gets $null
        GetAzResource{}             Gets $RSObject
    RemoveAzRGTag{}             Gets $null
        GetAzResourceGroup{}        Gets $RGObject
    RemoveAzRSTag{}             Gets $null
        GetAzResource{}             Gets $RSObject
    RemoveAzRGTags{}            Gets $null
        GetAzResourceGroup{}        Gets $RGObject
    RemoveAzRSTags{}            Gets $null
        GetAzResource{}             Gets $RSObject
}#>
<# Process Flow {
    Function
        Call ManageAzTags > Get $null
            Call AddAzRGTag > Get $null
                Call GetAzResourceGroup > Get $RGObject
                End GetAzResourceGroup
                    Return AddAzRGTag > Send $RGObject
                Call SetAzTagPair > Get $TagArray
                End SetAzTagPair
                    Return AddAzRGTag > Send $TagArray
            End AddAzRGTag
                Return ManageAzTags > Send $null
            Call AddAzRSTag > Get $null
                Call GetAzResource > Get $RSObject
                End GetAzResource
                    Return AddAzRSTag > Send $RSObject
                Call SetAzTagPair > Get $TagArray
                End SetAzTagPair
                    Return AddAzRSTag > Send $TagArray
            End AddAzRSTag
                Return ManageAzTags > Send $null
            Call ListAzRGTags > Get $null
                Call GetAzResourceGroup > Get $RGObject
                End GetAzResourceGroup
                    Return ListAzRGTags > Send $RGObject
            End ListAzRGTags
                Return ManageAzTags > Send $null
            Call ListAzRSTags > Get $null
                Call GetAzResource > Get $RSObject
                End GetAzResource
                    Return ListAzRSTags > Send $RSObject
            End ListAzRSTags
                Return ManageAzTags > Send $null                
            Call RemoveAzRGTag > Get $null
                Call GetAzResourceGroup > Get $RGObject
                End GetAzResourceGroup
                    Return RemoveAzRGTag > Send $RGObject
            End RemoveAzRGTag
                Return ManageAzTags > Send $null
            Call RemoveAzRSTag > Get $null
                Call GetAzResource > Get $RSObject
                End GetAzResource
                    Return RemoveAzRSTag > Send $RSObject
            End RemoveAzRSTag
                Return ManageAzTags > Send $null
            Call RemoveAzRGTags > Get $null
                Call GetAzResourceGroup > Get $RGObject
                End GetAzResourceGroup
                    Return RemoveAzRGTags > Send $RGObject
            End RemoveAzRGTags
                Return ManageAzTags > Send $null
            Call RemoveAzRSTags > Get $null
                Call GetAzResource > Get $RSObject
                End GetAzResource
                    Return RemoveAzRSTags > Send $RSObject
            End RemoveAzRSTags
                Return ManageAzTags > Send $null
        End ManageAzTags
            Return Function > Send $null
}#>
function ManageAzTags {                                                                     # Management function for tags
    Begin {                                                                                 # Begin function
        :ManageAzureTag while($true) {                                                      # Outer loop for managing function
            Write-Host 'Resource Group Tag Management'                                      # Write message to screen
            Write-Host '[0] Exit'                                                           # Write message to screen
            Write-Host '[1] Add Resource Group Tag'                                         # Write message to screen
            Write-Host '[2] Add Resource Tag'                                               # Write message to screen
            Write-Host '[3] List All Resource Group Tags'                                   # Write message to screen
            Write-Host '[4] List All Resource Tags'                                         # Write message to screen
            Write-Host '[5] Remove Resource Group Tag'                                      # Write message to screen
            Write-Host '[6] Remove Resource Tag'                                            # Write message to screen
            Write-Host '[7] Remove All Resource Group Tags'                                 # Write message to screen
            Write-Host '[8] Remove All Resource Tags'                                       # Write message to screen
            $OpSelect = Read-Host 'Option [#]'                                              # Operator input to select management function
            if ($OpSelect -eq '0') {                                                        # If $OpSelect equals '0'
                Break ManageAzureTag                                                        # Breaks :ManageAzureTag  
            }                                                                               # End if ($OpSelect -eq '0')
            elseif ($OpSelect -eq '1') {                                                    # Else if $OpSelect equals '1'
                Write-Host 'Add Resource Group Tag'                                         # Write message to screen
                AddAzRGTag                                                                  # Calls function
            }                                                                               # End elseif ($OpSelect -eq '1')
            elseif ($OpSelect -eq '2') {                                                    # Else if $OpSelect equals '2'
                Write-Host 'Add Resource Tag'                                               # Write message to screen
                AddAzRSTag                                                                  # Calls function
            }                                                                               # End elseif ($OpSelect -eq '2')
            elseif ($OpSelect -eq '3') {                                                    # Else if $OpSelect equals '3'
                Write-Host 'List Resource Group Tag'                                        # Write message to screen
                ListAzRGTags                                                                # Calls function
            }                                                                               # End elseif ($OpSelect -eq '3')
            elseif ($OpSelect -eq '4') {                                                    # Else if $OpSelect equals '4'
                Write-Host 'List Resource Tag'                                              # Write message to screen
                ListAzRSTags                                                                # Calls function
            }                                                                               # End elseif ($OpSelect -eq '4')
            elseif ($OpSelect -eq '5') {                                                    # Else if $OpSelect equals '5'
                Write-Host 'Remove Resource Group Tag'                                      # Write message to screen
                RemoveAzRGTag                                                               # Calls function
            }                                                                               # End elseif ($OpSelect -eq '5')
            elseif ($OpSelect -eq '6') {                                                    # Else if $OpSelect equals '6'
                Write-Host 'Remove Resource Tag'                                            # Write message to screen
                RemoveAzRSTag                                                               # Calls function
            }                                                                               # End elseif ($OpSelect -eq '6')
            elseif ($OpSelect -eq '7') {                                                    # Else if $OpSelect equals '7'
                Write-Host 'Remove All Resource Group Tags'                                 # Write message to screen
                RemoveAzRGTags                                                              # Calls function 
            }                                                                               # End elseif ($OpSelect -eq '7')
            elseif ($OpSelect -eq '8') {                                                    # Else if $OpSelect equals '8'
                Write-Host 'Remove All Resource Tags'                                       # Write message to screen
                RemoveAzRSTags                                                              # Calls function 
            }                                                                               # End elseif ($OpSelect -eq '8')
            else {                                                                          # All other inputs for $OpSelect
                Write-Host 'That was not a valid option'                                    # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Clear-Host                                                                  # Clears screen
            }                                                                               # End else (if ($OpSelect -eq '0'))
        }                                                                                   # End :ManageAzureTag while loop
        Clear-Host                                                                          # Clears screen
        Return                                                                              # Returns to calling function with $null
    }                                                                                       # End begin
}                                                                                           # End function ManageAzTags
function AddAzRGTag {                                                                       # Function to add a new tag to a resource group
    Begin {                                                                                 # Begin function
        $CallingFunction = 'AddAzRGTag'                                                     # Creates $CallingFunction
        :AddAzureRGTag while ($true) {                                                      # Outer loop for managing function
            if (!$RGObject) {                                                               # If $RGObject is $null
                $RGObject = GetAzResourceGroup ($CallingFunction)                           # Calls function and assigns output to $var
                if (!$RGObject) {                                                           # If $RGObject is $null
                    Break AddAzureRGTag                                                     # Breaks :AddAzureRSTag
                }                                                                           # End if (!$RGObject) | Inner
            }                                                                               # End if (!$RGObject) | Outer
            $TagArray = SetAzTagPair ($CallingFunction)                                     # Calls function and assigns output to $var
            if (!$TagArray) {                                                               # If $TagArray is $null
                Break AddAzureRGTag                                                         # Breaks AddAxureTag
            }                                                                               # End if (!$TagArray)
            foreach ($_ in $TagArray) {                                                     # For each item in $TagArray
                $Newtag = @{$_.Name=$_.Value}                                               # Creates a new hashed name and value
                try {                                                                       # Try the following
                $TagsList = Update-AzTag -ResourceID $RGObject.ResourceID -Operation `
                    'Merge' -Tag $Newtag                                                    # Appends the new tag to the resource group
                }                                                                           # End try
                catch {                                                                     # If try fails
                    Write-Host 'An error has occured'                                       # Write message to screen
                    Write-Host 'Check your permissions'                                     # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    $TagsList = `
                        (Get-AzResourceGroup -resourceID $RGObject.ResourceID).TagsTable    # Gets the current tags assigned to $RGObject
                    Write-Host 'The following tags are currently set on'`
                        $RGObject.ResourceGroupName                                         # Write message to screen
                    Write-Host $TagsList                                                    # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Break AddAzureRGTag                                                     # Breaks :AddAzureRGTag
                }                                                                           # End catch
            }                                                                               # End foreach ($_ in $TagArray)                                                       
            $TagsList = (Get-AzResourceGroup -resourceID $RGObject.ResourceID).TagsTable    # Gets the current tags assigned to $RGObject
            Write-Host 'The following tags are currently set on'$RGObject.ResourceGroupName # Write message to screen
            Write-Host $TagsList                                                            # Write message to screen
            Pause                                                                           # Pauses all actions for operator input
            Break AddAzureRGTag                                                             # Breaks :AddAzureRGTag
        }                                                                                   # End :AddAzureRGTag while ($true)
        Clear-Host                                                                          # Clears the screen
        Return                                                                              # Returns to the calling function with $null
    }                                                                                       # End begin
}                                                                                           # End function AddAzRGTag
function AddAzRSTag {                                                                       # Function to add a new tag to a resource grop
    Begin {                                                                                 # Begin function
        $CallingFunction = 'AddAzRSTag'                                                     # Creates $CallingFunction
        :AddAzureRSTag while ($true) {                                                      # Outer loop for managing function
            if (!$RSObject) {                                                               # If $RSObject is $null
                $RSObject = GetAzResource ($CallingFunction)                                # Calls function and assigns output to $var
                if (!$RSObject) {                                                           # If $RSObject is $null
                    Break AddAzureRSTag                                                     # Breaks :AddAzureRSTag
                }                                                                           # End if (!$RSObject) | Inner
            }                                                                               # End if (!$RSObject) | Outer
            $TagArray = SetAzTagPair ($CallingFunction)                                     # Calls function and assigns output to $var
            if (!$TagArray) {                                                               # If $TagArray is $null
                Break AddAzureRSTag                                                         # Breaks AddAxureTag
            }                                                                               # End if (!$TagArray)
            Write-Host 'Adding the selected tags'                                           # Write message to screen
            foreach ($_ in $TagArray) {                                                     # For each item in $TagArray
                $Newtag = @{$_.Name=$_.Value}                                               # Creates a new hashed name and value
                try {                                                                       # Try the following
                $TagsList = Update-AzTag -ResourceID $RSObject.ResourceID -Operation `
                    'Merge' -Tag $Newtag                                                    # Appends the new tag to the resource group
                }                                                                           # End try
                catch {                                                                     # If try fails
                    Write-Host 'An error has occured'                                       # Write message to screen
                    Write-Host 'Check your permissions'                                     # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    $TagsList = `
                        (Get-AzResource -resourceID $RSObject.ResourceID).TagsTable         # Gets the current tags assigned to $RSObject
                    Write-Host 'The following tags are currently set on'$RSObject.name      # Write message to screen
                    Write-Host $TagsList                                                    # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Break AddAzureRSTag                                                     # Breaks :AddAzureRSTag
                }                                                                           # End catch
            }                                                                               # End foreach ($_ in $TagArray)                                                       
            $TagsList = (Get-AzResource -resourceID $RSObject.ResourceID).TagsTable         # Gets the current tags assigned to $RSObject
            Write-Host 'The following tags are currently set on'$RSObject.name              # Write message to screen
            Write-Host $TagsList                                                            # Write message to screen
            Pause                                                                           # Pauses all actions for operator input
            Break AddAzureRSTag                                                             # Breaks :AddAzureRSTag
        }                                                                                   # End :AddAzureRSTag while ($true)
        Clear-Host                                                                          # Clears the screen
        Return                                                                              # Returns to the calling function with $null
    }                                                                                       # End begin
}                                                                                           # End function AddAzRSTag
function ListAzRGTags {                                                                     # Gets all resource group tags and writes them to screen with values
    Begin {                                                                                 # Begin function
        $CallingFunction = 'ListAzRGTags'                                                   # Creates $CallingFunction
        :GetAzureRGTag while ($true) {                                                      # Outer loop for managing function
            $RGObject = GetAzResourceGroup ($CallingFunction)                               # Calls function and assigns output to $var
            if (!$RGObject) {                                                               # If $RGObject is $null
                Break GetAzureRGTag                                                         # Breaks :GetAzureRGTag
            }                                                                               # End if (!$RGObject)
            $TagsList = (Get-AzResourceGroup -resourceID $RGObject.ResourceID).TagsTable    # Gets the current tags assigned to $RGObject
            Write-Host 'The following tags are currently set on'$RGObject.ResourceGroupName # Write message to screen
            Write-Host $TagsList                                                            # Write message to screen
            Pause                                                                           # Pauses for user input to continue
            Break GetAzureRGTag                                                             # Breaks :GetAzureRGTag 
        }                                                                                   # End :GetAzureRGTag while ($true)
    Clear-Host                                                                              # Clears screen
    Return                                                                                  # Returns to the calling function with $null
    }                                                                                       # End begin
}                                                                                           # End function ListAzRGTags
function ListAzRSTags {                                                                     # Gets all resource tags and writes them to screen with values
    Begin {                                                                                 # Begin function
        $CallingFunction = 'ListAzRSTags'                                                   # Creates $CallingFunction
        :GetAzureRSTag while ($true) {                                                      # Outer loop for managing function
            $RSObject = GetAzResource ($CallingFunction)                                    # Calls function and assigns output to $var
            if (!$RSObject) {                                                               # If $RSObject is $null
                Break GetAzureRSTag                                                         # Breaks :GetAzureRSTag
            }                                                                               # End if (!$RSObject)
            $TagsList = (Get-AzResource -resourceID $RSObject.ResourceID).TagsTable         # Gets the current tags assigned to $RSObject
            Write-Host 'The following tags are currently set on'$RSObject.Name              # Write message to screen
            Write-Host $TagsList                                                            # Write message to screen
            Pause                                                                           # Pauses for user input to continue
            Break GetAzureRSTag                                                             # Breaks :GetAzureRSTag 
        }                                                                                   # End :GetAzureRSTag while ($true)
    Clear-Host                                                                              # Clears screen
    Return                                                                                  # Returns to the calling function with $null
    }                                                                                       # End begin
}                                                                                           # End function ListAzRSTags
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
function RemoveAzRSTag {                                                                    # Function to remove tags from a resource 
    Begin {                                                                                 # Begin function
        $CallingFunction = 'RemoveAzRSTag'                                                  # Creates calling function
        :RemoveAzureRSTag while ($true) {                                                   # Outer loop for managing function
            $RSObject = GetAzResource ($CallingFunction)                                    # Calls function and assigns output to $var
            if (!$RSObject) {                                                               # If $RSObject does not have a value
                Break RemoveAzureRSTag                                                      # Breaks :RemoveAzureRSTag
            }                                                                               # End if (!$RSObject)
            $TagsNames = `
                (Get-AzTag -ResourceId $RSObject.ResourceId).Properties.TagsProperty.Keys   # Gets all tag names on $RSObject
            $TagsValues = `
                (Get-AzTag -ResourceId $RSObject.ResourceId).Properties.TagsProperty.Values # Gets all tag values on $RSObject
            if (!$TagsNames) {                                                              # If $TagsNames does not have a value
                Write-Host 'The resource does not have any tags'                            # Write message to screen
                Pause                                                                       # Pauses for operator input to continue
                Break RemoveAzureRSTag                                                      # Breaks :RemoveAzureRSTag
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
                        Break RemoveAzureRSTag                                              # Breaks :RemoveAzureRSTag
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
                $TagsList = Update-AzTag -ResourceID $RSObject.ResourceID -Operation `
                'Delete' -Tag $TagsArray                                                    # Removes the named tag from the resource group 
            }                                                                               # End try
            catch {                                                                         # If try fails
                Write-Host 'An error has occured'                                           # Write message to screen
                Write-Host 'There maybe a policy that'                                      # Write message to screen
                Write-Host 'prevents the removal of this tag'                               # Write message to screen           
                Pause                                                                       # Pauses for user input to continue
                Break RemoveAzureRSTag                                                      # Breaks :RemoveAzureRSTag
            }                                                                               # End catch    
            $TagsList = (Get-AzResource -resourceID $RSObject.ResourceID).TagsTable         # Gets the current tags assigned to $RSObject
            Write-Host 'The following tags are currently set on'$RSObject.Name              # Write message to screen
            Write-Host $TagsList                                                            # Write message to screen           
            Pause                                                                           # Pauses for user input to continue
            Break RemoveAzureRSTag                                                          # Breaks :RemoveAzureRSTag
        }                                                                                   # End :RemoveAzureRSTag while ($true)
        Clear-Host                                                                          # Clears screen
        Return                                                                              # Returns to the calling function with $null
    }                                                                                       # End begin
}                                                                                           # End function RemoveAzResouceTag
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
function RemoveAzRSTags {                                                                   # Function to remove all tags on a resource
    Begin {                                                                                 # Begin function
        $CallingFunction = 'RemoveAzRSTags'                                                 # Creates $CallingFunction
        :RemoveAzureRSTag while ($true) {                                                   # Outer loop for managing function
            $RSObject = GetAzResource ($CallingFunction)                                    # Calls function and assigns output to $var
            if (!$RSObject) {                                                               # If $RSObject does not have a value
                Break RemoveAzureRSTag                                                      # Breaks :RemoveAzureRSTag
            }                                                                               # End if (!$RSObject)
            $TagsNames = `
                (Get-AzTag -ResourceId $RSObject.ResourceId).Properties.TagsProperty.Keys   # Gets all tag names on $RSObject
            $TagsValues = `
                (Get-AzTag -ResourceId $RSObject.ResourceId).Properties.TagsProperty.Values # Gets all tag values on $RSObject
            if (!$TagsNames) {                                                              # If $TagsNames does not have a value
                Write-Host 'The resource does not have any tags'                            # Write message to screen
                Pause                                                                       # Pauses for operator input to continue
                Break RemoveAzureRSTag                                                      # Breaks :RemoveAzureRSTag
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
                    $TagsList = Update-AzTag -ResourceID $RSObject.ResourceID -Operation `
                    'Delete' -Tag $TagsArray -ErrorAction 'Stop'                            # Removes the named tag from the resource group 
                }                                                                           # End try
                catch {                                                                     # If try fails
                    Write-Host 'An error has occured'                                       # Write message to screen
                    Write-Host 'There maybe a policy that'                                  # Write message to screen
                    Write-Host 'prevents the removal of the tags'                           # Write message to screen
                    $TagsList = (Get-AzResource -resourceID $RSObject.ResourceID).TagsTable # Gets the current tags assigned to $RSObject
                    Write-Host ''                                                           # Write message to screen
                    Write-Host 'The following tags are currently set on'$RSObject.Name      # Write message to screen
                    Write-Host $TagsList                                                    # Write message to screen
                    Pause                                                                   # Pauses for operator input to continue
                    Break RemoveAzureRSTag                                                  # Breaks :RemoveAzureRSTag
                }                                                                           # End catch   
            } 
            Write-Host 'All tags removed from'$RSObject.Name                                # Write message to screen
            Pause                                                                           # Pauses for operator input to continue
            Break RemoveAzureRSTag                                                          # Breaks :RemoveAzureRSTag
        }                                                                                   # End :RemoveAzureRSTags while ($true)
        Clear-Host                                                                          # Clears screen
        Return                                                                              # Returns to the calling function with $null
    }                                                                                       # End begin
}                                                                                           # End function RemoveAzRSTags
function SetAzTagPair {                                                                     # Function for setting the tag name and value pair
    Begin {                                                                                 # Being function
        [System.Collections.ArrayList]$TagArray = @()                                       # Creates the blank tag array
        :SetAzureTagPair while ($true) {                                                    # Outer loop for managing function
            if ($CallingFunction) {                                                         # If $CallingFunction has a value
                Write-host 'You are setting the tag for'$CallingFunction                    # Write message to screen
            }                                                                               # End if ($CallingFunction)
            :SetAzureTagName while ($true) {                                                # Inner loop for setting the tag name
                $TagNameInput = Read-Host "Tag Name"                                        # Operator input for the tag name
                if ($TagNameInput -eq '0') {                                                # If $TagNameInput equals '0'
                    Break SetAzureTagPair                                                   # Breaks :SetAzureTagPair
                }                                                                           # End if ($TagNameInput -eq '0')
                Write-Host 'Use'$TagNameInput 'as the tag name'                             # Write message to screen
                $OpConfirm = Read-Host '[Y] or [N]'                                         # Operator confirmation that the name entered is correct
                if ($OpConfirm -eq 'y') {                                                   # If $OpConfirm is equal to 'y'
                    Clear-Host                                                              # Clears the screen
                    Break SetAzureTagName                                                   # Breaks :SetAzureTagName
                }                                                                           # End if ($OpConfirm -eq 'y')
            }                                                                               # End :SetAzureTagName while ($true)
            :SetAzureTagValue while ($true) {                                               # Inner loop for setting the tag value
                $TagValueInput = Read-Host "Tag Value"                                      # Operator input for the tag value
                if ($TagValueInput -eq '0') {                                               # If $TagValueInput equals '0'
                    Break SetAzureTagPair                                                   # Breaks :SetAzureTagPair
                }                                                                           # End if ($TagVlaueInput -eq '0')
                if (!$TagValueInput) {                                                      # If $TagValueInput is $null
                    Write-Host 'Use a blank tag value'                                      # Write message to screen
                }                                                                           # End if (!$TagValueInput)
                else {                                                                      # If $TagValueInput has a value
                    Write-Host 'Use'$TagValueInput 'as the tag value'                       # Write message to screen
                }                                                                           # End else (if (!$TagValueInput))
                $OpConfirm = Read-Host '[Y] or [N]'                                         # Operator confirmation that the name entered is correct
                if ($OpConfirm -eq 'y') {                                                   # If $OpConfirm is equal to 'y'
                    Clear-Host                                                              # Clears the screen
                    Break SetAzureTagValue                                                  # Breaks :SetAzureTagName
                }                                                                           # End if ($OpConfirm -eq 'y')
            }                                                                               # End :SetAzureTagValue while ($true)
            $ArrayInput = [PSCustomObject]@{'Name'=$TagNameInput;'Value'=$TagValueInput}    # Creates the item to loaded into array
            $TagArray.Add($ArrayInput) | Out-Null                                           # Loads item into array, out-null removes write to screen
            Write-Host 'Add another pair'                                                   # Write message to screen
            $OpConfirm = Read-Host '[Y] or [N]'                                             # Operator confirmation to add another tag
            if ($OpConfirm -eq 'n') {                                                       # If $OpConfirm equals 'n'
                Break SetAzureTagPair                                                       # Breaks :SetAzureTagPair
            }                                                                               # End if ($OpConfirm -eq 'n')
            Clear-Host                                                                      # Clear the screen 
        }                                                                                   # End :SetAzureTagPair while ($true)
        Clear-Host                                                                          # Clear the screen
        if ($TagArray) {                                                                    # If $TagArray has a value
            Return $TagArray                                                                # Returns to calling function with $var
        }                                                                                   # End if ($TagArray)
        else {                                                                              # If $TagArray does not have a value
            Return                                                                          # Returns to calling function with $null
        }                                                                                   # End else (if ($TagArray))
    }                                                                                       # End begin
}                                                                                           # End function SetAzTagPair
# Additional functions required for ManageAzTags
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
function GetAzResource {                                                                    # Function to get a resource 
    Begin {                                                                                 # Begin function
        $ErrorActionPreference = 'silentlyContinue'                                         # Disables error reporting
        :GetAzureResource while ($true) {                                                   # Outer loop for managing function
            $RSList = Get-AzResource                                                        # Gets all resources and assigns to $RSList
            $ListNumber = 1                                                                 # Sets $ListNumber to 1
            [System.Collections.ArrayList]$ListArray = @()                                  # Creates the list array
            foreach ($_ in $RSList) {                                                       # For each $_ in $RSListList
                $ListInput = [PSCustomObject]@{'Name'=$_.Name; `
                'RG' = $_.ResourceGroupName;'Number' = $ListNumber; `
                'Location' = $_.Location}                                                   # Creates the item to loaded into array
                $ListArray.Add($ListInput) | Out-Null                                       # Loads item into array, out-null removes write to screen
                $ListNumber = $ListNumber + 1                                               # Increments $ListNumber by 1
            }                                                                               # End foreach ($_ in $RSList)
            Write-Host "[0] Exit"                                                           # Write message to screen
            foreach ($_ in $ListArray) {                                                    # For each $_ in $ListArray
                $Number = $_.Number                                                         # Sets $Number to current item .Number
                if ($_.Number -le 9) {                                                      # If current item .number is 9 or less
                    Write-Host "[$Number] "$_.Name                                          # Write message to screen
                }                                                                           # End if ($_.Number -le 9)
                else {                                                                      # If current item .number is more than 9
                    Write-Host "[$Number]"$_.Name                                           # Write message to screen
                }                                                                           # End else (if ($_.Number -le 9))
                Write-Host 'RG: '$_.RG                                                      # Write message to screen
                Write-Host 'Loc:'$_.Location                                                # Write message to screen
                Write-Host ''                                                               # Write message to screen
            }                                                                               # End foreach ($_ in $ListArray)
            :SelectAzureResource while ($true) {                                            # Inner loop to select the resource 
                if ($CallingFunction) {                                                     # If $CallingFunction exists
                    Write-Host "You are selecting the resource for"$CallingFunction         # Write message to screen
                }                                                                           # End if ($CallingFunction)
                $RSSelect = Read-Host "Enter the resource [#]"                              # Operator input for the resource selection
                if ($RSSelect -eq '0') {                                                    # If $RSSelect equals 0
                    Break GetAzureResource                                                  # Breaks :GetAzureResource
                }                                                                           # End if ($RSSelect -eq '0')
                if ($RSSelect -in $ListArray.Number) {                                      # If $RSSelect is in $ListArray
                    $RSSelect = $ListArray | Where-Object {$_.Number -eq $RSSelect}         # $RSSelect is equal to $ListArray where $ListArray.Number is equal to $RSSelect                                  
                    $RSObject = Get-AzResource -ResourceGroup $RSSelect.RG `
                        | Where-Object {$_.Name -eq $RSSelect.Name}                         # Pulls the full resource object
                    Clear-Host                                                              # Clears screen
                    Return $RSObject                                                        # Returns to calling function with $RGObject
                }                                                                           # End if ($RSSelect -in $ListArray)
                else {                                                                      # If $RGObject does not have a value
                    Write-Host "That was not a valid option"                                # Write message to screen
                }                                                                           # End else (if ($RGObject))
            }                                                                               # End :SelectAzureResource while ($true)
        }                                                                                   # End :GetAzureResource while ($true)
        Clear-Host                                                                          # Clears screen
        Return                                                                              # Returns to calling function with $null
    }                                                                                       # End begin statement
}                                                                                           # End function GetAzResource