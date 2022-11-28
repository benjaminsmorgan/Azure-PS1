# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Microsoft docs links
    Get-AzResourceGroup:        https://docs.microsoft.com/en-us/powershell/module/az.resources/get-azresourcegroup?view=azps-5.1.0
} #>
<# Required Functions Links: {
    GetAzResourceGroup:         https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups//Resource%20Groups/GetAzResourceGroup.ps1
} #>
<# Functions Description: {
    ListAzRGTags:               Lists all tags on a resource group
    GetAzResourceGroup:         Collects resource group object
} #>
<# Variables: {
    :GetAzureRGTag              Outer loop for managing function
    $CallingFunction:           Name of this function
    $RGObject:                  Resource group object
    $TagsList:                  List of tags on the resource group
    GetAzResourceGroup{}        Gets $RGObject
}#>
<# Process Flow {
    Function
        Call ListAzRGTags > Get $null
            Call GetAzResourceGroup > Get $RGObject
            End GetAzResourceGroup
                Return ListAzRGTags > Send $RGObject
        End ListAzRGTags
            Return function > Send $null
}#>
function ListAzRGTags {                                                                     # Gets all resource group tags and writes them to screen with values
    Begin {                                                                                 # Begin function
        $CallingFunction = 'ListAzRGTags'                                                   # Creates $CallingFunction
        :GetAzureRGTag while ($true) {                                                      # Outer loop for managing function
            $RGObject = GetAzResourceGroup ($CallingFunction)                               # Calls function and assigns output to $var
            if (!$RGObject) {                                                               # If $RGObject is $null
                Break GetAzureRGTag                                                         # Breaks :GetAzureRGTag
            }                                                                               # End if (!$RGObject)
            $TagsList = (Get-AzResourceGroup -resourceID $RGObject.ResourceID).TagsTable    # Gets the current tags assigned to $RGObject
            Write-Host 'The following tags are currently set on'$RGObject.ResourceGroupName # Write message to screen
            Write-Host $TagsList                                                            # Write message to screen
            Pause                                                                           # Pauses for user input to continue
            Break GetAzureRGTag                                                             # Breaks :GetAzureRGTag 
        }                                                                                   # End :GetAzureRGTag while ($true)
    Clear-Host                                                                              # Clears screen
    Return                                                                                  # Returns to the calling function with $null
    }                                                                                       # End begin
}                                                                                           # End function ListAzRGTags