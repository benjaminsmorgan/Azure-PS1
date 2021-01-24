# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Mircosoft docs links
    Add-AzKeyVaultKey:          https://docs.microsoft.com/en-us/powershell/module/az.keyvault/add-azkeyvaultkey?view=azps-5.4.0
    Get-AzKeyVault:             https://docs.microsoft.com/en-us/powershell/module/az.keyvault/get-azkeyvault?view=azps-5.1.0
    Get-AzResourceGroup:        https://docs.microsoft.com/en-us/powershell/module/az.resources/get-azresourcegroup?view=azps-5.1.0
} #>
<# Required Functions Links: {
    GetAzKeyVault:              https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Storage/KeyVault/GetAzKeyVault.ps1
        GetAzResourceGroup:         https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/GetAzResourceGroup.ps1
} #>
<# Functions Description: {
    AddAzKeyVaultKey:           Uploads an existing key into key vault
    GetAzKeyVault:              Gets key vault object
    GetAzResourceGroup:         Gets resource group object
} #>
<# Variables: {
    :AddAzureKeyVaultKey        Outer loop for managing function
    :GetLocalDownloadPath       Inner loop for getting the file patch
    :GetLocalFileName           Inner loop for getting the key local name
    :AzureKeyVaultKeyName       Inner loop for validating and setting $KeyVaultKeyObject name
    :AzureKeyVaultKeyExpire     Inner loop for setting expiration date
    :AzureKeyVaultKeyEncrypt    Inner loop for setting the encyption type
    $LocalPath:                 The local path to $LocalFileName
    $LocalFileName:             The local key to be imported
    $Fullpath:                  Combination of $LocalPath and $LocalFileName 
    $RGObject:                  Resource group object
    $KeyVaultObject:            Key vault object
    $KeyVaultKeyNameInput:      Operator input for the key name 
    $OperatorConfirm:           Operator confirmation
    $KeyExpiration:             Operator input if key will have an expiration
    $StartDate:                 Gets current date
    $EndDate:                   Operator input for end date
    $DateDiff:                  Gets count of days between current and end date
    $KeyExpires:                Key expiration date
    $KeyNotBefore:              Key valid start date
    $KeyEncryptType:            Operator input for the key encryption type
    $KeyVaultKeyObject:         Key vault key
    GetAzKeyVault{}             Gets $KeyVaultSecret
        GetAzResourceGroup{}        Gets $RGObject
} #>
<# Process Flow {
    Function
        Call AddAzKeyVaultKey > Get $KeyVaultSecretObject
            Call GetAzKeyVault > Get $KeyVaultObject
                Call GetAzResourceGroup > Get $RGObject
                End GetAzResourceGroup
                    Return GetAzKeyVault > Send $RGObject
            End GetAzKeyVault
                Return AddAzKeyVaultKey > Send $KeyVaultObject  
        End AddAzKeyVaultKey
            Return Function > Send $KeyVaultSecretObject
}#>
function AddAzKeyVaultKey {
    Begin {
        :AddAzureKeyVaultKey while ($true) { # Outer loop for managing function
            if (!$KeyVaultObject) { # If $KeyVaultObject is $null 
                $KeyVaultObject = GetAzKeyVault # Calls function and assigns output to $var
                if (!$KeyVaultObject) { # If $var is still $null
                    Break AddAzureKeyVaultKey # Breaks :AddAzureKeyVaultKey    
                } # End if (!$KeyVaultObject)
            } # End if (!$KeyVaultObject)
            :GetLocalDownloadPath while ($true) { # Inner loop for getting the file patch
                $LocalPath = Read-Host "Please enter the file path (E.X. C:\Users\Admin\Downloads\)" # Operator input for the download path
                if ($LocalPath -eq 'exit') { # If $var is equal to 'exit' 
                    Break AddAzureKeyVaultKey # Breaks :AddAzureKeyVaultKey
                } # End if ($LocalPath -eq 'exit')
                if ($LocalPath -notlike '*\') { # If $LocalPath does not end with \
                    Write-Host "The path is not valid" # Write message to screen
                    Write-Host "Please re-enter the path" # Write message to screen
                } # End if ($LocalPath -notlike '*\')
                else { # If $LocalPath ends with \
                    Break GetLocalDownloadPath # Breaks :GetLocalDownloadPath
                } # End else (if ($LocalPath -notlike '*\'))
            } # End :GetLocalDownloadPath while ($true)
            :GetLocalFileName while ($true) { # Inner loop for getting the key local name
                $LocalFileName = Read-Host "Enter the key name and extension (E.X. Key.pfx)" # Operator input for the key name
                if ($LocalFileName -eq 'exit') { # If $var is equal to 'exit'
                    Break AddAzureKeyVaultKey # Breaks :AddAzureKeyVaultKey
                } # End if ($LocalFileName -eq 'exit')
                #$LocalfileName = $LocalFileName+'.pem' # Adds .pem to file name
                Write-Host $LocalFileName # Write message to screen
                $OperatorConfirm = Read-Host "Use this file name [Y] or [N]" # Operator confirmation of file name
                if ($OperatorConfirm -eq 'y') { # If $OperatorConfirm equals 'y'
                    Break GetLocalFileName # Breaks :GetLocalFileName
                } # End if ($OperatorConfirm -eq 'y')
            } # End :GetLocalFileName while ($true)
            $Fullpath = $LocalPath+$LocalFileName # Creates the full file path and name $var
            :AzureKeyVaultKeyName while ($true) { # Inner loop for validating and setting $KeyVaultKeyObject name
                $KeyVaultKeyNameInput = '0' # Assigns a value for elseif statement if operator input is invalid
                try { # Try statement for operator input of key name
                    [ValidatePattern('^[a-z,0-9]+$')]$KeyVaultKeyNameInput = [string](Read-Host "New key name (less than 64 characters, letters and numbers only)") # Operator input for the key name, only allows letters and numbers. 
                } # End try
                catch {Write-Host "The key name can only include letters and numbers"} # Error message for failed try
                if ($KeyVaultKeyNameInput -eq 'exit') { # $KeyVaultKeyNameInput is equal to exit
                    Break AddAzureKeyVaultKey # Breaks NewAzureKeyVault loop
                } # if ($KeyVaultKeyNameInput -eq 'exit')
                elseif ($KeyVaultKeyNameInput.Length -ge 64) { # If $KeyVaultKeyNameInput is greater than 63 characters
                    Write-Host "The key name must be between 1 and 63 characters in length" # Write message to screen
                    $KeyVaultKeyNameInput = '0' # Assigns a value for elseif statement if operator input is invalid
                } # End elseif ($KeyVaultKeyNameInput.Length -ge 63
                elseif ($KeyVaultKeyNameInput -eq '0') {}# Elseif when Try statement fails)
                else { # If Try statement input has value not equal to exit
                    Write-Host $KeyVaultKeyNameInput # Writes $var to screen
                    $OperatorConfirm = Read-Host "Is this name correct [Y] or [N]" # Operator confirmation
                    if ($OperatorConfirm -eq 'y' -or $OperatorConfirm -eq 'yes') { # If $OperatorConfirm is equal to 'y' or 'yes'
                        Break AzureKeyVaultKeyName # Breaks SetAzureKeyVaultName
                    } # End If ($OperatorConfirm -eq 'y' -or $OperatorConfirm -eq 'yes')
                    else {} # If $OperatorConfirm is not -eq 'y' or 'yes;
                } # End else (if ($KeyVaultKeyNameInput -eq 'exit'))
            } # End :AzureKeyVaultKeyName while ($true)
            $KeyNotBefore = $null # Clears all previous uses of this $var
            $KeyExpiration = Read-Host "Set key expiration [Y] or [N]"
            if ($KeyExpiration -eq 'y') { # If $KeyExpiration equals 'y'
                :AzureKeyVaultKeyExpire while ($true) { # Inner loop for setting expiration date
                    $StartDate = (Get-Date).Date # Gets current date
                    $EndDate = Read-Host 'Key expiration date: YEAR-MO-DY' # Operator input for end date
                    if ($EndDate -eq 'exit') { # If $EndDate equals 'exit'
                        Break AddAzureKeyVaultKey # Breaks :NewAzureKeyVaultKey
                    } # End if ($EndDate -eq 'exit')
                    $DateDiff = New-TimeSpan -Start $StartDate -End $EndDate # Gets count of days between current and end date
                    if (!$DateDiff) { # If $DateDiff does not have a value (Result of bad $EndDate entry)
                        Write-Host "The expiration date entry was not valid" # Write message to screen
                        Write-Host "Please enter a date in the listed format" # Write message to screen
                    } # End if (!$DateDiff)
                    elseif ($DateDiff -le 0) { # $DateDiff is 0 or less
                        Write-Host "The date entered was not in the future" # Write message to screen
                        Write-Host "Please enter a future date" # Write message to screen
                        $DateDiff = $null # Clears all previous uses of this $var
                    } # End elseif ($DateDiff -le 0) 
                    elseif ($DateDiff) { # If $DateDiff has a value of 1 or higher
                        $KeyExpires = (Get-Date).AddDays($DateDiff.Days).ToUniversalTime() # Sets $KeyExpires to operator selected date
                        $KeyNotBefore = (Get-Date).ToUniversalTime() # Sets $KeyNotBefore to current date
                        Break AzureKeyVaultKeyExpire # Breaks :AzureKeyVaultKeyExpire
                    } # End if ($DateDiff)
                } # End AzureKeyVaultKeyExpire while ($true)
            } # End if ($KeyExpiration -eq 'y')
            :AzureKeyVaultKeyEncrypt while ($true) { # Inner loop for setting the encyption type
                $KeyEncryptType = Read-Host "[HSM] or [Software]" # Operator input for the key encryption type
                if ($KeyEncryptType -eq 'exit') { # If $KeyEncryptType is equal to 'exit'
                    Break AddAzureKeyVaultKey # Breaks :NewAzureKeyVaultKey
                } # End if ($KeyEncryptType -eq 'exit')
                elseif ($KeyEncryptType -eq 'HSM') { # If $KeyEncryptType is equal to 'HSM'
                    if ($KeyVaultObject.SKU -eq 'Standard') { # If $KeyEncryptType is equal to 'HSM' and $KeyVaultObject.SKU is equal to 'Standard'
                        Write-Host "HSM is not supported on this key vault" # Write message to screen
                        Write-Host "Please enter 'Software' if this vault is used" # Write message to screen
                        Write-Host "Otherwise, enter 'exit' to leave this function" # Write message to screen
                    } # End if ($KeyVaultObject.Sku -eq 'Standard')
                    else { # If $KeyVaultObject.SKU does not equal 'standard'
                        Break AzureKeyVaultKeyEncrypt # Breaks :AzureKeyVaultKeyEncrypt 
                    } # End else (if ($KeyVaultObject.Sku -eq 'Standard'))
                } # End elseif ($KeyEncryptType -eq 'HSM')
                elseif ($KeyEncryptType -like 'Soft*') { # If $KeyEncryptType is equal to 'Soft*'
                    $KeyEncryptType = 'Software' # Sets $KeyEncryptType to 'Software'
                    Break AzureKeyVaultKeyEncrypt # Breaks :AzureKeyVaultKeyEncrypt
                } # End elseif ($KeyEncryptType -like 'Soft*')
                else { # If $KeyEncryptType is not HSM or Software
                    Write-Host "That was not a valid input" # Write message to screen
                } # End ese (if ($KeyEncryptType -eq 'exit'))
            } # End :AzureKeyVaultKeyEncrypt while ($true)
            if ($KeyNotBefore) { # If $KeyNotBefore has a value
                $KeyVaultKeyObject = Add-AzKeyVaultKey -VaultName $KeyVaultObject.VaultName -Name $KeyVaultKeyNameInput -Destination $KeyEncryptType -Expires $KeyExpires -NotBefore $KeyNotBefore -KeyFilePath $Fullpath # Creates the new key and assgins object to #var
                Return $KeyVaultKeyObject # Returns to calling function with $KeyVaultKeyObject
            } # End if ($KeyNotBefore)
            else { # If $KeyNotBefore is $null
                $KeyVaultKeyObject = Add-AzKeyVaultKey -VaultName $KeyVaultObject.VaultName -Name $KeyVaultKeyNameInput -Destination $KeyEncryptType -KeyFilePath $Fullpath # Creates the new key and assgins object to #var
                Return $KeyVaultKeyObject # Returns to calling function with $KeyVaultKeyObject
            } # End else (if ($KeyNotBefore))
        } # End :AddAzureKeyVaultKey while ($true)
        Return # Returns with $null
    } # End Begin
} # End function AddAzKeyVaultKey