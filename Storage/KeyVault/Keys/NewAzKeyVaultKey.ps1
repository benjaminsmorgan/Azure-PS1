function NewAzKeyVaultKey {
    Begin {
        :NewAzureKeyVaultKey while ($true) {
            if (!$KeyVaultObject) { # If $KeyVaultObject is $null 
                $KeyVaultObject = GetAzKeyVault # Calls function and assigns output to $var
                if (!$KeyVaultObject) { # If $var is still $null
                    Break NewAzureKeyVaultKey # Breaks :NewAzureKeyVaultKey    
                } # End if (!$KeyVaultObject)
            } # End if (!$KeyVaultObject)
            Write-Host $KeyVaultObject.Sku
            :AzureKeyVaultKeyName while ($true) {
                $KeyVaultKeyNameInput = '0' # Assigns a value for elseif statement if operator input is invalid
                try { # Try statement for operator input of vault name
                    [ValidatePattern('^[a-z,0-9]+$')]$KeyVaultKeyNameInput = [string](Read-Host "New key name (less than 64 characters, letters and numbers only)") # Operator input for the vault name, only allows letters and numbers. All letters converted to lowercase
                } # End try
                catch {Write-Host "The vault name can only include letters and numbers"} # Error message for failed try
                if ($KeyVaultKeyNameInput -eq 'exit') { # $KeyVaultKeyNameInput is equal to exit
                    Break NewAzureKeyVaultKey # Breaks NewAzureKeyVault loop
                } # if ($KeyVaultKeyNameInput -eq 'exit')
                elseif ($KeyVaultKeyNameInput.Length -ge 64) { # If $KeyVaultKeyNameInput is greater than 63 characters
                    Write-Host "The vault name must be between 3 and 24 characters in length" # Write message to screen
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
            if ($KeyExpiration -eq 'y'){
                :AzureKeyVaultKeyExpire while ($true) {
                    $StartDate = (Get-Date).Date
                    $EndDate = Read-Host 'Key expiration date: YEAR-MO-DY'
                    if ($EndDate -eq 'exit') {
                        Break NewAzureKeyVaultKey
                    }
                    $DateDiff = New-TimeSpan -Start $StartDate -End $EndDate
                    if (!$DateDiff) {
                        Write-Host "The expiration date entry was not valid"
                        Write-Host "Please enter a date in the listed format"
                    }
                    elseif ($DateDiff -le 0) {
                        Write-Host "The date entered was not in the future"
                        Write-Host "Please enter a future date"
                        $DateDiff = $null
                    }
                    elseif ($DateDiff) {
                        $KeyExpires = (Get-Date).AddDays($DateDiff.Days).ToUniversalTime()
                        $KeyNotBefore = (Get-Date).ToUniversalTime()
                        Break AzureKeyVaultKeyExpire
                    } # End if ($DateDiff)
                } # End AzureKeyVaultKeyExpire while ($true)
            } # End if ($KeyExpiration -eq 'y')
            :AzureKeyVaultKeyEncrypt while ($true) {
                $KeyEncrypttype = Read-Host "[HSM] or [Software]"
                if ($KeyEncrypttype -eq 'exit') {
                    Break NewAzureKeyVaultKey
                }
                elseif ($KeyEncrypttype -eq 'HSM') {
                    if ($KeyVaultObject.SKU -eq 'Standard') {
                        Write-Host "HSM is not supported on this key vault"
                        Write-Host "Please enter 'Software' if this vault is used"
                        Write-Host "Otherwise, enter 'exit' to leave this function"
                    } # End if ($KeyVaultObject.Sku -eq 'Standard')
                    else {
                        Break AzureKeyVaultKeyEncrypt
                    }
                } # End elseif ($KeyEncrypttype -eq 'HSM')
                elseif ($KeyEncrypttype -like 'Soft*') {
                    $KeyEncrypttype = 'Software'
                    Break AzureKeyVaultKeyEncrypt
                } # End elseif ($KeyEncrypttype -like 'Soft*')
                else {
                    Write-Host "That was not a valid input"
                }
            } # End :AzureKeyVaultKeyEncrypt while ($true)
            if ($KeyNotBefore) {
                $KeyVaultKeyObject = Add-AzKeyVaultKey -VaultName $KeyVaultObject.VaultName -Name $KeyVaultKeyNameInput -Destination $KeyEncrypttype -Expires $KeyExpires -NotBefore $KeyNotBefore
                Return $KeyVaultKeyObject
            }
            else {
                $KeyVaultKeyObject = Add-AzKeyVaultKey -VaultName $KeyVaultObject.VaultName -Name $KeyVaultKeyNameInput -Destination $KeyEncrypttype
                Return $KeyVaultKeyObject
            }
        } # End :NewAzureKeyVaultKey while ($true)
        Return # Returns with $null
    } # End Begin
} # End function NewAzKeyVaultKey
function GetAzKeyVault { # Collects a key vault object
    Begin {
        $ErrorActionPreference = 'silentlyContinue' # Disables error reporting
        :GetAzureKeyVault while ($true) { # Outer loop for managing function
            if (!$RGObject) { # If $RGObject is empty
                $RGObject = GetAzResourceGroup # Calls function and assigns output to $var
                if (!$RGObject) { # If $RGObject is still empty after returning
                    Break GetAzureKeyVault # Breaks :GetAzureKeyVault
                } # End if (!$RGObject)
            } # End if (!$RGObject)
            $KVList = Get-AzKeyVault -ResourceGroupName $RGObject.ResourceGroupName # Gets all key vaults in resource group and assigns to $KVList
            if (!$KVList) { # If $KVList returns empty
                Write-Host "No key vaults found" # Message write to screen
                Break GetAzureKeyVault # Breaks :GetAzureKeyVault
            } # End if (!$KVList)
            $KVListNumber = 1 # Sets the base value of the list
            Write-Host "0. Exit" # Adds exit option to beginning of list
            foreach ($_ in $KVList) { # For each item in list
                Write-Host $KVListNumber"." $_.VaultName # Writes the option number and key vault name
                $KVListNumber = $KVListNumber+1 # Adds 1 to $KVListNumber
            } # End foreach ($_ in $KVList)
            :SelectAzureKeyVault while ($true) { # Loop for selecting the key vault object
                $KVListNumber = 1 # Resets list number to 1
                $KVListSelect = Read-Host "Enter the option number" # Operator input for selecting which key vault
                if ($KVListSelect -eq '0') { # If $KVListSelect is equal to 0
                    Break GetAzureKeyVault # Breaks :GetAzureKeyVault
                } # End if ($KVListSelect -eq '0')
                foreach ($_ in $KVList) { # For each item in list
                    if ($KVListSelect -eq $KVListNumber) { # If the operator input matches the current $KVListNumber
                        $KeyVaultObject = Get-AzKeyVault -VaultName $_.VaultName # Currently selected item in $KVList is assigned to $KeyVaultObject
                        Break SelectAzureKeyVault # Breaks :SelectAzureKeyVault
                    } # End if ($KVListSelect -eq $KVListNumber)
                    else { # If user input does not match the current $KVListNumber
                        $KVListNumber = $KVListNumber+1 # Adds 1 to $KVListNumber
                    } # End else (if ($KVListSelect -eq $KVListNumber))
                } # End foreach ($_ in $KVList)
                Write-Host "That was not a valid selection, please try again" # Write message to screen
            } # End :SelectAzureKeyVault while ($true)
            Return $KeyVaultObject # Returns $RGObject to calling function
        } # End :GetAzureKeyVault while ($true)
        Return # Returns to calling function with $null
    } # End Begin
} # End function GetAzKeyVault