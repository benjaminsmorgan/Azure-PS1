# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Mircosoft docs links
    Get-AzResource:             https://docs.microsoft.com/en-us/powershell/module/az.resources/get-azresource?view=azps-5.1.0
    Get-AzLocation:             https://docs.microsoft.com/en-us/powershell/module/az.resources/get-azlocation?view=azps-5.2.0
} #>
<# Required Functions Links: {
    None
} #>    
<# Function Description: {
    SearchAzResourceLoc:        Searchs for resource using location matches on a resource
} #>
<# Variables: {
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
} #>
<# Process Flow {
    Function               
        Call SearchAzResourceLoc  > Get $RSObject
        End SearchAzResourceLoc
            Return Function > Send $RSObject
}#>
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