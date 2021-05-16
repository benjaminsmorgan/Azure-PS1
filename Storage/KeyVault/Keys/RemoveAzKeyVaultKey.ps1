# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Mircosoft docs links
    Remove-AzKeyVaultKey:       https://docs.microsoft.com/en-us/powershell/module/az.keyvault/remove-azkeyvaultKey?view=azps-5.1.0
    Get-AzKeyVaultKey:          https://docs.microsoft.com/en-us/powershell/module/az.keyvault/get-azkeyvaultKey?view=azps-5.1.0
    Get-AzKeyVault:             https://docs.microsoft.com/en-us/powershell/module/az.keyvault/get-azkeyvault?view=azps-5.1.0
} #>
<# Required Functions Links: {
    GetAzKeyVaultKey:           https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Storage/KeyVault/Keys/GetAzKeyVaultKey.ps1
    GetAzKeyVault:              https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Storage/KeyVault/GetAzKeyVault.ps1
} #>
<# Functions Description: {
    RemoveAzKeyVaultKey:        Removes key vault Key
    GetAzKeyVaultKey:           Gets a key vault Key object
    GetAzKeyVault:              Gets key vault object
} #>
<# Variables: {
    :RemoveAzureKeyVaultKey     Outer loop for managing function
    $RGObject:                  Resource group object
    $KeyVaultObject:            Key vault object
    $KeyVaultKeyObject:         Key vault Key object
    $ConfirmDelete:             Operator confirmation to remove the Key
    GetAzKeyVaultKey{}          Gets $KeyVaultKeyObject
        GetAzKeyVault{}             Gets $KeyVaultKey
} #>
<# Process Flow {
    Function
        Call RemoveAzKeyVaultKey > Get $null
            Call GetAzKeyVaultKey > Get $KeyVaultKeyObject
                Call GetAzKeyVault > Get $KeyVaultObject
                End GetAzKeyVault
                    Return GetAzKeyVaultKey > Send $KeyVaultObject
            End GetAzKeyVaultKey
                Return RemoveAzKeyVaultKey > Send $KeyVaultKeyObject  
        End RemoveAzKeyVaultKey
            Return Function > Send $null
}#>
function RemoveAzKeyVaultKey {                                                              # Function to remove a key vault key
    Begin {                                                                                 # Begin function
        $ErrorActionPreference = 'silentlyContinue'                                         # Disables error reporting
        if (!$CallingFunction) {                                                            # If $CallingFunction does not have a value
            $CallingFunction = 'RemoveAzKeyVaultKey'                                        # Creates $CallingFunction 
        }                                                                                   # End if (!$CallingFunction)
        :RemoveAzureKeyVaultKey while ($true) {
            $KeyVaultKeyObject, $KeyVaultObject = GetAzKeyVaultKey ($CallingFunction)       # Calls function and assigns output to $var
            if (!$KeyVaultKeyObject) {                                                      # If $KeyVaultKeyObject is $null
                Break RemoveAzureKeyVaultKey                                                # Breaks :DownloadAzureKeyVaultKey    
            }                                                                               # End if (!$KeyVaultObject)
            Write-host 'The remove key:'$KeyVaultKeyObject.Name                             # Write message to screen
            Write-Host 'From vault:'    $KeyVaultObject.VaultName                           # Write message to screen
            $OpConfirm = Read-Host '[Y] Yes [N] No'                                         # Operator confirmation for deletion
            if ($OpConfirm -eq 'y') {                                                       # If $OpConfirm is equal to 'y'
                Write-Host 'Removing:' $KeyVaultKeyObject.Name                              # Write message to screen
                Try {                                                                       # Try the following
                    Remove-AzKeyVaultKey -Name $KeyVaultKeyObject.Name -VaultName `
                        $KeyVaultKeyObject.VaultName -Force -ErrorAction 'Stop'             # Removes the selected key
                }                                                                           # End Try
                catch {                                                                     # If Try fails
                    Write-Host 'There was an issue removing the selected key'               # Write message to screen
                    Write-Host 'You may not have the permissions to remove this key'        # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Clear-Host                                                              # Clears screen
                    Break RemoveAzureKeyVaultKey                                            # Breaks :RemoveAzureKeyVaultKey 
                }                                                                           # End catch
                Write-Host 'The Key has been removed'                                       # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Clear-Host                                                                  # Clears screen
                Break RemoveAzureKeyVaultKey                                                # Breaks :RemoveAzureKeyVaultKey
            }                                                                               # End if ($ConfirmDelete -eq 'y')
            else {                                                                          # If $OpConfirm does not equal 'y'
                Write-Host 'No changes have been made'                                      # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Clear-Host                                                                  # Clears screen
                Break RemoveAzureKeyVaultKey                                                # Breaks :RemoveAzureKeyVaultKey
            }                                                                               # End else (if ($ConfirmDelete -eq 'y'))
        }                                                                                   # End :RemoveAzureKeyVaultKey while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to callign function with $null
    }                                                                                       # End Begin
}                                                                                           # End function RemoveAzKeyVaultKey