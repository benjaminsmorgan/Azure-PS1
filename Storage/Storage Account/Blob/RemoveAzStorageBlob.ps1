# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Mircosoft docs links
    Remove-AzStorageBlob:       https://docs.microsoft.com/en-us/powershell/module/az.storage/remove-azstorageblob?view=azps-5.3.0
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
    RemoveAzStorageBlob:        Removes blobs from Azure
    GetAzStorageAccount:        Collects the storage account object
    GetAzStorageContainer:      Collects storage container in a storage account  
    GetAzResourceGroup:         Collects resource group object
} #>
<# Variables: {
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
} #>
<# Process Flow {
    function
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
            Return Function > Send $null
}#>
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