# Benjamin Morgan benjamin.s.morgan@outlook.com 
# Ref: https://docs.microsoft.com/en-us/azure/storage/blobs/storage-quickstart-blobs-powershell
# $RGInput
# $RGObject
# $StorageContextInput
# $StorageContext
# $StorageContainerInput
# $StorageContainer
# $SkipRG
# $SkipContext
# $SkipContainer
# $SkipTier
# $SetTier
# $LocalFile
# $Anotherfile
function SetAzStoreBlobContent {
    Begin {
        if (!$SkipRG) {
            $RGInput = Read-Host "Resource Group Name"
            $RGObject = Get-AzResourceGroup -Name $RGInput
            if (!$RGObject) {
                Write-Host "The name entered for the resource group does not match, please select from the following names"
                Get-AzResourceGroup | Select-Object ResourceGroupName | Format-Table
                SetAzStoreBlobContent
            }
            else {
                $SkipRG = "Yes"
            }
        }
        if (!$SkipContext) {
            $StorageContextInput = Read-Host "Enter the name of the storage account"
            $StorageContext = Get-AzStorageAccount -ResourceGroupName $RGObject.ResourceGroupName -Name $StorageContextInput
            if (!$StorageContext) {
                Write-Host "The name entered for the storage account does not match, please select from the following names"
                Get-AzStorageAccount -ResourceGroupName $RGObject.ResourceGroupName | Select-Object StorageAccountName | Format-Table
                SetAzStoreBlobContent
            }
            else {
                $SkipContext = "Yes"
            }
        }
        if (!$SkipContainer) {
            $StorageContainerInput = Read-Host "Enter the name of the container"
            $StorageContainer = Get-AzStorageContainer -Context $StorageContext.Context -Name $StorageContainerInput
            if (!$StorageContainer) {
                Write-Host "The name entered for the storage container does not match, please select from the following names"
                Get-AzStorageContainer -Context $StorageContext.Context | Select-Object Name | Format-Table
                SetAzStoreBlobContent
            }
            else {
                $SkipContainer = "Yes"
            }
        }
        if (!$SkipTier) {
            $SetTier = Read-Host "Hot or Cool"
            if ($SetTier -eq "Hot" -or $SetTier -eq "Cool") {
                $SkipTier = "Yes"
            }
            else {
                Write-Host "Invalid input"
                SetAzStoreBlobContent
            }
        }
        $LocalFile = Read-Host "Full path and filename"
        $BlobFilename = Read-Host "New name and ext for this file"
        Set-AzStorageBlobContent -File $LocalFile -Blob $BlobFilename -Container $StorageContainer.Name -Context $StorageContext.Context -StandardBlobTier $SetTier
        $Anotherfile = Read-Host "Upload another file to this container"
        if ($Anotherfile -eq "y" -or $Anotherfile -eq "Yes") {
            SetAzStoreBlobContent
        }
        $AnotherContainer = Read-Host "Upload a file to a different container"
        if ($AnotherContainer -eq "y" -or $AnotherContainer -eq "Yes") {
            $SkipRG = $null
            $SkipContext = $null
            $SkipContainer = $null
            $SkipTier = $null
            SetAzStoreBlobContent
        }
        else {
            Write-Host "Ending script"
            Break
        }
    } 
}