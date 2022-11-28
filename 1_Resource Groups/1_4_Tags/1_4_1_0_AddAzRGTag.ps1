# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Microsoft docs links
    Update-AzTag:               https://docs.microsoft.com/en-us/powershell/module/az.resources/update-aztag?view=azps-5.2.0             
    Get-AzResourceGroup:        https://docs.microsoft.com/en-us/powershell/module/az.resources/get-azresourcegroup?view=azps-5.1.0
} #>
<# Required Functions Links: {
    GetAzResourceGroup:         https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/Resource%20Groups/GetAzResourceGroup.ps1
    SetAzTagPair:               https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/Tags/SetAzTagPair.ps1
} #>
<# Functions Description: {
    AddAzRGTag:                 Create a new resource tag on a resource group
    GetAzResourceGroup:         Collects resource group object
    SetAzTagPair:               Creates an array of tags
} #>
<# Variables: { 
    :AddAzureRGTag              Outer loop for function
    $CallingFunction:           Name of this function
    $TagArray:                  Array of all tags to be applied
    $NewTag:                    Current item hash being applied
    $RGObject:                  Resource group object
    $TagsList:                  List of all tags on the current resource group 
    GetAzResourceGroup{}        Gets $RGObject
    SetAzTagPair{}     Gets $TagArray
} #>
<# Process Flow {
    Function
        Call AddAzRGTag > Get $null
            Call GetAzResourceGroup > Get $RGObject
            End GetAzResourceGroup
                Return AddAzRGTag > Send $RGObject
            Call SetAzTagPair > Get $TagArray
            End SetAzTagPair
                Return AddAzRGTag > Send $TagArray
        End AddAzRGTag
            Return function > Send $null
} #>
function AddAzRGTag {                                                                       # Function to add a new tag to a resource group
    Begin {                                                                                 # Begin function
        $CallingFunction = 'AddAzRGTag'                                                     # Creates $CallingFunction
        :AddAzureRGTag while ($true) {                                                      # Outer loop for managing function
            if (!$RGObject) {                                                               # If $RGObject is $null
                $RGObject = GetAzResourceGroup ($CallingFunction)                           # Calls function and assigns output to $var
                if (!$RGObject) {                                                           # If $RGObject is $null
                    Break AddAzureRGTag                                                     # Breaks :AddAzureRSTag
                }                                                                           # End if (!$RGObject) | Inner
            }                                                                               # End if (!$RGObject) | Outer
            $TagArray = SetAzTagPair ($CallingFunction)                                     # Calls function and assigns output to $var
            if (!$TagArray) {                                                               # If $TagArray is $null
                Break AddAzureRGTag                                                         # Breaks AddAxureTag
            }                                                                               # End if (!$TagArray)
            foreach ($_ in $TagArray) {                                                     # For each item in $TagArray
                $Newtag = @{$_.Name=$_.Value}                                               # Creates a new hashed name and value
                try {                                                                       # Try the following
                $TagsList = Update-AzTag -ResourceID $RGObject.ResourceID -Operation `
                    'Merge' -Tag $Newtag                                                    # Appends the new tag to the resource group
                }                                                                           # End try
                catch {                                                                     # If try fails
                    Write-Host 'An error has occured'                                       # Write message to screen
                    Write-Host 'Check your permissions'                                     # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    $TagsList = `
                        (Get-AzResourceGroup -resourceID $RGObject.ResourceID).TagsTable    # Gets the current tags assigned to $RGObject
                    Write-Host 'The following tags are currently set on'`
                        $RGObject.ResourceGroupName                                         # Write message to screen
                    Write-Host $TagsList                                                    # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Break AddAzureRGTag                                                     # Breaks :AddAzureRGTag
                }                                                                           # End catch
            }                                                                               # End foreach ($_ in $TagArray)                                                       
            $TagsList = (Get-AzResourceGroup -resourceID $RGObject.ResourceID).TagsTable    # Gets the current tags assigned to $RGObject
            Write-Host 'The following tags are currently set on'$RGObject.ResourceGroupName # Write message to screen
            Write-Host $TagsList                                                            # Write message to screen
            Pause                                                                           # Pauses all actions for operator input
            Break AddAzureRGTag                                                             # Breaks :AddAzureRGTag
        }                                                                                   # End :AddAzureRGTag while ($true)
        Clear-Host                                                                          # Clears the screen
        Return                                                                              # Returns to the calling function with $null
    }                                                                                       # End begin
}                                                                                           # End function AddAzRGTag