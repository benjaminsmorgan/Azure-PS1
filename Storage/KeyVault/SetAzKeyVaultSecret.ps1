# Benjamin Morgan benjamin.s.morgan@outlook.com 
# Ref: https://docs.microsoft.com/en-us/powershell/module/az.resources/get-azresourcegroup?view=azps-5.1.0
# Ref: https://docs.microsoft.com/en-us/powershell/module/az.keyvault/get-azkeyvault?view=azps-5.1.0
# Depedencies:
# Function GetAzResourceGroup
# /Dependencies
# $RGObject - Resource group object
# $RGObjectinput - Operator input for the resource group name
# $RGList - variable used for printing all resource groups to screen if needed
# $KeyVault - KeyVault object
# $KeyVaultInput - Operator input for the key vault name
# $KVList - variable used for printing all key vaults to screen if needed 
# $KeyVaultSecretName - Operator input for the new secret name
# $KeyVaultSecretValue - Operator input for the new secret value
# $KeyVaultSecretHash - Hashed value of $KeyVauleSecretValue
function SetAzKeyVaultSecret { # Creates a new secret and value in existing key vault
    Begin {
        $ErrorActionPreference='silentlyContinue' # Disables Errors
        $WarningPreference = "silentlyContinue" # Disables key vault warnings
        $KeyVault = GetAzKeyVault # Calls (Function) GetAzKeyVault to get $KeyVault
        $KeyVaultSecretName = Read-Host "New key vault secret name" # Prompt for operator input for $KeyVaultSecretName
        $KeyVaultSecretValue = Read-Host "New key vault secret value"# Prompt for operator input for $KeyVaultSecretValue
        $KeyVaultSecretHash = ConvertTo-SecureString -String $KeyVaultSecretValue -AsPlainText -Force # Converts the operator input to secure string
        Set-AzKeyVaultSecret -VaultName $KeyVault.VaultName -Name $KeyVaultSecretName -SecretValue $KeyVaultSecretHash # Creates new secret based off operator input
    } # End begin statement
} # End function
function GetAzKeyVault { # Function to get a key vault, can pipe $KeyVault to another function.
    Begin {
        $ErrorActionPreference='silentlyContinue' # Disables Errors
        $WarningPreference = "silentlyContinue" # Disables key vault warnings
        $RGObject = GetAzResourceGroup # Calls (Function) GetAzResourceGroup to get $RGObject
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