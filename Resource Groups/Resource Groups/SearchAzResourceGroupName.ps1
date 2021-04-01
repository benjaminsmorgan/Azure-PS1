# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Mircosoft docs links
    Get-AzResourceGroup:        https://docs.microsoft.com/en-us/powershell/module/az.resources/get-azresourcegroup?view=azps-5.1.0
    Get-AzResource:             https://docs.microsoft.com/en-us/powershell/module/az.resources/get-azresource?view=azps-5.1.0
} #>
<# Required Functions Links: {
    None
} #>    
<# Function Description: {
    SearchAzResourceGroupName:  Searchs for resource group using partial name matches on the group name, or a contained resource name
} #>
<# Variables: {
    :SearchAzureRGByName    Outer loop for manaing function
    :SearchAzureRSName      Inner loop for finding $RGObject using resource name
    :SearchAzureRGName      Inner loop for finding $RGObject
    $OperatorSearchOption:  Operator input for search option
    $RSObjectInput:         Operator input for the resource name
    $RSObject:              Resource object, used to get $RGObject
    $RGObjectInput:         Operator input for the resource group name
    $RGObject:              Resource group object, used for all actions
} #>
<# Process Flow {
    Function
        Call SearchAzResourceGroupName > Get $RGObject
            Return Function > Send $RGObject
}#>
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
            }                                                                               # End foreach ($_ in $RGList)
            Write-Host "0 Exit"                                                             # Write message to screen
            foreach ($_ in $ListArray) {                                                    # For each $_ in $ListArray
                $Number = $_.Number                                                         # Sets $Number to current item .Number
                Write-Host "[$Number]"$_.Name                                               # Write message to screen
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
                    Return $RSObject                                                        # Returns to calling function with $RGObject
                }                                                                           # End if ($RSSelect -in $ListArray)
                else {                                                                      # If $RGObject does not have a value
                    Write-Host "That was not a valid option"                                # Write message to screen
                }                                                                           # End else (if ($RGObject))
            }                                                                               # End :SelectAzureResource` while ($true)
        }                                                                                   # End :GetAzureResource while ($true)
    }                                                                                       # End begin statement
}                                                                                           # End function GetAzResourceGroup
function GetAzResourceGroup {                                                               # Function to get a resource group, can pipe $RGObject to another function
    Begin {                                                                                 # Begin function
        $ErrorActionPreference = 'silentlyContinue'                                         # Disables error reporting
        :GetAzureResourceGroup while ($true) {                                              # Outer loop for managing function
            $RGList = Get-AzResourceGroup                                                   # Gets all resource groups and assigns to $RGList
            $RGListNumber = 1                                                               # Sets $RGListNumber to 1
            [System.Collections.ArrayList]$RGListArray = @()                                # Creates the RG list array
            foreach ($_ in $RGList) {                                                       # For each $_ in $RGListList
                $RGListInput = [PSCustomObject]@{'Name' = $_.ResourceGroupName; `
                    'Number' = $RGListNumber; 'Location' = $_.Location}                     # Creates the item to loaded into array
                $RGListArray.Add($RGListInput) | Out-Null                                   # Loads item into array, out-null removes write to screen
                $RGListNumber = $RGListNumber + 1                                           # Increments $RGListNumber by 1
            }                                                                               # End foreach ($_ in $RGList)
            Write-Host "0 Exit"                                                             # Write message to screen
            foreach ($_ in $RGListArray) {                                                  # For each $_ in $RGListArray
                Write-Host $_.Number $_.Name "|" $_.Location                                # Writes RG number, name, and location to screen
            }                                                                               # End foreach ($_ in $RGListArray)
            :SelectAzureRGList while ($true) {                                              # Inner loop to select the resource group
                if ($CallingFunction) {                                                     # If $CallingFunction exists
                    Write-Host "You are selecting the resource group for"$CallingFunction   # Write message to screen
                }                                                                           # End if ($CallingFunction)
                $RGSelect = Read-Host "Enter the resource group number"                     # Operator input for the RG selection
                if ($RGSelect -eq '0') {                                                    # If $RGSelect equals 0
                    Break GetAzureResourceGroup                                             # Breaks :GetAzureResourceGroup
                }                                                                           # End if ($RGSelect -eq '0')
                $RGSelect = $RGListArray | Where-Object {$_.Number -eq $RGSelect}           # $RGSelect is equal to $RGArray where $RGArray.Number is equal to $RGSelect                                  
                $RGObject = Get-AzResourceGroup | Where-Object `
                    {$_.ResourceGroupName -eq $RGSelect.Name}                               # Pulls the full resource group object
                if ($RGObject) {                                                            # If $RGObject has a value
                    Return $RGObject                                                        # Returns to calling function with $RGObject
                }                                                                           # End if ($RGObject)
                else {                                                                      # If $RGObject does not have a value
                    Write-Host "That was not a valid option"                                # Write message to screen
                }                                                                           # End else (if ($RGObject))
            }                                                                               # End :SelectAzureRGList while ($true)
        }                                                                                   # End :GetAzureResourceGroup while ($true)
    }                                                                                       # End begin statement
}                                                                                           # End function GetAzResourceGroup