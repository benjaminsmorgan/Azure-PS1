# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Mircosoft docs links
    Invoke-AzVMReimage:         https://docs.microsoft.com/en-us/powershell/module/az.compute/Invoke-AzVMReimage?view=azps-5.4.0
    Get-AzVM:                   https://docs.microsoft.com/en-us/powershell/module/az.compute/get-azvm?view=azps-5.4.0
} #>
<# Required Functions Links: {
    GetAzVM:                    https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Compute/Azure%20VM/GetAzVM.ps1
} #>
<# Functions Description: {
    ReimageAzVM:                Reimages a VM object
    GetAzVM:                    Gets a VM object
} #>
<# Variables: {
    :ReimageAzVM                Outer loop for managing function
    $VMObject:                  Virtual machine object
    $OperatorConfirm:           Operator confirmation to remove the VM
    
} #>
<# Process Flow {
    Function
        Call ReimageAzVM > Get $null
            Call GetAzVM > Get $VMObject
            End GetAzVMWin
                Return ReimageAzVM > Send $VMObject
        End ReimageAzVM
            Return function > Send $null
}#>
function ReimageAzVM { # Function to remove a VM
    Begin {
        $ErrorActionPreference='silentlyContinue'
        :ReimageAzVM while ($true) { # Outer loop for managing function
            if (!$VMObject) { # If $VMObject is $null
                $VMObject = GetAzVM # Calls function and assigns output to $var
                if (!$VMObject) { # If $VMObject is $null
                    Break ReimageAzVM # Breaks :ReimageAzVM
                } # End if (!$VMVM)
            } # End if (!$VMVM)
            $OperatorConfirm = Read-Host "Reimage"$VMObject.Name "[Y] or [N]"
            if (!($OperatorConfirm -eq 'y')) { # If OperatorConfirm does not equal 'y'
                Write-Host "No action taken" # Write message to screen
                Break ReimageAzVM # Breaks :ReimageAzVM
            } # End if (!($OperatorConfirm -eq 'y'))
            Write-Host "Attempting to reimage" $VMObject.Name # Write message to screen
            try { # Try the following
                Invoke-AzVMReimage -Name $VMObject.Name -ResourceGroup $VMObject.ResourceGroupName -ErrorAction 'stop' # Reimages the selected VM
            } # End Try
            catch { # If try fails
                Write-Host "" # Write message to screen
                Write-Host "***An Error Has Occured***" # Write message to screen
                Write-Host "Un-able to reimage the selected VM" # Write message to screen
                Write-Host "Auto OS upgrades may not be enabled" # Write message to screen
                Write-Host "You may not have permission to this VM" # Write message to screen
                Write-Host "The VM or group may be locked" # Write message to screen
                Write-Host "" # Write message to screen
                Break ReimageAzVM # Breaks :ReimageAzVM
            } # End Catch
            Break ReimageAzVM # Breaks :ReimageAzVM
        } # End :ReimageAzVM while ($true)
        Return # Returns to calling function with $null
    } # End Begin
} # End function ReimageAzVM