# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Mircosoft docs links
    Stop-AzVmss:                https://docs.microsoft.com/en-us/powershell/module/az.compute/Stop-azvmss?view=azps-5.6.0
    Get-AzVmss:                 https://docs.microsoft.com/en-us/powershell/module/az.compute/get-azvmss?view=azps-5.6.0
    Get-AzVmssVM:               https://docs.microsoft.com/en-us/powershell/module/az.compute/get-azvmssvm?view=azps-5.6.0
} #>
<# Required Functions Links: {
    GetAzVmss:                  https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Compute/Azure%20Vm%20Scale%20Set/GetAzVmSS.ps1
    GetAzVmssVM:                https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Compute/Azure%20Vm%20Scale%20Set/GetAzVmssVM.ps1
} #>
<# Functions Description: {
    StopAzVmss:                 Stops instances of a Vmss
    GetAzVmssVM:                Gets a Vmss instance
    GetAzVmss:                  Gets a Vmss
} #>
<# Variables: {
    :StopAzureVmssVM            Outer loop for managing function
    $OperatorSelect:            Operator input for the instance selection
    $VmssObject:                Virtual machine scale set object
    $VmssVMObject:              The instance object
    GetAzVmss{}                 Gets $VmssObject
    GetAzVmssVM{}               Gets $VmssVMObject
        GetAzVmss{}                 Gets $VmssObject                   
} #>
<# Process Flow {
    Function
        Call StopAzVmss > Get $null
            Call GetAzVmss > Get $VmssObject
            End GetAzVmss
                Return StopAzVmss > Send $VmssObject   
            Call GetAzVmssVM > Get $VmssVMObject, $VmssObject
                Call GetAzVmss > Get $VmssObject
                End GetAzVmss
                    Return GetAzVmssVM > Send $VmssObject
            End GetAzVmssVM
                Return StopAzVmss > Send $VmssVMObject, $VmssObject
        End StopAzVmss
            Return function > Send $null
}#>
function StopAzVmss {                                                                       # Function for Stoping vmss instances
    Begin {                                                                                 # Begin function
        :StopAzureVmssVM while ($true) {                                                    # Outer loop for managing function
            Write-Host '[0] Exit'                                                           # Write message to screen
            Write-Host '[1] Stop all instances in a Vmss'                                   # Write message to screen
            Write-Host '[2] Stop a single instance in a Vmss'                               # Write message to screen
            $OperatorSelect = Read-Host 'Option [#]'                                        # Operator input for selecting the instance stop option
            if ($OperatorSelect -eq '0') {                                                  # If $OperatorSelect equals '0'
                Break StopAzureVmssVM                                                       # Breaks :StopAzureVmssVM
            }                                                                               # End if ($OperatorSelect -eq '0')
            elseif ($OperatorSelect -eq '1') {                                              # Else if $OperatorSelect equals '1'
                if (!$VmssObject) {                                                         # If $var is $null
                    $VmssObject = GetAzVmss                                                 # Calls function and assigns output to $var
                    if (!$VmssObject) {                                                     # If $var is $null
                        Break StopAzureVmssVM                                               # Breaks :StopAzureVmssVM
                    }                                                                       # End if (!$VmssVMObject)
                }                                                                           # End if (!$VmssVMObject)
                Stop-AzVmss -ResourceGroupName $VmssObject.ResourceGroupName `
                    -VMScaleSetName $VmssObject.Name                                        # Stops all instances of the Vmss
                Break StopAzureVmssVM                                                       # Breaks :StopAzureVmssVM
            }                                                                               # End elseif ($OperatorSelect -eq '1')
            elseif ($OperatorSelect -eq '2') {                                              # Else if $OperatorSelect equals '2'
                if (!$VmssObject) {                                                         # If $var is $null
                    $VmssVMObject, $VmssObject = GetAzVmssVM                                # Calls function and assigns output to $var
                    if (!$VmssObject) {                                                     # If $var is $null
                        Break StopAzureVmssVM                                               # Breaks :StopAzureVmssVM 
                    }                                                                       # End if (!$VmssVMObject)
                }                                                                           # End if (!$VmssVMObject)
                Stop-AzVmss -ResourceGroupName $VmssObject.ResourceGroupName `
                    -VMScaleSetName $VmssObject.Name -InstanceId $VmssVMObject.InstanceId   # Stops the specified instance of the Vmss
                Break StopAzureVmssVM                                                       # Breaks :StopAzureVmssVM
            }                                                                               # End elseif ($OperatorSelect -eq '2')
            else {                                                                          # If $OperatorSelect did not meet any if or elseif statements
                Write-Host 'That was not a valid option'                                    # Write message to screen
            }                                                                               # End else (if ($OperatorSelect -eq '0'))
        }                                                                                   # End :StopAzureVmssVM while ($true) 
        Return                                                                              # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function StopAzVmss