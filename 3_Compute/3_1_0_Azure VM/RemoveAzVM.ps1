# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Microsoft docs links
    Remove-AzVM:                https://docs.microsoft.com/en-us/powershell/module/az.compute/Remove-azvm?view=azps-5.4.0
    Get-AzVM:                   https://docs.microsoft.com/en-us/powershell/module/az.compute/get-azvm?view=azps-5.4.0
} #>
<# Required Functions Links: {
    GetAzVM:                    https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Compute/Azure%20VM/GetAzVM.ps1
} #>
<# Functions Description: {
    RemoveAzVM:                 Function to remove a VM
    GetAzVM:                    Function to get a VM
} #>
<# Variables: {
    :RemoveAzureVM              Outer loop for managing function
    $CallingFunction:           Name of this function or the one that called it
    $VMObject:                  Virtual machine object
    $OpConfirm:                 Operator confirmation to remove the VM
    $MSG:                       Last powershell error message
} #>
<# Process Flow {
    RemoveAzVM
        Call GetAzVM > Get $VMObject
}#>
function RemoveAzVM {                                                                       # Function to remove a VM
    Begin {                                                                                 # Begin function
        if (!$CallingFunction) {                                                            # If $CallingFunction is $null
            $CallingFunction = 'RemoveAzVM'                                                 # Creates $CallingFunction
        }                                                                                   # End if (!$CallingFunction)
        :RemoveAzureVM while ($true) {                                                      # Outer loop for managing function
            $VMObject = GetAzVM ($CallingFunction)                                          # Calls function and assigns output to $var
            if (!$VMObject) {                                                               # If $VMObject is $null
                Break RemoveAzureVM                                                         # Breaks :RemoveAzureVM
            }                                                                               # End if (!$VMObject)
            Write-Host 'Remove:'$VMObject.name                                              # Write message to screen
            Write-Host ''                                                                   # Writes message to screen
            $OpConfirm = Read-Host '[Y] Yes [N] No'                                         # Operator confirmation to turn on the VM
            if ($OpConfirm -eq 'y') {                                                       # If $OpConfirm equals 'y'
                Try {                                                                       # Try the following
                    Write-Host 'Attempting to remove:'$VMObject.Name                        # Write message to screen
                    Remove-AzVM -Name $VMObject.Name -ResourceGroup `
                    $VMObject.ResourceGroupName -Force -ErrorAction 'Stop' | Out-Null       # Removes the selected VM
                }                                                                           # End try
                Catch {                                                                     # If Try fails
                    Clear-Host                                                              # Clears screen
                    Write-Host 'An error has occured'                                       # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    $MSG = $Error[0]                                                        # Gets the error message
                    if ($MSG.Exception.InnerException.Body.Message) {                       # If $MSG.Exception.InnerException.Body.Message has a value             
                        $MSG = $MSG.Exception.InnerException.Body.Message                   # Isolates the error message
                        Write-Warning $MSG                                                  # Write message to screen
                        Write-Host ''                                                       # Write message to screen    
                    }                                                                       # End if ($MSG.Exception.InnerException.Body.Message)
                    else {                                                                  # Else if $MSG.Exception.InnerException.Body.Message is $null
                        Write-Warning $MSG                                                  # Write message to screen
                        Write-Host ''                                                       # Write message to screen        
                    }                                                                       # End else (if ($MSG.Exception.InnerException.Body.Message))
                    Write-Host 'No changes have been made'                                  # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Break RemoveAzureVM                                                     # Breaks :RemoveAzureVM
                }                                                                           # End catch
                Write-Host $VMObject.Name 'has been removed'                                # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break RemoveAzureVM                                                         # Breaks :RemoveAzureVM
            }                                                                               # End if ($OpConfirm -eq 'y')
            else {                                                                          # All other inputs for $OpConfirm
                Write-Host 'No action taken'                                                # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break RemoveAzureVM                                                         # Breaks :RemoveAzureVM
            }                                                                               # End else (if ($OpConfirm -eq 'y'))                                                                
        }                                                                                   # End :RemoveAzureVM while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function RemoveAzVM