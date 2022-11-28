# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Microsoft docs links
    Get-AzKeyVaultSecret:       https://docs.microsoft.com/en-us/powershell/module/az.keyvault/get-azkeyvaultsecret?view=azps-5.1.0
    Get-AzKeyVault:             https://docs.microsoft.com/en-us/powershell/module/az.keyvault/get-azkeyvault?view=azps-5.1.0
} #>
<# Required Functions Links: {
    None
} #>
<# Functions Description: {
    ListAzKeyVaultSecret:       Lists all key vault Keys
} #>
<# Variables: {
    $KVList:                    List of all key vaults in subscription
    $KVSecretlist:              List of all Keys from current object in $KVList
} #>
<# Process Flow {
    Function
        Call ListAzKeyVaultSecret > Get $null
        End ListAzKeyVaultSecret
            Return Function > Send $null
}#>
function ListAzKeyVaultSecret {                                                             # Function to list all key vault secrets
    Begin {                                                                                 # Begin function
        $WarningPreference = "silentlyContinue"                                             # Disables key vault warnings
        $KVList = Get-AzKeyVault                                                            # Creates lists of all key vaults
        foreach ($VaultName in $KVList) {                                                   # For each key vault in $KVList
            Write-Host '------------------------------------------------------------------' # Write message to screen
            $KVSecretlist = Get-AzKeyVaultSecret -VaultName $VaultName.VaultName            # Creates a list of all secrets in current $VaultName
            Write-Host 'Vault Name: ' $VaultName.VaultName                                  # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            if ($KVSecretlist) {                                                            # If $KVSecretList has a value
                foreach ($Name in $KVSecretlist) {                                          # For each secret name in $KVSecretList
                    Write-Host 'Secret Name:' $Name.Name                                    # Write message to screen
                    Write-Host 'Secret ID:  ' $Name.ID                                      # Write message to screen
                    Write-Host 'Enabled:    ' $Name.Enabled                                 # Write message to screen
                    Write-Host 'Updated:    ' $Name.Updated                                 # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                }                                                                           # End foreach ($Name in $KVSecretlist)
            }                                                                               # End if ($KVSecretlist)
            else {                                                                          # If $KVSecretlist does not have a value
                Write-Host 'No secrets in this vault'                                       # Write message to screen
                Write-Host ''                                                               # Write message to screen
            }                                                                               # End else (if ($KVSecretlist))
        }                                                                                   # End foreach ($VaultName in $KVList)
        Write-Host '------------------------------------------------------------------'     # Write message to screen
        Pause                                                                               # Pauses all action for operator input
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin 
}                                                                                           # End function ListAzKeyVaultSecret