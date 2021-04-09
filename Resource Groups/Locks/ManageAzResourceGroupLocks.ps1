# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Mircosoft docs links
    New-AzResourceLock:         https://docs.microsoft.com/en-us/powershell/module/az.resources/new-azresourcelock?view=azps-5.2.0
    Get-AzResourceLock:         https://docs.microsoft.com/en-us/powershell/module/az.resources/get-azresourcelock?view=azps-5.0.0
    Remove-AzResourceLock:      https://docs.microsoft.com/en-us/powershell/module/az.resources/remove-azresourcelock?view=azps-5.0.0
    Get-AzResourceGroup:        https://docs.microsoft.com/en-us/powershell/module/az.resources/get-azresourcegroup?view=azps-5.1.0
    Get-AzResource:             https://docs.microsoft.com/en-us/powershell/module/az.resources/get-azresource?view=azps-5.1.0

} #>
<# Required Functions Links: {
    NewAzResourceGroupLock:     https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/Locks/ManageAzResourceGroupLocks.ps1
    NewAzResourceLock:          https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/Locks/NewAzResourceLock.ps1
    GetAzResourceGroupLocksAll: https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/Locks/GetAzResourceGroupLocksAll.ps1
    GetAzResourceGroupLockNamed:https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/Locks/GetAzResourceGroupLockNamed.ps1
    GetAzResourceLocksAll:      https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/Locks/GetAzResourceLocksAll.ps1
    GetAzResourceLockNamed:     https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/Locks/GetAzResourceLockNamed.ps1
    RemoveAzResourceGroupLocks: https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/Locks/RemoveAzResourceLocks.ps1
    GetAzResourceGroup:         https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/GetAzResourceGroup.ps1
    GetAzResource:              https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/GetAzResource.ps1
} #>
<# Functions Description: {
    ManageAzResourceGroupLocks: Management function for Locks functions
    NewAzResourceGroupLock:     Create a new resource lock on a resource group
    GetAzResourceGroupLocksAll: Collects all locks on a resource group and its resources
    GetAzResourceGroupLockNamed:Collects a named locks on a resource group
    GetAzResourceLocksAll:      Collects all locks on a resource
    GetAzResourceLockNamed:     Collects a named lock on a resource
    GetAzResourceGroup:         Collects resource group object
    GetAzResource:              Collects resources within a resource group
} #>
<# Variables: {
    ManageAzResourceGroupLocks {
        :ManageAzureRGLocks     Outer loop for function
        $OPSelect:  Operator input for management option
        $OperatorSelect:        Operator input for clearing $Vars
        $ForEachCount:          Number used in foreach statement for each found resource
        NewAzResourceGroupLock {
            $RGObject:              Resource group object
            $LockName:              Operator input for the lock name
            $LockLevel:             Operator input for the lock level
            $LockNotes:             Optional operator input for the lock notes
            $Locks:                 Locks object
            :NewAzureRGLock         Outer loop for function
            :GetAzureLockName       Inner loop for getting lock name
            :GetAzureLockLevel      Inner loop for getting lock level
        }
        NewAzResourceLock {
            $RGObject:              Resource group object
            $RSObject:              Resource object
            $LockName:              Operator input for the lock name
            $LockLevel:             Operator input for the lock level
            $LockNotes:             Optional operator input for the lock notes
            $Locks:                 Locks object
            :NewAzureRSLock         Outer loop for function
            :GetAzureLockName       Inner loop for getting lock name
            :GetAzureLockLevel      Inner loop for getting lock level
        }
        GetAzResourceGroupLocksAll {
            $RGObject:              Resource group object
            $Locks:                 Locks object
        }
        GetAzResourceGroupLockNamed {
            $RGObject:              Resource group object
            $Locks:                 Locks object
            $LocksInput:            Input to collect a named lock
            $LocksList:             Object containing all locks within the resource group
            $OperatorConfirm:       Operator confirmation that the lock found was the intended 
        }
        GetAzResourceLocksAll {
            $RGObject:              Resource group object
            $RSObject:              Resource object
            $Locks:                 Locks object
        }
        GetAzResourceLockNamed {
            $RGObject:              Resource group object
            $RSObject:              Resource object
            $Locks:                 Lock objects
            $OperatorConfirm:       Operator input that the correct object has been found
        }
        RemoveAzResourceLocks {
            $Locks:                 Lock or locks object
        }    
        GetAzResourceGroup {
            $RGObject:              Resource group object
            $RGObjectInput:         Operator input for the resource group name
            $RGList:                Variable used for printing all resource groups to screen if needed
        }
            GetAzResource {
            $RGObject:              Resource group object
            $RSObject:              Resource object
            $RSObjectInput:         Operator input for the resource name
            $RSList:                Variable used for printing all resources to screen if needed
        }
    } End ManageAzResourceGroupLocks
} #>
<# Process Flow {
    Function
        Call ManageAzResourceGroupLock
            Call NewAzResourceGroupLock > Get $Locks
                Return ManageAzResourceGroupLock > Send $Locks
            Call NewAzResourceLock > Get $Locks 
                Return ManageAzResourceGroupLock > Send $Locks
            Call GetAzResourceGroupLocksAll > Get $Locks
                Call GetAzResourceGroup > Get $RGObject
                    Return GetAzResourceGroupLocksAll > Send $RGObject
                Return ManageAzResourceGroupLock > Send $Locks
            Call GetAzResourceGroupLockNamed > Get $Locks
                Call GetAzResourceGroup > Get RGObject
                    Return GetAzResourceGroup > Send $RGObject
                Return ManageAzResourceGroupLock > Send $Locks                
            Call GetAzResourceLocksAll > Get $Locks
                Call GetAzResourceGroup > Get $RGObject
                    Return GetAzResourceLocksAll > Send $RGObject
                Call GetAzResource > Get $RSObject
                    Return GetAzResource > Send $RSObject
                Return ManageAzResourceGroupLock > Send $Locks
            Call GetAzResourceLockNamed > Get $Locks
                Call GetAzResourceGroup > Get $RGObject
                    Return GetAzResourceLockNamed > Send $RGObject
                Call GetAzResource > Get $RSObject
                    Return GetAzResourceLockNamed > Send $RSObject
                Return ManageAzResourceGroupLock > Send $Locks
            Call RemoveAzResourceLocks > Send $Locks
                Return ManageAzResourceGroupLock 
            End Function
                Return Function
}#>
function ManageAzResourceGroupLocks {                                                       # Function for managing resource locks
    Begin {                                                                                 # Begin function
        :ManageAzureRGLocks while($true) {                                                  # Outer loop for managing function 
            Write-Host 'Resource Group Lock Management'                                     # Write message to screen
            if ($Locks) {                                                                   # If $Locks has a value
                Write-Host 'The following locks are currently selected'                     # Write message to screen
                Write-Host ''                                                               # Write message to screen    
                foreach ($_ in $Locks) {                                                    # For each item in $Locks
                    $LockID = $_.ResourceID                                                 # $LockID equals current item .ResourceID
                    $ResProvider = $LockID.Split('/')[7]                                    # Collects the resource provider if lock on a resource
                    $ResName = $LockID.Split('/')[8]                                        # Collects the resource name if lock on a resource
                    Write-Host 'LockName:'$_.name                                           # Write message to screen
                    if ($ResProvider -ne 'locks') {                                         # If $ResProvider not equal to 'locks'
                        Write-Host 'ResName: '$ResName                                     # Write message to screen
                    }                                                                       # End if ($ResProvider -ne 'locks')
                    Write-Host 'RGName:  '$_.ResourceGroupName                              # Write message to screen
                    Write-Host 'Notes:   '$_.Properties                                     # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    $LockID = $null                                                         # Clears the selected $var
                    $ResProvider = $null                                                    # Clears the selected $var
                    $ResName = $null                                                        # Clears the selected $var
                }                                                                           # End foreach ($_ in $Locks)
            }                                                                               # End if ($Locks)
            Write-Host '[1] Clear "$Locks"'                                                 # Write message to screen
            Write-Host '[1] New Resource Group Lock'                                        # Write message to screen
            Write-Host '[2] New Resource Lock'                                              # Write message to screen
            Write-Host '[3] Get All Resource Group Locks'                                   # Write message to screen
            Write-Host '[4] Get Named Resource Group Lock'                                  # Write message to screen
            Write-Host '[5] Get All Resource Locks'                                         # Write message to screen
            Write-Host '[6] Get Named Resource Lock'                                        # Write message to screen
            Write-Host '[7] Remove Locks'                                                   # Write message to screen
            Write-Host '[Exit] to return'                                                   # Write message to screen
            $OPSelect = Read-Host "Option?"                                                 # Operator input to select management function
            if ($OPSelect -eq 'exit') {                                                     # If $OPSelect equals 'exit'
                Break ManageAzureRGLocks                                                    # Breaks :ManageAzureRGLocks 
            }                                                                               # End if ($OPSelect -eq 'exit')
            elseif ($OPSelect -eq '1') {                                                    # Else if $OPSelect equals '1'
                Write-Host "New Resource Group Lock"                                        # Write message to screen
                $Locks = NewAzResourceGroupLock                                             # Calls function and assigns output to $var
            }                                                                               # End elseif ($OPSelect -eq '1')
            elseif ($OPSelect -eq '2') {                                                    # Else if $OPSelect equals '2'
                Write-Host "New Resource Lock"                                              # Write message to screen
                $Locks = NewAzResourceLock                                                  # Calls function and assigns output to $var
            }                                                                               # End elseif ($OPSelect -eq '2')
            elseif ($OPSelect -eq '3') {                                                    # Else if $OPSelect equals '3'
                Write-Host "Get All Resource Group Locks"                                   # Write message to screen
                $Locks = GetAzResourceGroupLocksAll                                         # Calls function and assigns output to $var
            }                                                                               # End elseif ($OPSelect -eq '3')
            elseif ($OPSelect -eq '4') {                                                    # Else if $OPSelect equals '4'
                Write-Host "Get Named Resource Group Lock"                                  # Write message to screen
                $Locks = GetAzResourceGroupLockNamed                                        # Calls function and assigns output to $var
            }                                                                               # End elseif ($OPSelect -eq '4')
            elseif ($OPSelect -eq '5') {                                                    # Else if $OPSelect equals '5'
                Write-Host "Get All Resource Locks"                                         # Write message to screen
                $Locks = GetAzResourceLocksAll                                              # Calls function and assigns output to $var
            }                                                                               # End elseif ($OPSelect -eq '5')
            elseif ($OPSelect -eq '6') {                                                    # Else if $OPSelect equals '6'
                Write-Host "Get Named Resource Lock"                                        # Write message to screen
                $Locks = GetAzResourceLockNamed                                             # Calls function and assigns output to $var
            }                                                                               # End elseif ($OPSelect -eq '6')
            elseif ($OPSelect -eq '7') {                                                    # Else if $OPSelect equals '7'
                Write-Host "7 Remove Locks"                                                 # Write message to screen
                RemoveAzResourceLocks ($Locks)                                              # Calls function
            }                                                                               # End elseif ($OPSelect -eq '7')
            elseif ($OPSelect -eq '0') {                                                    # Else if $OPSelect equals '0'
                If ($Locks) {                                                               # If $Locks has a value
                    $Locks = $null                                                          # Clears $var
                    Write-Host '"$Locks" has been cleared'                                  # Write message to screen
                }                                                                           # End If ($Locks)
                else {                                                                      # If $Locks does not have a value
                    Write-Host '"$Locks was already cleared'                                # Write message to screen
                }                                                                           # End else (If ($Locks))
            }                                                                               # End elseif ($OPSelect -eq '0')
        }                                                                                   # End :ManageAzureRGLocks while ($true)
        Clear-Host                                                                          # Clears the screen
        if ($Locks) {                                                                       # If $Locks has a value
            Return $Locks                                                                   # Returns to calling function with $Locks
        }                                                                                   # End if ($Locks)
        else {                                                                              # If $Locks does not have a value
            Return                                                                          # Returns to calling function with $null
        }                                                                                   # End else (if ($Locks))
    }                                                                                       # End begin
}                                                                                           # End function ManageAzResourceGroupLocks
function GetAzRGLocksAll {                                                                  # Function to get all locks assigned to a resource group
    Begin {                                                                                 # Begin function
        $ErrorActionPreference='silentlyContinue'                                           # Disables Errors
        :GetAzureRGLocksAll while ($true) {                                                 # Outer loop for managing function
            if (!$RGObject) {                                                               # If $RGObject is $null
                $CallingFunction = 'GetAzRGLocksAll'                                        # Creates $CallingFunction
                $RGObject = GetAzResourceGroup ($CallingFunction)                           # Calls function and assigns output to $var
                if (!$RGObject) {                                                           # If $RGObject is $null
                    Break GetAzureRGLocksAll                                                # Breaks :GetAzureRGLocksAll
                }                                                                           # End if (!$RGObject) | Inner
            }                                                                               # End if (!$RGObject) | Outer
            $Locks = Get-AzResourceLock -ResourceGroupName $RGObject.ResourceGroupName      # Collects all locks and assigns to $Locks
            if (!$Locks) {                                                                  # If $Locks is $null
                Write-Host "No locks are on this resource group"                            # Write message to screen
                Start-Sleep(5)                                                              # Pauses all actions for 5 seconds
                Break GetAzureRGLocksAll                                                    # Breaks :GetAzureRGLocksAll
            }                                                                               # End if (!$Locks)
            else {                                                                          # Else if $Locks has a value
                Return $Locks                                                               # Returns $Locks to the calling function
            }                                                                               # End else (if (!$Locks))
        }                                                                                   # End :GetAzureRGLocksAll while ($true)
        Clear-Host                                                                          # Clears the screen
        Return                                                                              # Returns to calling function with $null
    }                                                                                       # End begin statement
}                                                                                           # End function GetAzRGLocksAll
function GetAzRSLocksAll {                                                                  # Function to get all locks assigned to a resource
    Begin {                                                                                 # Begin function
        $ErrorActionPreference='silentlyContinue'                                           # Disables Errors
        :GetAzureRSLocksAll while ($true) {                                                 # Outer loop for managing function
            if (!$RSObject) {                                                               # If $RSObject is $null
                $CallingFunction = 'GetAzRSLocksAll'                                        # Creates $CallingFunction
                $RSObject = GetAzResource ($CallingFunction)                                # Calls function and assigns output to $var
                if (!$RSObject) {                                                           # If $RSObject is $null
                    Break GetAzureRSLocksAll                                                # Breaks :GetAzureRSLocksAll
                }                                                                           # End if (!$RSObject) | Inner
            }                                                                               # End if (!$RSObject) | Outer
            $RSID = $RSObject.ResourceID                                                    # Isolates the resource ID
            $RSID = $RSID+'/*'                                                              # Adds a wildcard to the resource ID
            $Locks = Get-AzResourceLock | Where-Object {$_.ResourceID -like $RSID}          # Collects all locks and assigns to $Locks
            if (!$Locks) {                                                                  # If $Locks is $null
                Write-Host "No locks are on this resource "                                 # Write message to screen
                Start-Sleep(5)                                                              # Pauses all action for 5 seconds
                Break GetAzureRSLocksAll                                                    # Breaks :GetAzureRSLocksAll
            }                                                                               # End if (!$Locks)
            else {                                                                          # Else if $Locks has a value
                Return $Locks                                                               # Returns $Locks to the calling function
            }                                                                               # End else (if (!$Locks))
        }                                                                                   # End :GetAzureRSLocksAll while ($true)
        Clear-Host                                                                          # Clears the screen
        Return                                                                              # Returns to calling function with $null
    }                                                                                       # End begin statement
}                                                                                           # End function GetAzRSLocksAll
function RemoveAzResourceLocks {                                                            # Function to remove resource locks
    Begin {                                                                                 # Begin function
        :RemoveAzureLocks while ($true) {                                                   # Outer loop for managing function
            if (!$Locks) {                                                                  # If $Locks is $null
                $Locks = GetAzResourceLocks                                                 # Calls GetAzResourceLocks and assigns to $Locks
                if(!$Locks) {                                                               # If $Locks is $null
                    Break RemoveAzureLocks                                                  # Breaks :RemoveAzureLocks
                }                                                                           # End if(!$Locks) | Inner
            }                                                                               # End if(!$Locks) | Outer
            foreach ($_ in $Locks) {                                                        # For each item in $Locks
                Write-Host $_.Name                                                          # Write message to screen
            }                                                                               # End foreach ($_ in $Locks)
            Write-Host 'Remove these locks'                                                 # Write message to screen
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
                Write-Host 'All locks removed'                                              # Write message to screen
                $LocksRemoved = 'y'                                                         # Sets $LocksRemoved to 'n'
                Start-Sleep(10)                                                             # Pauses actions for 10 seconds
                Clear-Host                                                                  # Clears Screen
                Return $LocksRemoved                                                        # Returns to calling function with $LocksRemoved
            }                                                                               # End if ($OperatorConfirm -eq 'Y') 
            else {                                                                          # Else if $Operatorconfirm is not equal to 'y'
                Write-Host "No changes made"                                                # Message write to screen
                $LocksRemoved = 'n'                                                         # Sets $LocksRemoved to 'n'
                Return $LocksRemoved                                                        # Returns to calling function with $LocksRemoved
            }                                                                               # End else (if ($OperatorConfirm -eq 'Y') )
        }                                                                                   # End :RemoveAzureLocks while ($true)
        Clear-Host                                                                          # Clears Screen
        return                                                                              # Returns to calling function with $null
    }                                                                                       # End begin 
}                                                                                           # End function RemoveAzResourceLocks