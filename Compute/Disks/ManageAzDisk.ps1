# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Microsoft docs links
    New-AzDisk:                 https://docs.microsoft.com/en-us/powershell/module/az.compute/new-azdisk?view=azps-5.4.0
    Get-AzDisk:                 https://docs.microsoft.com/en-us/powershell/module/az.compute/get-azdisk?view=azps-5.4.0
    Remove-AzDisk:              https://docs.microsoft.com/en-us/powershell/module/az.compute/remove-azdisk?view=azps-5.4.0
    Get-AzKeyVault:             https://docs.microsoft.com/en-us/powershell/module/az.keyvault/get-azkeyvault?view=azps-5.1.0
    Get-AzKeyVaultSecret:       https://docs.microsoft.com/en-us/powershell/module/az.keyvault/get-azkeyvaultsecret?view=azps-5.1.0
    Get-AzKeyVaultKey:          https://docs.microsoft.com/en-us/powershell/module/az.keyvault/get-azkeyvaultkey?view=azps-5.4.0
    Get-AzResourceGroup:        https://docs.microsoft.com/en-us/powershell/module/az.resources/get-azresourcegroup?view=azps-5.1.0
    Get-AzLocation:             https://docs.microsoft.com/en-us/powershell/module/az.resources/get-azlocation?view=azps-5.2.0
} #>
<# Required Functions Links: { 
    NewAzDisk:                  https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Compute/Disks/NewAzDisk.ps1
    ListAzDisk:                 https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Compute/Disks/ListAzDisk.ps1
    Get-AzDisk:                 https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Compute/Disks/GetAzDisk.ps1
    RemoveAzDisk:               https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Compute/Disks/RemoveAzDisk.ps1
    GetAzResourceGroup:         https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/GetAzResourceGroup.ps1
    GetAzKeyVault:              https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Storage/KeyVault/GetAzKeyVault.ps1
    GetAzKeyVaultSecret:        https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Storage/KeyVault/Secrets/GetAzKeyVaultSecret.ps1
    GetAzKeyVaultKey:           https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Storage/KeyVault/Keys/GetAzKeyVaultKey.ps1
    GetAzLocation:              https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/Locations/GetAzLocation.ps1
} #>
<# Functions Description: {
    ManageAzDisk:               Management function for disks
    NewAzDisk:                  Creates a new disk
    ListAzDisk:                 Lists all disks
    GetAzDisk:                  Gets a disk
    RemoveAzDisk:               Removes a selected disk
    GetAzResourceGroup:         Gets a resource group
    GetAzKeyVault:              Gets a key vault
    GetAzKeyVaultSecret:        Gets a key vault secret
    GetAzKeyVaultKey:           Gets a key vault key
    GetAzLocation:              Gets a list of azure locations
} #>
<# Variables: {
    :ManageAzureDisk            Outer loop for managing function
    $RgObject:                  Resource group object
    $DiskObject:                Disk object
    $OpSelect:                  Operator input for the management function
    NewAzDisk{}                 Creates $DiskObject           
        GetAzResourceGroup{}        Gets $RGObject
        GetAzLocation{}             Gets $LocationObject
        GetAzKeyVaultKey{}          Gets $KeyVaultKeyObject
            GetAzKeyVault{}             Gets $KeyVaultObject
        GetAzKeyVaultSecret{}       Gets $KeyVaultSecretObject
            GetAzKeyVault{}             Gets $KeyVaultObject
    ListAzDisk{}                Lists disks
    GetAzDisk{}                 Gets $DiskObject
    RemoveAzDisk{}              Removes $DiskObject
        GetAzDisk{}                 Gets $DiskObject
} #>
<# Process Flow {
    Function
        Call ManageAzDisk > Get $null
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
                Return ManageAzDisk > Send $null
            Call ListAzDisk > Get $null
            End ListAzDisk
                Return ManageAzDisk > Return $null
            Call RemoveAzDisk > Get $null
                Call GetAzDisk > Get $DiskObject
                End GetAzDisk
                    Return RemoveAzDisk > Send $DiskObject
            End RemoveAzDisk
                Return ManageAzDisk > Return $null
        End ManageAzDisk
            Return Function > Send $null
}#>
function ManageAzDisk {                                                                     # Function for managing azure disks
    Begin {                                                                                 # Begin function
        :ManageAzureDisk while ($true) {                                                    # Outer loop for managing function
            Write-Host 'Manage Disks'                                                       # Write message to screen
            Write-Host '[0] Exit this function'                                             # Write message to screen
            Write-Host '[1] New Disk'                                                       # Write message to screen
            Write-Host '[2] List All Disks'                                                 # Write message to screen
            Write-Host '[3] Remove Disk'                                                    # Write message to screen
            $OpSelect = Read-Host 'Option'                                                  # Operator input for selecting function
            Clear-Host                                                                      # Clears screen
            if ($OpSelect -eq '0') {                                                        # If $OpSelect equals '0'
                Break ManageAzureDisk                                                       # Breaks :ManageAzureDisk
            }                                                                               # End if ($OpSelect -eq '0')
            elseif ($OpSelect -eq '1') {                                                    # Else if $OpSelect equals '1'
                Write-Host 'New Disk'                                                       # Write message to screen
                NewAzDisk                                                                   # Calls function
            }                                                                               # End elseif ($OpSelect -eq '1')
            elseif ($OpSelect -eq '2') {                                                    # Else if $OpSelect equals '2'
                Write-Host 'List All Disks'                                                 # Write message to screen
                ListAzDisk                                                                  # Calls function
            }                                                                               # End elseif ($OpSelect -eq '2')
            elseif ($OpSelect -eq '3') {                                                    # Else if $OpSelect equals '3'
                Write-Host 'Remove Disk'                                                    # Write message to screen
                RemoveAzDisk                                                                # Calls function RemoveAzDisk
            }                                                                               # End elseif ($OpSelect -eq '3')
            else {                                                                          # All other inputs for $OpSelect
                Write-Host 'That was not a valid option'                                    # Write message to screen
            }                                                                               # End else (if ($OpSelect -eq '0'))
        }                                                                                   # End :ManageAzureDisk while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End begin statemnt
}                                                                                           # End function ManageAzDisk
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
function ListAzDisk {                                                                       # Function to list all disk objects
    Begin {                                                                                 # Begin function
        :ListAzureDisk while ($true) {                                                      # Outer loop for managing function
            $DiskList = Get-AzDisk                                                          # Gets a list of all disks
            foreach ($_ in $DiskList) {                                                     # For each item in $DiskList
                Write-Host 'Disk Name: ' $_.Name                                            # Write message to screen
                Write-Host 'RG:        ' $_.ResourceGroupName                               # Write message to screen
                Write-Host 'OS:        ' $_.OsType                                          # Write message to screen
                Write-Host 'Size (GB): ' $_.DiskSizeGB                                      # Write message to screen
                Write-Host 'State:     ' $_.DiskState                                       # Write message to screen
                Write-Host 'Location:  ' $_.Location                                        # Write message to screen
                Write-Host 'Created:   ' $_.TimeCreated                                     # Write message to screen
                Write-Host 'Net Access:' $_.NetworkAccessPolicy                             # Write message to screen    
                Write-Host ''                                                               # Write message to screen
            }                                                                               # End foreach ($_ in $DiskList)
            Pause                                                                           # Pauses all actions for operator input
            Break ListAzureDisk                                                             # Breaks :ListAzureDisk
        }                                                                                   # End :ListAzureDisk while ($true)
        Return $null                                                                        # Returns to calling function with $null 
    }                                                                                       # End Begin
}                                                                                           # End function ListAzDisk
function GetAzDisk {                                                                        # Function to get a disk object
    Begin {                                                                                 # Begin function
        if (!$CallingFunction) {                                                            # If $CallingFunction is $null
            $CallingFunction = 'GetAzDisk'                                                  # Creates $CallingFunction
        }                                                                                   # End if (!$CallingFunction)
        :GetAzureDisk while ($true) {                                                       # Outer loop for managing function
            $ObjectList = Get-AzDisk                                                        # Gets a list of all disks
            $ObjectNumber = 1                                                               # $Var for setting $ObjectList.Number
            [System.Collections.ArrayList]$ObjectArray = @()                                # Creates the object array
            foreach ($_ in $ObjectList) {                                                   # For each $_ in $ObjectListList
                $ObjectInput = [PSCustomObject]@{'Number' = $ObjectNumber;`
                'Name'=$_.Name;'RG'=$_.ResourceGroupName;'OS'=$_.OsType;`
                'Size'=$_.DiskSizeGB;'State'=$_.DiskState;'Loc'=$_.Location;`
                'TC'=$_.TimeCreated;'Sku'=$_.Sku.Name}                                      # Creates the item to loaded into array
                $ObjectArray.Add($ObjectInput) | Out-Null                                   # Loads item into array, out-null removes write to screen
                $ObjectNumber = $ObjectNumber + 1                                           # Increments $ObjectNumber by 1
            }                                                                               # End foreach ($_ in $ObjectList)
            :SelectAzureDisk while ($true) {                                                # Inner loop for selecting object from list
                Write-Host '[0]  Exit'                                                      # Write message to screen
                Write-Host ''                                                               # Write message to screen
                foreach ($_ in $ObjectArray) {                                              # For each $_ in $ObjectArray
                    $Number = $_.Number                                                     # Sets $Number to current item .number
                    if ($_.Number -le 9) {                                                  # If current item .number is 9 or less
                        Write-Host "[$Number]       "$_.Name                                # Write message to screen
                    }                                                                       # End if ($_.Number -le 9) 
                    else {                                                                  # If current item .number is greater then 9
                        Write-Host "[$Number]      "$_.Name                                 # Write message to screen
                    }                                                                       # End else (if ($_.Number -le 9) 
                    Write-Host 'Location: '$_.loc                                           # Write message to screen
                    Write-Host 'Sku Name: '$_.Sku                                           # Write message to screen
                    Write-Host 'RG:       '$_.RG                                            # Write message to screen
                    Write-Host 'OS:       '$_.Os                                            # Write message to screen
                    Write-Host 'State:    '$_.State                                         # Write message to screen
                    Write-Host 'Created:  '$_.TC                                            # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                }                                                                           # End foreach ($_ in $ObjectArray)
                if ($CallingFunction -and $CallingFunction -ne 'GetAzDisk') {               # If $CallingFunction has a value and not equal to 'GetAzDisk'
                    Write-Host 'You are selecting the disk for:'$CallingFunction            # Write message to screen
                }                                                                           # End if ($CallingFunction -and $CallingFunction -ne 'GetAzDisk')
                $OpSelect = Read-Host 'Option [#]'                                          # Operator input to select the disk
                Clear-Host                                                                  # Clears screen
                if ($OpSelect -eq '0') {                                                    # If $OpSelect equals '0'
                   Break GetAzureDisk                                                       # Breaks :GetAzureDisk
                }                                                                           # End if ($OpSelect -eq '0')
                elseif ($OpSelect -in $ObjectArray.Number) {                                # If $OpSelect in $ObjectArray.Number
                    $OpSelect = $ObjectArray | Where-Object {$_.Number -eq $OpSelect}       # $OpSelect is equal to $ObjectArray where $OpSelect equals $ObjectArray.Number
                    $DiskObject = Get-AzDisk -ResourceGroupName $OpSelect.RG `
                        -DiskName $OpSelect.Name                                            # Gets full disk object
                    Return $DiskObject                                                      # Returns $DiskObject to calling function
                }                                                                           # End elseif ($OpSelect -in $ObjectArray.Number)
                else {                                                                      # All other inputs for $OpSelect
                   Write-Host 'That was not a valid input'                                  # Write message to screen
                   Pause                                                                    # Pauses all actions for operator input
                   Clear-Host                                                               # Clears host
                }                                                                           # End else (if ($OpSelect -eq '0'))
            }                                                                               # End :SelectAzureDisk while ($true)
        }                                                                                   # End :GetAzureDisk while ($true)
        Return $null                                                                        # Returns to calling function with $null 
    }                                                                                       # End Begin
}                                                                                           # End function GetAzDisk
function RemoveAzDisk {                                                                     # Function to remove a disk object
    Begin {                                                                                 # Begin function
        :RemoveAzureDisk while ($true) {                                                    # Outer loop for managing function
            $DiskObject = GetAzDisk                                                         # Calls function and assigns output to $var
            if (!$DiskObject) {                                                             # If $DiskObject is $null
                Break RemoveAzureDisk                                                       # Breaks :RemoveAzureDisk
            }                                                                               # End if (!$DiskObject)
            Write-Host 'Remove disk:        '$DiskObject.Name                               # Write message to screen
            Write-Host 'from resource group:'$DiskObject.ResourceGroupName                  # Write message to screen
            $OpConfirm = Read-Host '[Y] Yes [N] No'                                         # Operator confirmation to delete the disk
            if ($OpConfirm -eq 'y') {                                                       # If $OpConfirm equals 'y'
                Clear-Host                                                                  # Clears screen
                Write-Host 'Deleting:'$DiskObject.Name                                      # Write message to screen
                Try {                                                                       # Try the following
                    Remove-AzDisk -ResourceGroupName $DiskObject.ResourceGroupName `
                        -DiskName $DiskObject.Name -Force -ErrorAction 'Stop'               # Removes selected disk
                }                                                                           # End Try
                Catch {                                                                     # If try fails
                    Clear-Host                                                              # Clears screen
                    Write-Host 'An error has occured'                                       # Write message to screen
                    Write-Host 'The disk may still be in use'                               # Write message to screen
                    Write-Host 'The resource group maybe locked'                            # Write message to screen
                    Write-Host 'You may not have the permissions to remove this disk'       # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Break RemoveAzureDisk                                                   # Breaks :RemoveAzureDisk
                }                                                                           # End catch
                Clear-Host                                                                  # Clears screen
                Write-Host 'The selected disk has been deleted'                             # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break RemoveAzureDisk                                                       # Breaks :RemoveAzureDisk
            }                                                                               # End if ($OpConfirm -eq 'y') 
            else {                                                                          # All other inputs for $OpSelect
                Write-Host 'No action taken'                                                # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break RemoveAzureDisk                                                       # Breaks :RemoveAzureDisk
            }                                                                               # End else (if ($OpConfirm -eq 'y'))
        }                                                                                   # End :RemoveAzureDisk while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin 
}                                                                                           # End function RemoveAzDisk
# Additional functions for ManageAzDisk
function GetAzResourceGroup {                                                               # Function to get a resource group
    Begin {                                                                                 # Begin function
        $ErrorActionPreference = 'silentlyContinue'                                         # Disables error reporting
        :GetAzureResourceGroup while ($true) {                                              # Outer loop for managing function
            $ObjectList = Get-AzResourceGroup                                               # Gets all resource groups and assigns to $ObjectList
            $ObjectNumber = 1                                                               # Sets $ObjectNumber to 1
            [System.Collections.ArrayList]$ObjectArray = @()                                # Creates the RG list array
            foreach ($_ in $ObjectList) {                                                   # For each $_ in $ObjectListList
                $ObjectInput = [PSCustomObject]@{'Name' = $_.ResourceGroupName; `
                    'Number' = $ObjectNumber; 'Location' = $_.Location}                     # Creates the item to loaded into array
                $ObjectArray.Add($ObjectInput) | Out-Null                                   # Loads item into array, out-null removes write to screen
                $ObjectNumber = $ObjectNumber + 1                                           # Increments $ObjectNumber by 1
            }                                                                               # End foreach ($_ in $ObjectList)
            Write-Host "[0]  Exit"                                                          # Write message to screen
            foreach ($_ in $ObjectArray) {                                                  # For each $_ in $ObjectArray
                $Number = $_.Number                                                         # Sets $Number to current item .number
                if ($_.Number -le 9) {                                                      # If current item .number is 9 or less
                    Write-Host "[$Number] "$_.Name "|" $_.Location                          # Write message to screen
                }                                                                           # End if ($_.Number -le 9) 
                else {                                                                      # If current item .number is greater then 9
                    Write-Host "[$Number]"$_.Name "|" $_.Location                           # Write message to screen
                }                                                                           # End else (if ($_.Number -le 9) )
            }                                                                               # End foreach ($_ in $ObjectArray)
            :SelectAzureObjectList while ($true) {                                          # Inner loop to select the resource group
                if ($CallingFunction) {                                                     # If $CallingFunction exists
                    Write-Host "You are selecting the resource group for"$CallingFunction   # Write message to screen
                }                                                                           # End if ($CallingFunction)
                $RGSelect = Read-Host "Enter the resource group number"                     # Operator input for the RG selection
                if ($RGSelect -eq '0') {                                                    # If $RGSelect equals 0
                    Break GetAzureResourceGroup                                             # Breaks :GetAzureResourceGroup
                }                                                                           # End if ($RGSelect -eq '0')
                elseif ($RGSelect -in $ObjectArray.Number) {                                # If $RGSelect in $ObjectArray.Number
                    $RGSelect = $ObjectArray | Where-Object {$_.Number -eq $RGSelect}       # $RGSelect is equal to $ObjectArray where $ObjectArray.Number is equal to $RGSelect                                  
                    $RGObject = Get-AzResourceGroup | Where-Object `
                        {$_.ResourceGroupName -eq $RGSelect.Name}                           # Pulls the full resource group object
                    Clear-Host                                                              # Clears screen
                    Return $RGObject                                                        # Returns to calling function with $RGObject
                }                                                                           # End elseif ($RGSelect -in $ListArray.Number)
                else {                                                                      # If $RGObject does not have a value
                    Write-Host "That was not a valid option"                                # Write message to screen
                }                                                                           # End else (if ($RGObject))
            }                                                                               # End :SelectAzureObjectList while ($true)
        }                                                                                   # End :GetAzureResourceGroup while ($true)
        Clear-Host                                                                          # Clears screen
        Return                                                                              # Returns to calling function with $null
    }                                                                                       # End begin statement
}                                                                                           # End function GetAzResourceGroup
function GetAzLocation {                                                                    # Function to get azure location
    Begin {                                                                                 # Begin function
        :GetAzureLocation while ($true) {                                                   # Outer loop for managing function
            $ListObject = Get-AzLocation                                                    # Gets a list of all Azure locations
            $ListNumber = 1                                                                 # $Var for selecting the location
            [System.Collections.ArrayList]$ListArray = @()                                  # Creates the list array
            foreach ($_ in $ListObject) {                                                   # For each $_ in $ListObject
                $ListInput = [PSCustomObject]@{'Number' = $ListNumber; 'Location' `
                = $_.DisplayName}                                                           # Creates the item to load into array
                $ListArray.Add($ListInput) | Out-Null                                       # Loads item into array, out-null removes write to screen
                $ListNumber = $ListNumber + 1                                               # Increments $ListNumber by 1
            }                                                                               # End foreach ($_ in $ListObject)
            Write-Host "[ 0 ] Exit"                                                         # Write message to screen
            foreach ($_ in $ListArray) {                                                    # For each $_ in $ListArray
                Write-Host '['$_.Number']' $_.Location                                      # Writes number and location to screen
            }                                                                               # End foreach ($_ in $ListArray)
            :SelectAzureLocation while ($true) {                                            # Inner loop for selecting location from list
                if ($CallingFunction) {                                                     # If $CallingFunction exists
                    Write-Host "You are selecting the location for"$CallingFunction         # Write message to screen
                }                                                                           # End if ($CallingFunction)
                $LocationSelect = Read-Host "Please enter [#] of the location"              # Operator input for the selection
                if ($LocationSelect -eq '0') {                                              # If $LocationSelect is 0
                    Break GetAzureLocation                                                  # Breaks :GetAzureLocation
                }                                                                           # End if ($LocationSelect -eq '0')
                elseif ($LocationSelect -in $ListArray.Number) {                            # If $LocationSelect in $ListArray.Number
                    $LocationSelect = $ListArray | Where-Object {$_.Number -eq `
                        $LocationSelect}                                                    # LocationSelect is equal to $ListArray where $LocationSelect equals $ListArray.Number
                    Try {                                                                   # Try the following
                        $LocationObject = Get-AzLocation | Where-Object {$_.DisplayName `
                            -eq $LocationSelect.Location} -ErrorAction 'Stop'               # Pulls the full $LocationObject
                    }                                                                       # End try
                    catch {                                                                 # If try fails
                        Write-Host 'An error has occured'                                   # Write message to screen
                        Write-Host 'Please try again later'                                 # Write message to screen
                        Break GetAzureLocation                                              # Breaks :GetAzureLocation 
                    }                                                                       # End catch
                    Clear-Host                                                              # Clears screen
                    Return $LocationObject                                                  # Returns $LocationObject to calling function
                }                                                                           # End elseif ($LocationSelect -in $ListArray.Number) 
                else {                                                                      # All other inputs for $LocationSelect
                    Write-Host "That was not a valid selection"                             # Write message to screen   
                }                                                                           # End else (if ($LocationSelect -eq '0'))
            }                                                                               # End :SelectAzureLocation while ($true)
        }                                                                                   # End :GetAzureLocation while ($true)
        Clear-Host                                                                          # Clears screen
        Return                                                                              # Returns with $null 
    }                                                                                       # End Begin
}                                                                                           # End function GetAzLocation
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
function GetAzKeyVaultSecret {                                                              # Function to get a key vault secret
    Begin {                                                                                 # Begin function
        $WarningPreference = "silentlyContinue"                                             # Disables key vault warnings
        $ErrorActionPreference = 'silentlyContinue'                                         # Disables error reporting
        if (!$CallingFunction) {                                                            # If $CallingFunction does not have a value
            $CallingFunction = 'GetAzKeyVaultSecret'                                        # Creates $CallingFunction
        }                                                                                   # End if (!$CallingFunction)
        :GetAzureKeyVaultSecret while ($true) {                                             # Outer loop for managing function
            $KeyVaultObject = GetAzKeyVault ($CallingFunction)                              # Calls function and assigns output to $var
            if (!$KeyVaultObject) {                                                         # If $$KeyVaultObject is $null
                Break GetAzureKeyVaultSecret                                                # Breaks :GetAzureKeyVaultSecret    
            }                                                                               # End if (!$KeyVaultObject)
            $ObjectList = Get-AzKeyVaultSecret -VaultName $KeyVaultObject.VaultName         # Creates list of all secrets in vault
            if (!$ObjectList) {                                                             # If $ObjectList returns empty
                Write-Host 'No secrets present in this vault'                               # Message write to screen
                Pause                                                                       # Pauses all actions for operator input
                Break GetAzureKeyVaultSecret                                                # Breaks :GetAzureKeyVaultSecret
            }                                                                               # End if (!$ObjectList)
            $ObjectNumber = 1                                                               # Sets the base value of the list
            [System.Collections.ArrayList]$ObjectArray = @()                                # Creates the object list array
            foreach ($_ in $ObjectList) {                                                   # For each $_ in $ObjectListList
                $ObjectInput = [PSCustomObject]@{'Number'=$ObjectNumber; `
                'Name'=$_.Name;'ID'=$_.ID;'EN'=$_.Enabled;'CR'=$_.created; `
                'UP'=$_.Updated;}                                                           # Creates the item to loaded into array
                $ObjectArray.Add($ObjectInput) | Out-Null                                   # Loads item into array, out-null removes write to screen
                $ObjectNumber = $ObjectNumber + 1                                           # Increments $ObjectNumber by 1
            }                                                                               # End foreach ($_ in $ObjectList)
            Write-Host '[0]  Exit'                                                          # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            foreach ($_ in $ObjectArray) {                                                  # For each $_ in $ObjectArray
                $Number = $_.Number                                                         # Sets $Number to current item .number
                if ($_.Number -le 9) {                                                      # If current item .number is 9 or less
                    Write-Host "[$Number]     "$_.Name                                      # Write message to screen
                }                                                                           # End if ($_.Number -le 9) 
                else {                                                                      # If current item .number is greater then 9
                    Write-Host "[$Number]    "$_.Name                                       # Write message to screen
                }                                                                           # End else (if ($_.Number -le 9))
                Write-Host 'Enabled:'$_.EN                                                  # Write message to screen
                Write-Host 'Created:'$_.CR                                                  # Write message to screen
                Write-Host 'Updated:'$_.UP                                                  # Write message to screen
                Write-Host 'ID:     '$_.ID                                                  # Write message to screen
                Write-Host ''                                                               # Write message to screen
            }                                                                               # End foreach ($_ in $ObjectArray)
            :SelectAzureKeyVaultSecret while ($true) {                                      # Inner loop for selecting the secret
                if ($CallingFunction -and $CallingFunction -ne 'GetAzKeyVaultSecret') {     # If $CallingFunction exists
                    Write-Host 'You are selecting the secret for:'$CallingFunction          # Write message to screen
                }                                                                           # End if ($CallingFunction)
                $OpSelect = Read-Host 'Enter option[#]'                                     # Operator input for the key vault selection
                if ($OpSelect -eq '0') {                                                    # If $OpSelect equals 0
                    Break GetAzureKeyVaultSecret                                            # Breaks :GetAzureKeyVaultSecret
                }                                                                           # End if ($OpSelect -eq '0')
                elseif ($OpSelect -in $ObjectArray.Number) {                                # If $OpSelect in $ObjectArray.Number
                    $OpSelect = $ObjectArray | Where-Object {$_.Number -eq $OpSelect}       # $OpSelect is equal to $ObjectArray where $ObjectArray.Number is equal to $OpSelect                                  
                    $KeyVaultSecretObject = Get-AzKeyVaultSecret -VaultName `
                        $KeyVaultObject.VaultName -Name $OpSelect.Name                      # Pulls the full secret object
                    Clear-Host                                                              # Clears screen
                    Return $KeyVaultSecretObject, $KeyVaultObject                           # Returns to calling function with $vars
                }                                                                           # End elseif ($RGSelect -in $ListArray.Number)
                else {                                                                      # All other inputs for $OpSelect
                    Write-Host "That was not a valid option"                                # Write message to screen
                    Clear-Host                                                              # Clears screen
                    Pause                                                                   # Pauses all actions for operator input
                }                                                                           # End else (if ($OpSelect -eq '0'))
            }                                                                               # End :SelectAzureKeyVaultSecret
        }                                                                                   # End :GetAzureKeyVaultSecret while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End begin statement
}                                                                                           # End function GetAzKeyVaultSecret