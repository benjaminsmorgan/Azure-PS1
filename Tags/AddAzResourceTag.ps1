# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Mircosoft docs links
    Update-AzTag:               https://docs.microsoft.com/en-us/powershell/module/az.resources/update-aztag?view=azps-5.2.0             
    Get-AzResourceGroup:        https://docs.microsoft.com/en-us/powershell/module/az.resources/get-azresourcegroup?view=azps-5.1.0
    Get-AzResource:             https://docs.microsoft.com/en-us/powershell/module/az.resources/get-azresource?view=azps-5.1.0
} #>
<# Required Functions Links: {
    GetAzResourceGroup:         https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/GetAzResourceGroup.ps1
    GetAzResource:              https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/GetAzResource.ps1
} #>
<# Functions Description: {
    AddAzResourceTag:           Create a new resource tag on a resource 
    GetAzResourceGroup:         Collects resource group object
    GetAzResource:              Collects resources within a resource group
} #>
<# AddAzResourceTag {
    :AddAzureRSTag              Outer loop for function
    :SetAzureTagArray           Inner loop for setting the tag name and value
    $RGObject:                  Resource group object
    $RSObject:                  Resource object
    $TagNameInput:              Operator input for the tag name
    $TagValueInput:             Operator input for the tag value
    $TagsArray:                 Hashable value of $TagNameInput and $TagValueInput
    $TagsList:                  Write-Host writable tag name and value list
} End AddAzResourceTag
GetAzResourceGroup { 
    :GetAzureResourceGroup      Outer loop for function
    $RGObject:                  Resource group object 
    $RGObjectInput:             Resource group object input
    $RGList:                    List of all availiable resource groups
} End GetAzResourceGroup 
GetAzResource { 
    $RSObject:                  Resource object
    $RGObject:                  Resource group object
    $RSObjectInput:             Resource object input
    $RSList:                    List of all availiable resources
} End GetAzResource 
#>
<# Process Flow {
    Function
        Call AddAzResourceTag > Get $TagList
            Call GetAzResourceGroup > Get $RGObject
                Return AddAzResourceTag > Send $RGObject
            Call GetAzResource > Get $RSObject
                Return AddAzResourceTag > Send $RSObject
            End function
                Return function > Send $TagList
}#>
function AddAzResourceTag { # Function to add a new tag to a resource
    Begin {
        :AddAzureRSTag while ($true) { # :AddAzureRSTag loop for adding a new tag on a resource group
            if (!$RGObject) { # If $RGObject is $null
                $RGObject = GetAzResourceGroup # Calls GetAzResourceGroup and assigns output to $RGObject
                if (!$RGObject) { # If called function returns empty
                    Break AddAzureRSTag # Breaks :AddAzureRSTag loop
                } # End if (!$RGObject)
            } # End if (!$RGObject)
            if (!$RSObject) { # If $RSObject is $null
                $RSObject = GetAzResource # Calls GetAzResource and assigns output to $RSObject
                if (!$RSObject) { # If called function returns empty
                    Break AddAzureRSTag # Breaks :AddAzureRSTag loop
                } # End if (!$RSObject)
            } # End if (!$RSObject)
            if (!$TagNameInput) { # If $TagNameInput is $null
                :SetAzureTagArray while ($true) { # :SetAzureTagArray loop
                    $TagNameInput, $TagValueInput = SetAzTagPair # Calls function
                    if (!$TagNameInput) { # if SetAzTagPair returns $null
                        Break AddAzureRSTag # Breaks :AddAzureRSTag loop
                    } # End if (!$TagNameInput)
                    $TagsArray = @{$TagNameInput=$TagValueInput} # Builds the tag array to be applied 
                    Break SetAzureTagArray # Breaks :SetAzureTagArray
                } # End :SetAzureTagArray while ($true)
            } # End if (!$TagNameInput)
            Update-AzTag -ResourceID $RSObject.ResourceID -Operation 'Merge' -Tag $TagsArray # Adds the new tag to the resource group without changing the others
            $TagsList = (Get-AzResource -resourceID $RSObject.ResourceID).TagsTable | Out-String
            Return $TagsList # Returns $Tags to the calling function
        } # End :AddAzureRSTag while ($true) {
        Return # Returns to the calling function with $null
    } # End begin
} # End function AddAzResourceTag
