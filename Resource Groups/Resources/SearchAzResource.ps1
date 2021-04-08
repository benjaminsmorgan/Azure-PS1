# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Mircosoft docs links
    Get-AzResource:             https://docs.microsoft.com/en-us/powershell/module/az.resources/get-azresource?view=azps-5.1.0
    Get-AzResourceProvider:     https://docs.microsoft.com/en-us/powershell/module/az.resources/get-azresourceprovider?view=azps-5.2.0
    Get-AzLocation:             https://docs.microsoft.com/en-us/powershell/module/az.resources/get-azlocation?view=azps-5.2.0
    Get-AzTag:                  https://docs.microsoft.com/en-us/powershell/module/az.resources/get-azTag?view=azps-5.2.0
} #>
<# Required Functions Links: {
    SearchAzResourceName:       https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/SearchAzResourceName.ps1
    SearchAzResourceType:       https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/SearchAzResourceType.ps1
    SearchAzResourceLoc:        https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/SearchAzResourceLoc.ps1
    SearchAzResourceTag:        https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/SearchAzResourceTag.ps1
} #>    
<# Function Description: {
    SearchAzResourceGroup:      Management function for all SearchAzResourceGroup*
        SearchAzResourceName:       Searchs for resource using partial name matches on a resource name
        SearchAzResourceType:       Searchs for resource using resource provider or type on a resource or resource
        SearchAzResourceLoc:        Searchs for resource using location matches on a resource
        SearchAzResourceTag:        Searchs for resource using tag matches on a resource
} #>
<# Variables: {
    SearchAzResource {
        :SearchAzureRS          Outer loop for function
        $SearchAzRS:            Operator input for type of search
        $RSObject:              Resource object      
        SearchAzResourceName {
            :SearchAzureRSByName    Outer loop for function
            :SearchAzureRSName      Inner loop for finding resource by name
            $RSObjectInput:         Operator input for the resource name
            $RSObject:              Resource object
            $RGObjectInput:         Operator input for the resource group name
            $ForEachCount:          Number used in foreach statement for each found resource
        } End SearchAzResourceName
        SearchAzResourceType {                
            :SearchAzureRSByType    Outer loop for function
            :SearchAzureRPName      Inner lopp for getting the Azure resource provider
            :SearchAzureRSType      Inner loop for getting the Azure resource provider type
            :GetAzureRSObject       Inner loop for collecting the resource object
            $OperatorSearchOption:  Operator input to search by provider or provider and type
            $ProviderList:          List of all Azure resource providers
            $RPObjectInput:         Azure resource provider object input
            $RPObject:              Azure resource provider object
            $RPTObjectList:         List of all types on selected Azure resource provider 
            $RPTObjectInput:        Operator input for Azure resource provider type object
            $RPTObject:             Azure resource provider type object
            $RSObjectInput:         Operator input for the resource name
            $RSObject:              Resource object
            $RGObjectInput:         Operator input for the resource group name       
            $OperatorConfirm:       Operator confirmation that the resource provider and type are correct
            $ForEachCount:          Number used in foreach statement for each found resource
        } End SearchAzResourceType
        SearchAzResourceLoc {
            :SearchAzureRSByLoc     Outer loop for function
            :SearchAzureRSLoc       Inner loop for finding resource by location
            :SetLocation            Inner loop for setting $Location
            :GetAzureRSObject       Inner loop for collecting the resource object
            $ValidLocation:         List of all valid Azure locations
            $Location:              Operator input for the resource location
            $RSObject:              Resource object
            $RSObjectInput:         Operator input for the resource name 
            $RGObjectInput:         Operator input for the resource group name 
            $ForEachCount:          Number used in foreach statement for each found resource
        } End SearchAzResourceLoc
        SearchAzResourceTag {
            :SearchAzureRSByTag     Outer loop for function
            :SearchAzureRSTag       Inner loop for finding resource by tags
            :SetTagName             Inner loop for setting tag name
            :SetTagValue            Inner loop for setting tag value
            $ValidTagName:          List of all available tags in Azure subscription
            $TagNameInput:          Operator input for the tag name
            $TagValueInput:         Operator input for the tag value
            $RSObject:              Resource object
            $OperatorSearchOption:  Operator input to narrow search 
            $ForEachCount:          Number used in foreach statement for each found resource          
            $RSObjectInput:         Operator input for the resource name 
            $RGObjectInput:         Operator input for the resource group name
        } End SearchAzResourceTag
    } End SearchAzResource
} #>
<# Process Flow {
    Function
        Call SearchAzResource > Get $RSObject
            Call SearchAzResourceName > Get $RSObject
            End SearchAzResourceName
                Return SearchAzResource > Send $RSObject
            Call SearchAzResourceType > Get $RSObject
            End SearchAzResourceType
                Return SearchAzResource > Send $RSObject                
            Call SearchAzResourceLoc  > Get $RSObject
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