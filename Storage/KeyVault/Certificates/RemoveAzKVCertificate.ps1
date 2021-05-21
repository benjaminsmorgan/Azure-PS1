# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Mircosoft docs links
    Remove-AzKeyVaultCertificate:    https://docs.microsoft.com/en-us/powershell/module/az.keyvault/remove-azkeyvaultcertificate?view=azps-5.1.0
    Get-AzKeyVaultCertificate:       https://docs.microsoft.com/en-us/powershell/module/az.keyvault/get-azkeyvaultcertificate?view=azps-5.1.0
    Get-AzKeyVault:             https://docs.microsoft.com/en-us/powershell/module/az.keyvault/get-azkeyvault?view=azps-5.1.0
} #>
<# Required Functions Links: {
    GetAzKVCertificate:         https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Storage/KeyVault/Certificates/GetAzKVCertificate.ps1
    GetAzKeyVault:              https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Storage/KeyVault/GetAzKeyVault.ps1
} #>
<# Functions Description: {
    RemoveAzKVCertificate:      Removes key vault certificate
    GetAzKVCertificate:         Gets a key vault certificate object
    GetAzKeyVault:              Gets key vault object
} #>
<# Variables: {
    :RemoveAzureKVCertificate   Outer loop for managing function
    $CallingFunction:           Name of this function or the one that called it
    $KeyVaultObject:            Key vault object
    $KeyVaultCertObject:        Key vault certificate object
    $OpConfirm:                 Operator confirmation to remove the certificate
    GetAzKVCertificate{}        Gets $KeyVaultCertObject
        GetAzKeyVault{}             Gets $KeyVaultCertificate
} #>
<# Process Flow {
    Function
        Call RemoveAzKVCertificate > Get $null
            Call GetAzKVCertificate > Get $KeyVaultCertObject
                Call GetAzKeyVault > Get $KeyVaultObject
                End GetAzKeyVault
                    Return GetAzKVCertificate > Send $KeyVaultObject
            End GetAzKVCertificate
                Return RemoveAzKVCertificate > Send $KeyVaultCertObject, $KeyVaultObject  
        End RemoveAzKVCertificate
            Return Function > Send $null
}#>
function RemoveAzKVCertificate {                                                            # Function to remove a key vault certificate
    Begin {                                                                                 # Begin function
        $ErrorActionPreference='silentlyContinue'                                           # Disables errors
        $WarningPreference = 'silentlyContinue'                                             # Disables key vault warnings
        if (!$CallingFunction) {                                                            # If $CallingFunction does not have a value
            $CallingFunction = 'RemoveAzKVCertificate'                                      # Creates $CallingFunction
        }                                                                                   # End if (!$CallingFunction)
        :RemoveAzureKVCertificate while ($true) {                                           # Outer loop for managing function
            $KeyVaultCertObject, $KeyVaultObject = GetAzKVCertificate ($CallingFunction)    # Calls function and assigns output to $Var
            if (!$KeyVaultCertObject) {                                                     # If $KeyVaultCertObject is $null
                Break RemoveAzureKVCertificate                                              # Breaks :RemoveAzureKVCertificate
            }                                                                               # End if (!$KeyVaultCertObject)
            Write-host ''                                                                   # Write message to screen
            Write-host 'Remove:    '$KeyVaultCertObject.Name                                # Write message to screen
            Write-Host 'From vault:'$KeyVaultCertObject.VaultName                           # Write message to screen
            Write-host ''                                                                   # Write message to screen
            $OpConfirm = Read-Host '[Y] Yes [N] No'                                         # Operator confirmation to delete 
            Clear-Host                                                                      # Clears screen
            if ($OpConfirm -eq 'y') {                                                       # If $OpConfirm equals 'y'
                Write-Host 'Removing' $KeyVaultCertObject.Name                              # Write message to screen
                Try {                                                                       # Try the following
                    Remove-AzKeyVaultCertificate -Name $KeyVaultCertObject.Name -VaultName `
                        $KeyVaultCertObject.VaultName -Force -ErrorAction 'Stop'            # Removes the selected cert
                }                                                                           # End Try
                catch {                                                                     # If try fails
                    Write-Host 'There was an issue removing the selected cert'              # Write message to screen
                    Write-Host 'You may not have the permissions to remove this cert'       # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Break RemoveAzureKVCertificate                                          # Breaks :RemoveAzureKVCertificate 
                }                                                                           # End catch
                Write-Host 'The certificate has been removed'                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break RemoveAzureKVCertificate                                              # Breaks :RemoveAzureKVCertificate
            }                                                                               # End if ($OpConfirm -eq 'y')
            else {                                                                          # If $OpConfirm is not equal to 'y'
                Write-Host 'No action taken'                                                # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break RemoveAzureKVCertificate                                              # Breaks :RemoveAzureKVCertificate
            }                                                                               # End else (if ($OpConfirm -eq 'y'))
        }                                                                                   # End :RemoveAzureKVCertificate while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function RemoveAzKVCertificate