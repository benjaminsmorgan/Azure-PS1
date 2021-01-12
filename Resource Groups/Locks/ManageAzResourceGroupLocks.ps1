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
        $OperatorManageOption:  Operator input for management option
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
function ManageAzResourceGroupLocks {
    Begin {
        :ManageAzureRGLocks while($true) { # :ManageAzureRGLocks loop for managing resource group locks 
            Write-Host "Resource Group Lock Management" # Write message to screen
            Write-Host "1 New Resource Group Lock" # Write message to screen
            Write-Host "2 New Resource Lock" # Write message to screen
            Write-Host "3 Get All Resource Group Locks" # Write message to screen
            Write-Host "4 Get Named Resource Group Lock" # Write message to screen
            Write-Host "5 Get All Resource Locks" # Write message to screen
            Write-Host "6 Get Named Resource Lock" # Write message to screen
            Write-Host "7 Remove Locks" # Write message to screen
            Write-Host "'Exit to return'" # Write message to screen
            $OperatorManageOption = Read-Host "Option?" # Operator input to select management function
            if ($OperatorManageOption -eq 'exit') { # If statement for exiting this function
                Break ManageAzureRGLocks # Ends :ManageAzureRGLocks loop, returning to calling function 
            } # End if ($OperatorManageOption -eq 'exit')
            elseif ($OperatorManageOption -eq '1') { # Option for new resource group lock
                Write-Host "New Resource Group Lock" # Write message to screen
                $Locks = NewAzResourceGroupLock # Calls function and assigns value to $Locks
                $Locks # For Testing Purposes
            } # End elseif ($OperatorManageOption -eq '1')
            elseif ($OperatorManageOption -eq '2') { # Option for new resource lock
                Write-Host "New Resource Lock" # Write message to screen
                $Locks = NewAzResourceLock # Calls function and assigns value to $Locks
                $Locks # For Testing Purposes
            } # End elseif ($OperatorManageOption -eq '2')
            elseif ($OperatorManageOption -eq '3') { # Option to get all locks on a resource group
                Write-Host "Get All Resource Group Locks" # Write message to screen
                $Locks = GetAzResourceGroupLocksAll # Calls function and assigns value to $Locks
                $Locks # For Testing Purposes
            } # End elseif ($OperatorManageOption -eq '3')
            elseif ($OperatorManageOption -eq '4') { # Option to get a named lock on a resource group
                Write-Host "Get Named Resource Group Lock" # Write message to screen
                $Locks = GetAzResourceGroupLockNamed # Calls function and assigns value to $Locks
                $Locks # For Testing Purposes
            } # End elseif ($OperatorManageOption -eq '4')
            elseif ($OperatorManageOption -eq '5') { # Option to get all locks on a resource
                Write-Host "Get All Resource Locks" # Write message to screen
                $Locks = GetAzResourceLocksAll # Calls function and assigns value to $Locks
                $Locks # For Testing Purposes
            } # End elseif ($OperatorManageOption -eq '5')
            elseif ($OperatorManageOption -eq '6') { # Option to get a named lock on a resource
                Write-Host "Get Named Resource Lock" # Write message to screen
                $Locks = GetAzResourceLockNamed # Calls function and assigns value to $Locks
                $Locks # For Testing Purposes
            } # End elseif ($OperatorManageOption -eq '6')
            elseif ($OperatorManageOption -eq '7') { # Option to remove locks
                Write-Host "7 Remove Locks" # Write message to screen
                RemoveAzResourceLocks ($Locks) # Calls function to remove locks, passed $Locks
            } # End elseif ($OperatorManageOption -eq '7')
            elseif ($OperatorManageOption -eq '0') { # Option to clear the current $Locks, $RGObject, $RSObject values
                $OperatorSelect = Read-Host "Lock, RGObject, and/or RSObject" # Operator input for removing a value from $var
                if ($OperatorSelect -like "*Lock*") { # Option for clearing $Locks
                    $Locks = $null # Clears $Locks value
                    Write-Host '$Locks has been cleared' # Write message to screen
                } # End if ($OperatorSelect -like "*Lock*")
                if ($OperatorSelect -like "*RGObject*") { # Option for clearing $RGObject
                    $RGObject = $null # Clears $RGObject value
                    Write-Host '$RGObject has been cleared' # Write message to screen
                } # #End if ($OperatorSelect -like "*RGObject*")
                if ($OperatorSelect -like "*RSObject*") { # Option for clearing $RSObject
                    $RSObject = $null # Clears $RSObject value
                    Write-Host '$RSObject has been cleared' # Write message to screen
                } # End if ($OperatorSelect -like "*RSObject*")
            } # End elseif ($OperatorManageOption -eq '0')
            if ($Locks -or $RGObject -or $RSObject) { # If $Locks, $RGObject, or $RSObject object has a value, writes info to screen
                if ($Locks) { # If $Locks has a value
                    if ($Locks.count -gt 1) { # If $Locks has 2 or more objects
                        Write-Host "The following locks are selected"
                        $ForEachCount = 1 # Counter used in foreach statement
                        foreach ($Name in $Locks) { # For each lock name in $Locks
                            Write-Host "" # Write message to screen
                            Write-Host "Matching resource" $ForEachCount # Write message to screen
                            Write-Host "Lock name:          "$Name.Name
                            Write-Host "Lock properties:    "$Name.Properties
                            Write-Host "Lock resource name: "$Name.ResourceName
                            $ForEachCount = $ForEachCount+1 # Adds 1 to $ForEachCount
                        } # End foreach ($Name in $Locks)
                        Write-Host ""
                    } # End if ($Locks.count -gt 1)
                    else { # If $Locks has a single object
                    Write-Host $Locks.Name "is the currently selected lock" # Write message to screen
                    } # End else if ($Locks.count -gt 1)
                } # End if ($Locks)
                if ($RGObject) { # If $RGObject has a value
                    Write-Host $RGObject.ResourceGroupName "is the currently selected resource group" # Write message to screen
                } # End if ($RGObject)
                if ($RSObject) { # If $RSObject has a value
                    Write-Host $RSObject.Name "is the currently selected resource" # Write message to screen
                } # End if ($RSObject) 
            Write-Host 'Use option "0" to clear $Locks' # Write message to screen
            } # End if ($Locks -or $RGObject -or $RSObject)
            $OperatorManageOption = $null # Clears $Operator search option incase of error
        }# End :ManageAzureRGLocks while loop
        Return # Returns to calling function, no info is returned
    } # End begin
} # End function ManageAzResourceGroupLocks