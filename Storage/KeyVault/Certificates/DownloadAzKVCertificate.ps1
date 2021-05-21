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