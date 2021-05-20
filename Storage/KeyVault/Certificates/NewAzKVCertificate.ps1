# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Mircosoft docs links
    Add-AzKeyVaultCertificate:  https://docs.microsoft.com/en-us/powershell/module/az.keyvault/add-azkeyvaultcertificate?view=azps-5.9.0
    New-AzKeyVaultCertificatePolicy:    https://docs.microsoft.com/en-us/powershell/module/az.keyvault/new-azkeyvaultcertificatepolicy?view=azps-5.9.0
    Get-AzKeyVault:             https://docs.microsoft.com/en-us/powershell/module/az.keyvault/get-azkeyvault?view=azps-5.1.0
} #>
<# Required Functions Links: {
    NewAzKVCertificatePolicy:   https://github.com/benjaminsmorgan/Azure-Powershell/tree/main/Storage/KeyVault/Certificates/NewAzKVCertificatePolicy.ps1
    GetAzKeyVault:              https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Storage/KeyVault/GetAzKeyVault.ps1
} #>
<# Functions Description: {
    NewAzKVCertificate:         Creates a new key vault certificate
    NewAzKVCertificatePolicy:   Creates a new key vault certificate policy
    GetAzKeyVault:              Gets key vault object
} #>
<# Variables: {
    :NewAzureKVCert             Outer loop for managing function
    :SetAzureKVCertName         Inner loop for setting the cert name
    $CallingFunction:           Name of this function or the one that called it
    $KeyVaultObject:            Key vault object
    $Policy:                    Certificate policy object
    $CertName:                  Name of the cert
    $OpConfirm:                 Operator confirmation of the cert name
    GetAzKeyVault{}             Gets $KeyVaultSecret
    NewAzKVCertificatePolicy{}  Gets $Policy
} #>
<# Process Flow {
    Function
        Call NewAzKVCertificate > Get $null
            Call GetAzKeyVault > Get $KeyVaultObject
            End GetAzKeyVault
                Return NewAzKVCertificate > Send $KeyVaultObject 
            Call  NewAzKVCertificatePolicy > Get $Policy
            End NewAzKVCertificatePolicy
                Return NewAzKVCertificate > Send $Policy
        End NewAzKVCertificate
            Return Function > Send $null
}#>
function NewAzKVCertificate {                                                               # Function to create a certificate
    Begin {                                                                                 # Begin function
        if (!$CallingFunction) {                                                            # If $CallingFunction is $null
            $CallingFunction = 'NewAzKVCertificate'                                         # Creates $CallingFunction 
        }                                                                                   # End if (!$CallingFunction)
        :NewAzureKVCert while ($true) {                                                     # Outer loop for managing function
            $KeyVaultObject = GetAzKeyVault ($CallingFunction)                              # Calls function and assigns output to $var
            if (!$KeyVaultObject) {                                                         # If $KeyVaultObject is $null
                Break NewAzureKVCert                                                        # Breaks :NewAzureKVCert
            }                                                                               # End if (!$KeyVaultObject)
            $Policy = NewAzKVCertificatePolicy ($CallingFunction)                           # Calls function and assigns output to $var
            if (!$Policy) {                                                                 # If $Policy is $null
                Break NewAzureKVCert                                                        # Breaks :NewAzureKVCert
            }                                                                               # End if (!$Policy)
            :SetAzureKVCertName while ($true) {                                             # Inner loop for setting the cert name
                Write-Host 'Enter the name of the certificate'                              # Write message to screen
                $CertName = Read-Host 'Name'                                                # Operator input of the cert name
                Clear-Host                                                                  # Clears screen
                Write-Host 'Use:'$CertName'as the certificate name?'                        # Write message to screen
                $OpConfirm = Read-Host '[Y] Yes [N] No [E] Exit'                            # Operator confirmation of the cert name
                if ($OpConfirm -eq 'e') {                                                   # If $OpSelect equals 'e'
                    Break NewAzureKVCert                                                    # Breaks :NewAzureKVCert
                }                                                                           # End if ($OpConfirm -eq 'e')
                elseif ($OpConfirm -eq 'y') {                                               # Else if $OpSelect equals 'y'
                    Break SetAzureKVCertName                                                # Breaks :SetAzureKVCertName
                }                                                                           # End elseif ($OpConfirm -eq 'y') 
                else {                                                                      # All other inputs for $OpSelect
                    Clear-Host                                                              # Clears screen
                }                                                                           # End else (if ($OpConfirm -eq 'e'))
            }                                                                               # End :SetAzureKVCertName while ($true)
            try {                                                                           # Try the following
                Add-AzKeyVaultCertificate -VaultName $KeyVaultObject.VaultName -Name `
                    $CertName -CertificatePolicy $Policy -ErrorAction 'Stop'                # Adds cert to key vault
            }                                                                               # End try
            Catch {                                                                         # If try fails
                Write-Host 'An error has occured'                                           # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break NewAzureKVCert                                                        # Breaks :NewAzureKVCert
            }                                                                               # End catch
            Write-Host 'The certificate has been added'                                     # Write message to screen
            Pause                                                                           # Pauses all actions for operator input
            Break NewAzureKVCert                                                            # Breaks :NewAzureKVCert
        }                                                                                   # End :NewAzureKVCertPolicy while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function NewAzKVCertificate