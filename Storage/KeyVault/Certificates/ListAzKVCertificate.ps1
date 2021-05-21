# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Mircosoft docs links
    Get-AzKeyVaultCertificate:  https://docs.microsoft.com/en-us/powershell/module/az.keyvault/get-azkeyvaultcertificate?view=azps-5.9.0
    Get-AzKeyVault:             https://docs.microsoft.com/en-us/powershell/module/az.keyvault/get-azkeyvault?view=azps-5.1.0
} #>
<# Required Functions Links: {
    None
} #>
<# Functions Description: {
    ListAzKVCertificate:        Lists all key vault certificates
} #>
<# Variables: {
    $KVList:                    List of all key vaults
    $KeyVaultName:              Current item .vaultname           
    $CertList:                  List of all certificates in $KeyVaultName
} #>
<# Process Flow {
    Function
        Call NewAzKVCertificate > Get $null
        End NewAzKVCertificate
            Return Function > Send $null
}#>
function ListAzKVCertificate {                                                              # Function to list key vault certs
    Begin {                                                                                 # Begin function
        $KVList = Get-AzKeyVault                                                            # Pulls a list of all key vaults
        foreach ($_ in $KVList) {                                                           # For each item in $KVList
            $KeyVaultName = $_.VaultName                                                    # $KeyVaultName is equal to current item .VaultName
            $CertList = Get-AzKeyVaultCertificate -VaultName $KeyVaultName                  # Pulls a list of all certs in $KeyVaultNAme
            Write-Host '------------------------------------------------------------------' # Write message to screen
            Write-Host 'Vault Name:'$KeyVaultName                                           # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            if (!$CertList) {                                                               # If $CertList is $null
                Write-Host 'No certs in this vault'                                         # Write message to screen
                Write-Host ''                                                               # Write message to screen
            }                                                                               # End if (!$CertList)
            else {                                                                          # If $CertList has a value
                foreach ($_ in $CertList) {                                                 # For each item in $CertList
                    Write-Host 'Name:       ' $_.name                                       # Write message to screen
                    Write-Host 'ID:         ' $_.ID                                         # Write message to screen
                    Write-Host 'Enabled:    ' $_.Enabled                                    # Write message to screen
                    Write-Host 'Created:    ' $_.Created                                    # Write message to screen
                    Write-Host 'Updated:    ' $_.Updated                                    # Write message to screen
                    Write-Host 'Not Before: ' $_.NotBefore                                  # Write message to screen
                    Write-Host 'Expires:    ' $_.Expires                                    # Write message to screen
                    if ($_.Version) {                                                       # If current item .version has a value
                        Write-Host 'Version:    ' $_.Version                                # Write message to screen
                    }                                                                       # End if ($_.Version)
                    Write-Host ''                                                           # Write message to screen
                }                                                                           # End foreach ($_ in $CertList)
            }                                                                               # End else (if (!$CertList))
            Write-Host '------------------------------------------------------------------' # Write message to screen
        }                                                                                   # End foreach ($_ in $KVList)
        Pause                                                                               # Pauses all actions for operator input
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function ListAzKVCertificate 