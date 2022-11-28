# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Microsoft docs links
    Get-AzResourceGroup:        https://docs.microsoft.com/en-us/powershell/module/az.resources/get-azresourcegroup?view=azps-5.1.0
    Get-AzResource:             https://docs.microsoft.com/en-us/powershell/module/az.resources/get-azresource?view=azps-5.1.0
    Get-AzResourceProvider:     https://docs.microsoft.com/en-us/powershell/module/az.resources/get-azresourceprovider?view=azps-5.2.0
} #>
<# Required Functions Links: {
    SearchAzResourceType:       https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/Resources/SearchAzResourceType.ps1
} #>    
<# Function Description: {
    SearchAzResourceGroupType:  Search for a resource group by contained resouce provider and type
    SearchAzResourceType:       Searchs for resource using resource provider or type on a resource or resource
} #>
<# Variables: {
    :SearchAzureRGByType        Outer loop for managing function
    $RSObject:                  Resource object
    $RGObject:                  Resource group object
    SearchAzResourceType{}      Gets $RSObject
} #>
<# Process Flow {
    Function
        Call SearchAzResourceGroupType > Get $RGObject
            Call SearchAzResourceType > Get $RSObject
            End SearchAzResourceType
                Return SearchAzResourceGroupType > Send $RSObject
        End SearchAzResourceGroupType
            Return Function > Send $RGObject
}#>
function SearchAzResourceGroupType {                                                        # Function to search for resource group by resource provider or type
    Begin {                                                                                 # Begin function
        :SearchAzureRGByType while($True) {                                                 # Outer loop for manaing function
            $RSObject = SearchAzResourceType                                                # Calls function and assigns output to $var
            if (!$RSObject) {                                                               # If $RSObject does not have a value
                Break SearchAzureRGByType                                                   # Breaks :SearchAzureRGByType
            }                                                                               # End if (!$RSObject)
            else {                                                                          # If $RSObject has a value
                $RGObject = Get-AzResourceGroup -name $RSObject.ResourceGroupName           # Pulls the resource group
                Clear-Host                                                                  # Clears the screen
                Return $RGObject                                                            # Returns to calling function with $var
            }                                                                               # End else if (!$RSObject)
        }                                                                                   # End :SearchAzRGByType while ($true)
        Clear-Host                                                                          # Clears the screen
        Return                                                                              # Returns to calling function with $null
    }                                                                                       # End begin statement
}                                                                                           # End function SearchAzResourceGroupType