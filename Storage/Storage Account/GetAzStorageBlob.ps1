function GetAzStorageBlob {
    Begin {
        $StorageContainer = GetAzStorageContainer
        Get-AzStorageBlob -Context $StorageContainer.context

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
                Get-AzStorageAccount | Select-Object Storageaccountname | Format-Table
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
                Get-AzResourceGroup | Select-Object ResourceGroupName | Format-Table
            }
            else {
                $RGObject | Select-Object ResourceGroupName, Tags | Format-Table
            }
        }
        Return $RGObject
    }
}