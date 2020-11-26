function GetAzStorageBlob {
    Begin {
        $StorageAccount = GetAzStorageAccount
        $StorageContainer = GetAzStorageContainer ($StorageAccount)
        Write-Host $StorageContainer
        Write-Host $StorageAccount
        Write-Host $RGObject
        Get-AzStorageBlob -Context $StorageAccount.context -Container $StorageContainer.Name

    }
}
function GetAzStorageContainer {
    Begin {
        $ErrorActionPreference='silentlyContinue'
        #$StorageAccount = GetAzStorageAccount
        $StorageContainer = $null
        while (!$StorageContainer) {
            $StorageContainerInput = Read-Host "Storage container name"
            $StorageContainer = Get-AzStorageContainer -Context $StorageAccount.Context -Name $StorageContainerInput
            if (!$StorageContainer) {
                Write-Host "The name provided does not match an existing storage container"
                Write-Host "This is the list of available storage containers"
                $SCList = Get-AzStorageContainer -Context $StorageAccount.Context  
                Write-Host ""
                Write-Host $SCList.Name -Separator `n
                Write-Host ""
            }
            else {
                Write-host $StorageContainer
            }
        }
        Return $StorageContainer
    }
}
function GetAzStorageAccount {
    Begin {
        $ErrorActionPreference ='silentlyContinue'
        $RGObject = GetAzResourceGroup
        $StorageAccount = $null
        while (!$StorageAccount) {
            $StorageAccountInput = Read-Host "Storage account name"
            $StorageAccount = Get-AzStorageAccount -ResourceGroupName $RGObject.ResourceGroupName -Name $StorageAccountInput
            if (!$StorageAccount) {
                Write-Host "The name provided does not match an existing storage account"
                Write-Host "This is the list of available storage accounts"
                $SAList = Get-AzStorageAccount -ResourceGroupName $RGObject.ResourceGroupName
                Write-Host ""
                Write-Host $SAList.Storageaccountname -Separator `n
                Write-Host ""
            }
            else {
                $StorageAccount
            }
        }
        Return
    }
}
function GetAzResourceGroup {
    Begin {
        $ErrorActionPreference='silentlyContinue'
        $RGObject = $null
        while (!$RGObject) {
            $RGObjectInput = Read-Host "Resource group name"
            $RGObject = Get-AzResourceGroup -Name $RGObjectInput
            if (!$RGObject) {
                Write-Host "The name provided does not match an existing resource group"
                Write-Host "This is the list of available resource groups"
                $RGList = Get-AzResourceGroup
                Write-Host ""
                Write-Host $RGList.ResourceGroupName -Separator `n
                Write-Host ""
            }
            else {
                $RGObject | Select-Object ResourceGroupName, Tags | Format-Table
            }
        }
        Return $RGObject
    }
}