# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Microsoft docs links
    Remove-AzStorageDirectory:  https://docs.microsoft.com/en-us/powershell/module/az.storage/remove-azstoragedirectory?view=azps-5.9.0
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
    RemoveAzStorageDirectory:   Removes a storage share folder
    NavAzStorageShare:          Gets a storage share folder path
    GetAzStorageShare:          Gets a storage share object
    GetAzStorageAccount:        Gets the storage account object
    GetAzResourceGroup:         Gets resource group object
} #>
<# Variables: {
    :RemoveAzureSFolder         Outer loop for managing function
    $CallingFunction:           Name of this function or the one that called it
    $StorageShareFolderObject:  Path of the folder to remove
    $StorageShareObject:        Storage share object
    $StorageAccObject:          Storage account object
    $SubObjects:                List of any files or folders existing in $StorageShareFolderObject
    $OpConfirm                  Operator confirmation to remove the folder
    NavAzStorageShare{}         Gets $StorageShareFolderObject
        GetAzStorageShare{}         Gets $StorageShareObject 
            GetAzStorageAccount{}       Gets $StorageAccObject
                GetAzResourceGroup{}        Gets $RGObject
} #>
<# Process Flow {
    function
        Call RemoveAzStorageDirectory > Get $null
            Call NavAzStorageShare > Get $StorageShareFolderObject
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
                Return RemoveAzStorageDirectory > Send StorageShareFolderObject, $StorageShareObject, $StorageAccObject
        End RemoveAzStorageDirectory
            Return function > Send $null 
}#>
function RemoveAzStorageDirectory {                                                         # Function to remove a folder from file share
    Begin {                                                                                 # Begin function
        if (!$CallingFunction) {                                                            # If $CallingFunction is $null
            $CallingFunction = 'RemoveAzStorageDirectory'                                   # Creates $Calling function
        }                                                                                   # End if (!$CallingFunction)
        :RemoveAzureSFolder while ($true) {                                                 # Outer loop for managing function
            $StorageShareFolderObject, $StorageShareObject, $StorageAccObject = `
                NavAzStorageShare ($CallingFunction)                                        # Calls function and assigns output to $var
            if (!$StorageShareFolderObject) {                                               # If $StorageShareFolderObject is $null
                Break RemoveAzureSFolder                                                    # Breaks :RemoveAzureSFolder
            }                                                                               # End if (!$StorageShareFolderObject)
            $SubObjects = Get-AzStorageFile -Path $StorageShareFolderObject -ShareName `
                    $StorageShareObject.Name -Context $StorageAccObject.Context | `
                    Get-AzStorageFile                                                       # Gets a list of files or folders in StorageShareFolderObject
            if ($SubObjects) {                                                              # If $SubObjects has a value
                Write-Host 'Unable to remove:'$StorageShareFolderObject                     # Write message to screen
                Write-Host 'From file share: '$StorageShareObject.name                      # Write message to screen
                Write-Host 'From storage acc:'$StorageAccObject.StorageAccountName          # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Write-Host 'The directory is not empty'                                     # Write message to screen
                Write-Host 'No action has been taken'                                       # Write message to screen
                Pause                                                                       # Pauses for operator input
                Break RemoveAzureSFolder                                                    # Breaks :RemoveAzureSFolder
            }                                                                               # End if ($SubObjects)
            Write-Host 'Remove the folder:'$StorageShareFolderObject                        # Write message to screen
            Write-Host 'From file share:  '$StorageShareObject.name                         # Write message to screen
            Write-Host 'From storage acc: '$StorageAccObject.StorageAccountName             # Write message to screen
            $OpConfirm = Read-Host '[Y] Yes [N] No'                                         # Operator confirmation to remove the folder
            if ($OpConfirm -eq 'y') {                                                       # If $OpConfirm equals 'y'
                Try {                                                                       # Try the following
                    Remove-AzStorageDirectory -ShareName $StorageShareObject.Name -Path `
                        $StorageShareFolderObject -Context $StorageAccObject.Context `
                        -ErrorAction 'Stop'                                                 # Removes the folder
                }                                                                           # End try
                catch {                                                                     # If try fails
                    Write-Host 'An error has occured'                                       # Write message to screen
                    Write-Host 'The source folder may be locked'                            # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Break RemoveAzureSFolder                                                # Breaks :RemoveAzureSFolder
                }                                                                           # End catch
                Write-Host 'The folder has been removed'                                    # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break RemoveAzureSFolder                                                    # Breaks :RemoveAzureSFolder
            }                                                                               # End if ($OpConfirm -eq 'y')
            else {                                                                          # If $OpConfirm does not equal 'y'
                Write-Host 'No action taken'                                                # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break RemoveAzureSFolder                                                    # Breaks :RemoveAzureSFolder
            }                                                                               # End else (if ($OpConfirm -eq 'y'))
        }                                                                                   # End :RemoveAzureSFolder while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End begin
}                                                                                           # End function RemoveAzStorageDirectory