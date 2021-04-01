# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Mircosoft docs links
    Get-AzResourceGroup:        https://docs.microsoft.com/en-us/powershell/module/az.resources/get-azresourcegroup?view=azps-5.1.0
    Get-AzResource:             https://docs.microsoft.com/en-us/powershell/module/az.resources/get-azresource?view=azps-5.1.0
    Get-AzResourceProvider:     https://docs.microsoft.com/en-us/powershell/module/az.resources/get-azresourceprovider?view=azps-5.2.0
    Get-AzLocation:             https://docs.microsoft.com/en-us/powershell/module/az.resources/get-azlocation?view=azps-5.2.0
    Get-AzTag:                  https://docs.microsoft.com/en-us/powershell/module/az.resources/get-azTag?view=azps-5.2.0
} #>
<# Required Functions Links: {
    SearchAzResourceGroupName:  https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/SearchAzResourceGroupName.ps1
    SearchAzResourceGroupType:  https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/SearchAzResourceGroupType.ps1
    SearchAzResourceGroupLoc:   https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/SearchAzResourceGroupLoc.ps1
    SearchAzResourceGroupTag:   https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/SearchAzResourceGroupTag.ps1
    GetAzLocation:              https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/Locations/GetAzLocation.ps1
} #>    
<# Function Description: {
    SearchAzResourceGroup:      Management function for all SearchAzResourceGroup functions
    SearchAzResourceGroupName:  Searchs for resource group using partial name matches on the group name, or a contained resource name
    SearchAzResourceGroupType:  Searchs for resource group resource provider or type on a resource or resource group
    SearchAzResourceGroupLoc:   Searchs for resource group using location matches on the group, or a contained resource
    SearchAzResourceGroupTag:   Searchs for resource group using tag matches on the group, or a contained resource
    GetAzLocation:              Gets an Azure location
} #>
<# Variables: {
    :SearchAzureRG              Outer loop for selecting search type
    $SearchAzRG:                Operator input for type of search
    SearchAzResourceGroupName{} Gets $RGObject
    SearchAzResourceGroupType{} Gets $RGObject
    SearchAzResourceGroupLoc{}  Gets $RGObject
        GetAzLocation{}             Gets $LocationObject
    SearchAzResourceGroupTag{}  Gets $RGObject
} #>
<# Process Flow {
    Function
        Call SearchAzResourceGroup > Get $RGObject
            Call SearchAzResourceGroupName > Get $RGObject
            End SearchAzResourceGroupName
                Return SearchAzResourceGroup > Send $RGObject
            Call SearchAzResourceGroupType > Get $RGObject
            End SearchAzResourceGroupType
                Return SearchAzResourceGroup > Send $RGObject
            Call SearchAzResourceGroupLoc  > Get $RGObject
                Call GetAzLocation > Get $LocationObject
                End GetAzLocation
                    Return SearchAzResourceGroupLoc > Send $LocationObject
            End SearchAzREsourceGroupLoc
                Return SearchAzResourceGroup > Send $RGObject
            Call SearchAzResourceGroupTag  > Get $RGObject
                Return SearchAzResourceGroup > Send $RGObject
                    Return Function > Send $RGObject
}#>
function SearchAzResourceGroup {                                                            # Function to manage search for resource group functions
    Begin {                                                                                 # Begin function
        :SearchAzureRG while($true) {                                                       # Outer loop for managing function
            Write-Host "Azure Resource Group Search"                                        # Write message to screen
            Write-Host "[1] Search by partial name lookup"                                  # Write message to screen
            Write-Host "[2] Search by contained resource type"                              # Write message to screen
            Write-Host "[3] Search by resource group location"                              # Write message to screen
            Write-Host "[4] Search by tags"                                                 # Write message to screen
            Write-Host "'Exit to return'"                                                   # Write message to screen
            $SearchAzRG = Read-Host "Option?"                                               # Operator input on $SearchAzRG option
            if ($SearchAzRG -eq 'exit') {                                                   # If $SearchAzRG equals 'exit'
                Break SearchAzureRG                                                         # Breaks :SearchAzureRG
            }                                                                               # End if ($SearchAzRG -eq 'exit')
            elseif ($SearchAzRG -eq '1') {                                                  # Else if $SearchAzRG equals '1'
                Write-Host "Search by name"                                                 # Write message to screen
                $RGObject = SearchAzResourceGroupName                                       # Calls function and assigns output to $var
            }                                                                               # End elseif ($SearchAzRG -eq '1')
            elseif ($SearchAzRG -eq '2') {                                                  # Else if $SearchAzRG equals '2'
                Write-Host "Search by type"                                                 # Write message to screen
                $RGObject = SearchAzResourceGroupType                                       # Calls function and assigns output to $var
            }                                                                               # End elseif ($SearchAzRG -eq '2')
            elseif ($SearchAzRG -eq '3') {                                                  # Else if $SearchAzRG equals '3'
                Write-Host "Search by location"                                             # Write message to screen
                $RGObject = SearchAzResourceGroupLoc                                        # Calls function and assigns output to $var
            }                                                                               # End elseif ($SearchAzRG -eq '3')
            elseif ($SearchAzRG -eq '4') {                                                  # Else if $SearchAzRG equals '4'
                Write-Host "Search by tag"                                                  # Write message to screen
                $RGObject = SearchAzResourceGroupTag                                        # Calls function and assigns output to $var
            }                                                                               # End elseif ($SearchAzRG -eq '4')
            else {                                                                          # All other inputs for $SearchAzRG
                Write-Host 'That was not a valid option'                                    # Write message to screen
            }                                                                               # End else (if($SearchAzRG -eq 'exit'))
            if ($RGObject) {                                                                # If $RGObject has a value
                Return $RGObject                                                            # Returns to calling function with $RGObject
            }                                                                               # End if ($RGObject)
            else {                                                                          # If $RGObject does not have a value
                Write-Host 'No resource group selected'                                     # Write message to screen
            }                                                                               # End else (if ($RGObject))
        }                                                                                   # End :SearchAzureRG while($true)
        Return                                                                              # Returns to calling function with $null
    }                                                                                       # End begin statement
}                                                                                           # End function SearchAzResourceGroup
function SearchAzResourceGroupName {                                                        # Function to search for resource group by name
    Begin {                                                                                 # Begin function
        :SearchAzureRGByName while($true) {                                                 # Outer loop for managing function
            Write-Host "Resource Group Search By Name"                                      # Write message to screen
            Write-Host "[1] Search by resource name"                                        # Write message to screen
            Write-Host "[2] Search by group name"                                           # Write message to screen
            $OperatorSearchOption = Read-Host "Option?"                                     # Operator input for search method
            if ($OperatorSearchOption -eq 'exit') {                                         # If $OperatorSearchOption equals 'exit'
                Break SearchAzureRGByName                                                   # Breaks :SearchAzureRGByName
            }                                                                               # End if ($OperatorSearchOption -eq 'exit')
            elseif ($OperatorSearchOption -eq '1') {                                        # Else if $OperatorSearchOption equals '1' 
                :SearchAzureRSName while ($true) {                                          # Inner loop for finding resource group off partial resource name inputs
                    Write-Host "Search by resource name"                                    # Write message to screen
                    $RSObjectInput = Read-Host "Parital resource name"                      # Operator input for $RSObjectInput
                    if ($RSObjectInput -eq 'exit') {                                        # If $RSObjectInput equals 'exit'
                        Break SearchAzureRSName                                             # Breaks :SearchAzureRSName
                    }                                                                       # End if ($RSObjectInput -eq 'exit')
                    $RSObjectInput = "*"+$RSObjectInput+"*"                                 # Adds wildcards to $RSObjectInput
                    $RSObject = Get-AzResource | Where-Object `
                        {$_.Name -Like $RSObjectInput}                                      # Performs search and assigns any matching resources to $RSObject
                    if ($RSObject) {                                                        # If statement if $RSObject value is found
                        if ($RSObject.count -gt 1) {                                        # If statement if more than one $RSObject value found
                            Write-Host "More than one value found"                          # Write message to screen
                            Write-Host " "                                                  # Write message to screen
                            Write-host $RSObject.name -Separator `n                         # Write message to screen
                            Write-Host " "                                                  # Write message to screen
                            $RSObject = $null                                               # Clears $RSObject, restarting :SearchAzureRSName loop
                        }                                                                   # End if ($RSObject.count -gt 1)
                        else {                                                              # If statement for single $RSObject value
                            $RGObject = Get-AzResourceGroup -Name `
                                $RSObject.ResourceGroupName                                 # Gets $RGObject using $RSObject.ResourceGroupName
                            $RSObject = $null                                               # Sets $RSObject as $null
                            Return $RGObject                                                # Returns $RGObject to calling function
                        }                                                                   # End else (if ($RSObject.count -gt 1))
                    }                                                                       # End if ($RSObject)
                    else {                                                                  # Else statment for no $RSObject value found
                        Write-Host ''                                                       # Write message to screen
                        Write-Host "No resource found that matches"                         # Write message to screen
                        Write-Host "Please try again"                                       # Write message to screen
                        Write-Host ''                                                       # Write message to screen
                    }                                                                       # End else (if ($RSObject))
                }                                                                           # End :SearchAzureRSName while ($true)
            }                                                                               # End elseif ($OperatorSearchOption -eq '1')
            elseif ($OperatorSearchOption -eq '2') {                                        # Else if $OperatorSearchOption equals '2' 
                :SearchAzureRGName while ($true) {                                          # Inner loop for finding a resource group of partial group name match
                    Write-Host "Search by resource group name"                              # Write message to screen
                    $RGObjectInput = Read-Host "Parital resource group name"                # Operator input for $RGObjectInput
                    if ($RGObjectInput -eq 'exit') {                                        # If $RGObjectInput equals 'exit'
                        Break SearchAzureRGName                                             # Breaks :SearchAzureRGName 
                    }                                                                       # End if ($RGObjectInput -eq 'exit')
                    $RGObjectInput = "*"+$RGObjectInput+"*"                                 # Adds wildcards to $RGObjectInput
                    $RGObject = Get-AzResourceGroup | Where-Object `
                        {$_.ResourceGroupName -Like $RGObjectInput}                         # Pulls a list of all resources groups with a name like $RGObjectInput
                    if ($RGObject) {                                                        # If statement if $RGObject value is found
                        if ($RGObject.count -gt 1) {                                        # If statement if more than one $RGObject value found
                            Write-Host "More than one value found"                          # Write message to screen
                            Write-Host ''                                                   # Write message to screen
                            Write-host $RGObject.ResourceGroupName -Separator `n            # Write message to screen
                            Write-Host ''                                                   # Write message to screen
                            $RGObject = $null                                               # Clears $RGObject, restarting :SearchAzureRGName loop
                        }                                                                   # End if ($RGObject.count -gt 1)
                        else {                                                              # If statement for single $RGObject value
                            Return $RGObject                                                # Returns $RGObject to calling function
                        }                                                                   # else (if ($RGObject.count -gt 1))
                    }                                                                       # End if ($RGObject)
                    else {                                                                  # Else statment for no $RGObject value found
                        Write-Host ''                                                       # Write message to screen
                        Write-Host "No resource groups found that matches"                  # Write message to screen
                        Write-Host "Please try again"                                       # Write message to screen
                        Write-Host ''                                                       # Write message to screen
                    }                                                                       # End else (if ($RGObject))
                }                                                                           # End :SearchAzureRGName while ($true)
            }                                                                               # End elseif ($OperatorSearchOption -eq '1')
            else {                                                                          # All other inputs for $OperatorSearchOption
                Write-Host 'That was not a valid option'                                    # Write message to screen
            }                                                                               # End else (if ($OperatorSearchOption -eq 'exit'))
        }                                                                                   # End :SearchAzureRGByName while($true)
        Return                                                                              # Returns to calling function with $null
    }                                                                                       # End begin
}                                                                                           # End function SearchAzResourceGroupName
function SearchAzResourceGroupType {                                                        # Function to search for resource group by resource provider or type
    Begin {                                                                                 # Begin function
        :SearchAzureRGByType while($True) {                                                 # Outer loop for manaing function
            $ProviderList = Get-AzResourceProvider | select-object ProviderNamespace        # Collects all current Azure resource provider names
            $ListNumber = 1                                                                 # Sets $ListNumber to '1'
            [System.Collections.ArrayList]$ListArray = @()                                  # Creates the $ListArray
            foreach ($_ in $ProviderList) {                                                 # For each $_ in $ProviderList
                $ListInput = [PSCustomObject]@{'Name' = $_.ProviderNamespace; `
                    'Number' = $ListNumber}                                                 # Creates the item to loaded into array
                $ListArray.Add($ListInput) | Out-Null                                       # Loads item into array, out-null removes write to screen
                $ListNumber = $ListNumber + 1                                               # Increments $ListNumber by 1
            }                                                                               # End foreach ($_ in $ProviderList)
            Write-Host "Resource Group Search By Resource Type"                             # Write message to screen
            Write-Host "[1] Search by provider type"                                        # Write message to screen
            Write-Host "[2] Search by resource type"                                        # Write message to screen
            $OperatorSearchOption = Read-Host 'Search option [#]'                           # Operator input for $OperatorSearchOption
            if ($OperatorSearchOption -eq 'exit') {                                         # If $OperatorSearchOption equals 'exit'
                Break SearchAzureRGByType                                                   # Breaks :SearchAzureRGByType
            }                                                                               # End if ($OperatorSearchOption -eq 'exit')
            elseif ($OperatorSearchOption -eq '1') {                                        # Else if $OperatorSearchOption equals '1'
                :SearchAzureRSProvider while($True) {                                       # Inner loop to find a resource group off resource provider
                    $RPObject = $null                                                       # Clears $RPObject
                    $RGObject = $null                                                       # Clears $RGObject
                    $RSObject = $null                                                       # Clears $RSObject
                    Write-Host '[0] Exit'                                                   # Write message to screen
                    foreach ($_ in $ListArray) {                                            # For each item in $ListArray
                        $Number = $_.Number                                                 # $Number is equal to current item .Number
                        Write-Host "[$Number]" $_.Name                                      # Write message to screen
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
                                'Number' = $ListNumber}                                     # Creates the item to loaded into array
                            $ListArray.Add($ListInput) | Out-Null                           # Loads item into array, out-null removes write to screen
                            $ListNumber = $ListNumber + 1                                   # Increments $ListNumber by 1
                        }                                                                   # End foreach ($_ in $RSObject)
                        :SelectAzureRSObject while ($True) {                                # Inner loop for selecting a resource from a list
                            Write-Host '[0] Exit'                                           # Write message to screen
                            foreach ($_ in $ListArray) {                                    # For each item in $ListArray
                                $Number = $_.Number                                         # $Number is equal to current item.Number
                                Write-Host "[$Number]" $_.name                              # Write message to screen
                            }                                                               # End foreach ($_ in $ListArray)
                            $RSObjectInput = Read-Host 'Enter the [#] of the resource'      # Operator input to select the resource
                            if ($RSObjectInput -eq '0') {                                   # If $RSObjectInput equals '0'
                                Break SearchAzureRSProvider                                 # Breaks :SearchAzureRSProvider
                            }                                                               # End if ($RSObjectInput -eq '0')
                            elseif ($RSObjectInput -in $ListArray.Number) {                 # IF $RSObjectInput in $ListArray.Number
                                $RSObject = $ListArray | Where-Object `
                                    {$_.Number -eq $RSObjectInput}                          # $RSObject equals $ListArray where $RSObjectInput equals $ListArray.Number
                                $RSObject = Get-AzResource -Name $RSObject.Name             # Pulls the full resource object
                                $RGObject = Get-AzResourceGroup -Name `
                                    $RSObject.ResourceGroupName                             # Collects the resource group object containing $RSObject
                                Return $RGObject                                            # Returns $RGObject to calling function
                            }                                                               # End elseif ($RSObjectInput -in $ListArray.Number)
                            else {                                                          # All other inputs for $RSObjectInput
                                Write-Host 'That was not a valid input'                     # Write message to screen
                            }                                                               # End else (if ($RSObjectInput -eq '0'))
                        }                                                                   # End :SelectAzureRSObject while ($True)
                    }                                                                       # End if ($RSObject.count -gt 1) 
                    else {                                                                  # If $RSObject has a value and the count is not greater than '1'
                        $RGObject = Get-AzResourceGroup -Name $RSObject.ResourceGroupName   # Collects the resource group object containing $RSObject
                        Return $RGObject                                                    # Returns $RGObject to calling function
                    }                                                                       # End else (if ($RSObject.count -gt 1))
                }                                                                           # End :SearchAzureRSProvider while ($True)
            }                                                                               # End elseif ($OperatorSearchOption -eq '1')
            elseif ($OperatorSearchOption -eq '2') {                                        # Else if $OperatorSearchOption equals
                :SearchAzureRSProvider while($True) {                                       # Inner loop to find a resource group off resource types
                    $RPObject = $null                                                       # Clears $RPObject
                    $RPTObject = $null                                                      # Clears $RPTObject
                    $RGObject = $null                                                       # Clears $RGObject
                    $RSObject = $null                                                       # Clears $RSObject
                    Write-Host '[0] Exit'                                                   # Write message to screen
                    foreach ($_ in $ListArray) {                                            # For each item in $ListArray
                        $Number = $_.Number                                                 # $Number is equal to current item .Number
                        Write-Host "[$Number]" $_.Name                                      # Write message to screen
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
                        $Number = $_.Number                                                 # $Number equals current item .Number
                        Write-Host "[$Number]" $_.name                                      # Write message to screen
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
                                'Number' = $ListNumber}                                     # Creates the item to loaded into array
                            $ListArray.Add($ListInput) | Out-Null                           # Loads item into array, out-null removes write to screen
                            $ListNumber = $ListNumber + 1                                   # Increments $ListNumber by 1
                        }                                                                   # End foreach ($_ in $RSObject)
                        :SelectAzureRSObject while ($True) {                                # Inner loop for selecting a resource from a list
                            Write-Host '[0] Exit'                                           # Write message to screen
                            foreach ($_ in $ListArray) {                                    # For each item in $ListArray
                                $Number = $_.Number                                         # $Number is equal to current item.Number
                                Write-Host "[$Number]" $_.name                              # Write message to screen
                            }                                                               # End foreach ($_ in $ListArray)
                            $RSObjectInput = Read-Host 'Enter the [#] of the resource'      # Operator input to select the resource
                            if ($RSObjectInput -eq '0') {                                   # If $RSObjectInput equals '0'
                                Break SearchAzureRSProvider                                 # Breaks :SearchAzureRSProvider
                            }                                                               # End if ($RSObjectInput -eq '0')
                            elseif ($RSObjectInput -in $ListArray.Number) {                 # If $RSObjectInput in $ListArray.Number
                                $RSObject = $ListArray | Where-Object `
                                    {$_.Number -eq $RSObjectInput}                          # $RSObject equals $ListArray where $RSObjectInput equals $ListArray.Number
                                $RSObject = Get-AzResource -Name $RSObject.Name             # Pulls the full resource object
                                $RGObject = Get-AzResourceGroup -Name `
                                    $RSObject.ResourceGroupName                             # Collects the resource group object containing $RSObject
                                Return $RGObject                                            # Returns $RGObject to calling function
                            }                                                               # End elseif ($RSObjectInput -in $ListArray.Number)
                            else {                                                          # All other inputs for $RSObjectInput
                                Write-Host 'That was not a valid input'                     # Write message to screen
                            }                                                               # End else (if ($RSObjectInput -eq '0'))
                        }                                                                   # End :SelectAzureRSObject while ($True)
                    }                                                                       # End if ($RSObject.count -gt 1) 
                    else {                                                                  # If $RSObject has a value and the count is not greater than '1'
                        $RGObject = Get-AzResourceGroup -Name $RSObject.ResourceGroupName   # Collects the resource group object containing $RSObject
                        Return $RGObject                                                    # Returns $RGObject to calling function
                    }                                                                       # End else (if ($RSObject.count -gt 1))
                }                                                                           # End :SearchAzureRSProvider while ($True)
            }                                                                               # End elseif ($OperatorSearchOption -eq '2')
            else {                                                                          # All other inputs for if $OperatorSearchOption
                Write-Host 'That was not a valid option'                                    # Write message to screen
            }                                                                               # End else (if ($OperatorSearchOption -eq 'exit'))
        }                                                                                   # End :SearchAzRGByType while ($true)
        Return                                                                              # Returns to calling function with $null
    }                                                                                       # End begin statement
}                                                                                           # End SearchAzResourceGroupType
function SearchAzResourceGroupLoc {                                                         # Function to search for a resource group by resource or group location
    Begin {                                                                                 # Begin function
        :SearchAzureByLoc while ($true) {                                                   # Outer loop for managing function
            if (!$LocationObject) {                                                         # If $LocationObject does not have a value
                $CallingFunction = 'SearchAzResourceGroupLoc'                               # Creates $CallingFunction
                $LocationObject = GetAzLocation ($CallingFunction)                          # Calls function and assigns output to $var
                if (!$LocationObject) {                                                     # If $LocationObject does not have a value
                    Break SearchAzureByLoc                                                  # End Break SearchAzureByLoc
                }                                                                           # End (Inner) if (!$LocationObject)
            }                                                                               # End (Outer) if (!$LocationObject)
            Write-Host '[0] Exit'                                                           # Write message to screen
            Write-Host '[1] Find Resource'                                                  # Write message to screen
            Write-Host '[2] Find Resource Group'                                            # Write message to screen
            $OperatorSelect = Read-Host 'Enter option [#]'                                  # Operator input for the search option
            if ($OperatorSelect -eq '0') {                                                  # If $OperatorSelect equals '0'
                Break SearchAzureByLoc                                                      # End Break SearchAzureByLoc
            }                                                                               # End if ($OperatorSelect -eq '0')
            elseif ($OperatorSelect -eq '1') {                                              # Else if $OperatorSelect equals '1'
                $RSList = Get-AzResource | Where-Object `
                    {$_.Location -eq $LocationObject.Location}                              # Gets a list of all resources within the $LocationObject.Location
                if (!$RSList) {                                                             # If $RSList is $null
                    Write-Host 'No resource found'                                          # Write message to screen
                    Break SearchAzureByLoc                                                  # End Break SearchAzureByLoc
                }                                                                           # End if (!$RSList)
                elseif ($RSList.Count -gt 1) {                                              # If $RSList.Count greater than 1
                    $ListNumber = 1                                                         # Sets $ListNumber to 1
                    [System.Collections.ArrayList]$ListArray = @()                          # Creates the $ListArray
                    foreach ($_ in $RSList) {                                               # For each $_ in $RSList
                        $ListInput = [PSCustomObject]@{'Name' = $_.Name; `
                            'Number'=$ListNumber;'RG'=$_.ResourceGroupName}                 # Creates the item to loaded into array
                        $ListArray.Add($ListInput) | Out-Null                               # Loads item into array, out-null removes write to screen
                        $ListNumber = $ListNumber + 1                                       # Increments $ListNumber by 1
                    }                                                                       # End foreach ($_ in $ProviderList)
                    Write-Host '[0] Exit'                                                   # Write message to screen
                    foreach ($_ in $ListArray) {                                            # For each item in $ListArray
                        $Number = $_.number                                                 # $Number equals current item .Number
                        Write-Host "[$Number]" $_.Name $_.RG                                # Write message to screen
                    }                                                                       # End foreach ($_ in $ListArray)
                    :SelectAzureResource while ($true) {                                    # Inner loop for selecting a resource from list
                        $OperatorSelect = Read-Host 'Enter the resource [#]'                # Operator input to select the resource
                        if ($OperatorSelect -eq '0') {                                      # If $OperatorSelect equals '0'
                        Break SearchAzureByLoc                                              # End Break SearchAzureByLoc
                        }                                                                   # End if ($OperatorSelect -eq '0')
                        elseif ($OperatorSelect -in $ListArray.Number) {                    # Else if $OperatorSelect -in $ListArray.Number
                            $RGObject = $ListArray | Where-Object `
                                {$_.Number -eq $OperatorSelect}                             # $RGObject equals $ListArray where $OperatorSelect equals $ListArray.Number
                            $RGObject = Get-AzResourceGroup -name $RGObject.RG              # Pulls the full resource group object
                            Return $RGObject                                                # Returns to calling function with $RGObject
                        }                                                                   # End elseif ($OperatorSelect -in $ListArray.Number)
                        else {                                                              # All other inputs for $OperatorSelect
                            Write-Host 'That was not a valid option'                        # Write message to screen
                        }                                                                   # End else (if ($OperatorSelect -eq '0'))
                    }                                                                       # End :SelectAzureResource while ($true) 
                }                                                                           # End elseif ($RSList.Count -gt 1)
                else {                                                                      # If $RSList has only a single item
                    $RGObject = Get-AzResourceGroup -name $RSList.ResourceGroupName         # Pulls the full resource group object
                    Return $RGObject                                                        # Returns to calling function with $RGObject
                }                                                                           # End else (if (!$RSList))
            }                                                                               # End elseif ($OperatorSelect -eq '1')
            elseif ($OperatorSelect -eq '2') {                                              # Else if $OperatorSelect equals '2'
                $RGList = Get-AzResourceGroup | Where-Object `
                    {$_.Location -eq $LocationObject.Location}                              # Gets a list of all resources within the $LocationObject.Location
                if (!$RGList) {                                                             # If $RGList is $null
                    Write-Host 'No resource groups found'                                   # Write message to screen
                    Break SearchAzureByLoc                                                  # End Break SearchAzureByLoc
                }                                                                           # End if (!$RGList)
                elseif ($RGList.Count -gt 1) {                                              # If $RGList.Count greater than 1
                    $ListNumber = 1                                                         # Sets $ListNumber to 1
                    [System.Collections.ArrayList]$ListArray = @()                          # Creates the $ListArray
                    foreach ($_ in $RGList) {                                               # For each $_ in $RGList
                        $ListInput = [PSCustomObject]@{'RG'=$_.ResourceGroupName; `
                            'Number'=$ListNumber}                                           # Creates the item to loaded into array
                        $ListArray.Add($ListInput) | Out-Null                               # Loads item into array, out-null removes write to screen
                        $ListNumber = $ListNumber + 1                                       # Increments $ListNumber by 1
                    }                                                                       # End foreach ($_ in $ProviderList)
                    Write-Host '[0] Exit'                                                   # Write message to screen
                    foreach ($_ in $ListArray) {                                            # For each item in $ListArray
                        $Number = $_.number                                                 # $Number equals current item .Number
                        Write-Host "[$Number]" $_.RG                                        # Write message to screen
                    }                                                                       # End foreach ($_ in $ListArray)
                    :SelectAzureRG while ($true) {                                          # Inner loop for selecting a resource from list
                        $OperatorSelect = Read-Host 'Enter the resource group [#]'          # Operator input to select the resource
                        if ($OperatorSelect -eq '0') {                                      # If $OperatorSelect equals '0'
                        Break SearchAzureByLoc                                              # End Break SearchAzureByLoc
                        }                                                                   # End if ($OperatorSelect -eq '0')
                        elseif ($OperatorSelect -in $ListArray.Number) {                    # Else if $OperatorSelect -in $ListArray.Number
                            $RGObject = $ListArray | Where-Object `
                                {$_.Number -eq $OperatorSelect}                             # $RGObject equals $ListArray where $OperatorSelect equals $ListArray.Number
                            $RGObject = Get-AzResourceGroup -name $RGObject.RG              # Pulls the full resource group object
                            Return $RGObject                                                # Returns to calling function with $RGObject
                        }                                                                   # End elseif ($OperatorSelect -in $ListArray.Number)
                        else {                                                              # All other inputs for $OperatorSelect
                            Write-Host 'That was not a valid option'                        # Write message to screen
                        }                                                                   # End else (if ($OperatorSelect -eq '0'))
                    }                                                                       # End :SelectAzureRG while ($true) 
                }                                                                           # End elseif ($RGList.Count -gt 1)
                else {                                                                      # If $RGList has only a single item
                    $RGObject = Get-AzResourceGroup -name $RGList.Name                      # Pulls the full resource group object
                    Return $RGObject                                                        # Returns to calling function with $RGObject
                }                                                                           # End else (if (!$RGList))
            }                                                                               # End elseif ($OperatorSelect -eq '2')
            else {                                                                          # All other inputs for $OperatorSelect 
                Write-Host 'That was not a valid option'                                    # Write message to screen
            }                                                                               # End else (if ($OperatorSelect -eq '0'))
        }                                                                                   # End :SearchAzureByLoc while ($true) 
        Return                                                                              # Returns to calling function with $null
    }                                                                                       # End begin
}                                                                                           # End SearchAzResourceGroupLoc
function SearchAzResourceGroupTag { # Searchs for resource group using tag matches on the group, or a contained resource
    Begin {
        $ErrorActionPreference='silentlyContinue' # Disables Errors
        $ValidTagName = Get-AzTag # Collects the list of all existing tags
        :SearchAzureRGByTag while($true) { # :SearchAzureRGByTag loop finds a resource group off tag values
            Write-Host "Resource Group Search By Tag" # Write message to screen
            Write-Host "1 Search by resource tag" # Write message to screen
            Write-Host "2 Search by group tag" # Write message to screen
            $OperatorSearchOption = Read-Host "Option?" # Operator input for $OperatorSearchOption
            if ($OperatorSearchOption -eq 'exit') { # Ends SearchAzureRGByTag loop if operator types exit
                Break SearchAzureRGByTag # Breaks the SearchAzureRGByTag loop
            } # End exit if statement
            elseif ($OperatorSearchOption -eq '1') { # Elseif statement for search by resource Tag
                :SearchAzureRSTag while ($true) { # :SearchAzureRSTag loop finds resource group off Tag
                    Write-Host "Search by resource Tag" # Write message to screen
                    $TagNameInput = $null # Clears $var from previous use
                    $TagValueInput = $null # Clears $var from previous use
                    $RSObject = $null # Clears $var from previous use
                    $RGObject = $null # Clears $var from previous use
                    :SetTagName while ($true) { # Loop for getting and verifing $TagNameInput
                        $TagNameInput = Read-Host "Resource Tag" # Operator input for the Tag
                        if ($TagNameInput -eq 'exit') { # If statement to end this function
                            Break SearchAzureRSTag # Ends :SearchAzureRSTag loop, returns to :SearchAzureRGByTag loop
                        } # End if ($TagNameInput -eq 'exit')
                        elseif ($TagNameInput -iin $ValidTagName.Name) { # Validates $TagNameInput against $ValidTagName
                            Break SetTagName # End :SetTagName while ($true) 
                        } # End elseif statment
                        else { # Else statement for $TagNameInput not matching anything in $ValidTagName
                            Write-Host "The tag name provided is not valid, please chose from the following" # Error reporting to the screen
                            Write-Host $ValidTagName.Name -Separator `n # Outputs the valid Tag lists
                        } # End else statement
                    } # End :SetTagName while ($true)
                    $OperatorSearchOption = Read-Host "Include a tag value in search" # Operator input for searching just by tag name, or adding a tag value
                    if ($OperatorSearchOption -eq 'y' -or $OperatorSearchOption -eq 'yes') { # If statement for adding a tag value
                        :SetTagValue while ($true) { # :SetTagValue while loop, used to verify that the value is an available option on the tag name
                            $ValidTagValue = (Get-AzTag -Name $TagNameInput).values # Gets all tag values under the tag name $TagNameInput
                            $TagValueInput = Read-Host "Tag value" # Operator input for the tag value
                            if ($TagValueInput -eq 'exit') { # If statement to end this function
                                Break SearchAzureRSTag # Ends :SearchAzureRSTag loop, returns to :SearchAzureRGByTag loop
                            } # End if ($TagValueInput -eq 'exit')
                            elseif ($TagValueInput -iin $ValidTagValue.Name) { # elseif statement if $TagValueInput is in the list of $ValidTagValue
                                Break SetTagValue # Breaks out of :SetTagValue loop
                            } # End elseif ($TagValueInput -iin $ValidTagValue.Name)
                            else { # Else statement for $TagValueInput not matching anything in $ValidTagValue
                                Write-Host "The tag value provided is not valid, please chose from the following" # Error reporting to the screen
                                Write-Host $ValidTagValue.Name -Separator `n # Outputs the valid Tag lists
                            } # End else statement
                        } # End :SetTagValue while ($true) 
                    } # End if ($OperatorSearchOption -eq 'y' -or $OperatorSearchOption -eq 'yes') 
                    if ($TagValueInput) { # If statement for $TagValueInput having a value
                        $RSObject = Get-AzResource -TagName $TagNameInput -TagValue $TagValueInput # Collects all resource objects where tag name and value matches $TagNameInput and TagValueInput
                    } # End if ($TagValueInput)
                    else {  # Else statement for $TagValueInput not having a value
                        $RSObject = Get-AzResource -TagName $TagNameInput # Collects all resource objects where tag name matches $TagNameInput
                    } # End else if (($TagValueInput))
                    if (!$RSObject) { # If statement if no resources match the resource tag name
                        Write-Host "No resources found for the Tag name"$TagNameInput # Write message to screen
                        Break SearchAzureRSTag # Ends :SearchAzureRSTag loop, returns to :SearchAzureRGByTag loop
                    } # End if (!$RSObject)
                    :SelectAzureRSObject while ($true) { # :SelectAzureRSObject loop for narrowing down matching resources
                        if ($RSObject.count -gt 1) { # If statement if more than 1 resource matches the resource tag
                            if ($TagValueInput) { # If statement removes the option to narrow search using tag value if a tag value input has already been provided
                                Write-Host "Multiple resources found" # Write message to screen
                                Write-Host $RSObject.Name -Separator `n # Writes list of all resource names to screen
                                $OperatorSearchOption  = '2' # Sets follow up search option to use the resource name
                            } # End if ($TagValueInput) 
                            else { # else statement for $TagValueInput not having a value
                                Write-Host "Multiple resources found" # Write message to screen
                                Write-Host $RSObject.Name -Separator `n # Writes list of all resource names to screen
                                Write-Host "1 Narrow search using tag value" # Write message to screen
                                Write-Host "2 Narrow Search using resource name" # Write message to screen
                                $OperatorSearchOption = Read-Host "Option?" # Operator input for $OperatorSearchOption
                            } # End else if ($TagValueInput)
                            if ($OperatorSearchOption -eq 'exit') { # If statement for exiting :SearchAzureRSTag
                                Break SearchAzureRSTag # Ends :SearchAzureRSTag loop, returns to :SearchAzureRGByTag loop
                            } # End if ($OperatorSearchOption -eq 'exit')
                            elseif ($OperatorSearchOption -eq '1') { # Elseif statement for narrowing search by adding a tag value
                                $TagValueInput = Read-Host "Tag value" # Operator input for $TagValueInput
                                $RSObject = Get-AzResource -TagName $TagNameInput -TagValue $TagValueInput # Collects $RSObject with additional search values
                            } # End elseif ($OperatorSearchOption -eq '1')
                            elseif ($OperatorSearchOption -eq '2') { # Elseif statement for narrowing search by adding a resource name
                                $RSObjectInput = Read-Host "Resource name" # Operator inout for the resource name
                                if ($RSObjectInput -eq 'exit') { # If statement for exiting :SearchAzureRSTag
                                    Break SearchAzureRSTag # Ends :SearchAzureRSTag loop, returns to :SearchAzureRGByTag loop
                                } # End if ($RSObjectInput -eq 'exit')
                                $RSObjectInput = "*"+$RSObjectInput+"*" # Adds wildcards to $RSObjectInput
                                $RSObject = Get-AzResource -TagName $TagNameInput | Where-Object {$_.Name -like $RSObjectInput} # Collects $RSObject again using the narrower search options
                            } # End elseif ($OperatorSearchOption -eq '2')
                        } # End if ($RSObject.count -gt 1)
                        elseif ($RSObject.count -eq 1) { # elseif statement for a single matching resource object
                            $RGObject = Get-AzResourceGroup -Name $RSObject.ResourceGroupName # Collects the resource group object containing $RSObject
                            Write-Host "Returning with RGObject" # Write message to screen
                            Return $RGObject # Returns $RGObject to calling function # Returns $RGObject to calling function
                        } # End if ($RSObject.count -eq 1) 
                    } # End :SelectAzureRSObject while ($True)
                } # End :SearchAzureRSTag loop
            } # End else if statment for $OperatorSearchOption -eq '1'
            elseif ($OperatorSearchOption -eq '2') {  # Elseif statement for search by resource group name
                :SearchAzureRGTag while ($true) { # :SearchAzureRGTag loop finds resource group off Tag
                    Write-Host "Search by resource group Tag" # Write message to screen
                    $TagNameInput = $null # Clears $var from previous use
                    $TagValueInput = $null # Clears $var from previous use
                    $RGObject = $null # Clears $var from previous use
                    :SetTagName while ($true) { # Loop for getting and verifing $TagNameInput
                        $TagNameInput = Read-Host "Resource Tag" # Operator input for the Tag
                        if ($TagNameInput -eq 'exit') { # If statement to end this function
                            Break SearchAzureRSTag # Ends :SearchAzureRGTag loop, returns to :SearchAzureRGByTag loop
                        } # End if ($TagNameInput -eq 'exit')
                        elseif ($TagNameInput -iin $ValidTagName.Name) { # Validates $TagNameInput against $ValidTagName
                            Break SetTagName # End :SetTagName while ($true) 
                        } # End elseif statment
                        else { # Else statement for $TagNameInput not matching anything in $ValidTagName
                            Write-Host "The tag name provided is not valid, please chose from the following" # Error reporting to the screen
                            Write-Host $ValidTagName.Name -Separator `n # Outputs the valid Tag lists
                        } # End else statement
                    } # End :SetTagName while ($true)
                    $OperatorSearchOption = Read-Host "Include a tag value in search" # Operator input for searching just by tag name, or adding a tag value
                    if ($OperatorSearchOption -eq 'y' -or $OperatorSearchOption -eq 'yes') { # If statement for adding a tag value
                        :SetTagValue while ($true) { # :SetTagValue while loop, used to verify that the value is an available option on the tag name
                            $ValidTagValue = (Get-AzTag -Name $TagNameInput).values # Gets all tag values under the tag name $TagNameInput
                            $TagValueInput = Read-Host "Tag value (Case sensitive)" # Operator input for the tag value
                            if ($TagValueInput -eq 'exit') { # If statement to end this function
                                Break SearchAzureRSTag # Ends :SearchAzureRGTag loop, returns to :SearchAzureRGByTag loop
                            } # End if ($TagValueInput -eq 'exit')
                            elseif ($TagValueInput -cin $ValidTagValue.Name) { # elseif statement if $TagValueInput is in the list of $ValidTagValue
                                Break SetTagValue # Breaks out of :SetTagValue loop
                            } # End elseif ($TagValueInput -iin $ValidTagValue.Name)
                            else { # Else statement for $TagValueInput not matching anything in $ValidTagValue
                                Write-Host "The tag value provided is not valid, please chose from the following" # Error reporting to the screen
                                Write-Host $ValidTagValue.Name -Separator `n # Outputs the valid Tag lists
                            } # End else statement
                        } # End :SetTagValue while ($true) 
                    } # End if ($OperatorSearchOption -eq 'y' -or $OperatorSearchOption -eq 'yes') 
                    if ($TagValueInput) { # If statement for $TagValueInput having a value
                        $RGObject = Get-AzResourceGroup -Tag @{$TagNameInput=$TagValueInput} # Collects all resource group objects where tag name and value matches $TagNameInput and TagValueInput
                    } # End if ($TagValueInput)
                    else {  # Else statement for $TagValueInput not having a value
                        $RGObject = Get-AzResourceGroup -Tag @{$TagNameInput=""} # Collects all resource objects where tag name matches $TagNameInput
                    } # End else if (($TagValueInput))
                    if (!$RGObject) { # If statement if no resources match the resource group tag name
                        Write-Host "No resource groups found for the Tag name"$TagNameInput # Write message to screen
                        Break SearchAzureRGTag # Ends :SearchAzureRGTag loop, returns to :SearchAzureRGByTag loop
                    } # End if (!$RGObject)
                    :GetAzureRGObject while ($true) { # :GetAzureRGObject loop for narrowing down matching resource groups
                        if ($RGObject.count -gt 1) { # If statement if more than 1 resource groups matche the resource group tag
                            if ($TagValueInput) { # If statement removes the option to narrow search using tag value if a tag value input has already been provided
                                Write-Host "Multiple resource groups found" # Write message to screen
                                Write-Host $RGObject.ResourceGroupName -Separator `n # Writes list of all resource group names to screen
                                $OperatorSearchOption  = '2' # Sets follow up search option to use the resource name
                            } # End if ($TagValueInput) 
                            else { # else statement for $TagValueInput not having a value
                                Write-Host "Multiple resources found" # Write message to screen
                                Write-Host $RGObject.ResourceGroupName -Separator `n # Writes list of all resource names to screen
                                Write-Host "1 Narrow search using tag value" # Write message to screen
                                Write-Host "2 Narrow Search using resource group name" # Write message to screen
                                $OperatorSearchOption = Read-Host "Option?" # Operator input for $OperatorSearchOption
                            } # End else if ($TagValueInput)
                            if ($OperatorSearchOption -eq 'exit') { # If statement for exiting :SearchAzureRSTag
                                Break SearchAzureRGTag # Ends :SearchAzureRGTag loop, returns to :SearchAzureRGByTag loop
                            } # End if ($OperatorSearchOption -eq 'exit')
                            elseif ($OperatorSearchOption -eq '1') { # Elseif statement for narrowing search by adding a tag value
                                :SetTagValue while ($true) { # :SetTagValue while loop, used to verify that the value is an available option on the tag name
                                    $ValidTagValue = (Get-AzTag -Name $TagNameInput).values # Gets all tag values under the tag name $TagNameInput
                                    $TagValueInput = Read-Host "Tag value (Case sensitive)" # Operator input for the tag value
                                    if ($TagValueInput -eq 'exit') { # If statement to end this function
                                        Break SearchAzureRSTag # Ends :SearchAzureRGTag loop, returns to :SearchAzureRGByTag loop
                                    } # End if ($TagValueInput -eq 'exit')
                                    elseif ($TagValueInput -cin $ValidTagValue.Name) { # elseif statement if $TagValueInput is in the list of $ValidTagValue
                                        Break SetTagValue # Breaks out of :SetTagValue loop
                                    } # End elseif ($TagValueInput -iin $ValidTagValue.Name)
                                    else { # Else statement for $TagValueInput not matching anything in $ValidTagValue
                                        Write-Host "The tag value provided is not valid, please chose from the following" # Error reporting to the screen
                                        Write-Host $ValidTagValue.Name -Separator `n # Outputs the valid Tag lists
                                    } # End else statement
                                } # End :SetTagValue while ($true) 
                                $RGObject = Get-AzResourceGroup -Tag @{$TagNameInput=$TagValueInput} # Collects $RGObject with additional search values
                            } # End elseif ($OperatorSearchOption -eq '1')
                            elseif ($OperatorSearchOption -eq '2') { # Elseif statement for narrowing search by adding a resource group name
                                $RGObjectInput = Read-Host "Resource group name" # Operator input for the resource group name
                                if ($RGObjectInput -eq 'exit') { # If statement for exiting :SearchAzureRGTag
                                    Break SearchAzureRGTag # Ends :SearchAzureRGTag loop, returns to :SearchAzureRGByTag loop
                                } # End if ($RGObjectInput -eq 'exit')
                                $RGObjectInput = "*"+$RGObjectInput+"*" # Adds wildcards to $RGObjectInput
                                $RGObject = Get-AzResourceGroup -Tag @{$TagNameInput=""}  | Where-Object {$_.ResourceGroupName -like $RGObjectInput} # Collects $RGObject again using the narrower search options
                            } # End elseif ($OperatorSearchOption -eq '2')
                        } # End if ($RGObject.count -gt 1)
                        elseif ($RGObject.count -eq 1) { # elseif statement for a single matching resource group object
                            Write-Host "Returning with RGObject" # Write message to screen
                            Return $RGObject # Returns $RGObject to calling function # Returns $RGObject to calling function
                        } # End if ($RSObject.count -eq 1) 
                    } # End :SelectAzureRSObject while ($True)
                } # End :SearchAzureRGTag loop
            } # End else if statment for $OperatorSearchOption -eq '2'
        } # End :SearchAzureByTag while statement 
        Return # Returns to calling function empty if operator has used 'exit' options
    } # End begin statement
} # End SearchAzResourceGroupTag
# Addition required functions
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
                    Return $LocationObject                                                  # Returns $LocationObject to calling function
                }                                                                           # End elseif ($LocationSelect -in $ListArray.Number) 
                else {                                                                      # All other inputs for $LocationSelect
                    Write-Host "That was not a valid selection"                             # Write message to screen   
                }                                                                           # End else (if ($LocationSelect -eq '0'))
            }                                                                               # End :SelectAzureLocation while ($true)
        }                                                                                   # End :GetAzureLocation while ($true)
        Return                                                                              # Returns with $null 
    }                                                                                       # End Begin
}                                                                                           # End function GetAzLocation