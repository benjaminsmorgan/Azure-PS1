# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Mircosoft docs links
    New-AzResourceLock:         https://docs.microsoft.com/en-us/powershell/module/az.resources/new-azresourcelock?view=azps-5.2.0
    Get-AzResourceGroup:        https://docs.microsoft.com/en-us/powershell/module/az.resources/get-azresourcegroup?view=azps-5.1.0
} #>
<# Required Functions Links: {
    GetAzResourceGroup:         https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/Resource%20Groups/GetAzResourceGroup.ps1
} #>
<# Functions Description: {
    NewAzResourceGroupLock:     Create a new resource lock on a resource group
    GetAzResourceGroup:         Collects resource group object
} #>
<# Variables: {
    :NewAzureRGLock:            Outer loop for managing function
    :SetAzureLockName:          Inner loop for setting the lock name
    :SetAzureLockLevel:         Inner loop for setting the lock level
    $RGObject:                  Resource group object
    $CallingFunction:           The name of this function
    $LockName:                  Operator input for the lock name
    $OpConfirm:                 Operator confirmation of the lock name
    $LockLevel:                 Operator input for the lock level
    $LockNotes:                 Operator input for the lock notes
    $Locks:                     Lock object
    GetAzResourceGroup{}        Gets $RGObject
} #>
<# Process Flow {
    Function
        Call NewAzResourceGroupLock > Get $Locks
            Call GetAzResourceGroup > Get RGObject
            End GetAzResourceGroup
                Return NewAzResourceGroupLock > Send $RGObject
            End NewAzResourceGroupLock
                Return function > Send $Locks
}#>
function NewAzResourceGroupLock {                                                           # Function to create a new resource lock on a resource group
    Begin {                                                                                 # Begin function
        :NewAzureRGLock while ($true) {                                                     # Outer loop for managing fucntion
            if (!$RGObject) {                                                               # If $RGObject is $null
                $CallingFunction = 'NewAzResourceGroupLock'                                 # Creates $CallingFunction
                $RGObject = GetAzResourceGroup ($CallingFunction)                           # Calls function and assigns output to $var                                         
                if (!$RGObject) {                                                           # If $RGObject is $null
                    Break NewAzureRGLock                                                    # Breaks :NewAzureRGLock
                }                                                                           # End if (!$RGObject) | Inner
            }                                                                               # End if (!$RGObject) | Outer
            :SetAzureLockName while ($true) {                                               # Inner loop for setting the lock name
                $LockName = Read-Host "Lock Name?"                                          # Operator input for the lock name
                if ($LockName -eq 'exit') {                                                 # If $LockName equals 'exit'
                    Break NewAzureRGLock                                                    # Breaks :NewAzureRGLock
                }                                                                           # End if ($LockName -eq 'exit')
                Write-Host "The lock name will be" $LockName                                # Write message to screen
                $OpConfirm = Read-Host '[Y] or [N]'                                         # Operator input to confirm the lock name
                if ($OpConfirm -eq 'exit') {                                                # If $OpConfirm equals 'exit' 
                    Break NewAzureRGLock                                                    # Breaks :NewAzureRGLock
                }                                                                           # End if ($OpConfirm -eq 'exit')
                elseif ($OpConfirm -eq 'y') {                                               # $OpConfirm equals 'y'
                    Break SetAzureLockName                                                  # Breaks :SetAzureLockName
                }                                                                           # End elseif ($OpConfirm -eq 'y')
                else {                                                                      # All other inputs for $OpConfirm
                    Write-Host 'That was not a valid input'                                 # Write message to screen
                }                                                                           # End else (if ($OpConfirm -eq 'exit'))
            }                                                                               # End :SetAzureLockName while ($true)
            :SetAzureLockLevel while ($true) {                                              # Inner loop for setting lock level
                Write-Host '[1] Read Only'                                                  # Write message to screen
                Write-Host '[2] Can Not Delete'                                             # Write message to screen
                Write-Host '[Exit] to leave function'                                       # Write message to screen
                $LockLevel = Read-Host 'Option [#]'                                         # Operator input for the lock level
                if ($LockLevel -eq 'exit') {                                                # If $LockLevel equals 'exit'
                    Break NewAzureRGLock                                                    # Breaks :NewAzureRGLock
                }                                                                           # End if ($LockLevel -eq 'exit')
                elseif ($LockLevel -eq '1') {                                               # If $LockLevel equals '1'
                    $LockLevel = 'ReadOnly'                                                 # Sets $LockLevel to 'ReadOnly'
                    Break SetAzureLockLevel                                                 # Breaks :SetAzureLockLevel
                }                                                                           # End elseif ($LockLevel -eq '1')
                elseif ($LockLevel -eq '2') {                                               # If $LockLevel equals '2'
                    $LockLevel = 'CanNotDelete'                                             # Sets $LockLevel to 'CanNotDelete'
                    Break SetAzureLockLevel                                                 # Breaks :SetAzureLockLevel
                }                                                                           # End elseif ($LockLevel -eq '2')
                else {                                                                      # All other inputs for $LockLevel
                    Write-Host "That is not a valid option"                                 # Write message to screen
                }                                                                           # End else (if ($LockLevel -eq 'exit'))
            }                                                                               # End :SetAzureLockLevel while($true)
            $LockNotes = Read-Host 'Enter any lock notes here'                              # Operator input for lock notes
            if ($LockNotes) {                                                               # If $LocksNotes has a value
                Try {                                                                       # Try the following
                    $Locks = New-AzResourceLock -LockLevel $LockLevel -LockNotes `
                        $LockNotes -LockName $LockName -ResourceGroupName `
                        $RGObject.ResourceGroupName -Force -ErrorAction 'Stop'              # Deploys resource lock to resource group (With lock notes)   
                }                                                                           # End try
                catch {                                                                     # If try fails
                    Write-Host 'An error has occured'                                       # Write message to screen
                    Write-Host 'You may not have permissions'                               # Write message to screen
                    Start-Sleep(10)                                                         # Pauses all actions for 10 seconds
                    Break NewAzureRGLock                                                    # Breaks :NewAzureRGLock
                }                                                                           # End catch
                Clear-Host                                                                  # Clears the screen
                Return $Locks                                                               # Returns to calling function with $var
            }                                                                               # End if ($LockNotes)
            else {                                                                          # If $LockNotes is $null
                Try {                                                                       # Try the following
                    $Locks = New-AzResourceLock -LockLevel $LockLevel -LockName $LockName `
                        -ResourceGroupName $RGObject.ResourceGroupName -Force `
                        -ErrorAction 'Stop'                                                 # Deploys resource lock to resource group   
                }                                                                           # End try
                catch {                                                                     # If try fails
                    Write-Host 'An error has occured'                                       # Write message to screen
                    Write-Host 'You may not have permissions'                               # Write message to screen
                    Start-Sleep(10)                                                         # Pauses all actions for 10 seconds
                    Break NewAzureRGLock                                                    # Breaks :NewAzureRGLock
                }                                                                           # End catch
                Clear-Host                                                                  # Clears the screen
                Return $Locks                                                               # Returns to calling function with $var
            }                                                                               # End else (if ($LockNotes))
        }                                                                                   # End :NewAzureRGLock while ($true) 
        Clear-Host                                                                          # Clears the screen
        Return                                                                              # Returns to calling function with $null
    }                                                                                       # End begin
}                                                                                           # End function NewAzResourceGroupLock