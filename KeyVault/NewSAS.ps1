# 
# 
# $StoreContext
# $StoreAccountInput
# $StoreAccount
# $SASToken
# $TokenStart
# $TokenEnd
# $KVaultInput
# $KVault
# $SASName
function FunctionName {
    Begin {
        $RGInput = Read-Host "Resource group name"
        $RG = Get-AzResourceGroup -ResourceGroupName $RGInput
        $StoreAccountInput = Read-Host "Storage Account Name"
        $StoreAccount = Get-AzStorageAccount -StorageAccountName $StoreAccountInput -ResourceGroupName $RG.ResourceGroupName
        #$StoreContainer = Get-AzStorageContainer -Context $StoreAccount.Context
        $TokenStart = [System.DateTime]::Now.AddDays(-1)
        $TokenEndinput = Read-Host "Valid for how many minutes"
        $TokenEnd = [System.DateTime]::Now.AddMinutes($TokenEndinput)
        $SASToken = New-AzStorageAccountSasToken -Service blob,file,Table,Queue -ResourceType Service,Container,Object -Permission "racwdlup" -Protocol HttpsOnly -StartTime $TokenStart -ExpiryTime $TokenEnd -Context $StoreAccount.context
        $KVaultInput = Read-Host "Keyvault name"
        $KVault = Get-AzKeyVault -VaultName $KVaultInput -ResourceGroupName $RG.ResourceGroupName
        $SASName = Read-Host "SAS name"
        Set-AzKeyVaultManagedStorageSasDefinition -AccountName $StoreAccount.StorageAccountName -VaultName $KVault.VaultName -Name $SASName -TemplateUri $SASToken -SasType 'account'  -ValidityPeriod ([System.TimeSpan]::FromDays($TokenEndinput))
        #Get-AzKeyVaultSecret -VaultName $KVault.VaultName | Where-Object {$_.Name -Like $StoreAccount.StorageAccountName+"*" -and $_.Name -like "*"+$SASName}
    }
}