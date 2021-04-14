# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Mircosoft docs links
    Update-AzTag:               https://docs.microsoft.com/en-us/powershell/module/az.resources/update-aztag?view=azps-5.2.0             
    Get-AzResourceGroup:        https://docs.microsoft.com/en-us/powershell/module/az.resources/get-azresourcegroup?view=azps-5.1.0
} #>
<# Required Functions Links: {
    GetAzResourceGroup:         https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/Resource%20Groups/GetAzResourceGroup.ps1
    SetAzTagPair:               https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/Tags/SetAzTagPair.ps1
} #>
<# Functions Description: {
    AddAzResourceGroupTag:      Create a new resource tag on a resource group
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
    AddAzResourceGroupTag{}     Gets $TagArray
} #>
<# Process Flow {
    Function
        Call AddAzResourceGroupTag > Get $null
            Call GetAzResourceGroup > Get $RGObject
            End GetAzResourceGroup
                Return AddAzResourceGroupTag > Send $RGObject
            Call SetAzTagPair > Get $TagArray
            End SetAzTagPair
                Return AddAzResourceGroupTag > Send $TagArray
        End AddAzResourceGroupTag
            Return function > Send $$null
} #>
function AddAzResourceGroupTag {                                                            # Function to add a new tag to a resource group
    Begin {                                                                                 # Begin function
        $CallingFunction = 'AddAzResourceGroupTag'                                          # Creates $CallingFunction
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
                    Start-Sleep(10)                                                         # Pauses all actions for 10 seconds
                    Break AddAzureRGTag                                                     # Breaks :AddAzureRGTag
                }                                                                           # End catch
            }                                                                               # End foreach ($_ in $TagArray)                                                       
            $TagsList = (Get-AzResourceGroup -resourceID $RGObject.ResourceID).TagsTable `
                | Out-String                                                                # Formats hashable array into string
            Write-Host 'The following tags are currently set on'$RGObject.ResourceGroupName # Write message to screen
            foreach ($_ in $TagsList) {                                                     # For each item in $TagList
                Write-Host $_.Name $_.Value                                                 # Write message to screen
            }                                                                               # End foreach ($_ in $TagsList)
            Start-Sleep(10)                                                                 # Pauses all actions for 10 seconds
            Break AddAzureRGTag                                                             # Breaks :AddAzureRGTag
        }                                                                                   # End :AddAzureRGTag while ($true)
        Clear-Host                                                                          # Clears the screen
        Return                                                                              # Returns to the calling function with $null
    }                                                                                       # End begin
}                                                                                           # End function AddAzResourceGroupTag