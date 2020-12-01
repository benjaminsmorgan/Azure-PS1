<# 
Author - Benjamin Morgan benjamin.s.morgan@outlook.com 
Ref: {
    Get-AzResourceGroup:        https://docs.microsoft.com/en-us/powershell/module/az.resources/get-azresourcegroup?view=azps-5.1.0
    Get-AzStorageAccount:       https://docs.microsoft.com/en-us/powershell/module/az.storage/get-azstorageaccount?view=azps-5.1.0
    Get-AzureStorageContainer:  https://docs.microsoft.com/en-us/powershell/module/azure.storage/get-azurestoragecontainer?view=azurermps-6.13.0
    Remove-AzStorageBlob:       https://docs.microsoft.com/en-us/powershell/module/az.storage/remove-azstorageblob?view=azps-5.1.0
}
Required Functions: {
    GetAzResourceGroup:         Collects resource group object
    GetAzStorageAccount:        Collects the storage account object
    GetAzStorageContainer:      Collects the storage container object
}
Variables: {
    GetAzResourceGroup {
        $RGObject - Resource group object
        $RGObjectinput - Operator input for the resource group name
        $RGList - variable used for printing all resource groups to screen if needed
    }
    GetAzStorageAccount {
        $RGObject - Resource group object
        $StorageAccount - Storage account object
        $StorageAccointInput - Operator input for the sotrage account name
        $SAList - variable used for printing all storage accounts to screen if needed 
    }
    GetAzStorageContainer {
        $StorageAccount - Storage account object
        $StorageContainer - Storage container object
        $StorageContainerInput - Operator input for the storage container name
        $SCList - variable used for printing all storage containers to screen if needed 
    }
    RemoveAzStorageBlob {
        $BlobFileName - Blob object
        $BlobFileNameInput - Operator input for blob object
        $SCBlobList - If needed, outputs all blob objects in a container
        $StorageAccount - Storage account object
        $StorageContainer - Storage container object
    }
}
#>
Function RemoveAzStorageBlob { # Function to remove a blob (File) from an existing storage container
    Begin {
        $ErrorActionPreference='silentlyContinue' # Disables errors
        if (!$StorageContainer) {  # Check to see if container needs to be assigned to $StorageContainer
            $RGObject = GetAzResourceGroup # Calls function GetAzResourceGroup and assigns to $RGObject
            $StorageAccount = GetAzStorageAccount ($RGObject) # Calls function GetAzStorageAccount and assigns to $StorageAccount
            $StorageContainer = GetAzStorageContainer ($RGObject, $StorageAccount) # Calls function GetAzStorageContainer and assigns to $StorageContainer
        } # End if statement
        $BlobFileName = $null # Clears $BlobFileName from all previous use
        while (!$BlobFileName) { # Loop to continue getting a storage blob until the operator provided name matches an existing container
            $BlobFileNameInput = Read-Host "Name and ext of the blob to be deleted"  # Operator input of the storage blob name
            $BlobFileName = Get-AzStorageBlob -Blob $BlobFileNameInput -Container $StorageContainer.name -Context $StorageAccount.Context # Collects the blob object using $BlobFileNameInput
            if (!$BlobFileName) { # Error reporting if input does not match and existing blob
                Write-Host "The name provided does not match an existing storage blob" # Error reporting
                Write-Host "This is the list of available storage blobs" # Error reporting
                $SCBloblist = Get-AzStorageBlob -Context $StorageAccount.context -Container $StorageContainer.Name  # Collects all storage blobs within $StorageContainer and assigns them to $SCBloblist
                Write-Host "" # Error reporting
                Write-Host $SCBlobList.Name -Separator `n # Write-host used so list is written to screen when function is used as a called function
                Write-Host "" # Error reporting
            } # End if statement
        } # End while statement
        $ConfirmDelete = Read-Host "Do you want to delete"$BlobFileName.Name # Operator input to confirm delete
        if ($ConfirmDelete -eq 'y' -or $ConfirmDelete -eq 'yes') { # Check that operator input is 'y' or 'yes'
            Remove-AzStorageBlob -Blob $BlobFileName.Name -Container $StorageContainer.Name -Context $StorageAccount.Context # Removes the selected blob
            Write-Host $BlobFileName.Name"has been deleted" # Confirmation message
        } # End if statement
        else { # If $ConfirmDelete is not 'y' or 'yes'
            Write-Host "No changes were made" # Confirmation message
            Break # Terminates script
        } # End else statement
    } # End begin statement
} # End function
function GetAzStorageContainer { # Function to get a storage container, can pipe $StorageContainer to another function
    Begin {
        $ErrorActionPreference='silentlyContinue' # Disables errors
        if (!$StorageAccount) { # Check to see if account needs to be assigned to $StorageAccount
            $RGObject = GetAzResourceGroup # Calls function GetAzResourceGroup and assigns to $RGObject
            $StorageAccount = GetAzStorageAccount ($RGObject) # Calls function GetAzStorageAccount and assigns to $StorageAccount
        } # End if statement
        $StorageContainer = $null # Clears $StorageContainer from all previous use
        while (!$StorageContainer) { # Loop to continue getting a storage container until the operator provided name matches an existing container
            $StorageContainerInput = Read-Host "Storage container name" # Operator input of the storage container name
            $StorageContainer = Get-AzStorageContainer -Context $StorageAccount.Context -Name $StorageContainerInput # Collection of the storage container from the operator input
            if (!$StorageContainer) { # Error reporting if input does not match and existing container
                Write-Host "The name provided does not match an existing storage container" # Error reporting
                Write-Host "This is the list of available storage containers" # Error reporting
                $SCList = Get-AzStorageContainer -Context $StorageAccount.Context  # Collects all storage containers within $StorageAccount and assigns them to $SClist
                Write-Host "" # Error reporting
                Write-Host $SCList.Name -Separator `n # Write-host used so list is written to screen when function is used as $StorageContainer = GetAzStorageContainer
                Write-Host "" # Error reporting
            } # End if statement
            else { # Else for when $StorageContainer is assigned
                Write-Host $StorageContainer.Name # Writes the storage account name to the screen before ending function
            } # End of else statement
        } # End of while statement
        Return $StorageContainer # Returns $StorageContainer back to a calling function
    } # End of begin statement
} # End of function
function GetAzStorageAccount { # Function to get a storage account, can pipe $StorageAccount to another function
    Begin {
        $ErrorActionPreference = 'silentlyContinue' # Disables errors
        if (!$RGObject) { # Check to see if resource group needs to be assigned to $RGObject
            $RGObject = GetAzResourceGroup # Calls function GetAzResourceGroup and assigns to $RGObject
        } # End if statement
        $StorageAccount = $null # Clears $StorageAccount from all previous use
        while (!$StorageAccount) { # Loop to continue getting a storage account until the operator provided name matches an existing account
            $StorageAccountInput = Read-Host "Storage account name" # Operator input of the storage account name
            $StorageAccount = Get-AzStorageAccount -ResourceGroupName $RGObject.ResourceGroupName -Name $StorageAccountInput # Collection of the storage account from the operator input
            if (!$StorageAccount) { # Error reporting if input does not match and existing account
                Write-Host "The name provided does not match an existing storage account" # Error reporting
                $SAList = Get-AzStorageAccount -ResourceGroupName $RGObject.ResourceGroupName # Collects all storage accounts within $RGObject and assigns to $SAList
                Write-Host "" # Error reporting
                Write-Host $SAList.Storageaccountname -Separator `n # Write-host used so list is written to screen when function is used as $StorageAccount = GetAzStorageAccount
                Write-Host "" # Error reporting
            } # End if statement
            else { # Else for when $StorageAccount is assigned
                Write-Host $StorageAccount.StorageAccountName 'Has been assigned to "$StorageAccount"' # Writes the storage account name to the screen before ending function
            } #End else statement
        } # End of while statement
        Return $StorageAccount # Returns $StorageAccount back to a calling function
    } # End of begin statement
} # End of function
function GetAzResourceGroup { # Function to get a resource group, can pipe $RGObject to another function.
    Begin {
        $ErrorActionPreference='silentlyContinue' # Disables Errors
        $RGObject = $null # Clears $RGObject from all previous use
        while (!$RGObject) { # Loop to continue getting a resource group until the operator provided name matches an existing group
            $RGObjectInput = Read-Host "Resource group name" # Operator input of the resource group name
            $RGObject = Get-AzResourceGroup -Name $RGObjectInput # Collection of the resource group from the operator input
            if (!$RGObject) { # Error reporting if input does not match an existing group
                Write-Host "The name provided does not match an existing resource group" # Error note
                Write-Host "This is the list of available resource groups" # Error note
                $RGList = Get-AzResourceGroup # Collects all resource group objects and assigns to a variable
                Write-Host "" # Error reporting
                Write-Host $RGList.ResourceGroupName -Separator `n # Write-host used so list is written to screen when function is used as $RGObject = GetAzResourceGroup
                Write-Host "" # Error reporting
            } # End of if statement
            else { # Else for when $RGObject is assigned
                Write-Host $RGObject.ResourceGroupName 'Has been assigned to "$RGObject"' # Writes the resource group name to the screen before ending function
            } # End of else statement
        } # End of while statement
        Return $RGObject  # Returns the value of $RGObject to a function that called it
    } # End of begin statement
} # End of function