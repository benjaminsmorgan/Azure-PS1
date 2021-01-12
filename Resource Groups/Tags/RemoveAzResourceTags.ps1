# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Mircosoft docs links             
    Remove-AzTag:               https://docs.microsoft.com/en-us/powershell/module/az.resources/remove-aztag?view=azps-5.2.0
    Get-AzResourceGroup:        https://docs.microsoft.com/en-us/powershell/module/az.resources/get-azresourcegroup?view=azps-5.1.0
    Get-AzResource:             https://docs.microsoft.com/en-us/powershell/module/az.resources/get-azresource?view=azps-5.1.0
} #>
<# Required Functions Links: {
    GetAzResourceGroup:         https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/GetAzResourceGroup.ps1
    GetAzResource:              https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/GetAzResource.ps1
} #>
<# Functions Description: {
    RemoveAzResourceTags:       Remove all tags from a resource
    GetAzResourceGroup:         Collects resource group object
    GetAzResource:              Collects resources within a resource group
} #>
<# RemoveAzResourceTags {
    :RemoveAzureRSTags          Outer loop for function
    $RGObject:                  Resource group object
    $RSObject:                  Resource object
    $TagsList:                  Write-Host writable tag name and value list
} End RemoveAzResourceTags
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
        Call RemoveAzResourceTags > Get $TagList
            Call GetAzResourceGroup > Get $RGObject
                Return RemoveAzResourceTags > Send $RGObject
            Call GetAzResource > Get $RSObject
                Return RemoveAzResourceTags > Send $RSObject
            End function
                Return function > Send $TagList
}#>
function RemoveAzResourceTags {
    Begin {
        :RemoveAzureRSTags while ($true) { # :RemoveAzureRSTag loop for removing named tag on a resource
            if (!$RGObject) { # If $RGObject is $null
                $RGObject = GetAzResourceGroup # Calls GetAzResourceGroup and assigns output to $RGObject
                if (!$RGObject) { # If called function returns empty
                    Break RemoveAzureRSTags # Breaks :RemoveAzureRSTags loop
                } # End if (!$RGObject)
            } # End if (!$RGObject)
            if (!$RSObject) { # If $RSObject is $null
                $RSObject = GetAzResource # Calls GetAzResource and assigns output to $RSObject
                if (!$RSObject) { # If called function returns empty
                    Break RemoveAzureRSTags # Breaks :RemoveAzureRSTags loop
                } # End if (!$RSObject)
            } # End if (!$RSObject)
            Remove-AzTag -ResourceId $RSObject.ResourceID -PassThru # Removes all tags on the resource
            $TagsList = (Get-AzResource -resourceID $RSObject.ResourceID).TagsTable | Out-String # Formats hashable array into string
            if (!$TagsList) { # If $TagsList is $null
                Write-Host "No tags exist on this resource" # Write message to screen
            } # End if (!$TagsList)
            Return $TagsList # Returns $Tags to the calling function
        } # End :RemoveAzureRSTags while ($true) {
        Return # Returns to the calling function with $null
    } # End begin
} # End function RemoveAzResourceTags