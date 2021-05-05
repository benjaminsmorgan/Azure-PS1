# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Mircosoft docs links
    Remove-AzStorageBlob:       https://docs.microsoft.com/en-us/powershell/module/az.storage/remove-azstorageblob?view=azps-5.3.0
    Get-AzStorageBlob:          https://docs.microsoft.com/en-us/powershell/module/az.storage/get-azstorageblob?view=azps-5.8.0
    Get-AzStorageAccount:       https://docs.microsoft.com/en-us/powershell/module/az.storage/get-azstorageaccount?view=azps-5.2.0
    Get-AzStorageContainer:     https://docs.microsoft.com/en-us/powershell/module/az.storage/get-azstoragecontainer?view=azps-5.2.0
    Get-AzResourceGroup:        https://docs.microsoft.com/en-us/powershell/module/az.resources/get-azresourcegroup?view=azps-5.1.0
} #>
<# Required Functions Links: {
    GetAzStorageBlob:           https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Storage/Storage%20Account/GetAzStorageBlob.ps1
    GetAzStorageAccount:        https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Storage/Storage%20Account/GetAzStorageAccount.ps1
    GetAzStorageContainer:      https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Storage/Storage%20Account/Containers/GetAzStorageContainer.ps1
    GetAzResourceGroup:         https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/GetAzResourceGroup.ps1
} #>
<# Functions Description: {
    RemoveAzStorageBlob:        Removes blobs from Azure
    GetAzStorageBlob:           Gets a storage blob
    GetAzStorageAccount:        Collects the storage account object
    GetAzStorageContainer:      Collects storage container in a storage account  
    GetAzResourceGroup:         Collects resource group object
} #>
<# Variables: {
    :RemoveAzureBlob            Outer loop for managing function
    $StorageBlobObject:         Storage blob object or objects
    $StorageAccObject:          Storage account for the container holding the blobs
    $StorageConObject:          Storage container holding the blobs
    $OpConfirm:                 Operator confirmation for deletion
    GetAzStorageBlob{}          Gets $StorageBlobObject
        GetAzStorageContainer{}     Gets $StorageConObject
            GetAzStorageAccount{}       Gets $StorageAccObject
                GetAzResourceGroup{}        Gets $RGObject
} #>
<# Process Flow {
    function
        Call RemoveAzStorageBlob > Get $null
            Call GetAzStorageBlob > Get $StorageBlobObject
                Call GetAzStorageContainer > Get $StorageConObject
                    Call GetAzStorageAccount > Get $StorageAccObject
                        Call GetAzResourceGroup > Get $RGObject
                        End GetAzResourceGroup
                            Return GetAzStorageAccount > Send $RGObject
                    End GetAzStorageAccount 
                        Return GetAzStorageContainer > Send $StorageAccObject
                End GetAzStorageContainer 
                    Return GetAzStorageBlob > Send $StorageConObject, $StorageAccObject
            End GetAzStorageBlob
                Return RemoveAzStorageBlob > Send StorageBlobObject, $StorageConObject, $StorageAccObject
        End RemoveAzStorageBlob
            Return Function > Send $null
}#>
function RemoveAzStorageBlob {                                                              # Function to remove a storage blob    
    Begin {                                                                                 # Begin function
        $CallingFunction = 'RemoveAzStorageBlob'                                            # Creates $CallingFunction
        $ErrorActionPreference = 'silentlyContinue'                                         # Disables error messages
        :RemoveAzureBlob while ($true) {                                                    # Outer loop for managing function
            $StorageBlobObject, $StorageConObject, $StorageAccObject = GetAzStorageBlob `
                ($CallingFunction)                                                          # Calls function and assigns output to $var
            if (!$StorageBlobObject) {                                                      # If $var is $null
                Break RemoveAzureBlob                                                       # Breaks :RemoveAzureBlob  
            }                                                                               # End if (!$StorageConObject)
            Write-Host 'Remove the following blob'                                          # Write message to screen
            Write-Host 'Blob:     '$StorageBlobObject.Name                                  # Write message to screen
            Write-Host 'Container:'$StorageConObject.name                                   # Write message to screen
            Write-Host 'Account:  '$StorageAccObject.StorageAccountName                     # Write message to screen
            $OpConfirm = Read-Host '[Y] Yes [N] No'                                         # Operator confirmation to remove the blob
            Clear-Host                                                                      # Clears screen
            if ($OpConfirm -eq 'y') {                                                       # If $OpConfirm equals 'y'
                Try {                                                                       # Try the following
                    Remove-AzStorageBlob -Blob $StorageBlobObject.Name -Container `
                        $StorageConObject.Name -Context $StorageAccObject.Context `
                        -ErrorAction 'Stop'                                                 # Removes the selected blob
                }                                                                           # End Try
                Catch {                                                                     # If try fails
                    Write-Host 'An error has occured'                                       # Write message to screen
                    Write-Host 'Please check your permissions'                              # Write message to screen
                    Pause                                                                   # Pauses for operator input
                    Break RemoveAzureBlob                                                   # Breaks :RemoveAzureBlob
                }                                                                           # End catch
                Write-Host 'The selected blob has been removed'                             # Write message to screen
                Pause                                                                       # Pauses for operator input
                Break RemoveAzureBlob                                                       # Breaks :RemoveAzureBlob
            }                                                                               # End if ($OpConfirm -eq 'y')
            else {                                                                          # All other inputs for $OpConfirm
                Write-Host 'No action taken'                                                # Write message to screen
                Start-Sleep(3)                                                              # Pauses all action for 3 seconds
                Break RemoveAzureBlob                                                       # Breaks :RemoveAzureBlob
            }                                                                               # End else (if ($OpConfirm -eq 'y'))
        }                                                                                   # End RemoveAzureBlob while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function RemoveAzStorageBlob