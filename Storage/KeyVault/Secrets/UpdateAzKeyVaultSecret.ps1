# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Mircosoft docs links
    Set-AzKeyVaultSecret:       https://docs.microsoft.com/en-us/powershell/module/az.keyvault/set-azkeyvaultsecret?view=azps-5.1.0
    Get-AzKeyVaultSecret:       https://docs.microsoft.com/en-us/powershell/module/az.keyvault/get-azkeyvaultsecret?view=azps-5.1.0
    Get-AzKeyVault:             https://docs.microsoft.com/en-us/powershell/module/az.keyvault/get-azkeyvault?view=azps-5.1.0
    Get-AzResourceGroup:        https://docs.microsoft.com/en-us/powershell/module/az.resources/get-azresourcegroup?view=azps-5.1.0
} #>
<# Required Functions Links: {
    GetAzKeyVaultSecret:        https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Storage/KeyVault/Secrets/GetAzKeyVaultSecret.ps1
        GetAzKeyVault:              https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Storage/KeyVault/GetAzKeyVault.ps1
            GetAzResourceGroup:         https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/GetAzResourceGroup.ps1
} #>
<# Functions Description: {
    UpdateAzKeyVaultSecret:     Updates key vault secret
    GetAzKeyVaultSecret:        Gets a key vault secret object
    GetAzKeyVault:              Gets key vault object
    GetAzResourceGroup:         Gets resource group object
} #>
<# Variables: {
    :UpdateAzureKeyVaultSecret  Outer loop for managing function
    :UpdateAzureKVSecretValule  Inner loop for setting the new secret value
    $RGObject:                  Resource group object
    $KeyVaultObject:            Key vault object
    $KeyVaultSecretObject:      Key vault secret object
    $KeyVaultSecretValue:       New secret value
    $OperatorConfirm:           Operator confirmation of the inputed value
    $KeyVaultSecretHash:        Hashed version of $KeyVaultSecretValue
    GetAzKeyVaultSecret{}       Gets $KeyVaultSecretObject
        GetAzKeyVault{}             Gets $KeyVaultSecret
            GetAzResourceGroup{}        Gets $RGObject
} #>
<# Process Flow {
    Function
        Call UpdateAzKeyVaultSecret > Get $null
            Call GetAzKeyVaultSecret > Get $KeyVaultSecretObject
                Call GetAzKeyVault > Get $KeyVaultObject
                    Call GetAzResourceGroup > Get $RGObject
                    End GetAzResourceGroup
                        Return GetAzKeyVault > Send $RGObject
                End GetAzKeyVault
                    Return GetAzKeyVaultSecret > Send $KeyVaultObject
            End GetAzKeyVaultSecret
                Return UpdateAzKeyVaultSecret > Send $KeyVaultSecretObject  
        End UpdateAzKeyVaultSecret
            Return Function > Send $null
}#>
function UpdateAzKeyVaultSecret { # Updates the value of selected key
    Begin { 
        :UpdateAzureKeyVaultSecret while ($true) { # Outer loop for managing funciton
            if (!$KeyVaultSecretObject) { # If $var is $null
                $KeyVaultSecretObject = GetAzKeyVaultSecret ($RGObject, $KeyVaultObject) # Calls function and assigns output to $Var
                if (!$KeyVaultSecretObject) { # If $var is $null
                    Break UpdateAzureKeyVaultSecret # Breaks :RemoveAzureKeyVaultSecret
                } # End if (!$KeyVaultSecretObject)
            } # End if (!$KeyVaultSecretObject)
            :UpdateAzureKVSecretValule while ($true) { # Inner loop for updating key vault secret value
                $KeyVaultSecretValue = Read-Host "New key vault secret value" # Prompt for operator input for $KeyVaultSecretvalue
                if ($KeyVaultSecretValue -eq 'exit') { # If $KeyVaultSecretValue is equal to 'exit'
                    Break UpdateAzureKeyVaultSecret # Breaks :NewAzureKeyVaultSecret
                } # End if ($KeyVaultSecretValue -eq 'exit')
                Write-Host $KeyVaultSecretValue # Write message to screen
                $OperatorConfirm = Read-Host "Use this as the secret value [Y] or [N]" # Operator confirmation of value
                if ($OperatorConfirm -eq 'y') { # If $OperatorConfirm is equal to 'y'
                    Break UpdateAzureKVSecretValule # Breaks :UpdateAzureKVSecretValule
                } # End if ($OperatorConfirm -eq 'y')
            } # End :UpdateAzureKVSecretValule while ($true)
            $KeyVaultSecretHash = ConvertTo-SecureString -String $KeyVaultSecretValue -AsPlainText -Force # Converts the operator input to secure string
            try { # Try to do the following
                $KeyVaultSecretObject = Set-AzKeyVaultSecret -VaultName $KeyVaultSecretObject.VaultName -Name $KeyVaultSecretObject.Name -SecretValue $KeyVaultSecretHash # Updates $KeyVaultSecretObject
            } # End Try
            catch { # If try statement fails
                Write-Host "There was an issue updating this secret" # Write message to screen
                Write-Host "You may not have the permissions to modify this secret" # Write message to screen
                Break UpdateAzureKVSecretValule # Breaks :UpdateAzureKVSecretValule 
            } # End catch
            Write-Host $KeyVaultSecretObject.Name"has been updated with the new value" # Write message to screen
            Break UpdateAzureKVSecretValule # Breaks :UpdateAzureKVSecretValule
        } # End  :UpdateAzureKeyVaultSecret while ($true)
        Return # Returns to calling function with $null
    } # End Begin
} # End function UpdateAzKeyVaultSecret