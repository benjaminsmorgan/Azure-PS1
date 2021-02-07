# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Mircosoft docs links
    New-AzDisk:                 https://docs.microsoft.com/en-us/powershell/module/az.compute/new-azdisk?view=azps-5.4.0
    Set-AzDiskDiskEncryptionKey:https://docs.microsoft.com/en-us/powershell/module/az.compute/set-azdiskdiskencryptionkey?view=azps-5.4.0
    Set-AzDiskKeyEncryptionKey: https://docs.microsoft.com/en-us/powershell/module/az.compute/set-azdiskkeyencryptionkey?view=azps-5.4.0
    Get-AzResourceGroup:        https://docs.microsoft.com/en-us/powershell/module/az.resources/get-azresourcegroup?view=azps-5.1.0
    Get-AzKeyVault:             https://docs.microsoft.com/en-us/powershell/module/az.keyvault/get-azkeyvault?view=azps-5.1.0
    Get-AzKeyVaultSecret:       https://docs.microsoft.com/en-us/powershell/module/az.keyvault/get-azkeyvaultsecret?view=azps-5.1.0
    Get-AzKeyVaultKey:          https://docs.microsoft.com/en-us/powershell/module/az.keyvault/get-azkeyvaultkey?view=azps-5.4.0
    
} #>
<# Required Functions Links: { 
    GetAzResourceGroup:         https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/GetAzResourceGroup.ps1
    GetAzKeyVault:              https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Storage/KeyVault/GetAzKeyVault.ps1
    GetAzKeyVaultSecret:        https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Storage/KeyVault/Secrets/GetAzKeyVaultSecret.ps1
    GetAzKeyVaultKey:           https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Storage/KeyVault/Keys/GetAzKeyVaultKey.ps1
} #>
<# Functions Description: {
    NewAzDisk:                  Creates a new disk
    GetAzResourceGroup:         Gets a resource group
    GetAzKeyVault:              Gets a key vault
    GetAzKeyVaultSecret:        Gets a key vault secret
    GetAzKeyVaultKey:           Gets a key vault key 
} #>
<# Variables: {
    :NewAzureVMWin              Outer loop for managing function
    :NewAzureDisk               Outer loop for managing function 
    :SetAzureDiskSku            Inner loop for setting the disk sku
    :SelectAzureDiskSku         Inner loop for selection the disk sku
    :SetAzureDiskSize           Inner loop for setting the disk size
    :SetAzureDiskOSType         Inner loop for setting the disk os type
    :EnableAzureDiskEncrypt     Inner loop for setting the encyption settings 
    $RGObject:                  Resource group object
    $LocationObject:            Location object
    $ValidSku:                  Empty array that is loaded by $ValidSkuList
    $ValidSkuList:              Static list of disk skus          
    $SkuNumber:                 $var used in the list and selection
    $SkuObjectSelect:           Operator input for the sku selection
    $SkuObject:                 Sku object          
    $DiskSizeObject:            Disk size object
    $DiskOSObject:              Disk OS object
    $UseEncryptOption:          Operator input to use encrpytion
    $KeyVaultObject:            Key vault object
    $KeyVaultKeyObject:         Key vault key object
    $KeyVaultSecretObject:      Key vault secret object
    $DiskConfig:                Settings for the disk before creation            
    $KeyVaultSecretUrl:         Key vault secret url
    $KeyVaultKeyUrl:            Key vault key url
    $KeyVaultID:                Key vault resource ID
    $DiskObject:                Created disk object            
    GetAzResourceGroup{}        Gets $RGObject
    GetAzKeyVault{}             Gets $KeyVaultObject
        GetAzResourceGroup{}        Gets $RGObject
    GetAzKeyVaultSecret{}       Gets $KeyVaultSecretObject
    GetAzKeyVaultKey{}          Gets $KeyVaultKeyObject
} #>
<# Process Flow {
    Function
        Call NewAzDisk > Get $DiskObject
            Call GetAzResourceGroup > Get $RGObject
            End GetAzResourceGoup
                Return NewAzDisk > Send $RGObject
            Call GetAzKeyVault > Get $KeyVaultObject
                Call GetAzResourceGroup > Get $RGObject
                End GetAzResourceGoup
                    Return GetAzKeyVault > Send $RGObject
            End GetAzKeyVault
                Return NewAzDisk > Send $KeyVaultObject
            Call GetAzKeyVaultSecret > Get $KeyVaultSecretObject
            End GetAzKeyVaultSecret
                Return *** > Send $KeyVaultSecretObject
            Call GetAzKeyVaultKey > Get $KeyVaultKeyObject
            End GetAzKeyVaultKey
                Return NewAzDisk > Send $KeyVaultKeyObject
        End NewAzDisk
            Return Function > Send $DiskObject
}#>
function NewAzDisk {
    Begin {
        :NewAzureDisk while ($true) { 
            if (!$RGObject) { # IF $RGObject is $null 
                $RGObject = GetAzResourceGroup # Calls function and assigns output to $var
                if (!$RGObject) { # IF $RGObject is $null
                    Break NewAzureDisk # Breaks :NewAzureDisk
                } # End if (!$RGObject) 
            } # End if (!$RGObject)
            $LocationObject = Get-AzLocation | Where-Object {$_.Location -eq $RGObject.Location} # Pulls location from $RGObject  
            :SetAzureDiskSku while ($true) { # Inner loop for configuring the new disk sku
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
            :SetAzureDiskSize while ($true) { # Inner loop for configuring the new disk size
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
            :EnableAzureDiskEncrypt while ($true) { # Inner loop for configuring the new disk encyption
                $UseEncryptOption = Read-Host "Encypt this disk [Y] or [N]" # Operator input for adding disk encyption
                if ($UseEncryptOption -eq 'exit') { # If $UseEncyptOption equals 'exit'
                    Break NewAzureDisk # Breaks :NewAzureDisk
                } # End if ($UseEncryptOption -eq 'exit')
                elseif ($UseEncryptOption -eq 'n') { # If $UseEncyptOption equals 'n'
                    Break EnableAzureDiskEncrypt # Breaks :EnableAzureDiskEncrypt 
                } # End elseif ($UseEncryptOption -eq 'n')
                elseif ($UseEncryptOption -eq 'y') { # If $UseEncyptOption equals 'y'
                    if (!$KeyVaultObject) { # If $KeyVaultObject has no value
                        $KeyVaultObject = GetAzKeyVault # Calls function and assigns output to $var
                        if (!$KeyVaultObject) { # If $KeyVaultObject has no value
                            Break NewAzureDisk # Breaks :NewAzureDisk
                        } # End if (!$KeyVaultObject)
                    } # End if (!$KeyVaultObject)
                    if (!$KeyVaultKeyObject) { # If $KeyVaultKeyObject has no value
                        $KeyVaultKeyObject = GetAzKeyVaultKey ($KeyVaultObject) # Calls function and assigns output to $var
                        if (!$KeyVaultKeyObject) { # If $KeyVaultKeyObject has no value
                            Break NewAzureDisk # Breaks :NewAzureDisk
                        } # End if (!$KeyVaultKeyObject)
                    } # End if (!$KeyVaultKeyObject)
                    if (!$KeyVaultSecretObject) { # If $KeyVaultSecretObject has no value
                        $KeyVaultSecretObject = GetAzKeyVaultSecret ($KeyVaultObject) # Calls function and assigns output to $var
                        if (!$KeyVaultSecretObject) { # If $KeyVaultSecretObject has no value
                            Break NewAzureDisk # Breaks :NewAzureDisk
                        } # End if (!$KeyVaultSecretObject)
                    } # End if (!$KeyVaultSecretObject)
                    Break EnableAzureDiskEncrypt # Breaks :EnableAzureDiskEncrypt
                } # End elseif ($UseEncryptOption -eq 'y')
                else { # All other options for if ($UseEncryptOption -eq 'exit')
                    Write-Host "That was not a valid option" # Write message to screen
                } # End else (if ($UseEncryptOption -eq 'exit'))
            } # End :EnableAzureDiskEncrypt while ($true)
            if ($UseEncryptOption -eq 'y') { # If $UseEncyptOption equals 'y'
                $DiskConfig = New-AzDiskConfig -Location $LocationObject.DisplayName -DiskSizeGB $DiskSizeObject -SkuName $SkuObject -OsType $DiskOSObject -CreateOption Empty -EncryptionSettingsEnabled $true # Starts the disk configuration
                $KeyVaultSecretUrl = $KeyVaultSecretObject.ID # Assigns secret URL for later use
                $KeyVaultKeyUrl = $KeyVaultKeyObject.ID # Assigns key URL for later use
                $KeyVaultID = $KeyVaultObject.ResourceID # Assigns key vault ID for later use
                $DiskConfig = Set-AzDiskDiskEncryptionKey -Disk $DiskConfig -SecretUrl $KeyVaultSecretUrl -SourceVaultId $KeyVaultID # Sets the disk encyption secret
                $DiskConfig = Set-AzDiskKeyEncryptionKey -Disk $DiskConfig -KeyUrl $KeyVaultKeyUrl -SourceVaultId $KeyVaultID # Sets the disk encyption key
                $DiskObject = New-AzDisk -ResourceGroupName $RGObject.ResourceGroupName -DiskName "Tacos" -Disk $DiskConfig # Creates the disk
            } # End if ($UseEncryptOption -eq 'y') 
            elseif ($UseEncryptOption -eq 'n') { # If $UseEncyptOption equals 'n'
                $DiskConfig = New-AzDiskConfig -Location $LocationObject.DisplayName -DiskSizeGB $DiskSizeObject -SkuName $SkuObject -OsType $DiskOSObject -CreateOption Empty -EncryptionSettingsEnabled $false # Sets the disk settings
                $DiskObject = New-AzDisk -ResourceGroupName $RGObject.ResourceGroupName -DiskName "Tacos2" -Disk $DiskConfig # Creates the disk
            } # End elseif ($UseEncryptOption -eq 'n')
            Return $DiskObject # Returns to calling function with $DiskObject
        } # End :NewAzureDisk while ($true)
        Return # Returns to calling function with $null
    } # End Begin
} # End function NewAzDisk