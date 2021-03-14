# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Mircosoft docs links
    Stop-AzVM:                  https://docs.microsoft.com/en-us/powershell/module/az.compute/stop-azvm?view=azps-5.4.0
    Get-AzVM:                   https://docs.microsoft.com/en-us/powershell/module/az.compute/get-azvm?view=azps-5.4.0
} #>
<# Required Functions Links: {
    GetAzVM:                    https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Compute/Azure%20VM/GetAzVM.ps1
} #>
<# Functions Description: {
    StopAzVM:                   Stops a VM object
    GetAzVM:                    Gets a VM object
} #>
<# Variables: {
    :StopAzureVM                Outer loop for managing function
    $VMObject:                  Virtual machine object
    $OperatorConfirm:           Operator confirmation to stop the VM
    
} #>
<# Process Flow {
    Function
        Call StopAzVM > Get $null
            Call GetAzVM > Get $VMObject
            End GetAzVMWin
                Return StopAzVM > Send $VMObject
        End StopAzVM
            Return function > Send $null
}#>
function StopAzVM {                                                                         # Function to deallocate a VM
    Begin {                                                                                 # Begin function
        :StopAzureVM while ($true) {                                                        # Outer loop for managing function
            if (!$VMObject) {                                                               # If $VMObject is $null
                $VMObject = GetAzVM                                                         # Calls function and assigns output to $var
                if (!$VMObject) {                                                           # If $VMObject is $null
                    Break StopAzureVM                                                       # Breaks :StopAzureVM
                }                                                                           # End if (!$VMObject)
            }                                                                               # End if (!$VMObject)
            $OperatorConfirm = Read-Host "Shutdown"$VMObject.Name "[Y] or [N]"              # Operator input to shutdown the VM
            if (!($OperatorConfirm -eq 'y')) {                                              # If OperatorConfirm does not equal 'y'
                Write-Host "No action taken"                                                # Write message to screen
                Break StopAzureVM                                                           # Breaks :StopAzureVM
            }                                                                               # End if (!($OperatorConfirm -eq 'y'))
            Write-Host "Attempting to shut off" $VMObject.Name                              # Write message to screen
            Stop-AzVM -Name $VMObject.Name -ResourceGroup $VMObject.ResourceGroupName `
                -force                                                                      # Stops the selected VM
            Break StopAzureVM                                                               # Breaks :StopAzureVM
        }                                                                                   # End :StopAzureVM while ($true)
        Return                                                                              # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function StopAzVM