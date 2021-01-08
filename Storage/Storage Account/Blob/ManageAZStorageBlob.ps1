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
        $ManageAzStorageBlob:       Operator input for choosing a management function
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
            $LocalFileNameInput:        Operator input for the local file path and file name
            $OperatorConfirm:           Operator confirmation that info is correct
            $BlobFileNameInput:         Operator input for the blob name in azure
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
            $OperatorConfirm:           Operator confirmation that info is correct
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