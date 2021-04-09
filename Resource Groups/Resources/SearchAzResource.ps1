# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Mircosoft docs links
    Get-AzResource:             https://docs.microsoft.com/en-us/powershell/module/az.resources/get-azresource?view=azps-5.1.0
    Get-AzResourceProvider:     https://docs.microsoft.com/en-us/powershell/module/az.resources/get-azresourceprovider?view=azps-5.2.0
    Get-AzLocation:             https://docs.microsoft.com/en-us/powershell/module/az.resources/get-azlocation?view=azps-5.2.0
    Get-AzTag:                  https://docs.microsoft.com/en-us/powershell/module/az.resources/get-azTag?view=azps-5.2.0
} #>
<# Required Functions Links: {
    SearchAzResourceType:       https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/SearchAzResourceType.ps1
    SearchAzResourceLoc:        https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/SearchAzResourceLoc.ps1
    SearchAzResourceTag:        https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/SearchAzResourceTag.ps1
    GetAzLocation:              https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/Locations/GetAzLocation.ps1
} #>    
<# Function Description: {
    SearchAzResource:           Management function for all SearchAzResource functions
    SearchAzResourceType:       Searches for resource using resource provider or type on a resource or resource
    SearchAzResourceLoc:        Searches for resource using location matches on a resource
    SearchAzResourceTag:        Searches for resource using tag matches on a resource
    GetAzLocation:              Gets an Azure location
} #>
<# Variables: {
    :SearchAzureRS              Outer loop for managing function
    $OpSelect:                  Operator input for selecting the search function
    $RSObject:                  Resource object
    SearchAzResourceType{}      Gets $RSObject
    SearchAzResourceLoc{}       Gets $RSObject
        GetAzLocation{}             Gets $LocationObject
    SearchAzResourceTag{}       Gets $RSObject
} #>
<# Process Flow {
    Function
        Call SearchAzResource > Get $RSObject
            Call SearchAzResourceType > Get $RSObject
            End SearchAzResourceType
                Return SearchAzResource > Send $RSObject                
            Call SearchAzResourceLoc  > Get $RSObject
                Call GetAzLocation > Get $LocationObject
                End GetAzLocation
                    Return SearchAzResourceLoc > Send $LocationObject
            End SearchAzResourceLoc
                Return SearchAzResource > Send $RSObject
            Call SearchAzResourceTag  > Get $RSObject
            End SearchAzResourceTag
                Return SearchAzResource > Send $RSObject
        End SearchAzResource
            Return Function > Send $RSObject
}#>
function SearchAzResource {                                                                 # Function to manage search resource functions
    Begin {                                                                                 # Begin function
        :SearchAzureRS while($true) {                                                       # Outer loop for managing function 
            Write-Host 'Azure Resource Search'                                              # Write message to screen
            Write-Host '[1] Search by resource type'                                        # Write message to screen
            Write-Host '[2] Search by resource location'                                    # Write message to screen
            Write-Host '[3] Search by tags'                                                 # Write message to screen
            Write-Host '[Exit] to return'                                                   # Write message to screen
            $OpSelect = Read-Host 'Enter option [#]'                                        # Operator input to select the search function
            if ($OpSelect -eq 'exit') {                                                     # If $OpSelect equals 'exit' 
                Break SearchAzureRS                                                         # Breaks :SearchAzureRS 
            }                                                                               # End if ($OpSelect -eq 'exit')
            elseif ($OpSelect -eq '1') {                                                    # Else if $OpSelect equals '1'
                Write-Host 'Search by type'                                                 # Write message to screen
                $RSObject = SearchAzResourceType                                            # Calls function to assign output to $var
            }                                                                               # End elseif ($OpSelect -eq '1')
            elseif ($OpSelect -eq '2') {                                                    # Else if $OpSelect equals '2'
                Write-Host 'Search by location'                                             # Write message to screen
                $RSObject = SearchAzResourceLoc                                             # Calls function to assign output to $var
            }                                                                               # End elseif ($OpSelect -eq '3')
            elseif ($OpSelect -eq '3') {                                                    # Else if $OpSelect equals '3'
                Write-Host 'Search by tag'                                                  # Write message to screen
                $RSObject = SearchAzResourceTag                                             # Calls function to assign output to $var
            }                                                                               # End elseif ($OpSelect -eq '3')
            else {                                                                          # All other inputs for $OpSelect
                Write-Host 'That was not a valid option'                                    # Write message to screen
            }                                                                               # End else (if ($OpSelect -eq 'exit'))
            if ($RSObject) {                                                                # If $RSObject has a value
                Clear-Host                                                                  # Clears the screen
                Return $RSObject                                                            # Returns to calling function with $var
            }                                                                               # End if ($RSObject)
        }                                                                                   # End :SearchAzureRS while($true)
        Clear-Host                                                                          # Clears the screen
        Return                                                                              # Returns to calling function with $null
    }                                                                                       # End begin
}                                                                                           # End function SearchAzResource 
function SearchAzResourceType {                                                             # Function to search for resource group by resource provider or type
    Begin {                                                                                 # Begin function
        $ProviderList = Get-AzResourceProvider | select-object ProviderNamespace            # Collects all current Azure resource provider names
        :SearchAzureRSByType while($True) {                                                 # Outer loop for manaing function
            $ListNumber = 1                                                                 # Sets $ListNumber to '1'
            [System.Collections.ArrayList]$ListArray = @()                                  # Creates the $ListArray
            foreach ($_ in $ProviderList) {                                                 # For each $_ in $ProviderList
                $ListInput = [PSCustomObject]@{'Name' = $_.ProviderNamespace; `
                    'Number' = $ListNumber}                                                 # Creates the item to loaded into array
                $ListArray.Add($ListInput) | Out-Null                                       # Loads item into array, out-null removes write to screen
                $ListNumber = $ListNumber + 1                                               # Increments $ListNumber by 1
            }                                                                               # End foreach ($_ in $ProviderList)
            Write-Host 'Resource Group Search By Resource Type'                             # Write message to screen
            Write-Host '[Exit] this function'                                               # Write message to screen
            Write-Host '[1] Search by provider type'                                        # Write message to screen
            Write-Host '[2] Search by resource type'                                        # Write message to screen
            $OpSelect = Read-Host 'Search option [#]'                                       # Operator input for $OpSelect
            if ($OpSelect -eq 'exit') {                                                     # If $OpSelect equals 'exit'
                Break SearchAzureRSByType                                                   # Breaks :SearchAzureRSByType
            }                                                                               # End if ($OpSelect -eq 'exit')
            elseif ($OpSelect -eq '1') {                                                    # Else if $OpSelect equals '1'
                :SearchAzureRSProvider while($True) {                                       # Inner loop to find a resource off  provider
                    $RPObject = $null                                                       # Clears $RPObject
                    $RSObject = $null                                                       # Clears $RSObject
                    Write-Host '[0]  Exit'                                                  # Write message to screen
                    foreach ($_ in $ListArray) {                                            # For each item in $ListArray
                        $Number = $_.Number                                                 # $Number is equal to current item .Number
                        if ($Number -le 9) {                                                # If $Number is 9 or less
                            Write-Host "[$Number] " $_.Name                                 # Write message to screen
                        }                                                                   # End if ($Number -le 9)
                        else {                                                              # If $Number is 10 or more
                            Write-Host "[$Number]" $_.Name                                  # Write message to screen
                        }                                                                   # End else (if ($Number -le 9))
                    }                                                                       # End foreach ($_ in $ListArray)
                    :SelectAzureRSProvider while ($True) {                                  # Inner loop for selecting a resource provider name
                        $RPObjectInput = Read-Host "Resource provider"                      # Operator input for $RPObjectInput
                        if ($RPObjectInput -eq '0') {                                       # If $RPObjectInput equals '0'
                            Break SearchAzureRSProvider                                     # Breaks :SearchAzureRSProvider 
                        }                                                                   # End if ($RPObjectInput -eq '0')
                        elseif ($RPObjectInput -in $ListArray.Number) {                     # If $RPObjectInput in $ListArray.Number
                            $RPObject = $ListArray | Where-Object `
                                {$_.Number -eq $RPObjectInput}                              # $RPObjectInput is equal to $ListArray where $RPObjectInput equals $ListArray.number 
                            $RPObject = $RPObject.Name                                      # Isolates the resource provider name
                            $RPObject = $RPObject+"/*"                                      # Adds a wild card to the resource search 
                            Break SelectAzureRSProvider                                     # Breaks :SelectAzureRSProvider 
                        }                                                                   # End elseif ($RPObjectInput -in $ListArray.Number)
                        else {                                                              # All other inputs for $RPObjectInput
                            Write-Host 'That was not a valid input'                         # Write message to screen
                        }                                                                   # End else (if ($RPObjectInput -eq '0'))
                    }                                                                       # End :SelectAzureRSProvider while ($True)
                    $RSObject = Get-AzResource | Where-Object `
                        {$_.ResourceType -like $RPObject}                                   # Collects all resource with a resource provider matching $RPObject
                    if (!$RSObject) {                                                       # If $RSObject does not have a value
                        Write-Host `
                            'No resources found with the selected provider type'$RPObject   # Write message to screen
                        Break SearchAzureRSProvider                                         # Breaks :SearchAzureRSProvider
                    }                                                                       # End if (!$RSObject)
                    if ($RSObject.count -gt 1) {                                            # If $RSObject count is greater than 1
                        $ListArray = $null                                                  # Clears $ListArray
                        [System.Collections.ArrayList]$ListArray = @()                      # Recreates the $ListArray
                        $ListNumber = 1                                                     # Sets $ListNumber to '1'
                        foreach ($_ in $RSObject) {                                         # For each $_ in $ProviderList
                            $ListInput = [PSCustomObject]@{'Name'=$_.Name; `
                                'Number' = $ListNumber;'RG'=$_.ResourceGroupName}           # Creates the item to loaded into array
                            $ListArray.Add($ListInput) | Out-Null                           # Loads item into array, out-null removes write to screen
                            $ListNumber = $ListNumber + 1                                   # Increments $ListNumber by 1
                        }                                                                   # End foreach ($_ in $RSObject)
                        :SelectAzureRSObject while ($True) {                                # Inner loop for selecting a resource from a list
                            Write-Host '[0] Exit'                                           # Write message to screen
                            Write-Host ''                                                   # Write message to screen
                            foreach ($_ in $ListArray) {                                    # For each item in $ListArray
                                $Number = $_.Number                                         # $Number is equal to current item .Number
                                if ($Number -le 9) {                                        # If $Number is 9 or less
                                    Write-Host "[$Number] " $_.Name                         # Write message to screen
                                    Write-Host 'RG: '$_.RG                                  # Write message to screen
                                    Write-Host ''                                           # Write message to screen
                                }                                                           # End if ($Number -le 9)
                                else {                                                      # If $Number is 10 or more
                                    Write-Host "[$Number]" $_.Name                          # Write message to screen
                                    Write-Host 'RG: '$_.RG                                  # Write message to screen
                                    Write-Host ''                                           # Write message to screen
                                }                                                           # End else (if ($Number -le 9))
                            }                                                               # End foreach ($_ in $ListArray)
                            $RSObjectInput = Read-Host 'Enter the [#] of the resource'      # Operator input to select the resource
                            if ($RSObjectInput -eq '0') {                                   # If $RSObjectInput equals '0'
                                Break SearchAzureRSProvider                                 # Breaks :SearchAzureRSProvider
                            }                                                               # End if ($RSObjectInput -eq '0')
                            elseif ($RSObjectInput -in $ListArray.Number) {                 # IF $RSObjectInput in $ListArray.Number
                                $RSObject = $ListArray | Where-Object `
                                    {$_.Number -eq $RSObjectInput}                          # $RSObject equals $ListArray where $RSObjectInput equals $ListArray.Number
                                $RSObject = Get-AzResource -Name $RSObject.Name `
                                    -ResourceGroupName $RSObject.RG                         # Pulls the full resource object
                                Clear-Host                                                  # Clear the screen
                                Return $RSObject                                            # Returns to calling function with $var
                            }                                                               # End elseif ($RSObjectInput -in $ListArray.Number)
                            else {                                                          # All other inputs for $RSObjectInput
                                Write-Host 'That was not a valid input'                     # Write message to screen
                            }                                                               # End else (if ($RSObjectInput -eq '0'))
                        }                                                                   # End :SelectAzureRSObject while ($True)
                    }                                                                       # End if ($RSObject.count -gt 1) 
                    else {                                                                  # If $RSObject has a value and the count is not greater than '1'
                        Clear-Host                                                          # Clear the screen
                        Return $RSObject                                                    # Returns to calling function with $var
                    }                                                                       # End else (if ($RSObject.count -gt 1))
                }                                                                           # End :SearchAzureRSProvider while ($True)
            }                                                                               # End elseif ($OpSelect -eq '1')
            elseif ($OpSelect -eq '2') {                                                    # Else if $OpSelect equals
                :SearchAzureRSProvider while($True) {                                       # Inner loop to find a resource off types
                    $RPObject = $null                                                       # Clears $RPObject
                    $RPTObject = $null                                                      # Clears $RPTObject
                    $RSObject = $null                                                       # Clears $RSObject
                    Write-Host '[0] Exit'                                                   # Write message to screen
                    foreach ($_ in $ListArray) {                                            # For each item in $ListArray
                        $Number = $_.Number                                                 # $Number is equal to current item .Number
                        if ($Number -le 9) {                                                # If $Number is 9 or less
                            Write-Host "[$Number] " $_.Name                                 # Write message to screen
                        }                                                                   # End if ($Number -le 9)
                        else {                                                              # If $Number is 10 or more
                            Write-Host "[$Number]" $_.Name                                  # Write message to screen
                        }                                                                   # End else (if ($Number -le 9))
                    }                                                                       # End foreach ($_ in $ListArray)
                    :SelectAzureRSProvider while ($True) {                                  # Inner loop for selecting a resource provider 
                        $RPObjectInput = Read-Host "Resource provider"                      # Operator input for $RPObjectInput
                        if ($RPObjectInput -eq '0') {                                       # If $RPObjectInput equals '0'
                            Break SearchAzureRSProvider                                     # Breaks :SearchAzureRSProvider 
                        }                                                                   # End if ($RPObjectInput -eq '0')
                        elseif ($RPObjectInput -in $ListArray.Number) {                     # If $RPObjectInput in $ListArray.Number
                            $RPObject = $ListArray | Where-Object `
                                {$_.Number -eq $RPObjectInput}                              # $RPObjectInput is equal to $ListArray where $RPObjectInput equals $ListArray.number 
                            $RPObject = $RPObject.Name                                      # Isolates the resource provider name
                            Break SelectAzureRSProvider                                     # Breaks :SelectAzureRSProvider 
                        }                                                                   # End elseif ($RPObjectInput -in $ListArray.Number)
                        else {                                                              # All other inputs for $RPObjectInput
                            Write-Host 'That was not a valid input'                         # Write message to screen
                        }                                                                   # End else (if ($RPObjectInput -eq '0'))
                    }                                                                       # End :SelectAzureRSProvider while ($True)
                    $RPTObjectList = (Get-AzResourceProvider | Where-Object `
                        {$_.ProviderNamespace -eq $RPObject`
                        }).ResourceTypes                                                    # Creates a list of resrouce provider types
                    $ListArray = $null                                                      # Clears $ListArray
                    [System.Collections.ArrayList]$ListArray = @()                          # Recreates the $ListArray
                    $ListNumber = 1                                                         # Sets $ListNumber to '1'
                    foreach ($_ in $RPTObjectList) {                                        # For each $_ in $ProviderList
                        $ListInput = [PSCustomObject]@{'Name'=$_.ResourceTypeName; `
                            'Number' = $ListNumber}                                         # Creates the item to loaded into array
                        $ListArray.Add($ListInput) | Out-Null                               # Loads item into array, out-null removes write to screen
                        $ListNumber = $ListNumber + 1                                       # Increments $ListNumber by 1
                    }                                                                       # End foreach ($_ in $RPTObjectList)
                    Write-Host '[0] Exit'                                                   # Write message to screen
                    foreach ($_ in $ListArray) {                                            # For each item in $ListArray
                        $Number = $_.Number                                                 # $Number is equal to current item .Number
                        if ($Number -le 9) {                                                # If $Number is 9 or less
                            Write-Host "[$Number] " $_.Name                                 # Write message to screen
                        }                                                                   # End if ($Number -le 9)
                        else {                                                              # If $Number is 10 or more
                            Write-Host "[$Number]" $_.Name                                  # Write message to screen
                        }                                                                   # End else (if ($Number -le 9))
                    }                                                                       # End foreach ($_ in $ListArray)
                    :SelectAzureRPType while ($True) {                                      # Inner loop for selecting the resource provider type
                        $RPTObjectInput = Read-Host 'Enter the type [#]'                    # Operator input for the resource provider type name
                        if ($RPTObjectInput -eq '0') {                                      # If $RPTObjectInput equals '0' 
                            Break SearchAzureRSType                                         # Breaks :SearchAzureRSType
                        }                                                                   # End if ($RPTObjectInput -eq '0')
                        elseif ($RPTObjectInput -in $ListArray.Number) {                    # If $RPTObjectInput in $ListArry.Number
                            $RPTObject = $ListArray | Where-Object `
                                {$_.Number -eq $RPTObjectInput}                             # $RPTObject equals $ListArray where $RPTObjectInput equals $ListArray.number
                            $RPTObject = $RPTObject.Name                                    # RPTObject equals $RPTObject.Name
                            $RPTObjectName = $RPObject+"/"+$RPTObject                       # Merges $RPObject and $RPTObject for resource search
                            Break SelectAzureRPType                                         # Breaks :SelectAzureRPType
                        }                                                                   # End elseif ($RPTObjectInput -in $ListArray.Number)
                        else {                                                              # All other inputs for $RPTObject
                            Write-Host 'That was not a valid input'                         # Write message to screen
                        }                                                                   # End else (if ($RPTObjectInput -eq '0'))
                    }                                                                       # End :GetAzureRPTObject while ($True)
                    $RSObject = Get-AzResource -ResourceType $RPTObjectName                 # Collects all resource with a resource provider type matching $RPTObject
                    if (!$RSObject) {                                                       # If $RSObject does not have a value
                        Write-Host `
                            'No resources found with provider type'$RPTObjectName           # Write message to screen
                        Break SearchAzureRSType                                             # Breaks :SearchAzureRSType
                    }                                                                       # End if (!$RSObject)
                    if ($RSObject.count -gt 1) {                                            # If $RSObject count is greater than 1
                        $ListArray = $null                                                  # Clears $ListArray
                        [System.Collections.ArrayList]$ListArray = @()                      # Recreates the $ListArray
                        $ListNumber = 1                                                     # Sets $ListNumber to '1'
                        foreach ($_ in $RSObject) {                                         # For each $_ in $ProviderList
                            $ListInput = [PSCustomObject]@{'Name'=$_.Name; `
                                'Number'= $ListNumber;'RG'=$_.ResourceGroupName}            # Creates the item to loaded into array
                            $ListArray.Add($ListInput) | Out-Null                           # Loads item into array, out-null removes write to screen
                            $ListNumber = $ListNumber + 1                                   # Increments $ListNumber by 1
                        }                                                                   # End foreach ($_ in $RSObject)
                        :SelectAzureRSObject while ($True) {                                # Inner loop for selecting a resource from a list
                            Write-Host '[0] Exit'                                           # Write message to screen
                            Write-Host ''                                                   # Write message to screen
                            foreach ($_ in $ListArray) {                                    # For each item in $ListArray
                                $Number = $_.Number                                         # $Number is equal to current item .Number
                                if ($Number -le 9) {                                        # If $Number is 9 or less
                                    Write-Host "[$Number] " $_.Name                         # Write message to screen
                                    Write-Host 'RG: '$_.RG                                  # Write message to screen
                                    Write-Host ''                                           # Write message to screen
                                }                                                           # End if ($Number -le 9)
                                else {                                                      # If $Number is 10 or more
                                    Write-Host "[$Number]" $_.Name                          # Write message to screen
                                    Write-Host 'RG: '$_.RG                                  # Write message to screen
                                    Write-Host ''                                           # Write message to screen
                                }                                                           # End else (if ($Number -le 9))
                            }                                                               # End foreach ($_ in $ListArray)
                            $RSObjectInput = Read-Host 'Enter the [#] of the resource'      # Operator input to select the resource
                            if ($RSObjectInput -eq '0') {                                   # If $RSObjectInput equals '0'
                                Break SearchAzureRSProvider                                 # Breaks :SearchAzureRSProvider
                            }                                                               # End if ($RSObjectInput -eq '0')
                            elseif ($RSObjectInput -in $ListArray.Number) {                 # If $RSObjectInput in $ListArray.Number
                                $RSObject = $ListArray | Where-Object `
                                    {$_.Number -eq $RSObjectInput}                          # $RSObject equals $ListArray where $RSObjectInput equals $ListArray.Number
                                $RSObject = Get-AzResource -Name $RSObject.Name `
                                    -ResourceGroupName $RSObject.ResourceGroupName          # Pulls the full resource object
                                Clear-Host                                                  # Clear the screen
                                Return $RSObject                                            # Returns to calling function with $var
                            }                                                               # End elseif ($RSObjectInput -in $ListArray.Number)
                            else {                                                          # All other inputs for $RSObjectInput
                                Write-Host 'That was not a valid input'                     # Write message to screen
                            }                                                               # End else (if ($RSObjectInput -eq '0'))
                        }                                                                   # End :SelectAzureRSObject while ($True)
                    }                                                                       # End if ($RSObject.count -gt 1) 
                    else {                                                                  # If $RSObject has a value and the count is not greater than '1'
                        Clear-Host                                                          # Clear the screen
                        Return $RSObject                                                    # Returns to calling function with $var        
                    }                                                                       # End else (if ($RSObject.count -gt 1))
                }                                                                           # End :SearchAzureRSProvider while ($True)
            }                                                                               # End elseif ($OpSelect -eq '2')
            else {                                                                          # All other inputs for if $OpSelect
                Write-Host 'That was not a valid option'                                    # Write message to screen
            }                                                                               # End else (if ($OpSelect -eq 'exit'))
        }                                                                                   # End :SearchAzRGByType while ($true)
        Start-Sleep(5)                                                                      # Pauses all actions for 5 seconds
        Clear-Host                                                                          # Clear the screen
        Return                                                                              # Returns to calling function with $null
    }                                                                                       # End begin statement
}                                                                                           # End  function SearchAzResourceType
function SearchAzResourceLoc {                                                              # Function to get a resource based off location
    Begin {                                                                                 # Begin function
        :SearchAzureRSByLoc while($true) {                                                  # Outer loop for managing function
            $CallingFunction = 'SearchAzResourceLoc'                                        # Creates $CallingFunction
            $LocationObject = GetAzLocation ($CallingFunction)                              # Calls function and assigns output to $var
            if (!$LocationObject) {                                                         # If $LocationObject is $null
                Break SearchAzureRSByLoc                                                    # Breaks :SearchAzureRSByLoc
            }                                                                               # End if (!$LocationObject)
            else {                                                                          # If $LocationObject has a value
                $RSObject = Get-AzResource | Where-Object `
                    {$_.Location -eq $LocationObject.Location}                              # Pulls all matching resources
                if (!$RSObject) {
                    Write-Host 'No resources found in'$LocationObject.Location              # Write message to screen
                    Start-Sleep(5)                                                          # Pauses all action for 5 seconds
                    Break SearchAzureRSByLoc                                                # Breaks :SearchAzureRSByLoc
                }                                                                           # End if (!$RSObject)
                elseif ($RSObject.Count -gt 1) {                                            # If $RSObject exists and has a count greater than 1
                    $ListNumber = 1                                                         # Sets $ListNumber to 1
                    [System.Collections.ArrayList]$ListArray = @()                          # Creates the list array
                    foreach ($_ in $RSObject) {                                             # For each $_ in $RSObject
                        $ListInput = [PSCustomObject]@{'Name'=$_.Name; `
                        'RG' = $_.ResourceGroupName;'Number' = $ListNumber}                 # Creates the item to loaded into array
                        $ListArray.Add($ListInput) | Out-Null                               # Loads item into array, out-null removes write to screen
                        $ListNumber = $ListNumber + 1                                       # Increments $ListNumber by 1
                    }                                                                       # End foreach ($_ in $RSObject)
                    Write-Host '[0]  Exit'                                                  # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    foreach ($_ in $ListArray) {                                            # For each $_ in $ListArray
                        $Number = $_.Number                                                 # Sets $Number to current item .Number
                        if ($_.Number -le 9) {                                              # If current item .number is 9 or less
                            Write-Host "[$Number] "$_.Name                                  # Write message to screen
                        }                                                                   # End if ($_.Number -le 9)
                        else {                                                              # If current item .number is more than 9
                            Write-Host "[$Number]"$_.Name                                   # Write message to screen
                        }                                                                   # End else (if ($_.Number -le 9))
                        Write-Host 'RG: '$_.RG                                              # Write message to screen
                        Write-Host ''                                                       # Write message to screen
                    }                                                                       # End foreach ($_ in $ListArray)
                    :SelectAzureResource while ($true) {                                    # Inner loop to select the resource
                        $RSSelect = Read-Host "Enter the resource [#]"                      # Operator input for the resource selection
                        if ($RSSelect -eq '0') {                                            # If $RSSelect equals 0
                            Break SearchAzureRSByLoc                                        # Breaks :SearchAzureRSByLoc
                        }                                                                   # End if ($RSSelect -eq '0')
                        if ($RSSelect -in $ListArray.Number) {                              # If $RSSelect is in $ListArray
                            $RSSelect = $ListArray | Where-Object {$_.Number -eq $RSSelect} # $RSSelect is equal to $ListArray where $ListArray.Number is equal to $RSSelect                                  
                            $RSObject = Get-AzResource -ResourceGroup $RSSelect.RG `
                                | Where-Object {$_.Name -eq $RSSelect.Name}                 # Pulls the full resource object
                            Clear-Host                                                      # Clears screen
                            Return $RSObject                                                # Returns to calling function with $RGObject
                        }                                                                   # End if ($RSSelect -in $ListArray)
                        else {                                                              # All other inputs for RSSelect
                            Write-Host "That was not a valid option"                        # Write message to screen
                        }                                                                   # End else (if ($RSSelect -in $ListArray.Number))
                    }                                                                       # End :SelectAzureResource while ($true)
                }                                                                           # End elseif (($RSObject.Count -gt 1))
                else {                                                                      # If $RSObject exists with a single object
                    Clear-Host                                                              # Clears screen
                    Return $RSObject                                                        # Returns to calling function with $var
                }                                                                           # End else (if (!$RSObject))
            }                                                                               # End else (if (!$LocationObject))
        }                                                                                   # End :SearchAzureRSByLoc while($true)
        Clear-Host                                                                          # Clears screen
        Return                                                                              # Returns to calling function with $null
    }                                                                                       # End begin
}                                                                                           # End function SearchAzResourceLoc
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
                        Clear-Host                                                          # Clears the screen
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
                        Clear-Host                                                          # Clears the screen
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
                    Start-Sleep(5)                                                          # Pauses all actions for 5 seconds
                    Break SearchAzureResource                                               # Breaks :SearchAzureResource 
                }                                                                           # End if (!$RSObject)
            }                                                                               # End if ($TagValue)
            else {                                                                          # Else statement for $TagValueInput not having a value
                $RSObject = Get-AzResource -TagName $TagName                                # Collects all resource objects where tag name matches $TagNameInput
                if (!$RSObject) {                                                           # $RSObject does not have a value
                    Write-Host "No resources found for the Tag name"$TagName                # Write message to screen
                    Start-Sleep(5)                                                          # Pauses all actions for 5 seconds
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
                        Clear-Host                                                          # Clears the screen
                        Return $RSObject                                                    # Returns $RSObject to calling function
                    }                                                                       # End if ($RSSelect -in $ObjectArray)
                    else {                                                                  # If $RGObject does not have a value
                        Write-Host "That was not a valid option"                            # Write message to screen
                    }                                                                       # End else (if ($RSSelect -eq '0')))
                }                                                                           # End :SelectAzureResource while ($true)
            }                                                                               # End if ($RSObject.count -eq 1) 
            else {                                                                          # If $RSObject has a single value
                Clear-Host                                                                  # Clears the screen
                Write-Host 'A single matching resource is named:'$RSObject.Name             # Write message to screen
                Return $RSObject                                                            # Returns $RGObject to calling function       
            }                                                                               # End else (if ($RSObject.count -eq 1))
        }                                                                                   # End :SearchAzureResource while ($true)
        Clear-Host                                                                          # Clears the screen
        return                                                                              # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function SearchAzResourceTag
# Additional functions required for SearchAzResource
function GetAzLocation {                                                                    # Function to get azure location
    Begin {                                                                                 # Begin function
        :GetAzureLocation while ($true) {                                                   # Outer loop for managing function
            $ListObject = Get-AzLocation                                                    # Gets a list of all Azure locations
            $ListNumber = 1                                                                 # $Var for selecting the location
            [System.Collections.ArrayList]$ListArray = @()                                  # Creates the list array
            foreach ($_ in $ListObject) {                                                   # For each $_ in $ListObject
                $ListInput = [PSCustomObject]@{'Number' = $ListNumber; 'Location' `
                = $_.DisplayName}                                                           # Creates the item to load into array
                $ListArray.Add($ListInput) | Out-Null                                       # Loads item into array, out-null removes write to screen
                $ListNumber = $ListNumber + 1                                               # Increments $ListNumber by 1
            }                                                                               # End foreach ($_ in $ListObject)
            Write-Host "[ 0 ] Exit"                                                         # Write message to screen
            foreach ($_ in $ListArray) {                                                    # For each $_ in $ListArray
                Write-Host '['$_.Number']' $_.Location                                      # Writes number and location to screen
            }                                                                               # End foreach ($_ in $ListArray)
            :SelectAzureLocation while ($true) {                                            # Inner loop for selecting location from list
                if ($CallingFunction) {                                                     # If $CallingFunction exists
                    Write-Host "You are selecting the location for"$CallingFunction         # Write message to screen
                }                                                                           # End if ($CallingFunction)
                $LocationSelect = Read-Host "Please enter [#] of the location"              # Operator input for the selection
                if ($LocationSelect -eq '0') {                                              # If $LocationSelect is 0
                    Break GetAzureLocation                                                  # Breaks :GetAzureLocation
                }                                                                           # End if ($LocationSelect -eq '0')
                elseif ($LocationSelect -in $ListArray.Number) {                            # If $LocationSelect in $ListArray.Number
                    $LocationSelect = $ListArray | Where-Object {$_.Number -eq `
                        $LocationSelect}                                                    # LocationSelect is equal to $ListArray where $LocationSelect equals $ListArray.Number
                    Try {                                                                   # Try the following
                        $LocationObject = Get-AzLocation | Where-Object {$_.DisplayName `
                            -eq $LocationSelect.Location} -ErrorAction 'Stop'               # Pulls the full $LocationObject
                    }                                                                       # End try
                    catch {                                                                 # If try fails
                        Write-Host 'An error has occured'                                   # Write message to screen
                        Write-Host 'Please try again later'                                 # Write message to screen
                        Break GetAzureLocation                                              # Breaks :GetAzureLocation 
                    }                                                                       # End catch
                    Clear-Host                                                              # Clears screen
                    Return $LocationObject                                                  # Returns $LocationObject to calling function
                }                                                                           # End elseif ($LocationSelect -in $ListArray.Number) 
                else {                                                                      # All other inputs for $LocationSelect
                    Write-Host "That was not a valid selection"                             # Write message to screen   
                }                                                                           # End else (if ($LocationSelect -eq '0'))
            }                                                                               # End :SelectAzureLocation while ($true)
        }                                                                                   # End :GetAzureLocation while ($true)
        Clear-Host                                                                          # Clears screen
        Return                                                                              # Returns with $null 
    }                                                                                       # End Begin
}                                                                                           # End function GetAzLocation