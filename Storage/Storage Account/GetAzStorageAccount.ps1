function GetAzStorageAccount {
    Begin {
        #$ErrorActionPreference ='silentlyContinue'
        $RGObject = GetAzResourceGroup
        $StorageAccount = $null
        while (!$StorageAccount) {
            $StorageAccountInput = Read-Host "Storage account name"
            $StorageAccount = Get-AzStorageAccount -ResourceGroupName $RGObject.ResourceGroupName -Name $StorageAccountInput
            if (!$StorageAccount) {
                Write-Host "The name provided does not match an existing storage account"
                $SAList = Get-AzStorageAccount -ResourceGroupName $RGObject.ResourceGroupName
                Write-Host $SAList.Storageaccountname -Separator `n
            }
            else {
                $StorageAccount
            }
        }
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
                Write-Host $RGList.ResourceGroupName -Separator `n
            }
            else {
                $RGObject | Select-Object ResourceGroupName, Tags | Format-Table
            }
        }
        Return $RGObject
    }
}