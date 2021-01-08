# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Mircosoft docs links
    Set-AzStorageBlobContent:   https://docs.microsoft.com/en-us/powershell/module/az.storage/set-azstorageblobcontent?view=azps-5.3.0
    Get-AzStorageAccount:       https://docs.microsoft.com/en-us/powershell/module/az.storage/get-azstorageaccount?view=azps-5.2.0
    Get-AzStorageContainer:     https://docs.microsoft.com/en-us/powershell/module/az.storage/get-azstoragecontainer?view=azps-5.2.0
    Get-AzResourceGroup:        https://docs.microsoft.com/en-us/powershell/module/az.resources/get-azresourcegroup?view=azps-5.1.0
} #>
<# Required Functions Links: {
    GetAzStorageAccount:        https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Storage/Storage%20Account/GetAzStorageAccount.ps1
    GetAzStorageContainer:      https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Storage/Storage%20Account/Containers/GetAzStorageContainer.ps1
    GetAzResourceGroup:         https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/GetAzResourceGroup.ps1
} #>
<# Functions Description: {
    SetAzStorageBlobContent:    Uploads new blobs
    GetAzStorageAccount:        Collects the storage account object
    GetAzStorageContainer:      Collects storage container in a storage account  
    GetAzResourceGroup:         Collects resource group object
} #>
<# Variables: {
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
} #>
<# Process Flow {
    function
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
            Return function > Send $StorageBlobObject
}#>
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