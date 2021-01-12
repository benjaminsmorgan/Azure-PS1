# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Mircosoft docs links
    Get-AzStorageBlob:          https://docs.microsoft.com/en-us/powershell/module/az.storage/get-azstorageblob?view=azps-5.3.0
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
    ListAzStorageBlobs:         Gets blob(s) information
    GetAzStorageAccount:        Collects the storage account object
    GetAzStorageContainer:      Collects storage container in a storage account  
    GetAzResourceGroup:         Collects resource group object
} #>
<# Variables: {
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
} #>
<# Process Flow {
    function
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
            Return function > Send $StorageBlobObject
}#>
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