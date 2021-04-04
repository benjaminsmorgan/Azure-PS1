# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Mircosoft docs links
    Get-AzResourceGroup:        https://docs.microsoft.com/en-us/powershell/module/az.resources/get-azresourcegroup?view=azps-5.1.0
    Get-AzResource:             https://docs.microsoft.com/en-us/powershell/module/az.resources/get-azresource?view=azps-5.1.0
} #>
<# Required Functions Links: {
    GetAzResourceGroup:         https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/Resource%20Groups/GetAzResourceGroup.ps1
} #>    
<# Function Description: {
    ListAzRGResources:          Lists all resources within a resource group
    GetAzResourceGroup:         Gets a resource group
} #>
<# Variables: {
    :ListAzureRGResources       Outer loop for managing function
    $RGObject:                  Resource group object
    $CallingFunction:           Name of this function
    $RSList:                    List of all resources with $RGObject
    GetAzResourceGroup{}        Gets $RGObject
} #>
<# Process Flow {
    Function
        Call ListAzRGResources > Get $null
            GetAzResourceGroup > Get $RGObject
            End GetAzResourceGroup
                Return ListAzRGResources > Send $RGObject
        End ListAzRGResources
            Return Function > Send $null
}#>
function ListAzRGResources {                                                                # Function to list all resources within a resource group
    Begin {                                                                                 # Begin function
        :ListAzureRGResources while ($true) {                                               # Outer loop for managing function
            if (!$RGObject) {                                                               # If $RGObject does not have a value
                $CallingFunction = 'ListAzRGResources'                                      # Creates $CallingFunction
                $RGObject = GetAzResourceGroup ($CallingFunction)                           # Calls function and assigns output to $var
                if (!$RGObject) {                                                           # If $RGObject does not have a value
                    Break ListAzureRGResources                                              # Breaks :ListAzureRGResources
                }                                                                           # End if (!$RGObject) | Inner
            }                                                                               # End if (!$RGObject) | Outer
            $RSList = Get-AzResource | Where-Object `
                {$_.ResourceGroupName -eq $RGObject.ResourceGroupName}                      # Creates a list of all resources within $RGObject
            if (!$RSList) {                                                                 # If $RSList is $null
                Write-Host ''                                                               # Write message to screen
                Write-Host 'No resources in resource group'$RGObject.ResourceGroupName      # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Break ListAzureRGResources                                                  # Breaks :ListAzureRGResources
            }                                                                               # End if (!$RSList)
            else {                                                                          # If $RSList has a value
                Write-Host ''                                                               # Write message to screen
                Write-Host `
                    'There are'$RSList.Count'resources in'$RGObject.ResourceGroupName       # Write message to screen
                Write-Host ''                                                               # Write message to screen
                foreach ($_ in $RSList) {                                                   # For each item in $RSList
                    Write-Host 'Name:'$_.Name                                               # Write message to screen
                    Write-Host 'Loc: '$_.Location                                           # Write message to screen
                    Write-Host 'Type:'$_.ResourceType                                       # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                }                                                                           # End foreach ($_ in $RSList)
                Break ListAzureRGResources                                                  # Breaks :ListAzureRGResources
            }                                                                               # End else (End if (!$RSList))
        }                                                                                   # End :ListAzureRGResources while ($true)
        return                                                                              # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function ListAzRGResources