<# 
Author - Benjamin Morgan benjamin.s.morgan@outlook.com 
Ref: {
    Get-AzResourceGroup:        https://docs.microsoft.com/en-us/powershell/module/az.resources/get-azresourcegroup?view=azps-5.1.0
    Get-AzKeyVault:             https://docs.microsoft.com/en-us/powershell/module/az.keyvault/get-azkeyvault?view=azps-5.1.0
    Get-AzKeyVaultSecret:       https://docs.microsoft.com/en-us/powershell/module/az.keyvault/get-azkeyvaultsecret?view=azps-5.1.0
    Set-AzKeyVaultSecret:       https://docs.microsoft.com/en-us/powershell/module/az.keyvault/set-azkeyvaultsecret?view=azps-5.1.0
    Remove-AzKeyVaultSecret:    https://docs.microsoft.com/en-us/powershell/module/az.keyvault/remove-azkeyvaultsecret?view=azps-5.1.0
}
Required Functions: {
    ManageAzKeyVault:           Manages all other function calls
    GetAzResourceGroup:         Collects resource group object
    GetAzKeyVault:              Collects the key vault object
    GetAzKeyVaultSecret:        Collects a secret value
    SetAzKeyVaultSecret:        Creates a new key vault secret and value
    RemoveAzKeyVaultSecret:     Removes an existing key vault secret
}
Variables: {
    GetAzResourceGroup {
        $RGObject:              Resource group object
        $RGObjectinput:         Operator input for the resource group name
        $RGList:                variable used for printing all resource groups to screen if needed
    }
    ManageAzureFunction {
        $OperatorSelect:        Operator input for selecting a management function
    }
    GetAzKeyVault {
        $RGObject:              Resource group object
        $KeyVault:              KeyVault object
        $KeyVaultInput:         Operator input for the key vault name
        $KVList:                Variable used for printing all key vaults to screen if needed 
    }
    GetAzKeyVaultSecretList {
        $KeyVault:              KeyVault object
        $KeyVaultSecret:        Key vault secret object
        $KVSList:               Variable used for printing all key vault secrets to screen
    }
    GetAzKeyVaultSecret {
        $KeyVault:              KeyVault object
        $KeyVaultSecret:        Key vault secret object
        $KeyVaultSecretInput:   Operator input for the key vault secret name
        $KVSList:               Variable used for printing all key vault secrets to screen if needed
    } 
    SetAzKeyVaultSecret{
        $KeyVault:              KeyVault object
        $KeyVaultSecretName:    Operator input for the new secret name
        $KeyVaultSecretValue:   Operator input for the new secret value
        $KeyVaultSecretHash:    $KeyVaultSecretValue converted to secure string
    }
        RemoveAzKeyVaultSecret{
        $KeyVaultSecret:        Key vault secret object
        $ConfirmDelete:         Operator confirmation for delete
    }
}
#>
function ManageAzKeyVault { # Script for managing Azure
    Begin {
        $RGObject = $null # Clears any previous use of $RGObject
        while (!$OperatorSelect) { # Loop for script to function
            Write-Host "'0' Select key vault " # Write option to screen
            Write-Host "'1' List all secrets" # Write option list to screen
            Write-Host "'2' Get key vault secret" # Write option list to screen
            Write-Host "'3' Get key vault secret value" # Write option list to screen
            Write-Host "'4' Create key vault secret" # Write option list to screen
            Write-Host "'5' Delete key vault secret" # Write option list to screen
            Write-Host "'Exit' to end script" # Write option list to screen
            $OperatorSelect = Read-Host "Chose option" # Operator input for which option they need to run
            if ($OperatorSelect -eq '0') { # If statment for Option 0
                $RGObject = GetAzResourceGroup # Calls function GetAzResourceGroup and assigns to $RGObject
                $KeyVault = GetAzKeyVault ($RGObject)
            } # End if statement 
            elseif ($OperatorSelect -eq '1') { # Elseif statement for option 1
                Write-Host "***List all secrets***" # Option selection write to screen
                GetAzKeyVaultSecretList ($RGObject, $KeyVault) # Calls functionX
            } # End elseif statement
            elseif ($OperatorSelect -eq '2') { # Elseif statement for option 2
                Write-Host "***Get key vault secret" # Option selection write to screen
                GetAzKeyVaultSecret ($RGObject, $KeyVault) # Calls functionY
            } # End elseif statement
            elseif ($OperatorSelect -eq '3') { # Elseif statement for option 3
                Write-Host "***Get key vault secret value***" # Option selection write to screen
                GetAzKeyVaultSecretValue ($RGObject, $KeyVault) # Calls functionz
            } # End elseif statement
            elseif ($OperatorSelect -eq '4') { # Elseif statement for option 4
                Write-Host "***Create key vault secret***" # Option selection write to screen
                SetAzKeyVaultSecret ($RGObject, $KeyVault) # Calls functionz
            } # End elseif statement
            elseif ($OperatorSelect -eq '5') { # Elseif statement for option 5
                Write-Host "***Delete key vault secret***" # Option selection write to screen
                RemoveAzKeyVaultSecret ($RGObject, $KeyVault) # Calls functionz
            } # End elseif statement
            elseif ($OperatorSelect -eq 'exit') { # Elseif statement for ending the srcipt
                Write-Host "***Terminating Script***" # Option selection write to screen
                Break # Terminates script
            } # End elseif statement
            else { # Esle statement for all other values
                Write-Host "Invalid option" # Option selection write to screen
                $OperatorSelect = $null # Empties $OperatorSelect to restart operator input selection 
            } # End else statement
        $OperatorSelect = $null # Restarts while loop
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
function GetAzKeyVault { # Function to get a key vault, can pipe $KeyVault to another function.
    Begin {
        $WarningPreference = "silentlyContinue" # Disables key vault warnings
        $ErrorActionPreference = 'silentlyContinue' # Disables Errors
        if (!$RGObject) { # Check if $RGObject has an object assigned
            $RGObject = GetAzResourceGroup # Calls function GetAzResourceGroup to assign $RGObject
        } # End if statement
        $KeyVault = $null # Clears $KeyVault from all previous use
        while (!$KeyVault) { # Loop to continue getting a key vault until the operator provided name matches an existing key vault
            $KeyVaultInput = Read-Host "Key vault name" # Operator input for the key vault name
            $KeyVault = Get-AzKeyVault -VaultName $KeyVaultInput -ResourceGroupName $RGObject.ResourceGroupName # Collection of the key vault from the operator input
            if (!$KeyVault) { # Error reporting if input does not match and existing key vault
                Write-Host "The name provided does not match an existing key vault" # Error note
                Write-Host "This is the list of available key vaults" # Error note
                $KVList = Get-AzKeyVault -ResourceGroupName $RGObject.ResourceGroupName # Collects all key vault objects and assigns to a variable
                Write-Host "" # Error reporting
                Write-Host $KVList.VaultName -Separator `n # Write-host used so list is written to screen when function is used as $KeyVault = GetAzKeyVault
                Write-Host "" # Error reporting
            } # End if statement
            else { # Else if $KeyVault is assigned
                Write-Host $KeyVault.VaultName 'Has been assigned to "$KeyVault"' # Writes the key vault name to the screen before ending function 
            } # End else statement
        } # End while statement
        Return $KeyVault
    } # End begin statement
} # End function
function GetAzKeyVaultSecretList { # Function to get a all secrets in a key vault
    Begin {
        $ErrorActionPreference='silentlyContinue' # Disables Errors
        $WarningPreference = "silentlyContinue" # Disables key vault warnings
        if (!$KeyVault) { # Check if $KeyVault has an object assigned
            $RGObject = GetAzResourceGroup # Calls function GetAzResourceGroup to get $RGObject
            $KeyVault = GetAzKeyVault ($RGObject) # Calls  function GetAzKeyVault to assign $KeyVault
        } # End if statement
        $KVList = Get-AzKeyVaultSecret -VaultName $KeyVault.VaultName  # Collection of the key vault secret from the operator input
        $KVList | Select-Object Name, Enabled, Created | Format-Table # Outputs the name, Enable status, and date created. Can by changed to output other info
    } # End begin statement
} # End function
function GetAzKeyVaultSecret { # Function to get a key vault secret can pipe $KeyVaultSecret to another function.
    Begin {
        $WarningPreference = "silentlyContinue" # Disables key vault warnings
        $ErrorActionPreference='silentlyContinue' # Disables Errors
        if (!$KeyVault) { # Check if $KeyVault has an object assigned
            $RGObject = GetAzResourceGroup # Calls function GetAzResourceGroup to get $RGObject
            $KeyVault = GetAzKeyVault ($RGObject) # Calls  function GetAzKeyVault to assign $KeyVault
        } # End if statement
        $KeyVaultSecret = $null # Clears $KeyVaultSecret from all previous use
        while (!$KeyVaultSecret) { # Loop to continue getting a key vault secret until the operator provided name matches an existing key vault secret
            $KeyVaultSecretInput = Read-Host "KeyVault secret name" # Operator input for the key vault secret name
            $KeyVaultSecret = Get-AzKeyVaultSecret -VaultName $KeyVault.VaultName -Name $KeyVaultSecretInput  # Collection of the key vault secret from the operator input
            if (!$KeyVaultSecret) { # Error reporting if input does not match and existing key vault secret
                Write-Host "The name provided does not match an existing key vault secret" # Error note
                Write-Host "This is the list of available key vault secrets" # Error note
                $KVSList = Get-AzKeyVaultSecret -VaultName $KeyVault.VaultName # Collects all key vault secret objects and assigns to a variable
                Write-Host "" # Error reporting
                Write-Host $KVSList.Name -Separator `n # Write-host used so list is written to screen when function is used as $KeyVaultSecret = GetAzKeyVaultSecret
                Write-Host "" # Error reporting
            } # End if statement
            else { # Else if $KeyVaultSecret is assigned
                Write-Host $KeyVaultSecret.Name 'Has been assigned to "$KeyVaultSecret"' # Writes the key vault name secret to the screen before ending function 
            } # End else statement
        } # End while statement
        Return $KeyVaultSecret
    } # End begin statement
} # End function
function SetAzKeyVaultSecret { # Creates a new secret and value in existing key vault
    Begin {
        $ErrorActionPreference='silentlyContinue' # Disables Errors
        $WarningPreference = "silentlyContinue" # Disables key vault warnings
        if (!$KeyVault) { # Check if $KeyVault has an object assigned
            $RGObject = GetAzResourceGroup # Calls function GetAzResourceGroup to get $RGObject
            $KeyVault = GetAzKeyVault ($RGObject) # Calls  function GetAzKeyVault to assign $KeyVault
        } # End if statement
        $KeyVaultSecretName = Read-Host "New key vault secret name" # Prompt for operator input for $KeyVaultSecretName
        $KeyVaultSecretValue = Read-Host "New key vault secret value"# Prompt for operator input for $KeyVaultSecretValue
        $KeyVaultSecretHash = ConvertTo-SecureString -String $KeyVaultSecretValue -AsPlainText -Force # Converts the operator input to secure string
        Set-AzKeyVaultSecret -VaultName $KeyVault.VaultName -Name $KeyVaultSecretName -SecretValue $KeyVaultSecretHash # Creates new secret based off operator input
    } # End begin statement
} # End function
function RemoveAzKeyVaultSecret {
    Begin {
        #$ErrorActionPreference='silentlyContinue' # Disables errors
        $WarningPreference = "silentlyContinue" # Disables key vault warnings
        if (!$KeyVault) { # Check if $KeyVault has an object assigned
            $RGObject = GetAzResourceGroup # Calls function GetAzResourceGroup to get $RGObject
            $KeyVault = GetAzKeyVault ($RGObject) # Calls  function GetAzKeyVault to assign $KeyVault
        } # End if statement
        $KeyVaultSecret = GetAzKeyVaultSecret ($KeyVault)
        $ConfirmDelete = Read-Host "Do you want to delete"$KeyVaultSecret.Name # Operator input to confirm delete
        if ($ConfirmDelete -eq 'y' -or $ConfirmDelete -eq 'yes') { # Check that operator input is 'y' or 'yes'
            Remove-AzKeyVaultSecret -VaultName $KeyVault.VaultName -Name $KeyVaultSecret.Name -Force
            Write-Host $KeyVaultSecret.Name"has been deleted" # Confirmation message
            $KeyVaultSecret = $null # Clears $KeyVaultSecret once it has been deleted
        } # End if statement
        else { # If $ConfirmDelete is not 'y' or 'yes'
            Write-Host "No changes were made" # Confirmation message
            Break # Terminates script
        } # End else statement
    } # End begin statement
} # End function