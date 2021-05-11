# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Mircosoft docs links
    Remove-AzStorageFileContent:https://docs.microsoft.com/en-us/powershell/module/az.storage/remove-azstoragefilecontent?view=azps-5.9.0
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
    RemoveAzStorageFile:        Removes a storage share file
    NavAzStorageShare:          Gets a storage share file path
    GetAzStorageShare:          Gets a storage share object
    GetAzStorageAccount:        Gets the storage account object
    GetAzResourceGroup:         Gets resource group object
} #>
<# Variables: {
    :RemoveAzureSFile           Outer loop for managing function
    $CallingFunction:           Name of this function or the one that called it
    $StorageShareFileObject:    Path of the file to remove
    $StorageShareObject:        Storage share object
    $StorageAccObject:          Storage account object
    $OpConfirm                  Operator confirmation to remove the file
    NavAzStorageShare{}         Gets $StorageShareFileObject
        GetAzStorageShare{}         Gets $StorageShareObject 
            GetAzStorageAccount{}       Gets $StorageAccObject
                GetAzResourceGroup{}        Gets $RGObject
} #>
<# Process Flow {
    function
        Call RemoveAzStorageFile > Get $null
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
                Return RemoveAzStorageFile > Send StorageShareFileObject, $StorageShareObject, $StorageAccObject
        End RemoveAzStorageFile
            Return function > Send $null 
}#>
function RemoveAzStorageFile {                                                              # Function to remove a file from file share
    Begin {                                                                                 # Begin function
        if (!$CallingFunction) {                                                            # If $CallingFunction is $null
            $CallingFunction = 'RemoveAzStorageFile'                                        # Creates $Calling function
        }                                                                                   # End if (!$CallingFunction)
        :RemoveAzureSFile while ($true) {                                                   # Outer loop for managing function
            $StorageShareFileObject, $StorageShareObject, $StorageAccObject = `
                NavAzStorageShare ($CallingFunction)                                        # Calls function and assigns output to $var
            if (!$StorageShareFileObject) {                                                 # If $StorageShareFileObject is $null
                Break RemoveAzureSFile                                                      # Breaks :RemoveAzureSFile
            }                                                                               # End if (!$StorageShareFileObject)
            Write-Host 'Remove the file: '$StorageShareFileObject                           # Write message to screen
            Write-Host 'From file share: '$StorageShareObject.name                          # Write message to screen
            Write-Host 'From storage acc:'$StorageAccObject.StorageAccountName              # Write message to screen
            $OpConfirm = Read-Host '[Y] Yes [N] No'                                         # Operator confirmation to remove the file
            if ($OpConfirm -eq 'y') {                                                       # If $OpConfirm equals 'y'
                Try {                                                                       # Try the following
                    Remove-AzStorageFile -ShareName $StorageShareObject.Name -Path `
                        $StorageShareFileObject -Context $StorageAccObject.Context `
                        -ErrorAction 'Stop'                                                 # Removes the file
                }                                                                           # End try
                catch {                                                                     # If try fails
                    Write-Host 'An error has occured'                                       # Write message to screen
                    Write-Host 'The source file may be locked'                              # Write message to screen
                    Pause                                                                   # Pauses all actions for operator input
                    Break RemoveAzureSFile                                                  # Breaks :RemoveAzureSFile
                }                                                                           # End catch
                Write-Host 'The file has been removed'                                      # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break RemoveAzureSFile                                                      # Breaks :RemoveAzureSFile
            }                                                                               # End if ($OpConfirm -eq 'y')
            else {                                                                          # If $OpConfirm does not equal 'y'
                Write-Host 'No action taken'                                                # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Break RemoveAzureSFile                                                      # Breaks :RemoveAzureSFile
            }                                                                               # End else (if ($OpConfirm -eq 'y'))
        }                                                                                   # End :RemoveAzureSFile while ($true)
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End begin
}                                                                                           # End function RemoveAzStorageFile