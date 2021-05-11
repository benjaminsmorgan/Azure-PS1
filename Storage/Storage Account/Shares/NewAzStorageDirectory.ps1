# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Mircosoft docs links
    New-AzStorageDirectory:     https://docs.microsoft.com/en-us/powershell/module/az.storage/new-azstoragedirectory?view=azps-5.9.0
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
    NewAzStorageDirectory:      Creates a storage share folder
    NavAzStorageShare:          Gets a storage share folder path
    GetAzStorageShare:          Gets a storage share object
    GetAzStorageAccount:        Gets the storage account object
    GetAzResourceGroup:         Gets resource group object
} #>
<# Variables: {
    :NewAzureSFolder            Outer loop for managing function
    :SetAzureSFolderName        Inner loop for setting the new folder name
    $CallingFunction:           Name of this function or the one that called it
    $OpSelect:                  Operator input for selecting new folder location
    $StorageShareObject:        Storage share object
    $StorageAccObject:          Storage account object
    $FolderName:                Operator input of the new folder name
    $OpConfirm:                 Operator confirmation of the new folder name
    $StorageShareFolderObject:  Path for new folder if not in root of $StorageShareObject
    GetAzStorageShare{}         Gets $StorageShareObject 
        GetAzStorageAccount{}       Gets $StorageAccObject
            GetAzResourceGroup{}        Gets $RGObject
    NavAzStorageShare{}         Gets $StorageShareFolderObject
        GetAzStorageShare{}         Gets $StorageShareObject 
            GetAzStorageAccount{}       Gets $StorageAccObject
                GetAzResourceGroup{}        Gets $RGObject
} #>
<# Process Flow {
    function
        Call NewAzStorageDirectory > Get $null
            Call GetAzStorageShare > Get $$StorageShare
                Call GetAzStorageAccount > Get $StorageAccObject
                    Call GetAzResourceGroup > Get $RGObject
                    End GetAzResourceGroup
                        Return GetAzStorageAccount > Send $RGObject
                End GetAzStorageAccount 
                    Return GetAzStorageShare > Send $StorageAccObject
            End GetAzStorageShare 
                Return NewAzStorageDirectory > Send $StorageShare, $StorageAccObject
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
        End NewAzStorageDirectory
            Return function > Send $null 
}#>
function NewAzStorageDirectory {                                                            # Function for creating a folder in storage share
    Begin {                                                                                 # Begin function
        if (!$CallingFunction) {                                                            # If $CallingFunction does not have a value
            $CallingFunction = 'NewAzStorageDirectory'                                      # Creates $CallingFunction
        }                                                                                   # End if (!$CallingFunction)  
        :NewAzureSFolder while ($true) {                                                    # Outer loop for managing function
            Write-Host '[0] Exit'                                                           # Write message to screen
            Write-Host '[1] New root folder'                                                # Write message to screen
            Write-Host '[2] New sub folder'                                                 # Write message to screen
            Clear-Host                                                                      # Clears screen
            $OpSelect = Read-Host 'Option [#]'                                              # Operator input for selecting the folder type
            if ($OpSelect -eq '0') {                                                        # If $OpSelect equals '0'
                Break NewAzureSFolder                                                       # Breaks :NewAzureSFolder
            }                                                                               # End if ($OpSelect -eq '0')
            elseif ($OpSelect -eq '1') {                                                    # Else if $OpSelect equals '1'
                $StorageShareObject, $StorageAccObject = GetAzStorageShare `
                    ($CallingFunction)                                                      # Calls function and assigns output to $vars
                if (!$StorageShareObject) {                                                 # If $StorageShareObject does not have a value
                    Break NewAzureSFolder                                                   # Breaks :NewAzureSFolder
                }                                                                           # End if (!$StorageShareObject)
                :SetAzureSFolderName while ($true) {                                        # Inner loop for setting the folder name
                    $FolderName = Read-Host 'Enter the new folder name'                     # Operator input of the new folder name
                    Write-Host 'Use the name:'$FolderName                                   # Write message to screen
                    $OpConfirm = Read-Host '[Y] Yes [N] No [E] Exit'                        # Operator confirmation of the new folder name
                    if ($OpConfirm -eq 'e') {                                               # If $OpConfirm equals 'e'
                        Break NewAzureSFolder                                               # Breaks :NewAzureSFolder
                    }                                                                       # End if ($OpConfirm -eq 'e')
                    elseif ($OpConfirm -eq 'y') {                                           # Else if $OpConfirm equals 'y'
                        Break SetAzureSFolderName                                           # Breaks :SetAzureSFolderName
                    }                                                                       # End elseif ($OpConfirm -eq 'y')
                }                                                                           # End :SetAzureSFolderName while ($true)
                Try {                                                                       # Try the following
                    New-AzStorageDirectory -Path $FolderName -ShareName `
                        $StorageShareObject.Name -Context $StorageAccObject.Context `
                        -ErrorAction 'Stop'                                                 # Creates the new folder
                }                                                                           # End Try
                Catch {                                                                     # If Try fails
                    Write-Host 'An error has occured'                                       # Write message to screen
                    Write-Host 'The share maybe locked'                                     # Write message to screen
                    Pause                                                                   # Pauses all action for operator input
                    Break NewAzureSFolder                                                   # Breaks :NewAzureSFolder
                }                                                                           # End catch
                Write-Host 'The folder has been created'                                    # Write message to screen
                Pause                                                                       # Pauses all action for operator input
                Break NewAzureSFolder                                                       # Breaks :NewAzureSFolder
            }                                                                               # End elseif ($OpSelect -eq '1')
            elseif ($OpSelect -eq '2') {                                                    # Else if $OpSelect equals '2'
                $StorageShareFolderObject, $StorageShareObject, $StorageAccObject = `
                    NavAzStorageShare ($CallingFunction)                                    # Calls function and assigns output to $vars
                if (!$StorageShareFolderObject) {                                           # If $StorageShareFolderObject does not have a value
                    Break NewAzureSFolder                                                   # Breaks :NewAzureSFolder
                }                                                                           # End if (!$StorageShareObject)
                :SetAzureSFolderName while ($true) {                                        # Inner loop for setting the new folder name
                    $FolderName = Read-Host 'Enter the new folder name'                     # Operator input of the name
                    Write-Host 'Use the name:'$FolderName                                   # Write message to screen
                    $OpConfirm = Read-Host '[Y] Yes [N] No [E] Exit'                        # Operator confirmation of the name
                    if ($OpConfirm -eq 'e') {                                               # If $OpConfirm equals 'e'
                        Break NewAzureSFolder                                               # Breaks :NewAzureSFolder
                    }                                                                       # End if ($OpConfirm -eq 'e')
                    elseif ($OpConfirm -eq 'y') {                                           # Else if $OpConfirm equals 'y'
                        Break SetAzureSFolderName                                           # Breaks :SetAzureSFolderName
                    }                                                                       # End elseif ($OpConfirm -eq 'y')
                }                                                                           # End :SetAzureSFolderName while ($true)
                Try {                                                                       # Try the following
                    Get-AzStorageFile -Path $StorageShareFolderObject -ShareName `
                        $StorageShareObject.Name -Context $StorageAccObject.Context | `
                        New-AzStorageDirectory -Path $FolderName -ErrorAction 'Stop'        # Creates folder
                }                                                                           # End Try
                Catch {                                                                     # If Try fails
                    Write-Host 'An error has occured'                                       # Write message to screen
                    Write-Host 'The share maybe locked'                                     # Write message to screen
                    Pause                                                                   # Pauses all action for operator input
                    Break NewAzureSFolder                                                   # Breaks :NewAzureSFolder
                }                                                                           # End catch
                Write-Host 'The folder has been created'                                    # Write message to screen
                Pause                                                                       # Pauses all action for operator input
                Break NewAzureSFolder                                                       # Breaks :NewAzureSFolder
            }                                                                               # End elseif ($OpSelect -eq '2')
            else {                                                                          # All other inputs for $OpSelect
                Write-Host 'That was not a valid option'                                    # Write message to screen
            }                                                                               # End else (if ($OpSelect -eq '0'))
        }                                                                                   # End :NewAzureSFolder while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function NewAzStorageDirectory