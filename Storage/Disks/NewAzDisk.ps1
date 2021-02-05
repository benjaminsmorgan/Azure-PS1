function NewAzDisk {
    Begin {
        :NewAzureDisk while ($true) { 
            if (!$RGObject) { # IF $RGObject is $null # ***COMPLETE***
                $RGObject = GetAzResourceGroup # Calls function and assigns output to $var
                if (!$RGObject) { # IF $RGObject is $null
                    Break NewAzureDisk # Breaks :NewAzureDisk
                } # End if (!$RGObject) 
            } # End if (!$RGObject)
            $LocationObject = Get-AzLocation | Where-Object {$_.Location -eq $RGObject.Location}  
            :SetAzureDiskOptions while ($true) { # ***IN PROGRESS***
                :SetAzureDiskSku while ($true) { # ***COMPLETE***
                    [System.Collections.ArrayList]$ValidSku = @() # Creates the valid sku array
                    $ValidSkuList = @('Standard_LRS','Premium_LRS','StandardSSD_LRS','UltraSSD_LRS') # Creates a list of items to load into $ValidSku Array
                    $SkuNumber = 1 # Sets the base number for the valid sku array
                    foreach ($_ in $ValidSkuList) { # For each item in $ValidSkuList
                        $SkuInput = [PSCustomObject]@{'Name' = $_;'Number' = $SkuNumber} # Creates the item to loaded into array
                        $ValidSku.Add($SkuInput) | Out-Null # Loads item into array, out-null removes write to screen
                        $SkuNumber = $SkuNumber + 1 # Increments $SkuNumber up 1
                    } # End foreach ($_ in $ValidSkuList)
                    foreach ($_ in $ValidSku) { # For each item in $ValidSkut
                        Write-Host $_.Number $_.Name # Write message to screen
                    } # End foreach ($_ in $ValidSku)
                    :SelectAzureDiskSku while ($true) { # Inner loop for selecting object from list
                        $SkuObjectSelect = Read-Host "Please enter the number of the sku" # Operator input for the selection
                        if ($SkuObjectSelect -eq '0') { # If $$SkuObjectSelect is 0
                            Break NewAzureDisk # Breaks :NewAzureDisk
                        } # End if ($_Select -eq '0')
                        $SkuObject = $ValidSku | Where-Object {$_.Number -eq $SkuObjectSelect} # Isolates selected object 
                        $SkuObject = $SkuObject.Name # Pulls just the .name value
                        if ($SkuObject) { # If $SkuObject has a value
                            Break SetAzureDiskSku # Breaks :SetAzureDiskSku
                        } # End if ($SetAzureDiskSku)
                        Write-Host "That was not a valid selection" # Write message to screen 
                    } # End :SelectAzureDiskSku while ($true)
                } #End :SetAzureDiskSku while ($true)
                :SetAzureDiskSize while ($true) { # ***COMPLETE***
                    $DiskSizeObject = -1 # Sets $var to non-break value
                    Try{ # Try the following
                        [int]$DiskSizeObject = Read-Host "Size in GB of the Disk [0] to exit" # Operator input for the disk size
                    } # End Try
                    catch {} # If Try fails
                    if ($DiskSizeObject -eq 0) { # If $DiskSizeObject equals 0
                        Break NewAzureDisk # Breaks :NewAzureDisk
                    } # End if ($DiskSizeObject -eq 0)
                    if ($DiskSizeObject -ge 1) { # If $DiskSizeObject has a value greater than 1
                        Break SetAzureDiskSize # Breaks :SetAzureDiskSize
                    } # End if ($DiskSizeObject)
                    else { # All other inputs
                        Write-Host "Please enter a positive integer" # Write message to screen
                    } # End else (if ($DiskSizeObject -ge 1))
                } # End :SetAzureDiskSize while ($true)
                :SetAzureDiskOSType while ($true) { # ***COMPLETE****
                    Write-Host "1 Windows" # Write message to screen
                    Write-Host "2 Linux" # Write message to screen
                    $DiskOSObject = Read-Host "[1] or [2]" # Operator input for disk os type
                    if ($DiskOSObject -eq 'exit') { # If $DiskOSObject equals 'exit'
                        Break NewAzureDisk # Breaks :NewAzureDisk
                    } #End if ($DiskOSObject -eq 'exit') 
                    elseif ($DiskOSObject -eq '1') { # If $DiskOSObject equals '1'
                        $DiskOSObject = 'Windows' # Changes $DiskOSObject to 'Windows'
                        Break SetAzureDiskOSType # Breaks :SetAzureDiskOSType
                    } # End elseif ($DiskOSObject -eq '1')
                    elseif ($DiskOSObject -eq '2') { # If $DiskOSObject equals '2'
                        $DiskOSObject = 'Linux' # Changes $DiskOSObject to 'Linux'
                        Break SetAzureDiskOSType # Breaks :SetAzureDiskOSType
                    } # End elseif ($DiskOSObject -eq '2')
                    else { # All other inputs for $DiskOSType
                        Write-Host "That was not a valid option" # Write message to screen
                    } # End else (if ($DiskOSObject -eq 'exit') )
                } # End :SetAzureDiskOSType while ($true)
                :EnableAzureDiskEncrypt while ($true) { # ***IN PROGRESS***
                    $UseEncryptOption = Read-Host "Encypt this disk [Y] or [N]"
                    if ($UseEncryptOption -eq 'exit') {
                        Break NewAzureDisk # Breaks :NewAzureDisk
                    } # End if ($UseEncryptOption -eq 'exit')
                    elseif ($UseEncryptOption -eq 'n') {
                        Break EnableAzureDiskEncrypt
                    } # End elseif ($UseEncryptOption -eq 'n')
                    elseif ($UseEncryptOption -eq 'y') {
                        if (!$KeyVaultObject) {
                            $KeyVaultObject = GetAzKeyVault 
                            if (!$KeyVaultObject) {
                                Break NewAzureDisk # Breaks :NewAzureDisk
                            } # End if (!$KeyVaultObject)
                        } # End if (!$KeyVaultObject)
                        if (!$KeyVaultKeyObject) {
                            $KeyVaultKeyObject = GetAzKeyVaultKey ($KeyVaultObject)
                            if (!$KeyVaultKeyObject) {
                                Break NewAzureDisk # Breaks :NewAzureDisk
                            } # End if (!$KeyVaultKeyObject)
                        } # End if (!$KeyVaultKeyObject)
                        if (!$KeyVaultSecretObject) {
                            $KeyVaultSecretObject = GetAzKeyVaultSecret ($KeyVaultObject)
                            if (!$KeyVaultSecretObject) {
                                Break NewAzureDisk # Breaks :NewAzureDisk
                            } # End if (!$KeyVaultSecretObject)
                        } # End if (!$KeyVaultSecretObject)
                        Break EnableAzureDiskEncrypt # Breaks :EnableAzureDiskEncrypt
                    } # End elseif ($UseEncryptOption -eq 'y')
                    else {
                        Write-Host "That was not a valid option"
                    } # End else (if ($UseEncryptOption -eq 'exit'))
                } # End :EnableAzureDiskEncrypt while ($true)
                Break SetAzureDiskOptions
            } # End :SetAzureDiskOptions while ($true)
            if ($UseEncryptOption -eq 'y') {
                $DiskConfig = New-AzDiskConfig -Location $LocationObject.DisplayName -DiskSizeGB $DiskSizeObject -SkuName $SkuObject -OsType $DiskOSObject -CreateOption Empty -EncryptionSettingsEnabled $true
                $KeyVaultSecretUrl = $KeyVaultSecretObject.ID
                $KeyVaultKeyUrl = $KeyVaultKeyObject.ID 
                $KeyVaultID = $KeyVaultObject.ResourceID
                $DiskConfig = Set-AzDiskDiskEncryptionKey -Disk $DiskConfig -SecretUrl $KeyVaultSecretUrl -SourceVaultId $KeyVaultID
                $DiskConfig = Set-AzDiskKeyEncryptionKey -Disk $DiskConfig -KeyUrl $KeyVaultKeyUrl -SourceVaultId $KeyVaultID
                $DiskObject = New-AzDisk -ResourceGroupName $RGObject.ResourceGroupName -DiskName "Tacos" -Disk $DiskConfig
            } # End if ($UseEncryptOption -eq 'y') 
            elseif ($UseEncryptOption -eq 'n') {
                $DiskConfig = New-AzDiskConfig -Location $LocationObject.DisplayName -DiskSizeGB $DiskSizeObject -SkuName $SkuObject -OsType $DiskOSObject -CreateOption Empty -EncryptionSettingsEnabled $false
                $DiskObject = New-AzDisk -ResourceGroupName $RGObject.ResourceGroupName -DiskName "Tacos2" -Disk $DiskConfig
            } # End elseif ($UseEncryptOption -eq 'n')
            Return $DiskObject # Returns to calling function with $DiskObject
        } # End :NewAzureDisk while ($true)
        Return # Returns to calling function with $null
    } # End Begin
} # End function NewAzDisk

$ValidSku = 'Standard_LRS', 'Premium_LRS', 'StandardSSD_LRS', 'UltraSSD_LRS'

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
            $RGListSelect = Read-Host "Please enter the number of the resource group" # Operator input for selecting which resource group
            if ($RGListSelect -eq '0') { # If $RGListSelect is equal to 0
                Return # Returns to calling function with $null
            } # End if ($RGListSelect -eq '0')
            foreach ($_ in $RGList) { # For each item in list
                if ($RGListSelect -eq $RGListNumber) { # If the operator input matches the current $RGListNumber
                    $RGObject = $_ # Currently selected item in $RGList is assigned to $RGObject
                    Return $RGObject # Returns $RGObject to calling function
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
function GetAzKeyVaultSecret { # Function to get a key vault secret
    Begin {
        $WarningPreference = "silentlyContinue" # Disables key vault warnings
        $ErrorActionPreference = 'silentlyContinue' # Disables error reporting
        :GetAzureKeyVaultSecret while ($true) { # Outer loop for managing function
            if (!$KeyVaultObject) { # If $KeyVaultObject is $null 
                $KeyVaultObject = GetAzKeyVault # Calls function and assigns output to $var
                if (!$KeyVaultObject) { # If $var is still $null
                    Break GetAzureKeyVaultSecret # Breaks :GetAzureKeyVaultSecret    
                } # End if (!$KeyVaultObject)
            } # End if (!$KeyVaultObject)
            $KVSecretlist = Get-AzKeyVaultSecret -VaultName $KeyVaultObject.VaultName # Creates list of all secrets in vault
            if (!$KVSecretlist) { # If $KVSecretlist returns empty
                Write-Host "No secrets found" # Message write to screen
                Break GetAzureKeyVaultSecret # Breaks :GetAzureKeyVaultSecret
            } # End if (!$KVSecretlist)
            $KVSecretlistNumber = 1 # Sets the base value of the list
            Write-Host "0. Exit" # Write message to screen
            foreach ($_ in $KVSecretlist) { # For each item in list
                Write-Host $KVSecretlistNumber"." $_.Name # Writes list to screen
                $KVSecretlistNumber = $KVSecretlistNumber+1 # Adds 1 to $KVSecretlistNumber
            } # End foreach ($_ in $KVSecretlist) 
            $KVSecretlistNumber = 1 # Resets list number to 1
            $KVSecretlistSelect = Read-Host "Enter the option number" # Operator input to select from list
            if ($KVSecretlistSelect -eq '0') { # If $KVSecretListSelect is 0
                Break GetAzureKeyVaultSecret # Breaks :GetAzureKeyVaultSecret
            } # End if ($KVSecretlistSelect -eq '0')
            :SelectAzureKeyVaultSecret foreach ($_ in $KVSecretlist) { # For each item in list
                if ($KVSecretlistSelect -eq $KVSecretlistNumber) { # If the user input matches the current $KVSecretlistNumber
                    $KeyVaultSecretObject = Get-AzKeyVaultSecret -VaultName $KeyVaultObject.VaultName -Name $_.Name # Collects the full $KeyVaultSecretObject
                    Break SelectAzureKeyVaultSecret # Breaks :SelectAzureKeyVaultSecret
                } # End if ($KVSecretlistSelect -eq $KVSecretlistNumber)
                else { # If user input does not match the current $KVSecretlistNumber
                    $KVSecretlistNumber = $KVSecretlistNumber+1 # Adds 1 to $KVSecretlistNumber
                } # End else (if ($KVSecretlistSelect -eq $KVSecretlistNumber))
            } # End :SelectAzureKeyVaultSecret
            Return $KeyVaultSecretObject # Returns $KeyVaultSecretObject to calling function
        } # End :GetAzureKeyVaultSecret while ($true) {
        Return # Returns $null to calling function
    } # End begin statement
} # End GetAzKeyVaultSecret
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
function GetAzKeyVault { # Collects a key vault object
    Begin {
        $ErrorActionPreference = 'silentlyContinue' # Disables error reporting
        :GetAzureKeyVault while ($true) { # Outer loop for managing function
            #if (!$RGObject) { # If $RGObject is empty
                $RGObject = GetAzResourceGroup # Calls function and assigns output to $var
            #    if (!$RGObject) { # If $RGObject is still empty after returning
            #        Break GetAzureKeyVault # Breaks :GetAzureKeyVault
            #    } # End if (!$RGObject)
            #} # End if (!$RGObject)
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