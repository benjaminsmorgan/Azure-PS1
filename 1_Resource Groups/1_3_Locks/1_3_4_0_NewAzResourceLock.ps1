# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Microsoft docs links
    New-AzResourceLock:         https://docs.microsoft.com/en-us/powershell/module/az.resources/new-azresourcelock?view=azps-5.2.0
    Get-AzResource:             https://docs.microsoft.com/en-us/powershell/module/az.resources/get-azresource?view=azps-5.1.0
} #>
<# Required Functions Links: {
    GetAzResource:              https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/Resources/GetAzResource.ps1
} #>
<# Functions Description: {
    NewAzResourceLock:          Create a new resource lock on a resource
    GetAzResource:              Collects resources within a resource group
} #>
<# Variables: {
    :NewAzureRSLock:            Outer loop for managing function
    :SetAzureLockName:          Inner loop for setting the lock name
    :SetAzureLockLevel:         Inner loop for setting the lock level
    $RSObject:                  Resource object
    $CallingFunction:           The name of this function
    $LockName:                  Operator input for the lock name
    $OpConfirm:                 Operator confirmation of the lock name
    $LockLevel:                 Operator input for the lock level
    $LockNotes:                 Operator input for the lock notes
    $Locks:                     Lock object
    GetAzResource{}             Gets $RSObject
} #>
<# Process Flow {
    Function
        Call NewAzResourceLock > Get $Locks
            Call GetAzResource > Get RSObject
            End GetAzResource
                Return NewAzResourceLock > Send $RSObject    
        End NewAzResourceLock
                Return function > Send $Locks
}#>
function NewAzResourceLock {                                                                # Function to create a new resource lock on a resource
    Begin {                                                                                 # Begin function
        :NewAzureRSLock while ($true) {                                                     # Outer loop for managing fucntion
            if (!$RSObject) {                                                               # If $RSObject is $null
                $CallingFunction = 'NewAzResourceLock'                                      # Creates $CallingFunction
                $RSObject = GetAzResource ($CallingFunction)                                # Calls function and assigns output to $var                                         
                if (!$RSObject) {                                                           # If $RSObject is $null
                    Break NewAzureRSLock                                                    # Breaks :NewAzureRSLock
                }                                                                           # End if (!$RSObject) | Inner
            }                                                                               # End if (!$RSObject) | Outer
            :SetAzureLockName while ($true) {                                               # Inner loop for setting the lock name
                $LockName = Read-Host 'Lock Name?'                                          # Operator input for the lock name
                if ($LockName -eq '0') {                                                    # If $LockName equals '0'
                    Break NewAzureRSLock                                                    # Breaks :NewAzureRSLock
                }                                                                           # End if ($LockName -eq '0')
                Write-Host 'The lock name will be:' $LockName                               # Write message to screen
                $OpConfirm = Read-Host '[Y] or [N]'                                         # Operator input to confirm the lock name
                if ($OpConfirm -eq '0') {                                                   # If $OpConfirm equals '0' 
                    Break NewAzureRSLock                                                    # Breaks :NewAzureRSLock
                }                                                                           # End if ($OpConfirm -eq '0')
                elseif ($OpConfirm -eq 'y') {                                               # $OpConfirm equals 'y'
                    Break SetAzureLockName                                                  # Breaks :SetAzureLockName
                }                                                                           # End elseif ($OpConfirm -eq 'y')
                else {                                                                      # All other inputs for $OpConfirm
                    Write-Host 'That was not a valid input'                                 # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Clear-Host                                                              # Clears screen
                }                                                                           # End else (if ($OpConfirm -eq '0'))
            }                                                                               # End :SetAzureLockName while ($true)
            :SetAzureLockLevel while ($true) {                                              # Inner loop for setting lock level
                Write-Host '[0] Exit'                                                       # Write message to screen
                Write-Host '[1] Read Only'                                                  # Write message to screen
                Write-Host '[2] Can Not Delete'                                             # Write message to screen
                $LockLevel = Read-Host 'Option [#]'                                         # Operator input for the lock level
                if ($LockLevel -eq '0') {                                                   # If $LockLevel equals '0'
                    Break NewAzureRSLock                                                    # Breaks :NewAzureRSLock
                }                                                                           # End if ($LockLevel -eq '0')
                elseif ($LockLevel -eq '1') {                                               # If $LockLevel equals '1'
                    $LockLevel = 'ReadOnly'                                                 # Sets $LockLevel to 'ReadOnly'
                    Break SetAzureLockLevel                                                 # Breaks :SetAzureLockLevel
                }                                                                           # End elseif ($LockLevel -eq '1')
                elseif ($LockLevel -eq '2') {                                               # If $LockLevel equals '2'
                    $LockLevel = 'CanNotDelete'                                             # Sets $LockLevel to 'CanNotDelete'
                    Break SetAzureLockLevel                                                 # Breaks :SetAzureLockLevel
                }                                                                           # End elseif ($LockLevel -eq '2')
                else {                                                                      # All other inputs for $LockLevel
                    Write-Host 'That was not a valid input'                                 # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Clear-Host                                                              # Clears screen
                }                                                                           # End else (if ($LockLevel -eq '0'))
            }                                                                               # End :SetAzureLockLevel while($true)
            $LockNotes = Read-Host 'Enter any lock notes here'                              # Operator input for lock notes
            if ($LockNotes) {                                                               # If $LocksNotes has a value
                Try {                                                                       # Try the following
                    $Locks = New-AzResourceLock -LockLevel $LockLevel -LockNotes `
                        $LockNotes -LockName $LockName -ResourceName $RSObject.Name `
                        -ResourceType $RSObject.ResourceType -ResourceGroupName `
                        $RSObject.ResourceGroupName -Force -ErrorAction 'Stop'              # Deploys resource lock to resource (With lock notes)   
                }                                                                           # End try
                catch {                                                                     # If try fails
                    Write-Host 'An error has occured'                                       # Write message to screen
                    Write-Host 'You may not have permissions'                               # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Clear-Host                                                              # Clears the screen
                    Break NewAzureRSLock                                                    # Breaks :NewAzureRSLock
                }                                                                           # End catch
                if ($CallingFunction) {                                                     # If $CallingFunction has a value
                    Return $Locks                                                           # Returns to calling function with $var
                }                                                                           # End if ($CallingFunction)
                else {                                                                      # Else if $CallingFunction is $null
                    Return $null                                                            # Returns to calling function with $null
                }                                                                           # End else (if ($CallingFunction))
            }                                                                               # End if ($LockNotes)
            else {                                                                          # If $LockNotes is $null
                Try {                                                                       # Try the following
                    $Locks = New-AzResourceLock -LockLevel $LockLevel -LockName $LockName `
                        -ResourceName $RSObject.Name -ResourceType $RSObject.ResourceType `
                        -ResourceGroupName $RSObject.ResourceGroupName -Force `
                        -ErrorAction 'Stop'                                                 # Deploys resource lock to resource
                }                                                                           # End try
                catch {                                                                     # If try fails
                    Write-Host 'An error has occured'                                       # Write message to screen
                    Write-Host 'You may not have permissions'                               # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Break NewAzureRSLock                                                    # Breaks :NewAzureRSLock
                    Clear-Host                                                              # Clears the screen
                }                                                                           # End catch
                if ($CallingFunction) {                                                     # If $CallingFunction has a value
                    Return $Locks                                                           # Returns to calling function with $var
                }                                                                           # End if ($CallingFunction)
                else {                                                                      # Else if $CallingFunction is $null
                    Return $null                                                            # Returns to calling function with $null
                }                                                                           # End else (if ($CallingFunction))
            }                                                                               # End else (if ($LockNotes))
        }                                                                                   # End :NewAzureRSLock while ($true) 
        Clear-Host                                                                          # Clears the screen
        Return                                                                              # Returns to calling function with $null
    }                                                                                       # End begin
}                                                                                           # End function NewAzResourceLock