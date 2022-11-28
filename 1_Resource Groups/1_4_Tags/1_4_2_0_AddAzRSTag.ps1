# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Microsoft docs links
    Update-AzTag:               https://docs.microsoft.com/en-us/powershell/module/az.resources/update-aztag?view=azps-5.2.0             
    Get-AzResource:             https://docs.microsoft.com/en-us/powershell/module/az.resources/get-azresource?view=azps-5.1.0
} #>
<# Required Functions Links: {
    SetAzTagPair:               https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/Tags/SetAzTagPair.ps1
    GetAzResource:              https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/GetAzResource.ps1
} #>
<# Functions Description: {
    AddAzRSTag:                 Create a new resource tag on a resource
    SetAzTagPair:               Function to create multiple tag name value pairs
    GetAzResource:              Collects a resource
} #>
<# Variables: {
    :AddAzureRSTag              Outer loop for managing function
    $CallingFunction:           Name of this function
    $RSObject:                  Resource object
    $TagArray:                  Array of new tags to apply
    $Newtag:                    Current item .Name .Value array
    $TagsList:                  List of all tags applied to $RSObject
    GetAzResource{}             Gets $RSObject
    SetAzTagPair{}              Gets $TagArray
} #>
<# Process Flow {
    Function
        Call AddAzRSTag > Get $null
            Call GetAzResource > Get $RSObject
            End GetAzResource
                Return AddAzRSTag > Send $RSObject
            Call SetAzTagPair > Get $TagArray
            End SetAzTagPair
                Return AddAzRSTag > Send $TagArray
        End AddAzRSTag
            Return function > Send $null
}#>
function AddAzRSTag {                                                                       # Function to add a new tag to a resource grop
    Begin {                                                                                 # Begin function
        $CallingFunction = 'AddAzRSTag'                                                     # Creates $CallingFunction
        :AddAzureRSTag while ($true) {                                                      # Outer loop for managing function
            if (!$RSObject) {                                                               # If $RSObject is $null
                $RSObject = GetAzResource ($CallingFunction)                                # Calls function and assigns output to $var
                if (!$RSObject) {                                                           # If $RSObject is $null
                    Break AddAzureRSTag                                                     # Breaks :AddAzureRSTag
                }                                                                           # End if (!$RSObject) | Inner
            }                                                                               # End if (!$RSObject) | Outer
            $TagArray = SetAzTagPair ($CallingFunction)                                     # Calls function and assigns output to $var
            if (!$TagArray) {                                                               # If $TagArray is $null
                Break AddAzureRSTag                                                         # Breaks AddAxureTag
            }                                                                               # End if (!$TagArray)
            Write-Host 'Adding the selected tags'                                           # Write message to screen
            foreach ($_ in $TagArray) {                                                     # For each item in $TagArray
                $Newtag = @{$_.Name=$_.Value}                                               # Creates a new hashed name and value
                try {                                                                       # Try the following
                $TagsList = Update-AzTag -ResourceID $RSObject.ResourceID -Operation `
                    'Merge' -Tag $Newtag                                                    # Appends the new tag to the resource group
                }                                                                           # End try
                catch {                                                                     # If try fails
                    Write-Host 'An error has occured'                                       # Write message to screen
                    Write-Host 'Check your permissions'                                     # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    $TagsList = `
                        (Get-AzResource -resourceID $RSObject.ResourceID).TagsTable         # Gets the current tags assigned to $RSObject
                    Write-Host 'The following tags are currently set on'$RSObject.name      # Write message to screen
                    Write-Host $TagsList                                                    # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Break AddAzureRSTag                                                     # Breaks :AddAzureRSTag
                }                                                                           # End catch
            }                                                                               # End foreach ($_ in $TagArray)                                                       
            $TagsList = (Get-AzResource -resourceID $RSObject.ResourceID).TagsTable         # Gets the current tags assigned to $RSObject
            Write-Host 'The following tags are currently set on'$RSObject.name              # Write message to screen
            Write-Host $TagsList                                                            # Write message to screen
            Pause                                                                           # Pauses all actions for operator input
            Break AddAzureRSTag                                                             # Breaks :AddAzureRSTag
        }                                                                                   # End :AddAzureRSTag while ($true)
        Clear-Host                                                                          # Clears the screen
        Return                                                                              # Returns to the calling function with $null
    }                                                                                       # End begin
}                                                                                           # End function AddAzRSTag