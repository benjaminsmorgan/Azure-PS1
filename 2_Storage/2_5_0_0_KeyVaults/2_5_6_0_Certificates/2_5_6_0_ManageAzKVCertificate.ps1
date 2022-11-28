# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Microsoft docs links
    Add-AzKeyVaultCertificate:  https://docs.microsoft.com/en-us/powershell/module/az.keyvault/add-azkeyvaultcertificate?view=azps-5.9.0
    New-AzKeyVaultCertificatePolicy:    https://docs.microsoft.com/en-us/powershell/module/az.keyvault/new-azkeyvaultcertificatepolicy?view=azps-5.9.0
    Import-AzKeyVaultCertificate    https://docs.microsoft.com/en-us/powershell/module/az.keyvault/import-azkeyvaultcertificate?view=azps-5.9.0
    Get-AzKeyVaultCertificate:  https://docs.microsoft.com/en-us/powershell/module/az.keyvault/get-azkeyvaultcertificate?view=azps-5.1.0
    Update-AzKeyVaultCertificate:    https://docs.microsoft.com/en-us/powershell/module/az.keyvault/update-azkeyvaultcertificate?view=azps-5.1.0
    Remove-AzKeyVaultCertificate:    https://docs.microsoft.com/en-us/powershell/module/az.keyvault/remove-azkeyvaultcertificate?view=azps-5.1.0
    Get-AzKeyVault:             https://docs.microsoft.com/en-us/powershell/module/az.keyvault/get-azkeyvault?view=azps-5.1.0
    Get-AzKeyVaultSecret:       https://docs.microsoft.com/en-us/powershell/module/az.keyvault/get-azkeyvaultsecret?view=azps-5.1.0
    Convert value to plain txt: https://docs.microsoft.com/en-us/azure/key-vault/secrets/quick-create-powershell    
} #>
<# Required Functions Links: {
    NewAzKVCertificate:         https://github.com/benjaminsmorgan/Azure-Powershell/tree/main/Storage/KeyVault/Certificates/NewAzKVCertificate.ps1        
    NewAzKVCertificatePolicy:   https://github.com/benjaminsmorgan/Azure-Powershell/tree/main/Storage/KeyVault/Certificates/NewAzKVCertificatePolicy.ps1
    ImportAzKVCertificate:      https://github.com/benjaminsmorgan/Azure-Powershell/tree/main/Storage/KeyVault/Certificates/ImportAzKVCertificate.ps1      
    ListAzKVCertificate:        https://github.com/benjaminsmorgan/Azure-Powershell/tree/main/Storage/KeyVault/Certificates/ListAzKVCertificate.ps1        
    UpdateAzKVCertificate:      https://github.com/benjaminsmorgan/Azure-Powershell/tree/main/Storage/KeyVault/Certificates/UpdateAzKVCertificate.ps1      
    GetAzKVCertificate:         https://github.com/benjaminsmorgan/Azure-Powershell/tree/main/Storage/KeyVault/Certificates/GetAzKVCertificate.ps1         
    DownloadAzKVCertificate:    https://github.com/benjaminsmorgan/Azure-Powershell/tree/main/Storage/KeyVault/Certificates/DownloadAzKVCertificate.ps1    
    RemoveAzKVCertificate:      https://github.com/benjaminsmorgan/Azure-Powershell/tree/main/Storage/KeyVault/Certificates/RemoveAzKVCertificate.ps1      
    GetAzKeyVault:              https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Storage/KeyVault/GetAzKeyVault.ps1
    GetAzKeyVaultSecretValue:   https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Storage/KeyVault/Secrets/GetAzKeyVaultSecretValue.ps1
} #>
<# Functions Description: {
    ManageAzKVCertificate:      Management function for key vault certs
    NewAzKVCertificate:         Creates a new key vault certificate
    NewAzKVCertificatePolicy:   Creates a new key vault certificate policy
    ImportAzKVCertificate:      Imports a key vault certificate
    ListAzKVCertificate:        Lists all key vault certificates
    UpdateAzKVCertificate:      Updates key vault certificate
    GetAzKVCertificate:         Gets a key vault certificate object
    DownloadAzKVCertificate:    Downloads a key vault certificate
    RemoveAzKVCertificate:      Removes key vault certificate
    GetAzKeyVault:              Gets key vault object
    GetAzKeyVaultSecretValue:   Gets key vault secret value
    GetAzKeyVault:              Gets key vault object      
} #>
<# Variables: {
    :ManageAzureKeyVaultCert    Outer loop for managing function
    $OpSelect:                  Operator input to select function
    NewAzKVCertificate{}        Creates $KeyVaultCertObject
        GetAzKeyVault{}             Gets $KeyVaultObject
        NewAzKVCertificatePolicy{}  Gets $Policy
    ImportAzKVCertificate{}     Imports $KeyVaultCertObject
        GetAzKeyVault{}             Gets $KeyVaultObject
        GetAzKeyVaultSecretValue{}  Gets $KVSV
    UpdateAzKVCertificate{}     Gets $null
        GetAzKVCertificate{}        Gets $KeyVaultCertObject
            GetAzKeyVault{}             Gets $KeyVaultObject
    DownloadAzKVCertificate{}   Gets $null
        GetAzKVCertificate{}        Gets KeyVaultCertObject
            GetAzKeyVault{}             Gets $KeyVaultObject
        GetAzKeyVaultSecretValue{}  Gets $KVSV
            GetAzKeyVault{}             Gets $KeyVaultObject
    RemoveAzKVCertificate{}     Gets $null
        GetAzKVCertificate{}        Gets $KeyVaultCertObject
            GetAzKeyVault{}             Gets $KeyVaultObject  
} #>
<# Process Flow {
    Function
        Call ManageAzKVCertificate > Get $null
            Call NewAzKVCertificate > Get $null
                Call GetAzKeyVault > Get $KeyVaultObject
                End GetAzKeyVault
                    Return NewAzKVCertificate > Send $KeyVaultObject 
                Call  NewAzKVCertificatePolicy > Get $Policy
                End NewAzKVCertificatePolicy
                    Return NewAzKVCertificate > Send $Policy
            End NewAzKVCertificate
                Return ManageAzKVCertificate > Send $null
            Call ImportAzKVCertificate > Get $null
                Call GetAzKeyVault > Get $KeyVaultObject
                End GetAzKeyVault
                    Return ImportAzKVCertificate > Send $KeyVaultObject 
                Call GetAzKeyVaultSecretValue > Get $KVSV
                    Call GetAzKeyVault > Get $KeyVaultObject
                    End GetAzKeyVault
                        Return GetAzKeyVaultSecretValue > Send $KeyVaultObject
                End GetAzKeyVaultSecretValue
                    Return ImportAzKVCertificate > Send $KVSV
            End ImportAzKVCertificate
                Return ManageAzKVCertificate > Send $null
            Call NewAzKVCertificate > Get $null
            End NewAzKVCertificate
                Return ManageAzKVCertificate > Send $null
            Call UpdateAzKVCertificate > Get $null
                Call GetAzKVCertificate > Get $KeyVaultCertObject
                    Call GetAzKeyVault > Get $KeyVaultObject
                    End GetAzKeyVault
                        Return GetAzKVCertificate > Send $KeyVaultObject
                End GetAzKVCertificate
                    Return UpdateAzKVCertificate > Send $KeyVaultCertObject, $KeyVaultObject  
            End UpdateAzKVCertificate
                Return ManageAzKVCertificate > Send $null
            Call DownloadAzKVCertificate > Get $null
                GetAzKVCertificate > Get KeyVaultCertObject
                    Call GetAzKeyVault > Get $KeyVaultObject
                    End GetAzKeyVault
                        Return GetAzKVCertificate > Send $KeyVaultObject 
                End GetAzKVCertificate
                    Return DownloadAzKVCertificate > Send KeyVaultCertObject
                Call GetAzKeyVaultSecretValue > Get $KVSV
                    Call GetAzKeyVault > Get $KeyVaultObject
                    End GetAzKeyVault
                        Return GetAzKeyVaultSecretValue > Send $KeyVaultObject
                End GetAzKeyVaultSecretValue
                    Return DownloadAzKVCertificate > Send $KVSV
            End DownloadAzKVCertificate
                Return ManageAzKVCertificate > Send $null
            Call RemoveAzKVCertificate > Get $null
                Call GetAzKVCertificate > Get $KeyVaultCertObject
                    Call GetAzKeyVault > Get $KeyVaultObject
                    End GetAzKeyVault
                        Return GetAzKVCertificate > Send $KeyVaultObject
                End GetAzKVCertificate
                    Return RemoveAzKVCertificate > Send $KeyVaultCertObject, $KeyVaultObject  
            End RemoveAzKVCertificate
                Return ManageAzKVCertificate > Send $null
        End ManageAzKVCertificate
            Return Function > Send $null
}#>
function ManageAzKVCertificate {                                                            # Function for managing key vault certs
    Begin {                                                                                 # Begin function
        :ManageAzureKeyVaultCert while ($true) {                                            # Outer loop for managing function
            Write-Host '[0] Exit'                                                           # Write message to screen
            Write-Host '[1] New Key Vault Cert'                                             # Write message to screen
            Write-Host '[2] Import Key Vault Cert'                                          # Write message to screen
            Write-Host '[3] List All Key Vaults Certs'                                      # Write message to screen
            Write-Host '[4] Download Key Vault Cert'                                        # Write message to screen
            Write-Host '[5] Update Key Vault Cert'                                          # Write message to screen
            Write-Host '[6] Remove Key Vault Cert'                                          # Write message to screen
            $OpSelect = Read-Host 'Option [#]'                                              # Operator input for selecting the management function
            Clear-Host                                                                      # Clears screen
            if ($OpSelect -eq '0') {                                                        # If $OpSelect equals '0'
                Break ManageAzureKeyVaultCert                                               # Breaks :ManageAzureKeyVaultCert
            }                                                                               # End if ($OpSelect -eq '0')
            elseif ($OpSelect -eq '1') {                                                    # Else if $OpSelect equals '1'            
                Write-Host 'New Key Vault Cert'                                             # Write message to screen
                NewAzKVCertificate                                                          # Calls function
            }                                                                               # End elseif ($OpSelect -eq '1')
            elseif ($OpSelect -eq '2') {                                                    # Else if $OpSelect equals '2'            
                Write-Host 'Import Key Vault Cert'                                          # Write message to screen
                ImportAzKVCertificate                                                       # Calls function
            }                                                                               # End elseif ($OpSelect -eq '2')
            elseif ($OpSelect -eq '3') {                                                    # Else if $OpSelect equals '3'            
                Write-Host 'List All Key Vaults Certs'                                      # Write message to screen
                ListAzKVCertificate                                                         # Calls function
            }                                                                               # End elseif ($OpSelect -eq '3')
            elseif ($OpSelect -eq '4') {                                                    # Else if $OpSelect equals '4'            
                Write-Host 'Download Key Vault Cert'                                        # Write message to screen
                DownloadAzKVCertificate                                                     # Calls function
            }                                                                               # End elseif ($OpSelect -eq '4')
            elseif ($OpSelect -eq '5') {                                                    # Else if $OpSelect equals '5'            
                Write-Host 'Update Key Vault Cert'                                          # Write message to screen
                UpdateAzKVCertificate                                                       # Calls function
            }                                                                               # End elseif ($OpSelect -eq '5')
            elseif ($OpSelect -eq '6') {                                                    # Else if $OpSelect equals '6'            
                Write-Host 'Remove Key Vault Cert'                                          # Write message to screen
                RemoveAzKVCertificate                                                       # Calls function
            }                                                                               # End elseif ($OpSelect -eq '6')
            else {                                                                          # All other inputs for $OpSelect
                Write-Host 'That was not a valid input'                                     # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Clear-Host                                                                  # Clears screen
            }                                                                               # End else (if ($OpSelect -eq '0'))
        }                                                                                   # End :ManageAzureKeyVaultSecret while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End begin statemnt
}                                                                                           # End function ManageAzKeyVaultSecret
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
function NewAzKVCertificatePolicy {                                                         # Function to create a local certificate
    Begin {                                                                                 # Begin function
        if (!$CallingFunction) {                                                            # If $CallingFunction is $null
            $CallingFunction = 'NewAzKVCertificatePolicy'                                   # Creates $CallingFunction
        }                                                                                   # End if (!$CallingFunction)
        :NewAzureKVCertPolicy while ($true) {                                               # Outer loop for managing function
            :SetAzureKVCertIssuer while ($true) {                                           # Inner loop for setting the issuer name
                Write-Host 'Issuer name'                                                    # Write message to screen
                Write-Host '[0] Exit'                                                       # Write message to screen
                Write-Host '[1] Self'                                                       # Write message to screen
                Write-Host '[2] Custom issuer'                                              # Write message to screen
                $OpSelect = Read-Host 'Option [#]'                                          # Operator input for selecting the issuer name
                Clear-Host                                                                  # Clears screen
                if ($OpSelect -eq '0') {                                                    # If $OpSelect equals '0'
                    Break NewAzureKVCertPolicy                                              # Breaks :NewAzureKVCertPolicy
                }                                                                           # End if ($OpSelect -eq '0')
                elseif ($OpSelect -eq '1') {                                                # Else if $OpSelect equals '1'
                    $IssuerName = 'Self'                                                    # $IssuerName is equal to 'Self'
                    Break SetAzureKVCertIssuer                                              # Breaks :SetAzureKVCertIssuer
                }                                                                           # End elseif ($OpSelect -eq '1')
                elseif ($OpSelect -eq '2') {                                                # Else if $OpSelect equals '2'
                    Write-Host 'Enter the issuer name'                                      # Write message to screen
                    $IssuerName = Read-Host 'Name'                                          # Operator input for the issuer name
                    Write-Host 'Use'$IssuerName' as the issuer name'                        # Write message to screen
                    $OpConfirm = Read-Host '[Y] Yes [N] No [E] Exit'                        # Operator input for confriming the issuer name
                    Clear-Host                                                              # Clears screen
                    if ($OpConfirm -eq 'e') {                                               # If $OpConfirm equals 'e'
                        Break NewAzureKVCertPolicy                                          # Breaks :NewAzureKVCertPolicy
                    }                                                                       # End if ($OpConfirm -eq 'e')
                    elseif ($OpConfirm -eq 'y') {                                           # Else if $OpConfirm equals 'y'
                        Break SetAzureKVCertIssuer                                          # Breaks :SetAzureKVCertIssuer
                    }                                                                       # End elseif ($OpConfirm -eq 'y')
                    else {                                                                  # All other inputs for $OpConfirm
                    }                                                                       # End else (if ($OpConfirm -eq 'e'))
                }                                                                           # End elseif ($OpSelect -eq '2')
                else {                                                                      # All other options to for $OpSelect
                    Write-Host 'That was not a valid input'                                 # Write message to screen
                    Pause                                                                   # Pauses for operator input
                    Clear-Host                                                              # Clears screen
                }                                                                           # End else (if ($OpSelect -eq '0'))
            }                                                                               # End :SetAzureKVCertIssuer while ($true)
            :SetAzureKVCertType while ($true) {                                             # Inner loop for setting the cert type
                Write-Host 'Key Type'                                                       # Write message to screen
                Write-Host '[0] Exit'                                                       # Write message to screen
                Write-Host '[1] RSA'                                                        # Write message to screen
                Write-Host '[2] RSA-HSM'                                                    # Write message to screen
                Write-Host '[3] EC'                                                         # Write message to screen
                Write-Host '[4] EC-HSM'                                                     # Write message to screen
                $OpSelect = Read-Host 'Option [#]'                                          # Operator input for selecting the key type
                Clear-Host                                                                  # Clears screen
                if ($OpSelect -eq '0') {                                                    # If $OpSelect equals '0'
                    Break NewAzureKVCertPolicy                                              # Breaks :NewAzureKVCertPolicy
                }                                                                           # End if ($OpSelect -eq '0')
                elseif ($OpSelect -eq '1') {                                                # Else if $OpSelect equals '1'
                    $KeyType = 'RSA'                                                        # $KeyType is equal to 'RSA'
                    Break SetAzureKVCertType                                                # Breaks :SetAzureKVCertType
                }                                                                           # End elseif ($OpSelect -eq '1')
                elseif ($OpSelect -eq '2') {                                                # Else if $OpSelect equals '2'
                    $KeyType = 'RSA-HSM'                                                    # $KeyType is equal to 'RSA-HSM'
                    Break SetAzureKVCertType                                                # Breaks :SetAzureKVCertType
                }                                                                           # End elseif ($OpSelect -eq '2')
                elseif ($OpSelect -eq '3') {                                                # Else if $OpSelect equals '3'
                    $KeyType = 'EC'                                                         # $KeyType is equal to 'EC'
                    Break SetAzureKVCertType                                                # Breaks :SetAzureKVCertType
                }                                                                           # End elseif ($OpSelect -eq '3')
                elseif ($OpSelect -eq '4') {                                                # Else if $OpSelect equals '4'
                    $KeyType = 'EC-HSM'                                                     # $KeyType is equal to 'EC-HSM'
                    Break SetAzureKVCertType                                                # Breaks :SetAzureKVCertType
                }                                                                           # End elseif ($OpSelect -eq '4')
                else {                                                                      # All other options to for $OpSelect
                    Write-Host 'That was not a valid input'                                 # Write message to screen
                    Pause                                                                   # Pauses for operator input
                    Clear-Host                                                              # Clears screen
                }                                                                           # End else (if ($OpSelect -eq '0'))
            }                                                                               # End :SetAzureKVCertType while ($true)
            :SetAzureKVCertKeySize while ($true) {                                          # Inner loop for setting key size
                Write-Host 'Key Size'                                                       # Write message to screen
                Write-Host '[0] Exit'                                                       # Write message to screen
                Write-Host '[1] 4096'                                                       # Write message to screen
                Write-Host '[2] 3072'                                                       # Write message to screen
                Write-Host '[3] 2048'                                                       # Write message to screen
                Write-Host '[4] 521'                                                        # Write message to screen
                Write-Host '[5] 384'                                                        # Write message to screen
                Write-Host '[6] 256'                                                        # Write message to screen
                $OpSelect = Read-Host 'Option [#]'                                          # Operator input for selecting the key type
                Clear-Host                                                                  # Clears screen
                if ($OpSelect -eq '0') {                                                    # If $OpSelect equals '0'
                    Break NewAzureKVCertPolicy                                              # Breaks :NewAzureKVCertPolicy
                }                                                                           # End if ($OpSelect -eq '0')
                elseif ($OpSelect -eq '1') {                                                # If $OpSelct equals '1'
                    $KeySize = '4096'                                                       # Sets $KeySize
                    Break SetAzureKVCertKeySize                                             # Breaks :SetAzureKVCertKeySize
                }                                                                           # End elseif ($OpSelect -eq '1')
                elseif ($OpSelect -eq '2') {                                                # If $OpSelct equals '2'
                    $KeySize = '3072'                                                       # Sets $KeySize
                    Break SetAzureKVCertKeySize                                             # Breaks :SetAzureKVCertKeySize
                }                                                                           # End elseif ($OpSelect -eq '2')
                elseif ($OpSelect -eq '3') {                                                # If $OpSelct equals '3'
                    $KeySize = '2048'                                                       # Sets $KeySize
                    Break SetAzureKVCertKeySize                                             # Breaks :SetAzureKVCertKeySize
                }                                                                           # End elseif ($OpSelect -eq '3')
                elseif ($OpSelect -eq '4') {                                                # If $OpSelct equals '4'
                    $KeySize = '521'                                                        # Sets $KeySize
                    Break SetAzureKVCertKeySize                                             # Breaks :SetAzureKVCertKeySize
                }                                                                           # End elseif ($OpSelect -eq '4')
                elseif ($OpSelect -eq '5') {                                                # If $OpSelct equals '5'
                    $KeySize = '384'                                                        # Sets $KeySize
                    Break SetAzureKVCertKeySize                                             # Breaks :SetAzureKVCertKeySize
                }                                                                           # End elseif ($OpSelect -eq '5')
                elseif ($OpSelect -eq '6') {                                                # If $OpSelct equals '6'
                    $KeySize = '256'                                                        # Sets $KeySize
                    Break SetAzureKVCertKeySize                                             # Breaks :SetAzureKVCertKeySize
                }                                                                           # End elseif ($OpSelect -eq '6')
                else {                                                                      # All other options to for $OpSelect
                    Write-Host 'That was not a valid input'                                 # Write message to screen
                    Pause                                                                   # Pauses for operator input
                    Clear-Host                                                              # Clears screen
                }                                                                           # End else (if ($OpSelect -eq '0'))
            }                                                                               # End :SetAzureKVCertKeySize while ($true)
            :SetAzureKVCertKeyUse while ($true) {                                           # Inner loop for setting key use
                Write-Host 'Key Usage'                                                      # Write message to screen
                Write-Host '[0] Exit'                                                       # Write message to screen
                Write-Host '[1] None'                                                       # Write message to screen
                Write-Host '[2] EncipherOnly'                                               # Write message to screen
                Write-Host '[3] CrlSign'                                                    # Write message to screen
                Write-Host '[4] KeyCertSign'                                                # Write message to screen
                Write-Host '[5] KeyAgreement'                                               # Write message to screen
                Write-Host '[6] DataEncipherment'                                           # Write message to screen
                Write-Host '[7] KeyEncipherment'                                            # Write message to screen
                Write-Host '[8] NonRepudiation'                                             # Write message to screen
                Write-Host '[9] DigitalSignature'                                           # Write message to screen
                Write-Host '[A] DecipherOnly'                                               # Write message to screen
                $OpSelect = Read-Host 'Option [#]'                                          # Operator input for selecting the key type
                $KeyUsage = $null                                                           # Clears $KeyUsage
                Clear-Host                                                                  # Clears screen
                if ($OpSelect -eq '0') {                                                    # If $OpSelect equals '0'
                    Break NewAzureKVCertPolicy                                              # Breaks :NewAzureKVCertPolicy
                }                                                                           # End if ($OpSelect -eq '0')
                if ($OpSelect -eq '1') {                                                    # If $OpSelct equals '1'
                    $KeyUsage = 'None'                                                      # Sets $KeyUsage
                    Break SetAzureKVCertKeyUse                                              # Breaks :SetAzureKVCertKeyUse
                }                                                                           # End if ($OpSelect -eq '1')
                if ($OpSelect -like '*2*') {                                                # If $OpSelct equals '2'
                    $KeyUsage = $KeyUsage +',EncipherOnly'                                  # Sets $KeyUsage
                }                                                                           # End if ($OpSelect -like  '*2*'
                if ($OpSelect -like '*3*') {                                                # If $OpSelct equals '3'
                    $KeyUsage = $KeyUsage+',CRLSign'                                        # Sets $KeyUsage
                }                                                                           # End if ($OpSelect -like  '*3*')
                if ($OpSelect -like '*4*') {                                                # If $OpSelct equals '4'
                    $KeyUsage = $KeyUsage+',KeyCertSign'                                    # Sets $KeyUsage
                }                                                                           # End if ($OpSelect -like  '*4*')
                if ($OpSelect -like '*5*') {                                                # If $OpSelct equals '5'
                    $KeyUsage = $KeyUsage+',KeyAgreement'                                   # Sets $KeyUsage
                }                                                                           # End if ($OpSelect -like  '*5*')
                if ($OpSelect -like '*6*') {                                                # If $OpSelct equals '6'
                    $KeyUsage = $KeyUsage+',DataEncipherment'                               # Sets $KeyUsage
                }                                                                           # End if ($OpSelect -like  '*6*')
                if ($OpSelect -like '*7*') {                                                # If $OpSelct equals '7'
                    $KeyUsage = $KeyUsage+',KeyEncipherment'                                # Sets $KeyUsage
                }                                                                           # End if ($OpSelect -like  '*7*')
                if ($OpSelect -like '*8*') {                                                # If $OpSelct equals '8'
                    $KeyUsage = $KeyUsage+',NonRepudiation'                                 # Sets $KeyUsage
                }                                                                           # End if ($OpSelect -like  '*8*')
                if ($OpSelect -like '*9*') {                                                # If $OpSelct equals '9'
                    $KeyUsage = $KeyUsage+',DigitalSignature'                               # Sets $KeyUsage
                }                                                                           # End if ($OpSelect -like  '*9*')
                if ($OpSelect -eq 'A') {                                                    # If $OpSelct equals 'A'
                    $KeyUsage = 'DecipherOnly'                                              # Sets $KeyUsage
                    Break SetAzureKVCertKeyUse                                              # Breaks :SetAzureKVCertKeyUse
                }                                                                           # End if ($OpSelect -eq 'A')
                if (!$KeyUsage) {                                                           # If $KeyUsage is $null
                    Write-Host 'That was not a valid input'                                 # Write message to screen
                }                                                                           # End if (!$KeyUsage)
                else {                                                                      # If $KeyUsage has a value
                    $KeyUsage = $KeyUsage.Substring(1)                                      # Removes first ',' from $KeyUsage
                    Write-Host 'Current key use options:'$KeyUsage                          # Write message to screen
                    Write-Host 'Is this list correct'                                       # Write message to screen
                    $OpConfirm = Read-Host '[Y] Yes [N] No [E] Exit'                        # Operator confirmation of $KeyUsage
                    Clear-Host                                                              # Clears screen
                    if ($OpConfirm -eq 'e') {                                               # If $OpConfirm equals '0'
                        Break NewAzureKVCertPolicy                                          # Breaks :NewAzureKVCertPolicy
                    }                                                                       # End if ($OpConfirm -eq 'e')
                    elseif ($OpConfirm -eq 'y') {                                           # Else if $OpConfirm equals 'y'
                        Break SetAzureKVCertKeyUse                                          # Breaks :SetAzureKVCertKeyUse
                    }                                                                       # End elseif ($OpConfirm -eq 'y')
                }                                                                           # End else (if (!$KeyUsage))
            }                                                                               # End :SetAzureKVCertKeyUse while ($true)
            :SetAzureKVSContentType while ($true) {                                         # Inner loop for setting the secret content type
                Write-Host 'Secret Content Type'                                            # Write message to screen
                Write-Host '[0] Exit'                                                       # Write message to screen
                Write-Host '[1] x-pkcs12'                                                   # Write message to screen
                Write-Host '[2] x-pem-file'                                                 # Write message to screen
                $OpSelect = Read-Host 'Option [#]'                                          # Operator input for selecting the secret content type
                Clear-Host                                                                  # Clears screen
                if ($OpSelect -eq '0') {                                                    # If $OpSelect equals '0'
                    Break NewAzureKVCertPolicy                                              # Breaks :NewAzureKVCertPolicy
                }                                                                           # End if ($OpSelect -eq '0')
                elseif ($OpSelect -eq '1') {                                                # Else if $OpSelect equals '1'
                    $SecretContentType = 'application/x-pkcs12'                             # $SecretContentType is equal to 'application/x-pkcs12'
                    Break SetAzureKVSContentType                                            # Breaks :SetAzureKVSContentType
                }                                                                           # End elseif ($OpSelect -eq '1')
                elseif ($OpSelect -eq '1') {                                                # Else if $OpSelect equals '2'
                    $SecretContentType = 'application/x-pem-file'                           # $SecretContentType is equal to 'application/x-pem-file'
                    Break SetAzureKVSContentType                                            # Breaks :SetAzureKVSContentType
                }                                                                           # End elseif ($OpSelect -eq '2')
                else {                                                                      # All other options to for $OpSelect
                    Write-Host 'That was not a valid input'                                 # Write message to screen
                }                                                                           # End else (if ($OpSelect -eq '0'))
            }                                                                               # End :SetAzureKVSContentType while ($true)
            :SetAzureKVSubjectName while ($true) {                                          # Inner loop for setting the subject name
                Write-Host 'Enter the Subject name'                                         # Write message to screen
                $SubjectName = Read-Host 'Name'                                             # Operator input for the subjectname
                if ($SubjectName -notlike 'CN=*' -or $SubjectName -notlike 'O=*' ) {        # If $SubjectName does not start with 'CN=' or 'O='
                    :SetAzureKVSNType while ($true) {                                       # Inner loop for setting the subject name type
                        Write-Host '[0] Exit'                                               # Write message to screen
                        Write-Host '[1] Canonical Name'                                     # Write message to screen
                        Write-Host '[2] Organization Name'                                  # Write message to screen
                        $OpSelect = Read-Host 'Option [#]'                                  # Operator input for the subject name type
                        if ($OpSelect -eq '0') {                                            # If $OpSelect equals '0'
                            Break NewAzureKVCertPolicy                                      # Breaks :NewAzureKVCertPolicy
                        }                                                                   # End if ($OpSelect -eq '0')
                        elseif ($OpSelect -eq '1') {                                        # If $OpSelect equals '1'
                            if ($SubjectName -like '*.com' -or '*.org' -or '*.edu') {       # If $SubjectName ends with .com, .org, .edu
                            }                                                               # End if ($SubjectName -like '*.com' -or '*.org' -or '*.edu')
                            elseif ($SubjectName -like '*.gov' -or '*.mil') {               # If $SubjectName ends with .gov .mil
                            }                                                               # End elseif ($SubjectName -like '*.gov' -or '*.mil')
                            elseif ($SubjectName -like '*.*' -or '*,*') {                   # If $SubjectName has a '.' or ','
                                $SubjectName = '"'+$SubjectName+'"'                         # Adds quotes around $SubjectName
                            }                                                               # End if ($SubjectName -like '*.*' -or '*,*')    
                            $SubjectName = 'CN='+$SubjectName                               # Adds 'CN=' to the start of $Subjectname
                            Break SetAzureKVSNType                                          # Breaks :SetAzureKVSNType
                        }                                                                   # elseif ($OpSelect -eq '1')
                        elseif ($OpSelect -eq '2') {                                        # If $OpSelect equals '2'
                            if ($SubjectName -like '*.*' -or '*,*') {                       # If $SubjectName has a '.' or ','
                                $SubjectName = '"'+$SubjectName+'"'                         # Adds quotes around $SubjectName
                            }                                                               # End if ($SubjectName -like '*.*' -or '*,*')
                            $SubjectName = 'O='+$SubjectName                                # Adds 'O=' to the start of $Subjectname
                            Break SetAzureKVSNType                                          # Breaks :SetAzureKVSNType
                        }                                                                   # End elseif ($OpSelect -eq '2')
                        else {                                                              # All other inputs for $OpSelect
                            Write-Host 'That was not a valid option'                        # Write message to screen
                        }                                                                   # End else (if ($OpSelect -eq '0'))      
                    }                                                                       # End :SetAzureKVSNType while ($true)          
                }                                                                           # End if ($SubjectName -notlike 'CN=*')
                Write-Host 'Use'$SubjectName' as the subject name'                          # Write message to screen                                            
                $OpConfirm = Read-Host '[Y] Yes [N] No [E] Exit'                            # Operator confirmation of the subject name
                if ($OpConfirm -eq 'e') {                                                   # If $OpConfirm equals 'e'
                    Break NewAzureKVCertPolicy                                              # Breaks :NewAzureKVCertPolicy
                }                                                                           # End if ($OpConfirm -eq 'e')
                elseif ($OpConfirm -eq 'y') {                                               # Else if $OpConfirm equals 'y'
                    Clear-Host                                                              # Clears screen
                    Break SetAzureKVSubjectName                                             # Breaks :SetAzureKVSubjectName
                }                                                                           # End elseif ($OpConfirm -eq 'y')
                else {                                                                      # All other inputs for $OpConfirm
                    Clear-Host                                                              # Clears screen
                }                                                                           # End else (if ($OpConfirm -eq 'e'))
            }                                                                               # End :SetAzureKVSubjectName while ($true)
            Try {                                                                           # Try the following
                $Policy = New-AzKeyVaultCertificatePolicy -IssuerName $IssuerName -KeyType `
                    $KeyType -KeySize $KeySize -SecretContentType $SecretContentType `
                    -SubjectName $SubjectName -ValidityInMonths 6 -ReuseKeyOnRenewal    
                    -ErrorAction 'Stop'                                                     # Creates the cert policy
            }                                                                               # End try
            catch {                                                                         # If try fails
                Write-Host 'An error has occured'                                           # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break NewAzureKVCertPolicy                                                  # Breaks :NewAzureKVCertPolicy
            }                                                                               # End Catch
            Return $Policy                                                                  # Returns to calling function with $var
        }                                                                                   # End :NewAzureKVCertPolicy while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function NewAzKVCertificatePolicy
function ImportAzKVCertificate {                                                            # Function to import an existing certificate
    Begin {                                                                                 # Begin function
        if (!$CallingFunction) {                                                            # If $CallingFunction does not have a value
            $CallingFunction = 'ImportAzKVCertificate'                                      # Creates $CallingFunction 
        }                                                                                   # End if (!$CallingFunction)
        :AddAzureKVCert while ($true) {                                                     # Outer loop for managing function
            $KeyVaultObject = GetAzKeyVault ($CallingFunction)                              # Calls function and assigns output to $var
            if (!$KeyVaultObject) {                                                         # If $KeyVaultObject does not have a value
                Break AddAzureKVCert                                                        # Breaks :AddAzureKVCert
            }                                                                               # End if (!$KeyVaultObject)
            :GetLocalfilepath while ($true) {                                               # Inner loop for locating the cert to import
                Write-Host 'Enter the full file path, name, and extenstion'                 # Write message to screen
                Write-Host 'Example c:\users\admin\downloads\cert.pfx'                      # Write message to screen
                Write-Host '"Exit" to leave this function'                                  # Write message to screen
                $LocalFilePath = Read-Host 'Path'                                           # Operator input for the local file path
                Clear-Host                                                                  # Clears screen
                if ($LocalFilePath -eq 'exit') {                                            # If $LocalFilePath equals 'exit'
                    Break AddAzureKVCert                                                    # Breaks :AddAzureKVCert
                }                                                                           # End if ($LocalFilePath -eq 'exit')
                if (Test-Path -Path $LocalFilePath) {                                       # If $LocalFilePath is valid
                    Write-Host 'Import the following:'$LocalFilePath                        # Write message to screen
                    $OpConfirm = Read-Host '[Y] Yes [N] No'                                 # Operator confirmation of the file
                    Clear-Host                                                              # Clears screen
                    if ($OpConfirm -eq 'y') {                                               # If $OpConfirm equals 'y'
                        Break GetLocalfilepath                                              # Breaks :GetLocalfilepath
                    }                                                                       # End if ($OpConfirm -eq 'y')
                }                                                                           # End if (Test-Path -Path $LocalFilePath)
                else {                                                                      # If $LocalFilePath is not valid
                    Write-Host 'Unable to locate file'                                      # Write message to screen
                    Write-Host 'Please re-enter the path'                                   # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Clear-Host                                                              # Clears screen
                }                                                                           # End if (Test-Path -Path $LocalFilePath)
            }                                                                               # End :GetLocalfilepath while ($true)
            :GetLocalFilePassword while ($true) {                                           # Inner loop for getting the cert password
                Write-Host 'Certificate password'                                           # Write message to screen
                Write-Host '[0] Exit'                                                       # Write message to screen
                Write-Host '[1] Manually enter password'                                    # Write message to screen
                Write-Host '[2] Get key vault secret'                                       # Write message to screen
                Write-Host '[3] No password'                                                # Write message to screen
                $OpSelect = Read-Host 'Option [#]'                                          # Operator selection to provide password
                Clear-Host                                                                  # Clears screen
                if ($OpSelect -eq '0') {                                                    # If $OpSelect equals '0'
                    Break AddAzureKVCert                                                    # Breaks :AddAzureKVCert
                }                                                                           # End if ($OpSelect -eq '0')
                elseif ($OpSelect -eq '1') {                                                # If $OpSelect equals '1'
                    Write-Host 'Please enter the password for the certificate'              # Write message to screen
                    Write-Host '"Exit" to leave this function'                              # Write message to screen
                    $LocalFilePassword = Read-Host 'Password'                               # Operator input for the cert password
                    Clear-Host                                                              # Clears screen
                    Write-Host 'Confirm the password for the certificate'                   # Write message to screen
                    $LocalFilePassword2 = Read-Host 'Password'                              # Operator input for the cert password
                    Clear-Host                                                              # Clears screen
                    if ($LocalFilePassword -eq $LocalFilePassword2) {                       # If $LocalFilePassword equals $LocalFilePassword2
                        $Password = ConvertTo-SecureString -String $LocalFilePassword `
                            -AsPlainText -Force                                             # Converts $LocalFilePassword to secure string $Password
                        Break GetLocalFilePassword                                          # Breaks :GetLocalFilePassword
                    }                                                                       # End if ($LocalFilePassword -eq $LocalFilePassword2)
                }                                                                           # End elseif ($OpSelect -eq '1')
                elseif ($OpSelect -eq '2') {                                                # Else if $OpSelect equals '2'
                    $KVSV = GetAzKeyVaultSecretValue ($CallingFunction)                     # Calls function and assigns output to $var
                    if (!$KVSV) {                                                           # If $KVSV does not have a value
                        Break AddAzureKVCert                                                # Breaks :AddAzureKVCert
                    }                                                                       # End if (!$KVSV)
                    else {                                                                  # If $KVSV has a value
                        $Password = ConvertTo-SecureString -String $KVSV `
                            -AsPlainText -Force                                             # Converts $KVSV to secure string $Password
                        Break GetLocalFilePassword                                          # Breaks :GetLocalFilePassword
                    }                                                                       # End else (if (!$KVSV))
                }                                                                           # End elseif ($OpSelect -eq '2')
                elseif ($OpSelect -eq '3') {                                                # Else if $OpSelect equals '3'
                    $Password = $null                                                       # Clears $Password
                    Break GetLocalFilePassword                                              # Breaks :GetLocalFilePassword
                }                                                                           # End elseif ($OpSelect -eq '3')
                else {                                                                      # All other inputs for $OpSelect
                    Write-Host 'That was not a valid option'                                # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Clear-Host                                                              # Clears screen   
                }                                                                           # End else (if ($OpSelect -eq '0'))
            }                                                                               # End :GetLocalFilePassword while ($true)   
            :SetAzureKVCertName while ($true) {                                             # Inner loop for setting the cert name
                Write-Host 'Enter the name of the certificate'                              # Write message to screen
                $CertName = Read-Host 'Name'                                                # Operator input of the cert name
                Clear-Host                                                                  # Clears screen
                Write-Host 'Use:'$CertName'as the certificate name?'                        # Write message to screen
                $OpConfirm = Read-Host '[Y] Yes [N] No [E] Exit'                            # Operator confirmation of the cert name
                if ($OpConfirm -eq 'e') {                                                   # If $OpSelect equals 'e'
                    Break AddAzureKVCert                                                    # Breaks :NewAzureKVCert
                }                                                                           # End if ($OpConfirm -eq 'e')
                elseif ($OpConfirm -eq 'y') {                                               # Else if $OpSelect equals 'y'
                    Break SetAzureKVCertName                                                # Breaks :SetAzureKVCertName
                }                                                                           # End elseif ($OpConfirm -eq 'y') 
                else {                                                                      # All other inputs for $OpSelect
                    Clear-Host                                                              # Clears screen
                }                                                                           # End else (if ($OpConfirm -eq 'e'))
            }                                                                               # End :SetAzureKVCertName while ($true)
            if ($Password) {                                                                # If $Password has a value
                Try {                                                                       # Try the following
                    Import-AzKeyVaultCertificate -VaultName $KeyVaultObject.VaultName `
                        -Name $CertName -FilePath $LocalFilePath -Password $Password 
                        -ErrorAction 'Stop'                                                 # Imports the certificate
                }                                                                           # End try
                Catch {                                                                     # If try fails
                    Write-Host 'An error has occured'                                       # Write message to screen
                    Write-Host 'The certicate was not imported'                             # Write message to screen
                    Write-Host 'There maybe an issue with the certificate'                  # Write message to screen
                    Write-Host 'The password provided may not be valid'                     # Write message to screen
                    Write-Host 'You may not have the permissions to do this'                # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Break AddAzureKVCert                                                    # Breaks :AddAzureKVCert 
                }                                                                           # End catch
            }                                                                               # End if ($Password)
            else {                                                                          # If $Password does not have a value
                Try {
                    Import-AzKeyVaultCertificate -VaultName $KeyVaultObject.VaultName `
                        -Name $CertName -FilePath $LocalFilePath -ErrorAction 'Stop'        # Imports the certificate
                }                                                                           # End try
                Catch {                                                                     # If try fails
                    Write-Host 'An error has occured'                                       # Write message to screen
                    Write-Host 'The certicate was not imported'                             # Write message to screen
                    Write-Host 'There maybe an issue with the certificate'                  # Write message to screen
                    Write-Host 'You may not have the permissions to do this'                # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Break AddAzureKVCert                                                    # Breaks :AddAzureKVCert 
                }                                                                           # End catch    
            }                                                                               # End else (if ($Password))
            Write-Host 'The certificate has been imported successfully'                     # Write message to screen
            Pause                                                                           # Pauses all actions for operator input
            Break AddAzureKVCert                                                            # Breaks :AddAzureKVCert                                    
        }                                                                                   # End :AddAzureKVCert while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function ImportAzKVCertificate
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
function GetAzKVCertificate {                                                               # Function to get a key vault certificate
    Begin {                                                                                 # Begin function
        if (!$CallingFunction) {                                                            # If $CallingFunction is $null
            $CallingFunction = 'GetAzKVCertificate'                                         # Creates $CallingFunction
        }                                                                                   # End if (!$CallingFunction)
        :GetAzureKVCertificate while ($true) {                                              # Outer loop for managing function
            $KeyVaultObject = GetAzKeyVault ($CallingFunction)                              # Calls function and assigns output to $var
            if (!$KeyVaultObject) {                                                         # If $KeyVaultObject is $null
                Break GetAzureKVCertificate                                                 # Breaks :GetAzureKVCertificate
            }                                                                               # End if (!$KeyVaultObject)
            $ObjectList = Get-AzKeyVaultCertificate -VaultName $KeyVaultObject.VaultName    # Gets a list of all certs in $KeyVaultObject
            if (!$ObjectList) {                                                             # If $ObjectList is $null
                Write-Host 'No certificates in:'$KeyVaultObject.VaultName                   # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break GetAzureKVCertificate                                                 # Breaks :GetAzureKVCertificate
            }                                                                               # End if (!$ObjectList)    
            $ObjectNumber = 1                                                               # Creates $ObjectNumber
            [System.Collections.ArrayList]$ObjectArray =@()                                 # Creates $ObjectArray
            foreach ($_ in $ObjectList) {                                                   # For each item in $ObjectList
                $ObjectInput = [PSCustomObject]@{'Number'=$ObjectNumber;'Name'=$_.Name; `
                    'ID'=$_.ID;'EN'=$_.Enabled;'CR'=$_.Created;'UP'=$_.Updated;`
                    'NB'=$_.NotBefore;'EX'=$_.Expires;'VER'=$_.Version}                     # Creates $ObjectInput
                $ObjectArray.Add($ObjectInput) | Out-Null                                   # Adds $ObjectInput to $ObjectArray
                $ObjectNumber = $ObjectNumber + 1                                           # Increases $ObjectNumber by 1
            }                                                                               # End foreach ($_ in $ObjectList)
            Write-Host '[0] Exit'                                                           # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            foreach ($_ in $ObjectArray) {                                                  # For each item in $ObjectArray
                $Number = $_.Number                                                         # Number is equal to current item .number
                if ($Number -le 9) {                                                        # If $Number is 9 or less
                    Write-Host "[$Number]         "$_.Name                                  # Write message to screen
                }                                                                           # End if ($Number -le 9)
                else {                                                                      # If $Number is more than 9
                    Write-Host "[$Number]        "$_.Name                                   # Write message to screen
                }                                                                           # End else (if ($Number -le 9))
                Write-Host 'ID:         ' $_.ID                                             # Write message to screen
                Write-Host 'Enabled:    ' $_.EN                                             # Write message to screen
                Write-Host 'Created:    ' $_.CR                                             # Write message to screen
                Write-Host 'Updated:    ' $_.UP                                             # Write message to screen
                Write-Host 'Not Before: ' $_.NB                                             # Write message to screen
                Write-Host 'Expires:    ' $_.EX                                             # Write message to screen
                if ($_.Ver) {                                                               # If current item .ver has a value
                    Write-Host 'Version:    ' $_.Ver                                        # Write message to screen
                }                                                                           # End if ($_.Ver)
                Write-Host ''                                                               # Write message to screen
            }                                                                               # End foreach ($_ in $ObjectArray)
            :SelectAzureKVCert while ($true) {                                              # Inner loop for selecting the certificate
                if ($CallingFunction -and $CallingFunction -ne 'GetAzKVCertificate') {      # If $CallingFunction has a value and is not 'GetAzKVCertificate'
                    Write-Host 'You are selecting the certificate for:'$CallingFunction     # Write message to screen
                }                                                                           # End if ($CallingFunction -and $CallingFunction -ne 'GetAzKVCertificate')
                $OpSelect = Read-Host 'Option [#]'                                          # Operator input to select the cert
                if ($OpSelect -eq '0') {                                                    # If $OpSelect equals '0'
                    Break GetAzureKVCertificate                                             # Breaks :GetAzureKVCertificate
                }                                                                           # End if ($OpSelect -eq '0')
                elseif ($OpSelect -in $ObjectArray.Number) {                                # Else if $OpSelect in $ObjectArray.Number
                    $OpSelect = $ObjectArray | Where-Object {$_.Number -eq $OpSelect}       # $OpSelect equals $ObjectArray where $OpSelect equals $ObjectArray.Number
                    $KeyVaultCertObject = Get-AzKeyVaultCertificate -VaultName `
                        $KeyVaultObject.VaultName -Name $OpSelect.name                      # Pulls the full key vault cert object
                    Clear-Host                                                              # Clears screen
                    Return $KeyVaultCertObject, $KeyVaultObject                             # Returns to calling function with $vars 
                }                                                                           # End elseif ($OpSelect -in $ObjectArray.Number)
                else {                                                                      # All other inputs for $OpSelect
                    Write-Host 'That was not a valid option'                                # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Write-Host ''                                                           # Write message to screen
                }                                                                           # End else (if ($OpSelect -eq '0'))
            }                                                                               # End :SelectAzureKVCert while ($true)
        }                                                                                   # End :GetAzureKVCertificate while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function GetAzKVCertificate
function UpdateAzKVCertificate {                                                            # Function to update a key vault certificate
    Begin {                                                                                 # Begin function
        $ErrorActionPreference='silentlyContinue'                                           # Disables errors
        $WarningPreference = 'silentlyContinue'                                             # Disables key vault warnings
        if (!$CallingFunction) {                                                            # If $CallingFunction does not have a value
            $CallingFunction = 'UpdateAzKVCertificate'                                      # Creates $CallingFunction
        }                                                                                   # End if (!$CallingFunction)
        :UpdateAzureKVCertificate while ($true) {                                           # Outer loop for managing function
            $KeyVaultCertObject, $KeyVaultObject = GetAzKVCertificate ($CallingFunction)    # Calls function and assigns output to $Var
            if (!$KeyVaultCertObject) {                                                     # If $KeyVaultCertObject is $null
                Break UpdateAzureKVCertificate                                              # Breaks :UpdateAzureKVCertificate
            }                                                                               # End if (!$KeyVaultCertObject)
            Write-Host 'Update options'                                                     # Write message to screen
            Write-Host '[0] Exit'                                                           # Write message to screen
            if ($KeyVaultCertObject.Enabled -eq $True) {                                    # If $KeyVaultCertObject.Enabled is $true
                Write-Host '[1] Disable certificate'                                        # Write message to screen
            }                                                                               # End if ($KeyVaultCertObject.Enabled -eq $True) 
            else {                                                                          # If $KeyVaultCertObject.Enabled is not $true
                Write-Host '[1] Enable certificate'                                         # Write message to screen
            }                                                                               # End else (if ($KeyVaultCertObject.Enabled -eq $True))
            Write-Host '[2] Replace tags'                                                   # Write message to screen
            Write-Host '[3] Remove tags'                                                    # Write message to screen
            $OpSelect = Read-Host 'Option [#]'                                              # Operator input for selecting update function
            Clear-Host                                                                      # Clears screen
            if ($OpSelect -eq '0') {                                                        # If $OpSelect equals '0'
                Break UpdateAzureKVCertificate                                              # Breaks :UpdateAzureKVCertificate
            }                                                                               # End if ($OpSelect -eq '0')
            elseif ($OPSelect -eq '1' -and $KeyVaultCertObject.Enabled -eq $true) {         # If $OpSelect equals '1' $KeyVaultCertObject.Enabled is $true
                Try {                                                                       # Try the following
                    Write-Host 'Disabling:'$KeyVaultCertObject.Name                         # Write message to screen
                    Update-AzKeyVaultCertificate -VaultName $KeyVaultObject.VaultName `
                        -Name $KeyVaultCertObject.Name -Enable $false -ErrorAction 'Stop'   # Disables to cert
                }                                                                           # End try
                Catch {                                                                     # If Try fails
                    Write-Host 'There was an error while disabling the certificate'         # Write message to screen
                    Write-Host 'You may not have the permissions to do this'                # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Break UpdateAzureKVCertificate                                          # Breaks :UpdateAzureKVCertificate
                }                                                                           # End catch
                Write-Host 'Certificate has been disabled'                                  # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break UpdateAzureKVCertificate                                              # Breaks :UpdateAzureKVCertificate
            }                                                                               # End elseif ($OPSelect -eq '1' -and $KeyVaultCertObject.Enabled -eq $true)
            elseif ($OPSelect -eq '1' -and $KeyVaultCertObject.Enabled -eq $false) {        # If $OpSelect equals '1' $KeyVaultCertObject.Enabled is $false
                Try {                                                                       # Try the following
                    Write-Host 'Enabling:'$KeyVaultCertObject.Name                          # Write message to screen
                    Update-AzKeyVaultCertificate -VaultName $KeyVaultObject.VaultName `
                        -Name $KeyVaultCertObject.Name -Enable $true -ErrorAction 'Stop'    # Enables to cert
                }                                                                           # End try
                Catch {                                                                     # If Try fails
                    Write-Host 'There was an error while enabling the certificate'          # Write message to screen
                    Write-Host 'You may not have the permissions to do this'                # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Break UpdateAzureKVCertificate                                          # Breaks :UpdateAzureKVCertificate
                }                                                                           # End catch
                Write-Host 'Certificate has been enabled'                                   # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break UpdateAzureKVCertificate                                              # Breaks :UpdateAzureKVCertificate
            }                                                                               # End elseif ($OPSelect -eq '1' -and $KeyVaultCertObject.Enabled -eq $false)
            elseif ($OpSelect -eq '2') {                                                    # Else if $OpSelect equals '2'
                [System.Collections.ArrayList]$ObjectArray =@()                             # Creates $ObjectArray
                $ObjectNumber = 1                                                           # Creates $ObjectNumber
                :AddAzureKVCertTags while ($true) {                                         # Inner loop for setting the tags
                    :SetAzureKVCertTag while ($true) {                                      # Inner loop for adding a tag
                        Write-Host 'Replacement tag:'$ObjectNumber                          # Write message to screen
                        $TagName = Read-Host 'Name'                                         # Operator input for tag name
                        $TagValue = Read-Host 'Value'                                       # Operator input for tag value
                        Write-Host 'Add tag:'$TagName ':'$TagValue                          # Write message to screen
                        $OpConfirm = Read-Host '[Y] Yes [N] No [E] Exit'                    # Operator confirmation of the tag pair
                        Clear-Host                                                          # Clears screen
                        if ($OpConfirm -eq 'e') {                                           # If $OpConfirm equals 'e'
                            Break UpdateAzureKVCertificate                                  # Breaks :UpdateAzureKVCertificate
                        }                                                                   # End if ($OpConfirm -eq 'e')
                        elseif ($OpConfirm -eq 'y') {                                       # Else if $OpConfirm equals 'y'
                            $ObjectItem = [PSCustomObject]@{'Name'=$TagName;`
                            'Value'=$TagValue}                                              # Adds $TagName and $TagValue to $ObjectItem
                            $ObjectArray.Add($ObjectItem) | Out-Null                        # Adds $Objectitem to $ObjectArray
                            $ObjectNumber = $ObjectNumber + 1                               # Increments $ObjectNumber up by 1
                            Break SetAzureKVCertTag                                         # Breaks :SetAzureKVCertTag
                        }                                                                   # End elseif ($OpConfirm -eq 'y')
                        else {                                                              # All other inputs for $OpConfirm
                            Break SetAzureKVCertTag                                         # Breaks :SetAzureKVCertTag
                        }                                                                   # End else (if ($OpConfirm -eq 'e'))
                    }                                                                       # End :SetAzureKVCertTag while ($true)
                    :ReviewAzureKVCertTags while ($true) {                                  # Inner loop for reviewing tags
                        Write-Host 'Current tags'                                           # Write message to screen
                        foreach ($_ in $ObjectArray) {                                      # For each item in $ObjectArray
                            Write-Host $_.Name ':'$_.Value                                  # Write message to screen
                        }                                                                   # End foreach ($_ in $ObjectArray)
                        Write-Host $ObjectArray
                        Write-Host ''                                                       # Write message to screen
                        Write-Host '[0] Exit'                                               # Write message to screen
                        Write-Host '[1] Add additional tag'                                 # Write message to screen
                        Write-Host '[2] Save current tags to certificate'                   # Write message to screen
                        $OpSelect = Read-Host 'Option [#]'                                  # Operator input for next action
                        Clear-Host                                                          # Clears screen
                        if ($OpSelect -eq '0') {                                            # If $OpSelect equals '0'
                            Break UpdateAzureKVCertificate                                  # Breaks :UpdateAzureKVCertificate
                        }                                                                   # End if ($OpSelect -eq '0')
                        elseif ($OpSelect -eq '1') {                                        # Else if $OpSelect equals '1'
                            Break ReviewAzureKVCertTags                                     # Breaks :ReviewAzureKVCertTags
                        }                                                                   # End elseif ($OpSelect -eq '1')
                        elseif ($OpSelect -eq '2') {                                        # Else if $OpSelect equals '2'
                            Break AddAzureKVCertTags                                        # Breaks :AddAzureKVCertTags
                        }                                                                   # End elseif ($OpSelect -eq '2')
                        
                        else {                                                              # All other inputs for $OpSelect
                            Write-Host 'That was not a valid option'                        # Write message to screen
                            Pause                                                           # Pauses all actions for operator input
                            Clear-Host                                                      # Clears screen
                        }                                                                   # End if ($OpSelect -eq '0')
                    }                                                                       # End :ReviewAzureKVCertTags while ($true)
                }                                                                           # End :AddAzureKVCertTags while ($true)
                $Tags = @{}                                                                 # Creates $Tags hash table
                foreach ($_ in $ObjectArray) {                                              # For each item in $ObjectArray
                    $Name = $_.name                                                         # Isolates current item .name
                    $Value = $_.Value                                                       # Isolates current item .value
                    $tags.add($Name,$Value)                                                 # Adds $Name and $value to $Tags
                }                                                                           # End foreach ($_ in $ObjectArray)
                Try {                                                                       # Try the following
                    Write-Host 'Adding tags to:'$KeyVaultCertObject.name                    # Write message to screen
                    Update-AzKeyVaultCertificate -VaultName $KeyVaultObject.VaultName `
                        -Name $KeyVaultCertObject.Name -Tag $Tags -PassThru `
                        -ErrorAction 'Stop'                                                 # Replaces the current tag list
                }                                                                           # End try
                Catch {                                                                     # If try fails
                    Write-Host 'An error occured while modifing the tags'                   # Write message to screen
                    Write-Host 'You may not have the permissions to do this'                # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Break UpdateAzureKVCertificate                                          # Breaks :UpdateAzureKVCertificate
                }                                                                           # End catch
                Write-Host 'Tags have been updated'                                         # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break UpdateAzureKVCertificate                                              # Breaks :UpdateAzureKVCertificate
            }                                                                               # End elseif ($OpSelect -eq '2')
            elseif ($OpSelect -eq '3') {                                                    # Else if $OpSelect equals '3'
                Write-Host 'Remove the following tags from:'$KeyVaultCertObject.name        # Write message to screen
                [System.Collections.ArrayList]$KeyArray =@()                                # Creates $KeyArray
                [System.Collections.ArrayList]$ValueArray =@()                              # Creates $ValueArray
                $ObjectNumber = 1                                                           # Creates $ObjectNumber
                $CurrentTags = $KeyVaultCertObject.Tags                                     # Isolates the tags
                $CurrentKeys = $CurrentTags.Keys                                            # Isolates the tag keys
                $CurrentValues = $CurrentTags.Values                                        # Isolates the tags values
                foreach ($_ in $CurrentKeys) {                                              # For each item in $CurrentKeys
                    $KeyAdd = [PSCustomObject]@{'Number'=$ObjectNumber;'Name'=$_}           # Creates $KeyAdd
                    $KeyArray.Add($KeyAdd) | Out-Null                                       # Adds $KeyAdd to $KeyArray
                    $ObjectNumber = $ObjectNumber + 1                                       # Increments $ObjectNumber up by 1
                }                                                                           # End foreach ($_ in $CurrentKeys)
                $ObjectNumber = 1                                                           # Resets $ObjectNumber to 1
                foreach ($_ in $CurrentValues) {                                            # For each item in $CurrentValues
                    $ValueAdd = [PSCustomObject]@{'Number'=$ObjectNumber;'Value'=$_}        # Creates $ValueAdd
                    $ValueArray.Add($ValueAdd) | Out-Null                                   # Adds $ValueAdd to $ValueArray
                    $ObjectNumber = $ObjectNumber + 1                                       # Increments $ObjectNumber up by 1     
                }                                                                           # End foreach ($_ in $CurrentValues)
                foreach ($_ in $KeyArray) {                                                 # For each item in $KeyArray
                    $Key = $_                                                               # Pulls current item into $Key
                    $Number = $Key.Number                                                   # Isolates $Key.Number
                    $Value = $ValueArray | Where-Object {$_.Number -eq $Number}             # Value is equal to $ValueArray where $ValueArray.Number equals $number
                    Write-Host $Key.Name':' $Value.Value                                    # Write message to screen
                }                                                                           # End foreach ($_ in $KeyArray)
                $OpConfirm = Read-Host '[Y] Yes [N] No'                                     # Operator confirmation to remove the tags
                Clear-Host                                                                  # Clears screen
                if ($OpConfirm -eq 'y') {                                                   # If $OpConfrim equals 'y'
                    $Tags = @{}                                                             # Creates $Tags hash table
                    Try {                                                                   # Try the following
                        Write-Host 'Removing tags from:'$KeyVaultCertObject.name            # Write message to screen
                        Update-AzKeyVaultCertificate -VaultName $KeyVaultObject.VaultName `
                            -Name $KeyVaultCertObject.Name -Tag $Tags -PassThru `
                            -ErrorAction 'Stop'                                             # Replaces the current tag list
                    }                                                                       # End try
                    Catch {                                                                 # If try fails
                        Write-Host 'An error occured while modifing the tags'               # Write message to screen
                        Write-Host 'You may not have the permissions to do this'            # Write message to screen
                        Pause                                                               # Pauses all actions for operator input
                        Break UpdateAzureKVCertificate                                      # Breaks :UpdateAzureKVCertificate
                    }                                                                       # End catch
                    Write-Host 'Tags have been removed'                                     # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Break UpdateAzureKVCertificate                                          # Breaks :UpdateAzureKVCertificate
                }                                                                           # End if ($OpConfirm -eq 'y')
                else {                                                                      # All other inputs for $OpConfirm
                    Break UpdateAzureKVCertificate                                          # Breaks :UpdateAzureKVCertificate
                }                                                                           # End else (if ($OpConfirm -eq 'y'))
            }                                                                               # End elseif ($OpSelect -eq '3')
        }                                                                                   # End :UpdateAzureKVCertificate while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function UpdateAzKVCertificate
function DownloadAzKVCertificate {                                                          # Function to download a key vault certificate
    Begin {                                                                                 # Begin function
        if ($CallingFunction) {                                                             # If $CallingFunction is $null
            $CallingFunction = 'DownloadAzKVCertificate'                                    # Creates $CallingFunction
        }                                                                                   # End if ($CallingFunction)
        :DownloadAzureKVCert while ($true) {                                                # Outer loop for managing function
            $KeyVaultCertObject, $KeyVaultObject = GetAzKVCertificate ($CallingFunction)    # Calls function and assigns output to $var
            if (!$KeyVaultCertObject) {                                                     # If $KeyVaultCertObject is $null
                Break DownloadAzureKVCert                                                   # Breaks :DownloadAzureKVCert
            }                                                                               # End if (!$KeyVaultCertObject)
            Write-Host 'Certificate selected'                                               # Write message to screen
            Write-Host 'Please locate the matching key vault secret'                        # Write message to screen
            Pause
            $KVSV = GetAzKeyVaultSecretValue ($CallingFunction)                             # Calls function and assigns output to $var
            if (!$KVSV) {                                                                   # If $KVSV does not have a value
                Break DownloadAzureKVCert                                                   # Breaks :DownloadAzureKVCert
            }                                                                               # End if (!$KVSV)
            Write-Host 'Secret selected'                                                    # Write message to screen
            :GetDownloadPath while ($True) {                                                # Inner loop for setting the download path
                Write-Host 'Please enter the download path'                                 # Write message to screen
                Write-Host 'Example: C:\users\Admin\Downloads\'                             # Write message to screen
                $Localdownloadpath = Read-Host 'Path'                                       # Operator input for download path
                if ($Localdownloadpath -notlike '*\') {                                     # If $LocalDownloadPath does not end in '\'
                    $Localdownloadpath = $Localdownloadpath+'\'                             # Adds '\' to end of $LocalDownloadPath
                    if (Test-Path -Path $Localdownloadpath) {                               # If $LocalDownloadPath is valud
                        Break GetDownloadPath                                               # Breaks :GetDownloadPath
                    }                                                                       # End if (Test-Path -Path $Localdownloadpath)     
                    else {                                                                  # If $Localdownload path is not valid
                        Write-Host 'The path:'$Localdownloadpath                            # Write message to screen
                        Write-Host 'was not valid'                                          # Write message to screen
                        Pause                                                               # Pauses all actions for operator input
                        Clear-Host                                                          # Clears screen
                    }                                                                       # End else (if (Test-Path -Path $Localdownloadpath))
                }                                                                           # End if ($Localdownloadpath -notlike '*\')
                else {                                                                      # If $LocalDownloadPath ends with '\'
                    if (Test-Path -Path $Localdownloadpath) {                               # If $LocalDownloadPath is valud
                        Break GetDownloadPath                                               # Breaks :GetDownloadPath
                    }                                                                       # End if (Test-Path -Path $Localdownloadpath)     
                    else {                                                                  # If $Localdownload path is not valid
                        Write-Host 'The path:'$Localdownloadpath                            # Write message to screen
                        Write-Host 'was not valid'                                          # Write message to screen
                        Pause                                                               # Pauses all actions for operator input
                        Clear-Host                                                          # Clears screen
                    }                                                                       # End else (if (Test-Path -Path $Localdownloadpath))
                }                                                                           # End else (if ($Localdownloadpath -notlike '*\'))
            }                                                                               # End :GetDownloadPath while ($True)
            :GetDownloadName while ($true) {                                                # Inner loop for setting download name
                Write-Host 'Enter the filename'                                             # Write message to screen
                Write-Host 'Example: downloadedcert'                                        # Write message to screen
                $DownloadName = Read-Host 'Name'                                            # Operator input for file name
                Clear-Host                                                                  # Clears screen
                Write-Host 'Use:'$DownloadName 'as the file name'                           # Write message to screen
                $OpConfirm = Read-Host '[Y] Yes [N] No [E] Exit'                            # Operator confirmation of the file name
                if ($OpConfirm -eq 'e') {                                                   # If $OpConfirm equals 'e'
                    Break DownloadAzureKVCert                                               # Breaks :DownloadAzureKVCert
                }                                                                           # End if ($OpConfirm -eq 'e')
                elseif ($OpConfirm -eq 'y') {                                               # Else if $OpConfirm equals 'y'
                    Break GetDownloadName                                                   # Breaks :GetDownloadName
                }                                                                           # End elseif ($OpConfirm -eq 'y')
                else {                                                                      # All other inputs for $OpConfirm
                    Clear-Host                                                              # Clears screen
                }                                                                           # End else (if ($OpConfirm -eq 'e'))
            }                                                                               # End :GetDownloadName while ($true)
            :GetLocalFilePassword while ($true) {                                           # Inner loop for getting the cert password
                Write-Host 'Please create a password for the certificate'                   # Write message to screen
                $LocalFilePassword = Read-Host 'Password'                                   # Operator input for the cert password
                Clear-Host                                                                  # Clears screen
                Write-Host 'Confirm the password for the certificate'                       # Write message to screen
                $LocalFilePassword2 = Read-Host 'Password'                                  # Operator input for the cert password
                Clear-Host                                                                  # Clears screen
                if ($LocalFilePassword -eq $LocalFilePassword2) {                           # If $LocalFilePassword equals $LocalFilePassword2
                    $Password = ConvertTo-SecureString -String $LocalFilePassword `
                        -AsPlainText -Force                                                 # Converts $LocalFilePassword to secure string $Password
                    Break GetLocalFilePassword                                              # Breaks :GetLocalFilePassword
                }                                                                           # End if ($LocalFilePassword -eq $LocalFilePassword2)
                else {                                                                      # If $LocalFilePassword does not equal $LocalFulePassword2
                    Write-Host 'Passwords did not match'                                    # Write message to screen
                    Pause                                                                   # Pauses all action for operator input
                    Clear-Host                                                              # Clears screen
                }                                                                           # End else (if ($LocalFilePassword -eq $LocalFilePassword2))
            }                                                                               # End :GetLocalFilePassword while ($true)   
            $FullDownloadPath = $Localdownloadpath+$DownloadName+'.pfx'                     # Creates $FullDownloadPath
            Try {                                                                           # Try the following
                $secretByte = [Convert]::FromBase64String($KVSV)                            # Converts key vault secret
                $x509Cert = New-Object `
                    System.Security.Cryptography.X509Certificates.X509Certificate2 `
                    ($secretByte, "", "Exportable,PersistKeySet")                           # Creates X509 cer
                $type = `
                    [System.Security.Cryptography.X509Certificates.X509ContentType]::Pfx
                $pfxFileByte = $x509Cert.Export($type, $password)                           # Converts to PFX
                [System.IO.File]::WriteAllBytes($FullDownloadPath, $pfxFileByte)            # Writes cert to file
            }                                                                               # End try
            catch {                                                                         # If Try fails
                Write-Host 'An error has occured'                                           # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break DownloadAzureKVCert                                                   # Breaks :DownloadAzureKVCert
            }                                                                               # End catch
            Write-Host 'Download complete'                                                  # Write message to screen
            Write-Host 'Path:'$FullDownloadPath                                             # Write message to screen
            Write-Host 'Password:'$LocalFilePassword                                        # Write message to screen
            Pause                                                                           # Pauses all actions for operator input
            Break DownloadAzureKVCert                                                       # Breaks :DownloadAzureKVCert
        }                                                                                   # End :DownloadAzureKVCert while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function DownloadAzKVCertificate
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
# Additional functions for ManageAzKVCertificate
function GetAzKeyVault {                                                                    # Function to get a key vault object
    Begin {                                                                                 # Begin function
        :GetAzureKeyVault while ($true) {                                                   # Outer loop for managing function
            $ObjectList = Get-AzKeyVault                                                    # Gets all key vaults and assigns to $ObjectList
            $ObjectNumber = 1                                                               # Sets $ObjectNumber to 1
            [System.Collections.ArrayList]$ObjectArray = @()                                # Creates the object list array
            foreach ($_ in $ObjectList) {                                                   # For each $_ in $ObjectListList
                $ObjectInput = [PSCustomObject]@{'Number' = $ObjectNumber; `
                'Name'=$_.VaultName;'RG'=$_.ResourceGroupName;'Loc' = $_.Location}          # Creates the item to loaded into array
                $ObjectArray.Add($ObjectInput) | Out-Null                                   # Loads item into array, out-null removes write to screen
                $ObjectNumber = $ObjectNumber + 1                                           # Increments $ObjectNumber by 1
            }                                                                               # End foreach ($_ in $ObjectList)
            Write-Host '[0]  Exit'                                                          # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            foreach ($_ in $ObjectArray) {                                                  # For each $_ in $ObjectArray
                $Number = $_.Number                                                         # Sets $Number to current item .number
                if ($_.Number -le 9) {                                                      # If current item .number is 9 or less
                    Write-Host "[$Number] "$_.Name                                          # Write message to screen
                }                                                                           # End if ($_.Number -le 9) 
                else {                                                                      # If current item .number is greater then 9
                    Write-Host "[$Number]"$_.Name                                           # Write message to screen
                }                                                                           # End else (if ($_.Number -le 9))
                Write-Host 'RG Name: '$_.RG                                                 # Write message to screen
                Write-Host 'Location:'$_.Loc                                                # Write message to screen
                Write-Host ''                                                               # Write message to screen
            }                                                                               # End foreach ($_ in $ObjectArray)
            :SelectAzureKeyVault while ($true) {                                            # Inner loop for selecting the key vault
                if ($CallingFunction) {                                                     # If $CallingFunction exists
                    Write-Host 'You are selecting the key vault for:'$CallingFunction       # Write message to screen
                }                                                                           # End if ($CallingFunction)
                $OpSelect = Read-Host 'Enter option[#]'                                     # Operator input for the key vault selection
                if ($OpSelect -eq '0') {                                                    # If $OpSelect equals 0
                    Break GetAzureKeyVault                                                  # Breaks :GetAzureKeyVault
                }                                                                           # End if ($OpSelect -eq '0')
                elseif ($OpSelect -in $ObjectArray.Number) {                                # If $OpSelect in $ObjectArray.Number
                    $OpSelect = $ObjectArray | Where-Object {$_.Number -eq $OpSelect}       # $OpSelect is equal to $ObjectArray where $ObjectArray.Number is equal to $OpSelect                                  
                    $KeyVaultObject = Get-AzKeyVault -VaultName $OpSelect.Name `
                        -ResourceGroupName $OpSelect.RG                                     # Pulls the full key vault object
                    Clear-Host                                                              # Clears screen
                    Return $KeyVaultObject                                                  # Returns to calling function with $KeyVaultObject
                }                                                                           # End elseif ($RGSelect -in $ListArray.Number)
                else {                                                                      # All other inputs for $OpSelect
                    Write-Host "That was not a valid option"                                # Write message to screen
                }                                                                           # End else (if ($OpSelect -eq '0'))
            }                                                                               # End :SelectAzureKeyVault while ($true)
        }                                                                                   # End :GetAzureKeyVault while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function 
function GetAzKeyVaultSecretValue {                                                         # Function to return the value of a key vault secret
    Begin {                                                                                 # Begin function
        $ErrorActionPreference='silentlyContinue'                                           # Disables Errors
        $WarningPreference = "silentlyContinue"                                             # Disables key vault warnings
        if (!$CallingFunction) {                                                            # If $CallingFunction does not have a value
            $CallingFunction = 'GetAzKeyVaultSecretValue'                                   # Creates $CallingFunction
        }                                                                                   # End if (!$CallingFunction)
        :GetAzureKeyVaultSecretVal while ($true) {                                          # Outer loop for managing function
            $KeyVaultSecretObject, $KeyVaultObject = GetAzKeyVaultSecret ($CallingFunction) # Calls function and assigns output to $Var
            if (!$KeyVaultSecretObject) {                                                   # If $KeyVaultSecretObject is $null
                Break GetAzureKeyVaultSecretVal                                             # Breaks :GetAzureKeyVaultSecretVal
            }                                                                               # End if (!$KeyVaultSecretObject)
            $KVSO = $KeyVaultSecretObject                                                   # KVSO is equal to $KeyVaultSecretObject
            $KVSV = $null                                                                   # Clears $KVSV from all previous use
            $KVSH = $null                                                                   # Clears $KVSH from all previous use
            $KVSH = `
            [System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($KVSO.SecretValue) # $KVSH is equal to to $KVSO.SecretValue
            try {                                                                           # Try the following
                $KVSV = [System.Runtime.InteropServices.Marshal]::PtrToStringBSTR($KVSH)    # KVSV is equal to $KVSH
            }                                                                               # End try
            Catch {                                                                         # If try fails
                Write-Host 'An error has occured'                                           # Write message to screen
                Write-Host 'you may not have permissions'                                   # Write message to screen
                Write-Host 'to this secret or vault'                                        # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break GetAzureKeyVaultSecretVal                                             # Breaks :GetAzureKeyVaultSecretVal
            }                                                                               # End catch
            finally {                                                                       # If try succeeds
                [System.Runtime.InteropServices.Marshal]::ZeroFreeBSTR($KVSV)               # Finishes unhashing $KVSV
            }                                                                               # End finally
            Write-Host '[0] Exit'                                                           # Write message to screen
            Write-Host '[1] Write to screen'                                                # Write message to screen
            Write-Host '[2] Pass value to:'$CallingFunction                                 # Write message to screen
            $OpSelect = Read-Host 'Option [#]'                                              # Operator input for selection option
            if ($OpSelect -eq '0') {                                                        # If $OpSelect equals '0'
                Break GetAzureKeyVaultSecretVal                                             # Breaks :GetAzureKeyVaultSecretVal
            }                                                                               # End if ($OpSelect -eq '0')
            elseif ($OpSelect -eq '1') {                                                    # Else if $OpSelect equals '1'
                Write-Host 'Secret Name: '$KVSO.Name                                        # Write message to screen
                Write-Host 'Secret Value:'$KVSV                                             # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break GetAzureKeyVaultSecretVal                                             # Breaks :GetAzureKeyVaultSecretVal
            }                                                                               # End elseif ($OpSelect -eq '1')
            elseif ($OpSelect -eq '2') {                                                    # Else if $OpSelect equals '2'
                Clear-Host                                                                  # Clears screen
                Return $KVSV                                                                # Returns to calling function with $var
            }                                                                               # End elseif ($OpSelect -eq '1')
            else {                                                                          # All other inputs for $OpSelect
                Write-Host 'That was not a valid option'                                    # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Clear-Host                                                                  # Clears screen
            }                                                                               # End else (if ($OpSelect -eq '0'))
        }                                                                                   # End :GetAzureKeyVaultSecretValue while ($true) 
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End begin statement   
}                                                                                           # End function GetAzKeyVaultSecretValue