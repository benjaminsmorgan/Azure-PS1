# Benjamin Morgan benjamin.s.morgan@outlook.com 
# Ref: https://docs.microsoft.com/en-us/azure/storage/blobs/storage-quickstart-blobs-powershell
# $RGInput - Operator input for the resource group name
# $RGObject - Resource group object
# $StorageAccountInput - Operator input for the storage account info
# $StorageAccount - Storage account .context is used
# $StorageContainerInput - Operator input for the storage container (Where the blobs are uploaded to)
# $StorageContainer - Storage container object
# $SkipRG - Flag for skipping resource group info collection on additional passes
# $SkipStorageAccount - Flag for skipping storage account info on additional passes
# $SkipContainer - Flag for skipping storage container info on additional passes
# $AnotherContainer - Flag for running the script again with new storage container
# $AnotherStorageAccount - Flag for running the script again with new storage account
# $AnotherRG Flag for running the script again with all new information
function GetAzStoreBlobContent {
    Begin {
        $ErrorActionPreference = 'silentlyContinue' # Disables error reporting
        while (!$RGObject) {
            $RGInput = Read-Host "Resource Group Name" # RG name collection
            $RGObject = Get-AzResourceGroup -Name $RGInput # Retrives resource group object  
            if (!$RGObject) {
                Write-Host "The resource group name provided does not match"
                Write-Host "Please Select from the following"
                Get-AzResourceGroup | Select-Object ResourceGroupName | Format-Table
            }  
        }
        while (!$StorageAccount) {
            $StorageAccountInput = Read-Host "Enter the name of the storage account" # Storage account collection
            $StorageAccount = Get-AzStorageAccount -ResourceGroupName $RGObject.ResourceGroupName -Name $StorageAccountInput # Retrives storage account object
            if (!$StorageAccount) { # If statment checks if a storage account is found, if not operator will be notified
                Write-Host "The name entered for the storage account does not match, please select from the following names"
                Get-AzStorageAccount -ResourceGroupName $RGObject.ResourceGroupName | Select-Object StorageAccountName | Format-Table # Prints list of all storage accounts in RG to the operator
            }
        }
        while (!$StorageContainer.name) {
            $StorageContainerInput = Read-Host "Enter the name of the container" # Storage container collection
            $StorageContainer = Get-AzStorageContainer -Context $StorageAccount.Context -Name $StorageContainerInput # Retrives storage container object
            $StorageContainer
            if (!$StorageContainer) { # If statment checks if a storage container is found, if not operator will be notified
                Write-Host "The name entered for the storage container does not match, please select from the following names" 
                Get-AzStorageContainer -Context $StorageAccount.Context | Select-Object Name | Format-Table # Prints list of all storage container in RG to the operator
            }
        }
        Get-AzStorageBlob -Container $StorageContainer.Name -Context $StorageAccount.Context # Pulls all the blobs and info for the specified container
        if ($AnotherContainer -eq 'y' -or 'yes') { # If statment to run using same resource group and storage account
            $StorageContainer = $null # Sets $SkipContainer to $null
            GetAzStoreBlobContent # Restarts script
        }
        else {
            $AnotherStorageAccount = Read-Host "Get another storage account in this resource group?" # Prompts to rerun using same resource group
            if ($AnotherStorageAccount -eq 'y' -or $AnotherStorageAccount -eq 'yes') { # If statment to run using same resource group
                $StorageContainer = $null # Sets $SkipContainer to $null
                $StorageAccount = $null # Sets $SkipAccount to $null
                GetAzStoreBlobContent # Restarts script
            }
            else {
                $AnotherRG = Read-Host "Get another resource group?" # Prompts to rerun using all new information
                if ($AnotherRG -eq 'y' -or $AnotherRG -eq 'yes') { # If statement to run using all new information
                    $StorageContainer = $null # Sets $SkipContainer to $null
                    $StorageAccount = $null # Sets $SkipAccount to $null
                    $RGObject = $null # Sets $SkipRG to $null
                    GetAzStoreBlobContent # Restarts script
                }
                else { # Else statement to terminate script
                    Write-Host "Ending script"
                    Break # Ends Script
                }
            }
        }
    } 
}