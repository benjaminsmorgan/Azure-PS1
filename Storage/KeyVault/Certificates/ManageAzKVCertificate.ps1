# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Mircosoft docs links
    Get-AzKeyVault:             https://docs.microsoft.com/en-us/powershell/module/az.keyvault/get-azkeyvault?view=azps-5.1.0
} #>
<# Required Functions Links: {
    GetAzKeyVault:              https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Storage/KeyVault/GetAzKeyVault.ps1
} #>
<# Functions Description: {
    ManageAzKVCertificate:      Management function for key vault certs
    
} #>
<# Variables: {
    :ManageAzureKeyVaultCert  Outer loop for managing function
    $OpSelect:                  Operator input to select function

} #>
<# Process Flow {
    Function
        Call ManageAzKVCertificate > Get $null

            Return Function > Send $null
}#>
function ManageAzKVCertificate {                                                            # Function for managing key vault certs
    Begin {                                                                                 # Begin function
        :ManageAzureKeyVaultCert while ($true) {                                            # Outer loop for managing function
            Write-Host '[0] To exit'                                                        # Write message to screen
            Write-Host '[1] New Key Vault Cert'                                             # Write message to screen
            Write-Host '[2] Add Key Vault Cert'                                             # Write message to screen
            Write-Host '[3] List All Key Vaults Certs'                                      # Write message to screen
            Write-Host '[4] Download Key Vault Cert'                                        # Write message to screen
            Write-Host '[5] Update Key Vault Cert'                                          # Write message to screen
            Write-Host '[6] Remove Key Vault Cert'                                          # Write message to screen
            $OpSelect = Read-Host 'Option [#]'                                              # Operator input for selecting the management function
            if ($OpSelect -eq '0') {                                                        # If $OpSelect equals '0'
                Break ManageAzureKeyVaultCert                                               # Breaks :ManageAzureKeyVaultCert
            }                                                                               # End if ($OpSelect -eq '0')
            elseif ($OpSelect -eq '1') {                                                    # Else if $OpSelect equals '1'            
                Write-Host 'New Key Vault Cert'                                             # Write message to screen
                NewAzKVCertificate                                                          # Calls function
            }                                                                               # End elseif ($OpSelect -eq '1')
            elseif ($OpSelect -eq '2') {                                                    # Else if $OpSelect equals '2'            
                Write-Host 'Add Key Vault Cert'                                             # Write message to screen
                # Calls function
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
                # Calls function
            }                                                                               # End elseif ($OpSelect -eq '5')
            elseif ($OpSelect -eq '6') {                                                    # Else if $OpSelect equals '6'            
                Write-Host 'Remove Key Vault Cert'                                          # Write message to screen
                RemoveAzKVCertificate                                                       # Calls function
            }                                                                               # End elseif ($OpSelect -eq '6')
            else {                                                                          # All other inputs for $OpSelect
                Write-Host 'That was not a valid option'                                    # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
            }                                                                               # End else (if ($OpSelect -eq '0'))
            Clear-Host                                                                      # Clears screen
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
            $FullDownloadPath = $Localdownloadpath+$DownloadName+'.pfx'                     # Creates $FullDownloadPath
            Try {                                                                           # Try the following
                $secretByte = [Convert]::FromBase64String($KVSV)
                $x509Cert = New-Object System.Security.Cryptography.X509Certificates.X509Certificate2($secretByte, "", "Exportable,PersistKeySet")
                $type = [System.Security.Cryptography.X509Certificates.X509ContentType]::Pfx
                $pfxFileByte = $x509Cert.Export($type, $password)
                [System.IO.File]::WriteAllBytes($FullDownloadPath, $pfxFileByte)            # Writes cert to file
            }                                                                               # End try
            catch {                                                                         # If Try fails
                Write-Host 'An error has occured'                                           # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break DownloadAzureKVCert                                                   # Breaks :DownloadAzureKVCert
            }                                                                               # End catch
            Write-Host 'Download complete'                                                  # Write message to screen
            Write-Host 'Path:'$FullDownloadPath                                             # Write message to screen
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