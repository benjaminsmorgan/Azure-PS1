# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Mircosoft docs links
    Get-AzResourceGroup:        https://docs.microsoft.com/en-us/powershell/module/az.resources/get-azresourcegroup?view=azps-5.1.0
    Get-AzResource:             https://docs.microsoft.com/en-us/powershell/module/az.resources/get-azresource?view=azps-5.1.0
    Get-AzResourceProvider:     https://docs.microsoft.com/en-us/powershell/module/az.resources/get-azresourceprovider?view=azps-5.2.0
} #>
<# Required Functions Links: {
    None
} #>    
<# Function Description: {
    SearchAzResourceGroupType:  Searchs for resource group resource provider or type on a resource or resource group
} #>
<# Variables: {
    :SearchAzureRGByType        Outer loop for managing function
    :SearchAzureRSProvider      Inner loop for searching for resource by provider
    :SelectAzureRSProvider      Inner loop to select the provider
    :SelectAzureRSObject        Inner loop to select a resource if multiple matches are found
    :SelectAzureRPType          Inner loop to select the provider type
    $ProviderList:              List of all Azure providers
    $ListNumber:                $var used in $ListArray for selection
    $ListArray:                 Array used to list providers, types, and resources
    $ListInput:                 $var used to load info into $ListArray
    $OperatorSearchOption:      Operator input to select the search option
    $Number:                    $var used to show current item .number, used in formatting
    $RPObjectInput:             Operator input for the resource provider selection
    $RPObject:                  The name of the resource provider
    $RSObject:                  Resource object
    $RSObjectInput:             Operator input for selecting a resource from a list
    $RGObject:                  Resource group object
    $RPTObjectList:             List of all types under a resource provider
    $RPTObjectInput:            Operator input for selecting the type from list
    $RPTObject:                 The name of the resource provider type
} #>
<# Process Flow {
    Function
        Call SearchAzResourceGroupType > Get $RGObject
        End SearchAzResourceGroupType
            Return Function > Send $RGObject
}#>
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