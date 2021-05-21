# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Mircosoft docs links
    Remove-AzKeyVaultSecret:    https://docs.microsoft.com/en-us/powershell/module/az.keyvault/remove-azkeyvaultsecret?view=azps-5.1.0
    Get-AzKeyVaultSecret:       https://docs.microsoft.com/en-us/powershell/module/az.keyvault/get-azkeyvaultsecret?view=azps-5.1.0
    Get-AzKeyVault:             https://docs.microsoft.com/en-us/powershell/module/az.keyvault/get-azkeyvault?view=azps-5.1.0
} #>
<# Required Functions Links: {
    GetAzKeyVaultSecret:        https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Storage/KeyVault/Secrets/GetAzKeyVaultSecret.ps1
    GetAzKeyVault:              https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Storage/KeyVault/GetAzKeyVault.ps1
} #>
<# Functions Description: {
    RemoveAzKeyVaultSecret:     Removes key vault secret
    GetAzKeyVaultSecret:        Gets a key vault secret object
    GetAzKeyVault:              Gets key vault object
} #>
<# Variables: {
    :RemoveAzureKeyVaultSecret  Outer loop for managing function
    $CallingFunction:           Name of this function or the one that called it
    $KeyVaultObject:            Key vault object
    $KeyVaultSecretObject:      Key vault secret object
    $OpConfirm:                 Operator confirmation to remove the secret
    GetAzKeyVaultSecret{}       Gets $KeyVaultSecretObject
        GetAzKeyVault{}             Gets $KeyVaultSecret
} #>
<# Process Flow {
    Function
        Call RemoveAzKeyVaultSecret > Get $null
            Call GetAzKeyVaultSecret > Get $KeyVaultSecretObject
                Call GetAzKeyVault > Get $KeyVaultObject
                End GetAzKeyVault
                    Return GetAzKeyVaultSecret > Send $KeyVaultObject
            End GetAzKeyVaultSecret
                Return RemoveAzKeyVaultSecret > Send $KeyVaultSecretObject, $KeyVaultObject  
        End RemoveAzKeyVaultSecret
            Return Function > Send $null
}#>
function RemoveAzKeyVaultSecret {                                                           # Function to remove a key vault secret
    Begin {                                                                                 # Begin function
        $ErrorActionPreference='silentlyContinue'                                           # Disables errors
        $WarningPreference = 'silentlyContinue'                                             # Disables key vault warnings
        if (!$CallingFunction) {                                                            # If $CallingFunction does not have a value
            $CallingFunction = 'RemoveAzKeyVaultSecret'                                     # Creates $CallingFunction
        }                                                                                   # End if (!$CallingFunction)
        :RemoveAzureKeyVaultSecret while ($true) {                                          # Outer loop for managing function
            $KeyVaultSecretObject, $KeyVaultObject = GetAzKeyVaultSecret ($CallingFunction) # Calls function and assigns output to $Var
            if (!$KeyVaultSecretObject) {                                                   # If $KeyVaultSecretObject is $null
                Break RemoveAzureKeyVaultSecret                                             # Breaks :RemoveAzureKeyVaultSecret
            }                                                                               # End if (!$KeyVaultSecretObject)
            Write-host ''                                                                   # Write message to screen
            Write-host 'Remove:    '$KeyVaultSecretObject.Name                              # Write message to screen
            Write-Host 'From vault:'$KeyVaultSecretObject.VaultName                         # Write message to screen
            Write-host ''                                                                   # Write message to screen
            $OpConfirm = Read-Host '[Y] Yes [N] No'                                         # Operator confirmation to delete 
            Clear-Host                                                                      # Clears screen
            if ($OpConfirm -eq 'y') {                                                       # If $OpConfirm equals 'y'
                Write-Host 'Removing' $KeyVaultSecretObject.Name                            # Write message to screen
                Try {                                                                       # Try the following
                    Remove-AzKeyVaultSecret -Name $KeyVaultSecretObject.Name -VaultName `
                        $KeyVaultSecretObject.VaultName -Force -ErrorAction 'Stop'          # Removes the selected secret
                }                                                                           # End Try
                catch {                                                                     # If try fails
                    Write-Host 'There was an issue removing the selected key'               # Write message to screen
                    Write-Host 'You may not have the permissions to remove this key'        # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Break RemoveAzureKeyVaultSecret                                         # Breaks :RemoveAzureKeyVaultSecret 
                }                                                                           # End catch
                Write-Host 'The secret has been removed'                                    # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break RemoveAzureKeyVaultSecret                                             # Breaks :RemoveAzureKeyVaultSecret
            }                                                                               # End if ($OpConfirm -eq 'y')
            else {                                                                          # If $OpConfirm is not equal to 'y'
                Write-Host 'No action taken'                                                # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break RemoveAzureKeyVaultSecret                                             # Breaks :RemoveAzureKeyVaultSecret
            }                                                                               # End else (if ($OpConfirm -eq 'y'))
        }                                                                                   # End :RemoveAzureKeyVaultSecret while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function RemoveAzKeyVaultSecret