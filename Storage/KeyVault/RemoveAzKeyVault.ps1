# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Mircosoft docs links
    Remove-AzKeyVault:          https://docs.microsoft.com/en-us/powershell/module/az.keyvault/remove-azkeyvault?view=azps-5.3.0
    Get-AzKeyVault:             https://docs.microsoft.com/en-us/powershell/module/az.keyvault/get-azkeyvault?view=azps-5.3.0
} #>
<# Required Functions Links: {
    GetAzKeyVault:              https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Storage/KeyVault/GetAzKeyVault.ps1
} #>
<# Functions Description: {
    RemoveAzKeyVault:           Removes $KeyVaultObject
    GetAzKeyVault:              Gets $KeyVaultObject
} #>
<# Variables: {      
    :RemoveAzureKeyVault        Outer loop for managing function
    $KeyVaultObject:            Key vault object
    $OpConfirm                  Operator confirmation to delete $KeyVaultObject
    GetAzKeyVaul{}              Gets $KeyVaultObject
} #>
<# Process Flow {
    function
        Call RemoveAzKeyVault > Get $null
            Call GetAzKeyVault > Get $KeyVaultObject
            End GetAzKeyVault 
            Return RemoveAzKeyVault> Send $StorageKeyVaultObject
        End RemoveAzKeyVault
            Return Function > Send $null
}#>
function RemoveAzKeyVault {                                                                 # Function to remove a key vault object
    Begin {                                                                                 # Begin function
        if (!$CallingFunction) {                                                            # If $CallingFunction does not have a value
            $CallingFunction = 'RemoveAzKeyVault'                                           # Creates $Calling function
        }                                                                                   # End if (!$CallingFunction)
        :RemoveAzureKeyVault while ($true) {                                                # Outer loop for managing function
            $KeyVaultKeyObject = GetAzKeyVault                                              # Calls function and assigns output to $var
            if (!$KeyVaultKeyObject) {                                                      # If $KeyVaultKeyObject is $null
                Break RemoveAzureKeyVault                                                   # Breaks :RemoveAzureKeyVault
            }                                                                               # End if (!$KeyVaultKeyObject)
            Write-Host 'Remove Vault: '$KeyVaultKeyObject.VaultName                         # Write message to screen
            Write-Host 'from resource group: '$KeyVaultKeyObject.ResourceGroupName          # Write message to screen
            $OpConfirm = Read-Host '[Y] Yes [N] No'                                         # Write message to screen
            if ($OpConfirm -eq 'y') {                                                       # If $OpConfirm equals 'y'
                Write-Host 'Removing:'$KeyVaultKeyObject.VaultName                          # Write message to screen
                Try {                                                                       # Try the following
                    Remove-AzKeyVault -VaultName $KeyVaultKeyObject.VaultName `
                        -ResourceGroupName $KeyVaultKeyObject.ResourceGroupName -force `
                        -ErrorAction 'Stop'                                                 # Removes the key vault
                }                                                                           # End try
                catch {                                                                     # If Try fails
                    Write-Host 'An error has occured'                                       # Write message to screen
                    Write-Host 'This resource maybe locked'                                 # Write message to screen
                    Write-Host 'The resource group maybe locked'                            # Write message to screen
                    Write-Host 'You may not have the permissions'                           # Write message to screen
                    Write-Host 'To perform a remove action'                                 # Write message to screen
                    Pause                                                                   # Pauses all action for operator input
                    Break RemoveAzureKeyVault                                               # Breaks :RemoveAzureKeyVault
                }                                                                           # End catch
                Write-Host $KeyVaultKeyObject.VaultName 'has been removed'                  # Write message to screen
                Pause                                                                       # Pauses all action for operator input
                Break RemoveAzureKeyVault                                                   # Breaks :RemoveAzureKeyVault
            }                                                                               # End if ($OpConfirm -eq 'y')
            else {                                                                          # All other inputs for $OpConfirm
                Write-Host 'No action taken'                                                # Write message to screen
                Pause                                                                       # Pauses all action for operator input
                Break RemoveAzureKeyVault                                                   # Breaks :RemoveAzureKeyVault
            }                                                                               # End else (if ($OpConfirm -eq 'y'))
        }                                                                                   # End :RemoveAzureKeyVault while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function RemoveAzKeyVault