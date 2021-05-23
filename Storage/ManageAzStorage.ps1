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
    New-AzStorageDirectory:     https://docs.microsoft.com/en-us/powershell/module/az.storage/new-azstoragedirectory?view=azps-5.9.0
    Get-AzStorageFile:          https://docs.microsoft.com/en-us/powershell/module/az.storage/get-azstoragefile?view=azps-5.9.0
    Get-AzStorageFileContent:   https://docs.microsoft.com/en-us/powershell/module/az.storage/get-azstoragefilecontent?view=azps-5.9.0
    Remove-AzStorageFileContent:https://docs.microsoft.com/en-us/powershell/module/az.storage/remove-azstoragefilecontent?view=azps-5.9.0
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
        SetAzStorageBlobContent:    https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Storage/Storage%20Account/Blob/SetAzStorageBlobContent.ps1
        ListAzStorageBlobs:         https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Storage/Storage%20Account/Blob/ListAzStorageBlobs.ps1
        GetAzStorageBlobContent:    https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Storage/Storage%20Account/Blob/GetAzStorageBlobContent.ps1
        RemoveAzStorageBlob:        https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Storage/Storage%20Account/Blob/RemoveAzStorageBlob.ps1
        GetAzStorageBlob:           https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Storage/Storage%20Account/Blob/GetAzStorageBlob.ps1
        GetAzStorageAccount:        https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Storage/Storage%20Account/GetAzStorageAccount.ps1
        GetAzStorageContainer:      https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Storage/Storage%20Account/Containers/GetAzStorageContainer.ps1
        GetAzResourceGroup:         https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/GetAzResourceGroup.ps1
    ManageAzStorageShares:      https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Storage/Storage%20Account/Shares/ManageAzStorageShare.ps1
        NewAzStorageShare:          https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Storage/Storage%20Account/Shares/NewAzStorageShare.ps1
        GetAzStorageShare:          https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Storage/Storage%20Account/Shares/GetAzStorageShare.ps1
        ListAzStorageShare:         https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Storage/Storage%20Account/Shares/ListAzStorageShare.ps1
        RemoveAzStorageShare:       https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Storage/Storage%20Account/Shares/RemoveAzStorageShare.ps1
        ManageAzStorageDirectory:   https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Storage/Storage%20Account/Shares/ManageAzStorageDirectory.ps1
            NewAzStorageDirectory:      https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Storage/Storage%20Account/Shares/NewAzStorageDirectory.ps1
            RemoveAzStorageDirectory:   https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Storage/Storage%20Account/Shares/RemoveAzStorageDirectory.ps1
            NavAzStorageShare:          https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Storage/Storage%20Account/Shares/NavAzStorageShare.ps1
            GetAzStorageShare:          https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Storage/Storage%20Account/Shares/GetAzStorageShare.ps1
            GetAzStorageAccount:        https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Storage/Storage%20Account/GetAzStorageAccount.ps1
            GetAzResourceGroup:         https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/GetAzResourceGroup.ps1
        ManageAzStorageFile:        https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Storage/Storage%20Account/Shares/ManageAzStorageFile.ps1    
            GetAzStorageFileContent:    https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Storage/Storage%20Account/Shares/GetAzStorageFileContent.ps1
            RemoveAzStorageFile:        https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Storage/Storage%20Account/Shares/RemoveAzStorageFile.ps1
            NavAzStorageShare:          https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Storage/Storage%20Account/Shares/NavAzStorageShare.ps1
            GetAzStorageShare:          https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Storage/Storage%20Account/Shares/GetAzStorageShare.ps1
            GetAzStorageAccount:        https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Storage/Storage%20Account/GetAzStorageAccount.ps1
            GetAzResourceGroup:         https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/GetAzResourceGroup.ps1
        GetAzStorageAccObject:      https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Storage/Storage%20Account/GetAzStorageAccount.ps1
        GetAzResourceGroup:         https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/GetAzResourceGroup.ps1
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
        ManageAzStorageBlob:        Manages storage blob functions
            SetAzStorageBlobContent:    Uploads new blobs
            ListAzStorageBlobs:         Lists blob information
            GetAzStorageBlobContent:    Downloads existing blob
            RemoveAzStorageBlob:        Removes blobs from Azure
            GetAzStorageBlob:           Gets storage blob
            GetAzStorageAccount:        Collects the storage account object
            GetAzStorageContainer:      Collects storage container in a storage account  
            GetAzResourceGroup:         Collects resource group object
        ManageAzStorageShare:       Manages all functions for storage shares
            NewAzStorageShare:          Creates a new storage share
            GetAzStorageShare:          Gets a storage share
            ListAzStorageShare:         Lists all storage shares in a subscription
            RemoveAzStorageShare:       Removes a storage share
                ManageAzStorageDirectory:   Management function for storage share folders
                    NewAzStorageDirectory:      Creates a storage share folder
                    RemoveAzStorageDirectory:   Removes a storage share folder
                    NavAzStorageShare:          Gets a storage share folder path
                    GetAzStorageShare:          Gets a storage share object
                    GetAzStorageAccount:        Gets the storage account object
                    GetAzResourceGroup:         Gets resource group object
                    GetAzStorageAccount:        Collects the storage account object
                ManageAzStorageFile:        Management function for storage share files
                    GetAzStorageFileContent:    Downloads a storage share file
                    RemoveAzStorageFile:        Removes a storage share file
                    NavAzStorageShare:          Gets a storage share file path
                    GetAzStorageShare:          Gets a storage share object
                    GetAzStorageAccount:        Gets the storage account object
                    GetAzResourceGroup:         Gets resource group object    
            GetAzResourceGroup:         Collects resource group object
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
    ManageAzStorageAccount{}    Manages $StorageAccObject
        NewAzStorageAccount{}       Creates $StorageAccObject
            GetAzResourceGroup{}        Gets $RGObject
        GetAzStorageAccount{}       Gets $StorageAccObject
            GetAzResourceGroup{}        Gets $RGObject
        RemoveAzStorageAccount{}    Removes $StorageAccObject
            GetAzResourceGroup{}        Gets $RGObject
            GetAzResourceLocksAll{}     Gets $Locks
            RemoveAzResourceLocks{}     Removes $Locks
    ManageAzStorageContainer{}  Manages $StorageConObject
        NewAzStorageContainer{}     Creates $StorageConObject
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
    ManageAzStorageBlob{}       Manages $StorageBlobObject
        SetAzStorageBlobContent{}   Creates $StorageBlobObject
            GetAzStorageContainer{}     Gets $StorageConObject
                GetAzStorageAccount{}       Gets $StorageAccObject
                    GetAzResourceGroup{}        Gets $RGObject
        ListAzStorageBlob{}         Lists $StorageBlobObject
            GetAzStorageContainer{}     Gets $StorageConObject
                GetAzStorageAccount{}       Gets $StorageAccObject
                    GetAzResourceGroup{}        Gets $RGObject
        GetAzStorageBlobContent{}   Downloads $StorageBlobObject
            GetAzStorageBlob{}          Gets $StorageBlobObject
                GetAzStorageContainer{}     Gets $StorageConObject
                    GetAzStorageAccount{}       Gets $StorageAccObject
                        GetAzResourceGroup{}        Gets $RGObject
        RemoveAzStorageBlob{}       Removes $StorageBlobObject
            GetAzStorageBlob{}          Gets $StorageBlobObject
                GetAzStorageContainer{}     Gets $StorageConObject
                    GetAzStorageAccount{}       Gets $StorageAccObject
                        GetAzResourceGroup{}        Gets $RGObject
    ManageAzStorageShare{}      Manages $StorageShareObject
        NewAzStorageShare{}         Creates $StorageShareObject
            GetAzStorageAccount{}       Gets $StorageAccObject
                GetAzResourceGroup{}        Gets $RGObject
        GetAzStorageShare{}         Gets $StorageShareObject               
            GetAzStorageAccount{}       Gets $StorageAccObject
                GetAzResourceGroup{}        Gets $RGObject
        ListAzStorageShare{}        Gets all storage shares
        RemoveAzStorageShare{}      Removes $StorageShareObject
            GetAzStorageShare{}         Gets $StorageShareObject
                GetAzStorageAccount{}       Gets $StorageAccObject
                    GetAzResourceGroup{}        Gets $RGObject
        ManageAzStorageDirectory{}  Manages $StorageShareFolderObject
            NewAzStorageDirectory{}     Creates $StorageShareFolderObject
                GetAzStorageShare{}         Gets $StorageShareObject 
                    GetAzStorageAccount{}       Gets $StorageAccObject
                        GetAzResourceGroup{}        Gets $RGObject
                NavAzStorageShare{}         Gets $StorageShareFolderObject
                    GetAzStorageShare{}         Gets $StorageShareObject 
                        GetAzStorageAccount{}       Gets $StorageAccObject
                            GetAzResourceGroup{}        Gets $RGObject
            RemoveAzStorageDirectory{}  Removes $StorageShareFolderObject
                NavAzStorageShare{}         Gets $StorageShareFolderObject
                    GetAzStorageShare{}         Gets $StorageShareObject 
                        GetAzStorageAccount{}       Gets $StorageAccObject
                            GetAzResourceGroup{}        Gets $RGObject
        ManageAzStorageFileContent{}Manages $StorageShareFileObject 
            GetAzStorageFileContent{}   Downloads $StorageShareFileObject
                NavAzStorageShare{}         Gets $StorageShareFileObject
                    GetAzStorageShare{}         Gets $StorageShareObject 
                        GetAzStorageAccount{}       Gets $StorageAccObject
                            GetAzResourceGroup{}        Gets $RGObject
            RemoveAzStorageFile{}       Removes $StorageShareFileObject  
                NavAzStorageShare{}         Gets $StorageShareFileObject
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
                Call SetAzStorageBlobContent > Get $null
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
                    Return ManageAzStorageBlob > Send $null
                Call ListAzStorageBlob > Get $null
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
                    Return ManageAzStorageBlob > Send $null
                Call GetAzStorageBlobContent > Get $null
                    Call GetAzStorageBlob > Get $StorageBlobObject
                        Call GetAzStorageContainer > Get $StorageConObject
                            Call GetAzStorageAccount > Get $StorageAccObject
                                Call GetAzResourceGroup > Get $RGObject
                                End GetAzResourceGroup
                                    Return GetAzStorageAccount > Send $RGObject
                            End GetAzStorageAccount 
                                Return GetAzStorageContainer > Send $StorageAccObject
                        End GetAzStorageContainer 
                            Return SetAzStorageBlob > Send $StorageConObject, $StorageAccObject
                    End GetAzStorageBlob
                        Return GetAzStorageBlobContent > Send StorageBlobObject, $StorageConObject, $StorageAccObject
                End GetAzStorageBlobContent
                    Return ManageAzStorageBlob > Send $null
                Call RemoveAzStorageBlob > Get $null
                    Call GetAzStorageBlob > Get $StorageBlobObject
                        Call GetAzStorageContainer > Get $StorageConObject
                            Call GetAzStorageAccount > Get $StorageAccObject
                                Call GetAzResourceGroup > Get $RGObject
                                End GetAzResourceGroup
                                    Return GetAzStorageAccount > Send $RGObject
                            End GetAzStorageAccount 
                                Return GetAzStorageContainer > Send $StorageAccObject
                        End GetAzStorageContainer 
                            Return GetAzStorageBlob > Send $StorageConObject, $StorageAccObject
                    End GetAzStorageBlob
                        Return RemoveAzStorageBlob > Send StorageBlobObject, $StorageConObject, $StorageAccObject
                End RemoveAzStorageBlob
                    Return ManageAzStorageBlob > Send $null
            End ManageAzStorageBlob                                  
                Return ManageAzStorage > Send $null    
            Call ManageAzStorageShare > Get $null
                Call NewAzStorageShare > Get $StorageShareObject
                    Call GetAzStorageAccount > Get $StorageAccObject
                        Call GetAzResourceGroup > Get $RGObject
                        End GetAzResourceGroup
                            Return GetAzStorageAccount > Send $RGObject
                    End GetAzStorageAccount
                        Return NewAzStorageShare > Send $StorageAccObject
                End NewAzStorageShare      
                    Return ManageAzStorageShare > Send $StorageShareObject
                Call GetAzStorageShare > Get $StorageShareObject
                    Call GetAzStorageAccount > Get $StorageAccObject
                        Call GetAzResourceGroup > Get $RGObject
                        End GetAzResourceGroup
                            Return GetAzStorageAccount > Send $RGObject
                    End GetAzStorageAccount
                        Return NewAzStorageShare > Send $StorageAccObject
                End GetAzStorageShare      
                    Return ManageAzStorageShare > Send $StorageShareObject
                Call ListAzStorageShare > Get $null
                End ListAzStorageShare 
                    Return ManageAzStorageShare > Send $null
                Call RemoveAzStorageShare > Get $null
                    Call GetAzStorageShare > Get $StorageShareObject
                        Call GetAzStorageAccount > Get $StorageAccObject
                            Call GetAzResourceGroup > Get $RGObject
                            End GetAzResourceGroup
                                Return GetAzStorageAccount > Send $RGObject
                        End GetAzStorageAccount
                            Return NewAzStorageShare > Send $StorageAccObject
                    End GetAzStorageShare
                End RemoveAzStorageShare      
                    Return ManageAzStorageShare > Send $null            
                Call ManageAzStorageDirectory > Get $null
                    Call NewAzStorageDirectory > Get $null
                        Call GetAzStorageShare > Get $$StorageShare
                            Call GetAzStorageAccount > Get $StorageAccObject
                                Call GetAzResourceGroup > Get $RGObject
                                End GetAzResourceGroup
                                    Return GetAzStorageAccount > Send $RGObject
                            End GetAzStorageAccount 
                                Return GetAzStorageShare > Send $StorageAccObject
                        End GetAzStorageShare 
                            Return NewAzStorageDirectory > Send $StorageShare, $StorageAccObject
                        Call NavAzStorageShare > Get $StorageShareFolderObject
                            Call GetAzStorageShare > Get $$StorageShare
                                Call GetAzStorageAccount > Get $StorageAccObject
                                    Call GetAzResourceGroup > Get $RGObject
                                    End GetAzResourceGroup
                                        Return GetAzStorageAccount > Send $RGObject
                                End GetAzStorageAccount 
                                    Return GetAzStorageShare > Send $StorageAccObject
                            End GetAzStorageShare 
                                Return NavAzStorageShare > Send $StorageShare, $StorageAccObject
                        End NavAzStorageShare
                            Return RemoveAzStorageDirectory > Send StorageShareFolderObject, $StorageShareObject, $StorageAccObject
                    End NewAzStorageDirectory
                        Return ManageAzStorageDirectory > Send $null 
                    Call RemoveAzStorageDirectory > Get $null
                        Call NavAzStorageShare > Get $StorageShareFolderObject
                            Call GetAzStorageShare > Get $$StorageShare
                                Call GetAzStorageAccount > Get $StorageAccObject
                                    Call GetAzResourceGroup > Get $RGObject
                                    End GetAzResourceGroup
                                        Return GetAzStorageAccount > Send $RGObject
                                End GetAzStorageAccount 
                                    Return GetAzStorageShare > Send $StorageAccObject
                            End GetAzStorageShare 
                                Return NavAzStorageShare > Send $StorageShare, $StorageAccObject
                        End NavAzStorageShare
                            Return RemoveAzStorageDirectory > Send StorageShareFolderObject, $StorageShareObject, $StorageAccObject
                    End RemoveAzStorageDirectory
                        Return ManageAzStorageDirectory > Send $null
                End ManageAzStorageDirectory
                    Return ManageAzStorageShare > Send $null 
                Call ManageAzStorageFile > Get $null
                    Call GetAzStorageFileContent > Get $null
                        Call NavAzStorageShare > Get $StorageShareFileObject
                            Call GetAzStorageShare > Get $$StorageShare
                                Call GetAzStorageAccount > Get $StorageAccObject
                                    Call GetAzResourceGroup > Get $RGObject
                                    End GetAzResourceGroup
                                        Return GetAzStorageAccount > Send $RGObject
                                End GetAzStorageAccount 
                                    Return GetAzStorageShare > Send $StorageAccObject
                            End GetAzStorageShare 
                                Return NavAzStorageShare > Send $StorageShare, $StorageAccObject
                        End NavAzStorageShare
                            Return GetAzStorageFileContent > Send StorageShareFileObject, $StorageShareObject, $StorageAccObject
                    End GetAzStorageFileContent
                        Return ManageAzStorageFile > Send $null 
                    Call RemoveAzStorageFile > Get $null
                        Call NavAzStorageShare > Get $StorageShareFileObject
                            Call GetAzStorageShare > Get $$StorageShare
                                Call GetAzStorageAccount > Get $StorageAccObject
                                    Call GetAzResourceGroup > Get $RGObject
                                    End GetAzResourceGroup
                                        Return GetAzStorageAccount > Send $RGObject
                                End GetAzStorageAccount 
                                    Return GetAzStorageShare > Send $StorageAccObject
                            End GetAzStorageShare 
                                Return NavAzStorageShare > Send $StorageShare, $StorageAccObject
                        End NavAzStorageShare
                            Return RemoveAzStorageFile > Send StorageShareFileObject, $StorageShareObject, $StorageAccObject
                    End RemoveAzStorageFile
                        Return ManageAzStorageFile > Send $null 
                End ManageAzStorageFile
                    Return ManageAzStorageShare > Send $null
            End ManageAzStorageShare
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
function GetAzStorageBlobContent {                                                          # Function to download an existing blob
    Begin {                                                                                 # Begin function
        $CallingFunction = 'GetAzStorageBlobContent'                                        # Creates $CallingFunction
        $ErrorActionPreference = 'silentlyContinue'                                         # Disables error messages
        :GetAzureBlobContent while ($true) {                                                # Outer loop for managing function
            $StorageBlobObject, $StorageConObject, $StorageAccObject = GetAzStorageBlob `
                ($CallingFunction)                                                          # Calls function and assigns output to $vars
            if (!$StorageBlobObject) {                                                      # If $StorageBlobObject is $null
                Break GetAzureBlobContent                                                   # Breaks :GetAzureBlobContent
            }                                                                               # End if (!$StorageBlobObject)
            :SetLocalFilePath while ($true) {                                               # Inner loop for setting the local download path
                Write-Host '[0] Exit'                                                       # Write message to screen
                Write-Host '[1] Downloads folder'                                           # Write message to screen
                Write-Host '[2] Custom path'                                                # Write message to screen
                $OpSelect = Read-Host 'Option [#]'                                          # Operator input for download path selection
                if ($OpSelect -eq '0') {                                                    # If $OpSelect equals '0'
                    Break GetAzureBlobContent                                               # Breaks :GetAzureBlobContent
                }                                                                           # End if ($OpSelect -eq '0')
                elseif ($OpSelect -eq '1') {                                                # Else if $OpSelect equals '1'
                    $UserName = $env:USERNAME                                               # Gets session username
                    if ($UserName -like '*\*') {                                            # If $Username has a '\'
                        $UserName = $UserName.Split('\')[1]                                 # Removes \ and text before it
                    }                                                                       # End if ($UserName -like '*\*')
                    $LocalFileDownloadPath = 'c:\users\'+$UserName+'\downloads\'            # Creates $Localdownloadpath
                    Clear-Host                                                              # Clears screen
                    Break SetLocalFilePath                                                  # Breaks :SetLocalFilePath  
                }                                                                           # End elseif ($OpSelect -eq '1')
                elseif ($OpSelect -eq '2') {                                                # Else if $OpSelect equals '2'
                    :VerifyPath while ($true) {                                             # Inner loop for verifying local download path
                        $LocalFileDownloadPath = Read-Host `
                            'Enter the folder path to download blob to'                     # Operator input for local download path
                        if ($LocalFileDownloadPath -eq 'exit') {                            # If $LocalFileDownloadPath equals 'exit'
                            Break GetAzureBlobContent                                       # Breaks :GetAzureBlobContent
                        }                                                                   # End if ($LocalFileDownloadPath -eq 'exit')
                        if (Test-Path $LocalFileDownloadPath) {                             # If $LocalFileDownloadPath is valid
                            Clear-Host                                                      # Clears screen
                            Break SetLocalFilePath                                          # Breaks :SetLocalFilePath
                        }                                                                   # End if (Test-Path $LocalFileDownloadPath)
                        else {                                                              # If Test-Path is false
                            Write-Host ''                                                   # Write message to screen
                            Write-Host 'The listed path was not valid'                      # Write message to screen
                            Write-Host 'Please double check the folder path'                # Write message to screen
                            Write-Host ''                                                   # Write message to screen
                            Write-Host 'Enter "exit" to leave this function'                # Write message to screen
                            Pause                                                           # Pauses for operator input
                            Clear-Host                                                      # Clears screen
                        }                                                                   # End else (if (Test-Path $LocalFileDownloadPath))
                    }                                                                       # End :VerifyPath while ($true)
                }                                                                           # End elseif ($OpSelect -eq '2')
                else {                                                                      # All other inputs for $OpSelect
                    Write-Host 'That was not a valid option'                                # Write message to screen
                }                                                                           # End else (if ($OpSelect -eq '0'))
            }                                                                               # End :SetLocalFilePath while ($true)
            Try {                                                                           # Try the following
                Get-AzStorageBlobContent -Context $StorageAccObject.context -Container `
                    $StorageConObject.Name -Blob $StorageBlobObject.Name `
                    -Destination $LocalFileDownloadPath -ErrorAction 'Stop'                 # Downloads the selected blob
            }                                                                               # End Try
            catch {                                                                         # If try failes
                Write-Host ''                                                               # Write message to screen
                Write-Host 'An error has occured'                                           # Write message to screen
                Write-Host 'You may not have the permissions'                               # Write message to screen
                Pause                                                                       # Pauses all action for operator input
                Break GetAzureBlobContent                                                   # Breaks GetAzureBlobContent
            }                                                                               # End catch
            Write-Host ''                                                                   # Write message to screen
            Write-Host 'The blob has been downloaded to'$LocalFileDownloadPath              # Write message to screen
            Start-Sleep(5)                                                                  # Pauses all action for 5 seconds
            Break GetAzureBlobContent                                                       # Breaks GetAzureBlobContent
        }                                                                                   # End :GetAzureBlobContent while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function GetAzStorageBlobContent
function RemoveAzStorageBlob {                                                              # Function to remove a storage blob    
    Begin {                                                                                 # Begin function
        $CallingFunction = 'RemoveAzStorageBlob'                                            # Creates $CallingFunction
        $ErrorActionPreference = 'silentlyContinue'                                         # Disables error messages
        :RemoveAzureBlob while ($true) {                                                    # Outer loop for managing function
            $StorageBlobObject, $StorageConObject, $StorageAccObject = GetAzStorageBlob `
                ($CallingFunction)                                                          # Calls function and assigns output to $var
            if (!$StorageBlobObject) {                                                      # If $var is $null
                Break RemoveAzureBlob                                                       # Breaks :RemoveAzureBlob  
            }                                                                               # End if (!$StorageConObject)
            Write-Host 'Remove the following blob'                                          # Write message to screen
            Write-Host 'Blob:     '$StorageBlobObject.Name                                  # Write message to screen
            Write-Host 'Container:'$StorageConObject.name                                   # Write message to screen
            Write-Host 'Account:  '$StorageAccObject.StorageAccountName                     # Write message to screen
            $OpConfirm = Read-Host '[Y] Yes [N] No'                                         # Operator confirmation to remove the blob
            Clear-Host                                                                      # Clears screen
            if ($OpConfirm -eq 'y') {                                                       # If $OpConfirm equals 'y'
                Try {                                                                       # Try the following
                    Remove-AzStorageBlob -Blob $StorageBlobObject.Name -Container `
                        $StorageConObject.Name -Context $StorageAccObject.Context `
                        -ErrorAction 'Stop'                                                 # Removes the selected blob
                }                                                                           # End Try
                Catch {                                                                     # If try fails
                    Write-Host 'An error has occured'                                       # Write message to screen
                    Write-Host 'Please check your permissions'                              # Write message to screen
                    Pause                                                                   # Pauses for operator input
                    Break RemoveAzureBlob                                                   # Breaks :RemoveAzureBlob
                }                                                                           # End catch
                Write-Host 'The selected blob has been removed'                             # Write message to screen
                Pause                                                                       # Pauses for operator input
                Break RemoveAzureBlob                                                       # Breaks :RemoveAzureBlob
            }                                                                               # End if ($OpConfirm -eq 'y')
            else {                                                                          # All other inputs for $OpConfirm
                Write-Host 'No action taken'                                                # Write message to screen
                Start-Sleep(3)                                                              # Pauses all action for 3 seconds
                Break RemoveAzureBlob                                                       # Breaks :RemoveAzureBlob
            }                                                                               # End else (if ($OpConfirm -eq 'y'))
        }                                                                                   # End RemoveAzureBlob while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function RemoveAzStorageBlob
# Additional functions for ManageAzStorageBlob
function GetAzStorageBlob {                                                                 # Function to get a blob in storage container
    Begin {                                                                                 # Begin function
        if (!$CallingFunction) {                                                            # If $CallingFunction is $null
            $CallingFunction = 'GetAzStorageBlob'                                           # Creates $CallingFunction
        }                                                                                   # End if (!$CallingFunction)
        $ErrorActionPreference = 'silentlyContinue'                                         # Disables error messages
        :GetAzureBlobs while ($true) {                                                      # Outer loop for managing function
            $StorageConObject, $StorageAccObject = GetAzStorageContainer ($CallingFunction) # Calls function and assigns output to $var
            if (!$StorageConObject) {                                                       # If $StorageConObject is $null
                Break GetAzureBlobs                                                         # Breaks :GetAzureBlobs
            }                                                                               # End if (!$StorageConObject)
            $ObjectList = Get-AzStorageBlob -Context $StorageAccObject.context -Container `
                $StorageConObject.Name                                                      # Object containing the blob info objects
            if (!$ObjectList) {                                                             # If $ObjectList is $null
                Write-Host 'No blobs exist in this container'                               # Write message to screen
                Pause                                                                       # Pauses for operator input
                Break GetAzureBlobs                                                         # Breaks :GetAzureBlobs
            }                                                                               # End if (!$ObjectList)
            [System.Collections.ArrayList]$ObjectArray = @()                                # Creates the RG list array
            $ObjectNumber = 1                                                               # Creates $ObjectNumber
            foreach ($_ in $ObjectList) {                                                   # For each $_ in $ObjectListList
                $ObjectInput = [PSCustomObject]@{'Number'=$ObjectNumber;'Name' = $_.Name;`
                    'Type'=$_.BlobType;'LM'=$_.LastModified;'AT'=$_.AccessTier;`
                    'Del'=$_.IsDeleted;'VID'=$_.VersionID}                                  # Creates the item to loaded into array
                $ObjectArray.Add($ObjectInput) | Out-Null                                   # Loads item into array, out-null removes write to screen
                $ObjectNumber = $ObjectNumber + 1                                           # Increments $ObjectNumber up by 1
            }                                                                               # End foreach ($_ in $ObjectList)
            Write-Host '[0] Exit'                                                           # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            foreach ($_ in $ObjectArray) {                                                  # For each item in $ObjectArray
                $Number = $_.Number                                                         # Creates $Number from current item .number
                if ($Number -le 9) {                                                        # If $Number is less than 10
                    Write-Host "[$number]:        "$_.Name                                  # Write message to screen
                }                                                                           # End if ($Number -le 9)
                else {                                                                      # If $number is greater than 9
                    Write-Host "[$number]:       "$_.Name                                   # Write message to screen
                }                                                                           # End else (if ($Number -le 9))
                Write-Host 'Type:       '$_.Type                                            # Write message to screen
                Write-Host 'Last Mod:   '$_.LM                                              # Write message to screen
                Write-Host 'Access Tier:'$_.AT                                              # Write message to screen
                Write-Host 'Deleted:    '$_.Del                                             # Write message to screen
                Write-Host 'VersionID:  '$_.VID                                             # Write message to screen
                Write-Host ''                                                               # Write message to screen
            }                                                                               # End foreach ($_ in $ObjectArray)
            :SelectAzureBlobs while ($true) {                                               # Inner loop for selecting the blob
                if ($CallingFunction -ne 'GetAzStorageBlob') {                              # If $CallingFunction is not equal 'GetAzStorageBlob'
                    Write-Host 'You are selecting the blob for:'$CallingFunction            # Write message to screen
                }                                                                           # End if ($CallingFunction -ne 'GetAzStorageBlob')
                $OpSelect = Read-Host 'Enter the blob [#]'                                  # Operator input to select the blob
                if ($OpSelect -eq '0') {                                                    # If $OpSelect equals '0'
                    Break GetAzureBlobs                                                     # Breaks :GetAzureBlobs
                }                                                                           # End if ($OpSelect -eq '0')
                elseif ($OpSelect -in $ObjectArray.number) {                                # If $OpSelect is in $ObjectArray.Number
                    $StorageBlobObject = $ObjectArray | Where-Object `
                        {$_.Number -eq $OpSelect}                                           # $StorageBlobObject is equal to $ObjectArray where $ObjectArray.Number eqauls $OpSelect
                    if ($CallingFunction -ne 'GetAzStorageBlob') {                          # If $CallingFunction is not equal 'GetAzStorageBlob'
                        $StorageBlobObject = Get-AzStorageBlob -Blob `
                            $StorageBlobObject.Name -Container $StorageConObject.Name `
                            -Context $StorageAccObject.Context                              # Collects the full blob object
                        Clear-Host                                                          # Clears screen
                        Return $StorageBlobObject, $StorageConObject, $StorageAccObject     # Returns to calling function with $vars
                    }                                                                       # End if ($CallingFunction -ne 'GetAzStorageBlob')
                    else {                                                                  # If $CallingFunction is equal to 'GetAzStorageBlob'
                        Break GetAzureBlobs                                                 # Breaks :GetAzureBlobs
                    }                                                                       # End else (if ($CallingFunction -ne 'GetAzStorageBlob'))
                }                                                                           # End elseif ($OpSelect -in $ObjectArray.number)
                else {                                                                      # All other inputs for $OpSelect
                    Write-Host 'That was not a valid option'                                # Write message to screen
                }                                                                           # End else (if ($OpSelect -eq '0'))
            }                                                                               # End :SelectAzureBlobs while ($true)
        }                                                                                   # End :GetAzureBlobs while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function GetAzStorageBlob
# End ManageAzStorageBlob
# Functions for ManageAzStorageShare
function ManageAzStorageShare {                                                             # Function to manage azure storage shares
    Begin {                                                                                 # Begin function
        :ManageAzureStorageShares while ($true) {                                           # Outer loop for managing function
            Write-Host 'Azure Storage Share Management'                                     # Write message to screen
            Write-Host '[1] New Storage Share'                                              # Write message to screen
            Write-Host '[2] List Storage Shares'                                            # Write message to screen
            Write-Host '[3] Remove Storage Share'                                           # Write message to screen
            Write-Host '[4] Manage Storage Share Folders'                                   # Write message to screen
            Write-Host '[5] Manage Storage Share Files'                                     # Write message to screen
            Write-Host '[Exit] to return'                                                   # Write message to screen
            $OpSelect = Read-Host "Option?"                                                 # Operator input for selecting the management function
            if ($OpSelect -eq 'exit') {                                                     # If $OpSelect equals '0'
                Break ManageAzureStorageShares                                              # Breaks :ManageAzureStorageShares
            }                                                                               # End if ($OpSelect -eq 'exit')
            elseif ($OpSelect -eq '1') {                                                    # Else if $OpSelect equals '1'
                Write-Host 'New Storage Share'                                              # Write message to screen
                NewAzStorageShare                                                           # Calls function
            }                                                                               # End elseif ($OpSelect -eq '1')
            elseif ($OpSelect -eq '2') {                                                    # Else if $OpSelect equals '2'
                Write-Host 'List Storage Shares'                                            # Write message to screen
                ListAzStorageShares                                                         # Calls function
            }                                                                               # End elseif ($OpSelect -eq '2')
            elseif ($OpSelect -eq '3') {                                                    # Else if $OpSelect equals '3'
                Write-Host 'Remove Storage Share'                                           # Write message to screen
                RemoveAzStorageShare                                                        # Calls function
            }                                                                               # End elseif ($OpSelect -eq '3')
            elseif ($OpSelect -eq '4') {                                                    # Else if $OpSelect equals '4'
                Write-Host 'Manage Storage Share Folders'                                   # Write message to screen
                ManageAzStorageDirectory                                                    # Calls function
            }                                                                               # End elseif ($OpSelect -eq '4')
            elseif ($OpSelect -eq '4') {                                                    # Else if $OpSelect equals '5'
                Write-Host 'Manage Storage Share Files'                                     # Write message to screen
                ManageAzStorageFile                                                         # Calls function
            }                                                                               # End elseif ($OpSelect -eq '5')
            else {                                                                          # All other inputs for $OpSelect
                Write-Host 'That was not a valid option'                                    # Write message to screen
            }                                                                               # End else (if ($OpSelect -eq 'exit'))
        }                                                                                   # End :ManageAzureStorageShares while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End begin
}                                                                                           # End function ManageAzStorageShare
function NewAzStorageShare {                                                                # Function to create a new storage share
    Begin {                                                                                 # Begin function
        if (!$CallingFunction) {                                                            # If $CallingFunction is $null
            $CallingFunction = 'NewAzStorageShare'                                          # Creates $CallingFunction
        }                                                                                   # End if (!$CallingFunction)
        :NewAzureStorageShare while ($true) {                                               # Outer loop for managing function
            $StorageAccObject = GetAzStorageAccount ($CallingFunction)                      # Calls function and assigns output to $var
            if (!$StorageAccObject) {                                                       # If $StorageAccObject is $null
                Break NewAzureStorageShare                                                  # Breaks :NewAzureStorageShare
            }                                                                               # End if (!$StorageAccObject)
            :SetAzureShareName while ($true) {                                              # Inner loop for setting the name of the new share
                $ValidArray = 'abcdefghijklmnopqrstuvwxyz0123456789'                        # Creates a string of valid characters
                $ValidArray = $ValidArray.ToCharArray()                                     # Loads all valid characters into array
                Write-Host 'Storage share name must be atleast 3 characters'                # Write message to screen
                Write-Host 'and made up of letters and numbers only'                        # Write message to screen
                $ShareNameArray = $null                                                     # Clears $ShareNameArray
                $ShareNameInput = Read-Host 'Share name'                                    # Operator input for the share name
                $ShareNameInput = $ShareNameInput.ToLower()                                 # Recreates $ShareNameInput in lower
                $ShareNameArray = $ShareNameInput.ToCharArray()                             # Creates $ShareNameInput
                foreach ($_ in $ShareNameArray) {                                           # For each item in $ShareNameArray
                    if ($_ -notin $ValidArray) {                                            # If current item is not in $ValidArray
                        if ($_ -eq ' ') {                                                   # If current item equals 'space'
                            Write-Host ''                                                   # Write message to screen    
                            Write-Host 'Share name cannot include any spaces'               # Write message to screen
                        }                                                                   # End if ($_ -eq ' ')
                        else {                                                              # If current item is not equal to 'space'
                            Write-Host ''                                                   # Write message to screen    
                            Write-Host $_' is not a valid character'                        # Write message to screen
                        }                                                                   # End else (if ($_ -eq ' '))
                        $ShareNameInput = $null                                             # Clears $ShareNameInput
                    }                                                                       # End if ($_ -notin $ValidArray)
                }                                                                           # End foreach ($_ in $ShareNameArray)
                if (!$ShareNameInput) {                                                     # If $ShareNameInput is $null
                    Pause                                                                   # Pauses for operator input
                    Clear-Host                                                              # Clears screen
                }                                                                           # End if ($ShareNameInput -eq '0')
                else {                                                                      # If $ShareNameInput not equal to '0'
                    Write-Host $ShareNameInput 'is correct'                                 # Write message to screen
                    $OpConfirm = Read-Host '[Y] Yes [N] No [E] Exit'                        # Operator confirmation of share name input
                    if ($OpConfirm -eq 'e') {                                               # If $OpConfirm equals 'e'
                        Break NewAzureStorageShare                                          # Breaks NewAzureStorageShare
                    }                                                                       # End if ($OpConfirm -eq 'e')
                    if ($OpConfirm -eq 'y') {                                               # If $OpConfirm is equal to 'y'
                        Clear-Host                                                          # Clears screen
                        Break SetAzureShareName                                             # Breaks :SetAzureShareName
                    }                                                                       # End if ($OpConfirm -eq 'y')
                }                                                                           # End else (if (!$ShareNameInput))
            }                                                                               # End :SetAzureShareName while ($true)
            Try {                                                                           # Try the following
                New-AzStorageShare -Name $ShareNameInput -Context `
                    $StorageAccObject.Context -ErrorAction 'Stop'                           # Creates the storage share
            }                                                                               # End try
            catch {                                                                         # If try fails
                Write-Host 'An error has occured'                                           # Write message to screen
                Write-Host 'Check you permissions'                                          # Write message to screen
                Pause                                                                       # Pauses for operator input
                Break NewAzureStorageShare                                                  # Breaks NewAzureStorageShare
            }                                                                               # End catch
            Write-Host 'The share has been created'                                         # Write message to screen
            Pause                                                                           # Pauses for operator input
            Break NewAzureStorageShare                                                      # Breaks NewAzureStorageShare
        }                                                                                   # End :NewAzureStorageShare while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function NewAzStorageShare
Function ListAzStorageShare {                                                               # Function to list storage shares
    Begin {                                                                                 # Begin function
        :ListAzureStorageShare while ($true) {                                              # Outer loop for managing function
            Write-Host 'Getting shares list, this may take a moment'                        # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            $RGList = Get-AzResourceGroup                                                   # Gets a list of all resource groups
            foreach ($_ in $RGList) {                                                       # For each item in $RGList
                $RGObject = $_.ResourceGroupName                                            # $RGObject is equal to current item .ResourceGroupName
                $StorageAccList = Get-AzStorageAccount -ResourceGroupName $RGObject         # Gets a list of all storage accounts on $RGObject
                if (!$StorageAccList) {                                                     # If $StorageAccList is $null
                    Write-Host 'Resource Group: ' $RGObject                                 # Write message to screen
                    Write-Host 'StorageAccount:  None'                                      # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                }                                                                           # End if ($StorageAccList)
                else {                                                                      # If $StorageAccList has a value
                    foreach ($_ in $StorageAccList) {                                       # For each item in $StorageAccList
                        $StorageAccObject = Get-AzStorageAccount -Name `
                            $_.StorageAccountName -ResourceGroupName $RGObject              # Pulls the full storage account context
                        $StorageShareList = Get-AzStorageShare -Context `
                            $StorageAccObject.Context                                       # Pulls a list for storage shares on $StorageAccObject
                        if (!$StorageShareList) {                                           # If $StorageShareList is $null
                            Write-Host 'Resource Group: ' $RGObject                         # Write message to screen
                            Write-Host 'Storage Account:' `
                                $StorageAccObject.StorageAccountName                        # Write message to screen
                            Write-Host 'Storage Share:   None'                              # Write message to screen
                            Write-Host ''                                                   # Write message to screen
                        }                                                                   # End if (!$StorageShareList)
                        else {                                                              # If $StorageShareList is not $null
                            [System.Collections.ArrayList]$ObjectArray=@()                  # Creates $ObjectArray
                            foreach ($_ in $StorageShareList) {                             # For each item in $ObjectList
                                $ObjectInput = [PSCustomObject]@{'Name'=$_.Name;`
                                    'QU'=$_.Quota;'LM'=$_.LastModified;`
                                    'IsSnap'=$_.IsSnapshot;'SST'=$_.SnapShotTime}           # Creates $ObjectInput
                                $ObjectArray.Add($ObjectInput) | Out-Null                   # Loads content of $ObjectInput into $ObjectArray
                            }                                                               # End foreach ($_ in $OpSelect)
                            foreach ($_ in $ObjectArray) {                                  # For each item in $ObjectArray
                                Write-Host 'Resource Group: ' $RGObject                     # Write message to screen
                                Write-Host 'Storage Account:' `
                                $StorageAccObject.StorageAccountName                        # Write message to screen
                                Write-Host 'Share Name:     '  $_.Name                      # Write message to screen
                                Write-Host 'QuotaGiB:       '$_.QU                          # Write message to screen
                                Write-Host 'Last Mod:       '$_.LM                          # Write message to screen
                                if ($_.IsSnap -eq 'True') {                                 # If current item .IsSnap is equal to true
                                    Write-Host 'SnapshotTime:   '$_.SST                     # Write message to screen
                                }                                                           # End if ($_.IsSnap -eq 'True')
                                Write-Host ''                                               # Write message to screen
                            }                                                               # End foreach ($_ in $ObjectArray)
                        }                                                                   # End else (if (!$StorageShareList))
                    }                                                                       # End foreach ($_ in $StorageAccList)
                }                                                                           # End else (if ($StorageAccList))
            }                                                                               # End foreach ($_ in $RGList)
            Pause                                                                           # Pauses for operator input
            Break ListAzureStorageShare                                                     # Breaks :ListAzureStorageShare
        }                                                                                   # End :ListAzureStorageShare while ($true)
        Clear-Host                                                                          # Clears Screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End Function ListAzStorageShare
Function GetAzStorageShare {                                                                # Function to get a storage share
    Begin {                                                                                 # Begin function
        :GetAzureStorageShare while ($true) {                                               # Outer loop for managing function
            $StorageAccObject = GetAzStorageAccount ($CallingFunction)                      # Calls function and assigns output to $var
            if (!$StorageAccObject) {                                                       # If $StorageAccObject is $null
                Break GetAzureStorageShare                                                  # Breaks :GetAzureStorageShare
            }                                                                               # End if (!$StorageAccObject) 
            $ObjectList = Get-AzStorageShare -Context $StorageAccObject.Context             # Collects all shares in selected storage account
            if (!$ObjectList) {                                                             # If $ObjectList returns empty
                Write-Host 'No storage shares found'                                        # Message write to screen
                Write-Host 'on storage account'$StorageAccObject.StorageAccountName         # Message write to screen
                Pause                                                                       # Pauses all action for operator input
                Break GetAzureStorageShare                                                  # Breaks :GetAzureStorageShare
            }                                                                               # End if (!$ObjectList)
            $ObjectNumber = 1                                                               # Sets $ObjectNumber
            [System.Collections.ArrayList]$ObjectArray=@()                                  # Creates $ObjectArray
            foreach ($_ in $ObjectList) {                                                   # For each item in $ObjectList
                $ObjectInput = [PSCustomObject]@{'Number'=$ObjectNumber;'Name'=$_.Name;`
                    'QU'=$_.Quota;'LM'=$_.LastModified;'IsSnap'=$_.IsSnapshot;`
                    'SST'=$_.SnapShotTime}                                                  # Creates $ObjectInput
                $ObjectArray.Add($ObjectInput) | Out-Null                                   # Loads content of $ObjectInput into $ObjectArray
                $ObjectNumber = $ObjectNumber + 1                                           # Increments $ObjectNumber up by 1
            }                                                                               # End foreach ($_ in $OpSelect)
            Write-Host '[0] Exit'                                                           # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            foreach ($_ in $ObjectArray) {                                                  # For each item in $ObjectArray
                $Number = $_.Number                                                         # $Number is equal to current item .Number
                if ($Number -le 9) {                                                        # If $Number is 9 or less
                    Write-Host "[$Number]:         " $_.Name                                # Write message to screen
                }                                                                           # End if ($Number -le 9)
                else {                                                                      # If $Number is 10 or more
                    Write-Host "[$Number]:        " $_.Name                                 # Write message to screen
                }                                                                           # End else (if ($Number -le 9))
                Write-Host 'QuotaGiB:    '$_.QU                                             # Write message to screen
                Write-Host 'Last Mod:    '$_.LM                                             # Write message to screen
                if ($_.IsSnap -eq 'True') {                                                 # If current item .IsSnap is equal to true
                    Write-Host 'SnapshotTime:'$_.SST                                        # Write message to screen
                }                                                                           # End if ($_.IsSnap -eq 'True')
                Write-Host ''                                                               # Write message to screen
            }                                                                               # End foreach ($_ in $ObjectArray)
            :SelectAzureStorageShare while ($true) {                                        # Inner loop for selecting the storage share
                if ($CallingFunction) {                                                     # If $Calling function has a value
                    Write-Host 'You are selecting the storage share for:'$CallingFunction   # Write message to screen
                }                                                                           # End if ($CallingFunction)
                $OpSelect = Read-Host 'Enter the storage share [#]'                         # Operator input for the storage share selection
                if ($OpSelect -eq '0') {                                                    # If $OpSelect is equal to '0'
                    Break GetAzureStorageShare                                              # Breaks :GetAzureStorageShare
                }                                                                           # End if ($OpSelect -eq '0')
                elseif ($OpSelect -in $ObjectArray.Number) {                                # If $OpSelect in $ObjectArray.Number
                    $OpSelect = $ObjectArray | Where-Object {$_.Number -eq $OpSelect}       # $OpSelect is equal to $ObjectArray where $ObjectArray.Number equals $OpSelect
                    $StorageShareObject = Get-AzStorageShare -Name $OpSelect.Name -Context `
                    $StorageAccObject.Context                                               # Collects the full storage share object
                    if ($StorageShareObject) {                                              # If $StorageShareObject has a value
                        Clear-Host                                                          # Clears screen
                        Return $StorageShareObject, $StorageAccObject                       # Returns to $CallingFunction with $vars
                    }                                                                       # End if ($StorageShareObject)
                    else {                                                                  # If $StorageShareObject does not have a value
                        Write-Host 'An error has occured'                                   # Write message to screen
                        Pause                                                               # Pauses for operator input
                        Break GetAzureStorageShare                                          # End Break GetAzureStorageShare
                    }                                                                       # End else (if ($StorageShareObject))
                }                                                                           # End elseif ($OpSelect -in $ObjectArray.Number)
                else {                                                                      # All other inputs for $OpSelect
                    Write-Host 'That was not a valid option'                                # Write message to screen
                }                                                                           # End if ($OpSelect -eq '0')
            }                                                                               # End :SelectAzureStorageShare while ($true) 
        }                                                                                   # End :GetAzureStorageShare while ($true)
        Clear-Host                                                                          # Clears Screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End Function GetAzStorageShare
function RemoveAzStorageShare {                                                             # Function to remove a storage share
    Begin {                                                                                 # Begin function
        $ErrorActionPreference='silentlyContinue'                                           # Disables error reporting
        if (!$CallingFunction) {                                                            # If $CallingFunction does not have a value
            $CallingFunction = 'RemoveAzStorageShare'                                       # Creates $CallingFunction
        }                                                                                   # End if (!$CallingFunction)
        :RemoveAzureStorageShare while ($true) {                                            # Outer loop for managing function
            $StorageShareObject, $StorageAccObject = GetAzStorageShare ($CallingFunction)   # Calls function and assigns output to $vars
            if (!$StorageShareObject) {                                                     # If $StorageShareObject is $null
                Break RemoveAzureStorageShare                                               # Breaks :RemoveAzureStorageShare
            }                                                                               # End if (!$StorageShareObject)
            Write-Host 'Remove the share:    '$StorageShareObject.Name                      # Write message to screen
            Write-Host 'From storage account:'$StorageAccObject.StorageAccountName          # Write message to screen
            $OpConfirm = Read-Host '[Y] Yes [N] No'                                         # Operator confirmation to remove the share
            if ($OpConfirm -eq 'y') {                                                       # If OpConfirm equals 'y'
                Try {                                                                       # Try the following
                    Remove-AzStorageShare -Name $StorageShareObject.Name -Context `
                        $StorageAccObject.Context -ErrorAction 'Stop'                       # Removes the share
                }                                                                           # End try
                Catch {                                                                     # If try fails
                    Write-Host 'An error has occured'                                       # Write message to screen
                    Write-Host 'Check you permissions'                                      # Write message to screen
                    Write-Host 'A lock or policy may'                                       # Write message to screen
                    Write-Host 'have prevented this action'                                 # Write message to screen
                    Pause                                                                   # Pauses action for operator input
                    Break RemoveAzureStorageShare                                           # Breaks :RemoveAzureStorageShare
                }                                                                           # End catch
                Write-Host 'The selected share has been removed'                            # Write message to screen
                Pause                                                                       # Pauses action for operator input
                Break RemoveAzureStorageShare                                               # Breaks :RemoveAzureStorageShare
            }                                                                               # End if ($OpConfirm -eq 'y')
            else {                                                                          # All other inputs for $OpConfirm
                Break RemoveAzureStorageShare                                               # Breaks :RemoveAzureStorageShare
            }                                                                               # End else (if ($OpConfirm -eq 'y'))
        }                                                                                   # End :RemoveAzureStorageShare while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function RemoveAzStorageShare
function ManageAzStorageDirectory {                                                         # Function to manage folders in storage share
    Begin {                                                                                 # Begin function
        :ManageAzureSFolder while ($true) {                                                 # Outer loop for managing function
            Write-Host '[0] Exit'                                                           # Write message to screen
            Write-Host '[1] Create new folder'                                              # Write message to screen
            Write-Host '[2] Remove folder'                                                  # Write message to screen   
            $OpSelect = Read-Host 'Option [#]'                                              # Operator input for selecting management function
            if ($OpSelect -eq '0') {                                                        # If $OpSelect equals '0'
                Break ManageAzureSFolder                                                    # Breaks :ManageAzureSFolder
            }                                                                               # End if ($OpSelect -eq '0')
            elseif ($OpSelect -eq '1') {                                                    # Else if $OpSelect equals '1'
                Clear-Host                                                                  # Clears screen
                NewAzStorageDirectory                                                       # Calls function
            }                                                                               # End elseif ($OpSelect -eq '1')
            elseif ($OpSelect -eq '1') {                                                    # Else if $OpSelect equals '2'
                Clear-Host                                                                  # Clears screen
                RemoveAzStorageDirectory                                                    # Calls function
            }                                                                               # End elseif ($OpSelect -eq '2')
            else {                                                                          # All other inputs for $OpSelect
                Write-Host 'That was not a valid option'                                    # Write message to screen
            }                                                                               # End else (if ($OpSelect -eq '0'))
        }                                                                                   # End :ManageAzureSFolder while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function ManageAzStorageDirectory
function NewAzStorageDirectory {                                                            # Function for creating a folder in storage share
    Begin {                                                                                 # Begin function
        if (!$CallingFunction) {                                                            # If $CallingFunction does not have a value
            $CallingFunction = 'NewAzStorageDirectory'                                      # Creates $CallingFunction
        }                                                                                   # End if (!$CallingFunction)  
        :NewAzureSFolder while ($true) {                                                    # Outer loop for managing function
            Write-Host '[0] Exit'                                                           # Write message to screen
            Write-Host '[1] New root folder'                                                # Write message to screen
            Write-Host '[2] New sub folder'                                                 # Write message to screen
            Clear-Host                                                                      # Clears screen
            $OpSelect = Read-Host 'Option [#]'                                              # Operator input for selecting the folder type
            if ($OpSelect -eq '0') {                                                        # If $OpSelect equals '0'
                Break NewAzureSFolder                                                       # Breaks :NewAzureSFolder
            }                                                                               # End if ($OpSelect -eq '0')
            elseif ($OpSelect -eq '1') {                                                    # Else if $OpSelect equals '1'
                $StorageShareObject, $StorageAccObject = GetAzStorageShare `
                    ($CallingFunction)                                                      # Calls function and assigns output to $vars
                if (!$StorageShareObject) {                                                 # If $StorageShareObject does not have a value
                    Break NewAzureSFolder                                                   # Breaks :NewAzureSFolder
                }                                                                           # End if (!$StorageShareObject)
                :SetAzureSFolderName while ($true) {                                        # Inner loop for setting the folder name
                    $FolderName = Read-Host 'Enter the new folder name'                     # Operator input of the new folder name
                    Write-Host 'Use the name:'$FolderName                                   # Write message to screen
                    $OpConfirm = Read-Host '[Y] Yes [N] No [E] Exit'                        # Operator confirmation of the new folder name
                    if ($OpConfirm -eq 'e') {                                               # If $OpConfirm equals 'e'
                        Break NewAzureSFolder                                               # Breaks :NewAzureSFolder
                    }                                                                       # End if ($OpConfirm -eq 'e')
                    elseif ($OpConfirm -eq 'y') {                                           # Else if $OpConfirm equals 'y'
                        Break SetAzureSFolderName                                           # Breaks :SetAzureSFolderName
                    }                                                                       # End elseif ($OpConfirm -eq 'y')
                }                                                                           # End :SetAzureSFolderName while ($true)
                Try {                                                                       # Try the following
                    New-AzStorageDirectory -Path $FolderName -ShareName `
                        $StorageShareObject.Name -Context $StorageAccObject.Context `
                        -ErrorAction 'Stop'                                                 # Creates the new folder
                }                                                                           # End Try
                Catch {                                                                     # If Try fails
                    Write-Host 'An error has occured'                                       # Write message to screen
                    Write-Host 'The share maybe locked'                                     # Write message to screen
                    Pause                                                                   # Pauses all action for operator input
                    Break NewAzureSFolder                                                   # Breaks :NewAzureSFolder
                }                                                                           # End catch
                Write-Host 'The folder has been created'                                    # Write message to screen
                Pause                                                                       # Pauses all action for operator input
                Break NewAzureSFolder                                                       # Breaks :NewAzureSFolder
            }                                                                               # End elseif ($OpSelect -eq '1')
            elseif ($OpSelect -eq '2') {                                                    # Else if $OpSelect equals '2'
                $StorageShareFolderObject, $StorageShareObject, $StorageAccObject = `
                    NavAzStorageShare ($CallingFunction)                                    # Calls function and assigns output to $vars
                if (!$StorageShareFolderObject) {                                           # If $StorageShareFolderObject does not have a value
                    Break NewAzureSFolder                                                   # Breaks :NewAzureSFolder
                }                                                                           # End if (!$StorageShareObject)
                :SetAzureSFolderName while ($true) {                                        # Inner loop for setting the new folder name
                    $FolderName = Read-Host 'Enter the new folder name'                     # Operator input of the name
                    Write-Host 'Use the name:'$FolderName                                   # Write message to screen
                    $OpConfirm = Read-Host '[Y] Yes [N] No [E] Exit'                        # Operator confirmation of the name
                    if ($OpConfirm -eq 'e') {                                               # If $OpConfirm equals 'e'
                        Break NewAzureSFolder                                               # Breaks :NewAzureSFolder
                    }                                                                       # End if ($OpConfirm -eq 'e')
                    elseif ($OpConfirm -eq 'y') {                                           # Else if $OpConfirm equals 'y'
                        Break SetAzureSFolderName                                           # Breaks :SetAzureSFolderName
                    }                                                                       # End elseif ($OpConfirm -eq 'y')
                }                                                                           # End :SetAzureSFolderName while ($true)
                Try {                                                                       # Try the following
                    Get-AzStorageFile -Path $StorageShareFolderObject -ShareName `
                        $StorageShareObject.Name -Context $StorageAccObject.Context | `
                        New-AzStorageDirectory -Path $FolderName -ErrorAction 'Stop'        # Creates folder
                }                                                                           # End Try
                Catch {                                                                     # If Try fails
                    Write-Host 'An error has occured'                                       # Write message to screen
                    Write-Host 'The share maybe locked'                                     # Write message to screen
                    Pause                                                                   # Pauses all action for operator input
                    Break NewAzureSFolder                                                   # Breaks :NewAzureSFolder
                }                                                                           # End catch
                Write-Host 'The folder has been created'                                    # Write message to screen
                Pause                                                                       # Pauses all action for operator input
                Break NewAzureSFolder                                                       # Breaks :NewAzureSFolder
            }                                                                               # End elseif ($OpSelect -eq '2')
            else {                                                                          # All other inputs for $OpSelect
                Write-Host 'That was not a valid option'                                    # Write message to screen
            }                                                                               # End else (if ($OpSelect -eq '0'))
        }                                                                                   # End :NewAzureSFolder while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function NewAzStorageDirectory
function RemoveAzStorageDirectory {                                                         # Function to remove a folder from file share
    Begin {                                                                                 # Begin function
        if (!$CallingFunction) {                                                            # If $CallingFunction is $null
            $CallingFunction = 'RemoveAzStorageDirectory'                                   # Creates $Calling function
        }                                                                                   # End if (!$CallingFunction)
        :RemoveAzureSFolder while ($true) {                                                 # Outer loop for managing function
            $StorageShareFolderObject, $StorageShareObject, $StorageAccObject = `
                NavAzStorageShare ($CallingFunction)                                        # Calls function and assigns output to $var
            if (!$StorageShareFolderObject) {                                               # If $StorageShareFolderObject is $null
                Break RemoveAzureSFolder                                                    # Breaks :RemoveAzureSFolder
            }                                                                               # End if (!$StorageShareFolderObject)
            $SubObjects = Get-AzStorageFile -Path $StorageShareFolderObject -ShareName `
                    $StorageShareObject.Name -Context $StorageAccObject.Context | `
                    Get-AzStorageFile                                                       # Gets a list of files or folders in StorageShareFolderObject
            if ($SubObjects) {                                                              # If $SubObjects has a value
                Write-Host 'Unable to remove:'$StorageShareFolderObject                     # Write message to screen
                Write-Host 'From file share: '$StorageShareObject.name                      # Write message to screen
                Write-Host 'From storage acc:'$StorageAccObject.StorageAccountName          # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Write-Host 'The directory is not empty'                                     # Write message to screen
                Write-Host 'No action has been taken'                                       # Write message to screen
                Pause                                                                       # Pauses for operator input
                Break RemoveAzureSFolder                                                    # Breaks :RemoveAzureSFolder
            }                                                                               # End if ($SubObjects)
            Write-Host 'Remove the folder:'$StorageShareFolderObject                        # Write message to screen
            Write-Host 'From file share:  '$StorageShareObject.name                         # Write message to screen
            Write-Host 'From storage acc: '$StorageAccObject.StorageAccountName             # Write message to screen
            $OpConfirm = Read-Host '[Y] Yes [N] No'                                         # Operator confirmation to remove the folder
            if ($OpConfirm -eq 'y') {                                                       # If $OpConfirm equals 'y'
                Try {                                                                       # Try the following
                    Remove-AzStorageDirectory -ShareName $StorageShareObject.Name -Path `
                        $StorageShareFolderObject -Context $StorageAccObject.Context `
                        -ErrorAction 'Stop'                                                 # Removes the folder
                }                                                                           # End try
                catch {                                                                     # If try fails
                    Write-Host 'An error has occured'                                       # Write message to screen
                    Write-Host 'The source folder may be locked'                            # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Break RemoveAzureSFolder                                                # Breaks :RemoveAzureSFolder
                }                                                                           # End catch
                Write-Host 'The folder has been removed'                                    # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break RemoveAzureSFolder                                                    # Breaks :RemoveAzureSFolder
            }                                                                               # End if ($OpConfirm -eq 'y')
            else {                                                                          # If $OpConfirm does not equal 'y'
                Write-Host 'No action taken'                                                # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break RemoveAzureSFolder                                                    # Breaks :RemoveAzureSFolder
            }                                                                               # End else (if ($OpConfirm -eq 'y'))
        }                                                                                   # End :RemoveAzureSFolder while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End begin
}                                                                                           # End function RemoveAzStorageDirectory
function ManageAzStorageFile {                                                              # Function to manage files in storage share
    Begin {                                                                                 # Begin function
        :ManageAzureSFile while ($true) {                                                   # Outer loop for managing function
            Write-Host '[0] Exit'                                                           # Write message to screen
            Write-Host '[1] Download file'                                                  # Write message to screen
            Write-Host '[2] Remove file'                                                    # Write message to screen   
            $OpSelect = Read-Host 'Option [#]'                                              # Operator input for selecting management function
            if ($OpSelect -eq '0') {                                                        # If $OpSelect equals '0'
                Break ManageAzureSFile                                                      # Breaks :ManageAzureSFile
            }                                                                               # End if ($OpSelect -eq '0')
            elseif ($OpSelect -eq '1') {                                                    # Else if $OpSelect equals '1'
                Clear-Host                                                                  # Clears screen
                GetAzStorageFileContent                                                     # Calls function
            }                                                                               # End elseif ($OpSelect -eq '1')
            elseif ($OpSelect -eq '1') {                                                    # Else if $OpSelect equals '2'
                Clear-Host                                                                  # Clears screen
                RemoveAzStorageFile                                                         # Calls function
            }                                                                               # End elseif ($OpSelect -eq '2')
            else {                                                                          # All other inputs for $OpSelect
                Write-Host 'That was not a valid option'                                    # Write message to screen
            }                                                                               # End else (if ($OpSelect -eq '0'))
        }                                                                                   # End :ManageAzureSFolder while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}
function GetAzStorageFileContent {                                                          # Function to download a file from file share
    Begin {                                                                                 # Begin function
        if (!$CallingFunction) {                                                            # If $CallingFunction is $null
            $CallingFunction = 'GetAzStorageFileContent'                                    # Creates $Calling function
        }                                                                                   # End if (!$CallingFunction)
        :GetAzureSFileContent while ($true) {                                               # Outer loop for managing function
            $StorageShareFileObject, $StorageShareObject, $StorageAccObject = `
                NavAzStorageShare ($CallingFunction)                                        # Calls function and assigns output to $var
            if (!$StorageShareFileObject) {                                                 # If $StorageShareFileObject is $null
                Break GetAzureSFileContent                                                  # Breaks :GetAzureSFileContent
            }                                                                               # End if (!$StorageShareFileObject)
            :SetLocalFilePath while ($true) {                                               # Inner loop for setting the local download path
                Write-Host '[0] Exit'                                                       # Write message to screen
                Write-Host '[1] Downloads folder'                                           # Write message to screen
                Write-Host '[2] Custom path'                                                # Write message to screen
                $OpSelect = Read-Host 'Option [#]'                                          # Operator input for download path selection
                if ($OpSelect -eq '0') {                                                    # If $OpSelect equals '0'
                    Break GetAzureSFileContent                                              # Breaks :GetAzureSFileContent
                }                                                                           # End if ($OpSelect -eq '0')
                elseif ($OpSelect -eq '1') {                                                # Else if $OpSelect equals '1'
                    $UserName = $env:USERNAME                                               # Gets session username
                    if ($UserName -like '*\*') {                                            # If $Username has a '\'
                        $UserName = $UserName.Split('\')[1]                                 # Removes \ and text before it
                    }                                                                       # End if ($UserName -like '*\*')
                    $LocalFileDownloadPath = 'c:\users\'+$UserName+'\downloads\'            # Creates $Localdownloadpath
                    Clear-Host                                                              # Clears screen
                    Break SetLocalFilePath                                                  # Breaks :SetLocalFilePath  
                }                                                                           # End elseif ($OpSelect -eq '1')
                elseif ($OpSelect -eq '2') {                                                # Else if $OpSelect equals '2'
                    :VerifyPath while ($true) {                                             # Inner loop for verifying local download path
                        $LocalFileDownloadPath = Read-Host `
                            'Enter the folder path to download blob to'                     # Operator input for local download path
                        if ($LocalFileDownloadPath -eq 'exit') {                            # If $LocalFileDownloadPath equals 'exit'
                            Break GetAzureSFileContent                                      # Breaks :GetAzureSFileContent
                        }                                                                   # End if ($LocalFileDownloadPath -eq 'exit')
                        if (Test-Path $LocalFileDownloadPath) {                             # If $LocalFileDownloadPath is valid
                            Clear-Host                                                      # Clears screen
                            Break SetLocalFilePath                                          # Breaks :SetLocalFilePath
                        }                                                                   # End if (Test-Path $LocalFileDownloadPath)
                        else {                                                              # If Test-Path is false
                            Write-Host ''                                                   # Write message to screen
                            Write-Host 'The listed path was not valid'                      # Write message to screen
                            Write-Host 'Please double check the folder path'                # Write message to screen
                            Write-Host ''                                                   # Write message to screen
                            Write-Host 'Enter "exit" to leave this function'                # Write message to screen
                            Pause                                                           # Pauses for operator input
                            Clear-Host                                                      # Clears screen
                        }                                                                   # End else (if (Test-Path $LocalFileDownloadPath))
                    }                                                                       # End :VerifyPath while ($true)
                }                                                                           # End elseif ($OpSelect -eq '2')
                else {                                                                      # All other inputs for $OpSelect
                    Write-Host 'That was not a valid option'                                # Write message to screen
                }                                                                           # End else (if ($OpSelect -eq '0'))
            }                                                                               # End :SetLocalFilePath while ($true)
            Try {                                                                           # Try the following
                Get-AzStorageFileContent -ShareName $StorageShareObject.Name -Path `
                    $StorageShareFileObject -Context $StorageAccObject.Context `
                    -Destination $LocalFileDownloadPath  -PreserveSMBAttribute `
                    -ErrorAction 'Stop'                                                     # Downloads the file
            }                                                                               # End try
            catch {                                                                         # If try fails
                Write-Host 'An error has occured'                                           # Write message to screen
                Write-Host 'The source file may be locked'                                  # Write message to screen
                Write-Host 'The destination folder maybe locked'                            # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break GetAzureSFileContent                                                  # Breaks :GetAzureSFileContent
            }                                                                               # End catch
            Write-Host 'The file has been downloaded'                                       # Write message to screen
            Pause                                                                           # Pauses all actions for operator input
            Break GetAzureSFileContent                                                      # Breaks :GetAzureSFileContent
        }                                                                                   # End :GetAzureSFileContent while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End begin
}                                                                                           # End function GetAzStorageFileContent
function RemoveAzStorageFile {                                                              # Function to remove a file from file share
    Begin {                                                                                 # Begin function
        if (!$CallingFunction) {                                                            # If $CallingFunction is $null
            $CallingFunction = 'RemoveAzStorageFile'                                        # Creates $Calling function
        }                                                                                   # End if (!$CallingFunction)
        :RemoveAzureSFile while ($true) {                                                   # Outer loop for managing function
            $StorageShareFileObject, $StorageShareObject, $StorageAccObject = `
                NavAzStorageShare ($CallingFunction)                                        # Calls function and assigns output to $var
            if (!$StorageShareFileObject) {                                                 # If $StorageShareFileObject is $null
                Break RemoveAzureSFile                                                      # Breaks :RemoveAzureSFile
            }                                                                               # End if (!$StorageShareFileObject)
            Write-Host 'Remove the file: '$StorageShareFileObject                           # Write message to screen
            Write-Host 'From file share: '$StorageShareObject.name                          # Write message to screen
            Write-Host 'From storage acc:'$StorageAccObject.StorageAccountName              # Write message to screen
            $OpConfirm = Read-Host '[Y] Yes [N] No'                                         # Operator confirmation to remove the file
            if ($OpConfirm -eq 'y') {                                                       # If $OpConfirm equals 'y'
                Try {                                                                       # Try the following
                    Remove-AzStorageFile -ShareName $StorageShareObject.Name -Path `
                        $StorageShareFileObject -Context $StorageAccObject.Context `
                        -ErrorAction 'Stop'                                                 # Removes the file
                }                                                                           # End try
                catch {                                                                     # If try fails
                    Write-Host 'An error has occured'                                       # Write message to screen
                    Write-Host 'The source file may be locked'                              # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Break RemoveAzureSFile                                                  # Breaks :RemoveAzureSFile
                }                                                                           # End catch
                Write-Host 'The file has been removed'                                      # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break RemoveAzureSFile                                                      # Breaks :RemoveAzureSFile
            }                                                                               # End if ($OpConfirm -eq 'y')
            else {                                                                          # If $OpConfirm does not equal 'y'
                Write-Host 'No action taken'                                                # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break RemoveAzureSFile                                                      # Breaks :RemoveAzureSFile
            }                                                                               # End else (if ($OpConfirm -eq 'y'))
        }                                                                                   # End :RemoveAzureSFile while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End begin
}                                                                                           # End function RemoveAzStorageFile
Function NavAzStorageShare {                                                                # Function get a storage share file path
    Begin {                                                                                 # Begin function
        $StorageShareObject, $StorageAccObject = GetAzStorageShare                          # Calls function and assigns output to $vars
        :SelectAzureShareFolder while ($true) {                                             # Outer loop for managing function
            if (!$StorageShareObject) {                                                     # If $StorageShareObject is $null
                Break SelectAzureShareFolder                                                # Breaks :SelectAzureStorageShareFolder
            }                                                                               # End if (!$StorageShareObject)                                                       
            :GetShareRoot while ($true) {                                                   # Inner loop for selecting the share root folder
                [System.Collections.ArrayList]$ObjectArray=@()                              # Creates $ObjectArray
                $RootFolders = Get-AzStorageFile -ShareName $StorageShareObject.Name `
                    -Context $StorageAccObject.Context | Where-Object `
                    {$_.GetType().Name -eq "AzureStorageFileDirectory"}                     # Collects all folders in root of share
                $ObjectNumber = 1                                                           # Creates $ObjectNumber
                foreach ($_ in $RootFolders) {                                              # For each item in $RootFolders
                    $ObjectInput = [PSCustomObject]@{'Name'=$_.Name;'Number'=$ObjectNumber} # Creates $ObjectInputs
                    $ObjectArray.Add($ObjectInput) | Out-Null                               # Loads $ObjectInput into $ObjectArray
                    $ObjectNumber = $ObjectNumber + 1                                       # Increments $ObjectNumber up by 1
                }                                                                           # End foreach ($_ in $RootFolders)
                :SelectShareRoot while ($true) {                                            # Inner loop to select root folder
                    Write-Host '[0]  Exit'                                                  # Write message to screen
                    foreach ($_ in $ObjectArray) {                                          # For each item in $ObjectArray
                        $Number = $_.Number                                                 # $Number is equal to current item .Number
                        if ($Number -le 9) {                                                # If $Number is less than 10 
                            Write-Host "[$Number] "$_.Name                                  # Write message to screen
                        }                                                                   # End if ($Number -le 9)                                                  
                        else {                                                              # If $Number is greater than 9
                            Write-Host "[$Number]"$_.Name                                   # Write message to screen
                        }                                                                   # End else (if ($Number -le 9))
                    }                                                                       # End foreach ($_ in $ObjectArray)
                    $OpSelect = Read-Host 'Select folder [#]'                               # Operator input for selecting the root folder
                    if ($OpSelect -eq '0') {                                                # If $OpSelect equals '0'
                        Break SelectAzureShareFolder
                    }                                                                       # End if ($OpSelect -eq '0')
                    elseif ($OpSelect -in $ObjectArray.Number) {                            # Else if $OpSelect in $ObjectArray.Number
                        $Path = $ObjectArray | Where-Object {$_.Number -eq $OpSelect}       # $Path is equal $ObjectArray where $ObjectArray.Number equals $OpSelect
                        $Path = $Path.name                                                  # $Path is equal to $Path.
                        Clear-Host                                                          # Clears screen
                        Break GetShareRoot                                                  # Breaks :GetShareRoot
                    }                                                                       # End elseif ($OpSelect -in $ObjectArray.Number)
                    else {                                                                  # All other inputs for $OpSelect
                        Write-Host 'That was not a valid option'                            # Write message to screen
                    }                                                                       # End else (if ($OpSelect -eq '0'))
                }                                                                           # End :SelectShareRoot while ($true)
            }                                                                               # End :GetShareRoot while ($true) {
            :SelectSubFolder while ($true) {                                                # Inner loop for selecting subfolder
                $ObjectNumber = 1                                                           # Recreates $ObjectNumber
                [System.Collections.ArrayList]$ObjectArray2=@()                             # Creates $ObjectArray2
                [System.Collections.ArrayList]$ObjectArray3=@()                             # Creates $ObjectArray3
                $SubFolders = Get-AzStorageFile -Path $Path -ShareName `
                    $StorageShareObject.Name -Context $StorageAccObject.Context | `
                    Get-AzStorageFile | Where-Object `
                    {$_.GetType().Name -eq "AzureStorageFileDirectory"}                     # Gets a list of all folders in $Path
                $SubFiles = Get-AzStorageFile -Path $Path -ShareName `
                    $StorageShareObject.Name -Context $StorageAccObject.Context | `
                    Get-AzStorageFile | Where-Object `
                    {$_.GetType().Name -ne "AzureStorageFileDirectory"}                     # Gets a list of all files in $Path
                foreach ($_ in $SubFolders) {                                               # For each item in $SubFolders
                    $ObjectInput = [PSCustomObject]@{'Name'=$_.Name;'Number'=$ObjectNumber} # Recreats $ObjectInput
                    $ObjectArray2.Add($ObjectInput) | Out-Null                              # Loads $ObjectInput into $ObjectArray2
                    $ObjectNumber = $ObjectNumber + 1                                       # Increments $ObjectNumber up by 1
                }                                                                           # End foreach ($_ in $SubFolders)
                $ObjectNumber = 1                                                           # Recreates $ObjectNumber
                foreach ($_ in $SubFiles) {                                                 # For each item in $SubFiles
                    $ObjectInput = [PSCustomObject]@{'Name'=$_.Name;'Number'=$ObjectNumber} # Recreats $ObjectInput
                    $ObjectArray3.Add($ObjectInput) | Out-Null                              # Loads $ObjectInput into $ObjectArray3
                    $ObjectNumber = $ObjectNumber + 1                                       # Increments $ObjectNumber up by 1
                }                                                                           # End foreach ($_ in $RootFolders)
                Write-Host ''                                                               # Write message to screen
                Write-Host 'Current folders in'$Path                                        # Write message to screen
                Write-Host ''                                                               # Write message to screen
                if ($ObjectArray2) {                                                        # If $ObjectArray2 has a valid
                    foreach ($_ in $ObjectArray2) {                                         # For each item in $ObjectArray2
                        Write-Host $_.Name                                                  # Write message to screen
                    }                                                                       # End foreach ($_ in $ObjectArray2)
                }                                                                           # End if ($ObjectArray2)
                else {                                                                      # If $ObjectArray2 does not have a value
                    Write-Host 'No folders exist'                                           # Write message to screen
                }                                                                           # End else (if ($ObjectArray2))
                Write-Host ''                                                               # Write message to screen
                Write-Host 'Current files in'$Path                                          # Write message to screen
                Write-Host ''                                                               # Write message to screen
                if ($ObjectArray3) {                                                        # If $ObjectArray3 has a value
                    foreach ($_ in $ObjectArray3) {                                         # Foreach item in $ObjectArray3
                        Write-Host $_.Name                                                  # Write message to screen
                    }                                                                       # End foreach ($_ in $ObjectArray3)
                }                                                                           # End if ($ObjectArray3)
                else {                                                                      # If $ObjectArray3 does not have a value
                    Write-Host 'No files exist'                                             # Write message to screen
                }                                                                           # End else (if ($ObjectArray3))
                Write-Host ''                                                               # Write message to screen
                Write-Host '[0]  Exit'                                                      # Write message to screen
                Write-Host '[1]  Go down a folder'                                          # Write message to screen
                Write-Host '[2]  Go up a folder'                                            # Write message to screen
                Write-Host '[3]  Select current folder for action'                          # Write message to screen
                Write-Host '[4]  Select a file in folder for action'                        # Write message to screen
                Write-Host '[5]  Select new root folder'                                    # Write message to screen
                $OpSelect = Read-Host 'Select option [#]'                                   # Operator input to select action
                Clear-Host                                                                  # Clears screen
                if ($OpSelect -eq '0') {                                                    # If $OpSelect equals '0'
                    Break SelectAzureShareFolder                                            # Breaks :SelectAzureShareFolder
                }                                                                           # End if ($OpSelect -eq '0')
                elseif ($OpSelect -eq '1') {                                                # Else if $OpSelect equals '1'
                    :SelectShareSub while ($true) {                                         # Inner loop for selecting the sub folder 
                        Write-Host '[0]  Exit'                                              # Write message to screen
                        foreach ($_ in $ObjectArray2) {                                     # For each item in $ObjectArray2
                            $Number = $_.Number                                             # $Number is equal to current item .number
                            if ($Number -le 9) {                                            # If $Number is less than 10
                                Write-Host "[$Number] "$_.Name                              # Write message to screen
                            }                                                               # End if ($Number -le 9) 
                            else {                                                          # If $Number is greater than 9
                                Write-Host "[$Number]"$_.Name                               # Write message to screen
                            }                                                               # End else (if ($Number -le 9))
                        }                                                                   # End foreach ($_ in $ObjectArray2)
                        $OpSelect = Read-Host 'Select folder [#]'                           # Operator input to select folder
                        if ($OpSelect -eq '0') {                                            # If $OpSelect equals '0'
                            Break SelectAzureShareFolder                                    # Breaks :SelectAzureShareFolder    
                        }                                                                   # End if ($OpSelect -eq '0')
                        elseif ($OpSelect -in $ObjectArray2.Number) {                       # Else if $OpSelect in $ObjectArray2.Number
                            $UpdatedPath = $ObjectArray2 | Where-Object `
                                {$_.Number -eq $OpSelect}                                   # UpdatedPath is equal to $ObjectArray2 where $ObjectArray2.Number equals $OpSelect
                            $Path = $Path+'\'+$UpdatedPath.name                             # $Path is equal to $Path + '\' + $UpdatedPath.Name
                            Clear-Host                                                      # Clears screen
                            Break SelectShareSub                                            # Breaks :SelectShareSub
                        }                                                                   # End elseif ($OpSelect -in $ObjectArray.Number)
                        else {                                                              # All other inputs for $OpSelect
                            Write-Host 'That was not a valid option'                        # Write message to screen
                        }                                                                   # End else (if ($OpSelect -eq '0'))
                    }                                                                       # End :SelectShareSub while ($true) 
                }                                                                           # End elseif ($OpSelect -eq '1')
                elseif ($OpSelect -eq '2') {                                                # If $OpSelect equals '2'
                    if ($Path -in $ObjectArray.Name) {                                      # If $Path in $ObjectArray.Name
                        Break SelectSubFolder                                               # Breaks :SelectSubFolder
                    }                                                                       # End if ($Path -in $ObjectArray.Name)
                    else {                                                                  # If $Path not in $ObjectArray.Name
                        $Path = Split-Path $Path                                            # Updates the path by removing the last item
                    }                                                                       # End else (if ($Path -in $ObjectArray.Name))
                }                                                                           # End elseif ($OpSelect -eq '2')
                elseif ($OpSelect -eq '3') {                                                # If $OpSelect equals '4'
                    Write-Host 'Take action on:'$Path                                       # Write message to screen
                    $OpConfirm = Read-Host '[Y] Yes [N] No'                                 # Operator input to return to calling function
                    if ($OpConfirm -eq 'y') {                                               # If $OpConfirm equals 'y'
                        $StorageShareFolderObject = $Path                                   # $StorageShareFolderObject equals $Path                                   
                        Clear-Host                                                          # Clears screen
                            Return $StorageShareFolderObject, $StorageShareObject, `
                                $StorageAccObject                                           # Returns to $CallingFunction with $vars
                    }                                                                       # End if ($OpConfirm -eq 'y')
                }                                                                           # End elseif ($OpSelect -eq '3')
                elseif ($OpSelect -eq '4') {                                                # If $OpSelect equals '4'
                    :SelectShareFile while ($true) {                                        # Inner loop for selecting the file
                        Write-Host '[0]  Exit'                                              # Write message to screen
                        foreach ($_ in $ObjectArray3) {                                     # For each item in $ObjectArray3
                            $Number = $_.Number                                             # $Number is equal to current item .number
                            if ($Number -le 9) {                                            # If $Number is less than 10
                                Write-Host "[$Number] "$_.Name                              # Write message to screen
                            }                                                               # End if ($Number -le 9)
                            else {                                                          # If $Number is greater than 9
                                Write-Host "[$Number]"$_.Name                               # Write message to screen
                            }                                                               # End else (if ($Number -le 9))
                        }                                                                   # End foreach ($_ in $ObjectArray3)
                        if ($CallingFunction) {                                             # If $CallingFunction has a value
                            Write-Host 'You are selecting the file for:'$CallingFunction    # Write message to screen
                        }                                                                   # End if ($CallingFunction)
                        $OpSelect = Read-Host 'Select file [#]'                             # Operator input for selecting the file                           
                        if ($OpSelect -eq '0') {                                            # If $OpSelect equals '0'
                            Break SelectAzureShareFolder                                    # Breaks :SelectAzureShareFolder
                        }                                                                   # End if ($OpSelect -eq '0')
                        elseif ($OpSelect -in $ObjectArray3.Number) {                       # Else if $OpSelect in $ObjectArray3.Number
                            $FileName = $ObjectArray3 | Where-Object `
                                {$_.Number -eq $OpSelect}                                   # $FileName is equal to $ObjectArray3 where $ObjectArray3.Number equals $OpSelect
                            $FileName = $FileName.name                                      # $FileName is equal to $FileName.Name
                            $StorageShareFileObject = $Path+'\'+$FileName                   # Adds full path to filename
                            Clear-Host                                                      # Clears screen
                            Return $StorageShareFileObject, $StorageShareObject, `
                                $StorageAccObject                                           # Returns to $CallingFunction with $vars
                        }                                                                   # End elseif ($OpSelect -in $ObjectArray.Number)
                        else {                                                              # All other inputs for $OpSelect
                            Write-Host 'That was not a valid option'                        # Write message to screen
                        }                                                                   # End else (if ($OpSelect -eq '0'))
                    }                                                                       # End :SelectShareRoot while ($true)
                }                                                                           # End elseif ($OpSelect -eq '4')
                elseif ($OpSelect -eq '5') {                                                # If $OpSelect equals '5'
                    Break SelectSubFolder                                                   # Breaks :SelectSubFolder
                }                                                                           # End elseif ($OpSelect -eq '5')
                
                else {                                                                      # All other inputs for $OpSelect
                    Write-Host 'That was not a valid option'                                # Write message to screen
                }                                                                           # End else (if ($OpSelect -eq '0'))
            }                                                                               # End :SelectSubFolder while ($true)
        }                                                                                   # End :SelectAzureShareFolder while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function NavAzStorageShare
# End ManageAzStorageShare
# Functions for ManageAzKeyVault
function ManageAzKeyVault {                                                                 # Function for managing Azure key vaults
    Begin {                                                                                 # Begin function
        :ManageAzureKeyVault while ($true) {                                                # Outer loop for managing function
            Write-Host '[0] Exit'                                                           # Write message to screen
            Write-Host '[1] New Key Vault'                                                  # Write message to screen
            Write-Host '[2] List All Key Vaults'                                            # Write message to screen
            Write-Host '[3] Remove Key Vault'                                               # Write message to screen
            Write-Host '[4] Manage Key Vault Keys'                                          # Write message to screen
            Write-Host '[5] Manage Key Vault Secrets'                                       # Write message to screen
            Write-Host '[6] Manage Key Vault Certificates'                                  # Write message to screen
            $OpSelect= Read-Host 'Select option [#]'                                        # Operator input for which option they need to run
            Clear-Host                                                                      # Clears screen
            if ($OpSelect-eq '0') {                                                         # If $OpSelect equals '0'
                Break ManageAzureKeyVault                                                   # Breaks :ManageAzureKeyVault
            }                                                                               # End if ($OpSelect-eq '0')
            elseif ($OpSelect-eq '1') {                                                     # Else if $OpSelect equals '1'                  
                Write-Host 'New Key Vault'                                                  # Write message to screen
                NewAzKeyVault                                                               # Calls function 
            }                                                                               # End elseif ($OpSelect-eq '1')
            elseif ($OpSelect-eq '2') {                                                     # Else if $OpSelect equals '2'                  
                Write-Host 'List All Key Vaults'                                            # Write message to screen
                ListAzKeyVault                                                              # Calls function 
            }                                                                               # End elseif ($OpSelect-eq '2')
            elseif ($OpSelect-eq '3') {                                                     # Else if $OpSelect equals '3'                  
                Write-Host 'Remove Key Vault'                                               # Write message to screen
                RemoveAzKeyVault                                                            # Calls function 
            }                                                                               # End elseif ($OpSelect-eq '3')
            elseif ($OpSelect-eq '4') {                                                     # Else if $OpSelect equals '4'                  
                Write-Host 'Manage Key Vault Keys'                                          # Write message to screen
                ManageAzKeyVaultKey                                                         # Calls function 
            }                                                                               # End elseif ($OpSelect-eq '4')
            elseif ($OpSelect-eq '5') {                                                     # Else if $OpSelect equals '5'                  
                Write-Host 'Manage Key Vault Secrets'                                       # Write message to screen
                ManageAzKeyVaultSecret                                                      # Calls function 
            }                                                                               # End elseif ($OpSelect-eq '5')
            elseif ($OpSelect-eq '6') {                                                     # Else if $OpSelect equals '6'                  
                Write-Host 'Manage Key Vault Certificates'                                  # Write message to screen
                #ManageAzKeyVaultCert                                                        # Calls function 
            }                                                                               # End elseif ($OpSelect-eq '6')
            else {                                                                          # All other inputs for $OpSelect
                Write-Host 'That was not a valid option'                                    # Write message to screen
            }                                                                               # End else (if ($OpSelect-eq '0'))
        }                                                                                   # End :ManageAzureKeyVault while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End begin
}                                                                                           # End function ManageAzKeyVault
function NewAzKeyVault {                                                                    # Function to create a new key vault
    Begin {                                                                                 # Begin function
        $ErrorActionPreference='silentlyContinue'                                           # Turns off error reporting
        if (!$CallingFunction) {                                                            # If $CallingFunction does not have a value
            $CallingFunction = 'NewAzKeyVault'                                              # Creates $CallingFunction
        }                                                                                   # End if (!$CallingFunction)
        :NewAzureKeyVault while ($true) {                                                   # Outer loop for managing function
            $RGObject = GetAzResourceGroup ($CallingFunction)                               # Calls function and assigns output to $var
            if (!$RGObject) {                                                               # If $RGObject is $null
                Break NewAzureKeyVault                                                      # Breaks :NewAzureKeyVault
            }                                                                               # End if (!$RGObject)
            $LocationObject = GetAzLocation ($CallingFunction)                              # Calls function and assigns output to var
            if (!$LocationObject) {                                                         # If $LocationObject is $null
                Break NewAzureKeyVault                                                      # Breaks :NewAzureKeyVault
            }                                                                               # End if (!$LocationObject)
            :SetAzureKeyVaultName while ($true) {                                           # Inner loop for setting the key vault name
                $ValidArray = 'abcdefghijklmnopqrstuvwxyz0123456789-'                       # Creates a string of valid characters
                $ValidArray = $ValidArray.ToCharArray()                                     # Loads all valid characters into array
                Write-Host 'Vault name must be atleast 3 characters'                        # Write message to screen
                Write-Host 'and made up of letters and numbers only'                        # Write message to screen
                $VaultNameArray = $null                                                     # Clears $VaultNameArray
                $VaultNameInput = Read-Host 'Vault name'                                    # Operator input for the share name
                if ($VaultNameInput.Length -ge 3) {                                         # If $ValutNameinput is 3 or more characters
                    $VaultNameArray = $VaultNameInput.ToCharArray()                         # Creates $VaultNameInput
                    $VaultNameLast = $VaultNameInput.Length                                 # Gets total character count of $VaultNameInput
                    $VaultNameLast = $VaultNameLast - 1                                     # Reduces $VaultNameLast by one to match index
                    if ($VaultNameArray[0] -eq '-') {                                       # If $VaultNameArray first entry equals '-'
                        Write-Host ''                                                       # Write message to screen
                        Write-Host "Vault name first character cannot be '-'"               # Write message to screen
                        $VaultNameInput = $null                                             # Clears $VaultNameInput
                    }                                                                       # End if ($VaultNameArray[0] -eq '-')
                    if ($VaultNameArray[$VaultNameLast] -eq '-') {                          # If $VaultNameArray Last entry equals '-'
                        Write-Host ''                                                       # Write message to screen
                        Write-Host "Vault name last character cannot be '-'"                # Write message to screen
                        $VaultNameInput = $null                                             # Clears $VaultNameInput
                    }                                                                       # End if ($VaultNameArray[0] -eq '-')
                    foreach ($_ in $VaultNameArray) {                                       # For each item in $VaultNameArray
                        if ($_ -notin $ValidArray) {                                        # If current item is not in $ValidArray
                            if ($_ -eq ' ') {                                               # If current item equals 'space'
                                Write-Host ''                                               # Write message to screen    
                                Write-Host 'Vault name cannot include any spaces'           # Write message to screen
                            }                                                               # End if ($_ -eq ' ')
                            else {                                                          # If current item is not equal to 'space'
                                Write-Host ''                                               # Write message to screen    
                                Write-Host $_' is not a valid character'                    # Write message to screen
                            }                                                               # End else (if ($_ -eq ' '))
                            $VaultNameInput = $null                                         # Clears $VaultNameInput
                        }                                                                   # End if ($_ -notin $ValidArray)
                    }                                                                       # End foreach ($_ in $VaultNameArray)
                    if (!$VaultNameInput) {                                                 # If $VaultNameInput is $null
                        Pause                                                               # Pauses for operator input
                        Clear-Host                                                          # Clears screen
                    }                                                                       # End if ($VaultNameInput -eq '0')
                    else {                                                                  # If $VaultNameInput not equal to '0'
                        Write-Host $VaultNameInput 'is correct'                             # Write message to screen
                        $OpConfirm = Read-Host '[Y] Yes [N] No [E] Exit'                    # Operator confirmation of share name input
                        if ($OpConfirm -eq 'e') {                                           # If $OpConfirm equals 'e'
                            Break NewAzureKeyVault                                          # Breaks NewAzureKeyVault
                        }                                                                   # End if ($OpConfirm -eq 'e')
                        if ($OpConfirm -eq 'y') {                                           # If $OpConfirm is equal to 'y'
                            Clear-Host                                                      # Clears screen
                            Break SetAzureKeyVaultName                                      # Breaks :SetAzureKeyVaultName
                        }                                                                   # End if ($OpConfirm -eq 'y')
                    }                                                                       # End else (if (!$VaultNameInput))
                }                                                                           # End if ($VaultNameInput.Length -ge 3)
                else {                                                                      # If $KeyVaultNameInput is less than 3 characters
                    Write-Host 'Vault name must be atleast 3 characters'                    # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Clear-Host                                                              # Clears screen
                }                                                                           # End else (if ($VaultNameInput.Length -ge 3))
            }                                                                               # :SetAzureKeyVaultName while ($true)
            Try {                                                                           # Try the following
                New-AzKeyVault -ResourceGroupName $RGObject.ResourceGroupName `
                    -Location $LocationObject.DisplayName -Name $VaultNameInput `
                    -ErrorAction 'Stop'                                                     # Creates the key vault
            }                                                                               # End try
            Catch {                                                                         # If try fails
                Write-Host 'An error has occured'                                           # Write message to screen
                Write-Host 'You may not have the permissions'                               # Write message to screen
                Write-Host 'The vault name may already be in use'                           # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break NewAzureKeyVault                                                      # Breaks :NewAzureKeyVault
            }                                                                               # End catch
            Write-Host 'The key vault has been created'                                     # Write message to screen
            Pause                                                                           # Pauses all actions for operator input
            Break NewAzureKeyVault                                                          # Breaks :NewAzureKeyVault
        }                                                                                   # End :NewAzureKeyVault while ($true)
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function NewAzkeyvault
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
function ListAzKeyVault {                                                                   # Function to list a key vault objects
    Begin {                                                                                 # Begin function
        :ListAzureKeyVault while ($true) {                                                  # Outer loop for managing function
            $ObjectList = Get-AzKeyVault                                                    # Gets all key vaults and assigns to $ObjectList
            [System.Collections.ArrayList]$ObjectArray = @()                                # Creates the object list array
            foreach ($_ in $ObjectList) {                                                   # For each $_ in $ObjectListList
                $ObjectInput = [PSCustomObject]@{'Name'=$_.VaultName; `
                'RG'=$_.ResourceGroupName;'Loc' = $_.Location}                              # Creates the item to loaded into array
                $ObjectArray.Add($ObjectInput) | Out-Null                                   # Loads item into array, out-null removes write to screen
                $ObjectNumber = $ObjectNumber + 1                                           # Increments $ObjectNumber by 1
            }                                                                               # End foreach ($_ in $ObjectList)
            foreach ($_ in $ObjectArray) {                                                  # For each $_ in $ObjectArray
                Write-Host 'Vault name:'$_.Name                                             # Write message to screen
                Write-Host 'RG Name:   '$_.RG                                               # Write message to screen
                Write-Host 'Location:  '$_.Loc                                              # Write message to screen
                Write-Host ''                                                               # Write message to screen
            }                                                                               # End foreach ($_ in $ObjectArray)
            Pause                                                                           # Pauses all actions for operator input
            Break ListAzureKeyVault                                                         # Breaks :ListAzureKeyVault
        }                                                                                   # End :ListAzureKeyVault while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function ListAzKeyVault
function RemoveAzKeyVault {                                                                 # Function to remove a key vault object
    Begin {                                                                                 # Begin function
        if (!$CallingFunction) {                                                            # If $CallingFunction does not have a value
            $CallingFunction = 'RemoveAzKeyVault'                                           # Creates $Calling function
        }                                                                                   # End if (!$CallingFunction)
        :RemoveAzureKeyVault while ($true) {                                                # Outer loop for managing function
            $KeyVaultObject = GetAzKeyVault ($CallingFunction)                              # Calls function and assigns output to $var
            if (!$KeyVaultObject) {                                                         # If $KeyVaultObject is $null
                Break RemoveAzureKeyVault                                                   # Breaks :RemoveAzureKeyVault
            }                                                                               # End if (!$KeyVaultObject)
            Write-Host 'Remove Vault: '$KeyVaultObject.VaultName                            # Write message to screen
            Write-Host 'from resource group: '$KeyVaultObject.ResourceGroupName             # Write message to screen
            $OpConfirm = Read-Host '[Y] Yes [N] No'                                         # Write message to screen
            if ($OpConfirm -eq 'y') {                                                       # If $OpConfirm equals 'y'
                Write-Host 'Removing:'$KeyVaultObject.VaultName                             # Write message to screen
                Try {                                                                       # Try the following
                    Remove-AzKeyVault -VaultName $KeyVaultObject.VaultName `
                        -ResourceGroupName $KeyVaultObject.ResourceGroupName -force `
                        -ErrorAction 'Stop'                                                 # Removes the key vault
                }                                                                           # End try
                catch {                                                                     # If Try fails
                    Write-Host 'An error has occured'                                       # Write message to screen
                    Write-Host 'This resource maybe locked'                                 # Write message to screen
                    Write-Host 'The resource group maybe locked'                            # Write message to screen
                    Write-Host 'You may not have the permissions'                           # Write message to screen
                    Write-Host 'To perform a remove action'                                 # Write message to screen
                    Pause                                                                   # Pauses all action for operator input
                    Break RemoveAzureKeyVault                                               # Breaks :RemoveAzureKeyVault
                }                                                                           # End catch
                Write-Host $KeyVaultObject.VaultName 'has been removed'                     # Write message to screen
                Pause                                                                       # Pauses all action for operator input
                Break RemoveAzureKeyVault                                                   # Breaks :RemoveAzureKeyVault
            }                                                                               # End if ($OpConfirm -eq 'y')
            else {                                                                          # All other inputs for $OpConfirm
                Write-Host 'No action taken'                                                # Write message to screen
                Pause                                                                       # Pauses all action for operator input
                Break RemoveAzureKeyVault                                                   # Breaks :RemoveAzureKeyVault
            }                                                                               # End else (if ($OpConfirm -eq 'y'))
        }                                                                                   # End :RemoveAzureKeyVault while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function RemoveAzKeyVault
function ManageAzKeyVaultKey {                                                              # Function for managing key vault keys
    Begin {                                                                                 # Begin function
        :ManageAzureKeyVaultKey while ($true) {                                             # Outer loop for managing function
            Write-Host '[0] Exit'                                                           # Write message to screen
            Write-Host '[1] New Key Vault Key'                                              # Write message to screen
            Write-Host '[2] Add Key Vault Key'                                              # Write message to screen
            Write-Host '[3] List All Key Vaults Keys'                                       # Write message to screen
            Write-Host '[4] Download Key Vault Key'                                         # Write message to screen
            Write-Host '[5] Remove Key Vault Key'                                           # Write message to screen
            $OpSelect = Read-Host 'Chose option [#]'                                        # Operator selection for management function
            if ($OpSelect -eq '0') {                                                        # If $OpSelect equals '0'
                Break ManageAzureKeyVaultKey                                                # Breaks :ManageAzureKeyVaultKey
            }                                                                               # End if ($OpSelect -eq '0')
            elseif ($OpSelect -eq '1') {                                                    # Elseif $OpSelect equals '1'
                Write-Host 'New Key Vault Key'                                              # Write message to screen
                NewAzKeyVaultKey                                                            # Calls function 
            }                                                                               # End elseif ($OpSelect -eq '1')
            elseif ($OpSelect -eq '2') {                                                    # Elseif $OpSelect equals '2'
                Write-Host 'Add Key Vault Key'                                              # Write message to screen
                AddAzKeyVaultKey                                                            # Calls function 
            }                                                                               # End elseif ($OpSelect -eq '2')
            elseif ($OpSelect -eq '3') {                                                    # Elseif $OpSelect equals '3'
                Write-Host 'List All Key Vaults Keys'                                       # Write message to screen
                ListAzKeyVaultKey                                                           # Calls function 
            }                                                                               # End elseif ($OpSelect -eq '3')
            elseif ($OpSelect -eq '4') {                                                    # Elseif $OpSelect equals '4'
                Write-Host 'Download Key Vault Key'                                         # Write message to screen
                DownloadAzKeyVaultKey                                                       # Calls function 
            }                                                                               # End elseif ($OpSelect -eq '4')
            elseif ($OpSelect -eq '5') {                                                    # Elseif $OpSelect equals '5'
                Write-Host 'Remove Key Vault Key'                                           # Write message to screen
                RemoveAzKeyVaultKey                                                         # Calls function 
            }                                                                               # End elseif ($OpSelect -eq '5')
            else {                                                                          # All other inputs for $OpSelect
                Write-Host 'That was not a valid option'                                    # Write message to screen
            }                                                                               # End else (if ($OpSelect -eq '0'))
        }                                                                                   # End :ManageAzureKeyVaultKey while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End begin statemnt
}                                                                                           # End function ManageAzKeyVaultKey
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
function AddAzKeyVaultKey {                                                                 # Function to add an existing key to key vault
    Begin {                                                                                 # Begin function
        if (!$CallingFunction) {                                                            # If $CallingFunction does not have a value
            $CallingFunction = 'AddAzKeyVaultKey'                                           # Creates $CallingFunction
        }                                                                                   # End if (!$CallingFunction)
        :AddAzureKeyVaultKey while ($true) {                                                # Outer loop for managing function
            $KeyVaultObject = GetAzKeyVault ($CallingFunction)                              # Calls function and assigns output to $var
            if (!$KeyVaultObject) {                                                         # If $KeyVaultObject is $null
                Break AddAzureKeyVaultKey                                                   # Breaks :AddAzureKeyVaultKey    
            }                                                                               # End if (!$KeyVaultObject)
            :GetLocalDownloadPath while ($true) {                                           # Inner loop for getting the file patch
                Write-Host 'Please provide the path to the key'                             # Write message to screen
                Write-Host 'Example: C:\users\admin\documents\key.pfx'                      # Write message to screen
                $FilePath = Read-Host 'Path to file'                                        # Operator input for the download path
                if ($FilePath -eq 'exit') {                                                 # If $var is equal to 'exit' 
                    Break AddAzureKeyVaultKey                                               # Breaks :AddAzureKeyVaultKey
                }                                                                           # End if ($FilePath -eq 'exit')
                if (Test-Path -Path $FilePath) {                                            # If file exists
                    Write-Host 'Upload: '$FilePath                                          # Write message to screen
                    $OpConfirm = Read-Host '[Y] Yes [N] No'                                 # Operator confirmation to use this file
                    if ($OpConfirm -eq 'y') {                                               # If $OpConfirm equals 'y'
                        :GetKeyPassword while ($true) {                                     # Inner loop for getting key password
                            Write-Host 'Enter the password key'                             # Write message to screen
                            $Password1 = Read-Host 'Password'                               # Operator input for the key password
                            if ($Password1 -eq 'exit') {                                    # If $Password1 equals 'exit'
                                Break AddAzureKeyVaultKey                                   # Breaks :AddAzureKeyVaultKey
                            }                                                               # End if ($Password1 -eq 'exit')
                            $Password2 = Read-Host 'Re-enter to confirm'                    # Operator input to confirm key password
                            if ($Password1 -eq $Password2) {                                # If $Password1 equals $Password2
                                $Password = ConvertTo-SecureString -String $Password1 `
                                -AsPlainText -Force                                         # Creates hashed password
                                Clear-Host                                                  # Clears screen
                                Break GetLocalDownloadPath                                  # Breaks :GetLocalDownloadPath
                            }                                                               # End if ($Password1 -eq $Password2)
                            else {                                                          # If $Password1 does not equal $Password2
                                Write-Host 'Passwords do not match'                         # Write message to screen
                                Pause                                                       # Pauses all actions for operator input
                                Clear-Host                                                  # Clears screen
                            }                                                               # End else (if ($Password1 -eq $Password2))
                        }                                                                   # End :GetKeyPassword while ($true)
                    }                                                                       # End if ($OpConfirm -eq 'y')
                }                                                                           # End if (Test-Path -Path $FilePath)
                else {                                                                      # If file does not exist
                    Write-Host 'The file path:'$FilePath 'is not valid'                     # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Clear-Host                                                              # Clears screen
                }                                                                           # End else (if (Test-Path -Path $FilePath))
            }                                                                               # End :GetLocalDownloadPath while ($true)
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
                    Break AddAzureKeyVaultKey                                               # Breaks :AddAzureKeyVaultkey
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
                Break AddAzureKeyVaultKey                                                   # Breaks :AddAzureKeyVaultkey
            }                                                                               # End if ($OpSelect -eq 'e')
            if ($OpSelect -eq 'y') {                                                        # If $OpSelect equals 'y'
                :AzureKeyVaultKeyExpire while ($true) {                                     # Inner loop for setting expiration date
                    $StartDate = (Get-Date).Date                                            # Gets current date
                    Write-Host 'Enter the date in the following format: YYYY-MM-DD'         # Write message to screen
                    Write-Host 'Example: 2050-07-04 to have the key expire on 4 July 2050'  # Write message to screen
                    $EndDate = Read-Host 'Key expiration date'                              # Operator input for end date
                    if ($EndDate -eq 'exit') {                                              # If $EndDate equals 'exit'
                        Break AddAzureKeyVaultKey                                           # Breaks :AddAzureKeyVaultKey
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
                    Break AddAzureKeyVaultKey                                               # Breaks :AddAzureKeyVaultKey
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
                    Break AddAzureKeyVaultKey                                               # Breaks :AddAzureKeyVaultKey
                }                                                                           # End else (if ($OpSelect -eq '0'))
                if ($KeyEncryptType -eq 'HSM') {                                            # If $KeyEncryptType is equal to 'HSM'
                    if ($KeyVaultObject.SKU -eq 'Standard') {                               # If $KeyVaultObject.SKU is equal to 'Standard'
                        Write-Host 'HSM is not supported on this key vault'                 # Write message to screen
                        Write-Host '[0] Exit'                                               # Write message to screen
                        Write-Host '[1] Change encryption to software'                      # Write message to screen
                        $OpSelect = Read-Host 'Option [#]'                                  # Operator input on changing type or exiting
                        if ($OpSelect -eq '0') {                                            # If $OpSelect equals '0'
                            Break AddAzureKeyVaultKey                                       # Breaks :AddAzureKeyVaultKey
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
                        $KeyExpires -NotBefore $KeyNotBefore -KeyFilePath $FilePath `
                        -KeyFilePassword $Password -ErrorAction 'Stop'                      # Adds the key
                }                                                                           # End try
                Catch {                                                                     # If Try fails
                    Write-Host 'An error has occured'                                       # Write message to screen
                    Write-Host 'You may not have the permissions to preform this action'    # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Clear-Host                                                              # Clears screen
                    Break AddAzureKeyVaultKey                                               # Breaks :AddAzureKeyVaultKey
                }                                                                           # End Catch
                Write-Host 'The key has been created'                                       # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Clear-Host                                                                  # Clears screen
                Break AddAzureKeyVaultKey                                                   # Breaks :AddAzureKeyVaultKey
            }                                                                               # End if ($KeyNotBefore)
            else {                                                                          # If $KeyNotBefore is $null
                Try {                                                                       # Try the following
                    Add-AzKeyVaultKey -VaultName $KeyVaultObject.VaultName -Name `
                    $KeyVaultKeyNameInput -Destination $KeyEncryptType -KeyFilePath `
                    $FilePath -KeyFilePassword $Password -ErrorAction 'Stop'                # Adds the key
                }                                                                           # End try
                Catch {                                                                     # If Try fails
                    Write-Host 'An error has occured'                                       # Write message to screen
                    Write-Host 'You may not have the permissions to preform this action'    # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Clear-Host                                                              # Clears screen
                    Break AddAzureKeyVaultKey                                               # Breaks :AddAzureKeyVaultKey
                }                                                                           # End Catch
                Write-Host 'The key has been added'                                         # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Clear-Host                                                                  # Clears screen
                Break AddAzureKeyVaultKey                                                   # Breaks :AddAzureKeyVaultKey
            }                                                                               # End else (if ($KeyNotBefore))
        }                                                                                   # End :AddAzureKeyVaultKey while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function AddAzKeyVaultKey
function ListAzKeyVaultKey {                                                                # Function to list all key vault keys
    Begin {                                                                                 # Begin function
        $KVList = Get-AzKeyVault                                                            # Creates lists of all key vaults
        foreach ($VaultName in $KVList) {                                                   # For each key vault in $KVList
            Write-Host '------------------------------------------------------------------' # Write message to screen
            $KVKeylist = Get-AzKeyVaultKey -VaultName $VaultName.VaultName                  # Creates a list of all keys in current $VaultName
            Write-Host 'Vault Name: ' $VaultName.VaultName                                  # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            if ($KVKeylist) {                                                               # If $KVKeyList has a value
                foreach ($Name in $KVKeylist) {                                             # For each Key name in $KVKeyList
                    Write-Host 'Key Name:   ' $Name.Name                                    # Write message to screen
                    Write-Host 'Key ID:     ' $Name.ID                                      # Write message to screen
                    Write-Host 'Enabled:    ' $Name.Enabled                                 # Write message to screen
                    Write-Host 'Updated:    ' $Name.Updated                                 # Write message to screen
                    if ($Name.Expires) {                                                    # If current item has an existing expiration
                        Write-Host 'Expires:    ' $Name.Expires                             # Write message to screen
                        Write-Host 'NotBefore:  ' $Name.NotBefore                           # Write message to screen
                    }                                                                       # End if ($Name.Expires)
                    Write-Host ''                                                           # Write message to screen
                }                                                                           # End foreach ($Name in $KVKeylist)
            }                                                                               # End if ($KVKeylist)
            else {                                                                          # If $KVKeylist does not have a value
                Write-Host 'No Keys in this vault'                                          # Write message to screen
                Write-Host ''                                                               # Write message to screen
            }                                                                               # End else (if ($KVKeylist))
        }                                                                                   # End foreach ($VaultName in $KVList)
        Write-Host '------------------------------------------------------------------'     # Write message to screen
        Pause                                                                               # Pauses all action for operator input
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin 
}                                                                                           # End function ListAzKeyVaultKey
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
function DownloadAzKeyVaultKey {                                                            # Function to download a key vault key
    Begin {                                                                                 # Begin function
        $ErrorActionPreference = 'silentlyContinue'                                         # Disables error reporting
        if (!$CallingFunction) {                                                            # If $CallingFunction does not have a value
            $CallingFunction = 'DownloadAzKeyVaultKey'                                      # Creates $CallingFunction 
        }                                                                                   # End if (!$CallingFunction)
        :DownloadAzureKVKey while ($true) {                                                 # Outer loop for managing function
            $KeyVaultKeyObject, $KeyVaultObject = GetAzKeyVaultKey ($CallingFunction)       # Calls function and assigns output to $vars
            if (!$KeyVaultKeyObject) {                                                      # If $KeyVaultKeyObject is $null
                Break DownloadAzureKeyVaultKey                                              # Breaks :DownloadAzureKeyVaultKey    
            }                                                                               # End if (!$KeyVaultObject)
            :SetLocalFilePath while ($true) {                                               # Inner loop for setting the local download path
                Write-Host '[0] Exit'                                                       # Write message to screen
                Write-Host '[1] Downloads folder'                                           # Write message to screen
                Write-Host '[2] Custom path'                                                # Write message to screen
                $OpSelect = Read-Host 'Option [#]'                                          # Operator input for download path selection
                if ($OpSelect -eq '0') {                                                    # If $OpSelect equals '0'
                    Break DownloadAzureKeyVaultKey                                          # Breaks :DownloadAzureKeyVaultKey
                }                                                                           # End if ($OpSelect -eq '0')
                elseif ($OpSelect -eq '1') {                                                # Else if $OpSelect equals '1'
                    $UserName = $env:USERNAME                                               # Gets session username
                    if ($UserName -like '*\*') {                                            # If $Username has a '\'
                        $UserName = $UserName.Split('\')[1]                                 # Removes \ and text before it
                    }                                                                       # End if ($UserName -like '*\*')
                    $LocalFileDownloadPath = 'c:\users\'+$UserName+'\downloads\'            # Creates $Localdownloadpath
                    Clear-Host                                                              # Clears screen
                    Break SetLocalFilePath                                                  # Breaks :SetLocalFilePath  
                }                                                                           # End elseif ($OpSelect -eq '1')
                elseif ($OpSelect -eq '2') {                                                # Else if $OpSelect equals '2'
                    :VerifyPath while ($true) {                                             # Inner loop for verifying local download path
                        $LocalFileDownloadPath = Read-Host `
                            'Enter the folder path to download key to'                      # Operator input for local download path
                        if ($LocalFileDownloadPath -eq 'exit') {                            # If $LocalFileDownloadPath equals 'exit'
                            Break DownloadAzureKeyVaultKey                                  # Breaks :DownloadAzureKeyVaultKey
                        }                                                                   # End if ($LocalFileDownloadPath -eq 'exit')
                        if (Test-Path $LocalFileDownloadPath) {                             # If $LocalFileDownloadPath is valid
                            Clear-Host                                                      # Clears screen
                            Break SetLocalFilePath                                          # Breaks :SetLocalFilePath
                        }                                                                   # End if (Test-Path $LocalFileDownloadPath)
                        else {                                                              # If Test-Path is false
                            Write-Host ''                                                   # Write message to screen
                            Write-Host 'The listed path was not valid'                      # Write message to screen
                            Write-Host 'Please double check the folder path'                # Write message to screen
                            Write-Host ''                                                   # Write message to screen
                            Write-Host 'Enter "exit" to leave this function'                # Write message to screen
                            Pause                                                           # Pauses for operator input
                            Clear-Host                                                      # Clears screen
                        }                                                                   # End else (if (Test-Path $LocalFileDownloadPath))
                    }                                                                       # End :VerifyPath while ($true)
                }                                                                           # End elseif ($OpSelect -eq '2')
                else {                                                                      # All other inputs for $OpSelect
                    Write-Host 'That was not a valid option'                                # Write message to screen
                }                                                                           # End else (if ($OpSelect -eq '0'))
            }                                                                               # End :SetLocalFilePath while ($true)
            :SetLocalFileName while ($true) {                                               # Inner loop for setting the key local name
                $LocalFileName = Read-Host 'Enter the key name'                             # Operator input for the key name
                if ($LocalFileName -eq 'exit') {                                            # If $LocalFileName is equal to 'exit'
                    Break DownloadAzureKVKey                                                # Breaks :DownloadAzureKVKey
                }                                                                           # End if ($LocalFileName -eq 'exit')
                $LocalfileName = $LocalFileName+'.pem'                                      # Adds .pem to file name
                Write-Host 'User this file name:'$LocalFileName                             # Write message to screen
                $OpConfirm = Read-Host '[Y] Yes [N] No'                                     # Operator confirmation of file name
                if ($OpConfirm -eq 'y') {                                                   # If $OpConfirm equals 'y'
                    Break SetLocalFileName                                                  # Breaks :SetLocalFileName
                }                                                                           # End if ($OpConfirm -eq 'y')
            }                                                                               # End :SetLocalFileName while ($true)
            $Fullpath = $LocalFileDownloadPath+$LocalFileName                               # Creates the full download path and name $var
            Try {                                                                           # Try the following
                Get-AzKeyVaultKey -VaultName $KeyVaultObject.VaultName -Name `
                    $KeyVaultKeyObject.Name -OutFile $Fullpath -ErrorAction 'Stop'          # Downloads the selected key
            }                                                                               # End Try
            Catch {                                                                         # If try fails
                Write-Host 'An error has occured'                                           # Write message to screen
                Write-Host 'You may not have permissions to this key'                       # Write message to screen
                Write-Host 'You may not have permissions to the download location'          # Write message to screen
                Write-Host 'The selected download location may not exist'                   # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Clear-Host                                                                  # Clears screen
                Break DownloadAzureKVKey                                                    # Breaks :DownloadAzureKVKey    
            }                                                                               # End Catch
            Write-Host 'The key has been downloaded'                                        # Write message to screen
            Pause                                                                           # Pauses all actions for operator input
            Clear-Host                                                                      # Clears screen
            Break DownloadAzureKVKey                                                        # Breaks :DownloadAzureKVKey    
        }                                                                                   # End :DownloadAzureKVKey while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function DownloadAzKeyVaultKey
function RemoveAzKeyVaultKey {                                                              # Function to remove a key vault key
    Begin {                                                                                 # Begin function
        $ErrorActionPreference = 'silentlyContinue'                                         # Disables error reporting
        if (!$CallingFunction) {                                                            # If $CallingFunction does not have a value
            $CallingFunction = 'RemoveAzKeyVaultKey'                                        # Creates $CallingFunction 
        }                                                                                   # End if (!$CallingFunction)
        :RemoveAzureKeyVaultKey while ($true) {
            $KeyVaultKeyObject, $KeyVaultObject = GetAzKeyVaultKey ($CallingFunction)       # Calls function and assigns output to $var
            if (!$KeyVaultKeyObject) {                                                      # If $KeyVaultKeyObject is $null
                Break RemoveAzureKeyVaultKey                                                # Breaks :DownloadAzureKeyVaultKey    
            }                                                                               # End if (!$KeyVaultObject)
            Write-host 'The remove key:'$KeyVaultKeyObject.Name                             # Write message to screen
            Write-Host 'From vault:'    $KeyVaultObject.VaultName                           # Write message to screen
            $OpConfirm = Read-Host '[Y] Yes [N] No'                                         # Operator confirmation for deletion
            if ($OpConfirm -eq 'y') {                                                       # If $OpConfirm is equal to 'y'
                Write-Host 'Removing:' $KeyVaultKeyObject.Name                              # Write message to screen
                Try {                                                                       # Try the following
                    Remove-AzKeyVaultKey -Name $KeyVaultKeyObject.Name -VaultName `
                        $KeyVaultKeyObject.VaultName -Force -ErrorAction 'Stop'             # Removes the selected key
                }                                                                           # End Try
                catch {                                                                     # If Try fails
                    Write-Host 'There was an issue removing the selected key'               # Write message to screen
                    Write-Host 'You may not have the permissions to remove this key'        # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Clear-Host                                                              # Clears screen
                    Break RemoveAzureKeyVaultKey                                            # Breaks :RemoveAzureKeyVaultKey 
                }                                                                           # End catch
                Write-Host 'The Key has been removed'                                       # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Clear-Host                                                                  # Clears screen
                Break RemoveAzureKeyVaultKey                                                # Breaks :RemoveAzureKeyVaultKey
            }                                                                               # End if ($ConfirmDelete -eq 'y')
            else {                                                                          # If $OpConfirm does not equal 'y'
                Write-Host 'No changes have been made'                                      # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Clear-Host                                                                  # Clears screen
                Break RemoveAzureKeyVaultKey                                                # Breaks :RemoveAzureKeyVaultKey
            }                                                                               # End else (if ($ConfirmDelete -eq 'y'))
        }                                                                                   # End :RemoveAzureKeyVaultKey while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to callign function with $null
    }                                                                                       # End Begin
}                                                                                           # End function RemoveAzKeyVaultKey
# Functions for ManageAzKeyVaultSecret
function ManageAzKeyVaultSecret {                                                           # Function for managing key vault secrets
    Begin {                                                                                 # Begin function
        :ManageAzureKeyVaultSecret while ($true) {                                          # Outer loop for managing function
            Write-Host '[0] To exit'                                                        # Write message to screen
            Write-Host '[1] New Key Vault Secret'                                           # Write message to screen
            Write-Host '[2] List All Key Vaults Secret'                                     # Write message to screen
            Write-Host '[3] Get Key Vault Secret Value'                                     # Write message to screen
            Write-Host '[4] Update Key Vault Secret Value'                                  # Write message to screen
            Write-Host '[5] Remove Key Vault Secret Value'                                  # Write message to screen
            $OpSelect = Read-Host 'Option [#]'                                              # Operator input for selecting the management function
            if ($OpSelect -eq '0') {                                                        # If $OpSelect equals '0'
                Break ManageAzureKeyVaultSecret                                             # Breaks :ManageAzureKeyVaultSecret
            }                                                                               # End if ($OpSelect -eq '0')
            elseif ($OpSelect -eq '1') {                                                    # Else if $OpSelect equals '1'            
                Write-Host 'New Key Vault Secret'                                           # Write message to screen
                NewAzKeyVaultSecret                                                         # Calls function
            }                                                                               # End elseif ($OpSelect -eq '1')
            elseif ($OpSelect -eq '2') {                                                    # Else if $OpSelect equals '2'            
                Write-Host 'List All Key Vaults Secrets'                                    # Write message to screen
                ListAzKeyVaultSecret                                                        # Calls function
            }                                                                               # End elseif ($OpSelect -eq '2')
            elseif ($OpSelect -eq '3') {                                                    # Else if $OpSelect equals '3'            
                Write-Host 'Get Key Vault Secret Value'                                     # Write message to screen
                GetAzKeyVaultSecretValue                                                    # Calls function
            }                                                                               # End elseif ($OpSelect -eq '3')
            elseif ($OpSelect -eq '4') {                                                    # Else if $OpSelect equals '4'            
                Write-Host 'Update Key Vault Secret Value'                                  # Write message to screen
                UpdateAzKeyVaultSecret                                                      # Calls function
            }                                                                               # End elseif ($OpSelect -eq '4')
            elseif ($OpSelect -eq '5') {                                                    # Else if $OpSelect equals '5'            
                Write-Host 'Remove Key Vault Secret Value'                                  # Write message to screen
                RemoveAzKeyVaultSecret                                                      # Calls function
            }                                                                               # End elseif ($OpSelect -eq '5')
            else {                                                                          # All other inputs for $OpSelect
                Write-Host 'That was not a valid option'                                    # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
            }                                                                               # End else (if ($OpSelect -eq '0'))
            Clear-Host                                                                      # Clears screen
        }                                                                                   # End :ManageAzureKeyVaultSecret while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End begin statemnt
}                                                                                           # End function ManageAzKeyVaultSecret
function NewAzKeyVaultSecret {                                                              # Function to create a new key vault secret
    Begin {                                                                                 # Begin function
        if (!$CallingFunction) {                                                            # If $CallingFunction does not have a value
            $CallingFunction = 'NewAzKeyVaultSecret'                                        # Creates $CallingFunction
        }                                                                                   # End if (!$CallingFunction)
        $ErrorActionPreference='silentlyContinue'                                           # Disables Errors
        $WarningPreference = "silentlyContinue"                                             # Disables key vault warnings
        :NewAzureKVSecret while ($true) {                                                   # Outer loop for managing function
            $KeyVaultObject = GetAzKeyVault ($CallingFunction)                              # Calls function and assigns output to $Var
            if (!$KeyVaultObject) {                                                         # If $KeyVaultObject is $null
                Break NewAzureKVSecret                                                      # Breaks :NewAzureKVSecret
            }                                                                               # End if (!$KeyVaultObject)
            :NewAzureKVSecretName while ($true) {                                           # Inner loop for setting the new key vault secret name
                Write-Host 'Please enter the name of the new secret'                        # Write message to screen
                $KeyVaultSecretName = Read-Host 'Secret name'                               # Operator input for the secret name
                Write-Host 'Use:'$KeyVaultSecretName 'as the secret name'                   # Write message to screen
                $OpConfirm = Read-Host '[Y] Yes [N] No [E] Exit'                            # Operator confirmation of name
                if ($OpConfirm -eq 'e') {                                                   # If $OpConfirm is equal to 'e'
                    Break NewAzureKVSecret                                                  # Breaks :NewAzureKVSecret
                }                                                                           # End if ($OpConfirm -eq 'e')
                if ($OpConfirm -eq 'y') {                                                   # If $OpConfirm is equal to 'y'
                    Clear-Host                                                              # Clears screen
                    Break NewAzureKVSecretName                                              # Breaks :NewAzureKVSecretName
                }                                                                           # End if ($OpConfirm -eq 'y')
                Clear-Host                                                                  # Clears screen
            }                                                                               # End :NewAzureKVSecretName while ($true)
            :NewAzureKVSecretValue while ($true) {                                          # Inner loop for setting the new key vault secret value
                Write-Host 'Please enter the value of the new secret'                       # Write message to screen
                $KeyVaultSecretValue = Read-Host Read-Host 'Secret value'                   # Operator input for the secret value
                Write-Host 'Use:'$KeyVaultSecretValue 'as the secret value'                 # Write message to screen
                $OpConfirm = Read-Host '[Y] Yes [N] No [E] Exit'                            # Operator confirmation of name
                if ($OpConfirm -eq 'e') {                                                   # If $OpConfirm is equal to 'e'
                    Break NewAzureKVSecret                                                  # Breaks :NewAzureKVSecret
                }                                                                           # End if ($OpConfirm -eq 'e')
                if ($OpConfirm -eq 'y') {                                                   # If $OpConfirm is equal to 'y'
                    Clear-Host                                                              # Clears screen
                    $KeyVaultSecretHash = ConvertTo-SecureString -String `
                        $KeyVaultSecretValue -AsPlainText -Force                            # Converts the secret to a hashed value
                    Break NewAzureKVSecretValue                                             # Breaks :NewAzureKVSecretValue
                }                                                                           # End if ($OpConfirm -eq 'y')
                Clear-Host                                                                  # Clears screen
            }                                                                               # End :NewAzureKVSecretValue while ($true)
            Try {                                                                           # Try the following
                Set-AzKeyVaultSecret -VaultName $KeyVaultObject.VaultName -Name `
                    $KeyVaultSecretName -SecretValue $KeyVaultSecretHash `
                    -ErrorAction 'Stop'                                                     # Creates new secret
            }                                                                               # End Try
            catch {                                                                         # If try fails
                Write-Host 'An error has occured'                                           # Write message to screen
                Write-Host 'You may not have the'                                           # Write message to screen
                Write-Host 'permissions to do this'                                         # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break NewAzureKVSecret                                                      # Breaks :NewAzureKVSecret
            }                                                                               # End Catch
            Write-Host 'The secret has been created'                                        # Write message to screen
            Pause                                                                           # Pauses all actions for operator input
            Break NewAzureKVSecret                                                          # Breaks :NewAzureKVSecret
        }                                                                                   # End :NewAzureKVSecret while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function NewAzKeyVaultSecret
function ListAzKeyVaultSecret {                                                             # Function to list all key vault secrets
    Begin {                                                                                 # Begin function
        $WarningPreference = "silentlyContinue"                                             # Disables key vault warnings
        $KVList = Get-AzKeyVault                                                            # Creates lists of all key vaults
        foreach ($VaultName in $KVList) {                                                   # For each key vault in $KVList
            Write-Host '------------------------------------------------------------------' # Write message to screen
            $KVSecretlist = Get-AzKeyVaultSecret -VaultName $VaultName.VaultName            # Creates a list of all secrets in current $VaultName
            Write-Host 'Vault Name: ' $VaultName.VaultName                                  # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            if ($KVSecretlist) {                                                            # If $KVSecretList has a value
                foreach ($Name in $KVSecretlist) {                                          # For each secret name in $KVSecretList
                    Write-Host 'Secret Name:' $Name.Name                                    # Write message to screen
                    Write-Host 'Secret ID:  ' $Name.ID                                      # Write message to screen
                    Write-Host 'Enabled:    ' $Name.Enabled                                 # Write message to screen
                    Write-Host 'Updated:    ' $Name.Updated                                 # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                }                                                                           # End foreach ($Name in $KVSecretlist)
            }                                                                               # End if ($KVSecretlist)
            else {                                                                          # If $KVSecretlist does not have a value
                Write-Host 'No secrets in this vault'                                       # Write message to screen
                Write-Host ''                                                               # Write message to screen
            }                                                                               # End else (if ($KVSecretlist))
        }                                                                                   # End foreach ($VaultName in $KVList)
        Write-Host '------------------------------------------------------------------'     # Write message to screen
        Pause                                                                               # Pauses all action for operator input
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin 
}                                                                                           # End function ListAzKeyVaultSecret
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
                    Return $KeyVaultSecretObject, $KeyVaultObject                           # Returns to calling function with $vars
                }                                                                           # End elseif ($RGSelect -in $ListArray.Number)
                else {                                                                      # All other inputs for $OpSelect
                    Write-Host "That was not a valid option"                                # Write message to screen
                }                                                                           # End else (if ($OpSelect -eq '0'))
            }                                                                               # End :SelectAzureKeyVaultSecret
        }                                                                                   # End :GetAzureKeyVaultSecret while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End begin statement
}                                                                                           # End function GetAzKeyVaultSecret
function GetAzKeyVaultSecretValue {                                                         # Function to return the value of a key vault secret
    Begin {                                                                                 # Begin function
        $ErrorActionPreference='silentlyContinue'                                           # Disables Errors
        $WarningPreference = "silentlyContinue"                                             # Disables key vault warnings
        if (!$CallingFunction) {                                                            # If $CallingFunction does not have a value
            $CallingFunction = 'GetAzKeyVaultSecretValue'                                   # Creates $CallingFunction
        }                                                                                   # End if (!$CallingFunction)
        :GetAzureKeyVaultSecretVal while ($true) {                                          # Outer loop for managing function
            $KeyVaultSecretObject, $KeyVaultObject = GetAzKeyVaultSecret ($CallingFunction) # Calls function and assigns output to $Var
            if (!$KeyVaultSecretObject) {                                                   # If $KeyVaultSecretObject is $null
                Break GetAzureKeyVaultSecretVal                                             # Breaks :GetAzureKeyVaultSecretVal
            }                                                                               # End if (!$KeyVaultSecretObject)
            $KVSO = $KeyVaultSecretObject                                                   # KVSO is equal to $KeyVaultSecretObject
            $KVSV = $null                                                                   # Clears $KVSV from all previous use
            $KVSH = $null                                                                   # Clears $KVSH from all previous use
            $KVSH = `
            [System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($KVSO.SecretValue) # $KVSH is equal to to $KVSO.SecretValue
            try {                                                                           # Try the following
                $KVSV = [System.Runtime.InteropServices.Marshal]::PtrToStringBSTR($KVSH)    # KVSV is equal to $KVSH
            }                                                                               # End try
            Catch {                                                                         # If try fails
                Write-Host 'An error has occured'                                           # Write message to screen
                Write-Host 'you may not have permissions'                                   # Write message to screen
                Write-Host 'to this secret or vault'                                        # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break GetAzureKeyVaultSecretVal                                             # Breaks :GetAzureKeyVaultSecretVal
            }                                                                               # End catch
            finally {                                                                       # If try succeeds
                [System.Runtime.InteropServices.Marshal]::ZeroFreeBSTR($KVSV)               # Finishes unhashing $KVSV
            }                                                                               # End finally
            Write-Host '[0] Exit'                                                           # Write message to screen
            Write-Host '[1] Write to screen'                                                # Write message to screen
            Write-Host '[2] Pass value to:'$CallingFunction                                 # Write message to screen
            $OpSelect = Read-Host 'Option [#]'                                              # Operator input for selection option
            if ($OpSelect -eq '0') {                                                        # If $OpSelect equals '0'
                Break GetAzureKeyVaultSecretVal                                             # Breaks :GetAzureKeyVaultSecretVal
            }                                                                               # End if ($OpSelect -eq '0')
            elseif ($OpSelect -eq '1') {                                                    # Else if $OpSelect equals '1'
                Write-Host 'Secret Name: '$KVSO.Name                                        # Write message to screen
                Write-Host 'Secret Value:'$KVSV                                             # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break GetAzureKeyVaultSecretVal                                             # Breaks :GetAzureKeyVaultSecretVal
            }                                                                               # End elseif ($OpSelect -eq '1')
            elseif ($OpSelect -eq '2') {                                                    # Else if $OpSelect equals '2'
                Clear-Host                                                                  # Clears screen
                Return $KVSV                                                                # Returns to calling function with $var
            }                                                                               # End elseif ($OpSelect -eq '1')
            else {                                                                          # All other inputs for $OpSelect
                Write-Host 'That was not a valid option'                                    # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Clear-Host                                                                  # Clears screen
            }                                                                               # End else (if ($OpSelect -eq '0'))
        }                                                                                   # End :GetAzureKeyVaultSecretValue while ($true) 
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End begin statement   
}                                                                                           # End function GetAzKeyVaultSecretValue
function UpdateAzKeyVaultSecret {                                                           # Function to update the value of selected key
    Begin {                                                                                 # Begin function
        $ErrorActionPreference='silentlyContinue'                                           # Disables Errors
        $WarningPreference = "silentlyContinue"                                             # Disables key vault warnings
        if (!$CallingFunction) {                                                            # If $CallingFunction does not have a value
            $CallingFunction = 'UpdateAzKeyVaultSecret'                                     # Creates $CallingFunction
        }                                                                                   # End if (!$CallingFunction)
        :UpdateAzureKeyVaultSecret while ($true) {                                          # Outer loop for managing funciton
            $KeyVaultSecretObject, $KeyVaultObject = GetAzKeyVaultSecret ($CallingFunction) # Calls function and assigns output to $Var
            if (!$KeyVaultSecretObject) {                                                   # If $KeyVaultSecretObject is $null
                Break UpdateAzureKeyVaultSecret                                             # Breaks :UpdateAzureKeyVaultSecret
            }                                                                               # End if (!$KeyVaultSecretObject)
            :UpdateAzureKVSecretValue while ($true) {                                       # Inner loop for updating key vault secret value
                Write-Host 'Please enter a new value for:'$KeyVaultSecretObject.Name        # Write message to screen
                $KeyVaultSecretValue = Read-Host 'New value'                                # Operator input for the new secret value
                Write-Host 'Use:'$KeyVaultSecretValue'as the new value'                     # Write message to screen
                $OpConfirm = Read-Host '[Y] Yes [N] No [E] Exit'                            # Operator confirmation of value
                if ($OpConfirm -eq 'e') {                                                   # If $OpConfirm is equal to 'e'
                    Break UpdateAzureKeyVaultSecret                                         # Breaks :NewAzureKeyVaultSecret
                }                                                                           # End if ($OpConfirm -eq 'e')
                if ($OpConfirm -eq 'y') {                                                   # If $OConfirm is equal to 'y'
                    Clear-Host                                                              # Clears screen
                    Break UpdateAzureKVSecretValue                                          # Breaks :UpdateAzureKVSecretValue
                }                                                                           # End if ($OpConfirm -eq 'y')
                else {                                                                      # All other inputs for $OpConfirm
                    Clear-Host                                                              # Clears screen
                }                                                                           # End else (if ($OpConfirm -eq 'y'))
            }                                                                               # End :UpdateAzureKVSecretValue while ($true)
            $KeyVaultSecretHash = ConvertTo-SecureString -String $KeyVaultSecretValue `
                -AsPlainText -Force                                                         # Converts the operator input to secure string
            try {                                                                           # Try to do the following
                Set-AzKeyVaultSecret -VaultName $KeyVaultObject.VaultName -Name `
                    $KeyVaultSecretObject.Name -SecretValue $KeyVaultSecretHash `
                    -ErrorAction 'Stop'                                                     # Updates $KeyVaultSecretObject
            }                                                                               # End Try
            catch {                                                                         # If try statement fails
                Write-Host 'There was an issue updating this secret'                        # Write message to screen
                Write-Host 'You may not have the permissions to modify this secret'         # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break UpdateAzureKeyVaultSecret                                             # Breaks :UpdateAzureKVSecretValue 
            }                                                                               # End catch
            Write-Host $KeyVaultSecretObject.Name'has been updated'                         # Write message to screen
            Pause                                                                           # Pauses all actions for operator input
            Break UpdateAzureKeyVaultSecret                                                 # Breaks :UpdateAzureKVSecretValue
        }                                                                                   # End :UpdateAzureKeyVaultSecret while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function UpdateAzKeyVaultSecret
function RemoveAzKeyVaultSecret {                                                           # Function to remove a key vault secret
    Begin {                                                                                 # Begin function
        $ErrorActionPreference='silentlyContinue'                                           # Disables errors
        $WarningPreference = 'silentlyContinue'                                             # Disables key vault warnings
        if (!$CallingFunction) {                                                            # If $CallingFunction does not have a value
            $CallingFunction = 'RemoveAzKeyVaultSecret'                                     # Creates $CallingFunction
        }                                                                                   # End if (!$CallingFunction)
        :RemoveAzureKeyVaultSecret while ($true) {                                          # Outer loop for managing function
            $KeyVaultSecretObject, $KeyVaultObject = GetAzKeyVaultSecret ($CallingFunction) # Calls function and assigns output to $Var
            if (!$KeyVaultSecretObject) {                                                   # If $KeyVaultSecretObject is $null
                Break RemoveAzureKeyVaultSecret                                             # Breaks :RemoveAzureKeyVaultSecret
            }                                                                               # End if (!$KeyVaultSecretObject)
            Write-host ''                                                                   # Write message to screen
            Write-host 'Remove:    '$KeyVaultSecretObject.Name                              # Write message to screen
            Write-Host 'From vault:'$KeyVaultSecretObject.VaultName                         # Write message to screen
            Write-host ''                                                                   # Write message to screen
            $OpConfirm = Read-Host '[Y] Yes [N] No'                                         # Operator confirmation to delete 
            Clear-Host                                                                      # Clears screen
            if ($OpConfirm -eq 'y') {                                                       # If $OpConfirm equals 'y'
                Write-Host 'Removing' $KeyVaultSecretObject.Name                            # Write message to screen
                Try {                                                                       # Try the following
                    Remove-AzKeyVaultSecret -Name $KeyVaultSecretObject.Name -VaultName `
                        $KeyVaultSecretObject.VaultName -Force -ErrorAction 'Stop'          # Removes the selected secret
                }                                                                           # End Try
                catch {                                                                     # If try fails
                    Write-Host 'There was an issue removing the selected key'               # Write message to screen
                    Write-Host 'You may not have the permissions to remove this key'        # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Break RemoveAzureKeyVaultSecret                                         # Breaks :RemoveAzureKeyVaultSecret 
                }                                                                           # End catch
                Write-Host 'The secret has been removed'                                    # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break RemoveAzureKeyVaultSecret                                             # Breaks :RemoveAzureKeyVaultSecret
            }                                                                               # End if ($OpConfirm -eq 'y')
            else {                                                                          # If $OpConfirm is not equal to 'y'
                Write-Host 'No action taken'                                                # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break RemoveAzureKeyVaultSecret                                             # Breaks :RemoveAzureKeyVaultSecret
            }                                                                               # End else (if ($OpConfirm -eq 'y'))
        }                                                                                   # End :RemoveAzureKeyVaultSecret while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function RemoveAzKeyVaultSecret
# End ManageAzKeyVaultSecret
# Functions for ManageAzKVCertificate
function ManageAzKVCertificate {                                                            # Function for managing key vault certs
    Begin {                                                                                 # Begin function
        :ManageAzureKeyVaultCert while ($true) {                                            # Outer loop for managing function
            Write-Host '[0] To exit'                                                        # Write message to screen
            Write-Host '[1] New Key Vault Cert'                                             # Write message to screen
            Write-Host '[2] Add Key Vault Cert'                                             # Write message to screen
            Write-Host '[3] List All Key Vaults Certs'                                      # Write message to screen
            Write-Host '[4] Download Key Vault Cert'                                        # Write message to screen
            Write-Host '[5] Update Key Vault Cert'                                          # Write message to screen
            Write-Host '[6] Remove Key Vault Cert'                                          # Write message to screen
            $OpSelect = Read-Host 'Option [#]'                                              # Operator input for selecting the management function
            if ($OpSelect -eq '0') {                                                        # If $OpSelect equals '0'
                Break ManageAzureKeyVaultCert                                               # Breaks :ManageAzureKeyVaultCert
            }                                                                               # End if ($OpSelect -eq '0')
            elseif ($OpSelect -eq '1') {                                                    # Else if $OpSelect equals '1'            
                Write-Host 'New Key Vault Cert'                                             # Write message to screen
                NewAzKVCertificate                                                          # Calls function
            }                                                                               # End elseif ($OpSelect -eq '1')
            elseif ($OpSelect -eq '2') {                                                    # Else if $OpSelect equals '2'            
                Write-Host 'Add Key Vault Cert'                                             # Write message to screen
                # Calls function
            }                                                                               # End elseif ($OpSelect -eq '2')
            elseif ($OpSelect -eq '3') {                                                    # Else if $OpSelect equals '3'            
                Write-Host 'List All Key Vaults Certs'                                      # Write message to screen
                ListAzKVCertificate                                                         # Calls function
            }                                                                               # End elseif ($OpSelect -eq '3')
            elseif ($OpSelect -eq '4') {                                                    # Else if $OpSelect equals '4'            
                Write-Host 'Download Key Vault Cert'                                        # Write message to screen
                DownloadAzKVCertificate                                                     # Calls function
            }                                                                               # End elseif ($OpSelect -eq '4')
            elseif ($OpSelect -eq '5') {                                                    # Else if $OpSelect equals '5'            
                Write-Host 'Update Key Vault Cert'                                          # Write message to screen
                # Calls function
            }                                                                               # End elseif ($OpSelect -eq '5')
            elseif ($OpSelect -eq '6') {                                                    # Else if $OpSelect equals '6'            
                Write-Host 'Remove Key Vault Cert'                                          # Write message to screen
                RemoveAzKVCertificate                                                       # Calls function
            }                                                                               # End elseif ($OpSelect -eq '6')
            else {                                                                          # All other inputs for $OpSelect
                Write-Host 'That was not a valid option'                                    # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
            }                                                                               # End else (if ($OpSelect -eq '0'))
            Clear-Host                                                                      # Clears screen
        }                                                                                   # End :ManageAzureKeyVaultSecret while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End begin statemnt
}                                                                                           # End function ManageAzKeyVaultSecret
function NewAzKVCertificate {                                                               # Function to create a certificate
    Begin {                                                                                 # Begin function
        if (!$CallingFunction) {                                                            # If $CallingFunction is $null
            $CallingFunction = 'NewAzKVCertificate'                                         # Creates $CallingFunction 
        }                                                                                   # End if (!$CallingFunction)
        :NewAzureKVCert while ($true) {                                                     # Outer loop for managing function
            $KeyVaultObject = GetAzKeyVault ($CallingFunction)                              # Calls function and assigns output to $var
            if (!$KeyVaultObject) {                                                         # If $KeyVaultObject is $null
                Break NewAzureKVCert                                                        # Breaks :NewAzureKVCert
            }                                                                               # End if (!$KeyVaultObject)
            $Policy = NewAzKVCertificatePolicy ($CallingFunction)                           # Calls function and assigns output to $var
            if (!$Policy) {                                                                 # If $Policy is $null
                Break NewAzureKVCert                                                        # Breaks :NewAzureKVCert
            }                                                                               # End if (!$Policy)
            :SetAzureKVCertName while ($true) {                                             # Inner loop for setting the cert name
                Write-Host 'Enter the name of the certificate'                              # Write message to screen
                $CertName = Read-Host 'Name'                                                # Operator input of the cert name
                Clear-Host                                                                  # Clears screen
                Write-Host 'Use:'$CertName'as the certificate name?'                        # Write message to screen
                $OpConfirm = Read-Host '[Y] Yes [N] No [E] Exit'                            # Operator confirmation of the cert name
                if ($OpConfirm -eq 'e') {                                                   # If $OpSelect equals 'e'
                    Break NewAzureKVCert                                                    # Breaks :NewAzureKVCert
                }                                                                           # End if ($OpConfirm -eq 'e')
                elseif ($OpConfirm -eq 'y') {                                               # Else if $OpSelect equals 'y'
                    Break SetAzureKVCertName                                                # Breaks :SetAzureKVCertName
                }                                                                           # End elseif ($OpConfirm -eq 'y') 
                else {                                                                      # All other inputs for $OpSelect
                    Clear-Host                                                              # Clears screen
                }                                                                           # End else (if ($OpConfirm -eq 'e'))
            }                                                                               # End :SetAzureKVCertName while ($true)
            try {                                                                           # Try the following
                Add-AzKeyVaultCertificate -VaultName $KeyVaultObject.VaultName -Name `
                    $CertName -CertificatePolicy $Policy -ErrorAction 'Stop'                # Adds cert to key vault
            }                                                                               # End try
            Catch {                                                                         # If try fails
                Write-Host 'An error has occured'                                           # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break NewAzureKVCert                                                        # Breaks :NewAzureKVCert
            }                                                                               # End catch
            Write-Host 'The certificate has been added'                                     # Write message to screen
            Pause                                                                           # Pauses all actions for operator input
            Break NewAzureKVCert                                                            # Breaks :NewAzureKVCert
        }                                                                                   # End :NewAzureKVCertPolicy while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function NewAzKVCertificate
function NewAzKVCertificatePolicy {                                                         # Function to create a local certificate
    Begin {                                                                                 # Begin function
        if (!$CallingFunction) {                                                            # If $CallingFunction is $null
            $CallingFunction = 'NewAzKVCertificatePolicy'                                   # Creates $CallingFunction
        }                                                                                   # End if (!$CallingFunction)
        :NewAzureKVCertPolicy while ($true) {                                               # Outer loop for managing function
            :SetAzureKVCertIssuer while ($true) {                                           # Inner loop for setting the issuer name
                Write-Host 'Issuer name'                                                    # Write message to screen
                Write-Host '[0] Exit'                                                       # Write message to screen
                Write-Host '[1] Self'                                                       # Write message to screen
                Write-Host '[2] Custom issuer'                                              # Write message to screen
                $OpSelect = Read-Host 'Option [#]'                                          # Operator input for selecting the issuer name
                Clear-Host                                                                  # Clears screen
                if ($OpSelect -eq '0') {                                                    # If $OpSelect equals '0'
                    Break NewAzureKVCertPolicy                                              # Breaks :NewAzureKVCertPolicy
                }                                                                           # End if ($OpSelect -eq '0')
                elseif ($OpSelect -eq '1') {                                                # Else if $OpSelect equals '1'
                    $IssuerName = 'Self'                                                    # $IssuerName is equal to 'Self'
                    Break SetAzureKVCertIssuer                                              # Breaks :SetAzureKVCertIssuer
                }                                                                           # End elseif ($OpSelect -eq '1')
                elseif ($OpSelect -eq '2') {                                                # Else if $OpSelect equals '2'
                    Write-Host 'Enter the issuer name'                                      # Write message to screen
                    $IssuerName = Read-Host 'Name'                                          # Operator input for the issuer name
                    Write-Host 'Use'$IssuerName' as the issuer name'                        # Write message to screen
                    $OpConfirm = Read-Host '[Y] Yes [N] No [E] Exit'                        # Operator input for confriming the issuer name
                    Clear-Host                                                              # Clears screen
                    if ($OpConfirm -eq 'e') {                                               # If $OpConfirm equals 'e'
                        Break NewAzureKVCertPolicy                                          # Breaks :NewAzureKVCertPolicy
                    }                                                                       # End if ($OpConfirm -eq 'e')
                    elseif ($OpConfirm -eq 'y') {                                           # Else if $OpConfirm equals 'y'
                        Break SetAzureKVCertIssuer                                          # Breaks :SetAzureKVCertIssuer
                    }                                                                       # End elseif ($OpConfirm -eq 'y')
                    else {                                                                  # All other inputs for $OpConfirm
                    }                                                                       # End else (if ($OpConfirm -eq 'e'))
                }                                                                           # End elseif ($OpSelect -eq '2')
                else {                                                                      # All other options to for $OpSelect
                    Write-Host 'That was not a valid input'                                 # Write message to screen
                    Pause                                                                   # Pauses for operator input
                    Clear-Host                                                              # Clears screen
                }                                                                           # End else (if ($OpSelect -eq '0'))
            }                                                                               # End :SetAzureKVCertIssuer while ($true)
            :SetAzureKVCertType while ($true) {                                             # Inner loop for setting the cert type
                Write-Host 'Key Type'                                                       # Write message to screen
                Write-Host '[0] Exit'                                                       # Write message to screen
                Write-Host '[1] RSA'                                                        # Write message to screen
                Write-Host '[2] RSA-HSM'                                                    # Write message to screen
                Write-Host '[3] EC'                                                         # Write message to screen
                Write-Host '[4] EC-HSM'                                                     # Write message to screen
                $OpSelect = Read-Host 'Option [#]'                                          # Operator input for selecting the key type
                Clear-Host                                                                  # Clears screen
                if ($OpSelect -eq '0') {                                                    # If $OpSelect equals '0'
                    Break NewAzureKVCertPolicy                                              # Breaks :NewAzureKVCertPolicy
                }                                                                           # End if ($OpSelect -eq '0')
                elseif ($OpSelect -eq '1') {                                                # Else if $OpSelect equals '1'
                    $KeyType = 'RSA'                                                        # $KeyType is equal to 'RSA'
                    Break SetAzureKVCertType                                                # Breaks :SetAzureKVCertType
                }                                                                           # End elseif ($OpSelect -eq '1')
                elseif ($OpSelect -eq '2') {                                                # Else if $OpSelect equals '2'
                    $KeyType = 'RSA-HSM'                                                    # $KeyType is equal to 'RSA-HSM'
                    Break SetAzureKVCertType                                                # Breaks :SetAzureKVCertType
                }                                                                           # End elseif ($OpSelect -eq '2')
                elseif ($OpSelect -eq '3') {                                                # Else if $OpSelect equals '3'
                    $KeyType = 'EC'                                                         # $KeyType is equal to 'EC'
                    Break SetAzureKVCertType                                                # Breaks :SetAzureKVCertType
                }                                                                           # End elseif ($OpSelect -eq '3')
                elseif ($OpSelect -eq '4') {                                                # Else if $OpSelect equals '4'
                    $KeyType = 'EC-HSM'                                                     # $KeyType is equal to 'EC-HSM'
                    Break SetAzureKVCertType                                                # Breaks :SetAzureKVCertType
                }                                                                           # End elseif ($OpSelect -eq '4')
                else {                                                                      # All other options to for $OpSelect
                    Write-Host 'That was not a valid input'                                 # Write message to screen
                    Pause                                                                   # Pauses for operator input
                    Clear-Host                                                              # Clears screen
                }                                                                           # End else (if ($OpSelect -eq '0'))
            }                                                                               # End :SetAzureKVCertType while ($true)
            :SetAzureKVCertKeySize while ($true) {                                          # Inner loop for setting key size
                Write-Host 'Key Size'                                                       # Write message to screen
                Write-Host '[0] Exit'                                                       # Write message to screen
                Write-Host '[1] 4096'                                                       # Write message to screen
                Write-Host '[2] 3072'                                                       # Write message to screen
                Write-Host '[3] 2048'                                                       # Write message to screen
                Write-Host '[4] 521'                                                        # Write message to screen
                Write-Host '[5] 384'                                                        # Write message to screen
                Write-Host '[6] 256'                                                        # Write message to screen
                $OpSelect = Read-Host 'Option [#]'                                          # Operator input for selecting the key type
                Clear-Host                                                                  # Clears screen
                if ($OpSelect -eq '0') {                                                    # If $OpSelect equals '0'
                    Break NewAzureKVCertPolicy                                              # Breaks :NewAzureKVCertPolicy
                }                                                                           # End if ($OpSelect -eq '0')
                elseif ($OpSelect -eq '1') {                                                # If $OpSelct equals '1'
                    $KeySize = '4096'                                                       # Sets $KeySize
                    Break SetAzureKVCertKeySize                                             # Breaks :SetAzureKVCertKeySize
                }                                                                           # End elseif ($OpSelect -eq '1')
                elseif ($OpSelect -eq '2') {                                                # If $OpSelct equals '2'
                    $KeySize = '3072'                                                       # Sets $KeySize
                    Break SetAzureKVCertKeySize                                             # Breaks :SetAzureKVCertKeySize
                }                                                                           # End elseif ($OpSelect -eq '2')
                elseif ($OpSelect -eq '3') {                                                # If $OpSelct equals '3'
                    $KeySize = '2048'                                                       # Sets $KeySize
                    Break SetAzureKVCertKeySize                                             # Breaks :SetAzureKVCertKeySize
                }                                                                           # End elseif ($OpSelect -eq '3')
                elseif ($OpSelect -eq '4') {                                                # If $OpSelct equals '4'
                    $KeySize = '521'                                                        # Sets $KeySize
                    Break SetAzureKVCertKeySize                                             # Breaks :SetAzureKVCertKeySize
                }                                                                           # End elseif ($OpSelect -eq '4')
                elseif ($OpSelect -eq '5') {                                                # If $OpSelct equals '5'
                    $KeySize = '384'                                                        # Sets $KeySize
                    Break SetAzureKVCertKeySize                                             # Breaks :SetAzureKVCertKeySize
                }                                                                           # End elseif ($OpSelect -eq '5')
                elseif ($OpSelect -eq '6') {                                                # If $OpSelct equals '6'
                    $KeySize = '256'                                                        # Sets $KeySize
                    Break SetAzureKVCertKeySize                                             # Breaks :SetAzureKVCertKeySize
                }                                                                           # End elseif ($OpSelect -eq '6')
                else {                                                                      # All other options to for $OpSelect
                    Write-Host 'That was not a valid input'                                 # Write message to screen
                    Pause                                                                   # Pauses for operator input
                    Clear-Host                                                              # Clears screen
                }                                                                           # End else (if ($OpSelect -eq '0'))
            }                                                                               # End :SetAzureKVCertKeySize while ($true)
            :SetAzureKVCertKeyUse while ($true) {                                           # Inner loop for setting key use
                Write-Host 'Key Usage'                                                      # Write message to screen
                Write-Host '[0] Exit'                                                       # Write message to screen
                Write-Host '[1] None'                                                       # Write message to screen
                Write-Host '[2] EncipherOnly'                                               # Write message to screen
                Write-Host '[3] CrlSign'                                                    # Write message to screen
                Write-Host '[4] KeyCertSign'                                                # Write message to screen
                Write-Host '[5] KeyAgreement'                                               # Write message to screen
                Write-Host '[6] DataEncipherment'                                           # Write message to screen
                Write-Host '[7] KeyEncipherment'                                            # Write message to screen
                Write-Host '[8] NonRepudiation'                                             # Write message to screen
                Write-Host '[9] DigitalSignature'                                           # Write message to screen
                Write-Host '[A] DecipherOnly'                                               # Write message to screen
                $OpSelect = Read-Host 'Option [#]'                                          # Operator input for selecting the key type
                $KeyUsage = $null                                                           # Clears $KeyUsage
                Clear-Host                                                                  # Clears screen
                if ($OpSelect -eq '0') {                                                    # If $OpSelect equals '0'
                    Break NewAzureKVCertPolicy                                              # Breaks :NewAzureKVCertPolicy
                }                                                                           # End if ($OpSelect -eq '0')
                if ($OpSelect -eq '1') {                                                    # If $OpSelct equals '1'
                    $KeyUsage = 'None'                                                      # Sets $KeyUsage
                    Break SetAzureKVCertKeyUse                                              # Breaks :SetAzureKVCertKeyUse
                }                                                                           # End if ($OpSelect -eq '1')
                if ($OpSelect -like '*2*') {                                                # If $OpSelct equals '2'
                    $KeyUsage = $KeyUsage +',EncipherOnly'                                  # Sets $KeyUsage
                }                                                                           # End if ($OpSelect -like  '*2*'
                if ($OpSelect -like '*3*') {                                                # If $OpSelct equals '3'
                    $KeyUsage = $KeyUsage+',CRLSign'                                        # Sets $KeyUsage
                }                                                                           # End if ($OpSelect -like  '*3*')
                if ($OpSelect -like '*4*') {                                                # If $OpSelct equals '4'
                    $KeyUsage = $KeyUsage+',KeyCertSign'                                    # Sets $KeyUsage
                }                                                                           # End if ($OpSelect -like  '*4*')
                if ($OpSelect -like '*5*') {                                                # If $OpSelct equals '5'
                    $KeyUsage = $KeyUsage+',KeyAgreement'                                   # Sets $KeyUsage
                }                                                                           # End if ($OpSelect -like  '*5*')
                if ($OpSelect -like '*6*') {                                                # If $OpSelct equals '6'
                    $KeyUsage = $KeyUsage+',DataEncipherment'                               # Sets $KeyUsage
                }                                                                           # End if ($OpSelect -like  '*6*')
                if ($OpSelect -like '*7*') {                                                # If $OpSelct equals '7'
                    $KeyUsage = $KeyUsage+',KeyEncipherment'                                # Sets $KeyUsage
                }                                                                           # End if ($OpSelect -like  '*7*')
                if ($OpSelect -like '*8*') {                                                # If $OpSelct equals '8'
                    $KeyUsage = $KeyUsage+',NonRepudiation'                                 # Sets $KeyUsage
                }                                                                           # End if ($OpSelect -like  '*8*')
                if ($OpSelect -like '*9*') {                                                # If $OpSelct equals '9'
                    $KeyUsage = $KeyUsage+',DigitalSignature'                               # Sets $KeyUsage
                }                                                                           # End if ($OpSelect -like  '*9*')
                if ($OpSelect -eq 'A') {                                                    # If $OpSelct equals 'A'
                    $KeyUsage = 'DecipherOnly'                                              # Sets $KeyUsage
                    Break SetAzureKVCertKeyUse                                              # Breaks :SetAzureKVCertKeyUse
                }                                                                           # End if ($OpSelect -eq 'A')
                if (!$KeyUsage) {                                                           # If $KeyUsage is $null
                    Write-Host 'That was not a valid input'                                 # Write message to screen
                }                                                                           # End if (!$KeyUsage)
                else {                                                                      # If $KeyUsage has a value
                    $KeyUsage = $KeyUsage.Substring(1)                                      # Removes first ',' from $KeyUsage
                    Write-Host 'Current key use options:'$KeyUsage                          # Write message to screen
                    Write-Host 'Is this list correct'                                       # Write message to screen
                    $OpConfirm = Read-Host '[Y] Yes [N] No [E] Exit'                        # Operator confirmation of $KeyUsage
                    Clear-Host                                                              # Clears screen
                    if ($OpConfirm -eq 'e') {                                               # If $OpConfirm equals '0'
                        Break NewAzureKVCertPolicy                                          # Breaks :NewAzureKVCertPolicy
                    }                                                                       # End if ($OpConfirm -eq 'e')
                    elseif ($OpConfirm -eq 'y') {                                           # Else if $OpConfirm equals 'y'
                        Break SetAzureKVCertKeyUse                                          # Breaks :SetAzureKVCertKeyUse
                    }                                                                       # End elseif ($OpConfirm -eq 'y')
                }                                                                           # End else (if (!$KeyUsage))
            }                                                                               # End :SetAzureKVCertKeyUse while ($true)
            :SetAzureKVSContentType while ($true) {                                         # Inner loop for setting the secret content type
                Write-Host 'Secret Content Type'                                            # Write message to screen
                Write-Host '[0] Exit'                                                       # Write message to screen
                Write-Host '[1] x-pkcs12'                                                   # Write message to screen
                Write-Host '[2] x-pem-file'                                                 # Write message to screen
                $OpSelect = Read-Host 'Option [#]'                                          # Operator input for selecting the secret content type
                Clear-Host                                                                  # Clears screen
                if ($OpSelect -eq '0') {                                                    # If $OpSelect equals '0'
                    Break NewAzureKVCertPolicy                                              # Breaks :NewAzureKVCertPolicy
                }                                                                           # End if ($OpSelect -eq '0')
                elseif ($OpSelect -eq '1') {                                                # Else if $OpSelect equals '1'
                    $SecretContentType = 'application/x-pkcs12'                             # $SecretContentType is equal to 'application/x-pkcs12'
                    Break SetAzureKVSContentType                                            # Breaks :SetAzureKVSContentType
                }                                                                           # End elseif ($OpSelect -eq '1')
                elseif ($OpSelect -eq '1') {                                                # Else if $OpSelect equals '2'
                    $SecretContentType = 'application/x-pem-file'                           # $SecretContentType is equal to 'application/x-pem-file'
                    Break SetAzureKVSContentType                                            # Breaks :SetAzureKVSContentType
                }                                                                           # End elseif ($OpSelect -eq '2')
                else {                                                                      # All other options to for $OpSelect
                    Write-Host 'That was not a valid input'                                 # Write message to screen
                }                                                                           # End else (if ($OpSelect -eq '0'))
            }                                                                               # End :SetAzureKVSContentType while ($true)
            :SetAzureKVSubjectName while ($true) {                                          # Inner loop for setting the subject name
                Write-Host 'Enter the Subject name'                                         # Write message to screen
                $SubjectName = Read-Host 'Name'                                             # Operator input for the subjectname
                if ($SubjectName -notlike 'CN=*' -or $SubjectName -notlike 'O=*' ) {        # If $SubjectName does not start with 'CN=' or 'O='
                    :SetAzureKVSNType while ($true) {                                       # Inner loop for setting the subject name type
                        Write-Host '[0] Exit'                                               # Write message to screen
                        Write-Host '[1] Canonical Name'                                     # Write message to screen
                        Write-Host '[2] Organization Name'                                  # Write message to screen
                        $OpSelect = Read-Host 'Option [#]'                                  # Operator input for the subject name type
                        if ($OpSelect -eq '0') {                                            # If $OpSelect equals '0'
                            Break NewAzureKVCertPolicy                                      # Breaks :NewAzureKVCertPolicy
                        }                                                                   # End if ($OpSelect -eq '0')
                        elseif ($OpSelect -eq '1') {                                        # If $OpSelect equals '1'
                            if ($SubjectName -like '*.com' -or '*.org' -or '*.edu') {       # If $SubjectName ends with .com, .org, .edu
                            }                                                               # End if ($SubjectName -like '*.com' -or '*.org' -or '*.edu')
                            elseif ($SubjectName -like '*.gov' -or '*.mil') {               # If $SubjectName ends with .gov .mil
                            }                                                               # End elseif ($SubjectName -like '*.gov' -or '*.mil')
                            elseif ($SubjectName -like '*.*' -or '*,*') {                   # If $SubjectName has a '.' or ','
                                $SubjectName = '"'+$SubjectName+'"'                         # Adds quotes around $SubjectName
                            }                                                               # End if ($SubjectName -like '*.*' -or '*,*')    
                            $SubjectName = 'CN='+$SubjectName                               # Adds 'CN=' to the start of $Subjectname
                            Break SetAzureKVSNType                                          # Breaks :SetAzureKVSNType
                        }                                                                   # elseif ($OpSelect -eq '1')
                        elseif ($OpSelect -eq '2') {                                        # If $OpSelect equals '2'
                            if ($SubjectName -like '*.*' -or '*,*') {                       # If $SubjectName has a '.' or ','
                                $SubjectName = '"'+$SubjectName+'"'                         # Adds quotes around $SubjectName
                            }                                                               # End if ($SubjectName -like '*.*' -or '*,*')
                            $SubjectName = 'O='+$SubjectName                                # Adds 'O=' to the start of $Subjectname
                            Break SetAzureKVSNType                                          # Breaks :SetAzureKVSNType
                        }                                                                   # End elseif ($OpSelect -eq '2')
                        else {                                                              # All other inputs for $OpSelect
                            Write-Host 'That was not a valid option'                        # Write message to screen
                        }                                                                   # End else (if ($OpSelect -eq '0'))      
                    }                                                                       # End :SetAzureKVSNType while ($true)          
                }                                                                           # End if ($SubjectName -notlike 'CN=*')
                Write-Host 'Use'$SubjectName' as the subject name'                          # Write message to screen                                            
                $OpConfirm = Read-Host '[Y] Yes [N] No [E] Exit'                            # Operator confirmation of the subject name
                if ($OpConfirm -eq 'e') {                                                   # If $OpConfirm equals 'e'
                    Break NewAzureKVCertPolicy                                              # Breaks :NewAzureKVCertPolicy
                }                                                                           # End if ($OpConfirm -eq 'e')
                elseif ($OpConfirm -eq 'y') {                                               # Else if $OpConfirm equals 'y'
                    Clear-Host                                                              # Clears screen
                    Break SetAzureKVSubjectName                                             # Breaks :SetAzureKVSubjectName
                }                                                                           # End elseif ($OpConfirm -eq 'y')
                else {                                                                      # All other inputs for $OpConfirm
                    Clear-Host                                                              # Clears screen
                }                                                                           # End else (if ($OpConfirm -eq 'e'))
            }                                                                               # End :SetAzureKVSubjectName while ($true)
            Try {                                                                           # Try the following
                $Policy = New-AzKeyVaultCertificatePolicy -IssuerName $IssuerName -KeyType `
                    $KeyType -KeySize $KeySize -SecretContentType $SecretContentType `
                    -SubjectName $SubjectName -ValidityInMonths 6 -ReuseKeyOnRenewal    
                    -ErrorAction 'Stop'                                                     # Creates the cert policy
            }                                                                               # End try
            catch {                                                                         # If try fails
                Write-Host 'An error has occured'                                           # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break NewAzureKVCertPolicy                                                  # Breaks :NewAzureKVCertPolicy
            }                                                                               # End Catch
            Return $Policy                                                                  # Returns to calling function with $var
        }                                                                                   # End :NewAzureKVCertPolicy while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function NewAzKVCertificatePolicy
function ListAzKVCertificate {                                                              # Function to list key vault certs
    Begin {                                                                                 # Begin function
        $KVList = Get-AzKeyVault                                                            # Pulls a list of all key vaults
        foreach ($_ in $KVList) {                                                           # For each item in $KVList
            $KeyVaultName = $_.VaultName                                                    # $KeyVaultName is equal to current item .VaultName
            $CertList = Get-AzKeyVaultCertificate -VaultName $KeyVaultName                  # Pulls a list of all certs in $KeyVaultNAme
            Write-Host '------------------------------------------------------------------' # Write message to screen
            Write-Host 'Vault Name:'$KeyVaultName                                           # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            if (!$CertList) {                                                               # If $CertList is $null
                Write-Host 'No certs in this vault'                                         # Write message to screen
                Write-Host ''                                                               # Write message to screen
            }                                                                               # End if (!$CertList)
            else {                                                                          # If $CertList has a value
                foreach ($_ in $CertList) {                                                 # For each item in $CertList
                    Write-Host 'Name:       ' $_.name                                       # Write message to screen
                    Write-Host 'ID:         ' $_.ID                                         # Write message to screen
                    Write-Host 'Enabled:    ' $_.Enabled                                    # Write message to screen
                    Write-Host 'Created:    ' $_.Created                                    # Write message to screen
                    Write-Host 'Updated:    ' $_.Updated                                    # Write message to screen
                    Write-Host 'Not Before: ' $_.NotBefore                                  # Write message to screen
                    Write-Host 'Expires:    ' $_.Expires                                    # Write message to screen
                    if ($_.Version) {                                                       # If current item .version has a value
                        Write-Host 'Version:    ' $_.Version                                # Write message to screen
                    }                                                                       # End if ($_.Version)
                    Write-Host ''                                                           # Write message to screen
                }                                                                           # End foreach ($_ in $CertList)
            }                                                                               # End else (if (!$CertList))
            Write-Host '------------------------------------------------------------------' # Write message to screen
        }                                                                                   # End foreach ($_ in $KVList)
        Pause                                                                               # Pauses all actions for operator input
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function ListAzKVCertificate 
function GetAzKVCertificate {                                                               # Function to get a key vault certificate
    Begin {                                                                                 # Begin function
        if (!$CallingFunction) {                                                            # If $CallingFunction is $null
            $CallingFunction = 'GetAzKVCertificate'                                         # Creates $CallingFunction
        }                                                                                   # End if (!$CallingFunction)
        :GetAzureKVCertificate while ($true) {                                              # Outer loop for managing function
            $KeyVaultObject = GetAzKeyVault ($CallingFunction)                              # Calls function and assigns output to $var
            if (!$KeyVaultObject) {                                                         # If $KeyVaultObject is $null
                Break GetAzureKVCertificate                                                 # Breaks :GetAzureKVCertificate
            }                                                                               # End if (!$KeyVaultObject)
            $ObjectList = Get-AzKeyVaultCertificate -VaultName $KeyVaultObject.VaultName    # Gets a list of all certs in $KeyVaultObject
            if (!$ObjectList) {                                                             # If $ObjectList is $null
                Write-Host 'No certificates in:'$KeyVaultObject.VaultName                   # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break GetAzureKVCertificate                                                 # Breaks :GetAzureKVCertificate
            }                                                                               # End if (!$ObjectList)    
            $ObjectNumber = 1                                                               # Creates $ObjectNumber
            [System.Collections.ArrayList]$ObjectArray =@()                                 # Creates $ObjectArray
            foreach ($_ in $ObjectList) {                                                   # For each item in $ObjectList
                $ObjectInput = [PSCustomObject]@{'Number'=$ObjectNumber;'Name'=$_.Name; `
                    'ID'=$_.ID;'EN'=$_.Enabled;'CR'=$_.Created;'UP'=$_.Updated;`
                    'NB'=$_.NotBefore;'EX'=$_.Expires;'VER'=$_.Version}                     # Creates $ObjectInput
                $ObjectArray.Add($ObjectInput) | Out-Null                                   # Adds $ObjectInput to $ObjectArray
                $ObjectNumber = $ObjectNumber + 1                                           # Increases $ObjectNumber by 1
            }                                                                               # End foreach ($_ in $ObjectList)
            Write-Host '[0] Exit'                                                           # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            foreach ($_ in $ObjectArray) {                                                  # For each item in $ObjectArray
                $Number = $_.Number                                                         # Number is equal to current item .number
                if ($Number -le 9) {                                                        # If $Number is 9 or less
                    Write-Host "[$Number]         "$_.Name                                  # Write message to screen
                }                                                                           # End if ($Number -le 9)
                else {                                                                      # If $Number is more than 9
                    Write-Host "[$Number]        "$_.Name                                   # Write message to screen
                }                                                                           # End else (if ($Number -le 9))
                Write-Host 'ID:         ' $_.ID                                             # Write message to screen
                Write-Host 'Enabled:    ' $_.EN                                             # Write message to screen
                Write-Host 'Created:    ' $_.CR                                             # Write message to screen
                Write-Host 'Updated:    ' $_.UP                                             # Write message to screen
                Write-Host 'Not Before: ' $_.NB                                             # Write message to screen
                Write-Host 'Expires:    ' $_.EX                                             # Write message to screen
                if ($_.Ver) {                                                               # If current item .ver has a value
                    Write-Host 'Version:    ' $_.Ver                                        # Write message to screen
                }                                                                           # End if ($_.Ver)
                Write-Host ''                                                               # Write message to screen
            }                                                                               # End foreach ($_ in $ObjectArray)
            :SelectAzureKVCert while ($true) {                                              # Inner loop for selecting the certificate
                if ($CallingFunction -and $CallingFunction -ne 'GetAzKVCertificate') {      # If $CallingFunction has a value and is not 'GetAzKVCertificate'
                    Write-Host 'You are selecting the certificate for:'$CallingFunction     # Write message to screen
                }                                                                           # End if ($CallingFunction -and $CallingFunction -ne 'GetAzKVCertificate')
                $OpSelect = Read-Host 'Option [#]'                                          # Operator input to select the cert
                if ($OpSelect -eq '0') {                                                    # If $OpSelect equals '0'
                    Break GetAzureKVCertificate                                             # Breaks :GetAzureKVCertificate
                }                                                                           # End if ($OpSelect -eq '0')
                elseif ($OpSelect -in $ObjectArray.Number) {                                # Else if $OpSelect in $ObjectArray.Number
                    $OpSelect = $ObjectArray | Where-Object {$_.Number -eq $OpSelect}       # $OpSelect equals $ObjectArray where $OpSelect equals $ObjectArray.Number
                    $KeyVaultCertObject = Get-AzKeyVaultCertificate -VaultName `
                        $KeyVaultObject.VaultName -Name $OpSelect.name                      # Pulls the full key vault cert object
                    Clear-Host                                                              # Clears screen
                    Return $KeyVaultCertObject, $KeyVaultObject                             # Returns to calling function with $vars 
                }                                                                           # End elseif ($OpSelect -in $ObjectArray.Number)
                else {                                                                      # All other inputs for $OpSelect
                    Write-Host 'That was not a valid option'                                # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Write-Host ''                                                           # Write message to screen
                }                                                                           # End else (if ($OpSelect -eq '0'))
            }                                                                               # End :SelectAzureKVCert while ($true)
        }                                                                                   # End :GetAzureKVCertificate while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function GetAzKVCertificate
function DownloadAzKVCertificate {                                                          # Function to download a key vault certificate
    Begin {                                                                                 # Begin function
        if ($CallingFunction) {                                                             # If $CallingFunction is $null
            $CallingFunction = 'DownloadAzKVCertificate'                                    # Creates $CallingFunction
        }                                                                                   # End if ($CallingFunction)
        :DownloadAzureKVCert while ($true) {                                                # Outer loop for managing function
            $KeyVaultCertObject, $KeyVaultObject = GetAzKVCertificate ($CallingFunction)    # Calls function and assigns output to $var
            if (!$KeyVaultCertObject) {                                                     # If $KeyVaultCertObject is $null
                Break DownloadAzureKVCert                                                   # Breaks :DownloadAzureKVCert
            }                                                                               # End if (!$KeyVaultCertObject)
            Write-Host 'Certificate selected'                                               # Write message to screen
            Write-Host 'Please locate the matching key vault secret'                        # Write message to screen
            Pause
            $KVSV = GetAzKeyVaultSecretValue ($CallingFunction)                             # Calls function and assigns output to $var
            if (!$KVSV) {                                                                   # If $KVSV does not have a value
                Break DownloadAzureKVCert                                                   # Breaks :DownloadAzureKVCert
            }                                                                               # End if (!$KVSV)
            Write-Host 'Secret selected'                                                    # Write message to screen
            :GetDownloadPath while ($True) {                                                # Inner loop for setting the download path
                Write-Host 'Please enter the download path'                                 # Write message to screen
                Write-Host 'Example: C:\users\Admin\Downloads\'                             # Write message to screen
                $Localdownloadpath = Read-Host 'Path'                                       # Operator input for download path
                if ($Localdownloadpath -notlike '*\') {                                     # If $LocalDownloadPath does not end in '\'
                    $Localdownloadpath = $Localdownloadpath+'\'                             # Adds '\' to end of $LocalDownloadPath
                    if (Test-Path -Path $Localdownloadpath) {                               # If $LocalDownloadPath is valud
                        Break GetDownloadPath                                               # Breaks :GetDownloadPath
                    }                                                                       # End if (Test-Path -Path $Localdownloadpath)     
                    else {                                                                  # If $Localdownload path is not valid
                        Write-Host 'The path:'$Localdownloadpath                            # Write message to screen
                        Write-Host 'was not valid'                                          # Write message to screen
                        Pause                                                               # Pauses all actions for operator input
                        Clear-Host                                                          # Clears screen
                    }                                                                       # End else (if (Test-Path -Path $Localdownloadpath))
                }                                                                           # End if ($Localdownloadpath -notlike '*\')
            }                                                                               # End :GetDownloadPath while ($True)
            :GetDownloadName while ($true) {                                                # Inner loop for setting download name
                Write-Host 'Enter the filename'                                             # Write message to screen
                Write-Host 'Example: downloadedcert'                                        # Write message to screen
                $DownloadName = Read-Host 'Name'                                            # Operator input for file name
                Clear-Host                                                                  # Clears screen
                Write-Host 'Use:'$DownloadName 'as the file name'                           # Write message to screen
                $OpConfirm = Read-Host '[Y] Yes [N] No [E] Exit'                            # Operator confirmation of the file name
                if ($OpConfirm -eq 'e') {                                                   # If $OpConfirm equals 'e'
                    Break DownloadAzureKVCert                                               # Breaks :DownloadAzureKVCert
                }                                                                           # End if ($OpConfirm -eq 'e')
                elseif ($OpConfirm -eq 'y') {                                               # Else if $OpConfirm equals 'y'
                    Break GetDownloadName                                                   # Breaks :GetDownloadName
                }                                                                           # End elseif ($OpConfirm -eq 'y')
                else {                                                                      # All other inputs for $OpConfirm
                    Clear-Host                                                              # Clears screen
                }                                                                           # End else (if ($OpConfirm -eq 'e'))
            }                                                                               # End :GetDownloadName while ($true)
            $FullDownloadPath = $Localdownloadpath+$DownloadName+'.pfx'                     # Creates $FullDownloadPath
            Try {                                                                           # Try the following
                $secretByte = [Convert]::FromBase64String($KVSV)
                $x509Cert = New-Object System.Security.Cryptography.X509Certificates.X509Certificate2($secretByte, "", "Exportable,PersistKeySet")
                $type = [System.Security.Cryptography.X509Certificates.X509ContentType]::Pfx
                $pfxFileByte = $x509Cert.Export($type, $password)
                [System.IO.File]::WriteAllBytes($FullDownloadPath, $pfxFileByte)            # Writes cert to file
            }                                                                               # End try
            catch {                                                                         # If Try fails
                Write-Host 'An error has occured'                                           # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break DownloadAzureKVCert                                                   # Breaks :DownloadAzureKVCert
            }                                                                               # End catch
            Write-Host 'Download complete'                                                  # Write message to screen
            Write-Host 'Path:'$FullDownloadPath                                             # Write message to screen
            Pause                                                                           # Pauses all actions for operator input
            Break DownloadAzureKVCert                                                       # Breaks :DownloadAzureKVCert
        }                                                                                   # End :DownloadAzureKVCert while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function DownloadAzKVCertificate
function UpdateAzKVCertificate {                                                            # Function to update a key vault certificate
    Begin {                                                                                 # Begin function
        $ErrorActionPreference='silentlyContinue'                                           # Disables errors
        $WarningPreference = 'silentlyContinue'                                             # Disables key vault warnings
        if (!$CallingFunction) {                                                            # If $CallingFunction does not have a value
            $CallingFunction = 'UpdateAzKVCertificate'                                      # Creates $CallingFunction
        }                                                                                   # End if (!$CallingFunction)
        :UpdateAzureKVCertificate while ($true) {                                           # Outer loop for managing function
            $KeyVaultCertObject, $KeyVaultObject = GetAzKVCertificate ($CallingFunction)    # Calls function and assigns output to $Var
            if (!$KeyVaultCertObject) {                                                     # If $KeyVaultCertObject is $null
                Break UpdateAzureKVCertificate                                              # Breaks :UpdateAzureKVCertificate
            }                                                                               # End if (!$KeyVaultCertObject)
            Write-Host 'Update options'                                                     # Write message to screen
            Write-Host '[0] Exit'                                                           # Write message to screen
            if ($KeyVaultCertObject.Enabled -eq $True) {                                    # If $KeyVaultCertObject.Enabled is $true
                Write-Host '[1] Disable certificate'                                        # Write message to screen
            }                                                                               # End if ($KeyVaultCertObject.Enabled -eq $True) 
            else {                                                                          # If $KeyVaultCertObject.Enabled is not $true
                Write-Host '[1] Enable certificate'                                         # Write message to screen
            }                                                                               # End else (if ($KeyVaultCertObject.Enabled -eq $True))
            Write-Host '[2] Replace tags'                                                   # Write message to screen
            Write-Host '[3] Remove tags'                                                    # Write message to screen
            $OpSelect = Read-Host 'Option [#]'                                              # Operator input for selecting update function
            Clear-Host                                                                      # Clears screen
            if ($OpSelect -eq '0') {                                                        # If $OpSelect equals '0'
                Break UpdateAzureKVCertificate                                              # Breaks :UpdateAzureKVCertificate
            }                                                                               # End if ($OpSelect -eq '0')
            elseif ($OPSelect -eq '1' -and $KeyVaultCertObject.Enabled -eq $true) {         # If $OpSelect equals '1' $KeyVaultCertObject.Enabled is $true
                Try {                                                                       # Try the following
                    Write-Host 'Disabling:'$KeyVaultCertObject.Name                         # Write message to screen
                    Update-AzKeyVaultCertificate -VaultName $KeyVaultObject.VaultName `
                        -Name $KeyVaultCertObject.Name -Enable $false -ErrorAction 'Stop'   # Disables to cert
                }                                                                           # End try
                Catch {                                                                     # If Try fails
                    Write-Host 'There was an error while disabling the certificate'         # Write message to screen
                    Write-Host 'You may not have the permissions to do this'                # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Break UpdateAzureKVCertificate                                          # Breaks :UpdateAzureKVCertificate
                }                                                                           # End catch
                Write-Host 'Certificate has been disabled'                                  # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break UpdateAzureKVCertificate                                              # Breaks :UpdateAzureKVCertificate
            }                                                                               # End elseif ($OPSelect -eq '1' -and $KeyVaultCertObject.Enabled -eq $true)
            elseif ($OPSelect -eq '1' -and $KeyVaultCertObject.Enabled -eq $false) {        # If $OpSelect equals '1' $KeyVaultCertObject.Enabled is $false
                Try {                                                                       # Try the following
                    Write-Host 'Enabling:'$KeyVaultCertObject.Name                          # Write message to screen
                    Update-AzKeyVaultCertificate -VaultName $KeyVaultObject.VaultName `
                        -Name $KeyVaultCertObject.Name -Enable $true -ErrorAction 'Stop'    # Enables to cert
                }                                                                           # End try
                Catch {                                                                     # If Try fails
                    Write-Host 'There was an error while enabling the certificate'          # Write message to screen
                    Write-Host 'You may not have the permissions to do this'                # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Break UpdateAzureKVCertificate                                          # Breaks :UpdateAzureKVCertificate
                }                                                                           # End catch
                Write-Host 'Certificate has been enabled'                                   # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break UpdateAzureKVCertificate                                              # Breaks :UpdateAzureKVCertificate
            }                                                                               # End elseif ($OPSelect -eq '1' -and $KeyVaultCertObject.Enabled -eq $false)
            elseif ($OpSelect -eq '2') {                                                    # Else if $OpSelect equals '2'
                [System.Collections.ArrayList]$ObjectArray =@()                             # Creates $ObjectArray
                $ObjectNumber = 1                                                           # Creates $ObjectNumber
                :AddAzureKVCertTags while ($true) {                                         # Inner loop for setting the tags
                    :SetAzureKVCertTag while ($true) {                                      # Inner loop for adding a tag
                        Write-Host 'Replacement tag:'$ObjectNumber                          # Write message to screen
                        $TagName = Read-Host 'Name'                                         # Operator input for tag name
                        $TagValue = Read-Host 'Value'                                       # Operator input for tag value
                        Write-Host 'Add tag:'$TagName ':'$TagValue                          # Write message to screen
                        $OpConfirm = Read-Host '[Y] Yes [N] No [E] Exit'                    # Operator confirmation of the tag pair
                        Clear-Host                                                          # Clears screen
                        if ($OpConfirm -eq 'e') {                                           # If $OpConfirm equals 'e'
                            Break UpdateAzureKVCertificate                                  # Breaks :UpdateAzureKVCertificate
                        }                                                                   # End if ($OpConfirm -eq 'e')
                        elseif ($OpConfirm -eq 'y') {                                       # Else if $OpConfirm equals 'y'
                            $ObjectItem = [PSCustomObject]@{'Name'=$TagName;`
                            'Value'=$TagValue}                                              # Adds $TagName and $TagValue to $ObjectItem
                            $ObjectArray.Add($ObjectItem) | Out-Null                        # Adds $Objectitem to $ObjectArray
                            $ObjectNumber = $ObjectNumber + 1                               # Increments $ObjectNumber up by 1
                            Break SetAzureKVCertTag                                         # Breaks :SetAzureKVCertTag
                        }                                                                   # End elseif ($OpConfirm -eq 'y')
                        else {                                                              # All other inputs for $OpConfirm
                            Break SetAzureKVCertTag                                         # Breaks :SetAzureKVCertTag
                        }                                                                   # End else (if ($OpConfirm -eq 'e'))
                    }                                                                       # End :SetAzureKVCertTag while ($true)
                    :ReviewAzureKVCertTags while ($true) {                                  # Inner loop for reviewing tags
                        Write-Host 'Current tags'                                           # Write message to screen
                        foreach ($_ in $ObjectArray) {                                      # For each item in $ObjectArray
                            Write-Host $_.Name ':'$_.Value                                  # Write message to screen
                        }                                                                   # End foreach ($_ in $ObjectArray)
                        Write-Host $ObjectArray
                        Write-Host ''                                                       # Write message to screen
                        Write-Host '[0] Exit'                                               # Write message to screen
                        Write-Host '[1] Add additional tag'                                 # Write message to screen
                        Write-Host '[2] Save current tags to certificate'                   # Write message to screen
                        $OpSelect = Read-Host 'Option [#]'                                  # Operator input for next action
                        Clear-Host                                                          # Clears screen
                        if ($OpSelect -eq '0') {                                            # If $OpSelect equals '0'
                            Break UpdateAzureKVCertificate                                  # Breaks :UpdateAzureKVCertificate
                        }                                                                   # End if ($OpSelect -eq '0')
                        elseif ($OpSelect -eq '1') {                                        # Else if $OpSelect equals '1'
                            Break ReviewAzureKVCertTags                                     # Breaks :ReviewAzureKVCertTags
                        }                                                                   # End elseif ($OpSelect -eq '1')
                        elseif ($OpSelect -eq '2') {                                        # Else if $OpSelect equals '2'
                            Break AddAzureKVCertTags                                        # Breaks :AddAzureKVCertTags
                        }                                                                   # End elseif ($OpSelect -eq '2')
                        
                        else {                                                              # All other inputs for $OpSelect
                            Write-Host 'That was not a valid option'                        # Write message to screen
                            Pause                                                           # Pauses all actions for operator input
                            Clear-Host                                                      # Clears screen
                        }                                                                   # End if ($OpSelect -eq '0')
                    }                                                                       # End :ReviewAzureKVCertTags while ($true)
                }                                                                           # End :AddAzureKVCertTags while ($true)
                $Tags = @{}                                                                 # Creates $Tags hash table
                foreach ($_ in $ObjectArray) {                                              # For each item in $ObjectArray
                    $Name = $_.name                                                         # Isolates current item .name
                    $Value = $_.Value                                                       # Isolates current item .value
                    $tags.add($Name,$Value)                                                 # Adds $Name and $value to $Tags
                }                                                                           # End foreach ($_ in $ObjectArray)
                Try {                                                                       # Try the following
                    Write-Host 'Adding tags to:'$KeyVaultCertObject.name                    # Write message to screen
                    Update-AzKeyVaultCertificate -VaultName $KeyVaultObject.VaultName `
                        -Name $KeyVaultCertObject.Name -Tag $Tags -PassThru `
                        -ErrorAction 'Stop'                                                 # Replaces the current tag list
                }                                                                           # End try
                Catch {                                                                     # If try fails
                    Write-Host 'An error occured while modifing the tags'                   # Write message to screen
                    Write-Host 'You may not have the permissions to do this'                # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Break UpdateAzureKVCertificate                                          # Breaks :UpdateAzureKVCertificate
                }                                                                           # End catch
                Write-Host 'Tags have been updated'                                         # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break UpdateAzureKVCertificate                                              # Breaks :UpdateAzureKVCertificate
            }                                                                               # End elseif ($OpSelect -eq '2')
            elseif ($OpSelect -eq '3') {                                                    # Else if $OpSelect equals '3'
                Write-Host 'Remove the following tags from:'$KeyVaultCertObject.name        # Write message to screen
                [System.Collections.ArrayList]$KeyArray =@()                                # Creates $KeyArray
                [System.Collections.ArrayList]$ValueArray =@()                              # Creates $ValueArray
                $ObjectNumber = 1                                                           # Creates $ObjectNumber
                $CurrentTags = $KeyVaultCertObject.Tags                                     # Isolates the tags
                $CurrentKeys = $CurrentTags.Keys                                            # Isolates the tag keys
                $CurrentValues = $CurrentTags.Values                                        # Isolates the tags values
                foreach ($_ in $CurrentKeys) {                                              # For each item in $CurrentKeys
                    $KeyAdd = [PSCustomObject]@{'Number'=$ObjectNumber;'Name'=$_}           # Creates $KeyAdd
                    $KeyArray.Add($KeyAdd) | Out-Null                                       # Adds $KeyAdd to $KeyArray
                    $ObjectNumber = $ObjectNumber + 1                                       # Increments $ObjectNumber up by 1
                }                                                                           # End foreach ($_ in $CurrentKeys)
                $ObjectNumber = 1                                                           # Resets $ObjectNumber to 1
                foreach ($_ in $CurrentValues) {                                            # For each item in $CurrentValues
                    $ValueAdd = [PSCustomObject]@{'Number'=$ObjectNumber;'Value'=$_}        # Creates $ValueAdd
                    $ValueArray.Add($ValueAdd) | Out-Null                                   # Adds $ValueAdd to $ValueArray
                    $ObjectNumber = $ObjectNumber + 1                                       # Increments $ObjectNumber up by 1     
                }                                                                           # End foreach ($_ in $CurrentValues)
                foreach ($_ in $KeyArray) {                                                 # For each item in $KeyArray
                    $Key = $_                                                               # Pulls current item into $Key
                    $Number = $Key.Number                                                   # Isolates $Key.Number
                    $Value = $ValueArray | Where-Object {$_.Number -eq $Number}             # Value is equal to $ValueArray where $ValueArray.Number equals $number
                    Write-Host $Key.Name':' $Value.Value                                    # Write message to screen
                }                                                                           # End foreach ($_ in $KeyArray)
                $OpConfirm = Read-Host '[Y] Yes [N] No'                                     # Operator confirmation to remove the tags
                Clear-Host                                                                  # Clears screen
                if ($OpConfirm -eq 'y') {                                                   # If $OpConfrim equals 'y'
                    $Tags = @{}                                                             # Creates $Tags hash table
                    Try {                                                                   # Try the following
                        Write-Host 'Removing tags from:'$KeyVaultCertObject.name            # Write message to screen
                        Update-AzKeyVaultCertificate -VaultName $KeyVaultObject.VaultName `
                            -Name $KeyVaultCertObject.Name -Tag $Tags -PassThru `
                            -ErrorAction 'Stop'                                             # Replaces the current tag list
                    }                                                                       # End try
                    Catch {                                                                 # If try fails
                        Write-Host 'An error occured while modifing the tags'               # Write message to screen
                        Write-Host 'You may not have the permissions to do this'            # Write message to screen
                        Pause                                                               # Pauses all actions for operator input
                        Break UpdateAzureKVCertificate                                      # Breaks :UpdateAzureKVCertificate
                    }                                                                       # End catch
                    Write-Host 'Tags have been removed'                                     # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Break UpdateAzureKVCertificate                                          # Breaks :UpdateAzureKVCertificate
                }                                                                           # End if ($OpConfirm -eq 'y')
                else {                                                                      # All other inputs for $OpConfirm
                    Break UpdateAzureKVCertificate                                          # Breaks :UpdateAzureKVCertificate
                }                                                                           # End else (if ($OpConfirm -eq 'y'))
            }                                                                               # End elseif ($OpSelect -eq '3')
        }                                                                                   # End :UpdateAzureKVCertificate while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function UpdateAzKVCertificate
function RemoveAzKVCertificate {                                                            # Function to remove a key vault certificate
    Begin {                                                                                 # Begin function
        $ErrorActionPreference='silentlyContinue'                                           # Disables errors
        $WarningPreference = 'silentlyContinue'                                             # Disables key vault warnings
        if (!$CallingFunction) {                                                            # If $CallingFunction does not have a value
            $CallingFunction = 'RemoveAzKVCertificate'                                      # Creates $CallingFunction
        }                                                                                   # End if (!$CallingFunction)
        :RemoveAzureKVCertificate while ($true) {                                           # Outer loop for managing function
            $KeyVaultCertObject, $KeyVaultObject = GetAzKVCertificate ($CallingFunction)    # Calls function and assigns output to $Var
            if (!$KeyVaultCertObject) {                                                     # If $KeyVaultCertObject is $null
                Break RemoveAzureKVCertificate                                              # Breaks :RemoveAzureKVCertificate
            }                                                                               # End if (!$KeyVaultCertObject)
            Write-host ''                                                                   # Write message to screen
            Write-host 'Remove:    '$KeyVaultCertObject.Name                                # Write message to screen
            Write-Host 'From vault:'$KeyVaultCertObject.VaultName                           # Write message to screen
            Write-host ''                                                                   # Write message to screen
            $OpConfirm = Read-Host '[Y] Yes [N] No'                                         # Operator confirmation to delete 
            Clear-Host                                                                      # Clears screen
            if ($OpConfirm -eq 'y') {                                                       # If $OpConfirm equals 'y'
                Write-Host 'Removing' $KeyVaultCertObject.Name                              # Write message to screen
                Try {                                                                       # Try the following
                    Remove-AzKeyVaultCertificate -Name $KeyVaultCertObject.Name -VaultName `
                        $KeyVaultCertObject.VaultName -Force -ErrorAction 'Stop'            # Removes the selected cert
                }                                                                           # End Try
                catch {                                                                     # If try fails
                    Write-Host 'There was an issue removing the selected cert'              # Write message to screen
                    Write-Host 'You may not have the permissions to remove this cert'       # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Break RemoveAzureKVCertificate                                          # Breaks :RemoveAzureKVCertificate 
                }                                                                           # End catch
                Write-Host 'The certificate has been removed'                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break RemoveAzureKVCertificate                                              # Breaks :RemoveAzureKVCertificate
            }                                                                               # End if ($OpConfirm -eq 'y')
            else {                                                                          # If $OpConfirm is not equal to 'y'
                Write-Host 'No action taken'                                                # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break RemoveAzureKVCertificate                                              # Breaks :RemoveAzureKVCertificate
            }                                                                               # End else (if ($OpConfirm -eq 'y'))
        }                                                                                   # End :RemoveAzureKVCertificate while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function RemoveAzKVCertificate
# End ManageAzKVCertificate
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
# End ManageAzStorage
# Additional functions for ManageAzStorage
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