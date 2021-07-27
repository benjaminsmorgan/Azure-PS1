# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Microsoft docs links
    Get-AzStorageBlobContent:   https://docs.microsoft.com/en-us/powershell/module/az.storage/get-azstorageblobcontent?view=azps-5.3.0
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
    GetAzStorageBlobContent:    Downloads existing blob
    GetAzStorageBlob:           Gets a storage blob
    GetAzStorageAccount:        Collects the storage account object
    GetAzStorageContainer:      Collects storage container in a storage account  
    GetAzResourceGroup:         Collects resource group object
} #>
<# Variables: {
    :GetAzureBlobContent        Outer loop for managing funciton
    :SetLocalFilePath           Inner loop for setting the download path
    :VerifyPath                 Inner loop for setting a custom download path
    $CallingFunction:           Name of this function
    $StorageBlobObject:         Storage blob object
    $StorageConObject:          Storage container object
    $StorageAccObject:          Storage account object
    $OpSelect:                  Operator input for chosing download path
    $UserName:                  Operator username
    $LocalFileDownloadPath:     Local download path
    GetAzStorageContainer{}     Gets $StorageConObject
        GetAzStorageAccount{}       Gets $StorageAccObject
            GetAzResourceGroup{}        Gets $RGObject
} #>
<# Process Flow {
    function
        Call GetAzStorageBlobContent > Get $null
            Call GetAzStorageBlob > Get $StorageBlobObject
                Call GetAzStorageContainer > Get $StorageConObject
                    Call GetAzStorageAccount > Get $StorageAccObject
                        Call GetAzResourceGroup > Get $RGObject
                        End GetAzResourceGroup
                            Return GetAzStorageAccount > Send $RGObject
                    End GetAzStorageAccount 
                        Return GetAzStorageContainer > Send $StorageAccObject
                End GetAzStorageContainer 
                    Return SetAzStorageBlob > Send $StorageConObject, $StorageAccObject
            End GetAzStorageBlob
                Return GetAzStorageBlobContent > Send StorageBlobObject, $StorageConObject, $StorageAccObject
        End GetAzStorageBlobContent
            Return function > Send $null 
}#>
function GetAzStorageBlobContent {                                                          # Function to download an existing blob
    Begin {                                                                                 # Begin function
        $CallingFunction = 'GetAzStorageBlobContent'                                        # Creates $CallingFunction
        $ErrorActionPreference = 'silentlyContinue'                                         # Disables error messages
        :GetAzureBlobContent while ($true) {                                                # Outer loop for managing function
            $StorageBlobObject, $StorageConObject, $StorageAccObject = GetAzStorageBlob `
                ($CallingFunction)                                                          # Calls function and assigns output to $vars
            if (!$StorageBlobObject) {                                                      # If $StorageBlobObject is $null
                Break GetAzureBlobContent                                                   # Breaks :GetAzureBlobContent
            }                                                                               # End if (!$StorageBlobObject)
            :SetLocalFilePath while ($true) {                                               # Inner loop for setting the local download path
                Write-Host '[0] Exit'                                                       # Write message to screen
                Write-Host '[1] Downloads folder'                                           # Write message to screen
                Write-Host '[2] Custom path'                                                # Write message to screen
                $OpSelect = Read-Host 'Option [#]'                                          # Operator input for download path selection
                if ($OpSelect -eq '0') {                                                    # If $OpSelect equals '0'
                    Break GetAzureBlobContent                                               # Breaks :GetAzureBlobContent
                }                                                                           # End if ($OpSelect -eq '0')
                elseif ($OpSelect -eq '1') {                                                # Else if $OpSelect equals '1'
                    $UserName = $env:USERNAME                                               # Gets session username
                    if ($UserName -like '*\*') {                                            # If $Username has a '\'
                        $UserName = $UserName.Split('\')[1]                                 # Removes \ and text before it
                    }                                                                       # End if ($UserName -like '*\*')
                    $LocalFileDownloadPath = 'c:\users\'+$UserName+'\downloads\'            # Creates $Localdownloadpath
                    Clear-Host                                                              # Clears screen
                    Break SetLocalFilePath                                                  # Breaks :SetLocalFilePath  
                }                                                                           # End elseif ($OpSelect -eq '1')
                elseif ($OpSelect -eq '2') {                                                # Else if $OpSelect equals '2'
                    :VerifyPath while ($true) {                                             # Inner loop for verifying local download path
                        $LocalFileDownloadPath = Read-Host `
                            'Enter the folder path to download blob to'                     # Operator input for local download path
                        if ($LocalFileDownloadPath -eq 'exit') {                            # If $LocalFileDownloadPath equals 'exit'
                            Break GetAzureBlobContent                                       # Breaks :GetAzureBlobContent
                        }                                                                   # End if ($LocalFileDownloadPath -eq 'exit')
                        if (Test-Path $LocalFileDownloadPath) {                             # If $LocalFileDownloadPath is valid
                            Clear-Host                                                      # Clears screen
                            Break SetLocalFilePath                                          # Breaks :SetLocalFilePath
                        }                                                                   # End if (Test-Path $LocalFileDownloadPath)
                        else {                                                              # If Test-Path is false
                            Write-Host ''                                                   # Write message to screen
                            Write-Host 'The listed path was not valid'                      # Write message to screen
                            Write-Host 'Please double check the folder path'                # Write message to screen
                            Write-Host ''                                                   # Write message to screen
                            Write-Host 'Enter "exit" to leave this function'                # Write message to screen
                            Pause                                                           # Pauses for operator input
                            Clear-Host                                                      # Clears screen
                        }                                                                   # End else (if (Test-Path $LocalFileDownloadPath))
                    }                                                                       # End :VerifyPath while ($true)
                }                                                                           # End elseif ($OpSelect -eq '2')
                else {                                                                      # All other inputs for $OpSelect
                    Write-Host 'That was not a valid option'                                # Write message to screen
                }                                                                           # End else (if ($OpSelect -eq '0'))
            }                                                                               # End :SetLocalFilePath while ($true)
            Try {                                                                           # Try the following
                Get-AzStorageBlobContent -Context $StorageAccObject.context -Container `
                    $StorageConObject.Name -Blob $StorageBlobObject.Name `
                    -Destination $LocalFileDownloadPath -ErrorAction 'Stop'                 # Downloads the selected blob
            }                                                                               # End Try
            catch {                                                                         # If try failes
                Write-Host ''                                                               # Write message to screen
                Write-Host 'An error has occured'                                           # Write message to screen
                Write-Host 'You may not have the permissions'                               # Write message to screen
                Pause                                                                       # Pauses all action for operator input
                Break GetAzureBlobContent                                                   # Breaks GetAzureBlobContent
            }                                                                               # End catch
            Write-Host ''                                                                   # Write message to screen
            Write-Host 'The blob has been downloaded to'$LocalFileDownloadPath              # Write message to screen
            Start-Sleep(5)                                                                  # Pauses all action for 5 seconds
            Break GetAzureBlobContent                                                       # Breaks GetAzureBlobContent
        }                                                                                   # End :GetAzureBlobContent while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function GetAzStorageBlobContent