# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Microsoft docs links
    Stop-AzVM:                                  https://docs.microsoft.com/en-us/powershell/module/az.compute/stop-azvm?view=azps-5.4.0
    Get-AzVM:                                   https://docs.microsoft.com/en-us/powershell/module/az.compute/get-azvm?view=azps-5.4.0
} #>
<# Required Functions Links: {
    GetAzVM:                    https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Compute/Azure%20VM/GetAzVM.ps1
} #>
<# Functions Description: {
    StopAzVM:                   Function to deallocate a VM
    GetAzVM:                    Function to get a VM
} #>
<# Variables: {
    :StopAzureVM                Outer loop for managing function
    $CallingFunction:           Name of this function or the one that called it
    $VMObject:                  Virtual machine object
    $VMStatus:                  $VMObjects current power status
    $OperatorConfirm:           Operator confirmation to stop the VM
    $MSG:                       Last powershell error message
} #>
<# Process Flow {
    StopAzVM
        GetAzVM > Get $VMObject
}#>
function StopAzVM {                                                                         # Function to deallocate a VM
    Begin {                                                                                 # Begin function
        if (!$CallingFunction) {                                                            # If $CallingFunction is $null
            $CallingFunction = 'StopAzVM'                                                   # Creates $CallingFunction
        }                                                                                   # End if (!$CallingFunction)
        :StopAzureVM while ($true) {                                                        # Outer loop for managing function
            $VMObject = GetAzVM ($CallingFunction)                                          # Calls function and assigns output to $var
            if (!$VMObject) {                                                               # If $VMObject is $null
                Break StopAzureVM                                                           # Breaks :StopAzureVM
            }                                                                               # End if (!$VMObject)
            $VMStatus = (Get-AzVM -Name $VMObject.Name -ResourceGroupName `
                $VMObject.ResourceGroupName -Status).Statuses[1].Code                       # Pulls $VMObjects power state
            if ($VMStatus -eq 'PowerState/deallocated') {                                   # If $VMStatus equals 'PowerState/deallocated'
                Write-Host 'This VM is already powered off (Deallocated)'                   # Write message ot screen
                Write-Host ''                                                               # Write message ot screen
                Write-Host 'No changes have been made'                                      # Write message ot screen
                Write-Host ''                                                               # Write message ot screen
                Pause                                                                       # Pauses all actions for operator input
                Break StopAzureVM                                                           # Breaks :StopAzureVM        
            }                                                                               # End if ($VMStatus -eq 'PowerState/deallocated')
            Write-Host 'Power off:'$VMObject.name                                           # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            $OpConfirm = Read-Host '[Y] Yes [N] No'                                         # Operator confirmation to turn off the VM
            Clear-Host                                                                      # Clears screen
            if ($OpConfirm -eq 'y') {                                                       # If $OpConfirm equals 'y'
                Try {                                                                       # Try the following
                    Write-Host 'Attempting to power off:'$VMObject.Name                     # Write message to screen
                    Stop-AzVM -Name $VMObject.Name -ResourceGroup `
                    $VMObject.ResourceGroupName -force -ErrorAction 'Stop' | Out-Null       # Stops the selected VM
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
                    Break StopAzureVM                                                       # Breaks :StopAzureVM
                }                                                                           # End catch
                Write-Host $VMObject.Name 'has been powered off'                            # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break StopAzureVM                                                           # Breaks :StopAzureVM
            }                                                                               # End if ($OpConfirm -eq 'y')
            else {                                                                          # All other inputs for $OpConfirm
                Clear-Host                                                                  # Clears screen
                Write-Host 'No action taken'                                                # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break StopAzureVM                                                           # Breaks :StopAzureVM
            }                                                                               # End else (if ($OpConfirm -eq 'y'))
        }                                                                                   # End :StopAzureVM while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function StopAzVM