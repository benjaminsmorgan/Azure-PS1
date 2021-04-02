# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Mircosoft docs links
    Get-AzResourceGroup:        https://docs.microsoft.com/en-us/powershell/module/az.resources/get-azresourcegroup?view=azps-5.1.0
    Get-AzResource:             https://docs.microsoft.com/en-us/powershell/module/az.resources/get-azresource?view=azps-5.1.0
} #>
<# Required Functions Links: {
    GetAzResource:              https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/Resources/GetAzResource.ps1
    GetAzResourceGroup:         https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/Resource%20Groups/GetAzResourceGroup.ps1
} #>    
<# Function Description: {
    SearchAzResourceGroupName:  Searchs for resource group using name on the group name, or a contained resource name
    GetAzResource:              Gets a resource object
    GetAzResourceGroup:         Gets a resource group object
} #>
<# Variables: {
    :SearchAzureRGByName        Outer loop for manaing function
    :SearchAzureRSName          Inner loop for finding $RGObject using resource name
    :SearchAzureRGName          Inner loop for finding $RGObject
    $CallingFunction:           Name of this function
    $OperatorSearchOption:      Operator input for search option
    $RSObject:                  Resource object, used to get $RGObject
    $RGObject:                  Resource group object, used for all actions
    GetAzResource{}             Gets $RSObject
    GetAzResourceGroup{}        Gets $RGObject   
} #>
<# Process Flow {
    Function
        Call SearchAzResourceGroupName > Get $RGObject
            Call GetAzResource > Get $RSObject
            End GetAzResource
                Return SearchAzResourceGroupName > Send $RSObject
            Call GetAzResourceGroup > Get $RGObject
            End GetAzResourceGroup    
                Return SearchAzResourceGroupName > Send $RGObject
        End SearchAzResourceGroupName
            Return function > Send $RGObject
}#>
function SearchAzResourceGroupName {                                                        # Function to search for resource group by name
    Begin {                                                                                 # Begin function
        :SearchAzureRGByName while($true) {                                                 # Outer loop for managing function
            $CallingFunction = 'SearchAzResourceGroupName'                                  # Creates $CallingFunction
            Write-Host "Resource Group Search By Name"                                      # Write message to screen
            Write-Host "[1] Search by resource name"                                        # Write message to screen
            Write-Host "[2] Search by group name"                                           # Write message to screen
            $OperatorSearchOption = Read-Host "Option?"                                     # Operator input for search method
            if ($OperatorSearchOption -eq 'exit') {                                         # If $OperatorSearchOption equals 'exit'
                Break SearchAzureRGByName                                                   # Breaks :SearchAzureRGByName
            }                                                                               # End if ($OperatorSearchOption -eq 'exit')
            elseif ($OperatorSearchOption -eq '1') {                                        # Else if $OperatorSearchOption equals '1' 
                $RSObject = GetAzResource ($CallingFunction)                                # Calls function and assigns output to $var
                if (!$RSObject) {                                                           # If $RSObject does not have a value
                    Break SearchAzureRGByName                                               # Breaks :SearchAzureRGByName
                }                                                                           # End if (!$RSObject)
                $RGObject = Get-AzResourceGroup | Where-Object `
                    {$_.ResourceGroupName -eq $RSObject.ResourceGroupName}                  # Pulls the resource group object holding $RSObject
                Return $RGObject                                                            # Returns $RGObject to calling function
            }                                                                               # End elseif ($OperatorSearchOption -eq '1')
            elseif ($OperatorSearchOption -eq '2') {                                        # Else if $OperatorSearchOption equals '2' 
                $RGObject = GetAzResourceGroup ($CallingFunction)                           # Calls function and assigns output to $var
                if (!$RGObject) {                                                           # If $RGObject does not have a value
                    Break SearchAzureRGByName                                               # Breaks :SearchAzureRGByName
                }                                                                           # End if (!$RGObject)        
                Return $RGObject                                                            # Returns $RGObject to calling function 
            }                                                                               # End elseif ($OperatorSearchOption -eq '2')
            else {                                                                          # All other inputs for $OperatorSearchOption
                Write-Host 'That was not a valid option'                                    # Write message to screen
            }                                                                               # if ($OperatorSearchOption -eq 'exit')
        }                                                                                   # End :SearchAzureRGByName while($true)
        Return                                                                              # Returns to calling function with $null
    }                                                                                       # End begin
}                                                                                           # End function SearchAzResourceGroupName