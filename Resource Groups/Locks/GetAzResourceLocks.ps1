# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Mircosoft docs links
    Get-AzResourceGroup:        https://docs.microsoft.com/en-us/powershell/module/az.resources/get-azresourcegroup?view=azps-5.1.0
    Get-AzResource:             https://docs.microsoft.com/en-us/powershell/module/az.resources/get-azresource?view=azps-5.1.0
    Get-AzResourceLock:         https://docs.microsoft.com/en-us/powershell/module/az.resources/get-azresourcelock?view=azps-5.0.0
} #>
<# Required Functions Links: {
    GetAzResourceGroup:         https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/GetAzResourceGroup.ps1
    GetAzResource:              https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/GetAzResource.ps1
    GetAzResourceGroupLocksAll: https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/Locks/GetAzResourceGroupLocksAll.ps1
    GetAzResourceGroupLockNamed:https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/Locks/GetAzResourceGroupLockNamed.ps1
    GetAzResourceLocksAll:      https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/Locks/GetAzResourceLocksAll.ps1
    GetAzResourceLockNamed:     https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/Locks/GetAzResourceLockNamed.ps1
} #>
<# Functions Description: {
    GetAzResourceLocks:         Management function to get different sets of locks
    GetAzResourceGroup:         Collects resource group object
    GetAzResource:              Collects resources within a resource group
    GetAzResourceGroupLocksAll: Collects all locks on a resource group and its resources
    GetAzResourceGroupLockNamed:Collects a named locks on a resource group
    GetAzResourceLocksAll:      Collects all locks on a resource
    GetAzResourceLockNamed:     Collects a named lock on a resource
} #>
<# Variables: {
    GetAzResourceLocks {
        $Locks:                 Lock or locks object
        $OperatorSelect:        Operator input what locks to collect
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
    GetAzResourceGroupLocksAll {
        $RGObject:              Resource group object
        $Locks:                 Locks object
    }
    GetAzResourceGroupLockNamed {
        $RGObject:              Resource group object
        $Locks:                 Locks object
        $LocksInput:            Input to collect a named lock
        $LocksList:             Object containing all locks within the resource group
        $OperatorConfirm:       Operator confirmation that the lock found was the intended target
    }
    GetAzResourceLocksAll {
        $RGObject:              Resource group object
        $RSObject:              Resource object
        $Locks:                 Locks object
    }
    GetAzResourceLockNamed {
        $RGObject:              Resource group object
        $RSObject:              Resource object
        $Locks:                 Locks object
        $LocksInput:            Input to collect a named lock
        $LocksList:             Object containing all locks on the resource
        $OperatorConfirm:       Operator confirmation that the lock found was the intended target
    }
} #>
<# Process Flow {
    Function
        Call GetAzResourceLocks > Get $Locks
            Call GetAzResourceGroupLocksAll > Get $Locks
                Call GetAzResourceGroup > Get $RGObject
            Call GetAzResourceGroupLockNamed > Get $Locks
                Call GetAzResourceGroup > Get $RGObject
            Call GetAzResourceLocksAll > Get $Locks
                Call GetAzResourceGroup > Get $RGObject
                Call GetAzResource > Get $RSObject
            Call GetAzResourceLockNamed > Get $Locks
                Call GetAzResourceGroup > Get $RGObject
                Call GetAzResource > Get $RSObject    
}#>
function GetAzResourceLocks { # Function to manage getting resource locks, can pipe $Locks into another function
    Begin {
        while (!$Locks) { # While statement to get $Locks by calling another function is $Locks is $null
            Write-Host "'1' Get all locks on a resource group and its resources" # Write option to screen
            Write-Host "'2' Get a named lock on a resource group" # Write option to screen
            Write-Host "'3' Get all locks on a resource" # Write option to screen
            Write-Host "'4' Get a named lock on a resource" # Write option to screen
            $OperatorSelect = Read-Host "Enter the number from the list" # Operator input to call function to collect $Locks
            if ($OperatorSelect -eq '1') { # If statement for option 1
                Write-Host "**Get all locks on a resource group and its resources**" # Write message to screen
                $Locks = GetAzResourceGroupLocksAll # Calls function GetAzResourceGroupLocksAll and assigns to $Locks
                if (!$Locks) { # Check to see if called function returned a value
                    Write-Host "GetAzResourceLocks function was terminated" # Message write to screen
                    Return # Returns to calling function
                } # End if statement
                Return $Locks # Returns $Locks to calling function
            } # End if statement
            elseif ($OperatorSelect -eq '2') { # elseif statement for option 2
                Write-Host "**Get a named lock on a resource group**" # Write message to screen
                $Locks = GetAzResourceGroupLockNamed # Calls function GetAzResourceGroupLockNamed and assigns to $Locks
                if (!$Locks) { # Check to see if called function returned a value
                    Write-Host "GetAzResourceLocks function was terminated" # Message write to screen
                    Return # Returns to calling function
                } # End if statement
                Return $Locks # Returns $Locks to calling function
            } # End elseif statement
            elseif ($OperatorSelect -eq '3') { # elseif statement for option 3
                Write-Host "**Get all locks on a resource**" # Write message to screen
                $Locks = GetAzResourceLocksAll # Calls function GetAzResourceLocksAll and assigns to $Locks
                if (!$Locks) { # Check to see if called function returned a value
                    Write-Host "GetAzResourceLocks function was terminated" # Message write to screen
                    Return # Returns to calling function
                } # End if statement
                Return $Locks # Returns $Locks to calling function
            } # End elseif statement
            elseif ($OperatorSelect -eq '4') { # elseif statement for option 4
                Write-Host "**Get a named lock on a resource**" # Write message to screen
                $Locks = GetAzResourceLockNamed # Calls function GetAzResourceLockNamed and assigns to $Locks
                if (!$Locks) { # Check to see if called function returned a value
                    Write-Host "GetAzResourceLocks function was terminated" # Message write to screen
                    Return # Returns to calling function
                } # End if statement
                Return $Locks # Returns $Locks to calling function
            } # End elseif statement
            elseif ($OperatorSelect -eq 'Exit') { # Elseif statement for 'Exit'
                Write-Host "GetAzResourceLocks function was terminated" # Message write to screen
                Return # Returns to calling function
            } # End elseif statement
            else { # Else statement for no valid inputs by the operator
                Write-Host "**That was not a valid selection**" # Write error to screen
            } # End else statement
        } # End while statement
    } # End begin statement
} # End function