# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Mircosoft docs links
    Get-AzKeyVaultSecret:       https://docs.microsoft.com/en-us/powershell/module/az.keyvault/get-azkeyvaultsecret?view=azps-5.1.0
    Convert value to plain txt: https://docs.microsoft.com/en-us/azure/key-vault/secrets/quick-create-powershell
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
    :GetAzureKeyVaultSecretVal  Outer loop for managing function
    $RGObject:                  Resource group object
    $KeyVaultObject:            Key vault object
    $KeyVaultSecretObject:      Key vault secret object
    GetAzKeyVaultSecret{}       Gets $KeyVaultSecretObject
        GetAzKeyVault{}             Gets $KeyVaultSecret
            GetAzResourceGroup{}        Gets $RGObject
} #>
<# Process Flow {
    Function
        Call GetAzKeyVaultSecretValue > Get $null
            Call GetAzKeyVaultSecret > Get $KeyVaultSecretObject
                Call GetAzKeyVault > Get $KeyVaultObject
                    Call GetAzResourceGroup > Get $RGObject
                    End GetAzResourceGroup
                        Return GetAzKeyVault > Send $RGObject
                End GetAzKeyVault
                    Return GetAzKeyVaultSecret > Send $KeyVaultObject
            End GetAzKeyVaultSecret
                Return GetAzKeyVaultSecretValue > Send $KeyVaultSecretObject  
        End GetAzKeyVaultSecretValue
            Return Function > Send $null
}#>
function GetAzKeyVaultSecretValue { # Function to return the value of a key vault secret
    Begin {
        #$ErrorActionPreference='silentlyContinue' # Disables Errors
        #$WarningPreference = "silentlyContinue" # Disables key vault warnings
        :GetAzureKeyVaultSecretValue while ($true) { # Outer loop for managing function
            if (!$KeyVaultSecretObject) { # If $var is $null
                $KeyVaultSecretObject = GetAzKeyVaultSecret ($RGObject, $KeyVaultObject) # Calls function and assigns output to $Var
                if (!$KeyVaultSecretObject) { # If $var is $null
                    Break GetAzureKeyVaultSecretVal # Breaks :GetAzureKeyVaultSecretVal
                } # End if (!$KeyVaultSecretObject)
            } # End if (!$KeyVaultSecretObject)
            KeyVaultSecretValue = $null # Clears $KeyVaultSecretValue from all previous use
            $ssPtr = [System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($KeyVaultSecretObject.SecretValue) # Provided by MS Azure
            try { # Provided by MS Azure
                $KeyVaultSecretValue = [System.Runtime.InteropServices.Marshal]::PtrToStringBSTR($ssPtr) # Provided by MS Azure
            } # Provided by MS Azure
            Catch { # If error occurs
                Write-Host "An error has occured, you may not the permissions to this object" # Write message to screen
                Break GetAzureKeyVaultSecretVal # Breaks :GetAzureKeyVaultSecretVal
            } # End catch
            finally { # Provided by MS Azure
                [System.Runtime.InteropServices.Marshal]::ZeroFreeBSTR($ssPtr) # Provided by MS Azure
            } # Provided by MS Azure # This code was provided by MS, at this time is not needed and has commented out
            Write-Host "The value of"$KeyVaultSecretObject.Name "is:" $KeyVaultSecretValue # Prints secret name and value to screen
            Break GetAzureKeyVaultSecretVal # Breaks :GetAzureKeyVaultSecretVal
        } # End :GetAzureKeyVaultSecretValue while ($true) 
        Return # Returns to calling function with $null
    } # End begin statement   
} # End function GetAzKeyVaultSecretValue