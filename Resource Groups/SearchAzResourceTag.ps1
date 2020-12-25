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
} #>
<# Process Flow {
    Function
        Call SearchAzResourceTag  > Get $RSObject
        End SearchAzResourceTag
            Return Function > Send $RSObject
}#>
function SearchAzResourceTag { # Searchs for resource group using tag matches on the group, or a contained resource
    Begin {
        $ErrorActionPreference='silentlyContinue' # Disables Errors
        $ValidTagName = Get-AzTag # Collects the list of all existing tags
        :SearchAzureRSByTag while($true) { # :SearchAzureRSByTag loop finds a resource group off tag values
            :SearchAzureRSTag while ($true) { # :SearchAzureRSTag loop finds resource group off Tag
                Write-Host "Search by resource Tag" # Write message to screen
                $TagNameInput = $null # Clears $var from previous use
                $TagValueInput = $null # Clears $var from previous use
                $RSObject = $null # Clears $var from previous use
                :SetTagName while ($true) { # Loop for getting and verifing $TagNameInput
                    $TagNameInput = Read-Host "Resource Tag" # Operator input for the Tag
                    if ($TagNameInput -eq 'exit') { # If statement to end this function
                        Break SearchAzureRSByTag # Ends :SearchAzureRSByTag loop
                    } # End if ($TagNameInput -eq 'exit')
                    elseif ($TagNameInput -iin $ValidTagName.Name) { # Validates $TagNameInput against $ValidTagName
                        Break SetTagName # End :SetTagName while ($true) 
                    } # End elseif ($TagNameInput -iin $ValidTagName.Name)
                    else { # Else statement for $TagNameInput not matching anything in $ValidTagName
                        Write-Host "The tag name provided is not valid, please chose from the following" # Error reporting to the screen
                        Write-Host $ValidTagName.Name -Separator `n # Outputs the valid Tag lists
                    } # End if ($TagNameInput -eq 'exit')
                } # End :SetTagName while ($true)
                $OperatorSearchOption = Read-Host "Include a tag value in search" # Operator input for searching just by tag name, or adding a tag value
                if ($OperatorSearchOption -eq 'y' -or $OperatorSearchOption -eq 'yes') { # If statement for adding a tag value
                    :SetTagValue while ($true) { # :SetTagValue while loop, used to verify that the value is an available option on the tag name
                        $ValidTagValue = (Get-AzTag -Name $TagNameInput).values # Gets all tag values under the tag name $TagNameInput
                        $TagValueInput = Read-Host "Tag value" # Operator input for the tag value
                        if ($TagValueInput -eq 'exit') { # If statement to end this function
                            Break SearchAzureRSTag # Ends :SearchAzureRSTag loop, returns to :SearchAzureRSByTag loop
                        } # End if ($TagValueInput -eq 'exit')
                        elseif ($TagValueInput -iin $ValidTagValue.Name) { # elseif statement if $TagValueInput is in the list of $ValidTagValue
                            Break SetTagValue # Breaks out of :SetTagValue loop
                        } # End elseif ($TagValueInput -iin $ValidTagValue.Name)
                        else { # Else statement for $TagValueInput not matching anything in $ValidTagValue
                            Write-Host "The tag value provided is not valid, please chose from the following" # Error reporting to the screen
                            Write-Host $ValidTagValue.Name -Separator `n # Outputs the valid Tag lists
                        } # End else (if ($TagValueInput -eq 'exit'))
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
                    Break SearchAzureRSByTag # Ends :SearchAzureRSByTag loop
                } # End if (!$RSObject)
                :GetAzureRSObject while ($true) { # :GetAzureRSObject loop for narrowing down matching resources
                    if ($RSObject.count -gt 1) { # If statement if more than 1 resource matches the resource tag
                        if ($TagValueInput) { # If statement removes the option to narrow search using tag value if a tag value input has already been provided
                            Write-Host "Multiple resources found" # Write message to screen
                            $ForEachCount = 1 # Counter used in foreach statement
                            foreach ($Name in $RSObject) { # For each resource name in $RSObject
                                Write-Host "" # Write message to screen
                                Write-Host "Matching resource" $ForEachCount # Write message to screen
                                Write-Host "Resource Name: "$Name.Name # Write $RSObject name
                                Write-Host "Resource Group:"$Name.ResourceGroupName # Write $RSObject resource group name
                                $ForEachCount = $ForEachCount+1 # Adds 1 to $ForEachCount
                            } # End foreach ($Name in $RSObject)
                            Write-Host "" # Write message to screen
                            $OperatorSearchOption  = '2' # Sets follow up search option to use the resource name
                        } # End if ($TagValueInput) 
                        else { # else statement for $TagValueInput not having a value
                            Write-Host "Multiple resources found" # Write message to screen
                            $ForEachCount = 1 # Counter used in foreach statement
                            foreach ($Name in $RSObject) { # For each resource name in $RSObject
                                Write-Host "" # Write message to screen
                                Write-Host "Matching resource" $ForEachCount # Write message to screen
                                Write-Host "Resource Name: "$Name.Name # Write $RSObject name
                                Write-Host "Resource Group:"$Name.ResourceGroupName # Write $RSObject resource group name
                                $ForEachCount = $ForEachCount+1 # Adds 1 to $ForEachCount
                            } # End foreach ($Name in $RSObject)
                            Write-Host "" # Write message to screen
                            Write-Host "1 Narrow search using tag value" # Write message to screen
                            Write-Host "2 Narrow Search using resource name" # Write message to screen
                            $OperatorSearchOption = Read-Host "Option?" # Operator input for $OperatorSearchOption
                        } # End else if ($TagValueInput)
                        if ($OperatorSearchOption -eq 'exit') { # If statement for exiting :SearchAzureRSTag
                            Break SearchAzureRSTag # Ends :SearchAzureRSTag loop, returns to :SearchAzureRSByTag loop
                        } # End if ($OperatorSearchOption -eq 'exit')
                        elseif ($OperatorSearchOption -eq '1') { # Elseif statement for narrowing search by adding a tag value
                            $TagValueInput = Read-Host "Tag value" # Operator input for $TagValueInput
                            $RSObject = Get-AzResource -TagName $TagNameInput -TagValue $TagValueInput # Collects $RSObject with additional search values
                        } # End elseif ($OperatorSearchOption -eq '1')
                        elseif ($OperatorSearchOption -eq '2') { # Elseif statement for narrowing search by adding a resource name
                            $RSObjectInput = Read-Host "Resource name" # Operator inout for the resource name
                            if ($RSObjectInput -eq 'exit') { # If statement for exiting :SearchAzureRSTag
                                Break SearchAzureRSTag # Ends :SearchAzureRSTag loop, returns to :SearchAzureRSByTag loop
                            } # End if ($RSObjectInput -eq 'exit')
                            $RSObjectInput = "*"+$RSObjectInput+"*" # Adds wildcards to $RSObjectInput
                            $RGObjectInput = Read-Host "Resource group name" # Collects resource group name value to narrow selection
                            $RGObjectInput = "*"+$RGObjectInput+"*" # Adds wildcards to $RGObjectInput
                            $RSObject = Get-AzResource -TagName $TagNameInput | Where-Object {$_.Name -like $RSObjectInput -and $_.ResourceGroupName -like $RGObjectInput} # Collects $RSObject again using the narrower search options
                        } # End elseif ($OperatorSearchOption -eq '2')
                    } # End if ($RSObject.count -gt 1)
                    elseif ($RSObject.count -eq 1) { # elseif statement for a single matching resource object
                        Write-Host "Returning with RSObject" # Write message to screen
                        Return $RSObject # Returns $RSObject to calling function # Returns $RSObject to calling function
                    } # End if ($RSObject.count -eq 1) 
                } # End :GetAzureRSObject while ($True)
            } # End :SearchAzureRSTag while ($true)
        } # End :SearchAzureRSByTag while($true)
        Return # Returns to calling function empty if operator has used 'exit' options
    } # End begin statement
} # End SearchAzResourceTag