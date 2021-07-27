# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Microsoft docs links
    Get-AzResource:             https://docs.microsoft.com/en-us/powershell/module/az.resources/get-azresource?view=azps-5.1.0
} #>
<# Required Functions Links: {
    GetAzResource:              https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/Resources/GetAzResource.ps1
} #>
<# Functions Description: {
    ListAzRSTags:               Lists all tags on a resource 
    GetAzResource:              Collects resource object
} #>
<# Variables: {
    :GetAzureRSTag              Outer loop for managing function
    $CallingFunction:           Name of this function
    $RSObject:                  Resource object
    $TagsList:                  List of tags on the resource 
    GetAzResource{}             Gets $RSObject
}#>
<# Process Flow {
    Function
        Call ListAzRSTags > Get $null
            Call GetAzResource > Get $RSObject
            End GetAzResource
                Return ListAzRSTags > Send $RSObject
        End ListAzRSTags
            Return function > Send $null
}#>
function ListAzRSTags {                                                                     # Gets all resource tags and writes them to screen with values
    Begin {                                                                                 # Begin function
        $CallingFunction = 'ListAzRSTags'                                                   # Creates $CallingFunction
        :GetAzureRSTag while ($true) {                                                      # Outer loop for managing function
            $RSObject = GetAzResource ($CallingFunction)                                    # Calls function and assigns output to $var
            if (!$RSObject) {                                                               # If $RSObject is $null
                Break GetAzureRSTag                                                         # Breaks :GetAzureRSTag
            }                                                                               # End if (!$RSObject)
            $TagsList = (Get-AzResource -resourceID $RSObject.ResourceID).TagsTable         # Gets the current tags assigned to $RSObject
            Write-Host 'The following tags are currently set on'$RSObject.Name              # Write message to screen
            Write-Host $TagsList                                                            # Write message to screen
            Pause                                                                           # Pauses for user input to continue
            Break GetAzureRSTag                                                             # Breaks :GetAzureRSTag 
        }                                                                                   # End :GetAzureRSTag while ($true)
    Clear-Host                                                                              # Clears screen
    Return                                                                                  # Returns to the calling function with $null
    }                                                                                       # End begin
}                                                                                           # End function ListAzRSTags