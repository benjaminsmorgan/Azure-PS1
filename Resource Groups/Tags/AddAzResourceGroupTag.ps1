# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Mircosoft docs links
    Update-AzTag:               https://docs.microsoft.com/en-us/powershell/module/az.resources/update-aztag?view=azps-5.2.0             
    Get-AzResourceGroup:        https://docs.microsoft.com/en-us/powershell/module/az.resources/get-azresourcegroup?view=azps-5.1.0
} #>
<# Required Functions Links: {
    GetAzResourceGroup:         https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/GetAzResourceGroup.ps1
} #>
<# Functions Description: {
    AddAzResourceGroupTag:      Create a new resource tag on a resource group
    GetAzResourceGroup:         Collects resource group object
    GetAzResource:              Collects resources within a resource group
} #>
<# GetAzResourceGroupTags { 
    :GetAzureRGTag              Outer loop for function
    $RGObject:                  Resource group object
    $TagsList:                  Write-Host writable tag name and value list
} End GetAzResourceGroupTags 
GetAzResourceGroup { 
    :GetAzureResourceGroup      Outer loop for function
    $RGObject:                  Resource group object 
    $RGObjectInput:             Resource group object input
    $RGList:                    List of all availiable resource groups
} End GetAzResourceGroup 
} 
#>
<# Process Flow {
    Function
        Call AddAzResourceGroupTag > Get $TagList
            Call GetAzResourceGroup > Get $RGObject
                Return AddAzResourceGroupTag > Send $RGObject
            End function
            Return function > Send $TagList
}#>
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
