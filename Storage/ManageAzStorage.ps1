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
    Get-AzKeyVaultKey:          https://docs.microsoft.com/en-us/powershell/module/az.keyvault/get-azkeyvaultkey?view=azps-5.4.0
    Add-AzKeyVaultKey:          https://docs.microsoft.com/en-us/powershell/module/az.keyvault/add-azkeyvaultkey?view=azps-5.4.0
    Remove-AzKeyVaultKey:       https://docs.microsoft.com/en-us/powershell/module/az.keyvault/remove-azkeyvaultkey?view=azps-5.4.0
    Get-AzKeyVaultSecret:       https://docs.microsoft.com/en-us/powershell/module/az.keyvault/get-azkeyvaultsecret?view=azps-5.1.0
    Set-AzKeyVaultSecret:       https://docs.microsoft.com/en-us/powershell/module/az.keyvault/set-azkeyvaultsecret?view=azps-5.1.0
    Remove-AzKeyVaultSecret:    https://docs.microsoft.com/en-us/powershell/module/az.keyvault/remove-azkeyvaultsecret?view=azps-5.1.0
    New-AzDisk:                 https://docs.microsoft.com/en-us/powershell/module/az.compute/new-azdisk?view=azps-5.4.0
    Set-AzDiskDiskEncryptionKey:https://docs.microsoft.com/en-us/powershell/module/az.compute/set-azdiskdiskencryptionkey?view=azps-5.4.0
    Set-AzDiskKeyEncryptionKey: https://docs.microsoft.com/en-us/powershell/module/az.compute/set-azdiskkeyencryptionkey?view=azps-5.4.0
    Get-AzDisk:                 https://docs.microsoft.com/en-us/powershell/module/az.compute/get-azdisk?view=azps-5.4.0
    Remove-AzDisk:              https://docs.microsoft.com/en-us/powershell/module/az.compute/remove-azdisk?view=azps-5.4.0
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
        ListAzStorageContainer:     https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Storage/Storage%20Account/Containers/ListAzStorageContainer.ps1
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
    ManageAzKeyVault:           https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Storage/KeyVault/ManageAzKeyVault.ps1
        NewAzKeyVault:              https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Storage/KeyVault/NewAzKeyVault.ps1
        ListAzKeyVault:             https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Storage/KeyVault/ListAzKeyVault.ps1
        GetAzKeyVault:              https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Storage/KeyVault/GetAzKeyVault.ps1
        RemoveAzKeyVault:           https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Storage/KeyVault/RemoveAzKeyVault.ps1
        ManageAzKeyVaultKey:        https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Storage/KeyVault/Keys/ManageAzKeyVaultKey.ps1
            NewAzKeyVaultKey:           https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Storage/KeyVault/Keys/NewAzKeyVaultKey.ps1
            AddAzKeyVaultKey:           https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Storage/KeyVault/Keys/AddAzKeyVaultKey.ps1
            ListAzKeyVaultKey:          https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Storage/KeyVault/Keys/ListAzKeyVaultKey.ps1
            GetAzKeyVaultKey:           https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Storage/KeyVault/Keys/GetAzKeyVaultKey.ps1
            DownloadAzKeyVaultKey:      https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Storage/KeyVault/Keys/DownloadAzKeyVaultKey.ps1
            RemoveAzKeyVaultKey:        https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Storage/KeyVault/Keys/RemoveAzKeyVaultKey.ps1
        ManageAzKeyVaultSecret:     https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Storage/KeyVault/Secrets/ManageAzKeyVaultSecret.ps1
            NewAzKeyVaultSecret:        https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Storage/KeyVault/Secrets/NewAzKeyVaultSecret.ps1
            ListAzKeyVaultSecret:       https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Storage/KeyVault/Secrets/ListAzKeyVaultSecret.ps1
            GetAzKeyVaultSecret:        https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Storage/KeyVault/Secrets/GetAzKeyVaultSecret.ps1
            GetAzKeyVaultSecretValue:   https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Storage/KeyVault/Secrets/GetAzKeyVaultSecretValue.ps1
            UpdateAzKeyVaultSecret:     https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Storage/KeyVault/Secrets/UpdateAzKeyVaultSecret.ps1
            RemoveAzKeyVaultSecret:     https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Storage/KeyVault/Secrets/RemoveAzKeyVaultSecret.ps1
    ManageAzDisk:               https://github.com/benjaminsmorgan/Azure-Powershell/blob/main//Storage/Disks/ManageAzDisk.ps1
        NewAzDisk:                  https://github.com/benjaminsmorgan/Azure-Powershell/blob/main//Storage/Disks/NewAzDisk.ps1
        ListAzDisk:                 https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Storage/Disks/ListAzDisk.ps1
        Get-AzDisk:                 https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Storage/Disks/GetAzDisk.ps1
        RemoveAzDisk:               https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Storage/Disks/RemoveAzDisk.ps1
    GetAzResourceGroup:         https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/Resource%20Groups/GetAzResourceGroup.ps1
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
            ListAzStorageContainer:     Lists all storage containers
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
                NewAzKeyVaultKey:           Creates a new key vault Key
                AddAzKeyVaultKey:           Uploads an existing key into vault
                ListAzKeyVaultKey:          Lists all key vault Keys by vault name
                GetAzKeyVaultKey:           Gets a key vault Key
                DownloadAzKeyVaultKey:      Downloads selected key vault Key
                RemoveAzKeyVaultKey:        Removes a selected key vault Key
            ManageAzKeyVaultSecret:     Management function for key vault secrets
                NewAzKeyVaultSecret:        Creates a new key vault secret
                ListAzKeyVaultSecret:       Lists all key vault secrets by vault name
                GetAzKeyVaultSecret:        Gets a key vault secret
                UpdateAzKeyVaultSecret:     Updates the value of selected key vault secret
                RemoveAzKeyVaultSecret:     Removes a selected key vault secret
        ManageAzDisk:               Management function for disks
            NewAzDisk:                  Creates a new disk
            ListAzDisk:                 Lists all disks
            GetAzDisk:                  Gets a disk
            RemoveAzDisk:               Removes a selected disk
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
        ListAzStorageContainer{}    Lists all storage containers
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
            AddAzKeyVaultKey{}          Uploads $KeyVaultKeyObject
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
        ManageAzDisk{}              Manages $DiskObject
            NewAzDisk{}                 Creates $DiskObject           
                GetAzResourceGroup{}        Gets $RGObject
            GetAzKeyVault{}             Gets $KeyVaultObject
                GetAzResourceGroup{}        Gets $RGObject
            GetAzKeyVaultSecret{}       Gets $KeyVaultSecretObject
            GetAzKeyVaultKey{}          Gets $KeyVaultKeyObject
            ListAzDisk{}                Lists disks
            GetAzDisk{}                 Gets $DiskObject
            RemoveAzDisk{}              Removes $DiskObject
                GetAzDisk{}                 Gets $DiskObject 
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
                        Return NewAzStorageContainer > Send $StorageAccObject
                    End NewAzStorageContainer 
                        Return ManageStorageContainer > Send $null
                Call ListAzStorageContainer > Get $null
                End ListAzStorageContainer
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
            Call ManageAzKeyVault > Get $null
                Call NewAzKeyvault
                    Call GetAzResource Group > Get $RGObject
                    End GetAzResourceGroup
                        Return NewAzKeyVault > Send $RGObject
                End NewAzKeyvault
                    Return ManageAzKeyVault > Send $KeyVaultObject
                Call ListAzKeyVault
                End ListAzKeyVault
                    Return ManageAzKeyVault > Send $null
                Call GetAzKeyVault
                    Call GetAzResource Group > Get $RGObject
                    End GetAzResourceGroup
                        Return GetAzKeyVault > Send $RGObject
                End GetAzKeyVault
                    Return ManageAzKeyVault > Send $KeyVaultObject
                Call RemoveAzKeyVault
                    Call GetAzKeyVault
                        Call GetAzResource Group > Get $RGObject
                        End GetAzResourceGroup
                        Return GetAzKeyVault > Send $RGObject
                    End GetAzKeyVault
                    Return RemoveAzKeyVault > Send $KeyVaultObject
                End RemoveAzKeyVault
                    Return ManageAzKeyVault > Send $null
                Call ManageAzKeyVaultKey                
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
                    Return ManageAzKeyVault > Send $null
                Call ManageAzKeyVaultSecret > Get $KeyVaultSecretObject
                    Call NewAzKeyVaultSecret > Get $KeyVaultSecretObject
                        Call GetAzKeyVault > Get $KeyVaultObject
                            Call GetAzResourceGroup > Get $RGObject
                            End GetAzResourceGroup
                                Return GetAzKeyVault > Send $RGObject
                        End GetAzKeyVault
                            Return NewAzKeyVaultSecret > Send $KeyVaultObject  
                    End NewAzKeyVaultSecret
                        Return ManageAzKeyVaultSecret > Send $KeyVaultSecretObject
                    Call ListAzKeyVaultSecret > Get $null
                    End ListAzKeyVaultSecret
                        Return ManageAzKeyVaultSecret > Send $null          
                    Call GetAzKeyVaultSecret > Get $KeyVaultSecretObject
                        Call GetAzKeyVault > Get $KeyVaultObject
                            Call GetAzResourceGroup > Get $RGObject
                            End GetAzResourceGroup
                                Return GetAzKeyVault > Send $RGObject
                        End GetAzKeyVault
                            Return GetAzKeyVaultSecret > Send $KeyVaultObject
                    End GetAzKeyVaultSecret 
                        Return ManageAzKeyVaultSecret> Send $KeyVaultSecretObject            
                    Call GetAzKeyVaultSecretValue > Get $null
                        Call GetAzKeyVaultSecret > Get $KeyVaultSecretObject
                            Call GetAzKeyVault > Get $KeyVaultObject
                                Call GetAzResourceGroup > Get $RGObject
                                End GetAzResourceGroup
                                    Return GetAzKeyVault > Send $RGObject
                            End GetAzKeyVault
                                Return GetAzKeyVaultSecret > Send $KeyVaultObject
                        End GetAzKeyVaultSecret
                            Return GetAzKeyVaultSecretValue > Send $KeyVaultSecretObject  
                    End GetAzKeyVaultSecretValue
                        Return ManageAzKeyVaultSecret > Send $null                   
                    Call RemoveAzKeyVaultSecret > Get $null
                        Call GetAzKeyVaultSecret > Get $KeyVaultSecretObject
                            Call GetAzKeyVault > Get $KeyVaultObject
                                Call GetAzResourceGroup > Get $RGObject
                                End GetAzResourceGroup
                                    Return GetAzKeyVault > Send $RGObject
                            End GetAzKeyVault
                                Return GetAzKeyVaultSecret > Send $KeyVaultObject
                        End GetAzKeyVaultSecret
                            Return RemoveAzKeyVaultSecret > Send $KeyVaultSecretObject  
                    End RemoveAzKeyVaultSecret
                        Return ManageAzKeyVaultSecret > Send $null   
                End ManageAzKeyVaultSecret
                    Return ManageAzKeyVault > Send $null
            End ManageAzKeyVault
                Return ManageAzStorage > Send $null
            Call ManageAzDisk > Get $null
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
                    Return ManageAzDisk > Return $DiskObject
                Call ListAzDisk > Get $null
                End ListAzDisk
                    Return ManageAzDisk > Return $null
                Call GetAzDisk > Get $DiskObject
                End GetAzDisk
                    Return ManageAzDisk > Return $DiskObject
                Call RemoveAzDisk > Get $null
                    Call GetAzDisk > Get $DiskObject
                    End GetAzDisk
                        Return RemoveAzDisk > Send $DiskObject
                End RemoveAzDisk
                    Return ManageAzDisk > Return $null
            End ManageAzDisk
                Return ManageAzStorage > Send $null
        End ManageAzStorage
            Return Function > Send $null
}#>
function ManageAzStorage {                                                                  # Function for managing Azure storage
    Begin {                                                                                 # Begin function
        :ManageAzureStorage while ($true) {                                                 # Outer loop for managing function
            Write-Host 'Azure Storage Management'                                           # Write message to screen
            Write-Host '[1] Manage Storage Accounts'                                        # Write message to screen
            Write-Host '[2] Manage Storage Containers'                                      # Write message to screen
            Write-Host '[3] Manage Blobs'                                                   # Write message to screen
            Write-Host '[4] Manage Storage Shares'                                          # Write message to screen
            Write-Host '[5] Manage Key Vaults'                                              # Write message to screen
            Write-Host '[6] Manage Disks'                                                   # Write message to screen
            Write-Host '[Exit] to return'                                                   # Write message to screen
            $OpSelect = Read-Host "Option?"                                                 # Operator input for managing function selection
            if ($OpSelect -eq 'exit') {                                                     # If $OpSelect equals 'exit'
                Break ManageAzureStorage                                                    # Breaks :ManageAzureStorage 
            }                                                                               # End if ($OpSelect -eq 'exit')
            elseif ($OpSelect -eq '1') {                                                    # Else if $OpSelect equals '1'
                Write-Host 'Manage Storage Accounts'                                        # Write message to screen
                ManageAzStorageAccount                                                      # Calls function
            }                                                                               # End elseif ($OpSelect -eq '1')
            elseif ($OpSelect -eq '2') {                                                    # Else if $OpSelect equals '2'
                Write-Host 'Manage Storage Containers'                                      # Write message to screen
                ManageAzStorageContainer                                                    # Calls function
            }                                                                               # End elseif ($OpSelect -eq '2')
            elseif ($OpSelect -eq '3') {                                                    # Else if $OpSelect equals '3'
                Write-Host 'Manage Blobs'                                                   # Write message to screen
                ManageAzStorageBlob:                                                        # Calls function
            }                                                                               # End elseif ($OpSelect -eq '3')
            elseif ($OpSelect -eq '4') {                                                    # Else if $OpSelect equals '4'
                Write-Host 'Manage Storage Shares'                                          # Write message to screen
                ManageAzStorageShare                                                        # Calls function
            }                                                                               # End elseif ($OpSelect -eq '4')
            elseif ($OpSelect -eq '5') {                                                    # Else if $OpSelect equals '5'
                Write-Host 'Manage Key Vaults'                                              # Write message to screen
                ManageAzKeyVault                                                            # Calls function
            }                                                                               # End elseif ($OpSelect -eq '5')
            elseif ($OpSelect -eq '6') {                                                    # Else if $OpSelect equals '6'
                Write-Host 'Manage Disks'                                                   # Write message to screen
                ManageAzDisk                                                                # Calls function
            }                                                                               # End elseif ($OpSelect -eq '6')
        }                                                                                   # End ManageAzureStorage while ($true)
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End begin
}                                                                                           # End function ManageAzStorage
# Functions for ManageAzStorageAccount
function ManageAzStorageAccount {                                                           # Management function for storage accounts
    Begin {                                                                                 # Begin function
        :ManageAzureStorageAcc while ($true) {                                              # Outer loop for managing function
            Write-Host 'Azure Storage Account Management'                                   # Write message to screen
            Write-Host '[1] New Storage Account'                                            # Write message to screen
            Write-Host '[2] List Storage Accounts'                                          # Write message to screen
            Write-Host '[3] Get Storage Account'                                            # Write message to screen
            Write-Host '[4] Remove Storage Account'                                         # Write message to screen
            Write-Host '[Exit] to return'                                                   # Write message to screen
            $OpSelect = Read-Host "Option?"                                                 # Operator input for management function selection
            if ($OpSelect -eq 'exit') {                                                     # If $OpSelect equals 'exit'
                Break ManageAzureStorageAcc                                                 # Breaks :ManageAzureStorageAcc
            }                                                                               # End if ($OpSelect -eq 'exit')
            elseif ($OpSelect -eq '1') {                                                    # Else if $OpSelect equals '1'
                Write-Host 'New Storage Account'                                            # Write message to screen
                NewAzStorageAccount                                                         # Calls function
            }                                                                               # End elseif ($OpSelect -eq '1')
            elseif ($OpSelect -eq '2') {                                                    # Else if $OpSelect equals '2'
                Write-Host 'List Storage Accounts'                                          # Write message to screen
                ListAzStorageAccount                                                        # Calls function
            }                                                                               # End elseif ($OpSelect -eq '2')
            elseif ($OpSelect -eq '3') {                                                    # Else if $OpSelect equals '3'
                Write-Host 'Get Storage Account'                                            # Write message to screen
                GetAzStorageAccount                                                         # Calls function and assigns to $var
            }                                                                               # End elseif ($OpSelect -eq '3')
            elseif ($OpSelect -eq '4') {                                                    # Else if $OpSelect equals '4'
                Write-Host 'Remove Storage Accounts'                                        # Write message to screen
                RemoveAzStorageAccount                                                      # Calls function
            }                                                                               # End elseif ($OpSelect -eq '4')
            else {                                                                          # All other inputs for $OpSelect
                Write-Host 'That was not a valid option'                                    # Write message to screen
            }                                                                               # End else (if ($OpSelect -eq 'exit'))
        }                                                                                   # End ManageAzureStorageAcc while ($true)
        Return $null                                                                        # Returns to calling function 
    }                                                                                       # End begin
}                                                                                           # End function ManageAzStorageAccount
function NewAzStorageAccount {                                                              # Creates a new storage account
    Begin {                                                                                 # Begin function
        $ErrorActionPreference='silentlyContinue'                                           # Turns off error reporting
        $CallingFunction = 'NewAzStorageAccount'                                            # Creates $CallingFunction
        :NewAzureStorageAcc while ($true) {                                                 # Outer loop for managing function
            $RGObject = GetAzResourceGroup ($CallingFunction)                               # Calls function and assigns output to $var
            if (!$RGObject) {                                                               # If $RGObject is $null
                Break NewAzureStorageAcc                                                    # Breaks :NewAzureStorageAcc 
            }                                                                               # End if (!$RGObject)
            :SetAzureStorageAccName while ($true) {                                         # Inner loop for setting the storage account name
                $StorageAccNameInput = '0'                                                  # Sets a fail value for $StorageAccNameInput
                try {                                                                       # Try the following
                    Write-Host 'Storage account name must be between 3-24 characters'       # Write message to screen
                    Write-Host 'May only use letters and numbers'
                    [ValidatePattern('^[a-z,0-9]+$')]$StorageAccNameInput = `
                        [string](Read-Host 'New storage account name').ToLower()            # Operator input for the account name
                }                                                                           # End try
                catch {                                                                     # If try fails
                    Write-Host "The account name must only include letters and numbers"     # Write message to screen
                }                                                                           # End catch
                if ($StorageAccNameInput -eq 'exit') {                                      # $StorageAccNameInput is equal to 'exit'
                    Break NewAzureStorageAcc                                                # Breaks :NewAzureStorageAcc
                }                                                                           # if ($StorageAccNameInput -eq 'exit')
                elseif ($StorageAccNameInput.Length -le 2 `
                    -or $StorageAccNameInput.Length -ge 25) {                               # Else if $StorageAccNameInput is not between 3 and 24 characters
                    Write-Host `
                        "The account name must be between 3 and 24 characters in length"    # Write message to screen
                        Start-Sleep(5)                                                      # Pauses all actions for 5 seconds
                        Clear-Host                                                          # Clears the screen
                }                                                                           # End elseif ($StorageAccNameInput.Length -le 2 -or $StorageAccNameInput.Length -ge 25)
                else {                                                                      # All other inputs for $StorageAccNameInput
                    Write-Host 'Use'$StorageAccNameInput' as the name'                      # Writes $var to screen
                    $OpConfirm = Read-Host '[Y] or [N]'                                     # Operator confirmation
                    if ($OpConfirm -eq 'y') {                                               # If $OpConfirm is equal to 'y'
                        Clear-Host                                                          # Clears the screen
                        Break SetAzureStorageAccName                                        # Breaks :SetAzureStorageAccName
                    }                                                                       # End If ($OpConfirm -eq 'y')
                }                                                                           # End else (if ($StorageAccNameInput -eq 'exit'))
            }                                                                               # :SetAzureStorageAccName while ($true)
            $ValidSkuList = @('Standard_LRS', 'Standard_GRS', 'Standard_RAGRS', `
                'Standard_ZRS','Premium_LRS', 'Premium_ZRS', 'Standard_GZRS', `
                'Standard_RAGZRS')                                                          # Current list of all skus
                $ObjectNumber = 1                                                           # Sets $ObjectNumber to 1
                [System.Collections.ArrayList]$ObjectArray = @()                            # Creates the RG list array
                foreach ($_ in $ValidSkuList) {                                             # For each $_ in $ValidSkuList
                    $ObjectInput = [PSCustomObject]@{'Name' = $_; `
                        'Number' = $ObjectNumber}                                           # Creates the item to loaded into array
                    $ObjectArray.Add($ObjectInput) | Out-Null                               # Loads item into array, out-null removes write to screen
                    $ObjectNumber = $ObjectNumber + 1                                       # Increments $ObjectNumber by 1
                }                                                                           # End foreach ($_ in $ObjectList)
                Write-Host "[0]  Exit"                                                      # Write message to screen
                foreach ($_ in $ObjectArray) {                                              # For each $_ in $ObjectArray
                    $Number = $_.Number                                                     # Sets $Number to current item .number
                    if ($_.Number -le 9) {                                                  # If current item .number is 9 or less
                        Write-Host "[$Number] "$_.Name                                      # Write message to screen
                    }                                                                       # End if ($_.Number -le 9) 
                    else {                                                                  # If current item .number is greater then 9
                        Write-Host "[$Number]"$_.Name                                       # Write message to screen
                    }                                                                       # End else (if ($_.Number -le 9) )
                }                                                                           # End foreach ($_ in $ObjectArray)
            :SetAzureStorageAccSku while ($true) {                                          # Inner loop for setting the sku
                $StorageAccSkuInput = Read-Host 'Enter option [#]'                          # Operator input for the storage account sku
                if ($StorageAccSkuInput -eq '0') {                                          # If $StorageAccSkuInput equals '0'
                    Break NewAzureStorageAcc                                                # Breaks :NewAzureStorageACC
                }                                                                           # if ($StorageAccNameInput -eq '0')
                if ($StorageAccSkuInput -in $ObjectArray.Number) {                          # If $StorageAccSkuInput is in $ObjectArray.Number
                    $StorageAccSkuInput = $ObjectArray | Where-Object `
                        {$_.Number -eq $StorageAccSkuInput}                                 # $StorageAccSkuInput equals $ObjectArray where $ObjectArray.Number equals $StorageAccSkuInput
                    $StorageAccSkuInput = $StorageAccSkuInput.name                          # Isolates the sku name
                    Clear-Host                                                              # Clears the screen
                    Break SetAzureStorageAccSku                                             # Breaks :SetAzureStorageAccSku
                }                                                                           # End if ($StorageAccNameInput -in $ObjectArray.Number)
                else {                                                                      # Else for all other inputs 
                    Write-Host "That was not a valid input"                                 # Write message to screen
                }                                                                           # End else (if ($StorageAccNameInput -in $ObjectArray.Number))
            }                                                                               # End :SetAzureStorageAccSku while ($true)
            $LocationObject = GetAzLocation                                                 # Calls function and assigns output to $var
            Clear-Host                                                                      # Clears the screen
            if (!$LocationObject) {                                                         # If $LocationObject is $null
                Break NewAzureStorageAcc                                                    # Breaks :NewAzureStorageAcc
            }                                                                               # End if (!$LocationObject)
            try {                                                                           # Try the following
                New-AzStorageAccount -ResourceGroupName $RGObject.ResourceGroupName `
                    -Location $LocationObject.location -Name $StorageAccNameInput `
                    -SkuName $StorageAccSkuInput -ErrorAction 'Stop'                        # Creates the new storage account
            }                                                                               # End try
            catch {                                                                         # If try fails
                Write-Host 'An error has occured'                                           # Write message to screen
                Start-Sleep(5)                                                              # Pauses all actions for 5 seconds
                Break NewAzureStorageAcc                                                    # Breaks :NewAzureStorageAcc
            }                                                                               # End catch
            Write-Host 'The storage account has been made'                                  # Write message to screen
            Start-Sleep(5)                                                                  # Pause all actions for 5 seconds
            Break NewAzureStorageAcc                                                        # Breaks :NewAzureStorageAcc
        }                                                                                   # End :NewAzureStorageAcc while ($true)
        Clear-Host                                                                          # Clears the screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function NewAzStorageAccount
function ListAzStorageAccount {                                                             # Function to list storage accounts
    Begin {                                                                                 # Begin function
        :ListAzureStorageAcc while ($true) {                                                # Outer loop for managing function
            Write-Host 'Getting storage account info'                                       # Write message to screen
            Write-Host 'This may take a moment'                                             # Write message to screen
            [System.Collections.ArrayList]$ObjectArray = @()                                # Creates the object array
            $RGObject = Get-AzResourceGroup                                                 # List of all resource groups
            foreach ($_ in $RGObject) {                                                     # For each item in $RGObject
                $CurrentRG = $_.ResourceGroupName                                           # Isolates the current item .ResourceGroupName
                $ObjectList = Get-AzStorageAccount -ResourceGroupName `
                    $CurrentRG                                                              # Collects all storage accounts in $CurrentRG and assigns to $ObjectList
                foreach ($_ in $ObjectList) {                                               # For each $_ in $ObjectListList
                    $ObjectInput = [PSCustomObject]@{'Name' = $_.StorageAccountName; `
                        'Number' = $ObjectNumber;'Sku'=$_.Sku.Name;`
                        'AccTier'=$_.AccessTier;'Location'=$_.PrimaryLocation;`
                        'RG'=$CurrentRG}                                                    # Creates the item to loaded into array
                    $ObjectArray.Add($ObjectInput) | Out-Null                               # Loads item into array, out-null removes write to screen
                }                                                                           # End foreach ($_ in $ObjectList)
            }                                                                               # End foreach ($_ in $RGObject)
            Write-Host ''                                                                   # Write message to screen
            foreach ($_ in $ObjectArray) {                                                  # For each $_ in $ObjectArray
                Write-Host 'Store Acc Name:'$_.Name                                         # Write message to screen
                Write-Host 'Resource Group:'$_.RG                                           # Write message to screen
                Write-Host 'Primary Loc:   '$_.Location                                     # Write message to screen
                Write-Host 'Sku Name:      '$_.Sku                                          # Write message to screen
                Write-Host 'Access Tier:   '$_.AccTier                                      # Write message to screen
                Write-Host ''                                                               # Write message to screen
            }                                                                               # End foreach ($_ in $ObjectArray)
            Pause                                                                           # Pauses for operator
            Break ListAzureStorageAcc                                                       # Breaks :ListAzureStorageAcc  
        }                                                                                   # End :ListAzureStorageAcc while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End begin 
}                                                                                           # End function GetAzStorageAccount
function GetAzStorageAccount {                                                              # Function to get a storage account
    Begin {                                                                                 # Begin function
        $ErrorActionPreference = 'silentlyContinue'                                         # Disables errors
        if (!$CallingFunction) {                                                            # If $CallingFunction is $null
            $CallingFunction = 'GetAzStorageAccount'                                        # Creates $CallingFunction
        }                                                                                   # End if (!$CallingFunction)
        :GetAzureStorageAcc while ($true) {                                                 # Outer loop for managing function
            if (!$RGObject) {                                                               # If $RGObject is $null
                $RGObject = GetAzResourceGroup ($CallingFunction)                           # Calls function and assigns output to $var
                if (!$RGObject) {                                                           # If $RGObject is $null
                    Break GetAzureStorageACC                                                # Ends :GetAzureStorageAcc
                }                                                                           # End if (!$RGObject) | Inner
            }                                                                               # End if (!$RGObject) | Outer
            $ObjectList = Get-AzStorageAccount -ResourceGroupName `
                $RGObject.ResourceGroupName                                                 # Collects all storage accounts in $RGObject and assigns to $StorageAccList
            if (!$ObjectList) {                                                             # If $ObjectList is $null   
                Write-Host 'No storage accounts found on RG:'$RGObject.ResourceGroupName    # Write message to screen
                Start-Sleep(5)                                                              # Pauses all actions for 5 seconds
                Break GetAzureStorageACC                                                    # Ends :GetAzureStorageAcc
            }                                                                               # End if (!$StorageAccList)
            $ObjectNumber = 1                                                               # Sets $ObjectNumber to 1
            [System.Collections.ArrayList]$ObjectArray = @()                                # Creates the object array
            foreach ($_ in $ObjectList) {                                                   # For each $_ in $ObjectListList
                $ObjectInput = [PSCustomObject]@{'Name' = $_.StorageAccountName; `
                    'Number' = $ObjectNumber;'Sku'=$_.Sku.Name;'AccTier'=$_.AccessTier;`
                    'Location'=$_.PrimaryLocation}                                          # Creates the item to loaded into array
                $ObjectArray.Add($ObjectInput) | Out-Null                                   # Loads item into array, out-null removes write to screen
                $ObjectNumber = $ObjectNumber + 1                                           # Increments $ObjectNumber by 1
            }                                                                               # End foreach ($_ in $ObjectList)
            Write-Host "[0]  Exit"                                                          # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            foreach ($_ in $ObjectArray) {                                                  # For each $_ in $ObjectArray
                $Number = $_.Number                                                         # Sets $Number to current item .number
                if ($_.Number -le 9) {                                                      # If current item .number is 9 or less
                    Write-Host "[$Number] "$_.Name
                }                                                                           # End if ($_.Number -le 9) 
                else {                                                                      # If current item .number is greater then 9
                    Write-Host "[$Number]"$_.Name                                           # Write message to screen
                }                                                                           # End else (if ($_.Number -le 9) 
                Write-Host 'Primary Loc:'$_.Location                                        # Write message to screen
                Write-Host 'Sku Name:   '$_.Sku                                             # Write message to screen
                Write-Host 'Access Tier:'$_.AccTier                                         # Write message to screen
                Write-Host ''                                                               # Write message to screen
            }                                                                               # End foreach ($_ in $ObjectArray)
            :SelectAzureObjectList while ($true) {                                          # Inner loop to select the resource group
                if ($CallingFunction -and $CallingFunction -ne 'GetAzStorageAccount') {     # If $CallingFunction exists and not equal 'GetAzStorageAccount'
                    Write-Host "You are selecting the storage account for"$CallingFunction  # Write message to screen
                }                                                                           # End if ($CallingFunction -and $CallingFunction -ne 'GetAzStorageAccount')
                $ObjectSelect = Read-Host "Enter the storage account [#]"                   # Operator input for the storage account selection
                if ($ObjectSelect -eq '0') {                                                # If $ObjectSelect equals 0
                    Break GetAzureStorageAcc                                                # Breaks :GetAzureStorageAcc
                }                                                                           # End if ($ObjectSelect -eq '0')
                elseif ($ObjectSelect -in $ObjectArray.Number) {                            # If $ObjectSelect in $ObjectArray.Number
                    $ObjectSelect = $ObjectArray | Where-Object `
                        {$_.Number -eq $ObjectSelect}                                       # $ObjectSelect is equal to $ObjectArray where $ObjectArray.Number is equal to $ObjectSelect                                  
                    $StorageAccObject = Get-AzStorageAccount | Where-Object `
                        {$_.StorageAccountName -eq $ObjectSelect.Name}                      # Pulls the full storage account object
                    Clear-Host                                                              # Clears screen
                    Return $StorageAccObject                                                # Returns to calling function with $var
                }                                                                           # End elseif ($ObjectSelect -in $ListArray.Number)
                else {                                                                      # All other inputs for $ObjectSelect
                    Write-Host "That was not a valid option"                                # Write message to screen
                }                                                                           # End else (if ($ObjectSelect -eq '0'))
            }                                                                               # End :SelectAzureObjectList while ($true)
            if ($CallingFunction -and $CallingFunction -ne 'GetAzStorageAccount') {         # If $CallingFunction exists and not equal 'GetAzStorageAccount'
                Clear-Host                                                                  # Clears screen
                Return $StorageAccObject                                                    # Returns to calling function with $StorageAccObject
            }                                                                               # End if ($CallingFunction -and $CallingFunction -ne 'GetAzStorageAccount')
            else {                                                                          # If $Calling function does not exist or is equal to 'GetAzStorageAccount'
                Break GetAzureStorageAcc                                                    # Breaks :GetAzureStorageAcc  
            }                                                                               # End  else (if ($CallingFunction -and $CallingFunction -ne 'GetAzStorageAccount'))
        }                                                                                   # End :GetAzureStorageAcc while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End begin 
}                                                                                           # End function GetAzStorageAccount
function RemoveAzStorageAccount {                                                           # Function to remove a storage account
    Begin {                                                                                 # Begin function
        if (!$CallingFunction) {                                                            # If $CallingFunction does not exist
            $CallingFunction = 'RemoveAzStorageAccount'                                     # Creates $CallingFunction
        }                                                                                   # End if (!$CallingFunction)
        :RemoveAzureStorageAcc while ($true) {                                              # Outer loop for managing function
            $StorageAccObject = GetAzStorageAccount ($CallingFunction)                      # Calls function and assigns to $var
            if (!$StorageAccObject) {                                                       # If $StorageAccObject is $null
                Break RemoveAzureStorageAcc                                                 # Breaks RemoveAzureStorageAcc
            }                                                                               # End if (!$StorageAccObject)
            Write-Host 'Remove storage account:'$StorageAccObject.StorageAccountName        # Write message to screen
            Write-Host 'From resource group:'$StorageAccObject.ResourceGroupName            # Write message to screen
            $OpConfirm = Read-Host '[Y] or [N]'                                             # Operator confimation to remove the storage account
            if ($OpConfirm -ne 'y') {                                                       # If $OpConfirm is not equal to 'y'
                Break RemoveAzureStorageAcc                                                 # Breaks RemoveAzureStorageAcc
            }                                                                               # End if ($OpConfirm -ne 'y')
            Clear-Host                                                                      # Clears screen
            Write-Host "Checking for resource locks"                                        # Write message to screen
            $RSLocks = Get-AzResourceLock | Where-Object `
                {$_.ResourceName -eq $StorageAccObject.StorageAccountName}                  # Collects all locks on the storage account
            $RGLocks = Get-AzResourceLock -ResourceGroupName `
                $StorageAccObject.ResourceGroupName -AtScope                                # Collects all locks on the resource group holding the storage account
            if ($RSLocks -or $RGLocks) {      
                if ($RSLocks) {                                                             # If $RSLocks is not $null
                    Write-Host ''                                                           # Write message to screen
                    Write-Host 'There are locks on this this resource'                      # Write message to screen
                    Start-Sleep(2)                                                          # Pauses all actions for 2 seconds
                }                                                                           # End if ($RSLocks)
                if ($RGLocks) {                                                             # If $RGLocks is not $null
                    Write-Host ''                                                           # Write message to screen
                    Write-Host 'There are locks on the storage'                             # Write message to screen
                    Write-Host "accounts's resource group"                                  # Write message to screen
                    Start-Sleep(2)                                                          # Pauses all actions for 2 seconds
                }                                                                           # End if ($RGLocks)
                Write-Host ''                                                               # Write message to screen
                Write-Host 'All locks will need to be removed'                              # Write message to screen
                Write-Host 'prior to removing this storage account'                         # Write message to screen
                Start-Sleep(5)                                                              # Pauses all actions for 5 seconds
                Break RemoveAzureStorageAcc                                                 # Breaks :RemoveAzureStorageAcc
            }                                                                               # End if ($RSLocks -or $RGLocks)
            else {                                                                          # If $RSLocks and $RGLocks are $null
                Write-Host "No locks present on this storage account"                       # Write message to screen
            }                                                                               # End else (if ($RSLocks -or $RGLocks) )
            Try {                                                                           # Try the following
                Remove-AzStorageAccount -ResourceGroupName `
                    $StorageAccObject.ResourceGroupName -AccountName `
                    $StorageAccObject.StorageAccountName -Force -ErrorAction 'Stop'         # Removes storage account
            }                                                                               # End Try
            catch {                                                                         # Try fails
                Write-Host 'The storage account was not deleted'                            # Write message to screen
                Write-Host 'You may not have the permissions'                               # Write message to screen
                Write-host 'to remove this storage account'                                 # Write message to screen
                Start-Sleep(10)                                                             # Pauses all actions for 10 seconds
                Break RemoveAzureStorageAcc                                                 # Breaks RemoveAzureStorageAcc
            }                                                                               # End Catch
            Write-Host 'The selected storage account has been removed'                      # Write message to screen
            Start-Sleep(5)                                                                  # Pauses all actions for 5 seconds
            Break RemoveAzureStorageAcc                                                     # Breaks :RemoveAzureStorageAcc
        }                                                                                   # End :RemoveAzureStorageAcc while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End begin 
}                                                                                           # End function GetAzStorageAccount 
# End ManageAzStorageAccount
# Functions for ManageAzStorageContainer
function ManageAzStorageContainer {                                                         # Function to manage storage containers
    Begin {                                                                                 # Begin function
        :ManageAzureStorageCon while ($true) {                                              # Outer loop for managing function
            Write-Host 'Azure Storage Container Management'                                 # Write message to screen
            Write-Host '[1] New Storage Container'                                          # Write message to screen
            Write-Host '[2] List All Storage Containers'                                    # Write message to screen
            Write-Host '[3] Remove Storage Container'                                       # Write message to screen
            Write-Host '[Exit] to return'                                                   # Write message to screen
            $OpSelect = Read-Host 'Option [#]'                                              # Operator input to select management function
            if ($OpSelect -eq 'exit') {                                                     # If $OpSelect equals '0'
                Break ManageAzureStorageCon                                                 # Breaks :ManageAzureStorageCon 
            }                                                                               # End if ($OpSelect -eq 'exit')
            elseif ($OpSelect -eq '1') {                                                    # Else if $OpSelect equals '1'
                Write-Host "New Storage Container"                                          # Write message to screen
                NewAzStorageContainer                                                       # Calls function
            }                                                                               # End elseif ($OpSelect -eq '1')
            elseif ($OpSelect -eq '2') {                                                    # Else if $OpSelect equals '2'
                Write-Host 'List All Storage Containers'                                    # Write message to screen
                ListAzStorageContainer                                                      # Calls function    
            }                                                                               # End elseif ($OpSelect -eq '2')
            elseif ($OpSelect -eq '3') {                                                    # Else if $OpSelect equals '3'
                Write-Host 'Remove Storage Container'                                       # Write message to screen
                RemoveAzStorageContainer                                                    # Calls function
            }                                                                               # End elseif ($OpSelect -eq '3')
            else {                                                                          # All other inputs for $OpSelect
                Write-Host "That was not a valid option"                                    # Write message to screen
            }                                                                               # End else (if ($OpSelect -eq 'exit'))
        }                                                                                   # End ManageAzureStorageCon while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End begin
}                                                                                           # End function ManageAzStorageContainer
function NewAzStorageContainer {                                                            # Creates new storage container(s) in a storage account
    Begin {                                                                                 # Begin function
        if (!$CallingFunction) {                                                            # If $CallingFunction does not have a value
            $CallingFunction = 'NewAzStorageContainer'                                      # Creates $CallingFunction
        }                                                                                   # End if (!$CallingFunction)
        :NewAzureStorageCon while ($true) {                                                 # Outer loop for managing function
            $StorageAccObject = GetAzStorageAccount ($CallingFunction)                      # Calls function and assigns output to $var
            if (!$StorageAccObject) {                                                       # If $StorageAccObject is $null
                Break NewAzureStorageCon                                                    # Breaks :NewAzureStorageCon
            }                                                                               # End if (!$StorageAccObject)
            :SetAzureStorageConName while ($true) {                                         # Inner loop for setting storage account name
                Try {                                                                       # First validation of the storage container name or names
                    $StorageConNameInput = '0'                                              # Sets $StorageConNameInput to '0'
                    $StorageConNameSplit = $null                                            # Clears $StorageConNameSplit
                    Write-Host 'Storage container names must be atleast 3 characters'       # Write message to screen
                    Write-Host 'and made up of letters and numbers only'                    # Write message to screen
                    Write-Host ''                                                           # Write message to screen    
                    Write-Host 'To create multiple containers in this storage account,'     # Write message to screen
                    Write-Host 'enter each name seperated by a [Space]'                     # Write message to screen
                    [ValidatePattern('^[a-z,0-9,\s]+$')]$StorageConNameInput = `
                        [string](Read-Host "Storage account name or names").ToLower()       # Operator input for the container names
                }                                                                           # End Try 
                catch {                                                                     # If try fails
                    Write-Host ''                                                           # Write message to screen
                    Write-Host 'The provided name(s) were not valid,'                       # Write message to screen
                    Write-Host 'accepted inputs are letters and numbers only'               # Write message to screen
                    Start-Sleep(3)                                                          # Pauses all actions for 3 seconds
                }                                                                           # End Catch
                if ($StorageConNameInput -eq '0') {                                         # If $StorageConNamInput is 0 (failed check)
                    Clear-Host                                                              # Clears screen
                }                                                                           # End if ($StorageConNameInput -eq '0')
                else {                                                                      # If $StorageConNameInput has pass validation
                    :CheckAzureStorageConName while ($true) {                               # Inner loop for verifing each name
                        if ($StorageConNameInput -eq 'exit') {                              # If $StorageConName equals exit
                            Break NewAzStorageAccount                                       # Breaks :NewAzStorageAccount
                        }                                                                   # End if ($StorageConNameInput -eq 'exit')
                        $StorageConNameSplit = $StorageConNameInput.split()                 # $StorageConSplit equals $StorageConNameInput.Split()
                        foreach ($_ in $StorageConNameSplit) {                              # For each item in $StorageConNameSplit
                            if ($_.length -le 2) {                                          # If current item is 2 or less charaters
                                Write-Host ''                                               # Write message to screen
                                Write-Host 'The name'$_' is invalid, the minimum'           # Write message to screen
                                Write-Host 'length of a name is 3 characters'               # Write message to screen
                                Write-Host ''                                               # Write message to screen
                                Start-Sleep(3)                                              # Pauses all action for 3 seconds
                                Clear-Host                                                  # Clears screen
                                Break CheckAzureStorageConName                              # End Break CheckAzureStorageConName
                            }                                                               # End if ($_.length -le 2)
                            elseif ($_.Length -ge 64) {                                     # If current item is 64 or more charaters
                                Write-Host ''                                               # Write message to screen
                                Write-Host 'The name'$_' is invalid, the maximium'          # Write message to screen
                                Write-Host 'length of a name is 63 characters'              # Write message to screen
                                Write-Host ''                                               # Write message to screen
                                Start-Sleep(5)                                              # Pauses all action for 5 seconds
                                Clear-Host                                                  # Clears screen
                                Break CheckAzureStorageConName                              # End Break CheckAzureStorageConName
                            }                                                               # End elseif ($_.Length -ge 64)
                            else {                                                          # All other inputs for $_
                                Write-Host ''                                               # Write message to screen
                                Write-Host $_ 'is a valid name'                             # Write message to screen
                                Start-Sleep(1)                                              # Pauses all actions for 1 second
                            }                                                               # End else (if ($_.length -le 2))
                        }                                                                   # End foreach ($_ in $StorageConNameSplit) 
                        if ($StorageConNameSplit.count -gt 1) {                             # If $StorageConNameSplit has more than one value
                            Write-Host 'Create multiple storage containers '                # Write message to screen
                            Write-Host 'with the following names:'                          # Write message to screen
                            Write-Host ''                                                   # Write message to screen
                            Write-Host $StorageConNameSplit -Separator `n                   # Writes all names to screen
                            Write-Host ''                                                   # Write message to screen
                        }                                                                   # End if ($StorageConNameSplit.count -gt 1)
                        else {                                                              # If $StorageConNameSplit has 1 value
                            Write-Host 'Create a storage account named:' `
                                $StorageConNameInput                                        # Write message to screen
                        }                                                                   # End else (if ($StorageConNameSplit.count -gt 1))
                        $OpConfirm = Read-Host '[Y] or [N]'                                 # Operator input for approving the name
                        if ($OpConfirm -eq 'y') {                                           # If $OpConfirm equals 'y'
                            Clear-Host                                                      # Clears screen 
                            Break SetAzureStorageConName                                    # Breaks :SetAzureStorageConName
                        }                                                                   # End if ($OpConfirm -eq 'y')
                        else {                                                              # All other inputs for $OpConfirm
                            Clear-Host                                                      # Clears screen 
                            Break CheckAzureStorageConName                                  # Breaks :CheckAzureStorageConName
                        }                                                                   # End else (if ($OpConfirm -eq 'y'))
                    }                                                                       # End :CheckAzureStorageConName while ($true)
                }                                                                           # End else (if ($StorageConNameInput -eq '0'))
            }                                                                               # End :SetAzureStorageConName while ($true)
            Write-Host 'Please review the following permissions'
            Write-Host ''                                                                   # Write message to screen
            Write-Host 'Container: Provides full read'                                      # Write message to screen
            Write-Host 'access to a container and its blobs.'                               # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            Write-Host 'Blob:      Provides read access to'                                 # Write message to screen
            Write-Host 'blob data throughout a container through'                           # Write message to screen
            Write-Host 'anonymous request, but does not provide'                            # Write message to screen
            Write-Host 'access to container data.'                                          # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            Write-Host 'Off:       Restricts access to only'                                # Write message to screen
            Write-Host 'the storage account owner.'                                         # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            $ObjectList = @('Container';'Blob';'Off')                                       # List of valid rights input
            $ObjectNumber = 1                                                               # Creates ObjectNumber
            [System.Collections.ArrayList]$ObjectArray=@()                                  # Creates ObjectArray
            foreach ($_ in $ObjectList) {                                                   # For each item in $ObjectList
                $ObjectInput=[PSCustomObject]@{'Number'=$ObjectNumber;'Name'=$_}            # Combines $ObjectNumber and current item
                $ObjectArray.Add($ObjectInput) | Out-Null                                   # Adds $ObjectInput to $ObjectArray
                $ObjectNumber = $ObjectNumber + 1                                           # ObjectNumber is $ObjectNumber + 1
            }                                                                               # End foreach ($_ in $ObjectList)
            :SetAzureStorageConRights while ($true) {                                       # Inner loop for setting the rights level
                Write-Host '[0] Exit'                                                       # Write message to screen
                foreach ($_ in $ObjectArray) {                                              # For each item in $ObjectArray 
                    $Number = $_.Number                                                     # $Number equals current item .Number
                    Write-Host "[$Number]"$_.Name                                           # Write message to screen
                }                                                                           # End foreach ($_ in $ObjectArray)
                $OpSelect = Read-Host 'Select rights level [#]'                             # Operator input for the rights level
                if ($OpSelect -eq '0') {                                                    # If $OpSelect is equal to '0'
                    Break NewAzureStorageCon                                                # Breaks :NewAzureStorageCon
                }                                                                           # End if ($OpSelect -eq '0')
                elseif ($OpSelect -in $ObjectArray.Number) {                                # If $OpSelect in $ObjectArray.number
                    $OpSelect = $ObjectArray | Where-Object {$_.Number -eq $OpSelect}       # $OpSelect equals $ObjectArray where $OpSelect equals $ObjectArray.Number
                    $StorageConRights = $OpSelect.Name                                      # $StorageConRights equals $OpSelect.Name
                    Break SetAzureStorageConRights                                          # Breaks :SetAzureStorageConRights
                }                                                                           # End elseif ($OpSelect -in $ObjectArray.Number)
                else {                                                                      # All other inputs for $OpSelect
                    Write-Host 'That was not a valid input'                                 # Write message to screen
                }                                                                           # End else (if ($OpSelect -eq '0'))
            }                                                                               # End :SetAzureStorageConRights while ($true)
            if ($StorageConNameSplit.Count -gt 1) {                                         # If StorageConNameSplit is not $null
                Write-Host 'Creating storage containers, this may take a minute'            # Write message to screen
                Try {                                                                       # Try the following
                    $StorageConNameSplit | New-AzStorageContainer -context `
                        $StorageAccObject.Context -Permission $StorageConRights `
                        -ErrorAction 'Stop'                                                 # Creates the storage containers
                }                                                                           # End try
                catch {                                                                     # If Try fails
                    Write-Host 'An error has occured'                                       # Write message to screen
                    Write-Host  ''                                                          # Write message to screen
                    Write-Host 'The container name may'                                     # Write message to screen
                    Write-Host 'already exist in this account'                              # Write message to screen
                    Pause                                                                   # Pauses for operator input
                    Break NewAzureStorageCon                                                # Breaks :NewAzureStorageCon
                }                                                                           # End catch
                Write-Host 'The storage containers have been made'                          # Write message to screen
                Pause                                                                       # Pauses for operator input
                Break NewAzureStorageCon                                                    # Breaks :NewAzureStorageCon
            }                                                                               # End if ($StorageConNameSplit.Count -gt 1) 
            else {                                                                          # If $StorageConNameSplit.count is 1
                Try {                                                                       # Try the following
                    Write-Host 'Creating the storage container, this may take a minute'     # Write message to screen
                    $StorageConNameSplit | New-AzStorageContainer -context `
                        $StorageAccObject.Context -Permission $StorageConRights `
                        -ErrorAction 'Stop'                                                 # Creates the storage container
                }                                                                           # End try
                catch {                                                                     # If try fails
                    Write-Host 'An error has occured'                                       # Write message to screen
                    Write-Host  ''                                                          # Write message to screen
                    Write-Host 'The container name may'                                     # Write message to screen
                    Write-Host 'already exist in this account'                              # Write message to screen
                    Pause                                                                   # Pauses for operator input
                    Break NewAzureStorageCon                                                # Breaks :NewAzureStorageCon
                }                                                                           # End catch
                Write-Host 'The storage container has been made'                            # Write message to screen
                Pause                                                                       # Pauses for operator input
                Break NewAzureStorageCon                                                    # Breaks :NewAzureStorageCon
            }                                                                               # End else (if ($StorageConNameSplit.Count -gt 1))
        }                                                                                   # End :NewAzureStorageCon while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End begin
}                                                                                           # End function NewAzStorageContainer
function ListAzStorageContainer {                                                           # Function for listing storage containers
    Begin {                                                                                 # Begin function
        :ListAzStorageCon while ($true) {                                                   # Outer loop for managing function
            $RGList = Get-AzResourceGroup                                                   # creates list of all resource groups
            foreach ($_ in $RGList) {                                                       # For each object in $RGList
                $StorageAccList = Get-AzStorageAccount -ResourceGroupName `
                    $_.ResourceGroupName                                                    # Creates a list of all storage accounts in current resource group
                if ($StorageAccList) {                                                      # If $StorageAccList has a value
                    foreach ($_ in $StorageAccList) {                                       # For each item in $StorageAccList
                        Write-Host '------------------------------------------'             # Write message to screen
                        Write-Host ''                                                       # Write message to screen
                        Write-Host 'Resource group:   '$_.ResourceGroupName                 # Write message to screen
                        Write-Host 'Storage account:  '$_.StorageAccountName                # Write message to screen
                        Try {                                                               # Try the following 
                            $StorageConList = Get-AzStorageContainer -Context $_.Context    # Creates a list of all containers in current $StorageAccount
                        }                                                                   # End Try
                        catch {                                                             # If try fails
                            Write-Host `
                                'You may not have the permissions to view this acount'      # Write message to screen
                            Write-Host 'The account may have a lock on it'                  # Write message to screen
                        }                                                                   # End catch
                        if ($StorageConList) {                                              # If $StorageConList has a value
                            foreach ($_ in $StorageConList) {                               # For each item in $StorageConList
                                Write-Host 'Storage container:'$_.Name 
                            }                                                               # End foreach ($_ in $StorageConList)
                            Write-Host ''                                                   # Write message to screen
                        }                                                                   # End if ($StorageConList)
                        else {                                                              # If $StorageConList does not have a value
                            Write-Host 'Storage container: None'                            # Write message to screen
                            Write-Host ''                                                   # Write message to screen
                        }                                                                   # End else  (if ($StorageConList))
                    }                                                                       # End foreach ($_ in $StorageAccList)
                }                                                                           # End if ($StorageAccList)
                else {                                                                      # If $StorageAccList does not have a value
                    Write-Host '------------------------------------------'                 # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    Write-Host 'Resource group:   '$_.ResourceGroupName                     # Write message to screen
                    Write-Host 'Storage account:   None'                                    # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                }                                                                           # End else(if ($StorageAccList))
            }                                                                               # End foreach ($_ in $RGList)
            Write-Host '------------------------------------------'                         # Write message to screen
            Write-Host ''                                                                   # Write message to screen 
            Pause                                                                           # Pauses for operator input
            Break ListAzStorageCon                                                          # Breaks :ListAzStorageCon
        }                                                                                   # End :ListAzStorageCon while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function ListAzStorageContainer
function GetAzStorageContainer {                                                            # Function to get a storage container
    Begin {                                                                                 # Begin function
        $ErrorActionPreference='silentlyContinue'                                           # Disables error reporting
        if (!$CallingFunction) {                                                            # If $CallingFunction does not have a value
            $CallingFunction = 'GetAzStorageContainer'                                      # Creates $CallingFunction
        }                                                                                   # End if (!$CallingFunction)                                                              
        :GetAzureStorageContainer while ($true) {                                           # Outer loop for managing function
            $StorageAccObject = GetAzStorageAccount ($CallingFunction)                      # Call function and assigns output to $var
            if (!$StorageAccObject) {                                                       # If $StorageAccObject is $null
                Break GetAzureStorageContainer                                              # Breaks :GetAzureStorageContainer
            }                                                                               # End if (!$StorageAccObject)
            $ObjectList = Get-AzStorageContainer -Context $StorageAccObject.Context         # Gets a list of all storage containers in $StorageAccObject
            if (!$ObjectList) {                                                             # If $ObjectList is $null   
                Write-Host 'No storage containers found on account:'`
                    $StorageAccObject.StorageAccountName                                    # Write message to screen
                Start-Sleep(5)                                                              # Pauses all actions for 5 seconds
                Break GetAzureStorageContainer                                              # Ends :GetAzureStorageContainer
            }                                                                               # End if (!$StorageAccList)
            $ObjectNumber = 1                                                               # Sets $ObjectNumber to 1
            [System.Collections.ArrayList]$ObjectArray = @()                                # Creates the object array
            foreach ($_ in $ObjectList) {                                                   # For each $_ in $ObjectListList
                $ObjectInput = [PSCustomObject]@{'Name' = $_.Name; `
                    'Number' = $ObjectNumber;'PA'=$_.PublicAccess;'LM'=$_.LastModified}     # Creates the item to loaded into array
                $ObjectArray.Add($ObjectInput) | Out-Null                                   # Loads item into array, out-null removes write to screen
                $ObjectNumber = $ObjectNumber + 1                                           # Increments $ObjectNumber by 1
            }                                                                               # End foreach ($_ in $ObjectList)
            Write-Host "[0]  Exit"                                                          # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            foreach ($_ in $ObjectArray) {                                                  # For each $_ in $ObjectArray
                $Number = $_.Number                                                         # Sets $Number to current item .number
                if ($_.Number -le 9) {                                                      # If current item .number is 9 or less
                    Write-Host "[$Number]   "$_.Name                                        # Write message to screen
                }                                                                           # End if ($_.Number -le 9) 
                else {                                                                      # If current item .number is greater then 9
                    Write-Host "[$Number]  "$_.Name                                         # Write message to screen
                }                                                                           # End else (if ($_.Number -le 9) 
                Write-Host 'Public Access:'$_.PA                                            # Write message to screen
                Write-Host 'Last Modified:'$_.LM                                            # Write message to screen
                Write-Host ''                                                               # Write message to screen
            }                                                                               # End foreach ($_ in $ObjectArray)
            :SelectAzureObjectList while ($true) {                                          # Inner loop to select the resource group
                if ($CallingFunction -and $CallingFunction -ne 'GetAzStorageAccount' `
                    -and $CallingFunction -ne 'GetAzStorageContainer') {                    # If $CallingFunction exists and not equal 'GetAzStorageAccount' or 'GetAzStorageContainer'
                    Write-Host `
                        'You are selecting the storage container for:'$CallingFunction      # Write message to screen
                }                                                                           # End if ($CallingFunction -and ($CallingFunction -ne 'GetAzStorageAccount' -or $CallingFunction -ne 'GetAzStorageContainer'))
                $ObjectSelect = Read-Host "Enter the storage container [#]"                 # Operator input for the storage container selection
                if ($ObjectSelect -eq '0') {                                                # If $ObjectSelect equals 0
                    Break GetAzureStorageContainer                                          # Breaks :GetAzureStorageContainer
                }                                                                           # End if ($ObjectSelect -eq '0')
                elseif ($ObjectSelect -in $ObjectArray.Number) {                            # If $ObjectSelect in $ObjectArray.Number
                    $ObjectSelect = $ObjectArray | Where-Object `
                        {$_.Number -eq $ObjectSelect}                                       # $ObjectSelect is equal to $ObjectArray where $ObjectArray.Number is equal to $ObjectSelect                                  
                    $StorageConObject = Get-AzStorageContainer -Context `
                        $StorageAccObject.Context | Where-Object `
                        {$_.Name -eq $ObjectSelect.Name}                                    # Pulls the full storage container object
                    Break SelectAzureObjectList                                             # Breaks :SelectAzureObjectList
                }                                                                           # End elseif ($ObjectSelect -in $ListArray.Number)
                else {                                                                      # All other inputs for $ObjectSelect
                    Write-Host "That was not a valid option"                                # Write message to screen
                }                                                                           # End else (if ($ObjectSelect -eq '0'))
            }                                                                               # End :SelectAzureObjectList while ($true)
            if ($CallingFunction -and $CallingFunction -ne 'GetAzStorageAccount' `
                -and $CallingFunction -ne 'GetAzStorageContainer') {                        # If $CallingFunction exists and not equal 'GetAzStorageAccount' or 'GetAzStorageContainer'
                Clear-Host                                                                  # Clears screen
                Return $StorageConObject, $StorageAccObject                                 # Returns to calling function with $vars
            }                                                                               # End if ($CallingFunction -and $CallingFunction -ne 'GetAzStorageAccount')
            else {                                                                          # If $Calling function does not exist or is equal to 'GetAzStorageAccount' or 'GetAzStorageContainer'
                Break GetAzureStorageContainer                                              # Breaks :GetAzureStorageContainer  
            }                                                                               # End  else (if ($CallingFunction -and $CallingFunction -ne 'GetAzStorageAccount'))
        }                                                                                   # End GetAzureStorageContainer
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function GetAzStorageContainer
function RemoveAzStorageContainer {                                                         # Function to removes existing storage container
    Begin {                                                                                 # Begin function
        $CallingFunction = 'RemoveAzStorageContainer'                                       # Creates $CallingFunction
        :RemoveAzureStorageCon while ($true) {                                              # Outer loop for managing function
            $StorageConObject, $StorageAccObject = GetAzStorageContainer ($CallingFunction) # Calls function and assigns output to $var
            if (!$StorageConObject) {                                                       # If $StorageConObject is $null
                Break RemoveAzureStorageCon                                                 # Breaks :RemoveAzureStorageCon
            }                                                                               # End if (!$StorageAccObject)
            Write-Host 'Remove storage container:' $StorageConObject.Name                   # Write message to screen
            Write-Host 'from storage account:    ' $StorageAccObject.StorageAccountName     # Write message to screen
            $OpConfirm = Read-Host '[Y] Yes [N] No'                                         # Operator confimation to remove the storage container
            if ($OpConfirm -eq 'y') {                                                       # If $OpConfirm equals 'y'
                Try {                                                                       # Try the following
                    Remove-AzStorageContainer -Context $StorageAccObject.Context -Name `
                        $StorageConObject.Name -Force -ErrorAction 'Stop'                   # Removes storage container
                }                                                                           # End Try
                catch {                                                                     # Try fails
                    Write-Host 'An error has occured'                                       # Write message to screen
                    Write-Host 'You may not have the'                                       # Write message to screen
                    Write-Host 'permissions required'                                       # Write message to screen
                    Write-Host 'to complete this action'                                    # Write message to screen
                    Pause                                                                   # Pauses for operator input
                    Break RemoveAzureStorageCon                                             # Breaks RemoveAzureStorageAcc
                }                                                                           # End Catch
                Write-Host $StorageConObject.Name'has been removed'                         # Write message to screen
                Start-Sleep(3)                                                              # Pauses all action for 3 seconds
                Break RemoveAzureStorageCon                                                 # Breaks :RemoveAzureStorageCon
            }                                                                               # End if ($OpConfirm -eq 'y')
            else {                                                                          # All other inputs for $OpConfirm
                Write-Host 'No changes made'                                                # Write message to screen
                Start-Sleep(2)                                                              # Pauses all action for 2 seconds
                Break RemoveAzureStorageCon                                                 # Breaks :RemoveAzureStorageCon
            }                                                                               # End else (if ($OpConfirm -eq 'y'))
        }                                                                                   # End :RemoveAzureStorageCon while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function RemoveAzStorageContainer
# End ManageAzStorageContainer
# Functions for ManageAzStorageBlob
function ManageAzStorageBlob {                                                              # Manages storage blob functions
    Begin {                                                                                 # Begin function
        :ManageAzureStorageBlob while ($true) {                                             # Outer loop for managing function
            Write-Host 'Azure Storage Blob Management'                                      # Write message to screen
            Write-Host '[1] Add Storage Blob'                                               # Write message to screen
            Write-Host '[2] List Storage Blobs'                                             # Write message to screen
            Write-Host '[3] Download Storage Blobs'                                         # Write message to screen
            Write-Host '[4] Remove Storage Blobs'                                           # Write message to screen
            Write-Host '[Exit] to return'                                                   # Write message to screen
            $OpSelect = Read-Host 'Option [#]'                                              # Operator selection of management function        
            if ($OpSelect -eq 'exit') {                                                     # If $OpSelect equals 'exit'
                Break ManageAzureStorageBlob                                                # Breaks :ManageAzureStorageBlob 
            }                                                                               # End if ($OpSelect -eq 'exit')
            elseif ($OpSelect -eq '1') {                                                    # Else if $OpSelect equals '1'
                Write-Host 'Add Storage Blob'                                               # Write message to screen
                SetAzStorageBlobContent                                                     # Calls function 
            }                                                                               # End elseif ($OpSelect -eq '1')
            elseif ($OpSelect -eq '2') {                                                    # Else if $OpSelect equals '2'
                Write-Host 'List Storage Blobs'                                             # Write message to screen
                ListAzStorageBlob                                                           # Calls function  
            }                                                                               # End elseif ($OpSelect -eq '2')
            elseif ($OpSelect -eq '3') {                                                    # Else if $OpSelect equals '3'
                Write-Host 'Download Storage Blob'                                          # Write message to screen
                GetAzStorageBlobContent                                                     # Calls function 
            }                                                                               # End elseif ($OpSelect -eq '3')
            elseif ($OpSelect -eq '4') {                                                    # Else if $OpSelect equals '4'
                Write-Host 'Remove Storage Blobs'                                           # Write message to screen
                RemoveAzStorageBlob                                                         # Calls function 
            }                                                                               # End elseif ($OpSelect -eq '4')
            else {                                                                          # All other inputs for $OpSelect
                Write-Host 'That was not a valid option'                                    # Write message to screen
            }                                                                               # End else (if ($OpSelect -eq 'exit))
        }                                                                                   # End :ManageAzureStorageBlob while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End begin
}                                                                                           # End function ManageAzStorage
function SetAzStorageBlobContent {                                                          # Function to upload a new blob to storage container
    Begin {                                                                                 # Begin function
        $CallingFunction = 'SetAzStorageBlobContent'                                        # Creates $CallingFunction
        :SetAzureBlobContent while ($true) {                                                # Outer loop for managing function
            $StorageConObject, $StorageAccObject = GetAzStorageContainer ($CallingFunction) # Calls function and assigns output to $var
                if (!$StorageConObject) {                                                   # If $StorageConObject is $null
                    Break SetAzureBlobContent                                               # Breaks :SetAzureBlobContent
                }                                                                           # End if (!$StorageConObject)
            :SetAzureBlobTier while($true) {                                                # Inner loop for setting access tier
                Write-Host '[0] Exit'                                                       # Write message to screen
                Write-Host '[1] Hot'                                                        # Write message to screen
                Write-Host '[2] Cool'                                                       # Write message to screen
                $OpSelect = Read-Host 'Set blob access tier [#]'                            # Operator input for the blob tier
                if ($OpSelect -eq '0') {                                                    # If $OpSelect equals '0'
                    Break SetAzureBlobContent                                               # Breaks :SetAzureBlobContent
                }                                                                           # End if ($OpSelect -eq '0')
                elseif ($OpSelect -eq '1') {                                                # Else if $OpSelect equals '1'
                    $BlobTier = 'Hot'                                                       # Sets $BlobTier
                    Clear-Host                                                              # Clears screen
                    Break SetAzureBlobTier                                                  # Breaks :SetAzureBlobTier
                }                                                                           # End elseif ($OpSelect -eq '1')
                elseif ($OpSelect -eq '2') {                                                # Else if $OpSelect equals '2'
                    $BlobTier = 'Cool'                                                      # Sets $BlobTier
                    Clear-Host                                                              # Clears screen
                    Break SetAzureBlobTier                                                  # Breaks :SetAzureBlobTier
                }                                                                           # End elseif ($OpSelect -eq '2')
                else {                                                                      # All other inputs for $OpSelect
                    Write-Host 'That was not a valid option'                                # Write message to screen
                }                                                                           # End else (if ($OpSelect -eq '0'))
            }                                                                               # End :SetAzureBlobTier while($true)
            :SetLocalFileName while ($true) {                                               # Inner loop for adding file path
                Write-Host 'Please enter the full path plus file name and extension'        # Write message to screen
                $LocalFilePath = Read-Host 'Example: C:\users\admin\desktop\file.csv'       # Collects the path to file
                if ($LocalFilePath -eq 'exit') {                                            # If $LocalFilePath equals 'exit'
                    Break SetAzureBlobContent                                               # Breaks :SetAzureBlobContent
                }                                                                           # End if ($LocalFilePath -eq 'exit')
                if (Test-Path $LocalFilePath) {                                             # If file exists
                    Write-Host 'This is the file to be uploaded'                            # Write message to screen
                    Write-Host $LocalFilePath                                               # Write message to screen
                    $OpConfirm = Read-Host '[Y] Yes [N] No'                                 # Operator confirmation of the file to be uploaded
                    if ($OpConfirm -eq 'y') {                                               # If $OpConfirm equals 'y'
                        Clear-Host                                                          # Clears screen
                        Break SetLocalFileName                                              # Breaks :SetLocalFileName
                    }                                                                       # End if ($OpConfirm -eq 'y')
                }                                                                           # End if (Test-Path $LocalFilePath)
                else {                                                                      # If file does not exist
                    Write-Host 'The file could not be located'                              # Write message to screen
                    Write-Host 'Please recheck the path and file name'                      # Write message to screen
                    Pause                                                                   # Pauses all action for operator input
                    Clear-Host                                                              # Clears screen
                }                                                                           # End else (Test-Path $LocalFilePath)
            }                                                                               # End :SetLocalFileName while ($true)
            :SetAzureBlobName while ($true) {                                               # Inner loop for setting the blob file name in storage container
                $BlobFileName = Read-Host 'New name and ext for this file'                  # Operator input for the blob name and ext once uploaded
                if ($BlobFileName -eq 'exit') {                                             # If $BlobFileName is 'exit'
                    Break SetAzureBlobContent                                               # Breaks :SetAzureBlobContent
                }                                                                           # End if ($BlobFileName -eq 'exit')
                Write-Host 'This will be the file name in the container'                    # Write message to screen
                Write-Host $BlobFileName                                                    # Write message to screen
                $OpConfirm = Read-Host '[Y] Yes [N] No'                                     # Operator confirmation of the blob file name
                if ($OpConfirm -eq 'y') {                                                   # If $OpConfirm equals 'y'
                    Break SetAzureBlobName                                                  # Breaks :SetAzureBlobName  
                }                                                                           # End if ($OpConfirm -eq 'y')
            }                                                                               # End :SetAzureBlobName while ($true)
            Try {
                Set-AzStorageBlobContent -File $LocalFilePath -Blob $BlobFileName `
                    -Container $StorageConObject.Name -Context $StorageAccObject.Context `
                    -StandardBlobTier $BlobTier -ErrorAction 'Stop'                         # Adds file as blob
            }                                                                               # End try
            catch {                                                                         # If try fails
                Write-Host 'An error has occured'                                           # Write message to screen
                Write-Host 'You may not have the'                                           # Write message to screen
                Write-Host 'permissions required'                                           # Write message to screen
                Write-Host 'to complete this action'                                        # Write message to screen
                Pause                                                                       # Pauses for operator input
                Break SetAzureBlobName                                                      # Breaks SetAzureBlobName
            }                                                                               # End catch
            Write-Host 'The file has been uploaded into storage container'                  # Write message to screen
            Start-Sleep(2)                                                                  # Pauses all action for 2 seconds
            Break SetAzureBlobName                                                          # Breaks SetAzureBlobName
        }                                                                                   # End :SetAzureBlobContent while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function SetAzStorageBlobContent
function ListAzStorageBlob {                                                                # Function to list all blobs in storage container
    Begin {                                                                                 # Begin function
        $CallingFunction = 'ListAzStorageBlob'                                              # Creates $CallingFunction
        $ErrorActionPreference = 'silentlyContinue'                                         # Disables error messages
        :ListAzureBlobs while ($true) {                                                     # Outer loop for managing function
            $StorageConObject, $StorageAccObject = GetAzStorageContainer ($CallingFunction) # Calls function and assigns output to $var
            if (!$StorageConObject) {                                                       # If $StorageConObject is $null
                Break ListAzureBlobs                                                        # Breaks :ListAzureBlobs
            }                                                                               # End if (!$StorageConObject)
            $ObjectList = Get-AzStorageBlob -Context $StorageAccObject.context -Container `
                $StorageConObject.Name                                                      # Object containing the blob info objects
            if (!$ObjectList) {                                                             # If $ObjectList is $null
                Write-Host 'No blobs exist in this container'                               # Write message to screen
                Pause                                                                       # Pauses for operator input
                Break ListAzureBlobs                                                        # Breaks :ListAzureBlobs
            }                                                                               # End if (!$ObjectList)
            [System.Collections.ArrayList]$ObjectArray = @()                                # Creates the RG list array
            foreach ($_ in $ObjectList) {                                                   # For each $_ in $ObjectListList
                $ObjectInput = [PSCustomObject]@{'Name' = $_.Name;'Type'=$_.BlobType; `
                    'LM'=$_.LastModified;'AT'=$_.AccessTier;'Del'=$_.IsDeleted;`
                    'VID'=$_.VersionID}                                                     # Creates the item to loaded into array
                $ObjectArray.Add($ObjectInput) | Out-Null                                   # Loads item into array, out-null removes write to screen
            }                                                                               # End foreach ($_ in $ObjectList)
            foreach ($_ in $ObjectArray) {                                                  # For each item in $ObjectArray
                Write-Host 'Name:       '$_.Name                                            # Write message to screen
                Write-Host 'Type:       '$_.Type                                            # Write message to screen
                Write-Host 'Last Mod:   '$_.LM                                              # Write message to screen
                Write-Host 'Access Tier:'$_.AT                                              # Write message to screen
                Write-Host 'Deleted:    '$_.Del                                             # Write message to screen
                Write-Host 'VersionID:  '$_.VID                                             # Write message to screen
                Write-Host ''                                                               # Write message to screen
            }                                                                               # End foreach ($_ in $ObjectArray)
            Pause                                                                           # Pauses all actions for operator input
            Break ListAzureBlobs                                                            # Breaks :ListAzureBlobs
        }                                                                                   # End :ListAzureBlobs while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function ListAzStorageBlob
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
function RemoveAzStorageBlob { # Removes a storage blob
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
# End ManageAzStorageBlob
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
            $OpSelectShare = Read-Host "Option?" # Collects operator input on $OpSelectShare option
            if ($OpSelectShare -eq 'exit') { # Exit if statement for this function
                Break ManageAzureStorageShares # Ends :ManageAzureStorageShares loop, leading to return statement
            } # End if ($OpSelectShare -eq 'exit')
            elseif ($OpSelectShare -eq '1') { # Elseif statement for managing storage accounts
                Write-Host "New Storage Share" # Write message to screen
                $StorageShareObject = NewAzStorageShare ($StorageAccObject, $RGObject) # Calls function and assigns to $var 
                Write-Host $StorageShareObject.Name
            } # End elseif ($OpSelectShare -eq '1')
            elseif ($OpSelectShare -eq '2') { # Elseif statement for managing storage containers
                Write-Host "Get Storage Share" # Write message to screen
                $StorageShareObject, $StorageAccObject = GetAzStorageShare ($StorageAccObject, $RGObject) # Calls function and assigns to $var 
            } # End elseif ($OpSelectShare -eq '2')
            elseif ($OpSelectShare -eq '3') { # Elseif statement for managing Blobs
                Write-Host "List All Storage Shares" # Write message to screen
                GetAzStorageShareAll # Calls function 
            } # End elseif ($OpSelectShare -eq '3')
            elseif ($OpSelectShare -eq '4') { # Elseif statement for managing Storage shares
                Write-Host "Remove Storage Share" # Write message to screen
                RemoveAzStorageShare ($StorageAccObject, $StorageShareObject) # Calls function and assigns to $var
            } # End elseif ($OpSelectShare -eq '4')
            elseif ($OpSelectShare -eq '0') { # Elseif statement for managing disks
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
            } # End elseif ($OpSelectShare -eq '0')
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
            Write-Host "3 List All Key Vaults Keys" # Write message to screen
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
                AddAzKeyVaultKey # Calls function ListAzKeyVaultKey
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
function AddAzKeyVaultKey { # Creates a new key vault key
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
function DownloadAzKeyVaultKey { # Downloads a selected key vault key
    Begin {
        $ErrorActionPreference = 'silentlyContinue' # Disables error reporting
        :DownloadAzureKVKey while ($true) { # Outer loop for managing function
            if (!$KeyVaultKeyObject) { # If $KeyVaultKeyObject is $null 
                $KeyVaultKeyObject = GetAzKeyVaultKey # Calls function and assigns output to $var
                if (!$KeyVaultKeyObject) { # If $var is still $null
                    Break DownloadAzureKeyVaultKey # Breaks :DownloadAzureKeyVaultKey    
                } # End if (!$KeyVaultObject)
            } # End if (!$KeyVaultObject)
            :SetLocalDownloadPath while ($true) { # Inner loop for setting the download path
                $LocalPath = Read-Host "Please enter the file path (E.X. C:\Users\Admin\Downloads\)" # Operator input for the download path
                if ($LocalPath -eq 'exit') { # If $var is equal to 'exit' 
                    Break DownloadAzureKVKey # Breaks :DownloadAzureKVKey
                } # End if ($LocalPath -eq 'exit')
                if ($LocalPath -notlike '*\') { # If $LocalPath does not end with \
                    Write-Host "The path is not valid" # Write message to screen
                    Write-Host "Please re-enter the path" # Write message to screen
                } # End if ($LocalPath -notlike '*\')
                else { # If $LocalPath ends with \
                    Break SetLocalDownloadPath # Breaks :SetLocalDownloadPath
                } # End else (if ($LocalPath -notlike '*\'))
            } # End :SetLocalDownloadPath while ($true)
            :SetLocalFileName while ($true) { # Inner loop for setting the key local name
                $LocalFileName = Read-Host "Enter the key name" # Operator input for the key name
                if ($LocalFileName -eq 'exit') { # If $var is equal to 'exit'
                    Break DownloadAzureKVKey # Breaks :DownloadAzureKVKey
                } # End if ($LocalFileName -eq 'exit')
                $LocalfileName = $LocalFileName+'.pem' # Adds .pem to file name
                Write-Host $LocalFileName # Write message to screen
                $OperatorConfirm = Read-Host "Use this file name [Y] or [N]" # Operator confirmation of file name
                if ($OperatorConfirm -eq 'y') { # If $OperatorConfirm equals 'y'
                    Break SetLocalFileName # Breaks :SetLocalFileName
                } # End if ($OperatorConfirm -eq 'y')
            } # End :SetLocalFileName while ($true)
            $Fullpath = $LocalPath+$LocalFileName # Creates the full download path and name $var
            Try { # Try the following
                Get-AzKeyVaultKey -VaultName $KeyVaultKeyObject.VaultName -Name $KeyVaultKeyObject.Name -OutFile $Fullpath -ErrorAction Stop # Downloads the selected key
            } # End Try
            Catch { # If try fails
                Write-Host "An error has occured" # Write message to screen
                Write-Host "You may not have permissions to this key" # Write message to screen
                Write-Host "You may not have permissions to the download location" # Write message to screen
                Write-Host "The selected download location may not exist" # Write message to screen
            } # End Catch
            Break DownloadAzureKVKey # Breaks :DownloadAzureKVKey
        } # End :DownloadAzureKVKey while ($true)
        Return # Returns to calling function with $null
    } # End Begin
} # End function DownloadAzKeyVaultKey
function RemoveAzKeyVaultKey { # Removes a key vault key
    Begin {
        $ErrorActionPreference = 'silentlyContinue' # Disables error reporting
        :RemoveAzureKeyVaultKey while ($true) {
            if (!$KeyVaultKeyObject) { # If $KeyVaultKeyObject is $null 
                $KeyVaultKeyObject = GetAzKeyVaultKey # Calls function and assigns output to $var
                if (!$KeyVaultKeyObject) { # If $var is still $null
                    Break RemoveAzureKeyVaultKey # Breaks :DownloadAzureKeyVaultKey    
                } # End if (!$KeyVaultObject)
            } # End if (!$KeyVaultObject)
            Write-host "The selected key for removal is:"$KeyVaultKeyObject.Name"in vault:"$KeyVaultKeyObject.VaultName # Write message to screen
            $ConfirmDelete = Read-Host "Remove this key [Y] or [N]" # Operator confirmation for deletion
            if (!($ConfirmDelete -eq 'y')) { # $Confirm delete is not equal to 'y'
                Break RemoveAzureKeyVaultkey # Breaks :RemoveAzureKeyVaultKey
            } # End if (!($ConfirmDelete -eq 'y'))
            else { # If $ConfirmDelete is equal to 'y'
                Write-Host "Removing" $KeyVaultKeyObject.Name # Write message to screen
                Try { # Try the following
                    Remove-AzKeyVaultKey -Name $KeyVaultKeyObject.Name -VaultName $KeyVaultKeyObject.VaultName -Force # Removes the selected key
                } # End Try
                catch { # If error on Try
                    Write-Host "There was an issue removing the selected key" # Write message to screen
                    Write-Host "You may not have the permissions to remove this key" # Write message to screen
                    Break RemoveAzureKeyVaultKey # Breaks :RemoveAzureKeyVaultKey 
                } # End catch
                Write-Host "This Key has been removed" # Write message to screen
                Break RemoveAzureKeyVaultKey # Breaks :RemoveAzureKeyVaultKey
            } # End else (if (!($ConfirmDelete -eq 'y')))
        } # End :RemoveAzureKeyVaultKey while ($true)
        Return
    } # End Begin
} # End function RemoveAzKeyVaultKey
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
        Return # Retures to calling function with $null
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
function RemoveAzKeyVaultSecret { # Removes a key vault secret
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
function ManageAzDisk { # Script for managing Azure
    Begin {
        :ManageAzureDisk while ($true) { # Outer loop for managing function
            if ($RGObject) { # If $RGObject has a value
                Write-Host '$RGObject:' $RGObject.ResourceGroupName # Write message to screen 
            } # End if ($RGObject)
            if ($DiskObject) { # If $DiskObject has a value
                Write-Host '$DiskObject:' $DiskObject.Name # Write message to screen
            } # End if ($DiskObject)
            Write-Host "0 Clear Selected Objects" # Write message to screen
            Write-Host "1 New Disk" # Write message to screen
            Write-Host "2 List All Disks" # Write message to screen
            Write-Host "3 Get Disk" # Write message to screen
            Write-Host "4 Remove Disk" # Write message to screen
            Write-Host "'Exit' to end script" # Write option list to screen
            $ManageAzDiskSel = Read-Host "Chose option" # Operator input for which option they need to run
            if ($ManageAzDiskSel -eq '1') { # Elseif statement for option 1
                Write-Host "New Disk" # Option selection write to screen
                $DiskObject = NewAzDisk ($RGObject) # Calls function and assigns output to $var
            } # End if statement
            elseif ($ManageAzDiskSel -eq '2') { # Elseif statement for option 2
                Write-Host "List All Disks" # Option selection write to screen
                ListAzDisk # Calls function ListAzDisk
            } # End elseif statement
            elseif ($ManageAzDiskSel -eq '3') { # Elseif statement for option 3
                Write-Host "Get Disk" # Option selection write to screen
                $DiskObject = GetAzDisk # Calls function and assigns output to $var
            } # End elseif statement
            elseif ($ManageAzDiskSel -eq '4') { # Elseif statement for option 4
                Write-Host "Remove Disk" # Option selection write to screen
                RemoveAzDisk ($DiskObject) # Calls function RemoveAzDisk
            } # End elseif statement
            elseif ($ManageAzDiskSel -eq '0') { # Elseif statement for option 0
                $RGObject = $null # Sets $var to $null
                $DiskObject = $null # Sets $var to $null
                Write-Host '$RGObject and $DiskObject have been cleared'
            } # End elseif ($ManageAzDiskSel -eq '0')
            elseif ($ManageAzDiskSel -eq 'exit') { # Elseif statement for ending the srcipt
                Break ManageAzureDisk # Breaks :ManageAzureDisk
            } # End elseif statement
            else { # Esle statement for all other values
                Write-Host "Invalid option" # Option selection write to screen
            } # End else statement
        } # End :ManageAzureDisk while ($true)
        Return # Returns to calling function with $null
    } # End begin statemnt
} # End ManageAzDisk
function NewAzDisk { # Creats a new disk object
    Begin {
        :NewAzureDisk while ($true) { 
            if (!$RGObject) { # IF $RGObject is $null 
                $RGObject = GetAzResourceGroup # Calls function and assigns output to $var
                if (!$RGObject) { # IF $RGObject is $null
                    Break NewAzureDisk # Breaks :NewAzureDisk
                } # End if (!$RGObject) 
            } # End if (!$RGObject)
            $LocationObject = Get-AzLocation | Where-Object {$_.Location -eq $RGObject.Location} # Pulls location from $RGObject 
            :SetAzureDiskName while ($true) { # Inner loop for setting the disk name
                $DiskNameInput = '0' # Assigns a value for elseif statement if operator input is invalid
                try { # Try statement for operator input of disk name
                    [ValidatePattern('^[a-z,0-9]+$')]$DiskNameInput = [string](Read-Host "New disk name (3-24 letters and numbers only)") # Operator input for the disk name, only allows letters and numbers. 
                } # End try
                catch {Write-Host "The disk name can only include letters and numbers"} # Error message for failed try
                if ($DiskNameInput -eq 'exit') { # $DiskNameInput is equal to exit
                    Break NewAzureDisk # Breaks :NewAzureDisk loop
                } # if ($DiskNameInput -eq 'exit')
                elseif ($DiskNameInput -eq '0') {}# Elseif when Try statement fails
                elseif ($DiskNameInput.Length -le 2 -or $DiskNameInput.Length -ge 25) { # If $DiskNameInput is not between 3 and 24 characters
                    Write-Host "The disk name must be between 3 and 24 characters in length" # Write message to screen
                } # End elseif ($DiskNameInput.Length -le 2 -or $DiskNameInput.Length -ge 25)
                else { # If Try statement input has value not equal to exit
                    Write-Host $DiskNameInput # Writes $var to screen
                    $OperatorConfirm = Read-Host "Is this name correct [Y] or [N]" # Operator confirmation
                    if ($OperatorConfirm -eq 'y' -or $OperatorConfirm -eq 'yes') { # If $OperatorConfirm is equal to 'y' or 'yes'
                        Break SetAzureDiskName # Breaks SetAzureDiskName
                    } # End If ($OperatorConfirm -eq 'y' -or $OperatorConfirm -eq 'yes')
                    else {} # If $OperatorConfirm is not -eq 'y' or 'yes;
                } # End else (if ($DiskNameInput -eq 'exit'))
            } # End :SetAzureDiskName while ($true)
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
                $DiskObject = New-AzDisk -ResourceGroupName $RGObject.ResourceGroupName -DiskName $DiskNameInput -Disk $DiskConfig # Creates the disk
            } # End if ($UseEncryptOption -eq 'y') 
            elseif ($UseEncryptOption -eq 'n') { # If $UseEncyptOption equals 'n'
                $DiskConfig = New-AzDiskConfig -Location $LocationObject.DisplayName -DiskSizeGB $DiskSizeObject -SkuName $SkuObject -OsType $DiskOSObject -CreateOption Empty -EncryptionSettingsEnabled $false # Sets the disk settings
                $DiskObject = New-AzDisk -ResourceGroupName $RGObject.ResourceGroupName -DiskName $DiskNameInput -Disk $DiskConfig # Creates the disk
            } # End elseif ($UseEncryptOption -eq 'n')
            Return $DiskObject # Returns to calling function with $DiskObject
        } # End :NewAzureDisk while ($true)
        Return # Returns to calling function with $null
    } # End Begin
} # End function NewAzDisk
function ListAzDisk { # Collects disk object
    Begin {
        :ListAzureDisk while ($true) { # Outer loop for managing function
            $DiskList = Get-AzDisk # Gets a list of all disks
            foreach ($_ in $DiskList) { # Writes all objects to screen
                Write-Host "Name:    " $_.Name               # Write message to screen
                Write-Host "RG:      " $_.ResourceGroupName  # Write message to screen
                Write-Host "OS:      " $_.OsType             # Write message to screen
                Write-Host "Size GB: " $_.DiskSizeGB         # Write message to screen
                Write-Host "State:   " $_.DiskState          # Write message to screen
                Write-Host "Location:" $_.Location           # Write message to screen
                Write-Host""                                # Write space at end of each foreach
            } # End foreach ($_ in $DiskList)
            Return # Returns to calling function with $null
        } # End :ListAzureDisk while ($true) 
    } # End Begin
} # End function ListAzDisk
function GetAzDisk { # Collects disk object
    Begin {
        :GetAzureDisk while ($true) { # Outer loop for managing function
            $DiskList = Get-AzDisk # Gets a list of all disks
            $DiskListNumber = 1 # $Var for setting $DiskList.Number
            foreach ($_ in $DiskList) { # For each item in $DiskList
                $_ | Add-Member -NotePropertyName 'Number' -NotePropertyValue $DiskListNumber # Adds number property to each item in list
                $DiskListNumber = $DiskListNumber + 1 # Increments $DiskListNumber by 1
            } # End foreach ($_ in $DiskList)
            Write-Host "Option:  0 [Exit]" # Write message to screen
            Write-Host"" # Write message to screen
            foreach ($_ in $DiskList) { # Writes all objects to screen
                Write-Host "Option: "$_.Number # Write message to screen
                Write-Host "Name:   " $_.Name # Write message to screen
                Write-Host "RG:     " $_.ResourceGroupName # Write message to screen
                Write-Host "State:  " $_.DiskState # Write message to screen
                Write-Host"" # Write message to screen
            } # End foreach ($_ in $DiskList)
            :SelectAzureDisk while ($true) { # Inner loop for selecting object from list
                $DiskSelect = Read-Host "Please enter the number of the disk" # Operator input for the selection
                if ($DiskSelect -eq '0') { # If $DiskSelect is 0
                    Break GetAzureDisk # Breaks :GetAzureDisk
                } # End if ($_Select -eq '0')
                $DiskListSelect = $DiskList | Where-Object {$_.Number -eq $DiskSelect} # Isolates selected object 
                if ($DiskListSelect) { # If $DiskListSelect has a valud
                    Break SelectAzureDisk # Breaks SelectAzureDisk
                } # End if ($DiskListSelect)
                Write-Host "That was not a valid selection" # Write message to screen 
            } # End :SelectAzureDisk while ($true)
            $DiskObject = Get-AzDisk | Where-Object {$_.Name -eq $DiskListSelect.Name} # Pulls the full list object
            Return $DiskObject # Returns $Object to calling function
        } # End :GetAzureDisk while ($true)
        Return # Returns to calling function with $null 
    } # End Begin
} # End function GetAzDisk
function RemoveAzDisk { # Removes a disk object
    Begin {
        :RemoveAzureDisk while ($true) { # Outer loop for managing function
            if (!$DiskObject) { # If $DiskObject is $null
                $DiskObject = GetAzDisk # Calls function and assigns output to $var
                if (!$DiskObject) { # If $DiskObject is $null
                    Break RemoveAzureDisk # Breaks :RemoveAzureDisk
                } # End if (!$DiskObject)
            } # End if (!$DiskObject)
            Write-Host "Remove disk"$DiskObject.Name "in resource group"$DiskObject.ResourceGroupName # Write message to screen
            $ConfirmDelete = Read-Host "[Y] or [N]" # Operator confirmation to delete the disk
            if (!($ConfirmDelete -eq 'y')) { # If Confirm delete is not 'y'
                Write-Host "No action taken" # Write message to screen
                Break RemoveAzureDisk # Breaks :RemoveAzureDisk
            } # End if (!($ConfirmDelete -eq 'y'))
            else { # If $ConfirmDelete is 'y'
                Write-Host "Deleting"$DiskObject.Name # Write message to screen
                Try { # Try the following
                    Remove-AzDisk -ResourceGroupName $DiskObject.ResourceGroupName -DiskName $DiskObject.Name -Force -ErrorAction 'Stop' # Removes selected disk
                } # End Try
                Catch { # If try fails
                    Write-Host "An error has occured" # Write message to screen
                    Write-Host "The disk may still be in use" # Write message to screen
                    Write-Host "The resource group maybe locked" # Write message to screen
                    Write-Host "You may not have the permissions to remove this disk" # Write message to screen
                    Break RemoveAzureDisk # Breaks :RemoveAzureDisk
                } # End catch
                Write-Host "The selected disk has been deleted" # Write message to screen
                Break RemoveAzureDisk # Breaks :RemoveAzureDisk
            } # End else if (!($ConfirmDelete -eq 'y'))
        } # End :RemoveAzureDisk while ($true)
        Return # Returns to calling function with $null
    } # End Begin 
} # End function RemoveAzDisk
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