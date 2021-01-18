# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Mircosoft docs links
    Set-AzKeyVaultSecret:       https://docs.microsoft.com/en-us/powershell/module/az.keyvault/set-azkeyvaultsecret?view=azps-5.1.0
    Get-AzKeyVault:             https://docs.microsoft.com/en-us/powershell/module/az.keyvault/get-azkeyvault?view=azps-5.1.0
    Get-AzResourceGroup:        https://docs.microsoft.com/en-us/powershell/module/az.resources/get-azresourcegroup?view=azps-5.1.0
} #>
<# Required Functions Links: {
    GetAzKeyVault:              https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Storage/KeyVault/GetAzKeyVault.ps1
        GetAzResourceGroup:         https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/GetAzResourceGroup.ps1
} #>
<# Functions Description: {
    NewAzKeyVaultSecret:        Creates a new key vault secret
    GetAzKeyVault:              Gets key vault object
    GetAzResourceGroup:         Gets resource group object
} #>
<# Variables: {
    :NewAzureKeyVaultSecret     Outer loop for managing function
    :NewAzureKeyVaultSecretName Inner loop for setting the secret name
    :NewAzureKeyVaultSecretVal  Inner loop for setting the secret value
    $RGObject:                  Resource group object
    $KeyVaultObject:            Key vault object
    $KeyVaultSecretName:        Operator input for the secret name
    $OperatorConfirm:           Operator confirmation of name and value
    $KeyVaultSecretValue:       Operator input for the secret value
    $KeyVaultSecretHash:        Hashed version of $KeyVauleSecretValue
    $KeyVaultSecretObject:      Key vault secret
    GetAzKeyVault{}             Gets $KeyVaultSecret
        GetAzResourceGroup{}        Gets $RGObject
} #>
<# Process Flow {
    Function
        Call NewAzKeyVaultSecret > Get $KeyVaultSecretObject
            Call GetAzKeyVault > Get $KeyVaultObject
                Call GetAzResourceGroup > Get $RGObject
                End GetAzResourceGroup
                    Return GetAzKeyVault > Send $RGObject
            End GetAzKeyVault
                Return NewAzKeyVaultSecret > Send $KeyVaultObject  
        End NewAzKeyVaultSecret
            Return Function > Send $KeyVaultSecretObject
}#>
function NewAzKeyVaultSecret { # Creates a new key vault secret
    Begin {
        $ErrorActionPreference='silentlyContinue' # Disables Errors
        $WarningPreference = "silentlyContinue" # Disables key vault warnings
        :NewAzureKeyVaultSecret while ($true) { # Outer loop for managing function
            if (!$KeyVaultObject) { # If $var is $null
                $KeyVaultObject = GetAzKeyVault ($RGObject) # Calls function and assigns output to $Var
                if (!$KeyVaultObject) { # If $var is $null
                    Break NewAzureKeyVaultSecret # Breaks :NewAzureKeyVaultSecret
                } # End if (!$KeyVaultObject)
            } # End if (!$KeyVaultObject)
            :NewAzureKeyVaultSecretName while ($true) { # Inner loop for setting the new key vault secret name
                $KeyVaultSecretName = Read-Host "New key vault secret name" # Prompt for operator input for $KeyVaultSecretName
                Write-Host $KeyVaultSecretName # Write message to screen
                $OperatorConfirm = Read-Host "Use this as the secret name [Y] or [N]" # Operator confirmation of name
                if ($OperatorConfirm -eq 'exit') { # If $OperatorConfirm is equal to 'exit'
                    Break NewAzureKeyVaultSecret # Breaks :NewAzureKeyVaultSecret
                } # End if ($OperatorConfirm -eq 'exit')
                if ($OperatorConfirm -eq 'y') { # If $OperatorConfirm is equal to 'y'
                    Break :NewAzureKeyVaultSecretName # Breaks :NewAzureKeyVaultSecretName
                } # End if ($OperatorConfirm -eq 'y')
            } # End :NewAzureKeyVaultSecretName while ($true)
            :NewAzureKeyVaultSecretValue while ($true) { # Inner loop for setting the new key vault secret value
                $KeyVaultSecretValue = Read-Host "New key vault secret value" # Prompt for operator input for $KeyVaultSecretvalue
                Write-Host $KeyVaultSecretValue # Write message to screen
                $OperatorConfirm = Read-Host "Use this as the secret value [Y] or [N]" # Operator confirmation of value
                if ($OperatorConfirm -eq 'exit') { # If $OperatorConfirm is equal to 'exit'
                    Break NewAzureKeyVaultSecret # Breaks :NewAzureKeyVaultSecret
                } # End if ($OperatorConfirm -eq 'exit')
                if ($OperatorConfirm -eq 'y') { # If $OperatorConfirm is equal to 'y'
                    Break :NewAzureKeyVaultSecretValue # Breaks :NewAzureKeyVaultSecretValue
                } # End if ($OperatorConfirm -eq 'y')
            } # End :NewAzureKeyVaultSecretValue while ($true)
            $KeyVaultSecretHash = ConvertTo-SecureString -String $KeyVaultSecretValue -AsPlainText -Force # Converts the operator input to secure string
            $KeyVaultSecretObject = Set-AzKeyVaultSecret -VaultName $KeyVaultObject.VaultName -Name $KeyVaultSecretName -SecretValue $KeyVaultSecretHash # Creates $KeyVaultSecretObject
            Return $KeyVaultSecretObject # Returns to calling function with $KeyVaultSecretObject
        } # End :NewAzureKeyVaultSecret while ($true)
        Return # Returns to calling function with $null
    } # End Begin
} # End function NewAzKeyVaultSecret