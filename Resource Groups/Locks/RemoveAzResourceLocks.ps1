# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Mircosoft docs links
    Remove-AzResourceLock:      https://docs.microsoft.com/en-us/powershell/module/az.resources/remove-azresourcelock?view=azps-5.0.0
} #>
<# Required Functions Links: {
    None
} #>
<# Functions Description: {
    RemoveAzResourceLocks:      Removes locks
} #>
<# Variables: {
    :RemoveAzureLocks           Outer loop for managing function
    $Locks:                     Locks object
    $OperatorConfirm:           Operator confirmation that the lock found was the intended target
    $Temp:                      Holds the response from Remove-AzResourceLock
    $LocksRemoved:              Confirmation that all selected locks were removed
} #>
<# Process Flow {
    Function
        Call RemoveAzResourceLocks > Get $LocksRemoved
        End RemoveAzResourceLocks
            Return function > Send $LocksRemoved
}#>
function RemoveAzResourceLocks {                                                            # Function to remove resource locks
    Begin {                                                                                 # Begin function
        :RemoveAzureLocks while ($true) {                                                   # Outer loop for managing function
            if (!$Locks) {                                                                  # If $Locks is $null
                Write-Host 'No locks were passed to this function'                          # Write message to screen
                Start-Sleep(5)                                                              # Pauses all actions for 5 seconds
                Break RemoveAzureLocks                                                      # Breaks :RemoveAzureLocks
            }                                                                               # End if(!$Locks) 
            foreach ($_ in $Locks) {                                                        # For each item in $Locks
                Write-Host $_.Name                                                          # Write message to screen
            }                                                                               # End foreach ($_ in $Locks)
            if ($Locks.Count -gt 1) {                                                       # If $Locks.Count greater than 1
                Write-Host 'Remove these locks'                                             # Write message to screen
            }                                                                               # End if ($Locks.Count -gt 1)
            else {                                                                          # If $Locks.Count is not greater than 1
                Write-Host 'Remove this lock'                                               # Write message to screen
            }                                                                               # End else (if ($Locks.Count -gt 1))
            $OperatorConfirm = Read-Host '[Y] or [N]'                                       # Operator confirmation to remove the locks
            if ($OperatorConfirm -eq 'Y') {                                                 # If $Operatorconfirm equals 'y' 
                foreach ($_ in $Locks) {                                                    # For each item in $Locks
                    Try {                                                                   # Try the following
                        Write-Host 'Removing'$_.name                                        # Write message to screen
                        $Temp = Remove-AzResourceLock -LockId $_.LockId -force `
                            -ErrorAction 'Stop'                                             # Removes the current item in $Locks, $temp removes $True/$False from return
                    }                                                                       # End try
                    catch {                                                                 # If Try fails
                        Write-Host 'An error has occured'                                   # Write message to screen
                        $LocksRemoved = 'n'                                                 # Sets $LocksRemoved to 'n'
                        Start-Sleep(10)                                                     # Pauses actions for 10 seconds
                        Clear-Host                                                          # Clears Screen
                        Return $LocksRemoved                                                # Returns to calling function with $LocksRemoved
                    }                                                                       # End catch
                }                                                                           # End foreach ($_ in $Locks)
                if ($Locks.Count -gt 1) {                                                   # If $Locks.Count greater than 1
                    Write-Host 'Locks removed'                                              # Write message to screen
                }                                                                           # End if ($Locks.Count -gt 1)
                else {                                                                      # If $Locks.Count is not greater than 1
                    Write-Host 'Lock removed'                                               # Write message to screen
                }                                                                           # End else (if ($Locks.Count -gt 1))
                $LocksRemoved = 'y'                                                         # Sets $LocksRemoved to 'n'
                Start-Sleep(5)                                                              # Pauses actions for 10 seconds
                Clear-Host                                                                  # Clears Screen
                Return $LocksRemoved                                                        # Returns to calling function with $LocksRemoved
            }                                                                               # End if ($OperatorConfirm -eq 'Y') 
            else {                                                                          # Else if $Operatorconfirm is not equal to 'y'
                Write-Host "No changes made"                                                # Message write to screen
                Start-Sleep(5)                                                              # Pauses all actions for 5 seconds
                $LocksRemoved = 'n'                                                         # Sets $LocksRemoved to 'n'
                Return $LocksRemoved                                                        # Returns to calling function with $LocksRemoved
            }                                                                               # End else (if ($OperatorConfirm -eq 'Y') )
        }                                                                                   # End :RemoveAzureLocks while ($true)
        Clear-Host                                                                          # Clears Screen
        return                                                                              # Returns to calling function with $null
    }                                                                                       # End begin 
}                                                                                           # End function RemoveAzResourceLocks