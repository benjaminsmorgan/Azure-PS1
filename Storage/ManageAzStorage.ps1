# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Mircosoft docs links
    New-AzStorageAccount:       https://docs.microsoft.com/en-us/powershell/module/az.storage/new-azstorageaccount?view=azps-5.2.0
    Get-AzStorageAccount:       https://docs.microsoft.com/en-us/powershell/module/az.storage/get-azstorageaccount?view=azps-5.2.0
    Remove-AzStorageAccount:    https://docs.microsoft.com/en-us/powershell/module/az.storage/remove-azstorageaccount?view=azps-5.2.0
    New-AzStorageContainer:     https://docs.microsoft.com/en-us/powershell/module/az.storage/new-azstoragecontainer?view=azps-5.2.0
    Get-AzStorageContainer:     https://docs.microsoft.com/en-us/powershell/module/az.storage/get-azstoragecontainer?view=azps-5.2.0
    Remove-AzStorageContainer:  https://docs.microsoft.com/en-us/powershell/module/az.storage/remove-azstoragecontainer?view=azps-5.2.0
    Set-AzStorageBlobContent:   https://docs.microsoft.com/en-us/powershell/module/az.storage/set-azstorageblobcontent?view=azps-5.3.0
    Get-AzStorageBlob:          https://docs.microsoft.com/en-us/powershell/module/az.storage/get-azstorageblob?view=azps-5.3.0
    Get-AzStorageBlobContent:   https://docs.microsoft.com/en-us/powershell/module/az.storage/get-azstorageblobcontent?view=azps-5.3.0
    Remove-AzStorageBlob:       https://docs.microsoft.com/en-us/powershell/module/az.storage/remove-azstorageblob?view=azps-5.3.0
    New-AzStorageShare:         https://docs.microsoft.com/en-us/powershell/module/az.storage/new-azstorageshare?view=azps-5.3.0
    Get-AzStorageShare:         https://docs.microsoft.com/en-us/powershell/module/az.storage/get-azstorageshare?view=azps-5.3.0
    Remove-AzStorageShare:      https://docs.microsoft.com/en-us/powershell/module/az.storage/remove-azstorageshare?view=azps-5.3.0
    New-AzKeyVault:             https://docs.microsoft.com/en-us/powershell/module/az.keyvault/new-azkeyvault?view=azps-5.3.0
    Get-AzKeyVault:             https://docs.microsoft.com/en-us/powershell/module/az.keyvault/get-azkeyvault?view=azps-5.1.0
    Remove-AzKeyVault:          https://docs.microsoft.com/en-us/powershell/module/az.keyvault/remove-azkeyvault?view=azps-5.3.0
    Get-AzKeyVaultSecret:       https://docs.microsoft.com/en-us/powershell/module/az.keyvault/get-azkeyvaultsecret?view=azps-5.1.0
    Set-AzKeyVaultSecret:       https://docs.microsoft.com/en-us/powershell/module/az.keyvault/set-azkeyvaultsecret?view=azps-5.1.0
    Remove-AzKeyVaultSecret:    https://docs.microsoft.com/en-us/powershell/module/az.keyvault/remove-azkeyvaultsecret?view=azps-5.1.0
    Get-AzResourceGroup:        https://docs.microsoft.com/en-us/powershell/module/az.resources/get-azresourcegroup?view=azps-5.1.0
    Get-AzResourceLock:         https://docs.microsoft.com/en-us/powershell/module/az.resources/get-azresourcelock?view=azps-5.0.0
    Remove-AzResourceLock:      https://docs.microsoft.com/en-us/powershell/module/az.resources/remove-azresourcelock?view=azps-5.0.0
} #>
<# Required Functions Links: {
    ManageAzStorageAccount:     https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Storage/Storage%20Account/ManageAzStorageAccount.ps1
        NewAzStorageAccount:        https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Storage/Storage%20Account/NewAzStorageAccount.ps1
        GetAzStorageAccount:        https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Storage/Storage%20Account/GetAzStorageAccount.ps1
        RemoveAzStorageAccount:     https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Storage/Storage%20Account/RemoveAzStorageAccount.ps1
    ManageAzStorageContainer:   https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Storage/Storage%20Account/Containers/ManageAzStorageContainer.ps1
        NewAzStorageContainer:      https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Storage/Storage%20Account/Containers/NewAzStorageContainer.ps1
        GetAzStorageContainer:      https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Storage/Storage%20Account/Containers/GetAzStorageContainer.ps1
        RemoveAzStorageContainer:   https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Storage/Storage%20Account/Containers/RemoveAzStorageContainer.ps1
    ManageAzStorageBlobs:       https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Storage/Storage%20Account/Containers/Blob/ManageAzStorageBlob.ps1
        SetAzStorageBlobContent:    https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Storage/Storage%20Account/Containers/Blob/SetAzStorageBlobContent.ps1
        ListAzStorageBlobs:         https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Storage/Storage%20Account/Containers/Blob/ListAzStorageBlobs.ps1
        GetAzStorageBlobContent:    https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Storage/Storage%20Account/Containers/Blob/GetAzStorageBlobContent.ps1
        RemoveAzStorageBlob:        https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Storage/Storage%20Account/Containers/Blob/RemoveAzStorageBlob.ps1
    ManageAzStorageShares:      https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Storage/Storage%20Account/Shares/ManageAzStorageShare.ps1
        NewAzStorageShare:          https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Storage/Storage%20Account/Shares/NewAzStorageShare.ps1
        GetAzStorageShare:          https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Storage/Storage%20Account/Shares/GetAzStorageShare.ps1
        GetAzStorageShareAll:       https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Storage/Storage%20Account/Shares/GetAzStorageShareAll.ps1
        RemoveAzStorageShare:       https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Storage/Storage%20Account/Shares/RemoveAzStorageShare.ps1
        ManageAzStorageShareItems:  TBD
    ManageAzKeyVault
        NewAzKeyVault:              https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Storage/KeyVault/NewAzKeyVault.ps1
        ListAzKeyVault:             https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Storage/KeyVault/ListAzKeyVault.ps1
        GetAzKeyVault:              https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Storage/KeyVault/GetAzKeyVault.ps1
        RemoveAzKeyVault:           https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Storage/KeyVault/RemoveAzKeyVault.ps1
        ManageAzKeyVaultKey:        TBD
            NewAzKeyVaultKey:           TBD
            ListAzKeyVaultKey:          TBD
            GetAzKeyVaultKey:           TBD
            RemoveAzKeyVaultKey:        TBD
        ManageAzKeyVaultSecret:     https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Storage/KeyVault/Secrets/ManageAzKeyVaultSecret.ps1
            NewAzKeyVaultSecret:        https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Storage/KeyVault/Secrets/NewAzKeyVaultSecret.ps1
            ListAzKeyVaultSecret:       https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Storage/KeyVault/Secrets/ListAzKeyVaultSecret.ps1
            GetAzKeyVaultSecret:        https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Storage/KeyVault/Secrets/GetAzKeyVaultSecret.ps1
            GetAzKeyVaultSecretValue:   https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Storage/KeyVault/Secrets/GetAzKeyVaultSecretValue.ps1
            UpdateAzKeyVaultSecret:     https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Storage/KeyVault/Secrets/UpdateAzKeyVaultSecret.ps1
            RemoveAzKeyVaultSecret:     https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Storage/KeyVault/Secrets/RemoveAzKeyVaultSecret.ps1
    GetAzResourceGroup:         https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/GetAzResourceGroup.ps1
    GetAzResourceLocksAll:      https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Locks/GetAzResourceLocksAll.ps1
    RemoveAzResourceLocks:      https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Locks/RemoveAzResourceLocks.ps1 
} #>
<# Functions Description: {
    ManageAzStorage:            Manage function for storage
        ManageAzStorageAccount:     Management function for storage accounts
            NewAzStorageAccount:        Creates new storage account object
            GetAzStorageAccount:        Collects the storage account object
            RemoveAzStorageAccount:     Removes the selected storage account
        ManageAzStorageContainer:   Management function for storage containers
            NewAzStorageContainer:      Creates new storage container(s) in a storage account 
            GetAzStorageContainer:      Collects storage container in a storage account  
            RemoveAzStorageContainer:   Removes existing storage container
        ManageAzStorageBlob:        Management function for storage blobs
            SetAzStorageBlobContent:    Uploads new blobs
            ListAzStorageBlobs:         Gets blob(s) information
            GetAzStorageBlobContent:    Downloads existing blob(s)
            RemoveAzStorageBlob:        Removes blobs from Azure
        ManageAzStorageShare:       Manages all functions for storage shares
            NewAzStorageShare:          Creates a new storage share
            GetAzStorageShare:          Gets a storage share
            GetAzStorageShareAll:       Lists all storage shares in a subscription
            RemoveAzStorageShare:       Removes a storage share
            ManageAzStoreShareItems:    Management function for storage share items
        ManageAzKeyVault:            Management function for key vaults
            NewAzKeyVault:              Creates new key vault object
            ListAzKeyVault:             Lists all key vaults in subscription
            GetAzKeyVault:              Gets $KeyVaultObject
            RemoveAzKeyVault:           Removes $KeyVaultObject
            ManageAzKeyVaultKey:        Management function for key vault keys
                NewAzKeyVaultKey:           TBD
                ListAzKeyVaultKey:          TBD
                GetAzKeyVaultKey:           TBD
                RemoveAzKeyVaultKey:        TBD
            ManageAzKeyVaultSecret:     Management function for key vault secrets
                NewAzKeyVaultSecret:        Creates a new key vault secret
                ListAzKeyVaultSecret:       Lists all key vault secrets by vault name
                GetAzKeyVaultSecret:        Gets a key vault secret
                UpdateAzKeyVaultSecret:     Updates the value of selected key vault secret
                RemoveAzKeyVaultSecret:     Removes a selected key vault secret
        GetAzResourceGroup:         Collects resource group object
        RemoveAzResourceLocks:      Removes locks
        GetAzResourceLocksAll:      Collects all locks on a resource
} #>
<# Variables: {
    :ManageAzureStorage         Outer loop for managing function
    ManageAzStorage:            Operator input for function selection
    $RGObject:                  Resource group object
    $StorageAccObject:          Storage account object
    $StorageConObject:          Storage container object
    $StorageShareObject:        Storage share object
    ManageAzStorageAccount{}    Function for managing storage accounts
        NewAzStorageAccount{}       Function for creating new storage accounts
            GetAzResourceGroup{}        Gets $RGObject
        GetAzStorageAccount{}       Gets $StorageAccObject
            GetAzResourceGroup{}        Gets $RGObject
        RemoveAzStorageAccount{}    Removes $StorageAccObject
            GetAzResourceGroup{}        Gets $RGObject
            GetAzResourceLocksAll{}     Gets $Locks
            RemoveAzResourceLocks{}     Removes $Locks
    ManageAzStorageContainer{}  Function for managing storage containers
        NewAzStorageContainer{}     Function for creating new storage containers
            GetAzStorageAccount{}       Gets $StorageAccObject
                GetAzResourceGroup{}        Gets $RGObject
        GetAzStorageContainer{}     Gets $StorageConObject
            GetAzStorageAccount{}       Gets $StorageAccObject
                GetAzResourceGroup{}        Gets $RGObject
        RemoveAzStorageContainer{}  Removes $StorageConObject
            GetAzStorageContainer{}     Gets $StorageConObject
                GetAzStorageAccount{}       Gets $StorageAccObject
                    GetAzResourceGroup{}        Gets $RGObject
    ManageAzStorageBlob{}       Function for managing storage container blobs
        SetAzStorageBlobContent{}   Uploads new blob object
            GetAzStorageContainer{}     Gets $StorageConObject
                GetAzStorageAccount{}       Gets $StorageAccObject
                    GetAzResourceGroup{}        Gets $RGObject
        ListAzStorageBlob{}         Lists all storage blobs
            GetAzStorageContainer{}     Gets $StorageConObject
                GetAzStorageAccount{}       Gets $StorageAccObject
                    GetAzResourceGroup{}        Gets $RGObject
        GetAzStorageBlobContent{}   Downloads blob object
            GetAzStorageContainer{}     Gets $StorageConObject
                GetAzStorageAccount{}       Gets $StorageAccObject
                    GetAzResourceGroup{}        Gets $RGObject
        RemoveAzStorageBlob{}       Deletes blob object
            GetAzStorageContainer{}     Gets $StorageConObject
                GetAzStorageAccount{}       Gets $StorageAccObject
                    GetAzResourceGroup{}        Gets $RGObject
    ManageAzStorageShare{}      Function for managing storage shares
        NewAzStorageShare{}         Function to create new storage share
            GetAzStorageAccount{}       Gets $StorageAccObject
                GetAzResourceGroup{}        Gets $RGObject
        GetAzStorageShare{}         Gets $StorageShareObject               
            GetAzStorageAccount{}       Gets $StorageAccObject
                GetAzResourceGroup {}        Gets $RGObject
        GetAzStorageShareAll{}      Gets all storage shares
        RemoveAzStorageShare{}      Removes $StorageShareObject
            GetAzStorageShare{}         Gets $StorageShareObject
                GetAzStorageAccount{}       Gets $StorageAccObject
                    GetAzResourceGroup{}        Gets $RGObject
    ManageAzKeyVault{}          Manages $KeyVaultObject  
        NewAzKeyvault{}             Creates $KeyVaultObject
            GetAzResourceGroup{}        Gets $RGObject
        ListAzKeyVault{}            Lists all key vaults in subscription
        GetAzKeyVault{}             Gets $KeyVaultObject
            GetAzResourceGroup{}        Gets $RGObject
        RemoveAzKeyVault{}          Removes $KeyVaultObject
            GetAzKeyVault{}             Gets $KeyVaultObject
                GetAzResourceGroup{}        Gets $RGObject
        ManageAzKeyVaultKey{}       Manages $KeyVaultKeyObject
            NewAzKeyVaultKey{}          Creates $KeyVaultKeyObject
                GetAzKeyVault{}             Gets $KeyVaultObject
                    GetAzResourceGroup{}        Gets $RGObject
            ListAzKeyVaultKey{}         Lists all key vault keys in vault
                GetAzKeyVault{}             Gets $KeyVaultObject
                    GetAzResourceGroup{}        Gets $RGObject
            GetAzKeyVaultKey{}          Gets $KeyVaultKeyObject
                GetAzKeyVault{}             Gets $KeyVaultObject
                    GetAzResourceGroup{}        Gets $RGObject
            RemoveAzKeyVaultKey{}       Removes $KeyVaultKeyObject
                GetAzKeyVaultKey{}          Gets $KeyVaultKeyObject
                    GetAzKeyVault{}             Gets $KeyVaultObject
                        GetAzResourceGroup{}        Gets $RGObject
        ManageAzKeyVaultSecret{}    Manages $KeyVaultSecretObject
            NewAzKeyVaultSecret{}       Creates $KeyVaultSecretObject
                GetAzKeyVault{}             Gets $KeyVaultSecret
                    GetAzResourceGroup{}        Gets $RGObject
            ListAzKeyVaultSecret{}      Lists all secrets in subscription
            GetAzKeyVaultSecret{}       Gets $KeyVaultSecretObject
                GetAzKeyVault{}             Gets $KeyVaultObject
                    GetAzResourceGroup{}        Gets $RGObject 
            GetAzKeyVaultSecretValue{}  Lists value of $KeyVaultSecretObject
                GetAzKeyVaultSecret{}       Gets $KeyVaultSecretObject
                    GetAzKeyVault{}             Gets $KeyVaultObject
                        GetAzResourceGroup{}        Gets $RGObject
            UpdateAzKeyVaultSecret{}    Updates $KeyVaultSecretObject
                GetAzKeyVaultSecret{}       Gets $KeyVaultSecretObject
                    GetAzKeyVault{}             Gets $KeyVaultObject
                        GetAzResourceGroup{}        Gets $RGObject   
            RemoveAzKeyVaultSecret{}    Removes $KeyVaultSecretObject
                GetAzKeyVaultSecret{}       Gets $KeyVaultSecretObject
                    GetAzKeyVault{}             Gets $KeyVaultObject
                        GetAzResourceGroup{}        Gets $RGObject
} #>
<# Process Flow {
    function
        Call ManageAzStorage > Get $null
            Call ManageAzStorageAccount > Get $null
                Call NewAzStorageAccount > Get $StorageAccObject
                    Call GetAzResourceGroup > Get $RGObject
                    End GetAzResourceGroup
                        Return NewAzStorageAccount > Send $RGObject
                End NewAzStorageAccount 
                    Return Function > Send $StorageAccObject
                Call GetAzStorageAccount > Get $StorageAccObject
                    Call GetAzResourceGroup > Get $RGObject
                    End GetAzResourceGroup
                        Return GetAzStorageAccount > Send $RGObject
                End GetAzStorageAccount 
                    Return ManagageAzStorageAccount > Send $StorageAccObject
                Call RemoveAzStorageAccount > Get $null
                    Call GetAzStorageAccount > Get $StorageAccObject
                        Call GetAzResourceGroup > Get $RGObject
                        End GetAzResourceGroup
                            Return GetAzStorageAccount > Send $RGObject
                    End GetAzStorageAccount 
                        Return RemoveAzStorageAccount > Send $StorageAccObject
                End RemoveAzStorageAccount
                    Return ManageAzStorageAccount > Send $Null
            End ManageAzStorageAccount
                Return ManageAzStorage > Send $null
            Call ManageAzStorageContainer > Get $null
                Call NewAzStorageContainer > Get $null
                    Call GetAzStorageAccount > Get $StorageAccObject
                        Call GetAzResourceGroup > Get $RGObject
                        End GetAzResourceGroup
                            Return GetAzStorageAccount > Send $RGObject
                    End GetAzStorageAccount 
                        Return Function > Send $StorageAccObject
                    End NewAzStorageContainer 
                        Return ManageStorageContainer > Send $null
                Call GetAzStorageContainer > Get $StorageConObject
                    Call GetAzStorageAccount > Get $StorageAccObject
                        Call GetAzResourceGroup > Get $RGObject
                        End GetAzResourceGroup
                            Return GetAzStorageAccount > Send $RGObject
                        End GetAzStorageAccount 
                            Return GetAzStorageContainer > Send $StorageAccObject
                    End GetAzStorageContainer 
                        Return ManageAzStorageContainer > Send $StorageConObject, $StorageAccObject
                Call RemoveAzStorageContainer > Get $null
                    Call GetAzStorageContainer > Get $StorageConObject
                        Call GetAzStorageAccount > Get $StorageAccObject
                            Call GetAzResourceGroup > Get $RGObject
                            End GetAzResourceGroup
                                Return GetAzStorageAccount > Send $RGObject
                    End RemoveAzStorageContainer      
                        Return ManageAzStorageContainer > Send $null
            End ManageAzStorageContainer
                Return ManageAzStorage > Send $null
            Call ManageAzStorageBlob
                Call SetAzStorageBlobContent > Get $StorageBlobObject
                    Call GetAzStorageContainer > Get $StorageConObject
                        Call GetAzStorageAccount > Get $StorageAccObject
                            Call GetAzResourceGroup > Get $RGObject
                            End GetAzResourceGroup
                                Return GetAzStorageAccount > Send $RGObject
                        End GetAzStorageAccount 
                            Return GetAzStorageContainer > Send $StorageAccObject
                    End GetAzStorageContainer 
                        Return SetAzStorageBlob > Send $StorageConObject, $StorageAccObject
                End SetAzStorageBlobContent
                    Return ManageAzStorageBlob > Send $StorageBlobObject
                Call ListAzStorageBlob > Get $StorageBlobObject
                    Call GetAzStorageContainer > Get $StorageConObject
                        Call GetAzStorageAccount > Get $StorageAccObject
                            Call GetAzResourceGroup > Get $RGObject
                            End GetAzResourceGroup
                                Return GetAzStorageAccount > Send $RGObject
                        End GetAzStorageAccount 
                            Return GetAzStorageContainer > Send $StorageAccObject
                    End GetAzStorageContainer 
                        Return SetAzStorageBlob > Send $StorageConObject, $StorageAccObject
                End ListAzStorageBlob
                    Return ManageAzStorageBlob > Send $StorageBlobObject
                Call GetAzStorageBlobContent > Get $StorageBlobObject
                    Call GetAzStorageContainer > Get $StorageConObject
                        Call GetAzStorageAccount > Get $StorageAccObject
                            Call GetAzResourceGroup > Get $RGObject
                            End GetAzResourceGroup
                                Return GetAzStorageAccount > Send $RGObject
                        End GetAzStorageAccount 
                            Return GetAzStorageContainer > Send $StorageAccObject
                    End GetAzStorageContainer 
                        Return SetAzStorageBlob > Send $StorageConObject, $StorageAccObject
                End GetAzStorageBlobContent
                    Return ManageAzStorageBlob > Send $StorageBlobObject 
                Call RemoveAzStorageBlob > Get $null
                    Call GetAzStorageContainer > Get $StorageConObject
                        Call GetAzStorageAccount > Get $StorageAccObject
                            Call GetAzResourceGroup > Get $RGObject
                            End GetAzResourceGroup
                                Return GetAzStorageAccount > Send $RGObject
                        End GetAzStorageAccount 
                            Return GetAzStorageContainer > Send $StorageAccObject
                    End GetAzStorageContainer 
                        Return SetAzStorageBlob > Send $StorageConObject, $StorageAccObject
                End RemoveAzStorageBlob
                    Return ManageAzStorageBlob > Send $null
            End ManageAzStorageBlob
                Return ManageAzStorage > Send $null 
        End ManageAzStorage
            Return Function > Send $null
}#>
function ManageAzStorage {
    Begin {
        :ManageAzureStorage while ($true) { # :ManageAzureStorage named loop to select search function
            Write-Host "Azure Storage Management" # Write message to screen
            Write-Host "1 Manage Storage Accounts" # Write message to screen
            Write-Host "2 Manage Storage Containers" # Write message to screen
            Write-Host "3 Manage Blobs" # Write message to screen
            Write-Host "4 Manage Storage Shares" # Write message to screen
            Write-Host "5 Manage Key Vaults" # Write message to screen
            Write-Host "6 Manage Disks" # Write message to screen
            Write-Host "'Exit to return'" # Write message to screen
            $ManageAzStorage = Read-Host "Option?" # Collects operator input on $ManageAzStorage option
            if ($ManageAzStorage -eq 'exit') { # Exit if statement for this function
                Break ManageAzureStorage # Ends :ManageAzureStorage loop, leading to return statement
            } # End if ($ManageAzStorage -eq 'exit')
            elseif ($ManageAzStorage -eq '1') { # Elseif statement for managing storage accounts
                Write-Host "Manage Storage Accounts" # Write message to screen
                $StorageAccObject = ManageAzStorageAccount ($RGObject, $RSObject)
            } # End elseif ($ManageAzStorage -eq '1')
            elseif ($ManageAzStorage -eq '2') { # Elseif statement for managing storage containers
                Write-Host "Manage Storage Containers" # Write message to screen
                $StorageConObject = ManageAzStorageContainer ($RGObject, $RSObject, $StorageAccObject)
                Write-Host $StorageConObject
            } # End elseif ($ManageAzStorage -eq '2')
            elseif ($ManageAzStorage -eq '3') { # Elseif statement for managing Blobs
                Write-Host "Manage Blobs" # Write message to screen
                $StorageBlobObject = ManageAzStorageBlob ($RGObject, $RSObject, $StorageAccObject, $StorageConObject)
                Write-Host $StorageBlobObject.Name
            } # End elseif ($ManageAzStorage -eq '3')
            elseif ($ManageAzStorage -eq '4') { # Elseif statement for managing file shares
                Write-Host "Manage Storage Shares" # Write message to screen
                $StorageShareObject = ManageAzStorageShare ($RGObject, $RSObject, $StorageAccObject)
                Write-Host $StorageShareObject.Name
            } # End elseif ($ManageAzStorage -eq '4')
            elseif ($ManageAzStorage -eq '5') { # Elseif statement for managing keyvaults
                Write-Host "Manage Key Vaults" # Write message to screen
                ManageAzKeyVault ($RGObject)
            } # End elseif ($ManageAzStorage -eq '5')
            elseif ($ManageAzStorage -eq '6') { # Elseif statement for managing disks
                Write-Host "Manage Disks" # Write message to screen
                
            } # End elseif ($ManageAzStorage -eq '6')
            Write-Host $RGObject.ResourceGroupName
            Write-Host $RSObject.Name
            Write-Host $StorageAccObject.StorageAccountName
            Write-Host $StorageConObject.Name
        } # End ManageAzureStorage while ($true)
        Return # Returns to calling function if no search option is used
    } # End begin
} # End function ManageAzStorage
function ManageAzStorageAccount {
    Begin {
        :ManageAzureStorageAcc while ($true) { # :ManageAzureStorageAcc named loop to select search function
            Write-Host "Azure Storage Account Management" # Write message to screen
            Write-Host "1 New Storage Account" # Write message to screen
            Write-Host "2 Get Storage Account" # Write message to screen
            Write-Host "3 Remove Storage Account" # Write message to screen
            Write-Host '0 Clear "$StorageAccObject, $RSObject, $RGObject"' # Write message to screen
            Write-Host "'Exit to return'" # Write message to screen
            $ManageAzStorageACC = Read-Host "Option?" # Collects operator input on $ManageAzStorageACC option
            if ($ManageAzStorageACC -eq 'exit') { # Exit if statement for this function
                if ($StorageAccObject) { # If $StorageAccObject is not $null
                    Return $StorageAccObject # Returns $StorageAccObject to calling function
                } # End if ($StorageAccObject)
                Break ManageAzureStorageAcc # Ends :ManageAzureStorageAcc loop, leading to return statement
            } # End if ($ManageAzStorageACC -eq 'exit')
            elseif ($ManageAzStorageACC -eq '1') { # Elseif statement for creating storage accounts
                Write-Host "New Storage Account" # Write message to screen
                $StorageAccObject = NewAzStorageAccount ($RSObject, $RGObject) # Calls function and assigns to $var
                Write-Host $StorageAccObject.StorageAccountName $StorageAccObject.PrimaryLocation $StorageAccObject.Kind #Writes message to screen
            } # End elseif ($ManageAzStorageACC -eq '1')
            elseif ($ManageAzStorageACC -eq '2') { # Elseif statement for getting storage accounts
                Write-Host "Get Storage Account" # Write message to screen
                $StorageAccObject = GetAzStorageAccount ($RSObject, $RGObject)  # Calls function and assigns to $var
                Write-Host $StorageAccObject.StorageAccountName $StorageAccObject.PrimaryLocation $StorageAccObject.Kind  #Writes message to screen
            } # End elseif ($ManageAzStorageACC -eq '2')
            elseif ($ManageAzStorageACC -eq '3') { # Elseif statement for removing storage accounts
                Write-Host "Remove Storage Accounts" # Write message to screen
                RemoveAzStorageAccount  # Calls function
            } # End elseif ($ManageAzStorageACC -eq '3')
            elseif ($ManageAzStorageACC -eq '0') { # Elseif statement for clearing $vars
                Write-Host 'Clearing "$StorageAccObject, $RSObject, $RGObject"' # Write message to screen
                $StorageAccObject = $null # Clears $var
                $RSObject = $null # Clears $var
                $RGObject = $null # Clears $var
            } # End elseif ($ManageAzStorageACC -eq '0')
            else { # All other inputs for $ManageAzStorageAcc
                Write-Host "That was not a valid option" # Write message to screen
            } # End else (if ($ManageAzStorageACC -eq 'exit'))
        } # End ManageAzureStorageAcc while ($true)
        Return # Returns to calling function 
    } # End begin
} # End function ManageAzStorageAccount
function NewAzStorageAccount { # Creates a new storage account
    Begin {
        $ErrorActionPreference='silentlyContinue' # Turns off error reporting
        :NewAzureStorageAcc while ($true) { # Outer loop for managing function
            if (!$RGObject) { # If $RGObject is $null
                $RGObject = GetAzResourceGroup  # Calls GetAzResourceGroup and assigns to $RGObject
                if (!$RGObject) { # If $RGObject is still $null
                    Break NewAzureStorageAcc # Breaks NewAzureStorageAcc loop
                } # End if (!$RGObject)
            } # End if (!$RGObject)
            :SetAzureStorageAccName while ($true) { # Inner loop for setting the storage account name
                $StorageAccNameInput = '000100000000001000000' # Assigns a value for elseif statement if operator input is invalid
                try { # Try statement for operator input of account name
                    [ValidatePattern('^[a-z,0-9]+$')][ValidateLength (3, 24)]$StorageAccNameInput = [string](Read-Host "New storage account name").ToLower() # Operator input for the account name, only allows letters and numbers. All letters converted to lowercase
                } # End try
                catch {Write-Host "The provided name was not valid characters in length and use numbers and lower-case letters only"} # Error message for failed try
                if ($StorageAccNameInput -eq 'exit') { # $StorageAccNameInput is equal to exit
                    Break NewAzureStorageAcc # Breaks NewAzureStorageAcc loop
                } # if ($StorageAccNameInput -eq 'exit')
                elseif ($StorageAccNameInput -eq '000100000000001000000') {}# Elseif when Try statement fails
                else { # If Try statement input has value not equal to exit
                    Write-Host $StorageAccNameInput # Writes $var to screen
                    $OperatorConfirm = Read-Host "Is this name correct" # Operator confirmation
                    if ($OperatorConfirm -eq 'y' -or $OperatorConfirm -eq 'yes') { # If $OperatorConfirm is equal to 'y' or 'yes'
                        Break SetAzureStorageAccName # Breaks SetAzureStorageAccName
                    } # End If ($OperatorConfirm -eq 'y' -or $OperatorConfirm -eq 'yes')
                    else {} # If $OperatorConfirm is not -eq 'y' or 'yes;
                } # End else (if ($StorageAccNameInput -eq 'exit'))
            } # :SetAzureStorageAccName while ($true)
            $ValidSku = 'Standard_LRS', 'Standard_GRS', 'Standard_RAGRS', 'Standard_ZRS', 'Premium_LRS', 'Premium_ZRS', 'Standard_GZRS', 'Standard_RAGZRS' # Current list of all skus
            :SetAzureStorageAccSku while ($true) { # Inner loop for setting the sku
                $StorageAccSkuInput = Read-Host "New storage account sku" # Operator input for the sku
                if ($StorageAccSkuInput -eq 'exit') { # If $StorageAccSkuInput -eq 'exit'
                    Break NewAzureStorageAcc # Breaks :NewAzureStorageACC loop
                } # if ($StorageAccNameInput -eq 'exit')
                if ($StorageAccSkuInput -cin $ValidSku) { # If $StorageAccSkuInput is in $ValidSku (Case sensitive)
                    Write-Host $StorageAccSkuInput # Writes $StorageAccSkuInput to screen
                    $OperatorConfirm = Read-Host "Is the Sku correct" # Operator confirmation
                    if ($OperatorConfirm -eq 'y' -or $OperatorConfirm -eq 'yes') { # If $OperatorConfirm is equal to 'y' or 'yes'
                        Break SetAzureStorageAccSku # Breaks :SetAzureStorageAccSku
                    } # End if ($OperatorConfirm -eq 'y' -or $OperatorConfirm -eq 'yes')
                } # End if ($StorageAccNameInput -iin $ValidSku)
                else { # Else for all other inputs 
                    Write-Host "The Sku name provided is not valid" # Write message to screen
                    Write-Host "Select from the following" # Write message to screen
                    Write-Host "" # Write message to screen
                    Write-Host $ValidSku -Separator `n # Write $ValidSku list to screen
                } # End else (if ($StorageAccNameInput -iin $ValidSku))
            } # End :SetAzureStorageAccSku while
            $ValidLocation = Get-AzLocation # Collects the list of all valid Azure locations
            :SetAzureStorageAccLoc while ($true) { # Inner loop for setting the account location
                $StorageAccLocInput = Read-Host "New storage account location" # Operator input for the account location
                if ($StorageAccLocInput -eq 'exit') { # If $StorageAccLocInput is 'exit'
                    Break NewAzureStorageAcc # Breaks :NewAzureStorageAcc
                } # if ($StorageAccNameInput -eq 'exit')
                if ($StorageAccLocInput -iin $ValidLocation.Location) { # if $StorageAccLocInput is in $ValidLocation.Location (Case insensitive)
                    Write-Host $StorageAccLocInput # Write $StorageAccLocInput to screen
                    $OperatorConfirm = Read-Host "Is the location correct" # Operator confirmation
                    if ($OperatorConfirm -eq 'y' -or $OperatorConfirm -eq 'yes') { # If $OperatorConfirm is equal to 'y' or 'yes'
                        Break SetAzureStorageAccLoc # Breaks :SetAzureStorageAccLoc
                    } # End if ($OperatorConfirm -eq 'y' -or $OperatorConfirm -eq 'yes')
                } # End if ($StorageAccLocInput -iin $ValidLocation)
                else { # All other inputs for $StorageAccLocInput
                    Write-Host "The location provided is not valid" # Write message to screen
                    Write-Host "Select from the following" # Write message to screen
                    Write-Host "" # Write message to screen
                    Write-Host $ValidLocation.Location -Separator `n # Writes $ValidLocation.Location to screen
                } # End else (if ($StorageAccLocInput -iin $ValidLocation))
            } # End :SetAzStorageAccLoc while ($true)
            $StorageAccObject = New-AzStorageAccount -ResourceGroupName $RGObject.ResourceGroupName -Location $StorageAccLocInput -Name $StorageAccNameInput -SkuName $StorageAccSkuInput # Creates the new storage account and assigns to $StorageAccObject
            Return $StorageAccObject # Returns $var to calling function
        } # End :NewAzureStorageAcc while ($true)
        Break # Returns to calling function empty
    } # End Begin
} # End function NewAzStorageAccount
function GetAzStorageAccount { # Function to get a storage account, can pipe $StorageAccObject to another function
    Begin {
        $ErrorActionPreference = 'silentlyContinue' # Disables errors
        :GetAzureStorageAccByName while ($true) { # Outer loop for function
            $ErrorActionPreference ='silentlyContinue' # Disables errors
            if (!$RGObject) { # If $RGObject is $null
                $RGObject = GetAzResourceGroup # Calls (Function) GetAzResourceGroup to get $RGObject
                if (!$RGObject) { # If $RGObject is $null
                    Break GetAzureStorageACCByName # Ends :GetAzureStorageAccByName
                } # End if (!$RGObject) 
            } # End if (!$RGObject)
            $StorageAccList = Get-AzStorageAccount -ResourceGroupName $RGObject.ResourceGroupName # Collects all storage accounts in $RGObject and assigns to $StorageAccList
            if (!$StorageAccList) { # If $StorageAcclist returns empty
                Write-Host "No storage accounts found" # Message write to screen
                Break GetAzureStorageACCByName # Ends :GetAzureStorageAccByName
            } # End if (!$StorageAccList)
            $StorageAccListNumber = 1 # Sets the base value of $StorageAccListNumber
            Write-Host "0. Exit" # Writes exit option to screen
            foreach ($_ in $StorageAccList) { # For each item in $StorageAccList
                Write-Host $StorageAccListNumber"." $_.StorageAccountName # Writes $StorageAccList to screen
                $StorageAccListNumber = $StorageAccListNumber+1 # Adds 1 to $StorageAccListNumber
            } # End foreach ($_ in $StorageAccList)
            :GetAzureStorageAccount while ($true) {
                $StorageAccListNumber = 1 # Sets the base value of $StorageAccListNumber
                $StorageAccListSelect = Read-Host "Please enter the number of the storage account" # Operator input for the storage account selection
                if ($StorageAccListSelect -eq '0') { # If $StorageAccList is '0'
                    Break GetAzureStorageACCByName # Ends :GetAzureStorageAccByName
                } # if ($StorageAccListSelect -eq '0')
                foreach ($_ in $StorageAccList) { # For each item in $StorageAccList
                    if ($StorageAccListSelect -eq $StorageAccListNumber) { # If the operator input matches the current $StorageAccListNumber
                        $StorageAccObject = $_ # Assigns current item in $StorageAccList to $StorageAccObject
                        Break GetAzureStorageAccount # Breaks :GetAzureStorageAccount
                    } # End if ($StorageAccListSelect -eq $StorageAccListNumber)
                    else { # If user input does not match the current $StorageAccListNumber
                        $StorageAccListNumber = $StorageAccListNumber+1 # Adds 1 to $StorageAccListNumber
                    } # End else (if ($StorageAccListSelect -eq $StorageAccListNumber))
                } # End foreach ($_ in $StorageAccList)
                Write-Host "That was not a valid entry" # Write message to screen
            } # End :GetAzureStorageAccount while ($true) {
            Return $StorageAccObject # Returns to calling function with $StorageAccObject
        } # End :GetAzureStorageAccByName while ($true)
        Return # Returns to calling function with $null
    } # End begin 
} # End function GetAzStorageAccount
function RemoveAzStorageAccount { # Function to get a storage account, can pipe $StorageAccObject to another function
    Begin {
        :RemoveAzureStorageAcc while ($true) { # Outer loop for function
            $ErrorActionPreference ='silentlyContinue' # Disables errors
            if (!$StorageAccObject) { # If $StorageAccObject is $null
                $StorageAccObject = GetAzStorageAccount # Calls function and assigns to $var
                    if (!$StorageAccObject) { # If $StorageAccObject is still $null after calling function
                        Break RemoveAzureStorageAcc # Breaks RemoveAzureStorageAcc
                    } # End if (!$StorageAccObject)
            } # End if (!$StorageAccObject)
            else { # Else for when $StorageAccObject is assigned
                $StoreAccName = $StorageAccObject.StorageAccountName # Collects the name of the storage account and assigns to own $var
                $OperatorConfirm = Read-Host "Remove the following storage account" $StorageAccObject.StorageAccountName "in" $StorageAccObject.ResourceGroupName # Operator confimation to remove the storage account
                if (!($OperatorConfirm -eq 'y' -or $OperatorConfirm -eq 'yes')) { # If Operator confirm is not (equal 'y' or 'yes')
                    Break RemoveAzureStorageAcc # Breaks RemoveAzureStorageAcc
                } # End if (!($OperatorConfirm -eq 'y' -or $OperatorConfirm -eq 'yes'))
                Write-Host "Checking for resource locks" # Write message to screen
                $RSObject = Get-AzResource -Name $StorageAccObject.StorageAccountName -ResourceGroupName $StorageAccObject.ResourceGroupName # Collects the $RSObject 
                $RGObject = Get-AzResourceGroup -Name $StorageAccObject.ResourceGroupName # Collects the $RGObject
                $Locks = GetAzResourceLocksAll ($RSObject, $RGObject) #Calls function and assigns to $var
                if ($Locks) { # If $Locks is not $null
                    RemoveAzResourceLocks ($Locks) # Calls function assigns $null
                } # End if ($Locks)
                else { # If $Locks is $null
                    Write-Host "No locks present on this storage account" # Write message to screen
                } # End else (if ($Locks))
                Try { # Try to execute Remove-AzStorageAccount
                    Remove-AzStorageAccount -ResourceGroupName $StorageAccObject.ResourceGroupName -AccountName $StorageAccObject.StorageAccountName -Force -ErrorAction Stop # Removes storage account, -ErrorAction Stop used for catch statement
                } # End Try
                catch { # Try fails
                    Write-Host "The storage account was not deleted" # Write message to screen
                    if (Get-AzResourceLock -ResourceGroupName $StorageAccObject.ResourceGroupName -AtScope) { # If a lock exists on the resource group
                        Write-Host "There are locks on the resource group that must be removed before this storage account can be removed" # Write message to screen
                    } # End if (Get-AzResourceLock -ResourceGroupName $StorageAccObject.ResourceGroupName -AtScope)
                    else { # All other results for failing to remove the storage account
                        Write-Host "You may not have the permissions to remove this storage account" # Write message to screen
                    } # End else (if (Get-AzResourceLock -ResourceGroupName $StorageAccObject.ResourceGroupName -AtScope))
                    Break RemoveAzureStorageAcc # Breaks RemoveAzureStorageAcc
                } # End Catch
                Write-Host $StoreAccName" has been removed" # Write message to screen
                Return # Returns to calling function
            } # End else ((!$StorageAccObject))
        } # End :RemoveAzureStorageAcc while ($true)
        Write-Host "No changes made"
        Return # Returns to calling function with $null
    } # End begin 
} # End function GetAzStorageAccount
function ManageAzStorageContainer {
    Begin {
        :ManageAzureStorageCon while ($true) { # :ManageAzureStorageCon named loop to select search function
            Write-Host "Azure Storage Container Management" # Write message to screen
            Write-Host "1 New Storage Container" # Write message to screen
            Write-Host "2 Get Storage Container" # Write message to screen
            Write-Host "3 Remove Storage Container" # Write message to screen
            Write-Host '0 Clear "$StorageAccObject, $RSObject, $RGObject"' # Write message to screen
            Write-Host "'Exit to return'" # Write message to screen
            $ManageAzStorageCon = Read-Host "Option?" # Collects operator input on $ManageAzStorageCon option
            if ($ManageAzStorageCon -eq 'exit') { # Exit if statement for this function
                Break ManageAzureStorageCon # Ends :ManageAzureStorageCon loop, leading to return statement
            } # End if ($ManageAzStorageCon -eq 'exit')
            elseif ($ManageAzStorageCon -eq '1') { # Elseif statement for creating storage Containers
                Write-Host "New Storage Container" # Write message to screen
                NewAzStorageContainer ($RSObject, $RGObject, $StorageAccObject) # Calls function and assigns to $var
            } # End elseif ($ManageAzStorageCon -eq '1')
            elseif ($ManageAzStorageCon -eq '2') { # Elseif statement for getting storage Containers
                Write-Host "Get Storage Container" # Write message to screen
                $StorageAccObject = GetAzStorageContainer ($RSObject, $RGObject, $StorageAccObject)  # Calls function and assigns to $var
                Write-Host $StorageAccObject.StorageContainerName $StorageAccObject.PrimaryLocation $StorageAccObject.Kind  #Writes message to screen
            } # End elseif ($ManageAzStorageCon -eq '2')
            elseif ($ManageAzStorageCon -eq '3') { # Elseif statement for removing storage Containers
                Write-Host "Remove Storage Containers" # Write message to screen
                RemoveAzStorageContainer  # Calls function
            } # End elseif ($ManageAzStorageCon -eq '3')
            elseif ($ManageAzStorageCon -eq '0') { # Elseif statement for clearing $vars
                Write-Host 'Clearing "$StorageAccObject, $RSObject, $RGObject"' # Write message to screen
                $StorageAccObject = $null # Clears $var
                $RSObject = $null # Clears $var
                $RGObject = $null # Clears $var
            } # End elseif ($ManageAzStorageCon -eq '0')
            else { # All other inputs for $ManageAzStorageCon
                Write-Host "That was not a valid option" # Write message to screen
            } # End else (if ($ManageAzStorageCon -eq 'exit'))
        } # End ManageAzureStorageCon while ($true)
        Return # Returns to calling function 
    } # End begin
} # End function ManageAzStorageContainer
function NewAzStorageContainer { # Creates new storage container(s) in a storage account
    Begin {
        :NewAzureStorageCon while ($true) { # Outer loop for function
            if (!$StorageAccObject) { # If $StorageAccObject is $null
                $StorageAccObject = GetAzStorageAccount # Calls function and assigns to $var
                    if (!$StorageAccObject) { # If $StorageAccObject is still $null after calling function
                        Break NewAzureStorageCon # Breaks :NewAzureStorageCon
                    } # End if (!$StorageAccObject)
            } # End if (!$StorageAccObject)
            :SetAzureStorageConName while ($true) { # Inner loop for setting storage account name
                Try { # First validation of the storage container name or names
                    Write-Host "Storage container names must be atleast 3 characters and made up of letters and numbers only" # Write message to screen
                    Write-Host "To create multiple containers in this storage account, enter each name seperated by a [Space]" # Write message to screen
                    [ValidatePattern('^[a-z,0-9,\s]+$')]$StorageConNameInput = [string](Read-Host "Storage account name or names").ToLower() # Operator input for the container names
                } # End Try 
                catch { # Catch for failing to meet character validation of the container names
                    Write-Host "***Error***"  # Write message to screen
                    Write-Host "The provided name(s) were not valid, accepted inputs are letters and numbers only" # Write message to screen
                    Write-Host "***Error***" # Write message to screen
                    $StorageConNameInput = '0' # Sets $StorageConNameInput value to a failed check to reset loop
                } # End Catch
                if ($StorageConNameInput -eq '0') { # If $StorageConNamInput is 0 (failed check)
                    Write-Host " " # Writes a message to screen, last action before restarting loop
                } # End if ($StorageConNameInput -eq '0')
                elseif ($StorageConNameInput.Length -le 2) { # If unsplit $StorageConNameInput is 2 or less characters
                    Write-Host "***Error***" # Write message to screen
                    Write-Host "The name entered is invalid, the minimum length of a name is 3 characters" # Write message to screen
                    Write-Host "***Error***" # Write message to screen
                } # End elseif ($StorageConNameInput.Length -le 2)
                else { # Inital validation checks passed, performing secondary validation
                    $StorageConName = $StorageConNameInput # Creats $StorageConName $Var
                    if ($StorageConName -eq 'exit') { # If $StorageConName equals exit
                        Break NewAzStorageAccount # Breaks :NewAzStorageAccount
                    } # End if ($StorageConNameInput -eq 'exit')
                    $StorageConNameSplit = $StorageConName.split() # Creates $StorageConNameSplit, a list of names for each space in $StoreConName
                    foreach ($_ in $StorageConNameSplit) { # Performs length check on all names in list
                        if ($_.length -le 2) { # If $StoreConNameSplit.listitem is 2 or less charaters
                            Write-Host "***Error***" # Write message to screen
                            Write-Host $_ "is not a valid name" # Write message to screen
                            Write-Host "***Error***" # Write message to screen
                            $StorageConNameInput = '0'# Sets $StorageConNameInput value to a failed check to reset loop
                            $StorageConNameSplit = $null # Sets $StorageConNameSplit to $null
                        } # End if ($_.length -le 2)
                    } # End foreach ($_ in $StorageConNameSplit) 
                    if ($StorageConNameInput -eq '0') { # If $StorageConNamInput is 0 (failed check)
                        Write-Host " " # Writes a message to screen, last action before restarting loop
                    } # End if ($StorageConNameInput -eq '0')
                    else { # All validation passed
                        if ($StorageConNameSplit.count -gt 1) { # If $StorageConNameSplit has more than one value
                            Write-Host "Create multiple storage containers with the following names" # Write message to screen
                            Write-Host $StorageConNameSplit -Separator `n # Writes all names to screen
                        } # End if ($StorageConNameSplit.count -gt 1)
                        else { # If $StorageConNameSplit has 1 value
                            Write-Host "Create a single storage account named"$StorageConName # Write message to screen
                            $StorageConNameSplit = $null  # Sets $StorageConNameSplit to $null
                        } # End else (if ($StorageConNameSplit.count -gt 1))
                        $OperatorConfirm = Read-Host "Yes or No" # Operator input for approving the name
                        if ($OperatorConfirm -eq 'y' -or $OperatorConfirm -eq 'yes') { # If $OperatorConfirm is equal to 'y' or 'yes'
                            Break SetAzureStorageConName # Breaks :SetAzureStorageConName
                        } # End if ($OperatorConfirm -eq 'y' -or $OperatorConfirm -eq 'yes')
                    } # End else (if ($StorageConNameInput -eq '0'))
                } # End else (if ($StorageConNameInput -eq '0'))
            } # End :SetAzureStorageConName while ($true)
            Write-Host "Container - Provides full read access to a container and its blobs." # Write message to screen
            Write-Host "Blob      - Provides read access to blob data throughout a container through" # Write message to screen
            Write-Host "            anonymous request, but does not provide access to container data." # Write message to screen
            Write-Host "Off       - Which restricts access to only the storage account owner." # Write message to screen
            $ValidRights = 'Container', 'Blob', 'Off' # List of valid rights input
            :SetAzureStorageConRights while ($true) { # Inner loop for setting the rights level
                $StorageConRightsInput = Read-Host "Container rights level" # Operator input for the rights level
                if ($StorageConRightsInput -eq 'exit') { # If $StorageConRightsInput is equal to 'exit'
                    Break NewAzureStorageCon # Breaks :NewAzureStorageCon
                } # End if ($StorageConRightsInput -eq 'exit')
                elseif ($StorageConRightsInput -iin $ValidRights) { # If $StorageConRightsInput is in $ValidRights list
                    Break SetAzureStorageConRights # Breaks :SetAzureStorageConRights
                } # End elseif ($StorageConRightsInput -iin $ValidRights)
                else { # All other inputs for $StorageConRightsInput
                    Write-Host 'That was not a valid input'# Write message to screen
                    Write-Host 'please select from the following'# Write message to screen
                    Write-Host $ValidRights -Separator `n # Writes $ValidRights list to screen
                } # End else (if ($StorageConRightsInput -eq 'exit'))
            } # End :SetAzureStorageConRights while ($true)
            if ($StorageConNameSplit) { # If StorageConNameSplit is not $null
                Write-Host "Creating storage containers, this may take a minute"# Write message to screen
                $StorageConNameSplit | New-AzStorageContainer -context $StorageAccObject.Context -Permission $StorageConRightsInput # Creates the storage containers
            } # End if ($StorageConNameSplit) 
            else { # If $StorageConNameSplit is $null
                New-AzStorageContainer -Name $StorageConName -context $StorageAccObject.Context -Permission $StorageConRightsInput # Creates to storage container
            } # End else (if ($StorageConNameSplit) )
            Return # Returns to calling function empty
        } # End :NewAzureStorageCon while ($true)
    } # End begin
} # End NewAzStorageContainer
function GetAzStorageContainer { # Collects storage container in a storage accoun
    Begin {
        $ErrorActionPreference='silentlyContinue'
        $StorageConObject = $null # Clears $StorageConObject from all previous use
        :GetAzureStorageContainer while ($true) { # Outer loop for managing function
            if (!$StorageAccObject) { # If $StorageAccObject is $null
                $StorageAccObject = GetAzStorageAccount # Call function and assigns to $var
                if (!$StorageAccObject) { # If $StorageAccObject is $null after returning from function
                    Break GetAzureStorageContainer # Breaks :GetAzureStorageContainer
                } # End if (!$StorageAccObject)
            } # End if (!$StorageAccObject)
            :GetAzureStorageConName while ($true) { # Inner loop for getting the storage container
                if (Get-AzResourceLock -AtScope -ResourceGroupName $StorageAccObject.ResourceGroupName | Where-Object {$_.Properties -like "@{Level=Read*"}) { # Checks for a ReadOnly lock on the owning resource group
                    Write-Host "There is a ReadOnly lock on"$StorageAccObject.ResourceGroupName"that is preventing the search of the storage container" # Write message to screen
                    Write-Host "This will need to be removed or converted to a CanNotDeleteLock" # Write message to screen
                    Break GetAzureStorageContainer # Break :GetAzureStorageContainer
                } # End if (Get-AzResourceLock -AtScope -ResourceGroupName $StorageAccObject.ResourceGroupName | Where-Object {$_.Properties -like "@{Level=Read*"}) 
                $StorageConNameInput = Read-Host "Storage container name" # Operator input for the storage container name
                if ($StorageConNameInput -eq 'exit') { # If $StorageConNameInput is 'exit'
                    Break GetAzureStorageContainer # Breaks :GetAzureStorageContainer
                } # End if ($StorageConNameInput -eq 'exit')
                if (!$StorageConNameInput) { # If $StorageConNameInput is $null
                    $StorageConNameInput = '0' # Sets a value that cannot be an existing storage container name
                } # End if (!$StorageConNameInput)
                $StorageConObject = Get-AzStorageContainer -Name $StorageConNameInput -Context $StorageAccObject.Context # Gets the storage container and assigns to $StorageConObject
                if ($StorageConObject) { # If $StorageConObject has a value
                    Return $StorageConObject, $StorageAccObject # Returns $StorageConObject to calling function
                } # End if ($StorageConObject)
                else { # If $StorageConObject is empty
                    Write-Host "The name provided does not match and existing storage container" # Write message to screen
                    $StorageConList = Get-AzStorageContainer -Context $StorageAccObject.Context # Gets list of all containers in storage account
                    Write-Host $StorageConList.Name -Separator `n # Writes $StorageConList list to screen
                    Write-Host " " # Write message to screen
                    Write-Host "Please re-enter the storage container name" # Write message to screen
                } # End else (if ($StorageConObject))
            } # End :GetAzureStorageConName while ($true)
        } # End :GetAzureStorageContainer while ($true)
        Return # Returns to calling function with $null
    } # End Begin
} # End function GetAzStorageContainer
function RemoveAzStorageContainer { # Removes existing storage container
    Begin {
        :RemoveAzureStorageCon while ($true) { # Outer loop for function
            <#if (!$StorageAccObject) { # If $StorageAccObject is $null
                $StorageAccObject = GetAzStorageAccount ($RGObject) # Calls function and assigns to $var
                    if (!$StorageAccObject) { # If $StorageAccObject is still $null after calling function
                        Break RemoveAzureStorageCon # Breaks :RemoveAzureStorageCon
                    } # End if (!$StorageAccObject)
            } # End if (!$StorageAccObject) #>
            if (!$StorageConObject) { # If $StorageConObject is $null
                $StorageConObject = GetAzStorageContainer ($StorageAccObject) # Calls function and assigns to $var
                    if (!$StorageConObject) { # If $StorageConObject is still $null after calling function
                        Break RemoveAzureStorageCon # Breaks :RemoveAzureStorageCon
                    } # End if (!$StorageAccObject)
            } # End if (!$StorageAccObject)
            Write-Host "***WARNING RESOURCELOCKS WILL NOT PROTECT THIS STORAGECONTAINER FROM BEING DELETED***"
            $OperatorConfirm = Read-Host "Remove the following storage container" $StorageConObject.Name "in" $StorageAccObject.StorageAccountName # Operator confimation to remove the storage container
                if (!($OperatorConfirm -eq 'y' -or $OperatorConfirm -eq 'yes')) { # If Operator confirm is not (equal 'y' or 'yes')
                    Break RemoveAzureStorageCon # Breaks RemoveAzureStorageCon
                } # End if (!($OperatorConfirm -eq 'y' -or $OperatorConfirm -eq 'yes'))
                $StoreConName = $StorageConObject.Name
                Try { # Try to execute Remove-AzStorageAccount
                    Remove-AzStorageContainer -Context $StorageAccObject.Context -Name $StorageConObject.Name -Force -ErrorAction Stop # Removes storage container, -ErrorAction Stop used for catch statement
                } # End Try
                catch { # Try fails
                    Write-Host "You may not have the permissions to remove this storage account" # Write message to screen
                    Break RemoveAzureStorageCon # Breaks RemoveAzureStorageAcc
                } # End Catch
                Write-Host $StoreConName" has been removed" # Write message to screen
                Return # Returns to calling function
        } # End :RemoveAzureStorageCon while ($true)
        Return # Returns to calling function
    } # End Begin
} # End function RemoveAzStorageContainer
function ManageAzStorageBlob { # Manages storage blob functions
    Begin {
        :ManageAzureStorageBlob while ($true) { # :ManageAzureStorageBlob named loop to select search function
            Write-Host "Azure Storage Blob Management" # Write message to screen
            Write-Host "1 Add Storage Blob" # Write message to screen
            Write-Host "2 List Storage Blobs" # Write message to screen
            Write-Host "3 Download Storage Blobs" # Write message to screen
            Write-Host "4 Remove Storage Blobs" # Write message to screen
            Write-Host "0 Unselect currently selected resources" # Write message to screen
            Write-Host "'Exit to return'" # Write message to screen
            $ManageAzStorageBlob = Read-Host "Option?" # Collects operator input on $ManageAzStorageBlob option
            if ($ManageAzStorageBlob -eq 'exit') { # Exit if statement for this function
                Break ManageAzureStorageBlob # Ends :ManageAzureStorageBlob loop, leading to return statement
            } # End if ($ManageAzStorageBlob -eq 'exit')
            elseif ($ManageAzStorageBlob -eq '1') { # Elseif statement for managing storage accounts
                Write-Host "Add Storage Blob" # Write message to screen
                $StorageBlobObject = SetAzStorageBlobContent ($StorageAccObject, $StorageConObject) # Calls function and assigns to $var 
            } # End elseif ($ManageAzStorageBlob -eq '1')
            elseif ($ManageAzStorageBlob -eq '2') { # Elseif statement for managing storage containers
                Write-Host "List Storage Blobs" # Write message to screen
                $StorageBlobObject, $StorageAccObject, $StorageConObject = ListAzStorageBlob ($StorageAccObject, $StorageConObject) # Calls function and assigns to $var 
            } # End elseif ($ManageAzStorageBlob -eq '2')
            elseif ($ManageAzStorageBlob -eq '3') { # Elseif statement for managing Blobs
                Write-Host "Download Storage Blobs" # Write message to screen
                $StorageBlobObject = GetAzStorageBlobContent ($StorageAccObject, $StorageConObject, $StorageBlobObject) # Calls function and assigns to $var 
            } # End elseif ($ManageAzStorageBlob -eq '3')
            elseif ($ManageAzStorageBlob -eq '4') { # Elseif statement for managing file shares
                Write-Host "Remove Storage Blobs" # Write message to screen
                RemoveAzStorageBlob ($StorageAccObject, $StorageConObject, $StorageBlobObject) # Calls function and assigns to $var
            } # End elseif ($ManageAzStorageBlob -eq '4')
            elseif ($ManageAzStorageBlob -eq '0') { # Elseif statement for managing disks
                if ($RGObject) { # If $var is not $null
                Write-Host "Clearing" $RGObject.ResourceGroupName # Write message to screen
                $RGObject = $null # Sets $var to $null
                } # End if ($RGObject)
                if ($StorageAccObject) { # If $var is not $null
                Write-Host "Clearing" $StorageAccObject.StorageAccountName # Write message to screen
                $StorageAccObject = $null # Sets $var to $null
                } # End if ($StorageAccObject)
                if ($StorageConObject) { # If $var is not $null
                Write-Host "Clearing" $StorageConObject.Name # Write message to screen
                $StorageConObject = $null # Sets $var to $null
                } # End if ($StorageConObject)
                if ($StorageBlobObject) { # If $var is not $null
                Write-Host "Clearing" $StorageBlobObject.Name # Write message to screen
                $StorageBlobObject = $null # Sets $var to $null
                } # End if ($StorageBlobObject)
                Write-Host "All objects have been cleared" # Write message to screen
            } # End elseif ($ManageAzStorageBlob -eq '0')
            if ($RGObject) { # If $var is not $null
                Write-Host "Current Resource Group:    " $RGObject.ResourceGroupName # Write message to screen
            } # End if ($RGObject)
            if ($StorageAccObject) { # If $var is not $null
                Write-Host "Current Storage Account:   " $StorageAccObject.StorageAccountName # Write message to screen
            } # End if ($StorageAccObject)
            if ($StorageConObject) { # If $var is not $null
                Write-Host "Current Storage Container: " $StorageConObject.Name # Write message to screen
            } # End if ($StorageConObject)
            if ($StorageBlobObject) { # If $var is not $null
                Write-Host "Current Storage Blob(s):   " $StorageBlobObject.Name # Write message to screen
            } # End if ($StorageBlobObject)
            Write-Host "" # Write message to screen
        } # End :ManageAzureStorageBlob while ($true)
        Return # Returns to calling function if no search option is used
    } # End begin
} # End function ManageAzStorage
function SetAzStorageBlobContent {
    Begin {
        :SetAzureBlobContent while ($true) { # Outer loop for managing function
            if (!$StorageConObject) { # If $var is $null
                $StorageConObject, $StorageAccObject = GetAzStorageContainer # Calls function and assigns to $var
                if (!$StorageConObject) { # If $var is $null
                    Break SetAzureBlobContent
                } # End if (!$StorageConObject)
            } # End if (!$StorageConObject)
            :SetAzureBlobTier while($true) { # Inner loop for setting access tier
                $BlobTierInput = Read-Host "Hot or Cool" # Operator input for $BlobTierInput
                if ($BlobTierInput -eq 'hot' -or $BlobTierInput -eq 'cool') { # If $Var is a valid entry
                    Break SetAzureBlobTier
                } # End if ($BlobTierInput -eq 'hot' -or $BlobTierInput -eq 'cool')
                elseif ($BlobTierInput -eq 'exit') { # If $Var is 'exit'
                    Break SetAzureBlobContent
                } # End elseif ($BlobTierInput -eq 'exit')
                else { # Else if no valid entry for $Var
                    Write-Host "Please enter hot or cool" # Write message to screen
                } # End else (if ($BlobTierInput -eq 'hot' -or $BlobTierInput -eq 'cool'))
            } # End :SetAzureBlobTier while($true)
            :SetLocalFileName while ($true) {
                $LocalFileNameInput = Read-Host "Full path and filename" # Collects the path to file, example: C:\users\Admin\Documents\Blobupload.txt
                if ($LocalFileNameInput -eq 'exit') { # If $Var is 'exit'
                    Break SetAzureBlobContent
                } # End if ($LocalFileNameInput -eq 'exit')
                Write-Host "This is the file to be uploaded" # Write message to screen
                Write-Host $LocalFileNameInput
                $OperatorConfirm = Read-Host "[Y] or [N]"
                if ($OperatorConfirm -eq 'y' -or $OperatorConfirm -eq 'yes') {
                    Break SetLocalFileName
                } # End if ($OperatorConfirm -eq 'y' -or $OperatorConfirm -eq 'yes')
            } # End :SetLocalFileName while ($true)
            :SetAzureBlobName while ($true) {
                $BlobFileNameInput = Read-Host "New name and ext for this file" # Collects the new name and ext for the file that will be used in the storage account, example: SuperAwesomeBlob.jpg
                if ($BlobFileNameInput -eq 'exit') { # If $Var is 'exit'
                    Break SetAzureBlobContent
                } # End if ($BlobFileNameInput -eq 'exit')
                Write-Host "This will be the file name in the container" # Write message to screen
                Write-Host $BlobFileNameInput # Write message to screen
                $OperatorConfirm = Read-Host "[Y] or [N]"
                if ($OperatorConfirm -eq 'y' -or $OperatorConfirm -eq 'yes') {
                    Break SetAzureBlobName
                } # End if ($OperatorConfirm -eq 'y' -or $OperatorConfirm -eq 'yes')
            } # End :SetAzureBlobName while ($true)
            $StorageBlobObject = Set-AzStorageBlobContent -File $LocalFileNameInput -Blob $BlobFileNameInput -Container $StorageConObject.Name -Context $StorageAccObject.Context -StandardBlobTier $BlobTierInput
            Return $StorageBlobObject 
        } # End  :SetAzureBlobContent while ($true)
        Return # Returns to calling function with $null
    } # End Begin
} # End function SetAzStorageBlobContent
function ListAzStorageBlob {
    Begin {
        $ErrorActionPreference = 'silentlyContinue' # Disables error messages
        :ListAzureBlobs while ($true) { # Outer loop for managing function
            if (!$StorageConObject) { # If $var is $null
                $StorageConObject, $StorageAccObject = GetAzStorageContainer # Calls function and assigns to $var
                if (!$StorageConObject) { # If $var is $null
                    Break ListAzureBlobs
                } # End if (!$StorageConObject)
            } # End if (!$StorageConObject)
            $OperatorSelect = Read-Host "Search for a named blob [Y] or [N]"
            if ($OperatorSelect -eq 'y' -or $OperatorSelect -eq 'yes') {
                :GetAzureBlob while ($true) {
                    $StorageBlobNameInput = Read-Host "Blob name (Case Sensitive)"
                    if ($StorageBlobNameInput -eq 'exit') { # If $Var is 'exit'
                        Break ListAzureBlobs
                    } # End if ($StorageBlobNameInput -eq 'exit')
                    $StorageBlobObject = Get-AzStorageBlob -Blob $StorageBlobNameInput -Context $StorageAccObject.context -Container $StorageConObject.Name # Object containing the blob info objects
                    if (!$StorageBlobObject) { # If $Var is $null
                        Write-Host "No blobs names matched" # Write message to screen
                        Write-Host "Please chose from the following" # Write message to screen
                        $StorageBlobList = Get-AzStorageBlob -Context $StorageAccObject.context -Container $StorageConObject.Name # Object containing the blob info objects
                        Write-Host $StorageBlobList.Name -Separator `n # Write message to screen
                        Write-Host "" # Write message to screen
                    } # End if (!$StorageBlobObject)
                    else {
                        Write-Host $StorageBlobObject.Name $StorageBlobObject.Length $StorageBlobObject.LastModified $StorageBlobObject.AccessTier # Write message to screen 
                        Return $StorageBlobObject, $StorageAccObject, $StorageConObject
                    } # End else (if (!$StorageBlobObject))
                } # End :GetAzureBlob while ($true)
            } # End if ($OperatorSelect -eq 'y' -or $OperatorSelect -eq 'yes')
            else {
                $StorageBlobObject = Get-AzStorageBlob -Context $StorageAccObject.context -Container $StorageConObject.Name # Object containing the blob info objects
                foreach ($Name in $StorageBlobObject) {
                    Write-Host $Name.Name $Name.Length $Name.LastModified $Name.AccessTier # Write message to screen
                } # End foreach ($Name in $StorageBlobList)
                Return $StorageBlobObject, $StorageAccObject, $StorageConObject
            } # End else (if ($StorageBlobNameInput))
        } # End :ListAzureBlobs while
        Return # Returns to calling function empty
    } # End Begin
} # End function GetAzStorageBlob
function GetAzStorageBlobContent {
    Begin {
        $ErrorActionPreference = 'silentlyContinue' # Disables error messages
        :GetAzureBlobs while ($true) { # Outer loop for managing function
            if (!$StorageBlobObject) { # If $var is $null
                $StorageAccObject = GetAzStorageAccount # Calls function and assigns to $var
                if (!$StorageAccObject) { # If $var is $null
                    Break GetAzureBlobs
                } # End if (!$StorageConObject)
                $StorageConObject = GetAzStorageContainer ($StorageAccObject) # Calls function and assigns to $var
                if (!$StorageConObject) { # If $var is $null
                    Break GetAzureBlobs
                } # End if (!$StorageConObject)
                $StorageBlobObject = ListAzStorageBlob ($StorageAccObject, $StorageConObject) # Calls function and assigns to $var
                if (!$StorageBlobObject) { # If $var is $null
                    Break GetAzureBlobs
                } # End if (!$StorageConObject)
            } # End if (!$StorageConObject)
            :SetLocalFilePath while ($true) {
                $LocalFileDownloadPath = Read-Host "Path to download file to" # Operator input for the destination folder
                if ($LocalFileDownloadPath -eq 'exit') { # If $Var is 'exit'
                    Break GetAzureBlobs
                } # End if ($LocalFileDownloadPath -eq 'exit')
                Write-Host "Download blobs to"$LocalFileDownloadPath # Write message to screen
                $OperatorConfirm = Read-Host "[Y] or [N]"
                if ($OperatorConfirm -eq 'y' -or $OperatorConfirm -eq 'yes') {
                    Break SetLocalFilePath
                } # End if ($OperatorConfirm -eq 'y' -or $OperatorConfirm -eq 'yes')
            } # End :SetLocalFilePath while ($true)
            Try {
                foreach ($Name in $StorageBlobObject) {
                    Get-AzStorageBlobContent -Context $StorageAccObject.context -Container $StorageConObject.Name -Blob $Name.Name -Destination $LocalFileDownloadPath
                } # End foreach ($Name in $StorageBlobObject)
            }
            catch {Write-Host "An error has occured"}
            Return $StorageBlobObject
        } # End while statement
        Return # Returns to calling function
    } # End Begin
} # End function GetAzStorageBlobContent
function RemoveAzStorageBlob {
    Begin {
        $ErrorActionPreference = 'silentlyContinue' # Disables error messages
        :RemoveAzureBlobs while ($true) { # Outer loop for managing function
            if (!$StorageBlobObject) { # If $var is $null
                $StorageAccObject = GetAzStorageAccount # Calls function and assigns to $var
                if (!$StorageAccObject) { # If $var is $null
                    Break RemoveAzureBlobs
                } # End if (!$StorageConObject)
                $StorageConObject = GetAzStorageContainer ($StorageAccObject) # Calls function and assigns to $var
                if (!$StorageConObject) { # If $var is $null
                    Break RemoveAzureBlobs
                } # End if (!$StorageConObject)
                $StorageBlobObject = ListAzStorageBlob ($StorageAccObject, $StorageConObject) # Calls function and assigns to $var
                if (!$StorageBlobObject) { # If $var is $null
                    Break RemoveAzureBlobs
                } # End if (!$StorageConObject)
            } # End if (!$StorageConObject)
            foreach ($Name in $StorageBlobObject) {
                $ConfirmDelete = Read-Host "Do you want to delete"$Name.Name # Operator input to confirm delete
                if ($ConfirmDelete -eq 'exit') { # If $Var is 'exit'
                    Break RemoveAzureBlobs
                } # End if ($ConfirmDelete -eq 'exit')
                if ($ConfirmDelete -eq 'y' -or $ConfirmDelete -eq 'yes') { # Check that operator input is 'y' or 'yes'
                    Remove-AzStorageBlob -Blob $Name.Name -Container $StorageConObject.Name -Context $StorageAccObject.Context # Removes the selected blob
                    Write-Host $Name.Name"has been deleted"  # Write message to screen
                } # End if statement
                else { # If $ConfirmDelete is not 'y' or 'yes'
                    Write-Host $Name.Name "was not deleted"  # Write message to screen
                } # End else statement
            } # End foreach ($Name in $StorageBlobObject)
            $StorageBlobObject = $null # Sets $var to $null
            Return
        } # End RemoveAzureBlobs
        Return
    } # End Begin
} # End function RemoveAzStorageBlob
function ManageAzStorageShare { # Manages storage blob functions
    Begin {
        :ManageAzureStorageShares while ($true) { # :ManageAzureStorageShares named loop to select search function
            Write-Host "Azure Storage Share Management" # Write message to screen
            Write-Host "1 New Storage Share" # Write message to screen
            Write-Host "2 Get Storage Share" # Write message to screen
            Write-Host "3 List All Storage Shares" # Write message to screen
            Write-Host "4 Remove Storage Share" # Write message to screen
            Write-Host "5 Manage Storage Share Contents" # Write message to screen
            Write-Host "0 Unselect currently selected resources" # Write message to screen
            Write-Host "'Exit to return'" # Write message to screen
            $ManageAzStorageShare = Read-Host "Option?" # Collects operator input on $ManageAzStorageShare option
            if ($ManageAzStorageShare -eq 'exit') { # Exit if statement for this function
                Break ManageAzureStorageShares # Ends :ManageAzureStorageShares loop, leading to return statement
            } # End if ($ManageAzStorageShare -eq 'exit')
            elseif ($ManageAzStorageShare -eq '1') { # Elseif statement for managing storage accounts
                Write-Host "New Storage Share" # Write message to screen
                $StorageShareObject = NewAzStorageShare ($StorageAccObject, $RGObject) # Calls function and assigns to $var 
                Write-Host $StorageShareObject.Name
            } # End elseif ($ManageAzStorageShare -eq '1')
            elseif ($ManageAzStorageShare -eq '2') { # Elseif statement for managing storage containers
                Write-Host "Get Storage Share" # Write message to screen
                $StorageShareObject, $StorageAccObject = GetAzStorageShare ($StorageAccObject, $RGObject) # Calls function and assigns to $var 
            } # End elseif ($ManageAzStorageShare -eq '2')
            elseif ($ManageAzStorageShare -eq '3') { # Elseif statement for managing Blobs
                Write-Host "List All Storage Shares" # Write message to screen
                GetAzStorageShareAll # Calls function 
            } # End elseif ($ManageAzStorageShare -eq '3')
            elseif ($ManageAzStorageShare -eq '4') { # Elseif statement for managing Storage shares
                Write-Host "Remove Storage Share" # Write message to screen
                RemoveAzStorageShare ($StorageAccObject, $StorageShareObject) # Calls function and assigns to $var
            } # End elseif ($ManageAzStorageShare -eq '4')
            elseif ($ManageAzStorageShare -eq '0') { # Elseif statement for managing disks
                if ($RGObject) { # If $var is not $null
                Write-Host "Clearing" $RGObject.ResourceGroupName # Write message to screen
                $RGObject = $null # Sets $var to $null
                } # End if ($RGObject)
                if ($StorageAccObject) { # If $var is not $null
                Write-Host "Clearing" $StorageAccObject.StorageAccountName # Write message to screen
                $StorageAccObject = $null # Sets $var to $null
                } # End if ($StorageAccObject)
                if ($StorageShareObject) { # If $var is not $null
                Write-Host "Clearing" $StorageShareObject.Name # Write message to screen
                $StorageShareObject = $null # Sets $var to $null
                } # End if ($StorageBlobObject)
                Write-Host "All objects have been cleared" # Write message to screen
            } # End elseif ($ManageAzStorageShare -eq '0')
            Write-Host "" # Write message to screen
            if ($RGObject) { # If $var is not $null
                Write-Host "Current Resource Group:    " $RGObject.ResourceGroupName # Write message to screen
            } # End if ($RGObject)
            if ($StorageAccObject) { # If $var is not $null
                Write-Host "Current Storage Account:   " $StorageAccObject.StorageAccountName # Write message to screen
            } # End if ($StorageAccObject)
            if ($StorageShareObject) { # If $var is not $null
                Write-Host "Current Storage Share:   " $StorageShareObject.Name # Write message to screen
            } # End if ($StorageBlobObject)
            Write-Host "" # Write message to screen
        } # End :ManageAzureStorageShares while ($true)
        Return # Returns to calling function if no search option is used
    } # End begin
} # End function ManageAzStorage
function NewAzStorageShare { # Creates a new storage share
    Begin {
        :NewAzureStorageShare while ($true) { # Outer loop for managing function
            if (!$StorageAccObject) { # If $var is $null
                $StorageAccObject = GetAzStorageAccount ($RGObject) # Calls function and assigns to $var
                if (!$StorageAccObject) { # If $var is $null
                    Break NewAzureStorageShare # Breaks :NewAzureStorageShare
                } # End if (!$StorageAccObject)
            } # End if (!$StorageAccObject)
            :SetAzureShareName while ($true) { # Inner loop for setting the name of the new share
                Try { # First validation of the storage share name
                    Write-Host "Storage share name must be atleast 3 characters and made up of letters and numbers only" # Write message to screen
                    [ValidatePattern('^[a-z,0-9,\s]+$')]$ShareNameInput = [string](Read-Host "New Storage share name").ToLower() # Operator input for the share name
                } # End Try 
                catch { # Catch for failing to meet character validation of the share name
                    Write-Host "***Error***"  # Write message to screen
                    Write-Host "The provided name was not valid, accepted inputs are letters and numbers only" # Write message to screen
                    Write-Host "***Error***" # Write message to screen
                    $ShareNameInput = '0' # Sets $ShareNameInput value to a failed check to reset loop
                } # End Catch
                if ($ShareNameInput.Length -le 2) { # If $ShareNameInput is less than 3 charaters
                    Write-Host "***Error***" # Write message to screen
                    Write-Host "The name entered is invalid, the minimum length of a name is 3 characters" # Write message to screen
                    Write-Host "***Error***" # Write message to screen
                    $ShareNameInput = '0' # Sets $ShareNameInput value to a failed check to reset loop
                } # End if ($ShareNameInput.Length -le 2)
                $ShareNameSplit = $ShareNameInput.split() # Creates $ShareNameSplit, a list of entries for each space in $ShareNameInput
                if ($ShareNameSplit.Count -gt 1) { # If $ShareNameSplit is greater than 1 value
                    Write-Host "***Error***" # Write message to screen
                    Write-Host "The name entered is invalid, no spaces are allowed in the name" # Write message to screen
                    Write-Host "***Error***" # Write message to screen
                    $ShareNameInput = '0' # Sets $ShareNameInput value to a failed check to reset loop
                } # End if ($ShareNameSplit.Count -gt 1)
                $ShareNameSplit = $null  # Sets $StorageConNameSplit to $null
                if ($ShareNameInput -eq '0') { # If $ShareNameInput is 0 (failed check)
                    Write-Host " " # Writes a message to screen, last action before restarting loop
                } # End if ($ShareNameInput -eq '0')
                else { # All checks on $ShareNameInput passed
                    Write-Host "This will be the share name" # Write message to screen
                    Write-Host $ShareNameInput # Write message to screen
                    $OperatorConfirm = Read-Host "[Y] or [N]" # Operator confirmation on using this name
                    if ($OperatorConfirm -eq 'y' -or $OperatorConfirm -eq 'yes') { # If $OperatorConfrim is equal to 'y' or 'yes'
                        Break SetAzureShareName # Breaks :SetAzureShareName
                    } # End if ($OperatorConfirm -eq 'y' -or $OperatorConfirm -eq 'yes')
                } # End else (if ($ShareNameInput.Length -le 2))
            } # End :SetAzureShareName while ($true)
            $StorageShareObject = New-AzStorageShare -Name $ShareNameInput -Context $StorageAccObject.Context # Creates the storage share and assigns to $StorageShareObject
            Return $StorageShareObject # Returns to calling function with $StorageShareObject
        } # End :NewAzureStorageShare while ($true)
        Return # Returns to calling function with $null
    } # End Begin
} # End function NewAzStorageShare
Function GetAzStorageShare { # Gets a storage share
    Begin {
        :GetAzureStorageShare while ($true) { # Outer loop for managing function
            if (!$StorageAccObject) { # If $var is $null
                $StorageAccObject = GetAzStorageAccount ($RGObject) # Calls function and assigns to $var
                if (!$StorageAccObject) { # If $var is $null
                    Break GetAzureStorageShare # Breaks :GetAzureStorageShare
                } # End if (!$StorageAccObject) 
            } # End if (!$StorageAccObject) {
            $StorageShareList = Get-AzStorageShare -Context $StorageAccObject.Context # Collects all shares in selected storage account
            if (!$StorageShareList) { # If $StorageSharelist returns empty
                Write-Host "No storage shares found" # Message write to screen
                Break GetAzureStorageShare # Ends :GetAzureStorageShare
            } # End if (!$StorageShareList)
            $StorageShareListNumber = 1 # Sets the base value of $StorageShareListNumber
            Write-Host "0. Exit" # Writes exit option to screen
            foreach ($_ in $StorageShareList) { # For each item in $StorageShareList
                Write-Host $StorageShareListNumber"." $_.Name # Writes $StorageShareList to screen
                $StorageShareListNumber = $StorageShareListNumber+1 # Adds 1 to $StorageShareListNumber
            } # End foreach ($_ in $StorageShareList)
            :GetAzureStorageShareNumber while ($true) {
                $StorageShareListNumber = 1 # Sets the base value of $StorageShareListNumber
                $StorageShareListSelect = Read-Host "Please enter the number of the storage share" # Operator input for the storage share selection
                if ($StorageShareListSelect -eq '0') { # If $StorageShareList is '0'
                    Break :GetAzureStorageShare # Ends :GetAzureStorageShare
                } # if ($StorageShareListSelect -eq '0')
                foreach ($_ in $StorageShareList) { # For each item in $StorageShareList
                    if ($StorageShareListSelect -eq $StorageShareListNumber) { # If the operator input matches the current $StorageShareListNumber
                        $StorageShareObject = $_ # Assigns current item in $StorageShareList to $StorageShareObject
                        Break GetAzureStorageShareNumber # Breaks :GetAzureStorageShare
                    } # End if ($StorageShareListSelect -eq $StorageShareListNumber)
                    else { # If user input does not match the current $StorageShareListNumber
                        $StorageShareListNumber = $StorageShareListNumber+1 # Adds 1 to $StorageShareListNumber
                    } # End else (if ($StorageShareListSelect -eq $StorageShareListNumber))
                } # End foreach ($_ in $StorageShareList)
                Write-Host "That was not a valid entry" # Write message to screen
            } # End :GetAzureStorageShare while ($true) {
            Return $StorageShareObject # Returns to calling function with $StorageShareObject
        } # End :GetAzureStorageShare while ($true)
        Return # Returns $null
    } # End Begin
} # End Function GetAzStorageShare
Function GetAzStorageShareAll { # Lists all storage shares in a subscription
    Begin {
        $StorageAccObject = Get-AzStorageAccount # Collects all storage accounts in the subscription
        foreach ($Name in $StorageAccObject) { # For each name in $StorageAccObject
            Write-Host "Resource Group:"$Name.ResourceGroupName # Write message to screen
            Write-Host "Storage Account:"$Name.StorageAccountName # Write message to screen
            Try { # Try to get storage shares within a storage account
                $StorageShareObject = Get-AzStorageShare -Context $Name.Context # Collects all storage shares in a storage account
            } # End Try
            Catch { # If Try fails
                Write-Host "Permissions or locks prevent a search in this storage account" # Write message to screen
                $StorageShareObject = $null # Clears $StorageShareObject
            } # End Catch
            foreach ($Name in $StorageShareObject) { # For each name in $StorageShareObject
                Write-Host "Storage Share:"$Name.Name # Write message to screen
            } # End foreach ($Name in $StorageShareObject)
            Write-Host "" # Write message to screen
        } # End foreach ($Name in $StorageAccObject) 
        Return # Returns nothing
    } # End Begin
} # End Function GetAzStorageShareAll
function RemoveAzStorageShare { # Removes a storage share
    Begin {
        if (!$StorageAccObject) { # If $StorageAccObject is $null
            $StorageAccObject = GetAzStorageAccount # Call function and assign result to $var
            if (!$StorageAccObject) { # If $StorageAccObject is $null
                Return # Returns to calling function with $null
            } # End if (!$StorageAccObject)
        } # End if (!$StorageShareObject)
        if (!$StorageShareObject) { # If $StorageShareObject is $null 
            $StorageShareObject = GetAzStorageShare ($StorageAccObject) # Call function and assign result to $var
            if (!$StorageShareObject) { # If $StorageShareObject is $null 
                Return # Returns to calling function with $null
            } # End if (!$StorageShareObject)
        } # End if (!$StorageShareObject)
        Write-Host "Remove the storage share:"$StorageShareObject.Name"in storage account:"$StorageAccObject.StorageAccountName # Write message to screen
        $OperatorConfirm = Read-Host "[Y] or [N]" # Operator confirmation to remove storage share
        if ($OperatorConfirm -eq 'y' -or $OperatorConfirm -eq 'yes') { # If $OperatorConfirm is equal to 'y' or 'yes'
            Try { # Try to do the following
                Remove-AzStorageShare -Name $StorageShareObject.Name -Context $StorageAccObject.Context # Remove the selected share
            } # End Try
            Catch { # If try fails
                Write-Host "" # Write message to screen
                Write-Host "The storage share was not removed, you may not have the permissions to do so" # Write message to screen
                Write-Host "" # Write message to screen
                Return # Returns to calling function with $null
            } # End Catch
            Write-Host "" # Write message to screen
            Write-Host "The storage share was removed" # Write message to screen
            Write-Host "" # Write message to screen
            Return # Returns to calling function with $null
        } # End if ($OperatorConfirm -eq 'y' -or $OperatorConfirm -eq 'yes')
        else { # Returns to calling function with $null
            Write-Host "No action taken, returning to menu" # Write message to screen
            Return # Returns to calling function with $null
        } # End else (if ($OperatorConfirm -eq 'y' -or $OperatorConfirm -eq 'yes'))
    } # End Begin
} # End function RemoveAzStorageShare
function ManageAzKeyVault { # Script for managing Azure
    Begin {
        :ManageAzureKeyVault while ($true) { # Outer loop for managing function
            if ($RGObject) { # If $RGObject has a value
                Write-Host '$RGObject:' $RGObject.ResourceGroupName # Write message to screen 
            } # End if ($RGObject)
            if ($KeyVaultObject) { # If $KeyVaultObject has a value
                Write-Host '$KeyVaultObject:' $KeyVaultObject.VaultName # Write message to screen
            } # End if ($KeyVaultObject)
            if ($RGObject -or $KeyVaultObject) { # If $RGObject or $KeyVault Object has a value
                Write-Host '0 to clear $RGObject and $KeyVaultObject' # Write message to screen
            } # End if ($RGObject -or $KeyVaultObject)
            Write-Host "1 New Key Vault" # Write message to screen
            Write-Host "2 List All Key Vaults" # Write message to screen
            Write-Host "3 Get Key Vault" # Write message to screen
            Write-Host "4 Remove Key Vault" # Write message to screen
            Write-Host "5 Manage Key Vault Keys" # Write message to screen
            Write-Host "6 Manage Key Vault Secrets" # Write message to screen
            Write-Host "'Exit' to end script" # Write option list to screen
            $ManageAzKeyVaultSelect = Read-Host "Chose option" # Operator input for which option they need to run
            if ($ManageAzKeyVaultSelect -eq '1') { # Elseif statement for option 1
                Write-Host "New Key Vault" # Option selection write to screen
                $KeyVaultObject = NewAzKeyVault ($RGObject) # Calls function NewAzKeyVault
            } # End if statement
            elseif ($ManageAzKeyVaultSelect -eq '2') { # Elseif statement for option 2
                Write-Host "List All Key Vaults" # Option selection write to screen
                ListAzKeyVault # Calls function ListAzKeyVault
            } # End elseif statement
            elseif ($ManageAzKeyVaultSelect -eq '3') { # Elseif statement for option 3
                Write-Host "Get Key Vault" # Option selection write to screen
                $KeyVaultObject = GetAzKeyVault ($RGObject) # Calls function GetAzKeyVault
            } # End elseif statement
            elseif ($ManageAzKeyVaultSelect -eq '4') { # Elseif statement for option 4
                Write-Host "Remove Key Vault" # Option selection write to screen
                RemoveAzKeyVault ($KeyVaultObject) # Calls function RemoveAzKeyVault
            } # End elseif statement
            elseif ($ManageAzKeyVaultSelect -eq '5') { # Elseif statement for option 5
                Write-Host "Manage Key Vault Keys" # Option selection write to screen
                ManageAzKeyVaultKey ($RGObject, $KeyVaultObject) # Calls function ManageAzKeyVaultKey
            } # End elseif statement
            elseif ($ManageAzKeyVaultSelect -eq '6') { # Elseif statement for option 6
                Write-Host "Manage Key Vault Secrets" # Option selection write to screen
                ManageAzKeyVaultSecret ($RGObject, $KeyVaultObject) # Calls function ManageAzKeyVaultSecret
            } # End elseif statement
            elseif ($ManageAzKeyVaultSelect -eq '0') { # Elseif statement for option 0
                $RGObject = $null # Sets $var to $null
                $KeyVaultObject = $null # Sets $var to $null
                Write-Host '$RGObject and $KeyVaultObject have been cleared'
            } # End elseif ($ManageAzKeyVaultSelect -eq '0')
            elseif ($ManageAzKeyVaultSelect -eq 'exit') { # Elseif statement for ending the srcipt
                Break ManageAzureKeyVault # Breaks :ManageAzureKeyVault
            } # End elseif statement
            else { # Esle statement for all other values
                Write-Host "Invalid option" # Option selection write to screen
            } # End else statement
        } # End :ManageAzureKeyVault while ($true)
        Return # Returns to calling function with $null
    } # End begin statemnt
} # End ManageAzKeyVault
function NewAzKeyVault { # Creates a new key vault
    Begin {
        $ErrorActionPreference='silentlyContinue' # Turns off error reporting
        :NewAzureKeyVault while ($true) { # Outer loop for managing function
            if (!$RGObject) { # If $RGObject is $null
                $RGObject = GetAzResourceGroup  # Calls GetAzResourceGroup and assigns to $RGObject
                if (!$RGObject) { # If $RGObject is still $null
                    Break NewAzureKeyVault # Breaks NewAzureKeyVault loop
                } # End if (!$RGObject)
            } # End if (!$RGObject)
            :SetAzureKeyVaultName while ($true) { # Inner loop for setting the key vault name
                $KeyVaultNameInput = '0' # Assigns a value for elseif statement if operator input is invalid
                try { # Try statement for operator input of vault name
                    [ValidatePattern('^[a-z,0-9]+$')]$KeyVaultNameInput = [string](Read-Host "New vault name (3-24 letters and numbers only)") # Operator input for the vault name, only allows letters and numbers. All letters converted to lowercase
                } # End try
                catch {Write-Host "The vault name can only include letters and numbers"} # Error message for failed try
                if ($KeyVaultNameInput -eq 'exit') { # $KeyVaultNameInput is equal to exit
                    Break NewAzureKeyVault # Breaks NewAzureKeyVault loop
                } # if ($KeyVaultNameInput -eq 'exit')
                elseif ($KeyVaultNameInput -eq '0') {}# Elseif when Try statement fails
                elseif ($KeyVaultNameInput.Length -le 2 -or $KeyVaultNameInput.Length -ge 25) { # If $KeyVaultNameInput is not between 3 and 24 characters
                    Write-Host "The vault name must be between 3 and 24 characters in length" # Write message to screen
                } # End elseif ($KeyVaultNameInput.Length -le 2 -or $KeyVaultNameInput.Length -ge 25)
                else { # If Try statement input has value not equal to exit
                    Write-Host $KeyVaultNameInput # Writes $var to screen
                    $OperatorConfirm = Read-Host "Is this name correct [Y] or [N]" # Operator confirmation
                    if ($OperatorConfirm -eq 'y' -or $OperatorConfirm -eq 'yes') { # If $OperatorConfirm is equal to 'y' or 'yes'
                        Break SetAzureKeyVaultName # Breaks SetAzureKeyVaultName
                    } # End If ($OperatorConfirm -eq 'y' -or $OperatorConfirm -eq 'yes')
                    else {} # If $OperatorConfirm is not -eq 'y' or 'yes;
                } # End else (if ($KeyVaultNameInput -eq 'exit'))
            } # :SetAzureKeyVaultName while ($true)
            $ValidLocation = Get-AzLocation # Collects the list of all valid Azure locations
            :SetAzureKeyVaultLoc while ($true) { # Inner loop for setting the vault location
                $KeyVaultLocInput = Read-Host "New key vault location" # Operator input for the vault location
                if ($KeyVaultLocInput -eq 'exit') { # If $KeyVaultLocInput is 'exit'
                    Break NewAzureKeyVault # Breaks :NewAzureKeyVault
                } # if ($KeyVaultNameInput -eq 'exit')
                if ($KeyVaultLocInput -iin $ValidLocation.Location) { # if $KeyVaultLocInput is in $ValidLocation.Location (Case insensitive)
                    Write-Host $KeyVaultLocInput # Write $KeyVaultLocInput to screen
                    $OperatorConfirm = Read-Host "Is the location correct [Y] or [N]" # Operator confirmation
                    if ($OperatorConfirm -eq 'y' -or $OperatorConfirm -eq 'yes') { # If $OperatorConfirm is equal to 'y' or 'yes'
                        Break SetAzureKeyVaultLoc # Breaks :SetAzureKeyVaultLoc
                    } # End if ($OperatorConfirm -eq 'y' -or $OperatorConfirm -eq 'yes')
                } # End if ($KeyVaultLocInput -iin $ValidLocation)
                else { # All other inputs for $KeyVaultLocInput
                    Write-Host "The location provided is not valid" # Write message to screen
                    Write-Host "Select from the following" # Write message to screen
                    Write-Host "" # Write message to screen
                    Write-Host $ValidLocation.Location -Separator `n # Writes $ValidLocation.Location to screen
                } # End else (if ($KeyVaultLocInput -iin $ValidLocation))
            } # End :SetAzKeyVaultLoc while ($true)
            $KeyVaultObject = New-AzKeyVault -ResourceGroupName $RGObject.ResourceGroupName -Location $KeyVaultLocInput -Name $KeyVaultNameInput # Creates the new key vault and assigns to $KeyVaultObject
            Return $KeyVaultObject # Returns $var to calling function
        } # End :NewAzureKeyVault while ($true)
        Break # Returns to calling function empty
    } # End Begin
} # End function NewAzkeyvault
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
                        $KeyVaultObject = $_ # Currently selected item in $KVList is assigned to $KeyVaultObject
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
function ListAzKeyVault { # Lists all key vaults in subscription
    Begin {
        #$ErrorActionPreference = 'silentlyContinue' # Disables error reporting
        $KVList = Get-AzKeyVault # Gets all key vaults and assigns to $KVList
        if (!$KVList) { # If $KVList returns empty
            Write-Host "No key vaults found" # Message write to screen
        } # End if (!$KVList)
        else { # If $KVList has a value
            foreach ($_ in $KVList) { # For each item in $KVList
                Write-Host "VaultName:" $_.VaultName "ResourceGroup:" $_.ResourceGroupName # Write message to screen 
            } # End else 
        } # End else (if (!$KVList))
        Return # Returns to calling function with $null
    } # End Begin
} # End function ListAzKeyVault
function RemoveAzKeyVault { # Removes $KeyVaultObject
    Begin {
        :RemoveAzureKeyVault while ($true) { # Outer loop for managing function
            if (!$KeyVaultKeyObject) { # If $KeyVaultKeyObject is empty
                $KeyVaultKeyObject = GetAzKeyVault # Calls function and assigns output to $var
                if (!$KeyVaultKeyObject) { # If $KeyVaultKeyObject is still empty after returning
                    Break RemoveAzureKeyVault # Breaks :RemoveAzureKeyVault
                } # End if (!$KeyVaultKeyObject)
            } # End if (!$KeyVaultKeyObject)
            Write-Host "Remove Vault "$KeyVaultKeyObject.VaultName "in resource group "$KeyVaultKeyObject.ResourceGroupName # Write message to screen
            $ConfirmDelete = Read-Host "[Y] or [N]" # Operator confirmation to delete the key vault
            if (!($ConfirmDelete -eq 'y')) { # If Confirm delete is not 'y'
                Write-Host "No action taken" # Write message to screen
                Break RemoveAzureKeyVault # Breaks :RemoveAzureKeyVault
            } # End if (!($ConfirmDelete -eq 'y'))
            else { # IF $ConfrimDelete is not 'y'
                Write-Host "Deleting "$KeyVaultKeyObject.VaultName # Write message to screen
                Remove-AzKeyVault -VaultName $KeyVaultKeyObject.VaultName -ResourceGroupName $KeyVaultKeyObject.ResourceGroupName -force # Removes the key vault
                Break RemoveAzureKeyVault # Breaks :RemoveAzureKeyVault
            } # End else if (!($ConfirmDelete -eq 'y'))
        } # End :RemoveAzureKeyVault while ($true)
        Return # Returns to calling function
    } # End Begin
} # End function RemoveAzKeyVault
function ManageAzKeyVaultSecret { # Script for managing Azure
    Begin {
        :ManageAzureKeyVaultSecret while ($true) { # Outer loop for managing function
            if ($RGObject) { # If $RGObject has a value
                Write-Host '$RGObject:' $RGObject.ResourceGroupName # Write message to screen 
            } # End if ($RGObject)
            if ($KeyVaultObject) { # If $KeyVaultObject has a value
                Write-Host '$KeyVaultObject:' $KeyVaultObject.VaultName # Write message to screen
            } # End if ($KeyVaultObject)
            if ($KeyVaultSecretObject) { # If $KeyVaultObjectSecret has a value
                Write-Host '$KeyVaultObjectSecret:' $KeyVaultSecretObject.Name # Write message to screen
            } # End if ($KeyVaultSecretObject)
            if ($RGObject -or $KeyVaultObject -or $KeyVaultSecretObject) { # If $RGObject, $KeyVaultObject, or $KeyVaultSecretObject has a value
                Write-Host '0 to clear $RGObject, $KeyVaultObject $KeyVaultSecretObject' # Write message to screen
            } # End if ($RGObject -or $KeyVaultObject)
            Write-Host "1 New Key Vault Secret" # Write message to screen
            Write-Host "2 List All Key Vaults Secret" # Write message to screen
            Write-Host "3 Get Key Vault Secret" # Write message to screen
            Write-Host "4 Get Key Vault Secret Value" # Write message to screen
            Write-Host "5 Update Key Vault Secret Value" # Write message to screen
            Write-Host "6 Remove Key Vault Secret Value" # Write message to screen
            Write-Host "'Exit' to end script" # Write option list to screen
            $ManageAzKeyVaultSecretSel = Read-Host "Chose option" # Operator input for which option they need to run
            if ($ManageAzKeyVaultSecretSel -eq '1') { # Elseif statement for option 1
                Write-Host "New Key Vault Secrets" # Option selection write to screen
                $KeyVaultSecretObject = NewAzKeyVaultSecret ($RGObject, $KeyVaultObject) # Calls function NewAzKeyVaultSecret
            } # End if statement
            elseif ($ManageAzKeyVaultSecretSel -eq '2') { # Elseif statement for option 2
                Write-Host "List All Key Vaults Secrets" # Option selection write to screen
                ListAzKeyVaultSecret # Calls function ListAzKeyVaultSecret
            } # End elseif statement
            elseif ($ManageAzKeyVaultSecretSel -eq '3') { # Elseif statement for option 3
                Write-Host "Get Key Vault Secret" # Option selection write to screen
                $KeyVaultSecretObject = GetAzKeyVaultSecret ($RGObject, $KeyVaultObject) # Calls function GetAzKeyVaultSecret
                $KeyVaultSecretObject
            } # End elseif statement
            elseif ($ManageAzKeyVaultSecretSel -eq '4') { # Elseif statement for option 4
                Write-Host "Get Key Vaule Secret Value" # Option selection write to screen
                GetAzKeyVaultSecretValue ($RGObject, $KeyVaultObject, $KeyVaultSecretObject) # Calls function GetAzKeyVaultSecretValue
            } # End elseif statement
            elseif ($ManageAzKeyVaultSecretSel -eq '5') { # Elseif statement for option 5
                Write-Host "Update Key Vault Secret Value" # Option selection write to screen
                UpdateAzKeyVaultSecret ($RGObject, $KeyVaultObject, $KeyVaultSecretObject) # Calls function UpdateAzKeyVaultSecret
            } # End elseif statement
            elseif ($ManageAzKeyVaultSecretSel -eq '6') { # Elseif statement for option 6
                Write-Host "Remove Key Vault Secret Value" # Option selection write to screen
                RemoveAzKeyVaultSecret ($RGObject, $KeyVaultObject) # Calls function RemoveAzKeyVaultSecret
            } # End elseif statement
            elseif ($ManageAzKeyVaultSecretSel -eq '0') { # Elseif statement for option 0
                $RGObject = $null # Sets $var to $null
                $KeyVaultObject = $null # Sets $var to $null
                $KeyVaultSecretObject = $null # Sets $var to $null
                Write-Host '$RGObject, $KeyVaultObject, and $KeyVaultSecret have been cleared'
            } # End elseif ($ManageAzKeyVaultSecretSel -eq '0')
            elseif ($ManageAzKeyVaultSecretSel -eq 'exit') { # Elseif statement for ending the srcipt
                Break ManageAzureKeyVaultSecret # Breaks :ManageAzureKeyVaultSecret
            } # End elseif statement
            else { # Esle statement for all other values
                Write-Host "Invalid option" # Option selection write to screen
            } # End else statement
        } # End :ManageAzureKeyVaultSecret while ($true)
        Return # Returns to calling function with $null
    } # End begin statemnt
} # End ManageAzKeyVaultSecret
function NewAzKeyVaultSecret { # Creates a new key vault secret
    Begin {
        $ErrorActionPreference='silentlyContinue' # Disables Errors
        $WarningPreference = "silentlyContinue" # Disables key vault warnings
        :NewAzureKeyVaultSecret while ($true) { # Outer loop for managing function
            if (!$KeyVaultObject) { # If $var is $null
                $KeyVaultObject = GetAzKeyVault ($RGObject) # Calls function and assigns output to $Var
                if (!$KeyVaultObject) { # If $var is $null
                    Break NewAzureKeyVaultSecret # Breaks :NewAzureKeyVaultSecret
                } # End if (!$KeyVaultObject)
            } # End if (!$KeyVaultObject)
            :NewAzureKeyVaultSecretName while ($true) { # Inner loop for setting the new key vault secret name
                $KeyVaultSecretName = Read-Host "New key vault secret name" # Prompt for operator input for $KeyVaultSecretName
                Write-Host $KeyVaultSecretName # Write message to screen
                $OperatorConfirm = Read-Host "Use this as the secret name [Y] or [N]" # Operator confirmation of name
                if ($OperatorConfirm -eq 'exit') { # If $OperatorConfirm is equal to 'exit'
                    Break NewAzureKeyVaultSecret # Breaks :NewAzureKeyVaultSecret
                } # End if ($OperatorConfirm -eq 'exit')
                if ($OperatorConfirm -eq 'y') { # If $OperatorConfirm is equal to 'y'
                    Break :NewAzureKeyVaultSecretName # Breaks :NewAzureKeyVaultSecretName
                } # End if ($OperatorConfirm -eq 'y')
            } # End :NewAzureKeyVaultSecretName while ($true)
            :NewAzureKeyVaultSecretValue while ($true) { # Inner loop for setting the new key vault secret value
                $KeyVaultSecretValue = Read-Host "New key vault secret value" # Prompt for operator input for $KeyVaultSecretvalue
                Write-Host $KeyVaultSecretValue # Write message to screen
                $OperatorConfirm = Read-Host "Use this as the secret value [Y] or [N]" # Operator confirmation of value
                if ($OperatorConfirm -eq 'exit') { # If $OperatorConfirm is equal to 'exit'
                    Break NewAzureKeyVaultSecret # Breaks :NewAzureKeyVaultSecret
                } # End if ($OperatorConfirm -eq 'exit')
                if ($OperatorConfirm -eq 'y') { # If $OperatorConfirm is equal to 'y'
                    Break :NewAzureKeyVaultSecretValue # Breaks :NewAzureKeyVaultSecretValue
                } # End if ($OperatorConfirm -eq 'y')
            } # End :NewAzureKeyVaultSecretValue while ($true)
            $KeyVaultSecretHash = ConvertTo-SecureString -String $KeyVaultSecretValue -AsPlainText -Force # Converts the operator input to secure string
            $KeyVaultSecretObject = Set-AzKeyVaultSecret -VaultName $KeyVaultObject.VaultName -Name $KeyVaultSecretName -SecretValue $KeyVaultSecretHash # Creates $KeyVaultSecretObject
            Return $KeyVaultSecretObject # Returns to calling function with $KeyVaultSecretObject
        } # End :NewAzureKeyVaultSecret while ($true)
        Return # Returns to calling function with $null
    } # End Begin
} # End function NewAzKeyVaultSecret
function ListAzKeyVaultSecret { # Lists all key vault secrets
    Begin {
        $KVList = Get-AzKeyVault # Creates lists of all key vaults
        foreach ($VaultName in $KVList) { # For each key vault in $KVList
            Write-Host "-----------------------------------" # Write message to screen
            $KVSecretlist = Get-AzKeyVaultSecret -VaultName $VaultName.VaultName # Creates a list of all keys in current $VaultName
            Write-Host "Vault Name: " $VaultName.VaultName # Write message to screen
            Write-Host "" # Write message to screen
            foreach ($Name in $KVSecretlist) { # For each secret name in $KVSecretList
                Write-Host "Secret Name:" $Name.Name # Write message to screen
                Write-Host "Enabled:    " $Name.Enabled # Write message to screen
                Write-Host "Created:    " $Name.Created # Write message to screen
                Write-Host "Updated:    " $Name.Updated # Write message to screen
                if ($Name.Expires) { # If Selected key has an existing expiration
                    Write-Host "Expires:    " $Name.Expires # Write message to screen
                } # End if ($Name.Expires)
                Write-Host "" # Write message to screen
            } # End foreach ($Name in $KVSecretlist)
        } # End foreach ($VaultName in $KVList)
        Write-Host "-----------------------------------" # Write message to screen
    } # End Begin 
} # End function ListAzKeyVaultSecret
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
function GetAzKeyVaultSecretValue { # Function to return the value of a key vault secret
    Begin {
        $ErrorActionPreference='silentlyContinue' # Disables Errors
        $WarningPreference = "silentlyContinue" # Disables key vault warnings
        :GetAzureKeyVaultSecretVal while ($true) { # Outer loop for managing function
            if (!$KeyVaultSecretObject) { # If $var is $null
                $KeyVaultSecretObject = GetAzKeyVaultSecret ($RGObject, $KeyVaultObject) # Calls function and assigns output to $Var
                if (!$KeyVaultSecretObject) { # If $var is $null
                    Break GetAzureKeyVaultSecretVal # Breaks :GetAzureKeyVaultSecretVal
                } # End if (!$KeyVaultSecretObject)
            } # End if (!$KeyVaultSecretObject)
            $KeyVaultSecretValue = $null # Clears $KeyVaultSecretValue from all previous use
            $KeyVaultSecretHash = $null # Clears $KeyVaultSecretHash from all previous use
            $KeyVaultSecretHash = [System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($KeyVaultSecretObject.SecretValue) # Provided by MS Azure
            try { # Provided by MS Azure
                $KeyVaultSecretValue = [System.Runtime.InteropServices.Marshal]::PtrToStringBSTR($KeyVaultSecretHash) # Provided by MS Azure
            } # Provided by MS Azure
            Catch { # Catch for try statement
                Write-Host "An error has occured, you may not have permissions to this secret or vault" # Write message to screen
                Break GetAzureKeyVaultSecretVal # Breaks :GetAzureKeyVaultSecretVal
            } # End catch
            finally { # Provided by MS Azure
                [System.Runtime.InteropServices.Marshal]::ZeroFreeBSTR($KeyVaultSecretHash) # Provided by MS Azure
            } # Provided by MS Azure # This code was provided by MS, at this time is not needed and has commented out
            Write-Host "The value of"$KeyVaultSecretObject.Name "is:" $KeyVaultSecretValue # Prints secret name and value to screen
            Break GetAzureKeyVaultSecretVal # Breaks :GetAzureKeyVaultSecretVal
        } # End :GetAzureKeyVaultSecretValue while ($true) 
        Return # Returns to calling function with $null
    } # End begin statement   
} # End function GetAzKeyVaultSecretValue
function UpdateAzKeyVaultSecret { # Updates the value of selected key
    Begin { 
        :UpdateAzureKeyVaultSecret while ($true) { # Outer loop for managing funciton
            if (!$KeyVaultSecretObject) { # If $var is $null
                $KeyVaultSecretObject = GetAzKeyVaultSecret ($RGObject, $KeyVaultObject) # Calls function and assigns output to $Var
                if (!$KeyVaultSecretObject) { # If $var is $null
                    Break UpdateAzureKeyVaultSecret # Breaks :RemoveAzureKeyVaultSecret
                } # End if (!$KeyVaultSecretObject)
            } # End if (!$KeyVaultSecretObject)
            :UpdateAzureKVSecretValue while ($true) { # Inner loop for updating key vault secret value
                $KeyVaultSecretValue = Read-Host "New key vault secret value for"$KeyVaultSecretObject.Name # Prompt for operator input for $KeyVaultSecretvalue
                if ($KeyVaultSecretValue -eq 'exit') { # If $KeyVaultSecretValue is equal to 'exit'
                    Break UpdateAzureKeyVaultSecret # Breaks :NewAzureKeyVaultSecret
                } # End if ($KeyVaultSecretValue -eq 'exit')
                Write-Host $KeyVaultSecretValue # Write message to screen
                $OperatorConfirm = Read-Host "Use this as the secret value [Y] or [N]" # Operator confirmation of value
                if ($OperatorConfirm -eq 'y') { # If $OperatorConfirm is equal to 'y'
                    Break UpdateAzureKVSecretValue # Breaks :UpdateAzureKVSecretValue
                } # End if ($OperatorConfirm -eq 'y')
            } # End :UpdateAzureKVSecretValue while ($true)
            $KeyVaultSecretHash = ConvertTo-SecureString -String $KeyVaultSecretValue -AsPlainText -Force # Converts the operator input to secure string
            try { # Try to do the following
                $KeyVaultSecretObject = Set-AzKeyVaultSecret -VaultName $KeyVaultSecretObject.VaultName -Name $KeyVaultSecretObject.Name -SecretValue $KeyVaultSecretHash # Updates $KeyVaultSecretObject
            } # End Try
            catch { # If try statement fails
                Write-Host "There was an issue updating this secret" # Write message to screen
                Write-Host "You may not have the permissions to modify this secret" # Write message to screen
                Break UpdateAzureKeyVaultSecret # Breaks :UpdateAzureKVSecretValue 
            } # End catch
            Write-Host $KeyVaultSecretObject.Name"has been updated with the new value" # Write message to screen
            Break UpdateAzureKeyVaultSecret # Breaks :UpdateAzureKVSecretValue
        } # End  :UpdateAzureKeyVaultSecret while ($true)
        Return # Returns to calling function with $null
    } # End Begin
} # End function UpdateAzKeyVaultSecret
function RemoveAzKeyVaultSecret {
    Begin {
        $ErrorActionPreference='silentlyContinue' # Disables errors
        $WarningPreference = "silentlyContinue" # Disables key vault warnings
        :RemoveAzureKeyVaultSecret while ($true) { # Outer loop for managing function
            if (!$KeyVaultSecretObject) { # If $var is $null
                $KeyVaultSecretObject = GetAzKeyVaultSecret ($RGObject, $KeyVaultObject) # Calls function and assigns output to $Var
                if (!$KeyVaultSecretObject) { # If $var is $null
                    Break RemoveAzureKeyVaultSecret # Breaks :RemoveAzureKeyVaultSecret
                } # End if (!$KeyVaultSecretObject)
            } # End if (!$KeyVaultSecretObject)
            Write-host "The selected secret for removal is:"$KeyVaultSecretObject.Name"in vault:"$KeyVaultSecretObject.VaultName # Write message to screen
            $ConfirmDelete = Read-Host "Remove this secret [Y] or [N]" # Operator confirmation for deletion
            if (!($ConfirmDelete -eq 'y')) { # $Confirm delete is not equal to 'y'
                Break RemoveAzureKeyVaultSecret # Breaks :RemoveAzureKeyVaultSecret
            } # End if (!($ConfirmDelete -eq 'y'))
            else { # If $ConfirmDelete is equal to 'y'
                Write-Host "Removing" $KeyVaultSecretObject.Name # Write message to screen
                Try { # Try the following
                    Remove-AzKeyVaultSecret -Name $KeyVaultSecretObject.Name -VaultName $KeyVaultSecretObject.VaultName -Force # Removes the selected key
                } # End Try
                catch { # If error on Try
                    Write-Host "There was an issue removing the selected key" # Write message to screen
                    Write-Host "You may not have the permissions to remove this key" # Write message to screen
                    Break RemoveAzureKeyVaultSecret # Breaks :RemoveAzureKeyVaultSecret 
                } # End catch
                Write-Host "This secret has been removed" # Write message to screen
                Break RemoveAzureKeyVaultSecret # Breaks :RemoveAzureKeyVaultSecret
            } # End else (if (!($ConfirmDelete -eq 'y')))
        } # End :RemoveAzureKeyVaultSecret while ($true)
        Return # Returns to calling function with $null
    } # End Begin
} # End function RemoveAzKeyVaultSecret
function RemoveAzResourceLocks { # Function to remove resource locks, No input validation is done
    Begin {
        if (!$Locks) { # If statement if $Locks is $null
            $Locks = GetAzResourceLocks # Calls GetAzResourceLocks and assigns to $Locks
            if(!$Locks) { # If statement if $Locks is $null after calling function to assign
                Write-Host "RemoveAzResourceLocks function was terminated, no changes made" # Message write to screen
                Return $Locks # Returns to calling function
            } # End if statement
        } # End if statement
        $Locks.Name # Writes all names contained in $Locks
        $OperatorConfirm = Read-Host "Type 'Y' or 'Yes' to remove these locks" # Operator confirmation to remove the listed locks
        if (!($OperatorConfirm -ceq 'Y' -or $OperatorConfirm -ceq 'Yes')) { # If $Operatorconfirm is not (Equal to 'Y' or 'Yes') statement
            $Locks = $null # $Locks is set to $null
            Write-Host "RemoveAzResourceLocks function was terminated, no changes made" # Message write to screen
            Return $Locks # Return to calling function
        } # End if statement
        else { # Else statement if $Operatorconfirm is (Equal to 'Y' or 'Yes')
            $ErrorActionPreference='silentlyContinue' # Disables Errors
            foreach ($LockId in $Locks) { # Completes the command in a loop untill performed on all LockIds within $Locks
                $LockId.name # Prints the LockId for each lock as the cycle goes
                Remove-AzResourceLock -LockId $LockId.LockId -force # Removes the lock by targeting the LockID, -force removes operator confirmation
            } # End foreach loop
            $Locks = $null # Clears $Locks prior to returning to calling function
            Return $Locks # Returns to calling function
        } # End else statement
    } # End begin statement
} # End function
function GetAzResourceLocksAll { # Function to get all locks assigned to a resource, can pipe $Locks to another function
    Begin {
        if (!$RSObject) {
            $RGObject = GetAzResourceGroup # Calls function GetAzResourceGroup and assigns to $RGObject
            if (!$RGObject) { # If statement if $RGObject is $null after calling GetAzResourceObject
                Write-Host "GetAzResourceLocksAll function was terminated" # Message write to screen
                Return # Returns to calling function
            } # End if (!$RGObject)
            $RSObject = GetAzResource # Calls function GetAzResourceGroup and assigns to $RGObject
            if (!$RSObject) { # If statement if $RGObject is $null after calling GetAzResourceObject
                Write-Host "GetAzResourceLocksAll function was terminated" # Message write to screen
                Return # Returns to calling function
            } # End if if (!$RSObject)
        } # End if (!$RSObject)
        $Locks = Get-AzResourceLock -ResourceGroupName $RSObject.ResourceGroupName -ResourceName $RSObject.Name -ResourceType $RSObject.ResourceType | Where-Object {$_.ResourceName -eq $RSObject.Name} # Collects all locks and assigns to $Locks
        if (!$Locks) { # If statement for no object assigned to $Locks
            Write-Host "No locks are on this resource" # Write message to screen
            Write-Host "The GetAzResourceLocksAll function was terminated" # Message write to screen
            Return # Returns to calling function
        } # End if statement
        else { # Else statement for an object being assigned to $Locks
            Write-Host $Locks.Name -Separator `n # Write-host used so list is written to screen when function is used as $Locks = GetAzResourceLocksAll
            Return $Locks # Returns $Locks to the calling function
        } # End else statement
    } # End begin statement
} # End function   
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