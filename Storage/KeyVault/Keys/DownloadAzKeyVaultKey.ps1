# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Mircosoft docs links
    Get-AzKeyVaultKey:          https://docs.microsoft.com/en-us/powershell/module/az.keyvault/get-azkeyvaultKey?view=azps-5.1.0
    Get-AzKeyVault:             https://docs.microsoft.com/en-us/powershell/module/az.keyvault/get-azkeyvault?view=azps-5.1.0
    Get-AzResourceGroup:        https://docs.microsoft.com/en-us/powershell/module/az.resources/get-azresourcegroup?view=azps-5.1.0
} #>
<# Required Functions Links: {
    GetAzKeyVaultKey:           https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Storage/KeyVault/Keys/GetAzKeyVaultKey.ps1
    GetAzKeyVault:              https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Storage/KeyVault/GetAzKeyVault.ps1
} #>
<# Functions Description: {
    DownloadAzKeyVaultKey:      Downloads a key vault key
    GetAzKeyVaultKey:           Gets a key vault Key
    GetAzKeyVault:              Gets key vault object
} #>
<# Variables: {
    :DownloadAzureKVKey         Outer loop for managing function
    :SetLocalFilePath           Inner loop for setting the download path
    :SetLocalFileName           Inner loop for setting the key local name
    $CallingFunction:           Name of this function or the one that called it
    $KeyVaultKeyObject:         Key vault key being downloaded
    $KeyVaultObject:            Key vault object
    $OpSelect:                  Operator input for selecting download location
    $Username:                  Operators username
    $LocalFileDownloadPath:     Operator input for the download path
    $LocalFileName:             Operator input for the key name
    $OpConfirm:                 Operator confirmation of file name
    $Fullpath:                  Creates the full download path and name $var
    GetAzKeyVaultKey{}          Gets $KeyVaultKeyObject
        GetAzKeyVault{}             Gets $KeyVaultObject
} #>
<# Process Flow {
    Function
        Call DownloadKeyVaultKey > Get $null
            Call GetAzKeyVaultKey > Get $KeyVaultKeyObject
                Call GetAzKeyVault > Get $KeyVault
                End GetAzKeyVault
                    Return GetAzKeyVaultKey > Send $KeyVault
            End GetAzKeyVaultKey
                Return DownloadKeyVaultKey > Send $KeyVaultKeyObject
        End DownloadKeyVaultKey
            Return function > Send $null
}#>
function DownloadAzKeyVaultKey {                                                            # Function to download a key vault key
    Begin {                                                                                 # Begin function
        $ErrorActionPreference = 'silentlyContinue'                                         # Disables error reporting
        if (!$CallingFunction) {                                                            # If $CallingFunction does not have a value
            $CallingFunction = 'DownloadAzKeyVaultKey'                                      # Creates $CallingFunction 
        }                                                                                   # End if (!$CallingFunction)
        :DownloadAzureKVKey while ($true) {                                                 # Outer loop for managing function
            $KeyVaultKeyObject, $KeyVaultObject = GetAzKeyVaultKey ($CallingFunction)       # Calls function and assigns output to $vars
            if (!$KeyVaultKeyObject) {                                                      # If $KeyVaultKeyObject is $null
                Break DownloadAzureKeyVaultKey                                              # Breaks :DownloadAzureKeyVaultKey    
            }                                                                               # End if (!$KeyVaultObject)
            :SetLocalFilePath while ($true) {                                               # Inner loop for setting the local download path
                Write-Host '[0] Exit'                                                       # Write message to screen
                Write-Host '[1] Downloads folder'                                           # Write message to screen
                Write-Host '[2] Custom path'                                                # Write message to screen
                $OpSelect = Read-Host 'Option [#]'                                          # Operator input for download path selection
                if ($OpSelect -eq '0') {                                                    # If $OpSelect equals '0'
                    Break DownloadAzureKeyVaultKey                                          # Breaks :DownloadAzureKeyVaultKey
                }                                                                           # End if ($OpSelect -eq '0')
                elseif ($OpSelect -eq '1') {                                                # Else if $OpSelect equals '1'
                    $UserName = $env:USERNAME                                               # Gets session username
                    if ($UserName -like '*\*') {                                            # If $Username has a '\'
                        $UserName = $UserName.Split('\')[1]                                 # Removes \ and text before it
                    }                                                                       # End if ($UserName -like '*\*')
                    $LocalFileDownloadPath = 'c:\users\'+$UserName+'\downloads\'            # Creates $Localdownloadpath
                    Clear-Host                                                              # Clears screen
                    Break SetLocalFilePath                                                  # Breaks :SetLocalFilePath  
                }                                                                           # End elseif ($OpSelect -eq '1')
                elseif ($OpSelect -eq '2') {                                                # Else if $OpSelect equals '2'
                    :VerifyPath while ($true) {                                             # Inner loop for verifying local download path
                        $LocalFileDownloadPath = Read-Host `
                            'Enter the folder path to download key to'                      # Operator input for local download path
                        if ($LocalFileDownloadPath -eq 'exit') {                            # If $LocalFileDownloadPath equals 'exit'
                            Break DownloadAzureKeyVaultKey                                  # Breaks :DownloadAzureKeyVaultKey
                        }                                                                   # End if ($LocalFileDownloadPath -eq 'exit')
                        if (Test-Path $LocalFileDownloadPath) {                             # If $LocalFileDownloadPath is valid
                            Clear-Host                                                      # Clears screen
                            Break SetLocalFilePath                                          # Breaks :SetLocalFilePath
                        }                                                                   # End if (Test-Path $LocalFileDownloadPath)
                        else {                                                              # If Test-Path is false
                            Write-Host ''                                                   # Write message to screen
                            Write-Host 'The listed path was not valid'                      # Write message to screen
                            Write-Host 'Please double check the folder path'                # Write message to screen
                            Write-Host ''                                                   # Write message to screen
                            Write-Host 'Enter "exit" to leave this function'                # Write message to screen
                            Pause                                                           # Pauses for operator input
                            Clear-Host                                                      # Clears screen
                        }                                                                   # End else (if (Test-Path $LocalFileDownloadPath))
                    }                                                                       # End :VerifyPath while ($true)
                }                                                                           # End elseif ($OpSelect -eq '2')
                else {                                                                      # All other inputs for $OpSelect
                    Write-Host 'That was not a valid option'                                # Write message to screen
                }                                                                           # End else (if ($OpSelect -eq '0'))
            }                                                                               # End :SetLocalFilePath while ($true)
            :SetLocalFileName while ($true) {                                               # Inner loop for setting the key local name
                $LocalFileName = Read-Host 'Enter the key name'                             # Operator input for the key name
                if ($LocalFileName -eq 'exit') {                                            # If $LocalFileName is equal to 'exit'
                    Break DownloadAzureKVKey                                                # Breaks :DownloadAzureKVKey
                }                                                                           # End if ($LocalFileName -eq 'exit')
                $LocalfileName = $LocalFileName+'.pem'                                      # Adds .pem to file name
                Write-Host 'User this file name:'$LocalFileName                             # Write message to screen
                $OpConfirm = Read-Host '[Y] Yes [N] No'                                     # Operator confirmation of file name
                if ($OpConfirm -eq 'y') {                                                   # If $OpConfirm equals 'y'
                    Break SetLocalFileName                                                  # Breaks :SetLocalFileName
                }                                                                           # End if ($OpConfirm -eq 'y')
            }                                                                               # End :SetLocalFileName while ($true)
            $Fullpath = $LocalFileDownloadPath+$LocalFileName                               # Creates the full download path and name $var
            Try {                                                                           # Try the following
                Get-AzKeyVaultKey -VaultName $KeyVaultObject.VaultName -Name `
                    $KeyVaultKeyObject.Name -OutFile $Fullpath -ErrorAction 'Stop'          # Downloads the selected key
            }                                                                               # End Try
            Catch {                                                                         # If try fails
                Write-Host 'An error has occured'                                           # Write message to screen
                Write-Host 'You may not have permissions to this key'                       # Write message to screen
                Write-Host 'You may not have permissions to the download location'          # Write message to screen
                Write-Host 'The selected download location may not exist'                   # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Clear-Host                                                                  # Clears screen
                Break DownloadAzureKVKey                                                    # Breaks :DownloadAzureKVKey    
            }                                                                               # End Catch
            Write-Host 'The key has been downloaded'                                        # Write message to screen
            Pause                                                                           # Pauses all actions for operator input
            Clear-Host                                                                      # Clears screen
            Break DownloadAzureKVKey                                                        # Breaks :DownloadAzureKVKey    
        }                                                                                   # End :DownloadAzureKVKey while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function DownloadAzKeyVaultKey