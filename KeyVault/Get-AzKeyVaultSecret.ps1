# Benjamin Morgan benjamin.s.morgan@outlook.com 
# Ref https://docs.microsoft.com/en-us/powershell/module/az.keyvault/get-azkeyvaultsecret?view=azps-5.0.0
# $VaultNameInput - Operator input to find the matching Vaultname
# $VaultName - Actual vault object.name
# $SecretNameInput - operator input to find the matching secret
# $SecretName - actual secret object.name
# $SecretHash - actual current secret object
# SecretValueText - plain text of $SecretHash onject
function GETAZSECRET { # Retrieves a secret and value to provided KeyVault
    [CmdletBinding()]
    param 
    (
        # Begin parameter input
        [Parameter(Mandatory=$true, Position=0)] # User input KeyVault name
            [string] $VaultNameInput,
        [Parameter(Mandatory=$true, Position=1)] # User input for secret name
            [string] $SecretNameInput    
    )   # End parameter input
    Begin
    {
        # Message suppression start
        $ErrorActionPreference = "silentlyContinue" # Disables all auto errors
        $WarningPreference = "silentlyContinue" # Disables KeyVault warnings
        # Operator input validation for keyvault
        $VaultName = (Get-AzKeyVault -Name $VaultNameInput*).VaultName # Pulls Keyvault object based off name + wildcard ex: "ABC" will pull "ABC123"
        if (!$VaultName){ # Check for no keyvaults matching the operator input
            Write-Host "The KeyVault name provided does not match any KeyVaults in this subscription"
            Write-Host "Here is the list of Keyvaults available:"
            Write-host "\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\"
            Get-AzKeyVault | Select-Object vaultname, ResourceGroupName | Format-Table # Pulls all available vault names and lists to operator
            Write-host "\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\"
            $VaultNameInput = Read-Host "Please re-enter the KeyVault name" # Collects new operator entry for $VaultNameInput
            $VaultName = (Get-AzKeyVault -Name $VaultNameInput).VaultName # Pulls Keyvault object if $VaultNameInput completely matches
            if (!$VaultName) { # Checks for a misspelled or unavailable vault from second $VaultNameInput
                Write-Host "The Keyvault name is either misspelled or not available"
                Break # Terminates Script
            }
        }
        elseif ($VaultName.count -gt 1) { # check for multiple returns for the operator input
            Write-Host "Multiple vaults match the vaultname entry"
            Write-Host "Please re-enter the full vault name"
            $VaultName = $VaultName | Select-Object VaultName, ResourceGroupName | Format-Table # Formats $VaultName into table
            Write-host "\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\"
            Write-Host $VaultName # Prints lists of vaults matching operator input
            Write-host "\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\"
            $VaultNameInput = Read-Host "Please re-enter the KeyVault name" # Collects new operator entry for $VaultNameInput
            $VaultName = (Get-AzKeyVault -Name $VaultNameInput).VaultName # Pulls Keyvault object if $VaultNameInput completely matches
            if (!$VaultName) { # Checks for a misspelled or unavailable vault from second $VaultNameInput
                Write-Host "The Keyvault name is either misspelled or not available"
                Break # Terminates Script
            }    
        }
        # End operator input validation for keyvault
        # Operator input validation for secret name
        $SecretName = (Get-AzKeyVaultSecret -VaultName $VaultName | Where-Object {$_.Name -like "$SecretNameInput*"} | Select-Object name) # Pulls Keyvault secret name based off name + wildcard ex: "ABC" will pull "ABC123"
        if (!$SecretName) { # Check for no secret names matching the operator input 
            Write-Host "The secret name provided does not match any secrets in this keyvault"
            Write-Host "Here is the list of secrets available in" $VaultName
            Write-host "\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\"
            (Get-AzKeyVaultSecret -VaultName $VaultName).Name  # Pulls all available secret names and lists to operator
            Write-host "\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\"
            $SecretNameInput = Read-Host "Please re-enter the secret name" # Collects new operator entry for $VaultNameInput
            $SecretName = (Get-AzKeyVaultSecret -VaultName $VaultName | Where-Object {$_.Name -eq $SecretNameinput} | Select-Object name) # Pulls secret name if $SecretNameInput completely matches
            if (!$SecretName) { # Checks for a misspelled or unavailable secret from second $SecretNameInput
                Write-Host "The Secret Name entered is either misspelled or is not available"
                Break # Terminates Script
            }    
        }
        elseif ($SecretName.Count -gt 1){ # This is a check for multiple responses
            Write-Host "Multiple keys match the keyname entry"
            $SecretNameList = $SecretName.Name | Format-Table | out-string # Formats all matching secret names into list
            Write-Host $SecretNameList # Writes the list of matching secret names
            $SecretNameInput = Read-Host "Please re-enter the secret name" # Collects new operator entry for $SecretNameInput 
            $SecretName = (Get-AzKeyVaultSecret -VaultName $VaultName | Where-Object {$_.Name -eq $SecretNameInput} | Select-Object name) # Pulls secret name if $SecretNameInput completely matches
            if (!$SecretName) { # Checks for a misspelled or unavailable secret from second $SecretNameInput
                Write-Host "The Secret Name entered is either mi-spelled or is not available"
                Break # Terminates Script
            }
        }
        # End operator input validation for secret name
        # Convert secret value into plain text
        $SecretHash = (Get-AzKeyVaultSecret -VaultName $VaultName -Name $SecretName.Name) # Uses complete secret name to pull the latest version
        # This code is provided by MS to change the hashed value into plain text https://docs.microsoft.com/en-us/powershell/module/az.keyvault/get-azkeyvaultsecret?view=azps-5.0.0#examples
        $SecretValueText = ''; 
        $ssPtr = [System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($SecretHash.SecretValue)
        try {
            $SecretValueText = [System.Runtime.InteropServices.Marshal]::PtrToStringBSTR($ssPtr)
        } 
        finally {
            [System.Runtime.InteropServices.Marshal]::ZeroFreeBSTR($ssPtr)
        }
        # End MS provided code
        # Convert secret value into plain text
        # Write final output to operator
        Write-host "\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\"
        Write-Host "Vault Name" $VaultName # Writes the keyvault name
        Write-Host "Secret Name" $SecretName.Name # Writes the secret name operator
        Write-Host "Secret Value" $secretValueText # Writes the secret value for the operator 
        Write-host "\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\"
        # End write final output to operator
    }
}      