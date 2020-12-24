# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Mircosoft docs links
    Update-AzTag:               https://docs.microsoft.com/en-us/powershell/module/az.resources/update-aztag?view=azps-5.2.0             
    Get-AzResourceGroup:        https://docs.microsoft.com/en-us/powershell/module/az.resources/get-azresourcegroup?view=azps-5.1.0
} #>
<# Required Functions Links: {
    GetAzResourceGroup:         https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/GetAzResourceGroup.ps1
} #>
<# Functions Description: {
    RemoveAzResourceGroupTag:   Remove a named tag from a resource group
    GetAzResourceGroup:         Collects resource group object
} #>
<# RemoveAzResourceGroupTag { 
    :RemoveAzureRGTag           Outer loop for function
    :SetAzureTagArray           Inner loop for setting the tag name and value 
    $RGObject:                  Resource group object
    $ValidTagName:              List of all tag names on resource group
    $TagNameInput:              Operator input for the tag name
    $TagsArray:                 Hashable value of $TagNameInput and $TagValueInput
    $TagsList:                  Write-Host writable tag name and value list
} End RemoveAzResouceGroupTag 
GetAzResourceGroup { 
    :GetAzureResourceGroup      Outer loop for function
    $RGObject:                  Resource group object 
    $RGObjectInput:             Resource group object input
    $RGList:                    List of all availiable resource groups
} End GetAzResourceGroup 
#>
<# Process Flow {
    Function
        Call RemoveAzResourceGroupTag > Get $TagList
            Call GetAzResourceGroup > Get $RGObject
                Return RemoveAzResourceGroupTag > Send $RGObject
            End function
                Return function > Send $TagList
}#>
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