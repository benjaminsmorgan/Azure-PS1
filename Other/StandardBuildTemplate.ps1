<# 
Author - Benjamin Morgan benjamin.s.morgan@outlook.com 
Ref: {
    Get-AzResourceGroup:        https://docs.microsoft.com/en-us/powershell/module/az.resources/get-azresourcegroup?view=azps-5.1.0
}
Required Functions: {
    GetAzResourceGroup:         Collects resource group object
}
Variables: {
    GetAzResourceGroup {
        $RGObject - Resource group object
        $RGObjectinput - Operator input for the resource group name
        $RGList - variable used for printing all resource groups to screen if needed
    }
    ManageAzureFunction
        $OperatorSelect - Operator input for selecting a management function
}
#>
function ManageAzureFunction { # Script for managing Azure
    Begin {
        $RGObject = $null # Clears any previous use of $RGObject
        while (!$OperatorSelect) { # Loop for script to function
            Write-Host "'0' Select XXX" # Write option to screen
            Write-Host "'1' Option" # Write option list to screen
            Write-Host "'2' Option" # Write option list to screen
            Write-Host "'3' Option" # Write option list to screen
            Write-Host "'Exit' to end script" # Write option list to screen
            $OperatorSelect = Read-Host "Chose option" # Operator input for which option they need to run
            if ($OperatorSelect -eq '0') { # If statment for Option 0
                $RGObject = GetAzResourceGroup # Calls function GetAzResourceGroup and assigns to $RGObject
            } # End if statement 
            elseif ($OperatorSelect -eq '1') { # Elseif statement for option 1
                Write-Host "***Option2***" # Option selection write to screen
                FunctionX ($RGObject) # Calls functionX
            } # End elseif statement
            elseif ($OperatorSelect -eq '2') { # Elseif statement for option 2
                Write-Host "***Option3***" # Option selection write to screen
                FunctionY ($RGObject) # Calls functionY
            } # End elseif statement
            elseif ($OperatorSelect -eq '3') { # Elseif statement for option 3
                Write-Host "***Option4***" # Option selection write to screen
                FunctionZ ($RGObject) # Calls functionz
            } # End elseif statement
            elseif ($OperatorSelect -eq 'exit') { # Elseif statement for ending the srcipt
                Write-Host "***Terminating Script***" # Option selection write to screen
                Break # Terminates script
            } # End elseif statement
            else { # Esle statement for all other values
                Write-Host "Invalid option" # Option selection write to screen
                $OperatorSelect = $null # Empties $OperatorSelect to restart operator input selection 
            } # End else statement
        } # End while statement
    } # End begin statemnt
} # End function
function GetAzResourceGroup { # Function to get a resource group, can pipe $RGObject to another function.
    Begin {
        $ErrorActionPreference='silentlyContinue' # Disables Errors
        $RGObject = $null # Clears $RGObject from all previous use
        while (!$RGObject) { # Loop to continue getting a resource group until the operator provided name matches an existing group
            $RGObjectInput = Read-Host "Resource group name" # Operator input of the resource group name
            $RGObject = Get-AzResourceGroup -Name $RGObjectInput # Collection of the resource group from the operator input
            if (!$RGObject) { # Error reporting if input does not match an existing group
                Write-Host "The name provided does not match an existing resource group" # Error note
                Write-Host "This is the list of available resource groups" # Error note
                $RGList = Get-AzResourceGroup # Collects all resource group objects and assigns to a variable
                Write-Host "" # Error reporting
                Write-Host $RGList.ResourceGroupName -Separator `n # Write-host used so list is written to screen when function is used as $RGObject = GetAzResourceGroup
                Write-Host "" # Error reporting
            } # End of if statement
            else { # Else for when $RGObject is assigned
                Write-Host $RGObject.ResourceGroupName 'Has been assigned to "$RGObject"' # Writes the resource group name to the screen before ending function
            } # End of else statement
        } # End of while statement
        Return $RGObject  # Returns the value of $RGObject to a function that called it
    } # End of begin statement
} # End of function