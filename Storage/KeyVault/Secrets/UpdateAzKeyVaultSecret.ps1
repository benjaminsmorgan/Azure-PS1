# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Mircosoft docs links
    Set-AzKeyVaultSecret:       https://docs.microsoft.com/en-us/powershell/module/az.keyvault/set-azkeyvaultsecret?view=azps-5.1.0
    Get-AzKeyVaultSecret:       https://docs.microsoft.com/en-us/powershell/module/az.keyvault/get-azkeyvaultsecret?view=azps-5.1.0
    Get-AzKeyVault:             https://docs.microsoft.com/en-us/powershell/module/az.keyvault/get-azkeyvault?view=azps-5.1.0
} #>
<# Required Functions Links: {
    GetAzKeyVaultSecret:        https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Storage/KeyVault/Secrets/GetAzKeyVaultSecret.ps1
        GetAzKeyVault:              https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Storage/KeyVault/GetAzKeyVault.ps1
} #>
<# Functions Description: {
    UpdateAzKeyVaultSecret:     Updates key vault secret
    GetAzKeyVaultSecret:        Gets a key vault secret object
    GetAzKeyVault:              Gets key vault object
} #>
<# Variables: {
    :UpdateAzureKeyVaultSecret  Outer loop for managing function
    :UpdateAzureKVSecretValue   Inner loop for setting the new secret value
    $CallingFunction:           Name of this function or the one that called it
    $KeyVaultObject:            Key vault object
    $KeyVaultSecretObject:      Key vault secret object
    $KeyVaultSecretValue:       New secret value
    $OpConfirm:                 Operator confirmation of the inputed value
    $KeyVaultSecretHash:        Hashed version of $KeyVaultSecretValue
    GetAzKeyVaultSecret{}       Gets $KeyVaultSecretObject
        GetAzKeyVault{}             Gets $KeyVaultSecret
} #>
<# Process Flow {
    Function
        Call UpdateAzKeyVaultSecret > Get $null
            Call GetAzKeyVaultSecret > Get $KeyVaultSecretObject
                Call GetAzKeyVault > Get $KeyVaultObject
                End GetAzKeyVault
                    Return GetAzKeyVaultSecret > Send $KeyVaultObject
            End GetAzKeyVaultSecret
                Return UpdateAzKeyVaultSecret > Send $KeyVaultSecretObject  
        End UpdateAzKeyVaultSecret
            Return Function > Send $null
}#>
function UpdateAzKeyVaultSecret {                                                           # Function to update the value of selected key
    Begin {                                                                                 # Begin function
        $ErrorActionPreference='silentlyContinue'                                           # Disables Errors
        $WarningPreference = "silentlyContinue"                                             # Disables key vault warnings
        if (!$CallingFunction) {                                                            # If $CallingFunction does not have a value
            $CallingFunction = 'UpdateAzKeyVaultSecret'                                     # Creates $CallingFunction
        }                                                                                   # End if (!$CallingFunction)
        :UpdateAzureKeyVaultSecret while ($true) {                                          # Outer loop for managing funciton
            $KeyVaultSecretObject, $KeyVaultObject = GetAzKeyVaultSecret ($CallingFunction) # Calls function and assigns output to $Var
            if (!$KeyVaultSecretObject) {                                                   # If $KeyVaultSecretObject is $null
                Break UpdateAzureKeyVaultSecret                                             # Breaks :UpdateAzureKeyVaultSecret
            }                                                                               # End if (!$KeyVaultSecretObject)
            :UpdateAzureKVSecretValue while ($true) {                                       # Inner loop for updating key vault secret value
                Write-Host 'Please enter a new value for:'$KeyVaultSecretObject.Name        # Write message to screen
                $KeyVaultSecretValue = Read-Host 'New value'                                # Operator input for the new secret value
                Write-Host 'Use:'$KeyVaultSecretValue'as the new value'                     # Write message to screen
                $OpConfirm = Read-Host '[Y] Yes [N] No [E] Exit'                            # Operator confirmation of value
                if ($OpConfirm -eq 'e') {                                                   # If $OpConfirm is equal to 'e'
                    Break UpdateAzureKeyVaultSecret                                         # Breaks :NewAzureKeyVaultSecret
                }                                                                           # End if ($OpConfirm -eq 'e')
                if ($OpConfirm -eq 'y') {                                                   # If $OConfirm is equal to 'y'
                    Clear-Host                                                              # Clears screen
                    Break UpdateAzureKVSecretValue                                          # Breaks :UpdateAzureKVSecretValue
                }                                                                           # End if ($OpConfirm -eq 'y')
                else {                                                                      # All other inputs for $OpConfirm
                    Clear-Host                                                              # Clears screen
                }                                                                           # End else (if ($OpConfirm -eq 'y'))
            }                                                                               # End :UpdateAzureKVSecretValue while ($true)
            $KeyVaultSecretHash = ConvertTo-SecureString -String $KeyVaultSecretValue `
                -AsPlainText -Force                                                         # Converts the operator input to secure string
            try {                                                                           # Try to do the following
                Set-AzKeyVaultSecret -VaultName $KeyVaultObject.VaultName -Name `
                    $KeyVaultSecretObject.Name -SecretValue $KeyVaultSecretHash `
                    -ErrorAction 'Stop'                                                     # Updates $KeyVaultSecretObject
            }                                                                               # End Try
            catch {                                                                         # If try statement fails
                Write-Host 'There was an issue updating this secret'                        # Write message to screen
                Write-Host 'You may not have the permissions to modify this secret'         # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break UpdateAzureKeyVaultSecret                                             # Breaks :UpdateAzureKVSecretValue 
            }                                                                               # End catch
            Write-Host $KeyVaultSecretObject.Name'has been updated'                         # Write message to screen
            Pause                                                                           # Pauses all actions for operator input
            Break UpdateAzureKeyVaultSecret                                                 # Breaks :UpdateAzureKVSecretValue
        }                                                                                   # End :UpdateAzureKeyVaultSecret while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function UpdateAzKeyVaultSecret