# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Mircosoft docs links
    Remove-AzStorageContainer:  https://docs.microsoft.com/en-us/powershell/module/az.storage/remove-azstoragecontainer?view=azps-5.2.0
    Get-AzStorageContainer:     https://docs.microsoft.com/en-us/powershell/module/az.storage/get-azstoragecontainer?view=azps-5.2.0
    Get-AzStorageAccount:       https://docs.microsoft.com/en-us/powershell/module/az.storage/get-azstorageaccount?view=azps-5.2.0
    Get-AzResourceGroup:        https://docs.microsoft.com/en-us/powershell/module/az.resources/get-azresourcegroup?view=azps-5.1.0
} #>
<# Required Functions Links: {
    GetAzStorageContainer:      https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Storage/Storage%20Account/Containers/GetAzStorageContainer.ps1
    GetAzStorageAccount:        https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Storage/Storage%20Account/GetAzStorageAccount.ps1
    GetAzResourceGroup:         https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/GetAzResourceGroup.ps1
    } #>
<# Functions Description: {
    RemoveAzStorageContainer:   Removes existing storage container
    GetAzStorageContainer:      Collects storage container in a storage account    
    GetAzStorageAccount:        Collects the storage account object
    GetAzResourceGroup:         Collects resource group object
} #>
<# Variables: {
    RemoveAzStorageContainer {
        :RemoveAzureStorageCon      Outer loop for managing function
        $StorageConObject:          Storage container object
        $OperatorConfirm:           Operator confirmation to remove the storage container
        GetAzStorageContainer {
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
    } End RemoveAzStorageContainer
} #>
<# Process Flow {
    function
        Call RemoveAzStorageContainer > Get $null
            Call GetAzStorageContainer > Get $StorageConObject
                Call GetAzStorageAccount > Get $StorageAccObject
                    Call GetAzResourceGroup > Get $RGObject
                    End GetAzResourceGroup
                        Return GetAzStorageAccount > Send $RGObject
                End RemoveAzStorageContainer 
                    Return Function > Send $null
}#>
function RemoveAzStorageContainer { # Removes existing storage container
    Begin {
        :RemoveAzureStorageCon while ($true) { # Outer loop for function
            <#if (!$StorageAccObject) { # If $StorageAccObject is $null
                $StorageAccObject = GetAzStorageAccount ($RGObject) # Calls function and assigns to $var
                    if (!$StorageAccObject) { # If $StorageAccObject is still $null after calling function
                        Break RemoveAzureStorageCon # Breaks :RemoveAzureStorageCon
                    } # End if (!$StorageAccObject)
            } # End if (!$StorageAccObject) #>
            if (!$StorageConObject) { # If $StorageConObject is $null
                $StorageConObject = GetAzStorageContainer ($StorageAccObject) # Calls function and assigns to $var
                    if (!$StorageConObject) { # If $StorageConObject is still $null after calling function
                        Break RemoveAzureStorageCon # Breaks :RemoveAzureStorageCon
                    } # End if (!$StorageAccObject)
            } # End if (!$StorageAccObject)
            Write-Host "***WARNING RESOURCELOCKS WILL NOT PROTECT THIS STORAGECONTAINER FROM BEING DELETED***"
            $OperatorConfirm = Read-Host "Remove the following storage container" $StorageConObject.Name "in" $StorageAccObject.StorageAccountName # Operator confimation to remove the storage container
                if (!($OperatorConfirm -eq 'y' -or $OperatorConfirm -eq 'yes')) { # If Operator confirm is not (equal 'y' or 'yes')
                    Break RemoveAzureStorageCon # Breaks RemoveAzureStorageCon
                } # End if (!($OperatorConfirm -eq 'y' -or $OperatorConfirm -eq 'yes'))
                $StoreConName = $StorageConObject.Name
                Try { # Try to execute Remove-AzStorageAccount
                    Remove-AzStorageContainer -Context $StorageAccObject.Context -Name $StorageConObject.Name -Force -ErrorAction Stop # Removes storage container, -ErrorAction Stop used for catch statement
                } # End Try
                catch { # Try fails
                    Write-Host "You may not have the permissions to remove this storage account" # Write message to screen
                    Break RemoveAzureStorageCon # Breaks RemoveAzureStorageAcc
                } # End Catch
                Write-Host $StoreConName" has been removed" # Write message to screen
                Return # Returns to calling function
        } # End :RemoveAzureStorageCon while ($true)
        Return # Returns to calling function
    } # End Begin
} # End function RemoveAzStorageContainer
