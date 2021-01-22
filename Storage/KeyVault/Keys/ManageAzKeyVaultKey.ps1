# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Mircosoft docs links
    Get-AzKeyVaultKey:          TBD
    Add-AzKeyVaultKey:          https://docs.microsoft.com/en-us/powershell/module/az.keyvault/add-azkeyvaultkey?view=azps-5.4.0
    Remove-AzKeyVaultKey:       TBD
    Get-AzKeyVault:             https://docs.microsoft.com/en-us/powershell/module/az.keyvault/get-azkeyvault?view=azps-5.1.0
    Get-AzResourceGroup:        https://docs.microsoft.com/en-us/powershell/module/az.resources/get-azresourcegroup?view=azps-5.1.0
} #>
<# Required Functions Links: {
    NewAzKeyVaultKey:           TBD
    AddAzKeyVaultKey:           TBD
    ListAzKeyVaultKey:          TBD
    GetAzKeyVaultKey:           TBD
    DownloadAzKeyVaultKey:      TBD
    RemoveAzKeyVaultKey:        TBD
    GetAzKeyVault:              https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Storage/KeyVault/GetAzKeyVault.ps1
        GetAzResourceGroup:         https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/GetAzResourceGroup.ps1
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
    GetAzResourceGroup:         Gets resource group object
} #>
<# Variables: {
    :ManageAzureKeyVaultKey     Outer loop for managing function
    $ManageAzKeyVaultKeySel:    Additional azure object needed to get main object
    $RGObject:                  Resource group object
    $KeyVaultObject:            Key vault object
    $KeyVaultKeyObject:         Key vault Key object
    NewAzKeyVaultKey{}          Creates $KeyVaultKeyObject
        GetAzKeyVault{}             Gets $KeyVaultKey
            GetAzResourceGroup{}        Gets $RGObject
    AddAzKeyVaultKey{}          Creates $KeyVaultKeyObject
        GetAzKeyVault{}             Gets $KeyVaultKey
            GetAzResourceGroup{}        Gets $RGObject
    ListAzKeyVaultKey{}         Lists all Keys in subscription
    GetAzKeyVaultKey{}          Gets $KeyVaultKeyObject
        GetAzKeyVault{}             Gets $KeyVaultObject
            GetAzResourceGroup{}        Gets $RGObject 
    DownloadAzKeyVaultKey{      Downloads $KeyVaultKeyObject
        GetAzKeyVaultKey{}          Gets $KeyVaultKeyObject
            GetAzKeyVault{}             Gets $KeyVaultObject
                GetAzResourceGroup{}        Gets $RGObject   
    RemoveAzKeyVaultKey{}       Removes $KeyVaultKeyObject
        GetAzKeyVaultKey{}          Gets $KeyVaultKeyObject
            GetAzKeyVault{}             Gets $KeyVaultObject
                GetAzResourceGroup{}        Gets $RGObject   
} #>
<# Process Flow {
    Function
        Call ManageAzKeyVaultKey > Get $KeyVaultKeyObject
            Call NewAzKeyVaultKey > Get $KeyVaultKeyObject
                Call GetAzKeyVault > Get $KeyVaultObject
                    Call GetAzResourceGroup > Get $RGObject
                    End GetAzResourceGroup
                        Return GetAzKeyVault > Send $RGObject
                End GetAzKeyVault
                    Return NewAzKeyVaultKey > Send $KeyVaultObject  
            End NewAzKeyVaultKey
                Return ManageAzKeyVaultKey > Send $KeyVaultKeyObject
            Call AddAzKeyVaultKey > Get $KeyVaultKeyObject
                Call GetAzKeyVault > Get $KeyVaultObject
                    Call GetAzResourceGroup > Get $RGObject
                    End GetAzResourceGroup
                        Return GetAzKeyVault > Send $RGObject
                End GetAzKeyVault
                    Return AddAzKeyVaultKey > Send $KeyVaultObject  
            End AddAzKeyVaultKey
                Return ManageAzKeyVaultKey > Send $KeyVaultKeyObject
            Call ListAzKeyVaultKey > Get $null
            End ListAzKeyVaultKey
                Return ManageAzKeyVaultKey > Send $null          
            Call GetAzKeyVaultKey > Get $KeyVaultKeyObject
                Call GetAzKeyVault > Get $KeyVaultObject
                    Call GetAzResourceGroup > Get $RGObject
                    End GetAzResourceGroup
                        Return GetAzKeyVault > Send $RGObject
                End GetAzKeyVault
                    Return GetAzKeyVaultKey > Send $KeyVaultObject
            End GetAzKeyVaultKey 
                Return ManageAzKeyVaultKey> Send $KeyVaultKeyObject            
            Call RemoveAzKeyVaultKey > Get $null
                Call GetAzKeyVaultKey > Get $KeyVaultKeyObject
                    Call GetAzKeyVault > Get $KeyVaultObject
                        Call GetAzResourceGroup > Get $RGObject
                        End GetAzResourceGroup
                            Return GetAzKeyVault > Send $RGObject
                    End GetAzKeyVault
                        Return GetAzKeyVaultKey > Send $KeyVaultObject
                End GetAzKeyVaultKey
                    Return RemoveAzKeyVaultKey > Send $KeyVaultKeyObject  
            End RemoveAzKeyVaultKey
                Return ManageAzKeyVaultKey > Send $null   
        End ManageAzKeyVaultKey
            Return Function > Send $KeyVaultKeyObject
}#>
function ManageAzKeyVaultKey { # Script for managing Azure
    Begin {
        :ManageAzureKeyVaultKey while ($true) { # Outer loop for managing function
            if ($RGObject) { # If $RGObject has a value
                Write-Host '$RGObject:' $RGObject.ResourceGroupName # Write message to screen 
            } # End if ($RGObject)
            if ($KeyVaultObject) { # If $KeyVaultObject has a value
                Write-Host '$KeyVaultObject:' $KeyVaultObject.VaultName # Write message to screen
            } # End if ($KeyVaultObject)
            if ($KeyVaultKeyObject) { # If $KeyVaultObjectKey has a value
                Write-Host '$KeyVaultObjectKey:' $KeyVaultKeyObject.Name # Write message to screen
            } # End if ($KeyVaultKeyObject)
            if ($RGObject -or $KeyVaultObject -or $KeyVaultKeyObject) { # If $RGObject, $KeyVaultObject, or $KeyVaultKeyObject has a value
                Write-Host '0 to clear $RGObject, $KeyVaultObject $KeyVaultKeyObject' # Write message to screen
            } # End if ($RGObject -or $KeyVaultObject)
            Write-Host "1 New Key Vault Key" # Write message to screen
            Write-Host "2 Add Key Vault Key" # Write message to screen
            Write-Host "3 List All Key Vaults Key" # Write message to screen
            Write-Host "4 Get Key Vault Key" # Write message to screen
            Write-Host "5 Download Key Vault Key" # Write message to screen
            Write-Host "6 Remove Key Vault Key" # Write message to screen
            Write-Host "'Exit' to end script" # Write option list to screen
            $ManageAzKeyVaultKeySel = Read-Host "Chose option" # Operator input for which option they need to run
            if ($ManageAzKeyVaultKeySel -eq '1') { # Elseif statement for option 1
                Write-Host "New Key Vault Keys" # Option selection write to screen
                $KeyVaultKeyObject = NewAzKeyVaultKey ($RGObject, $KeyVaultObject) # Calls function NewAzKeyVaultKey
            } # End if statement
            elseif ($ManageAzKeyVaultKeySel -eq '2') { # Elseif statement for option 2
                Write-Host "Add Key Vault Key" # Option selection write to screen
                ListAzKeyVaultKey # Calls function ListAzKeyVaultKey
            } # End elseif statement
            elseif ($ManageAzKeyVaultKeySel -eq '3') { # Elseif statement for option 3
                Write-Host "List All Key Vaults Keys" # Option selection write to screen
                ListAzKeyVaultKey # Calls function ListAzKeyVaultKey
            } # End elseif statement
            elseif ($ManageAzKeyVaultKeySel -eq '4') { # Elseif statement for option 4
                Write-Host "Get Key Vault Key" # Option selection write to screen
                $KeyVaultKeyObject = GetAzKeyVaultKey ($RGObject, $KeyVaultObject) # Calls function GetAzKeyVaultKey
                $KeyVaultKeyObject
            } # End elseif statement
            elseif ($ManageAzKeyVaultKeySel -eq '5') { # Elseif statement for option 5
                Write-Host "Download Key Vault Key" # Option selection write to screen
                DownloadAzKeyVaultKey ($RGObject, $KeyVaultObject, $KeyVaultKeyObject) # Calls function DownloadAzKeyVaultKey
            } # End elseif statement
            elseif ($ManageAzKeyVaultKeySel -eq '6') { # Elseif statement for option 6
                Write-Host "Remove Key Vault Key" # Option selection write to screen
                RemoveAzKeyVaultKey ($RGObject, $KeyVaultObject) # Calls function RemoveAzKeyVaultKey
            } # End elseif statement
            elseif ($ManageAzKeyVaultKeySel -eq '0') { # Elseif statement for option 0
                $RGObject = $null # Sets $var to $null
                $KeyVaultObject = $null # Sets $var to $null
                $KeyVaultKeyObject = $null # Sets $var to $null
                Write-Host '$RGObject, $KeyVaultObject, and $KeyVaultKey have been cleared'
            } # End elseif ($ManageAzKeyVaultKeySel -eq '0')
            elseif ($ManageAzKeyVaultKeySel -eq 'exit') { # Elseif statement for ending the srcipt
                Break ManageAzureKeyVaultKey # Breaks :ManageAzureKeyVaultKey
            } # End elseif statement
            else { # Esle statement for all other values
                Write-Host "Invalid option" # Option selection write to screen
            } # End else statement
         } # End :ManageAzureKeyVaultKey while ($true)
        Return # Returns to calling function with $null
    } # End begin statemnt
} # End ManageAzKeyVaultKey
function NewAzKeyVaultKey { # Creates a new $KeyVaultKeyObject
    Begin {
        :NewAzureKeyVaultKey while ($true) { # Outer loop for managing function
            if (!$KeyVaultObject) { # If $KeyVaultObject is $null 
                $KeyVaultObject = GetAzKeyVault # Calls function and assigns output to $var
                if (!$KeyVaultObject) { # If $var is still $null
                    Break NewAzureKeyVaultKey # Breaks :NewAzureKeyVaultKey    
                } # End if (!$KeyVaultObject)
            } # End if (!$KeyVaultObject)
            :AzureKeyVaultKeyName while ($true) { # Inner loop for validating and setting $KeyVaultKeyObject name
                $KeyVaultKeyNameInput = '0' # Assigns a value for elseif statement if operator input is invalid
                try { # Try statement for operator input of key name
                    [ValidatePattern('^[a-z,0-9]+$')]$KeyVaultKeyNameInput = [string](Read-Host "New key name (less than 64 characters, letters and numbers only)") # Operator input for the key name, only allows letters and numbers. 
                } # End try
                catch {Write-Host "The key name can only include letters and numbers"} # Error message for failed try
                if ($KeyVaultKeyNameInput -eq 'exit') { # $KeyVaultKeyNameInput is equal to exit
                    Break NewAzureKeyVaultKey # Breaks NewAzureKeyVault loop
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
                        Break NewAzureKeyVaultKey # Breaks :NewAzureKeyVaultKey
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
                    Break NewAzureKeyVaultKey # Breaks :NewAzureKeyVaultKey
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
                $KeyVaultKeyObject = Add-AzKeyVaultKey -VaultName $KeyVaultObject.VaultName -Name $KeyVaultKeyNameInput -Destination $KeyEncryptType -Expires $KeyExpires -NotBefore $KeyNotBefore # Creates the new key and assgins object to #var
                Return $KeyVaultKeyObject # Returns to calling function with $KeyVaultKeyObject
            } # End if ($KeyNotBefore)
            else { # If $KeyNotBefore is $null
                $KeyVaultKeyObject = Add-AzKeyVaultKey -VaultName $KeyVaultObject.VaultName -Name $KeyVaultKeyNameInput -Destination $KeyEncryptType # Creates the new key and assgins object to #var
                Return $KeyVaultKeyObject # Returns to calling function with $KeyVaultKeyObject
            } # End else (if ($KeyNotBefore))
        } # End :NewAzureKeyVaultKey while ($true)
        Return # Returns with $null
    } # End Begin
} # End function NewAzKeyVaultKey
function AddAzKeyVaultKey {
    Begin {
        Write-Host "Under Development"
        Return
    } # End Begin
} # End function AddAzKeyVaultKey
function ListAzKeyVaultKey { # Lists all key vault Keys
    Begin {
        $KVList = Get-AzKeyVault # Creates lists of all key vaults
        foreach ($VaultName in $KVList) { # For each key vault in $KVList
            Write-Host "-----------------------------------" # Write message to screen
            $KVKeylist = Get-AzKeyVaultKey -VaultName $VaultName.VaultName # Creates a list of all keys in current $VaultName
            Write-Host "Vault Name: " $VaultName.VaultName # Write message to screen
            Write-Host "" # Write message to screen
            foreach ($Name in $KVKeylist) { # For each Key name in $KVKeyList
                Write-Host "Key Name:   " $Name.Name # Write message to screen
                Write-Host "Key ID:     " $Name.ID
                Write-Host "Enabled:    " $Name.Enabled # Write message to screen
                Write-Host "Updated:    " $Name.Updated # Write message to screen
                if ($Name.Expires) { # If Selected key has an existing expiration
                    Write-Host "Expires:    " $Name.Expires # Write message to screen
                    Write-Host "NotBefore:  " $Name.NotBefore
                } # End if ($Name.Expires)
                Write-Host "" # Write message to screen
            } # End foreach ($Name in $KVKeylist)
        } # End foreach ($VaultName in $KVList)
        Write-Host "-----------------------------------" # Write message to screen
        Return # Retures to calling function with $null
    } # End Begin 
} # End function ListAzKeyVaultKey
function GetAzKeyVaultKey { # Function to get a key vault Key
    Begin {
        $WarningPreference = "silentlyContinue" # Disables key vault warnings
        $ErrorActionPreference = 'silentlyContinue' # Disables error reporting
        :GetAzureKeyVaultKey while ($true) { # Outer loop for managing function
            if (!$KeyVaultObject) { # If $KeyVaultObject is $null 
                $KeyVaultObject = GetAzKeyVault # Calls function and assigns output to $var
                if (!$KeyVaultObject) { # If $var is still $null
                    Break GetAzureKeyVaultKey # Breaks :GetAzureKeyVaultKey    
                } # End if (!$KeyVaultObject)
            } # End if (!$KeyVaultObject)
            $KVKeylist = Get-AzKeyVaultKey -VaultName $KeyVaultObject.VaultName # Creates list of all Keys in vault
            if (!$KVKeylist) { # If $KVKeylist returns empty
                Write-Host "No Keys found" # Message write to screen
                Break GetAzureKeyVaultKey # Breaks :GetAzureKeyVaultKey
            } # End if (!$KVKeylist)
            $KVKeylistNumber = 1 # Sets the base value of the list
            Write-Host "0. Exit" # Write message to screen
            foreach ($_ in $KVKeylist) { # For each item in list
                Write-Host $KVKeylistNumber"." $_.Name # Writes list to screen
                $KVKeylistNumber = $KVKeylistNumber+1 # Adds 1 to $KVKeylistNumber
            } # End foreach ($_ in $KVKeylist) 
            $KVKeylistNumber = 1 # Resets list number to 1
            $KVKeylistSelect = Read-Host "Enter the option number" # Operator input to select from list
            if ($KVKeylistSelect -eq '0') { # If $KVKeyListSelect is 0
                Break GetAzureKeyVaultKey # Breaks :GetAzureKeyVaultKey
            } # End if ($KVKeylistSelect -eq '0')
            :SelectAzureKeyVaultKey foreach ($_ in $KVKeylist) { # For each item in list
                if ($KVKeylistSelect -eq $KVKeylistNumber) { # If the user input matches the current $KVKeylistNumber
                    $KeyVaultKeyObject = Get-AzKeyVaultKey -VaultName $KeyVaultObject.VaultName -Name $_.Name # Collects the full $KeyVaultKeyObject
                    Break SelectAzureKeyVaultKey # Breaks :SelectAzureKeyVaultKey
                } # End if ($KVKeylistSelect -eq $KVKeylistNumber)
                else { # If user input does not match the current $KVKeylistNumber
                    $KVKeylistNumber = $KVKeylistNumber+1 # Adds 1 to $KVKeylistNumber
                } # End else (if ($KVKeylistSelect -eq $KVKeylistNumber))
            } # End :SelectAzureKeyVaultKey
            Return $KeyVaultKeyObject # Returns $KeyVaultKeyObject to calling function
        } # End :GetAzureKeyVaultKey while ($true) {
        Return # Returns $null to calling function
    } # End begin statement
} # End GetAzKeyVaultKey
function DownloadAzKeyVaultKey {
    Begin {
        Write-Host "Under Development"
        Return
    } # End Begin
} # End function DownloadAzKeyVaultKey
function RemoveAzKeyVaultKey {
    Begin {
        Write-Host "Under Development"
        Return
    } # End Begin
} # End function RemoveAzKeyVaultKey
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
function GetAzResourceGroup { # Function to get a resource group, can pipe $RGObject to another function
    Begin {
        $ErrorActionPreference = 'silentlyContinue' # Disables error reporting
        $RGList = Get-AzResourceGroup # Gets all resource groups and assigns to $RGList
        if (!$RGList) { # If $RGList returns empty
            Write-Host "No resource groups found" # Message write to screen
            Return # Returns to calling function with $null
        } # End if (!$RGList)
        $RGListNumber = 1 # Sets the base value of the list
        Write-Host "0. Exit" # Adds exit option to beginning of list
        foreach ($_ in $RGList) { # For each item in list
            Write-Host $RGListNumber"." $_.ResourceGroupName # Writes the option number and resource group name
            $RGListNumber = $RGListNumber+1 # Adds 1 to $RGListNumber
        } # End foreach ($_ in $RGList)
        :GetAzureResourceGroup while ($true) { # Loop for selecting the resource group object
            $RGListNumber = 1 # Resets list number to 1
            $RGListSelect = Read-Host "Enter the option number" # Operator input for selecting which resource group
            if ($RGListSelect -eq '0') { # If $RGListSelect is equal to 0
                Return # Returns to calling function with $null
            } # End if ($RGListSelect -eq '0')
            foreach ($_ in $RGList) { # For each item in list
                if ($RGListSelect -eq $RGListNumber) { # If the operator input matches the current $RGListNumber
                    $RGObject = $_ # Currently selected item in $RGList is assigned to $RGObject
                    Break GetAzureResourceGroup # Breaks :GetAzureResourceGroup
                } # End if ($RGListSelect -eq $RGListNumber)
                else { # If user input does not match the current $RGListNumber
                    $RGListNumber = $RGListNumber+1 # Adds 1 to $RGListNumber
                } # End else (if ($RGListSelect -eq $RGListNumber))
            } # End foreach ($_ in $RGList)
            Write-Host "That was not a valid selection, please try again" # Write message to screen
        } # End :GetAzureResourceGroup while ($true)
        Return $RGObject # Returns $RGObject to calling function
    } # End of begin statement
} # End of function