# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Mircosoft docs links
    New-AzContainerGroup :      https://docs.microsoft.com/en-us/powershell/module/az.containerinstance/new-azcontainergroup?view=azps-5.6.0
    Get-AzContainerGroup:       https://docs.microsoft.com/en-us/powershell/module/az.containerinstance/get-azcontainergroup?view=azps-5.6.0
    Remove-AzContainerGroup:    https://docs.microsoft.com/en-us/powershell/module/az.containerinstance/remove-azcontainergroup?view=azps-5.6.0
    Get-AzResourceGroup:        https://docs.microsoft.com/en-us/powershell/module/az.resources/get-azresourcegroup?view=azps-5.1.0
} #>
<# Required Functions Links: {
    NewAzContainerGroup:        https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Compute/Containers/NewAzContainerGroup.ps1
    GetAzContainerGroup:        https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Compute/Containers/GetAzContainerGroup.ps1
    RemoveAzContainerGroup:     https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Compute/Containers/RemoveAzContainerGroup.ps1
    GetAzResourceGroup:         https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/GetAzResourceGroup.ps1   
} #>
<# Functions Description: {
    ManageAzContainerGroup:     Management function for container groups
    NewAzContainerGroup:        Creates a container group
    GetAzContainerGroup:        Gets a container group
    RemoveAzContainerGroup:     Removes a container group
    GetAzResourceGroup:         Gets a resource group
} #>
<# Variables: {
    :ManageAzureContainerGroup  Outer loop for managing function
    $ContainerObject:           Container group object
    $ManageAzContainerGroup     Operator input to select the management function
    NewAzContainerGroup{}       Creates $ContainerGroup
    GetAzContainerGroup{}       Gets $ContainerGroup
    RemoveAzContainerGroup{}    Removes $ContainerGroup
        GetAzContainerGroup{}       Gets $ContainerGroup
} #>
<# Process Flow {
    Function
        Call ManageAzContainerGroup > Get $null
            Call NewAzContainerGroup > Get $ContainerObject
                Call GetAzResourceGroup > Get $RGObject
                End GetAzResourceGroup 
                Return NewAzContainerGroup > Send $RGObject
            End NewAzContainerGroup
                Return ManageAzContainerGroup > Send $ContainerObject
            Call GetAzContainerGroup > Get $ContainerObject
            End GetAzContainerGroup
                    Return ManageAzContainerGroup > Send $ContainerObject
            Call RemoveAzContainerGroup > Get $null
                Call GetAzContainerGroup > Get $ContainerObject
                End GetAzContainerGroup
                    Return RemoveAzContainerGroup > Send $ContainerObject
            End RemoveAzContainerGroup
                Return ManageAzContainerGroup > Send $null
        End ManageAzContainerGroup
            Return function > Send $null
}#>
function ManageAzContainerGroup {                                                           # Function to manage container groups
    Begin {                                                                                 # Begin function
        :ManageAzureContainerGroup while ($true) {                                          # Outer loop for managing function
            if ($ContainerObject) {                                                         # If $ContainerObject has a value
                Write-Host 'The currently selected container object is' `
                    $ContainerObject.name                                                   # Write message to screen
            }                                                                               # End if ($ContainerObject)
            Write-Host "Azure Container Group Management"                                   # Write message to screen
            Write-Host '0 Clear "$ContainerObject"'                                         # Write message to screen
            Write-Host '1 New container group'                                              # Write message to screen
            Write-Host '2 Get container group'                                              # Write message to screen
            Write-Host '3 Remove container group'                                           # Write message to screen
            Write-Host "'Exit to return'"                                                   # Write message to screen
            $ManageAzContainerGroup = Read-Host "Option?"                                   # Collects operator input on $ManageAzContainerGroup option
            if ($ManageAzContainerGroup -eq 'exit') {                                       # If $ManageAzContainerGroup equals 'exit'
                Break ManageAzureContainerGroup                                             # Breaks :ManageAzureContainerGroupr
            }                                                                               # End if ($ManageAzContainerGroup -eq 'exit')
            elseif ($ManageAzContainerGroup -eq '0') {                                      # Elseif $ManageAzContainerGroup equals 0
                if ($ContainerObject) {                                                     # If $ContainerObject has a value
                    Write-Host 'Clearing "$ContainerObject'                                 # Write message to screen
                    $ContainerObject = $null                                                # Clears $ContainerObject
                }                                                                           # End if ($ContainerObject)
                else {                                                                      # If $ContainerObject does not have a value
                    Write-Host '$ContainerObject is already clear'                          # Write message to screen
                }                                                                           # End else (if ($ContainerObject))
            }                                                                               # End elseif ($ManageAzContainerGroup -eq '0')
            elseif ($ManageAzContainerGroup -eq '1') {                                      # Elseif $ManageAzContainerGroup equals 1
                Write-Host 'New container group'                                            # Write message to screen
                $ContainerObject = NewAzContainerGroup ($RGObject)                          # Calls function and assigns output to $var
            }                                                                               # End elseif ($ManageAzContainerGroup -eq '1')
            elseif ($ManageAzContainerGroup -eq '2') {                                      # Elseif $ManageAzContainerGroup equals 2
                Write-Host 'Get container group'                                            # Write message to screen
                $ContainerObject = GetAzContainerGroup                                      # Calls function and assigns output to $var
            }                                                                               # End elseif ($ManageAzContainerGroup -eq '2')
            elseif ($ManageAzContainerGroup -eq '3') {                                      # Elseif $ManageAzContainerGroup equals 3
                Write-Host 'Remove container group'                                         # Write message to screen
                RemoveAzContainerGroup ($ContainerObject)                                   # Calls function
            }                                                                               # End elseif ($ManageAzContainerGroup -eq '3')
            else {                                                                          # If $ManageAzContainerGroup do not match any if or elseif     
                Write-Host "That was not a valid option"                                    # Write message to screen
            }                                                                               # End else (if ($ManageAzContainerGroup -eq 'exit'))
        }                                                                                   # End :ManageAzureContainerGroup while ($true)
        return                                                                              # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function ManageAzContainerGroup