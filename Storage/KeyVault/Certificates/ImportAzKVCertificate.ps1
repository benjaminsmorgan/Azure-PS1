# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Mircosoft docs links
    Import-AzKeyVaultCertificate    https://docs.microsoft.com/en-us/powershell/module/az.keyvault/import-azkeyvaultcertificate?view=azps-5.9.0
    Get-AzKeyVault:             https://docs.microsoft.com/en-us/powershell/module/az.keyvault/get-azkeyvault?view=azps-5.1.0
    Get-AzKeyVaultSecret:       https://docs.microsoft.com/en-us/powershell/module/az.keyvault/get-azkeyvaultsecret?view=azps-5.1.0
    Convert value to plain txt: https://docs.microsoft.com/en-us/azure/key-vault/secrets/quick-create-powershell
} #>
<# Required Functions Links: {
    GetAzKeyVault:              https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Storage/KeyVault/GetAzKeyVault.ps1
    GetAzKeyVaultSecretValue:   https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Storage/KeyVault/Secrets/GetAzKeyVaultSecretValue.ps1
} #>
<# Functions Description: {
    ImportAzKVCertificate:      Imports a key vault certificate
    GetAzKeyVault:              Gets key vault object
    GetAzKeyVaultSecretValue:   Gets key vault secret value
} #>
<# Variables: {
    :AddAzureKVCert             Outer loop for managing function
    :GetLocalfilepath           Inner loop for getting the file path
    :GetLocalFilePassword       Inner loop for adding the cert password
    :SetAzureKVCertName         Inner loop for setting the cert name
    $CallingFunction:           Name of this function or the one that called it
    $KeyVaultObject:            Key vault object
    $LocalFilePath:             Operator input to the file
    $OpConfirm:                 Operator confirmation of inputted values
    $OpSelect:                  Operator input to select option
    $LocalFilePassword:         Operator input of the cert password
    $LocalFilePassword2:        Operator confirmation of the cert password
    $Password:                  Hashed version of $LocalFilePassword
    $KVSV:                      Key vault secret value
    $CertName:                  Operator input of the name of the cert in the vault
    GetAzKeyVault{}             Gets $KeyVaultObject
    GetAzKeyVaultSecretValue{}  Gets $KVSV
        GetAzKeyVault{}             Gets $KeyVaultObject
} #>
<# Process Flow {
    Function
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
            Return Function > Send $null
}#>
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