# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Mircosoft docs links
    Remove-AzVM:                https://docs.microsoft.com/en-us/powershell/module/az.compute/Remove-azvm?view=azps-5.4.0
    Get-AzVM:                   https://docs.microsoft.com/en-us/powershell/module/az.compute/get-azvm?view=azps-5.4.0
} #>
<# Required Functions Links: {
    GetAzVM:                    https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Compute/Azure%20VM/GetAzVM.ps1
} #>
<# Functions Description: {
    RemoveAzVM:                 Removes a VM object
    GetAzVM:                    Gets a VM object
} #>
<# Variables: {
    :RemoveAzureVM              Outer loop for managing function
    $VMObject:                  Virtual machine object
    $OperatorConfirm:           Operator confirmation to remove the VM
    
} #>
<# Process Flow {
    Function
        Call RemoveAzVM > Get $null
            Call GetAzVM > Get $VMObject
            End GetAzVMWin
                Return RemoveAzVM > Send $VMObject
        End RemoveAzVM
            Return function > Send $null
}#>
function RemoveAzVM {                                                                       # Function to remove a VM
    Begin {                                                                                 # Begin function
        $ErrorActionPreference='silentlyContinue'                                           # Disables powershell reporting
        :RemoveAzureVM while ($true) {                                                      # Outer loop for managing function
            if (!$VMObject) {                                                               # If $VMObject is $null
                $VMObject = GetAzVM                                                         # Calls function and assigns output to $var
                if (!$VMObject) {                                                           # If $VMObject is $null
                    Break RemoveAzureVM                                                     # Breaks :RemoveAzureVM
                }                                                                           # End if (!$VMObject)
            }                                                                               # End if (!$VMObject)
            $OperatorConfirm = Read-Host "Remove"$VMObject.Name "[Y] or [N]"                # Operator confirmation to remove the VM
            if (!($OperatorConfirm -eq 'y')) {                                              # If OperatorConfirm does not equal 'y'
                Write-Host "No action taken"                                                # Write message to screen
                Break RemoveAzureVM                                                         # Breaks :RemoveAzureVM
            }                                                                               # End if (!($OperatorConfirm -eq 'y'))
            Write-Host "Attempting to remove" $VMObject.Name                                # Write message to screen
            Try {                                                                           # Try the following
            Remove-AzVM -Name $VMObject.Name -ResourceGroup $VMObject.ResourceGroupName `
                -force -ErrorAction 'Stop'                                                  # Removes the selected VM
            }                                                                               # End Try
            Catch {                                                                         # If try fails
                Write-host ''                                                               # Write message to screen
                Write-Host 'An error has occured'                                           # Write message to screen
                Write-Host 'The VM was not removed'                                         # Write message to screen
                Write-Host 'You may not have the permissions'                               # Write message to screen
                Write-host ''                                                               # Write message to screen
                Break RemoveAzureVM                                                         # Breaks :RemoveAzureVM
            }                                                                               # End catch
            Break RemoveAzureVM                                                             # Breaks :RemoveAzureVM
        }                                                                                   # End :RemoveAzureVM while ($true)
        Return                                                                              # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function RemoveAzVM