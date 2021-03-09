# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Mircosoft docs links
    Get-AzVmss:                 https://docs.microsoft.com/en-us/powershell/module/az.compute/get-azvmss?view=azps-5.6.0
    Remove-AzVmss:              https://docs.microsoft.com/en-us/powershell/module/az.compute/remove-azvmss?view=azps-5.6.0
} #>
<# Required Functions Links: {
    GetAzVmss:                  https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Compute/Azure%20Vm%20Scale%20Set/GetAzVmSS.ps1
} #>
<# Functions Description: {
    RemoveAzVmss:               Removes a Vmss
    GetAzVmss:                  Gets a Vmss
} #>
<# Variables: {
    :RemoveAzureVmss            Outer loop for managing function
    $VmssObject:                Virtual machine scale set object
    $OperatorConfirm:           Operator confirmation to remove the vmss
    
} #>
<# Process Flow {
    Function
        Call RemoveAzVmss > Get $null
            Call GetAzVmss > Get $VmssObject
            End GetAzVmss
                Return RemoveAzVmss > Send $VmssObject
        End RemoveAzVmss
            Return function > Send $null
}#>
function RemoveAzVmss {
    Begin {
        :RemoveAzureVmss while ($true) {                                                    # Outer loop for managing function
            if (!$VmssObject) {                                                             # If $VmssObject is $null
                $VmssObject = GetAzVmSS                                                     # Calls function and assigns output to $var
                if (!$VmssObject) {                                                         # If $VmssObject is $null
                    Break RemoveAzureVmss                                                   # Breaks :RemoveAzureVmss
                }                                                                           # End if (!$VmssObject)
            }                                                                               # End if (!$VmssObject)
            Write-Host 'Remove' $VmssObject.name                                            # Write message to screen
            $OperatorConfirm = Read-Host '[Y] or [N]'                                       # Operator confirmation for deletion
            if (!($OperatorConfirm -eq 'y')) {                                              # If $OperatorConfirm does not equal 'y'
                Break RemoveAzureVmss                                                       # Breaks :RemoveAzureVmss
            }                                                                               # End if (!($OperatorConfirm -eq 'y'))
            else {
                Try {                                                                       # Try the following
                    Remove-AzVmss -ResourceGroupName $VmssObject.ResourceGroupName `
                        -VMScaleSetName $VmssObject.name -Force                             # Removes the VMSS
                }                                                                           # End Try
                catch {                                                                     # If Try fails
                    Write-Host 'An error has occured'                                       # Write message to screen
                    Write-Host 'You may not have the required permissions'                  # Write message to screen
                }                                                                           # End catch
                Break RemoveAzureVmss                                                       # Breaks :RemoveAzureVmss
            }                                                                               # End else (if (!($OperatorConfirm -eq 'y')))
        }                                                                                   # End :RemoveAzureVmss while ($true)
    Return                                                                                  # Returns to calling function with $null 
    }                                                                                       # End Begin
}                                                                                           # End function RemoveAzVmss