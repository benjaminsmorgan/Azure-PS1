# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Mircosoft docs links
    Start-AzVM:                 https://docs.microsoft.com/en-us/powershell/module/az.compute/Start-azvm?view=azps-5.4.0
    Get-AzVM:                   https://docs.microsoft.com/en-us/powershell/module/az.compute/get-azvm?view=azps-5.4.0
} #>
<# Required Functions Links: {
    GetAzVM:                    https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Compute/Azure%20VM/GetAzVM.ps1
} #>
<# Functions Description: {
    StartAzVM:                  Starts a VM object
    GetAzVM:                    Gets a VM object
} #>
<# Variables: {
    :StartAzureVM               Outer loop for managing function
    $VMObject:                  Virtual machine object
    $OperatorConfirm:           Operator confirmation to Start the VM
    
} #>
<# Process Flow {
    Function
        Call StartAzVM > Get $null
            Call GetAzVM > Get $VMObject
            End GetAzVMWin
                Return StartAzVM > Send $VMObject
        End StartAzVM
            Return function > Send $null
}#>
function StartAzVM { # Function to start a VM
    Begin {
        :StartAzureVM while ($true) { # Outer loop for managing function
            if (!$VMObject) { # If $VMObject is $null
                $VMObject = GetAzVM # Calls function and assigns output to $var
                if (!$VMObject) { # If $VMObject is $null
                    Break StartAzureVM # Breaks :StartAzureVM
                } # End if (!$VMVM)
            } # End if (!$VMVM)
            $OperatorConfirm = Read-Host "Power on "$VMObject.Name "[Y] or [N]"
            if (!($OperatorConfirm -eq 'y')) { # If OperatorConfirm does not equal 'y'
                Write-Host "No action taken" # Write message to screen
                Break StartAzureVM # Breaks :StartAzureVM
            } # End if (!($OperatorConfirm -eq 'y'))
            Write-Host "Attempting to power on" $VMObject.Name # Write message to screen
            Start-AzVM -Name $VMObject.Name -ResourceGroup $VMObject.ResourceGroupName # Starts the selected VM
            Break StartAzureVM # Breaks :StartAzureVM
        } # End :StartAzureVM while ($true)
        Return # Returns to calling function with $null
    } # End Begin
} # End function StartAzVM