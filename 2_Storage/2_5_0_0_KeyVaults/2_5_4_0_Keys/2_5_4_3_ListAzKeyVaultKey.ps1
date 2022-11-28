# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Microsoft docs links
    Get-AzKeyVaultKey:          https://docs.microsoft.com/en-us/powershell/module/az.keyvault/get-azkeyvaultKey?view=azps-5.1.0
    Get-AzKeyVault:             https://docs.microsoft.com/en-us/powershell/module/az.keyvault/get-azkeyvault?view=azps-5.1.0
} #>
<# Required Functions Links: {
    None
} #>
<# Functions Description: {
    ListAzKeyVaultKey:          Lists all key vault Keys
} #>
<# Variables: {
    $KVList:                    List of all key vaults in subscription
    $KVKeylist:                 List of all Keys from current object in $KVList
} #>
<# Process Flow {
    Function
        Call ListAzKeyVaultKey > Get $null
        End ListAzKeyVaultKey
            Return Function > Send $null
}#>
function ListAzKeyVaultKey {                                                                # Function to list all key vault keys
    Begin {                                                                                 # Begin function
        $KVList = Get-AzKeyVault                                                            # Creates lists of all key vaults
        foreach ($VaultName in $KVList) {                                                   # For each key vault in $KVList
            Write-Host '------------------------------------------------------------------' # Write message to screen
            $KVKeylist = Get-AzKeyVaultKey -VaultName $VaultName.VaultName                  # Creates a list of all keys in current $VaultName
            Write-Host 'Vault Name: ' $VaultName.VaultName                                  # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            if ($KVKeylist) {                                                               # If $KVKeyList has a value
                foreach ($Name in $KVKeylist) {                                             # For each Key name in $KVKeyList
                    Write-Host 'Key Name:   ' $Name.Name                                    # Write message to screen
                    Write-Host 'Key ID:     ' $Name.ID                                      # Write message to screen
                    Write-Host 'Enabled:    ' $Name.Enabled                                 # Write message to screen
                    Write-Host 'Updated:    ' $Name.Updated                                 # Write message to screen
                    if ($Name.Expires) {                                                    # If current item has an existing expiration
                        Write-Host 'Expires:    ' $Name.Expires                             # Write message to screen
                        Write-Host 'NotBefore:  ' $Name.NotBefore                           # Write message to screen
                    }                                                                       # End if ($Name.Expires)
                    Write-Host ''                                                           # Write message to screen
                }                                                                           # End foreach ($Name in $KVKeylist)
            }                                                                               # End if ($KVKeylist)
            else {                                                                          # If $KVKeylist does not have a value
                Write-Host 'No Keys in this vault'                                          # Write message to screen
                Write-Host ''                                                               # Write message to screen
            }                                                                               # End else (if ($KVKeylist))
        }                                                                                   # End foreach ($VaultName in $KVList)
        Write-Host '------------------------------------------------------------------'     # Write message to screen
        Pause                                                                               # Pauses all action for operator input
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin 
}                                                                                           # End function ListAzKeyVaultKey