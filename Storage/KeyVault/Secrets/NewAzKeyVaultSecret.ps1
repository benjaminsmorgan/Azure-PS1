# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Mircosoft docs links
    Set-AzKeyVaultSecret:       https://docs.microsoft.com/en-us/powershell/module/az.keyvault/set-azkeyvaultsecret?view=azps-5.1.0
    Get-AzKeyVault:             https://docs.microsoft.com/en-us/powershell/module/az.keyvault/get-azkeyvault?view=azps-5.1.0
} #>
<# Required Functions Links: {
    GetAzKeyVault:              https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Storage/KeyVault/GetAzKeyVault.ps1
} #>
<# Functions Description: {
    NewAzKeyVaultSecret:        Creates a new key vault secret
    GetAzKeyVault:              Gets key vault object
} #>
<# Variables: {
    :NewAzureKVSecret           Outer loop for managing function
    :NewAzureKVSecretName       Inner loop for setting the secret name
    :NewAzureKVSecretValue      Inner loop for setting the secret value
    $CallingFunction:           The name of this function, or the one that called it
    $KeyVaultObject:            Key vault object
    $KeyVaultSecretName:        Operator input for the secret name
    $OpConfirm:                 Operator confirmation of name and value
    $KeyVaultSecretValue:       Operator input for the secret value
    $KeyVaultSecretHash:        Hashed version of $KeyVauleSecretValue
    GetAzKeyVault{}             Gets $KeyVaultSecret
} #>
<# Process Flow {
    Function
        Call NewAzKeyVaultSecret > Get $null
            Call GetAzKeyVault > Get $KeyVaultObject
            End GetAzKeyVault
                Return NewAzKeyVaultSecret > Send $KeyVaultObject  
        End NewAzKeyVaultSecret
            Return Function > Send $null
}#>
function NewAzKeyVaultSecret {                                                              # Function to create a new key vault secret
    Begin {                                                                                 # Begin function
        if (!$CallingFunction) {                                                            # If $CallingFunction does not have a value
            $CallingFunction = 'NewAzKeyVaultSecret'                                        # Creates $CallingFunction
        }                                                                                   # End if (!$CallingFunction)
        $ErrorActionPreference='silentlyContinue'                                           # Disables Errors
        $WarningPreference = "silentlyContinue"                                             # Disables key vault warnings
        :NewAzureKVSecret while ($true) {                                                   # Outer loop for managing function
            $KeyVaultObject = GetAzKeyVault ($CallingFunction)                              # Calls function and assigns output to $Var
            if (!$KeyVaultObject) {                                                         # If $KeyVaultObject is $null
                Break NewAzureKVSecret                                                      # Breaks :NewAzureKVSecret
            }                                                                               # End if (!$KeyVaultObject)
            :NewAzureKVSecretName while ($true) {                                           # Inner loop for setting the new key vault secret name
                Write-Host 'Please enter the name of the new secret'                        # Write message to screen
                $KeyVaultSecretName = Read-Host 'Secret name'                               # Operator input for the secret name
                Write-Host 'Use:'$KeyVaultSecretName 'as the secret name'                   # Write message to screen
                $OpConfirm = Read-Host '[Y] Yes [N] No [E] Exit'                            # Operator confirmation of name
                if ($OpConfirm -eq 'e') {                                                   # If $OpConfirm is equal to 'e'
                    Break NewAzureKVSecret                                                  # Breaks :NewAzureKVSecret
                }                                                                           # End if ($OpConfirm -eq 'e')
                if ($OpConfirm -eq 'y') {                                                   # If $OpConfirm is equal to 'y'
                    Clear-Host                                                              # Clears screen
                    Break NewAzureKVSecretName                                              # Breaks :NewAzureKVSecretName
                }                                                                           # End if ($OpConfirm -eq 'y')
                Clear-Host                                                                  # Clears screen
            }                                                                               # End :NewAzureKVSecretName while ($true)
            :NewAzureKVSecretValue while ($true) {                                          # Inner loop for setting the new key vault secret value
                Write-Host 'Please enter the value of the new secret'                       # Write message to screen
                $KeyVaultSecretValue = Read-Host Read-Host 'Secret value'                   # Operator input for the secret value
                Write-Host 'Use:'$KeyVaultSecretValue 'as the secret value'                 # Write message to screen
                $OpConfirm = Read-Host '[Y] Yes [N] No [E] Exit'                            # Operator confirmation of name
                if ($OpConfirm -eq 'e') {                                                   # If $OpConfirm is equal to 'e'
                    Break NewAzureKVSecret                                                  # Breaks :NewAzureKVSecret
                }                                                                           # End if ($OpConfirm -eq 'e')
                if ($OpConfirm -eq 'y') {                                                   # If $OpConfirm is equal to 'y'
                    Clear-Host                                                              # Clears screen
                    $KeyVaultSecretHash = ConvertTo-SecureString -String `
                        $KeyVaultSecretValue -AsPlainText -Force                            # Converts the secret to a hashed value
                    Break NewAzureKVSecretValue                                             # Breaks :NewAzureKVSecretValue
                }                                                                           # End if ($OpConfirm -eq 'y')
                Clear-Host                                                                  # Clears screen
            }                                                                               # End :NewAzureKVSecretValue while ($true)
            Try {                                                                           # Try the following
                Set-AzKeyVaultSecret -VaultName $KeyVaultObject.VaultName -Name `
                    $KeyVaultSecretName -SecretValue $KeyVaultSecretHash `
                    -ErrorAction 'Stop'                                                     # Creates new secret
            }                                                                               # End Try
            catch {                                                                         # If try fails
                Write-Host 'An error has occured'                                           # Write message to screen
                Write-Host 'You may not have the'                                           # Write message to screen
                Write-Host 'permissions to do this'                                         # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break NewAzureKVSecret                                                      # Breaks :NewAzureKVSecret
            }                                                                               # End Catch
            Write-Host 'The secret has been created'                                        # Write message to screen
            Pause                                                                           # Pauses all actions for operator input
            Break NewAzureKVSecret                                                          # Breaks :NewAzureKVSecret
        }                                                                                   # End :NewAzureKVSecret while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function NewAzKeyVaultSecret