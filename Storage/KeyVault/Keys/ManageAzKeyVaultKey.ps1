# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Microsoft docs links
    Get-AzKeyVaultKey:          https://docs.microsoft.com/en-us/powershell/module/az.keyvault/get-azkeyvaultkey?view=azps-5.4.0
    Add-AzKeyVaultKey:          https://docs.microsoft.com/en-us/powershell/module/az.keyvault/add-azkeyvaultkey?view=azps-5.4.0
    Remove-AzKeyVaultKey:       https://docs.microsoft.com/en-us/powershell/module/az.keyvault/remove-azkeyvaultkey?view=azps-5.4.0
    Get-AzKeyVault:             https://docs.microsoft.com/en-us/powershell/module/az.keyvault/get-azkeyvault?view=azps-5.1.0
} #>
<# Required Functions Links: {
    NewAzKeyVaultKey:           https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Storage/KeyVault/Keys/NewAzKeyVaultKey.ps1
    AddAzKeyVaultKey:           https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Storage/KeyVault/Keys/AddAzKeyVaultKey.ps1
    ListAzKeyVaultKey:          https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Storage/KeyVault/Keys/ListAzKeyVaultKey.ps1
    GetAzKeyVaultKey:           https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Storage/KeyVault/Keys/GetAzKeyVaultKey.ps1
    DownloadAzKeyVaultKey:      https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Storage/KeyVault/Keys/DownloadAzKeyVaultKey.ps1
    RemoveAzKeyVaultKey:        https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Storage/KeyVault/Keys/RemoveAzKeyVaultKey.ps1
    GetAzKeyVault:              https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Storage/KeyVault/GetAzKeyVault.ps1
} #>
<# Functions Description: {
    ManageAzKeyVaultKey:        Management function for key vault Keys
    NewAzKeyVaultKey:           Creates a new key vault Key
    AddAzKeyVaultKey:           Uploads an existing key into vault
    ListAzKeyVaultKey:          Lists all key vault Keys by vault name
    GetAzKeyVaultKey:           Gets a key vault Key
    DownloadAzKeyVaultKey:      Downloads selected key vault Key
    RemoveAzKeyVaultKey:        Removes a selected key vault Key
    GetAzKeyVault:              Gets key vault object
} #>
<# Variables: {
    :ManageAzureKeyVaultKey     Outer loop for managing function
    $OpSelect:                  Operator input for selecting management function
    NewAzKeyVaultKey{}          Creates $KeyVaultKeyObject
        GetAzKeyVault{}             Gets $KeyVaultKey
    AddAzKeyVaultKey{}          Creates $KeyVaultKeyObject
        GetAzKeyVault{}             Gets $KeyVaultKey
    ListAzKeyVaultKey{}         Lists all Keys in subscription
    DownloadAzKeyVaultKey{      Downloads $KeyVaultKeyObject
        GetAzKeyVaultKey{}          Gets $KeyVaultKeyObject
            GetAzKeyVault{}             Gets $KeyVaultObject
    RemoveAzKeyVaultKey{}       Removes $KeyVaultKeyObject
        GetAzKeyVaultKey{}          Gets $KeyVaultKeyObject
            GetAzKeyVault{}             Gets $KeyVaultObject
} #>
<# Process Flow {
    Function
        Call ManageAzKeyVaultKey > Get $null
            Call NewAzKeyVaultKey > Get $null
                Call GetAzKeyVault > Get $KeyVaultObject
                End GetAzKeyVault
                    Return NewAzKeyVaultKey > Send $KeyVaultObject  
            End NewAzKeyVaultKey
                Return ManageAzKeyVaultKey > Send $null
            Call AddAzKeyVaultKey > Get $null
                Call GetAzKeyVault > Get $KeyVaultObject
                End GetAzKeyVault
                    Return AddAzKeyVaultKey > Send $KeyVaultObject  
            End AddAzKeyVaultKey
                Return ManageAzKeyVaultKey > Send $null
            Call ListAzKeyVaultKey > Get $null
            End ListAzKeyVaultKey
                Return ManageAzKeyVaultKey > Send $null
            Call DownloadKeyVaultKey > Get $null
                Call GetAzKeyVaultKey > Get $KeyVaultKeyObject
                    Call GetAzKeyVault > Get $KeyVault
                    End GetAzKeyVault
                        Return GetAzKeyVaultKey > Send $KeyVault
                End GetAzKeyVaultKey
                    Return DownloadKeyVaultKey > Send $KeyVaultKeyObject
            End DownloadKeyVaultKey
                Return ManageAzKeyVaultKey > Send $null
            Call RemoveAzKeyVaultKey > Get $null
                Call GetAzKeyVaultKey > Get $KeyVaultKeyObject
                    Call GetAzKeyVault > Get $KeyVaultObject
                    End GetAzKeyVault
                        Return GetAzKeyVaultKey > Send $KeyVaultObject
                End GetAzKeyVaultKey
                    Return RemoveAzKeyVaultKey > Send $KeyVaultKeyObject  
            End RemoveAzKeyVaultKey
                Return ManageAzKeyVaultKey > Send $null
        End ManageAzKeyVaultKey
            Return Function > Send $null
}#>
function ManageAzKeyVaultKey {                                                              # Function for managing key vault keys
    Begin {                                                                                 # Begin function
        :ManageAzureKeyVaultKey while ($true) {                                             # Outer loop for managing function
            Write-Host '[0] Exit'                                                           # Write message to screen
            Write-Host '[1] New Key Vault Key'                                              # Write message to screen
            Write-Host '[2] Add Key Vault Key'                                              # Write message to screen
            Write-Host '[3] List All Key Vaults Keys'                                       # Write message to screen
            Write-Host '[4] Download Key Vault Key'                                         # Write message to screen
            Write-Host '[5] Remove Key Vault Key'                                           # Write message to screen
            $OpSelect = Read-Host 'Option [#]'                                              # Operator input for selecting the management function
            Clear-Host                                                                      # Clears screen
            if ($OpSelect -eq '0') {                                                        # If $OpSelect equals '0'
                Break ManageAzureKeyVaultKey                                                # Breaks :ManageAzureKeyVaultKey
            }                                                                               # End if ($OpSelect -eq '0')
            elseif ($OpSelect -eq '1') {                                                    # Elseif $OpSelect equals '1'
                Write-Host 'New Key Vault Key'                                              # Write message to screen
                NewAzKeyVaultKey                                                            # Calls function 
            }                                                                               # End elseif ($OpSelect -eq '1')
            elseif ($OpSelect -eq '2') {                                                    # Elseif $OpSelect equals '2'
                Write-Host 'Add Key Vault Key'                                              # Write message to screen
                AddAzKeyVaultKey                                                            # Calls function 
            }                                                                               # End elseif ($OpSelect -eq '2')
            elseif ($OpSelect -eq '3') {                                                    # Elseif $OpSelect equals '3'
                Write-Host 'List All Key Vaults Keys'                                       # Write message to screen
                ListAzKeyVaultKey                                                           # Calls function 
            }                                                                               # End elseif ($OpSelect -eq '3')
            elseif ($OpSelect -eq '4') {                                                    # Elseif $OpSelect equals '4'
                Write-Host 'Download Key Vault Key'                                         # Write message to screen
                DownloadAzKeyVaultKey                                                       # Calls function 
            }                                                                               # End elseif ($OpSelect -eq '4')
            elseif ($OpSelect -eq '5') {                                                    # Elseif $OpSelect equals '5'
                Write-Host 'Remove Key Vault Key'                                           # Write message to screen
                RemoveAzKeyVaultKey                                                         # Calls function 
            }                                                                               # End elseif ($OpSelect -eq '5')
            else {                                                                          # All other inputs for $OpSelect
                Write-Host 'That was not a valid input'                                     # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Clear-Host                                                                  # Clears screen
            }                                                                               # End else (if ($OpSelect -eq '0'))
        }                                                                                   # End :ManageAzureKeyVaultKey while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End begin statemnt
}                                                                                           # End function ManageAzKeyVaultKey
function NewAzKeyVaultKey {                                                                 # Function to create a new key vault key
    Begin {                                                                                 # Begin function
        if (!$CallingFunction) {                                                            # If $CallingFunction does not exist
            $CallingFunction = 'NewAzKeyVaultKey'                                           # Creates $CallingFunction
        }                                                                                   # End if (!$CallingFunction)
        :NewAzureKeyVaultKey while ($true) {                                                # Outer loop for managing function
            $KeyVaultObject = GetAzKeyVault ($CallingFunction)                              # Calls function and assigns output to $var
            if (!$KeyVaultObject) {                                                         # If $KeyVaultObject is $null
                Break NewAzureKeyVaultKey                                                   # Breaks :NewAzureKeyVaultKey    
            }                                                                               # End if (!$KeyVaultObject)
            $ValidArray = 'abcdefghijklmnopqrstuvwxyz0123456789'                            # Creates a string of valid characters
            $ValidArray = $ValidArray.ToCharArray()                                         # Loads all valid characters into array    
            :AzureKeyVaultKeyName while ($true) {                                           # Inner loop for setting $KeyVaultKeyObject name
                $KeyVaultKeyNameInput = $null                                               # Clears $KeyVaultKeyNameInput
                Write-Host 'Key name may only include letters and numbers'                  # Write message to screen
                Write-Host 'Key name cannot inlude any spaces'                              # Write message to screen
                Write-Host 'Key name must be less that 64 characters'                       # Write message to screen
                Write-Host ''                                                               # Write message to screen
                $KeyVaultKeyNameInput = Read-Host 'Key name'                                # Operator input for the key name
                $KeyVaultKeyNameArray = $KeyVaultKeyNameInput.ToCharArray()                 # Creates an array from $KeyVaultKeyNameInput 
                if ($KeyVaultKeyNameInput -eq 'exit') {                                     # $KeyVaultKeyNameInput is equal to exit
                    Break NewAzureKeyVaultKey                                               # Breaks :NewAzureKeyVaultkey
                }                                                                           # if ($KeyVaultKeyNameInput -eq 'exit')
                if ($KeyVaultKeyNameInput.Length -ge 64) {                                  # If $KeyVaultKeyNameInput is greater than 63 characters
                    Write-Host 'The key name must be less than 64 characters'               # Write message to screen
                    $KeyVaultKeyNameInput = $null                                           # Clears $KeyVaultKeyNameInput                                   
                }                                                                           # End if ($KeyVaultKeyNameInput.Length -ge 63)
                foreach ($_ in $KeyVaultKeyNameArray) {
                    if ($_ -notin $ValidArray) {                                            # If current item is not in $ValidArray
                        if ($_ -eq ' ') {                                                   # If current item equals 'space'
                            Write-Host ''                                                   # Write message to screen    
                            Write-Host 'Key name cannot include any spaces'                 # Write message to screen
                        }                                                                   # End if ($_ -eq ' ')
                        else {                                                              # If current item is not equal to 'space'
                            Write-Host ''                                                   # Write message to screen    
                            Write-Host $_' is not a valid character'                        # Write message to screen
                        }                                                                   # End else (if ($_ -eq ' '))
                        $KeyVaultKeyNameInput = $null                                       # Clears $VaultNameInput
                    }                                                                       # End if ($_ -notin $ValidArray)
                }                                                                           # End foreach ($_ in $KeyVaultKeyNameArray)
                if (!$KeyVaultKeyNameInput) {                                               # If $KeyVaultNameInput is $null
                    Pause                                                                   # Pauses all action for operator input
                    Clear-Host                                                              # Clears screen
                }                                                                           # End if (!$KeyVaultKeyNameInput)
                else {                                                                      # If $KeyVaultKeyNameInput has a value
                    Write-Host 'Use:' $KeyVaultKeyNameInput 'as key name'                   # Write message to screen
                    $OpConfirm = Read-Host '[Y] Yes [N] No'                                 # Operator confirmation of key name
                    if ($OpConfirm -eq 'y') {                                               # If $OpConfirm is equal to 'y'
                        Clear-Host                                                          # Clears screen
                        Break AzureKeyVaultKeyName                                          # Breaks SetAzureKeyVaultName
                    }                                                                       # End If ($OpConfirm -eq 'y')
                }                                                                           # End else (if (!$KeyVaultKeyNameInput))
            }                                                                               # End :AzureKeyVaultKeyName while ($true)
            Write-Host 'Set an expiration date on this key'                                 # Write message to screen
            $OpSelect = Read-Host '[Y] Yes [N] No [E] Exit'                                 # Operator input for setting a key expiration
            if ($OpSelect -eq 'e') {                                                        # If $OpSelect equals 'e'
                Break NewAzureKeyVaultKey                                                   # Breaks :NewAzureKeyVaultkey
            }                                                                               # End if ($OpSelect -eq 'e')
            if ($OpSelect -eq 'y') {                                                        # If $OpSelect equals 'y'
                :AzureKeyVaultKeyExpire while ($true) {                                     # Inner loop for setting expiration date
                    $StartDate = (Get-Date).Date                                            # Gets current date
                    Write-Host 'Enter the date in the following format: YYYY-MM-DD'         # Write message to screen
                    Write-Host 'Example: 2050-07-04 to have the key expire on 4 July 2050'  # Write message to screen
                    $EndDate = Read-Host 'Key expiration date'                              # Operator input for end date
                    if ($EndDate -eq 'exit') {                                              # If $EndDate equals 'exit'
                        Break NewAzureKeyVaultKey                                           # Breaks :NewAzureKeyVaultKey
                    }                                                                       # End if ($EndDate -eq 'exit')
                    $DateDiff = New-TimeSpan -Start $StartDate -End $EndDate                # Gets count of days between current and end date
                    if (!$DateDiff) {                                                       # If $DateDiff does not have a value (Result of bad $EndDate entry)
                        Write-Host 'The expiration date entry was not valid'                # Write message to screen
                        Write-Host 'Please enter a date in the listed format'               # Write message to screen
                        Pause                                                               # Pauses all actions for operator input
                        Clear-Host                                                          # Clears screen
                    }                                                                       # End if (!$DateDiff)
                    elseif ($DateDiff -le 0) {                                              # $DateDiff is 0 or less
                        Write-Host 'The date entered was not in the future'                 # Write message to screen
                        Write-Host 'Please enter a future date'                             # Write message to screen
                        $DateDiff = $null                                                   # Clears $DateDiff
                        Pause                                                               # Pauses all actions for operator input
                        Clear-Host                                                          # Clears screen
                    }                                                                       # End elseif ($DateDiff -le 0) 
                    elseif ($DateDiff) {                                                    # If $DateDiff has a value of 1 or higher
                        $KeyExpires = (Get-Date).AddDays($DateDiff.Days).ToUniversalTime()  # Sets $KeyExpires to operator selected date
                        $KeyNotBefore = (Get-Date).ToUniversalTime()                        # Sets $KeyNotBefore to current date
                        Clear-Host                                                          # Clears screen
                        Break AzureKeyVaultKeyExpire                                        # Breaks :AzureKeyVaultKeyExpire
                    }                                                                       # End if ($DateDiff)
                }                                                                           # End AzureKeyVaultKeyExpire while ($true)
            }                                                                               # End if ($OpSelect -eq 'y')
            :AzureKeyVaultKeyEncrypt while ($true) {                                        # Inner loop for setting the encyption type
                Write-Host 'Select key encyption type'                                      # Write message to screen
                Write-Host '[0] Exit'                                                       # Write message to screen
                Write-Host '[1] HSM'                                                        # Write message to screen
                Write-Host '[2] Software'                                                   # Write message to screen
                $OpSelect = Read-Host 'Option [#]'                                          # Operator input for encryption type
                if ($OpSelect -eq '0') {                                                    # If $OpSelect equals '0' 
                    Break NewAzureKeyVaultKey                                               # Breaks :NewAzureKeyVaultKey
                }                                                                           # End if ($OpSelect -eq '0')
                elseif ($OpSelect -eq '1') {                                                # Else if $OpSelect equals '1'
                    $KeyEncryptType = 'HSM'                                                 # Sets $KeyEncryptType to 'HSM'
                }                                                                           # End elseif ($OpSelect -eq '1')
                elseif ($OpSelect -eq '2') {                                                # Else if $OpSelect equals '2'
                    $KeyEncryptType = 'Software'                                            # Sets $KeyEncryptType to 'Software'
                    Clear-Host                                                              # Clears screen
                    Break AzureKeyVaultKeyEncrypt                                           # Breaks :AzureKeyVaultKeyEncrypt
                }                                                                           # End elseif ($OpSelect -eq '2')
                else {                                                                      # All other inputs for $OpSelect
                    Write-Host 'That was not a valid option'                                # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Clear-Host                                                              # Clears screen
                    Break NewAzureKeyVaultKey                                               # Breaks :NewAzureKeyVaultKey
                }                                                                           # End else (if ($OpSelect -eq '0'))
                if ($KeyEncryptType -eq 'HSM') {                                            # If $KeyEncryptType is equal to 'HSM'
                    if ($KeyVaultObject.SKU -eq 'Standard') {                               # If $KeyVaultObject.SKU is equal to 'Standard'
                        Write-Host 'HSM is not supported on this key vault'                 # Write message to screen
                        Write-Host '[0] Exit'                                               # Write message to screen
                        Write-Host '[1] Change encryption to software'                      # Write message to screen
                        $OpSelect = Read-Host 'Option [#]'                                  # Operator input on changing type or exiting
                        if ($OpSelect -eq '0') {                                            # If $OpSelect equals '0'
                            Break NewAzureKeyVaultKey                                       # Breaks :NewAzureKeyVaultKey
                        }                                                                   # End if ($OpSelect -eq '0')
                        elseif ($OpSelect -eq '1') {                                        # Else if $OpSelect equals '1'
                            $KeyEncryptType = 'Software'                                    # Sets $KeyEncryptType to 'Software'
                            Clear-Host                                                      # Clears screen
                            Break AzureKeyVaultKeyEncrypt                                   # Breaks :AzureKeyVaultKeyEncrypt
                        }                                                                   # End elseif ($OpSelect -eq '1')
                        else {                                                              # All other inputs for $OpSelect
                            Write-Host 'That was not a valid option'                        # Write message to screen
                            Pause                                                           # Pauses all actions for operator input
                            Clear-Host                                                      # Clears screen
                        }                                                                   # End else (if ($OpSelect -eq '0'))
                    }                                                                       # End if ($KeyVaultObject.Sku -eq 'Standard')
                    else {                                                                  # If $KeyVaultObject.SKU does not equal 'standard'
                        Clear-Host                                                          # Clears screen
                        Break AzureKeyVaultKeyEncrypt                                       # Breaks :AzureKeyVaultKeyEncrypt 
                    }                                                                       # End else (if ($KeyVaultObject.Sku -eq 'Standard'))
                }                                                                           # End elseif ($KeyEncryptType -eq 'HSM')
            }                                                                               # End :AzureKeyVaultKeyEncrypt while ($true)
            if ($KeyNotBefore) {                                                            # If $KeyNotBefore has a value
                Try {                                                                       # Try the following
                    Add-AzKeyVaultKey -VaultName $KeyVaultObject.VaultName -Name `
                        $KeyVaultKeyNameInput -Destination $KeyEncryptType -Expires `
                        $KeyExpires -NotBefore $KeyNotBefore -ErrorAction 'Stop'            # Creates the new key
                }                                                                           # End try
                Catch {                                                                     # If Try fails
                    Write-Host 'An error has occured'                                       # Write message to screen
                    Write-Host 'You may not have the permissions to preform this action'    # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Clear-Host                                                              # Clears screen
                    Break NewAzureKeyVaultKey                                               # Breaks :NewAzureKeyVaultKey
                }                                                                           # End Catch
                Write-Host 'The key has been created'                                       # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Clear-Host                                                                  # Clears screen
                Break NewAzureKeyVaultKey                                                   # Breaks :NewAzureKeyVaultKey
            }                                                                               # End if ($KeyNotBefore)
            else {                                                                          # If $KeyNotBefore is $null
                Try {                                                                       # Try the following
                    Add-AzKeyVaultKey -VaultName $KeyVaultObject.VaultName -Name `
                        $KeyVaultKeyNameInput -Destination $KeyEncryptType `
                        -ErrorAction 'Stop'                                                 # Creates the new key
                }                                                                           # End try
                Catch {                                                                     # If Try fails
                    Write-Host 'An error has occured'                                       # Write message to screen
                    Write-Host 'You may not have the permissions to preform this action'    # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Clear-Host                                                              # Clears screen
                    Break NewAzureKeyVaultKey                                               # Breaks :NewAzureKeyVaultKey
                }                                                                           # End Catch
                Write-Host 'The key has been created'                                       # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Clear-Host                                                                  # Clears screen
                Break NewAzureKeyVaultKey                                                   # Breaks :NewAzureKeyVaultKey
            }                                                                               # End else (if ($KeyNotBefore))
        }                                                                                   # End :NewAzureKeyVaultKey while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function NewAzKeyVaultKey
function AddAzKeyVaultKey {                                                                 # Function to add an existing key to key vault
    Begin {                                                                                 # Begin function
        if (!$CallingFunction) {                                                            # If $CallingFunction does not have a value
            $CallingFunction = 'AddAzKeyVaultKey'                                           # Creates $CallingFunction
        }                                                                                   # End if (!$CallingFunction)
        :AddAzureKeyVaultKey while ($true) {                                                # Outer loop for managing function
            $KeyVaultObject = GetAzKeyVault ($CallingFunction)                              # Calls function and assigns output to $var
            if (!$KeyVaultObject) {                                                         # If $KeyVaultObject is $null
                Break AddAzureKeyVaultKey                                                   # Breaks :AddAzureKeyVaultKey    
            }                                                                               # End if (!$KeyVaultObject)
            :GetLocalDownloadPath while ($true) {                                           # Inner loop for getting the file patch
                Write-Host 'Please provide the path to the key'                             # Write message to screen
                Write-Host 'Example: C:\users\admin\documents\key.pfx'                      # Write message to screen
                $FilePath = Read-Host 'Path to file'                                        # Operator input for the download path
                if ($FilePath -eq 'exit') {                                                 # If $var is equal to 'exit' 
                    Break AddAzureKeyVaultKey                                               # Breaks :AddAzureKeyVaultKey
                }                                                                           # End if ($FilePath -eq 'exit')
                if (Test-Path -Path $FilePath) {                                            # If file exists
                    Write-Host 'Upload: '$FilePath                                          # Write message to screen
                    $OpConfirm = Read-Host '[Y] Yes [N] No'                                 # Operator confirmation to use this file
                    if ($OpConfirm -eq 'y') {                                               # If $OpConfirm equals 'y'
                        :GetKeyPassword while ($true) {                                     # Inner loop for getting key password
                            Write-Host 'Enter the password key'                             # Write message to screen
                            $Password1 = Read-Host 'Password'                               # Operator input for the key password
                            if ($Password1 -eq 'exit') {                                    # If $Password1 equals 'exit'
                                Break AddAzureKeyVaultKey                                   # Breaks :AddAzureKeyVaultKey
                            }                                                               # End if ($Password1 -eq 'exit')
                            $Password2 = Read-Host 'Re-enter to confirm'                    # Operator input to confirm key password
                            if ($Password1 -eq $Password2) {                                # If $Password1 equals $Password2
                                $Password = ConvertTo-SecureString -String $Password1 `
                                -AsPlainText -Force                                         # Creates hashed password
                                Clear-Host                                                  # Clears screen
                                Break GetLocalDownloadPath                                  # Breaks :GetLocalDownloadPath
                            }                                                               # End if ($Password1 -eq $Password2)
                            else {                                                          # If $Password1 does not equal $Password2
                                Write-Host 'Passwords do not match'                         # Write message to screen
                                Pause                                                       # Pauses all actions for operator input
                                Clear-Host                                                  # Clears screen
                            }                                                               # End else (if ($Password1 -eq $Password2))
                        }                                                                   # End :GetKeyPassword while ($true)
                    }                                                                       # End if ($OpConfirm -eq 'y')
                }                                                                           # End if (Test-Path -Path $FilePath)
                else {                                                                      # If file does not exist
                    Write-Host 'The file path:'$FilePath 'is not valid'                     # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Clear-Host                                                              # Clears screen
                }                                                                           # End else (if (Test-Path -Path $FilePath))
            }                                                                               # End :GetLocalDownloadPath while ($true)
            $ValidArray = 'abcdefghijklmnopqrstuvwxyz0123456789'                            # Creates a string of valid characters
            $ValidArray = $ValidArray.ToCharArray()                                         # Loads all valid characters into array    
            :AzureKeyVaultKeyName while ($true) {                                           # Inner loop for setting $KeyVaultKeyObject name
                $KeyVaultKeyNameInput = $null                                               # Clears $KeyVaultKeyNameInput
                Write-Host 'Key name may only include letters and numbers'                  # Write message to screen
                Write-Host 'Key name cannot inlude any spaces'                              # Write message to screen
                Write-Host 'Key name must be less that 64 characters'                       # Write message to screen
                Write-Host ''                                                               # Write message to screen
                $KeyVaultKeyNameInput = Read-Host 'Key name'                                # Operator input for the key name
                $KeyVaultKeyNameArray = $KeyVaultKeyNameInput.ToCharArray()                 # Creates an array from $KeyVaultKeyNameInput 
                if ($KeyVaultKeyNameInput -eq 'exit') {                                     # $KeyVaultKeyNameInput is equal to exit
                    Break AddAzureKeyVaultKey                                               # Breaks :AddAzureKeyVaultkey
                }                                                                           # if ($KeyVaultKeyNameInput -eq 'exit')
                if ($KeyVaultKeyNameInput.Length -ge 64) {                                  # If $KeyVaultKeyNameInput is greater than 63 characters
                    Write-Host 'The key name must be less than 64 characters'               # Write message to screen
                    $KeyVaultKeyNameInput = $null                                           # Clears $KeyVaultKeyNameInput                                   
                }                                                                           # End if ($KeyVaultKeyNameInput.Length -ge 63)
                foreach ($_ in $KeyVaultKeyNameArray) {
                    if ($_ -notin $ValidArray) {                                            # If current item is not in $ValidArray
                        if ($_ -eq ' ') {                                                   # If current item equals 'space'
                            Write-Host ''                                                   # Write message to screen    
                            Write-Host 'Key name cannot include any spaces'                 # Write message to screen
                        }                                                                   # End if ($_ -eq ' ')
                        else {                                                              # If current item is not equal to 'space'
                            Write-Host ''                                                   # Write message to screen    
                            Write-Host $_' is not a valid character'                        # Write message to screen
                        }                                                                   # End else (if ($_ -eq ' '))
                        $KeyVaultKeyNameInput = $null                                       # Clears $VaultNameInput
                    }                                                                       # End if ($_ -notin $ValidArray)
                }                                                                           # End foreach ($_ in $KeyVaultKeyNameArray)
                if (!$KeyVaultKeyNameInput) {                                               # If $KeyVaultNameInput is $null
                    Pause                                                                   # Pauses all action for operator input
                    Clear-Host                                                              # Clears screen
                }                                                                           # End if (!$KeyVaultKeyNameInput)
                else {                                                                      # If $KeyVaultKeyNameInput has a value
                    Write-Host 'Use:' $KeyVaultKeyNameInput 'as key name'                   # Write message to screen
                    $OpConfirm = Read-Host '[Y] Yes [N] No'                                 # Operator confirmation of key name
                    if ($OpConfirm -eq 'y') {                                               # If $OpConfirm is equal to 'y'
                        Clear-Host                                                          # Clears screen
                        Break AzureKeyVaultKeyName                                          # Breaks SetAzureKeyVaultName
                    }                                                                       # End If ($OpConfirm -eq 'y')
                }                                                                           # End else (if (!$KeyVaultKeyNameInput))
            }                                                                               # End :AzureKeyVaultKeyName while ($true)
            Write-Host 'Set an expiration date on this key'                                 # Write message to screen
            $OpSelect = Read-Host '[Y] Yes [N] No [E] Exit'                                 # Operator input for setting a key expiration
            if ($OpSelect -eq 'e') {                                                        # If $OpSelect equals 'e'
                Break AddAzureKeyVaultKey                                                   # Breaks :AddAzureKeyVaultkey
            }                                                                               # End if ($OpSelect -eq 'e')
            if ($OpSelect -eq 'y') {                                                        # If $OpSelect equals 'y'
                :AzureKeyVaultKeyExpire while ($true) {                                     # Inner loop for setting expiration date
                    $StartDate = (Get-Date).Date                                            # Gets current date
                    Write-Host 'Enter the date in the following format: YYYY-MM-DD'         # Write message to screen
                    Write-Host 'Example: 2050-07-04 to have the key expire on 4 July 2050'  # Write message to screen
                    $EndDate = Read-Host 'Key expiration date'                              # Operator input for end date
                    if ($EndDate -eq 'exit') {                                              # If $EndDate equals 'exit'
                        Break AddAzureKeyVaultKey                                           # Breaks :AddAzureKeyVaultKey
                    }                                                                       # End if ($EndDate -eq 'exit')
                    $DateDiff = New-TimeSpan -Start $StartDate -End $EndDate                # Gets count of days between current and end date
                    if (!$DateDiff) {                                                       # If $DateDiff does not have a value (Result of bad $EndDate entry)
                        Write-Host 'The expiration date entry was not valid'                # Write message to screen
                        Write-Host 'Please enter a date in the listed format'               # Write message to screen
                        Pause                                                               # Pauses all actions for operator input
                        Clear-Host                                                          # Clears screen
                    }                                                                       # End if (!$DateDiff)
                    elseif ($DateDiff -le 0) {                                              # $DateDiff is 0 or less
                        Write-Host 'The date entered was not in the future'                 # Write message to screen
                        Write-Host 'Please enter a future date'                             # Write message to screen
                        $DateDiff = $null                                                   # Clears $DateDiff
                        Pause                                                               # Pauses all actions for operator input
                        Clear-Host                                                          # Clears screen
                    }                                                                       # End elseif ($DateDiff -le 0) 
                    elseif ($DateDiff) {                                                    # If $DateDiff has a value of 1 or higher
                        $KeyExpires = (Get-Date).AddDays($DateDiff.Days).ToUniversalTime()  # Sets $KeyExpires to operator selected date
                        $KeyNotBefore = (Get-Date).ToUniversalTime()                        # Sets $KeyNotBefore to current date
                        Clear-Host                                                          # Clears screen
                        Break AzureKeyVaultKeyExpire                                        # Breaks :AzureKeyVaultKeyExpire
                    }                                                                       # End if ($DateDiff)
                }                                                                           # End AzureKeyVaultKeyExpire while ($true)
            }                                                                               # End if ($OpSelect -eq 'y')
            :AzureKeyVaultKeyEncrypt while ($true) {                                        # Inner loop for setting the encyption type
                Write-Host 'Select key encyption type'                                      # Write message to screen
                Write-Host '[0] Exit'                                                       # Write message to screen
                Write-Host '[1] HSM'                                                        # Write message to screen
                Write-Host '[2] Software'                                                   # Write message to screen
                $OpSelect = Read-Host 'Option [#]'                                          # Operator input for encryption type
                if ($OpSelect -eq '0') {                                                    # If $OpSelect equals '0' 
                    Break AddAzureKeyVaultKey                                               # Breaks :AddAzureKeyVaultKey
                }                                                                           # End if ($OpSelect -eq '0')
                elseif ($OpSelect -eq '1') {                                                # Else if $OpSelect equals '1'
                    $KeyEncryptType = 'HSM'                                                 # Sets $KeyEncryptType to 'HSM'
                }                                                                           # End elseif ($OpSelect -eq '1')
                elseif ($OpSelect -eq '2') {                                                # Else if $OpSelect equals '2'
                    $KeyEncryptType = 'Software'                                            # Sets $KeyEncryptType to 'Software'
                    Clear-Host                                                              # Clears screen
                    Break AzureKeyVaultKeyEncrypt                                           # Breaks :AzureKeyVaultKeyEncrypt
                }                                                                           # End elseif ($OpSelect -eq '2')
                else {                                                                      # All other inputs for $OpSelect
                    Write-Host 'That was not a valid option'                                # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Clear-Host                                                              # Clears screen
                    Break AddAzureKeyVaultKey                                               # Breaks :AddAzureKeyVaultKey
                }                                                                           # End else (if ($OpSelect -eq '0'))
                if ($KeyEncryptType -eq 'HSM') {                                            # If $KeyEncryptType is equal to 'HSM'
                    if ($KeyVaultObject.SKU -eq 'Standard') {                               # If $KeyVaultObject.SKU is equal to 'Standard'
                        Write-Host 'HSM is not supported on this key vault'                 # Write message to screen
                        Write-Host '[0] Exit'                                               # Write message to screen
                        Write-Host '[1] Change encryption to software'                      # Write message to screen
                        $OpSelect = Read-Host 'Option [#]'                                  # Operator input on changing type or exiting
                        if ($OpSelect -eq '0') {                                            # If $OpSelect equals '0'
                            Break AddAzureKeyVaultKey                                       # Breaks :AddAzureKeyVaultKey
                        }                                                                   # End if ($OpSelect -eq '0')
                        elseif ($OpSelect -eq '1') {                                        # Else if $OpSelect equals '1'
                            $KeyEncryptType = 'Software'                                    # Sets $KeyEncryptType to 'Software'
                            Clear-Host                                                      # Clears screen
                            Break AzureKeyVaultKeyEncrypt                                   # Breaks :AzureKeyVaultKeyEncrypt
                        }                                                                   # End elseif ($OpSelect -eq '1')
                        else {                                                              # All other inputs for $OpSelect
                            Write-Host 'That was not a valid option'                        # Write message to screen
                            Pause                                                           # Pauses all actions for operator input
                            Clear-Host                                                      # Clears screen
                        }                                                                   # End else (if ($OpSelect -eq '0'))
                    }                                                                       # End if ($KeyVaultObject.Sku -eq 'Standard')
                    else {                                                                  # If $KeyVaultObject.SKU does not equal 'standard'
                        Clear-Host                                                          # Clears screen
                        Break AzureKeyVaultKeyEncrypt                                       # Breaks :AzureKeyVaultKeyEncrypt 
                    }                                                                       # End else (if ($KeyVaultObject.Sku -eq 'Standard'))
                }                                                                           # End elseif ($KeyEncryptType -eq 'HSM')
            }                                                                               # End :AzureKeyVaultKeyEncrypt while ($true)
            if ($KeyNotBefore) {                                                            # If $KeyNotBefore has a value
                Try {                                                                       # Try the following
                    Add-AzKeyVaultKey -VaultName $KeyVaultObject.VaultName -Name `
                        $KeyVaultKeyNameInput -Destination $KeyEncryptType -Expires `
                        $KeyExpires -NotBefore $KeyNotBefore -KeyFilePath $FilePath `
                        -KeyFilePassword $Password -ErrorAction 'Stop'                      # Adds the key
                }                                                                           # End try
                Catch {                                                                     # If Try fails
                    Write-Host 'An error has occured'                                       # Write message to screen
                    Write-Host 'You may not have the permissions to preform this action'    # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Clear-Host                                                              # Clears screen
                    Break AddAzureKeyVaultKey                                               # Breaks :AddAzureKeyVaultKey
                }                                                                           # End Catch
                Write-Host 'The key has been created'                                       # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Clear-Host                                                                  # Clears screen
                Break AddAzureKeyVaultKey                                                   # Breaks :AddAzureKeyVaultKey
            }                                                                               # End if ($KeyNotBefore)
            else {                                                                          # If $KeyNotBefore is $null
                Try {                                                                       # Try the following
                    Add-AzKeyVaultKey -VaultName $KeyVaultObject.VaultName -Name `
                    $KeyVaultKeyNameInput -Destination $KeyEncryptType -KeyFilePath `
                    $FilePath -KeyFilePassword $Password -ErrorAction 'Stop'                # Adds the key
                }                                                                           # End try
                Catch {                                                                     # If Try fails
                    Write-Host 'An error has occured'                                       # Write message to screen
                    Write-Host 'You may not have the permissions to preform this action'    # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Clear-Host                                                              # Clears screen
                    Break AddAzureKeyVaultKey                                               # Breaks :AddAzureKeyVaultKey
                }                                                                           # End Catch
                Write-Host 'The key has been added'                                         # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Clear-Host                                                                  # Clears screen
                Break AddAzureKeyVaultKey                                                   # Breaks :AddAzureKeyVaultKey
            }                                                                               # End else (if ($KeyNotBefore))
        }                                                                                   # End :AddAzureKeyVaultKey while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function AddAzKeyVaultKey
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
function GetAzKeyVaultKey {                                                                 # Function to get a key vault Key
    Begin {                                                                                 # Begin function
        $WarningPreference = "silentlyContinue"                                             # Disables key vault warnings
        $ErrorActionPreference = 'silentlyContinue'                                         # Disables error reporting
        if (!$CallingFunction) {                                                            # If $CallingFunction does not have a value
            $CallingFunction = 'GetAzKeyVaultKey'                                           # Creates $CallingFunction
        }                                                                                   # End if (!$CallingFunction)
        :GetAzureKeyVaultKey while ($true) {                                                # Outer loop for managing function
            $KeyVaultObject = GetAzKeyVault ($CallingFunction)                              # Calls function and assigns output to $var
            if (!$KeyVaultObject) {                                                         # If $KeyVaultObject is $null
                Break GetAzureKeyVaultKey                                                   # Breaks :GetAzureKeyVaultKey    
            }                                                                               # End if (!$KeyVaultObject)
            $Objectlist = Get-AzKeyVaultKey -VaultName $KeyVaultObject.VaultName            # Creates list of all Keys in vault
            if (!$ObjectList) {                                                             # If $ObjectList is empty
                Write-Host 'No Keys found'                                                  # Message write to screen
                Pause                                                                       # Pauses all actions for operator input
                Break GetAzureKeyVaultKey                                                   # Breaks :GetAzureKeyVaultKey
            }                                                                               # End if (!$ObjectList)
            $ObjectNumber = 1                                                               # Sets $ObjectNumber to 1
            [System.Collections.ArrayList]$ObjectArray = @()                                # Creates the object list array
            foreach ($_ in $ObjectList) {                                                   # For each $_ in $ObjectListList
                $ObjectInput = [PSCustomObject]@{'Number' = $ObjectNumber; `
                'Name'=$_.Name;'ID'=$_.Id;'Enabled'=$_.Enabled;'Updated'=$_.Updated; `
                'EXP'=$_.Expires;'NB'=$_.NotBefore}                                         # Creates the item to loaded into array
                $ObjectArray.Add($ObjectInput) | Out-Null                                   # Loads item into array, out-null removes write to screen
                $ObjectNumber = $ObjectNumber + 1                                           # Increments $ObjectNumber by 1
            }                                                                               # End foreach ($_ in $ObjectList)
            Write-Host '[0]  Exit'                                                          # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            foreach ($_ in $ObjectArray) {                                                  # For each $_ in $ObjectArray
                $Number = $_.Number                                                         # Sets $Number to current item .number
                if ($_.Number -le 9) {                                                      # If current item .number is 9 or less
                    Write-Host "[$Number]       "$_.Name                                    # Write message to screen
                }                                                                           # End if ($_.Number -le 9) 
                else {                                                                      # If current item .number is greater then 9
                    Write-Host "[$Number]      "$_.Name                                     # Write message to screen
                }                                                                           # End else (if ($_.Number -le 9))
                Write-Host 'ID:       '$_.ID                                                # Write message to screen
                Write-Host 'Enabled:  '$_.Enabled                                           # Write message to screen
                Write-Host 'Updated:  '$_.Updated                                           # Write message to screen
                if ($_.EXP) {                                                               # If current item .EXP has a value
                    Write-Host 'Expires:  '$_.EXP                                           # Write message to screen
                    Write-Host 'NotBefore:'$_.NB                                            # Write message to screen
                }                                                                           # End if ($_.EXP)
                Write-Host ''                                                               # Write message to screen
            }                                                                               # End foreach ($_ in $ObjectArray)
            :SelectAzureKeyVaultKey foreach ($_ in $ObjectArray) {                          # For each item in $ObjectArray
                if ($CallingFunction -and $CallingFunction -ne 'GetAzKeyVaultKey') {        # If $CallingFunction exists and not equal to 'GetAzKeyVaultKey'
                    Write-Host 'You are selecting the key for:'$CallingFunction             # Write message to screen
                }                                                                           # End if ($CallingFunction)
                $OpSelect = Read-Host 'Enter option[#]'                                     # Operator input for the key selection
                if ($OpSelect -eq '0') {                                                    # If $OpSelect equals 0
                    Break GetAzureKeyVaultKey                                               # Breaks :GetAzureKeyVaultKey
                }                                                                           # End if ($OpSelect -eq '0')
                elseif ($OpSelect -in $ObjectArray.Number) {                                # If $OpSelect in $ObjectArray.Number
                    $OpSelect = $ObjectArray | Where-Object {$_.Number -eq $OpSelect}       # $OpSelect is equal to $ObjectArray where $ObjectArray.Number is equal to $OpSelect                                  
                    $KeyVaultKeyObject = Get-AzKeyVaultKey -VaultName `
                    $KeyVaultObject.VaultName -Name $OpSelect.Name                          # Pulls the full key object
                    Clear-Host                                                              # Clears screen
                    Return $KeyVaultKeyObject, $KeyVaultObject                              # Returns to calling function with $vars
                }                                                                           # End elseif ($RGSelect -in $ListArray.Number)
                else {                                                                      # All other inputs for $OpSelect
                    Write-Host "That was not a valid option"                                # Write message to screen
                    Pause                                                                   # Pauses all action for operator input
                    Clear-Host                                                              # Clears screen
                }                                                                           # End else (if ($OpSelect -eq '0'))
            }                                                                               # End :SelectAzureKeyVaultKey
        }                                                                                   # End :GetAzureKeyVaultKey while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End begin statement
}                                                                                           # End function GetAzKeyVaultKey
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
function RemoveAzKeyVaultKey {                                                              # Function to remove a key vault key
    Begin {                                                                                 # Begin function
        $ErrorActionPreference = 'silentlyContinue'                                         # Disables error reporting
        if (!$CallingFunction) {                                                            # If $CallingFunction does not have a value
            $CallingFunction = 'RemoveAzKeyVaultKey'                                        # Creates $CallingFunction 
        }                                                                                   # End if (!$CallingFunction)
        :RemoveAzureKeyVaultKey while ($true) {
            $KeyVaultKeyObject, $KeyVaultObject = GetAzKeyVaultKey ($CallingFunction)       # Calls function and assigns output to $var
            if (!$KeyVaultKeyObject) {                                                      # If $KeyVaultKeyObject is $null
                Break RemoveAzureKeyVaultKey                                                # Breaks :DownloadAzureKeyVaultKey    
            }                                                                               # End if (!$KeyVaultObject)
            Write-host 'The remove key:'$KeyVaultKeyObject.Name                             # Write message to screen
            Write-Host 'From vault:'    $KeyVaultObject.VaultName                           # Write message to screen
            $OpConfirm = Read-Host '[Y] Yes [N] No'                                         # Operator confirmation for deletion
            if ($OpConfirm -eq 'y') {                                                       # If $OpConfirm is equal to 'y'
                Write-Host 'Removing:' $KeyVaultKeyObject.Name                              # Write message to screen
                Try {                                                                       # Try the following
                    Remove-AzKeyVaultKey -Name $KeyVaultKeyObject.Name -VaultName `
                        $KeyVaultKeyObject.VaultName -Force -ErrorAction 'Stop'             # Removes the selected key
                }                                                                           # End Try
                catch {                                                                     # If Try fails
                    Write-Host 'There was an issue removing the selected key'               # Write message to screen
                    Write-Host 'You may not have the permissions to remove this key'        # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Clear-Host                                                              # Clears screen
                    Break RemoveAzureKeyVaultKey                                            # Breaks :RemoveAzureKeyVaultKey 
                }                                                                           # End catch
                Write-Host 'The Key has been removed'                                       # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Clear-Host                                                                  # Clears screen
                Break RemoveAzureKeyVaultKey                                                # Breaks :RemoveAzureKeyVaultKey
            }                                                                               # End if ($ConfirmDelete -eq 'y')
            else {                                                                          # If $OpConfirm does not equal 'y'
                Write-Host 'No changes have been made'                                      # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Clear-Host                                                                  # Clears screen
                Break RemoveAzureKeyVaultKey                                                # Breaks :RemoveAzureKeyVaultKey
            }                                                                               # End else (if ($ConfirmDelete -eq 'y'))
        }                                                                                   # End :RemoveAzureKeyVaultKey while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to callign function with $null
    }                                                                                       # End Begin
}                                                                                           # End function RemoveAzKeyVaultKey
# Additional functions required for ManageAzKeyVaultKey
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
}                                                                                           # End function GetAzKeyVault