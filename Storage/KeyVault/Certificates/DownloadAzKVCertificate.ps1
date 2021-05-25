# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Mircosoft docs links
    Get-AzKeyVaultCertificate:  https://docs.microsoft.com/en-us/powershell/module/az.keyvault/get-azkeyvaultcertificate?view=azps-5.9.0
    Get-AzKeyVault:             https://docs.microsoft.com/en-us/powershell/module/az.keyvault/get-azkeyvault?view=azps-5.1.0
    Get-AzKeyVaultSecret:       https://docs.microsoft.com/en-us/powershell/module/az.keyvault/get-azkeyvaultsecret?view=azps-5.1.0
    Convert value to plain txt: https://docs.microsoft.com/en-us/azure/key-vault/secrets/quick-create-powershell
} #>
<# Required Functions Links: {
    GetAzKVCertificate:         https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Storage/KeyVault/
    GetAzKeyVault:              https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Storage/KeyVault/GetAzKeyVault.ps1
    GetAzKeyVaultSecretValue:   https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Storage/KeyVault/Secrets/GetAzKeyVaultSecretValue.ps1
} #>
<# Functions Description: {
    DownloadAzKVCertificate:    Downloads a key vault certificate
    GetAzKeyVault:              Gets key vault object
    GetAzKeyVaultSecretValue:   Gets key vault secret value
} #>
<# Variables: {
    :DownloadAzureKVCert        Outer loop for managing function
    :GetDownloadPath            Inner loop for setting the download path
    :GetDownloadName            Inner loop for setting the file name once downloaded
    :GetLocalFilePassword       Inner loop for setting the download cert password
    $CallingFunction:           Name of this function or the one that called it
    $KeyVaultCertObject:        Key vault certificate object
    $KeyVaultObject:            Key vault object    
    $KVSV:                      Key vault secret value
    $Localdownloadpath:         Operator input on the download path
    $DownloadName:              Operator input for the cert name
    $OpConfirm:                 Operator confirmation of inputted values
    $LocalFilePassword:         Operator input of the cert password
    $LocalFilePassword2:        Operator confirmation of the cert password
    $Password:                  Hashed version of $LocalFilePassword
    $FullDownloadPath:          $Localdownloadpath + $DownloadName
    GetAzKVCertificate{}        Gets $KeyVaultCertObject
        GetAzKeyVault{}             Gets $KeyVaultObject
    GetAzKeyVaultSecretValue{}  Gets $KVSV
        GetAzKeyVault{}             Gets $KeyVaultObject
} #>
<# Process Flow {
    Function
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
            Return Function > Send $null
}#>
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