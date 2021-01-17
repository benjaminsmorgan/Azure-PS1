# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Mircosoft docs links
    Remove-AzKeyVault:          https://docs.microsoft.com/en-us/powershell/module/az.keyvault/remove-azkeyvault?view=azps-5.3.0
    Get-AzKeyVault:             https://docs.microsoft.com/en-us/powershell/module/az.keyvault/get-azkeyvault?view=azps-5.3.0
    Get-AzResourceGroup:        https://docs.microsoft.com/en-us/powershell/module/az.resources/get-azresourcegroup?view=azps-5.1.0
} #>
<# Required Functions Links: {
    GetAzKeyVault:              https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Storage/KeyVault/GetAzKeyVault.ps1
    GetAzResourceGroup:         https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/GetAzResourceGroup.ps1
} #>
<# Functions Description: {
    RemoveAzKeyVault:           Removes $KeyVaultObject
    GetAzKeyVault:              Gets $KeyVaultObject
    GetAzResourceGroup:         Gets $RGObject
} #>
<# Variables: {      
    :RemoveAzureKeyVault        Outer loop for managing function
    $KVObject:                  Key vault object
    $ConfirmDelete              Operator confirmation to delete $KeyVaultObject
    GetAzKeyVaul{}              Gets $KeyVaultObject
        GetAzResourceGroup{}        Gets $RGObject
} #>
<# Process Flow {
    function
        Call RemoveAzKeyVault > Get $null
            Call GetAzKeyVault > Get $KeyVaultObject
                Call GetAzResourceGroup > Get $RGObject
                End GetAzResourceGroup
                    Return GetAzStorageAccount > Send $RGObject
            End GetAzKeyVault > Send $StorageKeyVaultObject
        End RemoveAzKeyVault
            Return Function > Send $null
}#>
function RemoveAzKeyVault { # Removes $KeyVaultObject
    Begin {
        :RemoveAzureKeyVault while ($true) { # Outer loop for managing function
            if (!$KeyVaultKeyObject) { # If $KeyVaultKeyObject is empty
                $KeyVaultKeyObject = GetAzKeyVault # Calls function and assigns output to $var
                if (!$KeyVaultKeyObject) { # If $KeyVaultKeyObject is still empty after returning
                    Break RemoveAzureKeyVault # Breaks :RemoveAzureKeyVault
                } # End if (!$KeyVaultKeyObject)
            } # End if (!$KeyVaultKeyObject)
            Write-Host "Remove Vault "$KeyVaultKeyObject.VaultName "in resource group "$KeyVaultKeyObject.ResourceGroupName # Write message to screen
            $ConfirmDelete = Read-Host "[Y] or [N]" # Operator confirmation to delete the key vault
            if (!($ConfirmDelete -eq 'y')) { # If Confirm delete is not 'y'
                Write-Host "No action taken" # Write message to screen
                Break RemoveAzureKeyVault # Breaks :RemoveAzureKeyVault
            } # End if (!($ConfirmDelete -eq 'y'))
            else { # IF $ConfrimDelete is not 'y'
                Write-Host "Deleting "$KeyVaultKeyObject.VaultName # Write message to screen
                Remove-AzKeyVault -VaultName $KeyVaultKeyObject.VaultName -ResourceGroupName $KeyVaultKeyObject.ResourceGroupName -force # Removes the key vault
                Break RemoveAzureKeyVault # Breaks :RemoveAzureKeyVault
            } # End else if (!($ConfirmDelete -eq 'y'))
        } # End :RemoveAzureKeyVault while ($true)
        Return # Returns to calling function
    } # End Begin
} # End function RemoveAzKeyVault