# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Mircosoft docs links
    Add-AzKeyVaultKey:          https://docs.microsoft.com/en-us/powershell/module/az.keyvault/add-azkeyvaultkey?view=azps-5.4.0
    Get-AzKeyVault:             https://docs.microsoft.com/en-us/powershell/module/az.keyvault/get-azkeyvault?view=azps-5.1.0
    Get-AzResourceGroup:        https://docs.microsoft.com/en-us/powershell/module/az.resources/get-azresourcegroup?view=azps-5.1.0
} #>
<# Required Functions Links: {
    GetAzKeyVault:              https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Storage/KeyVault/GetAzKeyVault.ps1
} #>
<# Functions Description: {
    NewAzKeyVaultKey:           Creates a new key vault key
    GetAzKeyVault:              Gets key vault object
} #>
<# Variables: { 
    :NewAzureKeyVaultKey        Outer loop for managing function
    :AzureKeyVaultKeyName       Inner loop for validating and setting $KeyVaultKeyObject name
    :AzureKeyVaultKeyExpire     Inner loop for setting expiration date
    :AzureKeyVaultKeyEncrypt    Inner loop for setting the encyption type
    $CallingFunction:           Name of this function or the one that called it
    $KeyVaultObject:            Key vault object
    $ValidArray:                Array of valud characters to key name
    $KeyVaultKeyNameInput:      Operator input for the key name 
    $KeyVaultKeyNameArray:      $KeyVaultKeyNameInput converted to array
    $OpConfirm:                 Operator confirmation of the keyment
    $KeyExpiration:             Operator input if key will have an expiration
    $StartDate:                 Gets current date
    $EndDate:                   Operator input for end date
    $DateDiff:                  Gets count of days between current and end date
    $KeyExpires:                Key expiration date
    $KeyNotBefore:              Key valid start date
    $OpSelect:                  Operator input for the key encryption type
    $KeyEncryptType:            Key encryption type
    GetAzKeyVault{}             Gets $KeyVaultSecret
} #>
<# Process Flow {
    Function
        Call NewAzKeyVaultKey > Get $null
            Call GetAzKeyVault > Get $KeyVaultObject
            End GetAzKeyVault
                Return NewAzKeyVaultKey > Send $KeyVaultObject  
        End NewAzKeyVaultKey
            Return Function > Send $null
}#>
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