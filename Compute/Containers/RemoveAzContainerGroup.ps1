# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Mircosoft docs links
    Remove-AzContainerGroup:    https://docs.microsoft.com/en-us/powershell/module/az.containerinstance/remove-azcontainergroup?view=azps-5.6.0
    Get-AzContainerGroup:       https://docs.microsoft.com/en-us/powershell/module/az.containerinstance/get-azcontainergroup?view=azps-5.6.0

} #>
<# Required Functions Links: {
    GetAzContainerGroup:        https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Compute/Containers/GetAzContainerGroup.ps1
} #>
<# Functions Description: {
    RemoveAzContainerGroup:     Removes a container group
    GetAzContainerGroup:        Gets a container group
} #>
<# Variables: {
    :RemoveAzureContainerGroup  Outer loop for managing function
    $ContainerObject:           Container group object  
    $OperatorConfirm:           Operator confirmation to remove the container
    GetAzContainerGroup{}       Gets $ContainerObject
} #>
<# Process Flow {
    Function
        Call RemoveAzContainerGroup > Get $null
            Call GetAzContainerGroup > Get $ContainerObject
            End GetAzContainerGroup
                Return RemoveAzContainerGroup > Send $ContainerObject
        End RemoveAzContainerGroup
            Return function > Send $null
}#>
function RemoveAzContainerGroup {                                                           # Function to remove a container
    Begin{                                                                                  # Begin function
        :RemoveAzureContainerGroup while ($true) {                                          # Outer loop to manage function
            if (!$ContainerObject) {                                                        # If $ContainerObject is $null
                $ContainerObject = GetAzContainerGroup                                      # Calls function and assigns output to $var 
                if (!$ContainerObject) {                                                    # If $ContainerObject is $null
                    Break RemoveAzureContainerGroup                                         # Breaks :RemoveAzureContainerGroup
                }                                                                           # End if (!$ContainerObject)
            }                                                                               # End if (!$ContainerObject)
            Write-Host 'Remove container ' $ContainerObject.name                            # Write message to screen
            $OperatorConfirm = Read-Host '[Y] or [N]'                                       # Operator input to confirm removal
            if ($OperatorConfirm -eq 'y') {                                                 # If $OperatorConfirm equals 'y'
                Remove-AzContainerGroup -ResourceGroupName `
                    $ContainerObject.ResourceGroupName -Name $ContainerObject.Name          # Removes $ContainerObject
                Break RemoveAzureContainerGroup                                             # Breaks :RemoveAzureContainerGroup     
            }                                                                               # End if ($OperatorConfirm equals 'y')
            else {                                                                          # If $OperatorConfirm does not equal 'y'
                Break RemoveAzureContainerGroup                                             # Breaks :RemoveAzureContainerGroup
            }                                                                               # End else (if ($OperatorConfirm equals 'y'))
        }                                                                                   # End :RemoveAzContainerGroup while ($true)
        Return                                                                              # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function RemoveAzContainerGroup