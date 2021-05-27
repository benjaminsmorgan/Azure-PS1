# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Mircosoft docs links
    New-AzDisk:                 https://docs.microsoft.com/en-us/powershell/module/az.compute/new-azdisk?view=azps-5.4.0
    Get-AzResourceGroup:        https://docs.microsoft.com/en-us/powershell/module/az.resources/get-azresourcegroup?view=azps-5.1.0
    Get-AzKeyVault:             https://docs.microsoft.com/en-us/powershell/module/az.keyvault/get-azkeyvault?view=azps-5.1.0
    Get-AzKeyVaultSecret:       https://docs.microsoft.com/en-us/powershell/module/az.keyvault/get-azkeyvaultsecret?view=azps-5.1.0
    Get-AzKeyVaultKey:          https://docs.microsoft.com/en-us/powershell/module/az.keyvault/get-azkeyvaultkey?view=azps-5.4.0
    Get-AzLocation:             https://docs.microsoft.com/en-us/powershell/module/az.resources/get-azlocation?view=azps-5.2.0
} #>
<# Required Functions Links: { 
    GetAzResourceGroup:         https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/GetAzResourceGroup.ps1
    GetAzKeyVault:              https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Storage/KeyVault/GetAzKeyVault.ps1
    GetAzKeyVaultSecret:        https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Storage/KeyVault/Secrets/GetAzKeyVaultSecret.ps1
    GetAzKeyVaultKey:           https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Storage/KeyVault/Keys/GetAzKeyVaultKey.ps1
    GetAzLocation:              https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/Locations/GetAzLocation.ps1
} #>
<# Functions Description: {
    NewAzDisk:                  Creates a new disk
    GetAzResourceGroup:         Gets a resource group
    GetAzKeyVault:              Gets a key vault
    GetAzKeyVaultSecret:        Gets a key vault secret
    GetAzKeyVaultKey:           Gets a key vault key 
} #>
<# Variables: {
    :NewAzureDisk               Outer loop for managing function
    :SetAzureDiskName           Inner loop for setting the disk name
    :SetAzureDiskSku            Inner loop for setting the disk sku
    :SetAzureDiskSize           Inner loop for setting the disk size
    :SetAzureDiskOSType         Inner loop for setting the disk OS
    :EnableAzureDiskEncrypt     Inner loop for setting the disk encryption
    :EncryptError               Inner loop for $KeyVaultObject not equaling $KeyVaultObject2
    $CallingFunction:           Name of this function or the one that called it
    $RGObject:                  Resource group object
    $LocationObject:            Azure location object
    $ValidArray:                Array of valid characters for disk name
    $DiskNameInput:             Operator input for the disk name
    $DiskNameArray:             $DiskNameInput convert to array
    $OpConfirm:                 Operator confirmation of action
    $OpSelect:                  Operator selection of action
    $SkuObject:                 Disk sku object
    $DiskSizeObject:            Operator input for the disk size
    $DiskOSObject:              Disk OS object
    $UseEncryptOption:          Operator input for the disk encrpytion setting
    $KeyVaultKeyObject:         Key vault key object
    $KeyVaultObject:            Key vault object holding secret
    $KeyVaultObject2:           Key vault object holding key
    $KeyVaultSecretObject:      Key vault secret object
    $DiskConfig:                $var holding disk configuration
    GetAzResourceGroup{}        Gets $RGObject
    GetAzLocation{}             Gets $LocationObject
    GetAzKeyVaultKey{}          Gets $KeyVaultKeyObject
        GetAzKeyVault{}             Gets $KeyVaultObject
    GetAzKeyVaultSecret{}       Gets $KeyVaultSecretObject
        GetAzKeyVault{}             Gets $KeyVaultObject
} #>
<# Process Flow {
    Function
        Call NewAzDisk > Get $null
            Call GetAzResourceGroup > Get $RGObject
            End GetAzResourceGoup
                Return NewAzDisk > Send $RGObject
            Call GetAzLocation > Get $LocationObject
            End GetAzLocation
                Return NewAzDisk > Send $LocationObject
            Call GetAzKeyVaultKey > Get $KeyVaultKeyObject
                Call GetAzKeyVault > Get $KeyVaultObject
                End GetAzKeyVault
                    Return GetAzKeyVaultKey > Send $KeyVaultObject
            End GetAzKeyVaultKey
                Return NewAzDisk > Send $KeyVaultKeyObject, $KeyVaultObject
            Call GetAzKeyVaultSecret > Get $KeyVaultSecretObject
                Call GetAzKeyVault > Get $KeyVaultObject
                End GetAzKeyVault
                    Return GetAzKeyVaultSecret > Send $KeyVaultObject
            End GetAzKeyVaultSecret
                Return NewAzDisk > Send $KeyVaultSecretObject, $KeyVaultObject
        End NewAzDisk
            Return Function > Send $null
}#>
function NewAzDisk {                                                                        # Function for creating a new disk
    Begin {                                                                                 # Begin function
        if (!$CallingFunction) {                                                            # If $CallingFunction is $null
            $CallingFunction = 'NewAzDisk'                                                  # Creates $CallingFunction 
        }                                                                                   # End if (!$CallingFunction)
        :NewAzureDisk while ($true) {                                                       # Outer loop for managing function
            $RGObject = GetAzResourceGroup ($CallingFunction)                               # Calls function and assigns output to $var
            if (!$RGObject) {                                                               # If $RGObject is $null
                Break NewAzureDisk                                                          # Breaks :NewAzureDisk
            }                                                                               # End if (!$RGObject) 
            $LocationObject = GetAzLocation ($CallingFunction)                              # Calls function and assigns output to $var
            if (!$LocationObject) {                                                         # If $LocationObject is $null
                Break NewAzureDisk                                                          # Breaks :NewAzureDisk    
            }                                                                               # End if (!$LocationObject)
            :SetAzureDiskName while ($true) {                                               # Inner loop for setting the disk name
                $ValidArray = 'abcdefghijklmnopqrstuvwxyz0123456789'                        # Creates a string of valid characters
                $ValidArray = $ValidArray.ToCharArray()                                     # Loads all valid characters into array
                Write-Host 'Storage Disk name must be atleast 3 characters'                 # Write message to screen
                Write-Host 'and made up of letters and numbers only'                        # Write message to screen
                $DiskNameArray = $null                                                      # Clears $DiskNameArray
                $DiskNameInput = Read-Host 'Disk name'                                      # Operator input for the Disk name
                $DiskNameInput = $DiskNameInput.ToLower()                                   # Recreates $DiskNameInput in lower
                $DiskNameArray = $DiskNameInput.ToCharArray()                               # Creates $DiskNameInput
                foreach ($_ in $DiskNameArray) {                                            # For each item in $DiskNameArray
                    if ($_ -notin $ValidArray) {                                            # If current item is not in $ValidArray
                        if ($_ -eq ' ') {                                                   # If current item equals 'space'
                            Write-Host ''                                                   # Write message to screen    
                            Write-Host 'Disk name cannot include any spaces'                # Write message to screen
                        }                                                                   # End if ($_ -eq ' ')
                        else {                                                              # If current item is not equal to 'space'
                            Write-Host ''                                                   # Write message to screen    
                            Write-Host $_' is not a valid character'                        # Write message to screen
                        }                                                                   # End else (if ($_ -eq ' '))
                        $DiskNameInput = $null                                              # Clears $DiskNameInput
                    }                                                                       # End if ($_ -notin $ValidArray)
                }                                                                           # End foreach ($_ in $DiskNameArray)
                if (!$DiskNameInput) {                                                      # If $DiskNameInput is $null
                    Pause                                                                   # Pauses for operator input
                    Clear-Host                                                              # Clears screen
                }                                                                           # End if ($DiskNameInput -eq '0')
                else {                                                                      # If $DiskNameInput not equal to '0'
                    Write-Host $DiskNameInput 'is correct'                                  # Write message to screen
                    $OpConfirm = Read-Host '[Y] Yes [N] No [E] Exit'                        # Operator confirmation of Disk name input
                    if ($OpConfirm -eq 'e') {                                               # If $OpConfirm equals 'e'
                        Break NewAzureDisk                                                  # Breaks NewAzureDisk
                    }                                                                       # End if ($OpConfirm -eq 'e')
                    if ($OpConfirm -eq 'y') {                                               # If $OpConfirm is equal to 'y'
                        Clear-Host                                                          # Clears screen
                        Break SetAzureDiskName                                              # Breaks :SetAzureDiskName
                    }                                                                       # End if ($OpConfirm -eq 'y')
                }                                                                           # End else (if (!$DiskNameInput))
            }                                                                               # End :SetAzureDiskName while ($true)
            :SetAzureDiskSku while ($true) {                                                # Inner loop for configuring the new disk sku
                Write-Host 'Available disk skus'                                            # Write message to screen
                Write-Host '[0] Exit'                                                       # Write message to screen
                Write-Host '[1] Standard_LRS'                                               # Write message to screen
                Write-Host '[2] Premium_LRS'                                                # Write message to screen
                Write-Host '[3] StandardSSD_LRS'                                            # Write message to screen
                Write-Host '[4] UltraSSD_LRS'                                               # Write message to screen
                $OpSelect = Read-Host 'Option [#]'                                          # Operator input to select the sku
                Clear-Host                                                                  # Clear host
                if ($OpSelect -eq '0') {                                                    # If $OpSelect equals '0'
                    Break NewAzureDisk                                                      # Breaks NewAzureDisk
                }                                                                           # End if ($OpSelect -eq '0')
                elseif ($OpSelect -eq '1') {                                                # Else if $OpSelect equals '1'
                    $SkuObject = 'Standard_LRS'                                             # Sets $SkuObject
                }                                                                           # End elseif ($OpSelect -eq '1')
                elseif ($OpSelect -eq '2') {                                                # Else if $OpSelect equals '2'
                    $SkuObject = 'Premium_LRS'                                              # Sets $SkuObject
                }                                                                           # End elseif ($OpSelect -eq '2')
                elseif ($OpSelect -eq '3') {                                                # Else if $OpSelect equals '3'
                    $SkuObject = 'StandardSSD_LRS'                                          # Sets $SkuObject
                }                                                                           # End elseif ($OpSelect -eq '3')
                elseif ($OpSelect -eq '4') {                                                # Else if $OpSelect equals '4'
                    $SkuObject = 'UltraSSD_LRS'                                             # Sets $SkuObject
                }                                                                           # End elseif ($OpSelect -eq '4')
                else {                                                                      # All other inputs for $OpSelect
                    Write-Host 'That was not a valid option'                                # Write message to screen
                }                                                                           # End else (if ($OpSelect -eq '0'))
                if ($SkuObject) {                                                           # If $SkuObject has a value
                    Break SetAzureDiskSku                                                   # Breaks :SetAzureDiskSku
                }                                                                           # End if ($SkuObject)
            }                                                                               # End :SetAzureDiskSku while ($true)
            :SetAzureDiskSize while ($true) {                                               # Inner loop for configuring the new disk size
                $DiskSizeObject = -1                                                        # Sets $var to non-break value
                Try{                                                                        # Try the following
                    Write-Host 'Enter the requested size of the disk in GB'                 # Write message to screen
                    Write-Host 'Enter "0" to exit this function'                            # Write message to screen
                    [int]$DiskSizeObject = Read-Host 'Disk size'                            # Operator input for the disk size
                    Clear-Host                                                              # Clears screen
                }                                                                           # End Try
                catch {                                                                     # End catch
                    Write-Host 'That was not a valid input'                                 # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Clear-Host                                                              # Clears screen
                }                                                                           # If Try fails
                if ($DiskSizeObject -eq 0) {                                                # If $DiskSizeObject equals '0'
                    Break NewAzureDisk                                                      # Breaks :NewAzureDisk
                }                                                                           # End if ($DiskSizeObject -eq 0)
                if ($DiskSizeObject -ge 1) {                                                # If $DiskSizeObject has a value greater than 1
                    Break SetAzureDiskSize                                                  # Breaks :SetAzureDiskSize
                }                                                                           # End if ($DiskSizeObject)
                else {                                                                      # All other inputs for $DiskSizeNumber
                    Write-Host 'Please enter a positive number'                             # Write message to screen
                }                                                                           # End else (if ($DiskSizeObject -ge 1))
            }                                                                               # End :SetAzureDiskSize while ($true)
            :SetAzureDiskOSType while ($true) {                                             # Inner loop for setting the disk OS
                Write-Host '[0] Exit'                                                       # Write message to screen
                Write-Host '[1] Windows'                                                    # Write message to screen
                Write-Host '[2] Linux'                                                      # Write message to screen
                $OpSelect = Read-Host 'Option [#]'                                          # Operator input for selecting the disk os
                if ($OpSelect -eq '0') {                                                    # If $OpSelect equals '0'
                    Break NewAzureDisk                                                      # Breaks :NewAzureDisk
                }                                                                           # End if ($OpSelect -eq '0') 
                elseif ($OpSelect -eq '1') {                                                # If $OpSelect equals '1'
                    $DiskOSObject = 'Windows'                                               # Sets $DiskOSObject to 'Windows'
                }                                                                           # End elseif ($OpSelect -eq '1')
                elseif ($OpSelect -eq '2') {                                                # If $OpSelect equals '2'
                    $DiskOSObject = 'Linux'                                                 # Sets $DiskOSObject to 'Linux'
                }                                                                           # End elseif ($OpSelect -eq '2')
                else {                                                                      # All other inputs for $OpSelect
                    Write-Host 'That was not a valid input'                                 # Write message to screen
                }                                                                           # End else (if ($OpSelect -eq '0'))
                if ($DiskOSObject) {                                                        # If $DiskOSObject has a value
                    Break SetAzureDiskOSType                                                # Breaks :SetAzureDiskOSType
                }                                                                           # End if ($DiskOSObject)
            }                                                                               # End :SetAzureDiskOSType while ($true)
            :EnableAzureDiskEncrypt while ($true) {                                         # Inner loop for configuring the new disk encyption
                Write-Host 'Encrypt this disk'                                              # Write message to screen
                $UseEncryptOption = Read-Host '[Y] Yes [N] No [E] Exit'                     # Operator input for adding disk encyption
                Clear-Host                                                                  # Clears screen
                if ($UseEncryptOption -eq 'e') {                                            # If $UseEncyptOption equals 'e'
                    Break NewAzureDisk                                                      # Breaks :NewAzureDisk
                }                                                                           # End if ($UseEncryptOption -eq 'e')
                elseif ($UseEncryptOption -eq 'n') {                                        # If $UseEncyptOption equals 'n'
                    Break EnableAzureDiskEncrypt                                            # Breaks :EnableAzureDiskEncrypt 
                }                                                                           # End elseif ($UseEncryptOption -eq 'n')
                elseif ($UseEncryptOption -eq 'y') {                                        # If $UseEncyptOption equals 'y'
                    $KeyVaultKeyObject, $KeyVaultObject = GetAzKeyVaultKey `
                        ($CallingFunction)                                                  # Calls function and assigns output to $var
                    if (!$KeyVaultKeyObject) {                                              # If $KeyVaultKeyObject has no value
                        Write-Host 'No key selected'                                        # Write messsage to screen
                        Write-Host 'Continue building disk without encryption?'             # Write messsage to screen
                        $OpSelect = Read-Host '[Y] Yes [N]'                                 # Operator input to continue without encryption
                        Clear-Host                                                          # Clears screen
                        if ($OpSelect -eq 'y') {                                            # If $OpSelect equals 'y'
                            $UseEncryptOption = 'n'                                         # Sets $UseEncryptOption to 'n'
                            Break EnableAzureDiskEncrypt                                    # Breaks :EnableAzureDiskEncrypt 
                        }                                                                   # End if ($OpSelect -eq 'y')
                        else {                                                              # All other inputs for $OpSelect
                            Break NewAzureDisk                                              # Breaks :NewAzureDisk
                        }                                                                   # End else (if ($OpSelect -eq 'y'))
                    }                                                                       # End if (!$KeyVaultKeyObject)
                    $KeyVaultObject2 = $KeyVaultObject                                      # Moves vault object holding $KeyVaultObject to $KeyVaultObject2
                    $KeyVaultSecretObject, $KeyVaultObject = GetAzKeyVaultSecret `
                        ($CallingFunction)                                                  # Calls function and assigns output to $var
                    if (!$KeyVaultSecretObject) {                                           # If $KeyVaultSecretObject has no value
                        Write-Host 'No secret selected'                                     # Write messsage to screen
                        Write-Host 'Continue building disk without encryption?'             # Write messsage to screen
                        $OpSelect = Read-Host '[Y] Yes [N]'                                 # Operator input to continue without encryption
                        Clear-Host                                                          # Clears screen
                        if ($OpSelect -eq 'y') {                                            # If $OpSelect equals 'y'
                            $UseEncryptOption = 'n'                                         # Sets $UseEncryptOption to 'n'
                            Break EnableAzureDiskEncrypt                                    # Breaks :EnableAzureDiskEncrypt 
                        }                                                                   # End if ($OpSelect -eq 'y')
                        else {                                                              # All other inputs for $OpSelect
                            Break NewAzureDisk                                              # Breaks :NewAzureDisk
                        }                                                                   # End else (if ($OpSelect -eq 'y'))
                    }                                                                       # End if (!$KeyVaultSecretObject)
                    if ($KeyVaultObject.ResourceID -ne $KeyVaultObject2.ResourceID) {       # If $KeyVaultObject.ResourceID not equal KeyVaultObject2.ResourceID
                        :EncryptError while ($true) {                                       # Inner loop for dealing with 2 vaults
                            Write-Host 'The key and secret used to encypt'                  # Write message to screen
                            Write-Host 'this drive must reside in the same vault'           # Write message to screen
                            Write-Host ''                                                   # Write message to screen
                            Write-Host '[0] Exit'                                           # Write message to screen
                            Write-Host '[1] Select new key and secret'                      # Write message to screen
                            Write-Host '[2] Continue without encyption'                     # Write message to screen
                            $OpSelect = Read-Host 'Option [#]'                              # Operator input for selecting next action
                            Clear-Host                                                      # Clears screen
                            if ($OpSelect -eq '0') {                                        # If $OpSelect equals '0'
                                Break NewAzureDisk                                          # Breaks :NewAzureDisk
                            }                                                               # End if ($OpSelect -eq '0')
                            elseif ($OpSelect -eq '1') {                                    # Else if $OpSelect equals '1'
                                Break EncryptError                                          # Breaks :EncryptError  
                            }                                                               # End elseif ($OpSelect -eq '1')
                            elseif ($OpSelect -eq '2') {                                    # Else if $OpSelect equals '2'
                                $UseEncryptOption = 'n'                                     # Sets $UseEncryptOption to 'n'
                                Break EnableAzureDiskEncrypt                                # Breaks :EnableAzureDiskEncrypt 
                            }                                                               # End elseif ($OpSelect -eq '2')
                            else {                                                          # All other inputs for $OpSelect
                                Write-Host 'That was not a valid input'                     # Write message to screen
                                Pause                                                       # Pauses all actions for operator input
                                Clear-Host                                                  # Clears screen
                            }                                                               # End else (if ($OpSelect -eq '0'))
                        }                                                                   # End :EncryptError while ($true)
                    }                                                                       # End if ($KeyVaultObject -ne $KeyVaultObject2)
                    else {
                        Break EnableAzureDiskEncrypt                                        # Breaks :EnableAzureDiskEncrypt
                    }
                }                                                                           # End elseif ($UseEncryptOption -eq 'y')
                else {                                                                      # All other options for $OpSelect
                    Write-Host 'That was not a valid input'                                 # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Clear-Host                                                              # Clears screen
                }                                                                           # End else (if ($UseEncryptOption -eq 'e'))
            }                                                                               # End :EnableAzureDiskEncrypt while ($true)
            Write-Host 'Building disk'                                                      # Write message to screen
            Write-Host 'This may take a moment'                                             # Write message to screen
            if ($UseEncryptOption -eq 'y') {                                                # If $UseEncyptOption equals 'y'
                Try {                                                                       # Try the following
                    $DiskConfig = New-AzDiskConfig -Location $LocationObject.DisplayName `
                        -DiskSizeGB $DiskSizeObject -SkuName $SkuObject -OsType `
                        $DiskOSObject -CreateOption Empty -EncryptionSettingsEnabled $true  # Starts the disk configuration
                    $KeyVaultSecretUrl = $KeyVaultSecretObject.ID                           # Assigns secret URL
                    $KeyVaultKeyUrl = $KeyVaultKeyObject.ID                                 # Assigns key URL 
                    $KeyVaultID = $KeyVaultObject.ResourceID                                # Assigns key vault ID 
                    $DiskConfig = Set-AzDiskDiskEncryptionKey -Disk $DiskConfig -SecretUrl `
                        $KeyVaultSecretUrl -SourceVaultId $KeyVaultID -ErrorAction 'Stop'   # Sets the disk encyption secret
                    $DiskConfig = Set-AzDiskKeyEncryptionKey -Disk $DiskConfig -KeyUrl `
                        $KeyVaultKeyUrl -SourceVaultId $KeyVaultID -ErrorAction 'Stop'      # Sets the disk encyption key
                    New-AzDisk -ResourceGroupName $RGObject.ResourceGroupName -DiskName `
                        $DiskNameInput -Disk $DiskConfig -ErrorAction 'Stop'                # Creates the disk
                }                                                                           # End Try
                catch {                                                                     # If Try fails
                    Write-Host 'An error has occured'                                       # Write message to screen
                    Write-Host 'You may not have the correct'                               # Write message to screen
                    Write-Host 'permissions to do this action'                              # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Break NewAzureDisk                                                      # Breaks :NewAzureDisk
                }                                                                           # End catch
                Write-Host 'The disk has been created'                                      # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break NewAzureDisk                                                          # Breaks :NewAzureDisk
            }                                                                               # End if ($UseEncryptOption -eq 'y') 
            elseif ($UseEncryptOption -eq 'n') {                                            # If $UseEncyptOption equals 'n'
                Try {                                                                       # Try the following
                    $DiskConfig = New-AzDiskConfig -Location $LocationObject.DisplayName `
                        -DiskSizeGB $DiskSizeObject -SkuName $SkuObject -OsType `
                        $DiskOSObject -CreateOption Empty -EncryptionSettingsEnabled `
                        $false -ErrorAction 'Stop'                                          # Sets the disk settings
                    New-AzDisk -ResourceGroupName $RGObject.ResourceGroupName -DiskName `
                        $DiskNameInput -Disk $DiskConfig -ErrorAction 'Stop'                # Creates the disk
                }                                                                           # End try
                catch {                                                                     # If Try fails
                    Write-Host 'An error has occured'                                       # Write message to screen
                    Write-Host 'You may not have the correct'                               # Write message to screen
                    Write-Host 'permissions to do this action'                              # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Break NewAzureDisk                                                      # Breaks :NewAzureDisk
                }                                                                           # End catch
                Write-Host 'The disk has been created'                                      # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break NewAzureDisk                                                          # Breaks :NewAzureDisk
            }                                                                               # End elseif ($UseEncryptOption -eq 'n')
        }                                                                                   # End :NewAzureDisk while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function NewAzDisk