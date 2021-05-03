# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Mircosoft docs links
    Set-AzStorageBlobContent:   https://docs.microsoft.com/en-us/powershell/module/az.storage/set-azstorageblobcontent?view=azps-5.3.0
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
    SetAzStorageBlobContent:    Uploads new blobs
    GetAzStorageAccount:        Collects the storage account object
    GetAzStorageContainer:      Collects storage container in a storage account  
    GetAzResourceGroup:         Collects resource group object
} #>
<# Variables: {
    SetAzStorageBlobContent {
        :SetAzureBlobContent        Outer loop for managing function
        :SetAzureBlobTier           Inner loop for setting a new blob access tier
        :SetLocalFileName           Inner loop for setting the local machine file path
        :SetAzureBlobName           Inner loop for setting the file name and ext in azure
        $CallingFunction:           Name of this function
        $StorageConObject:          Storage container holding the blobs
        $StorageAccObject:          Storage account for the container holding the blobs
        $BlobTier:                  Operator input for the access tier
        $LocalFileName:             Operator input for the local file path and file name
        $OpConfirm:                 Operator confirmation that info is correct
        $BlobFileName:              Operator input for the blob name in azure
        GetAzStorageContainer{}     Gets $StorageConObject
            GetAzStorageAccount{}       Gets $StorageAccObject
                GetAzResourceGroup{}        Gets $RGObject
} #>
<# Process Flow {
    function
        Call SetAzStorageBlobContent > Get $null
            Call GetAzStorageContainer > Get $StorageConObject
                Call GetAzStorageAccount > Get $StorageAccObject
                    Call GetAzResourceGroup > Get $RGObject
                    End GetAzResourceGroup
                        Return GetAzStorageAccount > Send $RGObject
                End GetAzStorageAccount 
                    Return GetAzStorageContainer > Send $StorageAccObject
            End GetAzStorageContainer 
                Return SetAzStorageBlob > Send $StorageConObject, $StorageAccObject
        End SetAzStorageBlobContent
            Return function > Send $null
}#>
function SetAzStorageBlobContent {                                                          # Function to upload a new blob to storage container
    Begin {                                                                                 # Begin function
        $CallingFunction = 'SetAzStorageBlobContent'                                        # Creates $CallingFunction
        :SetAzureBlobContent while ($true) {                                                # Outer loop for managing function
            $StorageConObject, $StorageAccObject = GetAzStorageContainer ($CallingFunction) # Calls function and assigns output to $var
                if (!$StorageConObject) {                                                   # If $StorageConObject is $null
                    Break SetAzureBlobContent                                               # Breaks :SetAzureBlobContent
                }                                                                           # End if (!$StorageConObject)
            :SetAzureBlobTier while($true) {                                                # Inner loop for setting access tier
                Write-Host '[0] Exit'                                                       # Write message to screen
                Write-Host '[1] Hot'                                                        # Write message to screen
                Write-Host '[2] Cool'                                                       # Write message to screen
                $OpSelect = Read-Host 'Set blob access tier [#]'                            # Operator input for the blob tier
                if ($OpSelect -eq '0') {                                                    # If $OpSelect equals '0'
                    Break SetAzureBlobContent                                               # Breaks :SetAzureBlobContent
                }                                                                           # End if ($OpSelect -eq '0')
                elseif ($OpSelect -eq '1') {                                                # Else if $OpSelect equals '1'
                    $BlobTier = 'Hot'                                                       # Sets $BlobTier
                    Clear-Host                                                              # Clears screen
                    Break SetAzureBlobTier                                                  # Breaks :SetAzureBlobTier
                }                                                                           # End elseif ($OpSelect -eq '1')
                elseif ($OpSelect -eq '2') {                                                # Else if $OpSelect equals '2'
                    $BlobTier = 'Cool'                                                      # Sets $BlobTier
                    Clear-Host                                                              # Clears screen
                    Break SetAzureBlobTier                                                  # Breaks :SetAzureBlobTier
                }                                                                           # End elseif ($OpSelect -eq '2')
                else {                                                                      # All other inputs for $OpSelect
                    Write-Host 'That was not a valid option'                                # Write message to screen
                }                                                                           # End else (if ($OpSelect -eq '0'))
            }                                                                               # End :SetAzureBlobTier while($true)
            :SetLocalFileName while ($true) {                                               # Inner loop for adding file path
                Write-Host 'Please enter the full path plus file name and extension'        # Write message to screen
                $LocalFilePath = Read-Host 'Example: C:\users\admin\desktop\file.csv'       # Collects the path to file
                if ($LocalFilePath -eq 'exit') {                                            # If $LocalFilePath equals 'exit'
                    Break SetAzureBlobContent                                               # Breaks :SetAzureBlobContent
                }                                                                           # End if ($LocalFilePath -eq 'exit')
                if (Test-Path $LocalFilePath) {                                             # If file exists
                    Write-Host 'This is the file to be uploaded'                            # Write message to screen
                    Write-Host $LocalFilePath                                               # Write message to screen
                    $OpConfirm = Read-Host '[Y] Yes [N] No'                                 # Operator confirmation of the file to be uploaded
                    if ($OpConfirm -eq 'y') {                                               # If $OpConfirm equals 'y'
                        Clear-Host                                                          # Clears screen
                        Break SetLocalFileName                                              # Breaks :SetLocalFileName
                    }                                                                       # End if ($OpConfirm -eq 'y')
                }                                                                           # End if (Test-Path $LocalFilePath)
                else {                                                                      # If file does not exist
                    Write-Host 'The file could not be located'                              # Write message to screen
                    Write-Host 'Please recheck the path and file name'                      # Write message to screen
                    Pause                                                                   # Pauses all action for operator input
                    Clear-Host                                                              # Clears screen
                }                                                                           # End else (Test-Path $LocalFilePath)
            }                                                                               # End :SetLocalFileName while ($true)
            :SetAzureBlobName while ($true) {                                               # Inner loop for setting the blob file name in storage container
                $BlobFileName = Read-Host 'New name and ext for this file'                  # Operator input for the blob name and ext once uploaded
                if ($BlobFileName -eq 'exit') {                                             # If $BlobFileName is 'exit'
                    Break SetAzureBlobContent                                               # Breaks :SetAzureBlobContent
                }                                                                           # End if ($BlobFileName -eq 'exit')
                Write-Host 'This will be the file name in the container'                    # Write message to screen
                Write-Host $BlobFileName                                                    # Write message to screen
                $OpConfirm = Read-Host '[Y] Yes [N] No'                                     # Operator confirmation of the blob file name
                if ($OpConfirm -eq 'y') {                                                   # If $OpConfirm equals 'y'
                    Break SetAzureBlobName                                                  # Breaks :SetAzureBlobName  
                }                                                                           # End if ($OpConfirm -eq 'y')
            }                                                                               # End :SetAzureBlobName while ($true)
            Try {
                Set-AzStorageBlobContent -File $LocalFilePath -Blob $BlobFileName `
                    -Container $StorageConObject.Name -Context $StorageAccObject.Context `
                    -StandardBlobTier $BlobTier -ErrorAction 'Stop'                         # Adds file as blob
            }                                                                               # End try
            catch {                                                                         # If try fails
                Write-Host 'An error has occured'                                           # Write message to screen
                Write-Host 'You may not have the'                                           # Write message to screen
                Write-Host 'permissions required'                                           # Write message to screen
                Write-Host 'to complete this action'                                        # Write message to screen
                Pause                                                                       # Pauses for operator input
                Break SetAzureBlobName                                                      # Breaks SetAzureBlobName
            }                                                                               # End catch
            Write-Host 'The file has been uploaded into storage container'                  # Write message to screen
            Start-Sleep(2)                                                                  # Pauses all action for 2 seconds
            Break SetAzureBlobName                                                          # Breaks SetAzureBlobName
        }                                                                                   # End :SetAzureBlobContent while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function SetAzStorageBlobContent