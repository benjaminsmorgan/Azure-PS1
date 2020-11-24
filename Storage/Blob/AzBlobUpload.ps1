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
# $SkipTier - Flag for skipping storage tier on additional passes
# $SetTier - Operator input to set the storage tier on blob upload
# $LocalFile - Operator input for full path + filename + ext (Quotes is not used)
# $BlobFileName - Operator input for the name of the blob when it resides in the storage container
# $AnotherFile - Flag for running the script again using the same storage container
# $AnotherFile2 - Flag for running the script again using the same storage container with a new tier
# $AnotherContainer - Flag for running the script again with all new information
function SetAzStoreBlobContent {
    Begin {
        if (!$SkipRG) { # If statement skips RG input if the flag is set to anything other than $null
            $RGInput = Read-Host "Resource Group Name" # RG name collection
            $RGObject = Get-AzResourceGroup -Name $RGInput # Retrives resource group object
            if (!$RGObject) { # If statment checks if a resource group is found, if not operator will be notified
                Write-Host "The name entered for the resource group does not match, please select from the following names"
                Get-AzResourceGroup | Select-Object ResourceGroupName | Format-Table # Prints list of all resource groups to the operator
                SetAzStoreBlobContent # Restarts script
            }
            else { # Else statement when resource group object matches operator input
                $SkipRG = "Yes" # Sets $SkipRG to a value of 'Yes' to skip on script reruns
            }
        }
        if (!$SkipStorageAccount) { # If statement skips storage account input if the flag is set to anything other than $null
            $StorageAccountInput = Read-Host "Enter the name of the storage account" # Storage account collection
            $StorageAccount = Get-AzStorageAccount -ResourceGroupName $RGObject.ResourceGroupName -Name $StorageAccountInput # Retrives storage account object
            if (!$StorageAccount) { # If statment checks if a storage account is found, if not operator will be notified
                Write-Host "The name entered for the storage account does not match, please select from the following names"
                Get-AzStorageAccount -ResourceGroupName $RGObject.ResourceGroupName | Select-Object StorageAccountName | Format-Table # Prints list of all storage accounts in RG to the operator
                SetAzStoreBlobContent # Restarts script
            }
            else { # Else statement when storage account object matches operator input
                $SkipStorageAccount = "Yes" # Sets $SkipStorageAccount to a value of 'Yes' to skip on script reruns
            }
        }
        if (!$SkipContainer) { # If statement skips storage container input if the flag is set to anything other than $null
            $StorageContainerInput = Read-Host "Enter the name of the container" # Storage container collection
            $StorageContainer = Get-AzStorageContainer -Context $StorageAccount.Context -Name $StorageContainerInput # Retrives storage container object
            if (!$StorageContainer) { # If statment checks if a storage container is found, if not operator will be notified
                Write-Host "The name entered for the storage container does not match, please select from the following names" 
                Get-AzStorageContainer -Context $StorageAccount.Context | Select-Object Name | Format-Table # Prints list of all storage container in RG to the operator
                SetAzStoreBlobContent # Restarts script
            }
            else { # Else statement when storage container object matches operator input
                $SkipContainer = "Yes" # Sets $SkipContainer to a value of 'Yes' to skip on script reruns
            }
        }
        if (!$SkipTier) { # If statement skips storage tier input if the flag is set to anything other than $null
            $SetTier = Read-Host "Hot or Cool" # Storage tier collection
            if ($SetTier -eq "Hot" -or $SetTier -eq "Cool") { # If statement to determine if a valid option has been inputed
                $SkipTier = "Yes" # Sets $SkipTier to a value of 'Yes' to skip on script reruns
            }
            else { # Else statement for invalid $SetTier input
                Write-Host "Invalid input"
                SetAzStoreBlobContent # Restarts script
            }
        }
        $LocalFile = Read-Host "Full path and filename" # Collects the path to file, example: C:\users\Admin\Documents\Blobupload.txt
        $BlobFilename = Read-Host "New name and ext for this file" # Collects the new name and ext for the file that will be used in the storage account, example: SuperAwesomeBlob.jpg
        Set-AzStorageBlobContent -File $LocalFile -Blob $BlobFilename -Container $StorageContainer.Name -Context $StorageAccount.Context -StandardBlobTier $SetTier # Uploads the file to azure
        $Anotherfile = Read-Host "Upload another file to this container" # Prompt to rerun the script using the same storage account
        if ($AnotherFile -eq "y" -or $Anotherfile -eq "Yes") { # If statement for running the script again using the same settings
            $AnotherFile2 = Read-Host "Use the same storage tier?" # Prompt to change the storage tier on another pass
            if ($AnotherFile2 -eq 'y' -or $AnotherFile2 -eq 'yes') { # If operator response to using the same tier with 'y' or 'yes'
                SetAzStoreBlobContent # Restarts script
            }
            else { # Else for operator response to using the same storage tier for any input other than 'y' or 'yes'
                $SkipTier = $null # Sets $SkipTier to $null, next pass of script will prompt for access tier
                SetAzStoreBlobContent # Restarts script
            }
        }
        $AnotherContainer = Read-Host "Upload a file to a different container" # Prompt to restart the script using all new values
        if ($AnotherContainer -eq "y" -or $AnotherContainer -eq "Yes") { # If statement for operator input of 'y' or 'yes'
            $SkipRG = $null # Sets $SkipRG to $null
            $SkipStorageAccount = $null # Sets $SkipStorageAccount to $null
            $SkipContainer = $null # Sets $SkipContainer to $null
            $SkipTier = $null # Sets $SkipTier to $null
            SetAzStoreBlobContent # Restarts script with all skip flags set to $null
        }
        else { # Else statement to terminate script
            Write-Host "Ending script"
            Break # Ends Script
        }
    } 
}