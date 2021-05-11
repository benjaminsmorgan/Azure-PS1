# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Mircosoft docs links
    Get-AzStorageFileContent:   https://docs.microsoft.com/en-us/powershell/module/az.storage/get-azstoragefilecontent?view=azps-5.9.0
    Get-AzStorageFile:          https://docs.microsoft.com/en-us/powershell/module/az.storage/get-azstoragefile?view=azps-5.9.0
    Get-AzStorageAccount:       https://docs.microsoft.com/en-us/powershell/module/az.storage/get-azstorageaccount?view=azps-5.2.0
    Get-AzResourceGroup:        https://docs.microsoft.com/en-us/powershell/module/az.resources/get-azresourcegroup?view=azps-5.1.0
} #>
<# Required Functions Links: {
    NavAzStorageShare:          https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Storage/Storage%20Account/Shares/NavAzStorageShare.ps1
    GetAzStorageShare:          https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Storage/Storage%20Account/Shares/GetAzStorageShare.ps1
    GetAzStorageAccount:        https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Storage/Storage%20Account/GetAzStorageAccount.ps1
    GetAzResourceGroup:         https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/GetAzResourceGroup.ps1
} #>
<# Functions Description: {
    GetAzStorageFileContent:    Downloads a storage share file
    NavAzStorageShare:          Gets a storage share file path
    GetAzStorageShare:          Gets a storage share object
    GetAzStorageAccount:        Gets the storage account object
    GetAzResourceGroup:         Gets resource group object
} #>
<# Variables: {
    :GetAzureSFileContent       Outer loop for managing function
    :SetLocalFilePath           Inner loop for setting the download path
    :VerifyPath                 Inner loop for verifying a manual download path
    $CallingFunction:           Name of this function or the one that called it
    $StorageShareFileObject:    Path of the file to download
    $StorageShareObject:        Storage share object
    $StorageAccObject:          Storage account object
    $OpSelect:                  Operator input for selecting the download path
    $UserName:                  Current user name
    NavAzStorageShare{}         Gets $StorageShareFileObject
        GetAzStorageShare{}         Gets $StorageShareObject 
            GetAzStorageAccount{}       Gets $StorageAccObject
                GetAzResourceGroup{}        Gets $RGObject
} #>
<# Process Flow {
    function
        Call GetAzStorageFileContent > Get $null
            Call NavAzStorageShare > Get $StorageShareFileObject
                Call GetAzStorageShare > Get $$StorageShare
                    Call GetAzStorageAccount > Get $StorageAccObject
                        Call GetAzResourceGroup > Get $RGObject
                        End GetAzResourceGroup
                            Return GetAzStorageAccount > Send $RGObject
                    End GetAzStorageAccount 
                        Return GetAzStorageShare > Send $StorageAccObject
                End GetAzStorageShare 
                    Return NavAzStorageShare > Send $StorageShare, $StorageAccObject
            End NavAzStorageShare
                Return GetAzStorageFileContent > Send StorageShareFileObject, $StorageShareObject, $StorageAccObject
        End GetAzStorageFileContent
            Return function > Send $null 
}#>
function GetAzStorageFileContent {                                                          # Function to download a file from file share
    Begin {                                                                                 # Begin function
        if (!$CallingFunction) {                                                            # If $CallingFunction is $null
            $CallingFunction = 'GetAzStorageFileContent'                                    # Creates $Calling function
        }                                                                                   # End if (!$CallingFunction)
        :GetAzureSFileContent while ($true) {                                               # Outer loop for managing function
            $StorageShareFileObject, $StorageShareObject, $StorageAccObject = `
                NavAzStorageShare ($CallingFunction)                                        # Calls function and assigns output to $var
            if (!$StorageShareFileObject) {                                                 # If $StorageShareFileObject is $null
                Break GetAzureSFileContent                                                  # Breaks :GetAzureSFileContent
            }                                                                               # End if (!$StorageShareFileObject)
            :SetLocalFilePath while ($true) {                                               # Inner loop for setting the local download path
                Write-Host '[0] Exit'                                                       # Write message to screen
                Write-Host '[1] Downloads folder'                                           # Write message to screen
                Write-Host '[2] Custom path'                                                # Write message to screen
                $OpSelect = Read-Host 'Option [#]'                                          # Operator input for download path selection
                if ($OpSelect -eq '0') {                                                    # If $OpSelect equals '0'
                    Break GetAzureSFileContent                                              # Breaks :GetAzureSFileContent
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
                            Break GetAzureSFileContent                                      # Breaks :GetAzureSFileContent
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
                Get-AzStorageFileContent -ShareName $StorageShareObject.Name -Path `
                    $StorageShareFileObject -Context $StorageAccObject.Context `
                    -Destination $LocalFileDownloadPath  -PreserveSMBAttribute `
                    -ErrorAction 'Stop'                                                     # Downloads the file
            }                                                                               # End try
            catch {                                                                         # If try fails
                Write-Host 'An error has occured'                                           # Write message to screen
                Write-Host 'The source file may be locked'                                  # Write message to screen
                Write-Host 'The destination folder maybe locked'                            # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break GetAzureSFileContent                                                  # Breaks :GetAzureSFileContent
            }                                                                               # End catch
            Write-Host 'The file has been downloaded'                                       # Write message to screen
            Pause                                                                           # Pauses all actions for operator input
            Break GetAzureSFileContent                                                      # Breaks :GetAzureSFileContent
        }                                                                                   # End :GetAzureSFileContent while ($true)
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End begin
}                                                                                           # End function GetAzStorageFileContent