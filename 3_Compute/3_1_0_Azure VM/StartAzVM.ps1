# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Microsoft docs links
    Start-AzVM:                                 https://docs.microsoft.com/en-us/powershell/module/az.compute/Start-azvm?view=azps-5.4.0
    Get-AzVM:                                   https://docs.microsoft.com/en-us/powershell/module/az.compute/get-azvm?view=azps-5.4.0
} #>
<# Required Functions Links: {
    GetAzVM:                    https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Compute/Azure%20VM/GetAzVM.ps1
} #>
<# Functions Description: {
    StartAzVM:                  Function to start a VM
    GetAzVM:                    Function to get a VM
} #>
<# Variables: {
    :StartAzureVM               Outer loop for managing function
    $CallingFunction:           Name of this function or the one that called it
    $VMObject:                  Virtual machine object
    $VMStatus:                  $VMObjects current power status
    $OpConfirm:                 Operator confirmation to Start the VM
    $MSG:                       Last powershell error message
} #>
<# Process Flow {
    StartAzVM
        GetAzVM > Get $VMObject
}#>
function StartAzVM {                                                                        # Function to start a VM
    Begin {                                                                                 # Begin function
        if (!$CallingFunction) {                                                            # If $CallingFunction is $null
            $CallingFunction = 'StartAzVM'                                                  # Creates $CallingFunction
        }                                                                                   # End if (!$CallingFunction)
        :StartAzureVM while ($true) {                                                       # Outer loop for managing function
            $VMObject = GetAzVM ($CallingFunction)                                          # Calls function and assigns output to $var
            if (!$VMObject) {                                                               # If $VMObject is $null
                Break StartAzureVM                                                          # Breaks :StartAzureVM
            }                                                                               # End if (!$VMObject)
            $VMStatus = (Get-AzVM -Name $VMObject.Name -ResourceGroupName `
                $VMObject.ResourceGroupName -Status).Statuses[1].Code                       # Pulls $VMObjects power state
            if ($VMStatus -ne 'PowerState/deallocated') {                                   # If $VMStatus does not equal 'PowerState/deallocated'
                Write-Host 'This VM is already powered on (Allocated)'                      # Write message ot screen
                Write-Host ''                                                               # Write message ot screen
                Write-Host 'No changes have been made'                                      # Write message ot screen
                Write-Host ''                                                               # Write message ot screen
                Pause                                                                       # Pauses all actions for operator input
                Break StartAzureVM                                                          # Breaks :StartAzureVM        
            }                                                                               # End if ($VMStatus -ne 'PowerState/deallocated')
            Write-Host 'Power on:'$VMObject.name                                            # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            $OpConfirm = Read-Host '[Y] Yes [N] No'                                         # Operator confirmation to turn on the VM
            Clear-Host                                                                      # Clears screen
            if ($OpConfirm -eq 'y') {                                                       # If $OpConfirm equals 'y'
                Try {                                                                       # Try the following
                    Write-Host 'Attempting to power on:'$VMObject.Name                      # Write message to screen
                    Start-AzVM -Name $VMObject.Name -ResourceGroup `
                    $VMObject.ResourceGroupName -ErrorAction 'Stop' | Out-Null              # Starts the selected VM
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
                    Break StartAzureVM                                                      # Breaks :StartAzureVM
                }                                                                           # End catch
                Clear-Host                                                                  # Clears screen
                Write-Host $VMObject.Name 'has been powered on'                             # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break StartAzureVM                                                          # Breaks :StartAzureVM
            }                                                                               # End if ($OpConfirm -eq 'y')
            else {                                                                          # All other inputs for $OpConfirm
                Write-Host 'No action taken'                                                # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break StartAzureVM                                                          # Breaks :StartAzureVM
            }                                                                               # End else (if ($OpConfirm -eq 'y'))                                                                
        }                                                                                   # End :StartAzureVM while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function StartAzVM