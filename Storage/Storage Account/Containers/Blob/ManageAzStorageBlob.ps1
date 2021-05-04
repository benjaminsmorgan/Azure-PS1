# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Mircosoft docs links
    Set-AzStorageBlobContent:   https://docs.microsoft.com/en-us/powershell/module/az.storage/set-azstorageblobcontent?view=azps-5.3.0
    Get-AzStorageBlob:          https://docs.microsoft.com/en-us/powershell/module/az.storage/get-azstorageblob?view=azps-5.3.0
    Get-AzStorageBlobContent:   https://docs.microsoft.com/en-us/powershell/module/az.storage/get-azstorageblobcontent?view=azps-5.3.0
    Remove-AzStorageBlob:       https://docs.microsoft.com/en-us/powershell/module/az.storage/remove-azstorageblob?view=azps-5.3.0
    Get-AzStorageAccount:       https://docs.microsoft.com/en-us/powershell/module/az.storage/get-azstorageaccount?view=azps-5.2.0
    Get-AzStorageContainer:     https://docs.microsoft.com/en-us/powershell/module/az.storage/get-azstoragecontainer?view=azps-5.2.0
    Get-AzResourceGroup:        https://docs.microsoft.com/en-us/powershell/module/az.resources/get-azresourcegroup?view=azps-5.1.0
} #>
<# Required Functions Links: {
    SetAzStorageBlobContent:    https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Storage/Storage%20Account/Blob/SetAzStorageBlobContent.ps1
    ListAzStorageBlobs:         https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Storage/Storage%20Account/Blob/ListAzStorageBlobs.ps1
    GetAzStorageBlobContent:    https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Storage/Storage%20Account/Blob/GetAzStorageBlobContent.ps1
    RemoveAzStorageBlob:        https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Storage/Storage%20Account/Blob/RemoveAzStorageBlob.ps1
    GetAzStorageAccount:        https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Storage/Storage%20Account/GetAzStorageAccount.ps1
    GetAzStorageContainer:      https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Storage/Storage%20Account/Containers/GetAzStorageContainer.ps1
    GetAzResourceGroup:         https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/GetAzResourceGroup.ps1
} #>
<# Functions Description: {
    ManageAzStorageBlob:        Manages storage blob functions
    SetAzStorageBlobContent:    Uploads new blobs
    ListAzStorageBlobs:         Gets blob(s) information
    GetAzStorageBlobContent:    Downloads existing blob(s)
    RemoveAzStorageBlob:        Removes blobs from Azure
    GetAzStorageAccount:        Collects the storage account object
    GetAzStorageContainer:      Collects storage container in a storage account  
    GetAzResourceGroup:         Collects resource group object
} #>
<# Variables: {
    ManageAzStorageBlob {
        :ManageAzureStorageBlob     Outer loop for managing function
        $OpSelect:       Operator input for choosing a management function
        $StorageBlobObject:         Storage blob object or objects
        $StorageAccObject:          Storage account for the container holding the blobs
        $StorageConObject:          Storage container holding the blobs
        $RGObject:                  Resource group object holding the storage account
        SetAzStorageBlobContent {
            :SetAzureBlobContent        Outer loop for managing function
            :SetAzureBlobTier           Inner loop for setting a new blob access tier
            :SetLocalFileName           Inner loop for setting the local machine file path
            :SetAzureBlobName           Inner loop for setting the file name and ext in azure
            $StorageConObject:          Storage container holding the blobs
            $StorageAccObject:          Storage account for the container holding the blobs
            $BlobTierInput:             Operator input for the access tier
            $LocalFilePath:        Operator input for the local file path and file name
            $OpConfirm:           Operator confirmation that info is correct
            $BlobFileName:         Operator input for the blob name in azure
            $StorageBlobObject:         Storage blob object or objects
            GetAzStorageContainer{
                :GetAzureStorageContainer   Outer loop for managing function
                :GetAzureStorageConName     Inner loop for getting the storage container
                $StorageAccObject:          Storage account object    
                $StorageConNameInput:       Operator input for the storage container name
                $StorageConObject:          Storage container object
                $StorageConList:            List of all containers in storage account
                GetAzStorageAccount{
                    :GetAzureStorageAccByName   Outer loop for managing funciton
                    :GetAzureStorageAcc         Inner loop for getting the storage account
                    $RGObject:                  Resource group object
                    $StorageAccObjectInput:     Operator input for the name of the storage account
                    $SAList:                    List of all storage accounts within $RGObject
                    $StorageAccObject:          Storage account object    
                    GetAzResourceGroup {
                        $RGObject:                  Resource group object
                        $RGObjectInput:             Operator input for the resource group name
                        $RGList:                    Variable used for printing all resource groups to screen if needed
                    } End GetAzResourceGroup
                } End GetAzStorageAccount
            } End GetAzStorageContainer
        } End SetAzStorageBlobContent
        ListAzStorageBlob {
            :ListAzureBlobs             Outer loop for managing function
            $StorageConObject:          Storage container holding the blobs
            $StorageAccObject:          Storage account for the container holding the blobs
            $OperatorSelect:            Operator input for blob object selection
            $StorageBlobNameInput:      Operator input for blob name
            $StorageBlobList:           List of all blobs in container
            $StorageBlobObject:         Storage blob object or objects
            GetAzStorageContainer{
                :GetAzureStorageContainer   Outer loop for managing function
                :GetAzureStorageConName     Inner loop for getting the storage container
                $StorageAccObject:          Storage account object    
                $StorageConNameInput:       Operator input for the storage container name
                $StorageConObject:          Storage container object
                $StorageConList:            List of all containers in storage account
                GetAzStorageAccount{
                    :GetAzureStorageAccByName   Outer loop for managing funciton
                    :GetAzureStorageAcc         Inner loop for getting the storage account
                    $RGObject:                  Resource group object
                    $StorageAccObjectInput:     Operator input for the name of the storage account
                    $SAList:                    List of all storage accounts within $RGObject
                    $StorageAccObject:          Storage account object    
                    GetAzResourceGroup {
                        $RGObject:                  Resource group object
                        $RGObjectInput:             Operator input for the resource group name
                        $RGList:                    Variable used for printing all resource groups to screen if needed
                    } End GetAzResourceGroup
                } End GetAzStorageAccount
            } End GetAzStorageContainer
        } End ListAzStorageBlob
        GetAzStorageBlobContent {
            :GetAzureBlobs              Outer loop for managing function
            :SetLocalFilePath           Inner loop for setting the download path
            $StorageBlobObject:         Storage blob object or objects
            $StorageAccObject:          Storage account for the container holding the blobs
            $StorageConObject:          Storage container holding the blobs
            $LocalFileDownloadPath:     Operator input for the file path blob will be downloaded to
            $OpConfirm:           Operator confirmation that info is correct
            GetAzStorageContainer{
                :GetAzureStorageContainer   Outer loop for managing function
                :GetAzureStorageConName     Inner loop for getting the storage container
                $StorageAccObject:          Storage account object    
                $StorageConNameInput:       Operator input for the storage container name
                $StorageConObject:          Storage container object
                $StorageConList:            List of all containers in storage account
                GetAzStorageAccount{
                    :GetAzureStorageAccByName   Outer loop for managing funciton
                    :GetAzureStorageAcc         Inner loop for getting the storage account
                    $RGObject:                  Resource group object
                    $StorageAccObjectInput:     Operator input for the name of the storage account
                    $SAList:                    List of all storage accounts within $RGObject
                    $StorageAccObject:          Storage account object    
                    GetAzResourceGroup {
                        $RGObject:                  Resource group object
                        $RGObjectInput:             Operator input for the resource group name
                        $RGList:                    Variable used for printing all resource groups to screen if needed
                    } End GetAzResourceGroup
                } End GetAzStorageAccount
            } End GetAzStorageContainer
        } End GetAzStorageBlobContent
        RemoveAzStorageBlob {
            :RemoveAzureBlobs           Outer loop for managing function
            $StorageBlobObject:         Storage blob object or objects
            $StorageAccObject:          Storage account for the container holding the blobs
            $StorageConObject:          Storage container holding the blobs
            $ConfirmDelete:             Operator confirmation for deletion
            GetAzStorageContainer{
                :GetAzureStorageContainer   Outer loop for managing function
                :GetAzureStorageConName     Inner loop for getting the storage container
                $StorageAccObject:          Storage account object    
                $StorageConNameInput:       Operator input for the storage container name
                $StorageConObject:          Storage container object
                $StorageConList:            List of all containers in storage account
                GetAzStorageAccount{
                    :GetAzureStorageAccByName   Outer loop for managing funciton
                    :GetAzureStorageAcc         Inner loop for getting the storage account
                    $RGObject:                  Resource group object
                    $StorageAccObjectInput:     Operator input for the name of the storage account
                    $SAList:                    List of all storage accounts within $RGObject
                    $StorageAccObject:          Storage account object    
                    GetAzResourceGroup {
                        $RGObject:                  Resource group object
                        $RGObjectInput:             Operator input for the resource group name
                        $RGList:                    Variable used for printing all resource groups to screen if needed
                    } End GetAzResourceGroup
                } End GetAzStorageAccount
            } End GetAzStorageContainer
        } End RemoveAzStorageBlob
    } End  ManageAzStorageBlob 
} #>
<# Process Flow {
    function
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
            Return Function > Send $null
}#>
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
}                                                                                           # End function RemoveAzStorageBlob
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
# Additional functions required for ManageAzStorgeBlob
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