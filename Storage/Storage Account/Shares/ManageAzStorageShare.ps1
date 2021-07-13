# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Mircosoft docs links
    New-AzStorageShare:         https://docs.microsoft.com/en-us/powershell/module/az.storage/new-azstorageshare?view=azps-5.3.0
    Get-AzStorageShare:         https://docs.microsoft.com/en-us/powershell/module/az.storage/get-azstorageshare?view=azps-5.3.0
    Remove-AzStorageShare:      https://docs.microsoft.com/en-us/powershell/module/az.storage/remove-azstorageshare?view=azps-5.3.0
    New-AzStorageDirectory:     https://docs.microsoft.com/en-us/powershell/module/az.storage/new-azstoragedirectory?view=azps-5.9.0
    Get-AzStorageFile:          https://docs.microsoft.com/en-us/powershell/module/az.storage/get-azstoragefile?view=azps-5.9.0
    Get-AzStorageFileContent:   https://docs.microsoft.com/en-us/powershell/module/az.storage/get-azstoragefilecontent?view=azps-5.9.0
    Remove-AzStorageFileContent:https://docs.microsoft.com/en-us/powershell/module/az.storage/remove-azstoragefilecontent?view=azps-5.9.0
    Get-AzStorageAccount:       https://docs.microsoft.com/en-us/powershell/module/az.storage/get-azstorageaccount?view=azps-5.2.0
    Get-AzResourceGroup:        https://docs.microsoft.com/en-us/powershell/module/az.resources/get-azresourcegroup?view=azps-5.1.0
} #>
<# Required Functions Links: {
    NewAzStorageShare:          https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Storage/Storage%20Account/Shares/NewAzStorageShare.ps1
    GetAzStorageShare:          https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Storage/Storage%20Account/Shares/GetAzStorageShare.ps1
    ListAzStorageShare:         https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Storage/Storage%20Account/Shares/ListAzStorageShare.ps1
    RemoveAzStorageShare:       https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Storage/Storage%20Account/Shares/RemoveAzStorageShare.ps1
    ManageAzStorageDirectory:   https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Storage/Storage%20Account/Shares/ManageAzStorageDirectory.ps1
        NewAzStorageDirectory:      https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Storage/Storage%20Account/Shares/NewAzStorageDirectory.ps1
        RemoveAzStorageDirectory:   https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Storage/Storage%20Account/Shares/RemoveAzStorageDirectory.ps1
        NavAzStorageShare:          https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Storage/Storage%20Account/Shares/NavAzStorageShare.ps1
        GetAzStorageShare:          https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Storage/Storage%20Account/Shares/GetAzStorageShare.ps1
        GetAzStorageAccount:        https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Storage/Storage%20Account/GetAzStorageAccount.ps1
        GetAzResourceGroup:         https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/GetAzResourceGroup.ps1
    ManageAzStorageFile:        https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Storage/Storage%20Account/Shares/ManageAzStorageFile.ps1    
        GetAzStorageFileContent:    https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Storage/Storage%20Account/Shares/GetAzStorageFileContent.ps1
        RemoveAzStorageFile:        https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Storage/Storage%20Account/Shares/RemoveAzStorageFile.ps1
        NavAzStorageShare:          https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Storage/Storage%20Account/Shares/NavAzStorageShare.ps1
        GetAzStorageShare:          https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Storage/Storage%20Account/Shares/GetAzStorageShare.ps1
        GetAzStorageAccount:        https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Storage/Storage%20Account/GetAzStorageAccount.ps1
        GetAzResourceGroup:         https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/GetAzResourceGroup.ps1
    GetAzStorageAccObject:      https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Storage/Storage%20Account/GetAzStorageAccount.ps1
    GetAzResourceGroup:         https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/GetAzResourceGroup.ps1
} #>
<# Functions Description: {
    ManageAzStorageShare:       Manages all functions for storage shares
    NewAzStorageShare:          Creates a new storage share
    GetAzStorageShare:          Gets a storage share
    ListAzStorageShare:         Lists all storage shares in a subscription
    RemoveAzStorageShare:       Removes a storage share
        ManageAzStorageDirectory:   Management function for storage share folders
        NewAzStorageDirectory:      Creates a storage share folder
        RemoveAzStorageDirectory:   Removes a storage share folder
        NavAzStorageShare:          Gets a storage share folder path
        GetAzStorageShare:          Gets a storage share object
        GetAzStorageAccount:        Gets the storage account object
        GetAzResourceGroup:         Gets resource group object
        GetAzStorageAccount:        Collects the storage account object
    ManageAzStorageFile:        Management function for storage share files
        GetAzStorageFileContent:    Downloads a storage share file
        RemoveAzStorageFile:        Removes a storage share file
        NavAzStorageShare:          Gets a storage share file path
        GetAzStorageShare:          Gets a storage share object
        GetAzStorageAccount:        Gets the storage account object
        GetAzResourceGroup:         Gets resource group object    
    GetAzResourceGroup:         Collects resource group object
} #>
<# Variables: {
    :ManageAzureStorageShare    Outer loop for managing function
    $OpSelect:                  Operator input for selecting function
    NewAzStorageShare{}         Creates $StorageShareObject
        GetAzStorageAccount{}       Gets $StorageAccObject
            GetAzResourceGroup{}        Gets $RGObject
    GetAzStorageShare{}         Gets $StorageShareObject               
        GetAzStorageAccount{}       Gets $StorageAccObject
            GetAzResourceGroup{}        Gets $RGObject
    ListAzStorageShare{}        Gets all storage shares
    RemoveAzStorageShare{}      Removes $StorageShareObject
        GetAzStorageShare{}         Gets $StorageShareObject
            GetAzStorageAccount{}       Gets $StorageAccObject
                GetAzResourceGroup{}        Gets $RGObject
    ManageAzStorageDirectory{}  Manages $StorageShareFolderObject
        NewAzStorageDirectory{}     Creates $StorageShareFolderObject
            GetAzStorageShare{}         Gets $StorageShareObject 
                GetAzStorageAccount{}       Gets $StorageAccObject
                    GetAzResourceGroup{}        Gets $RGObject
            NavAzStorageShare{}         Gets $StorageShareFolderObject
                GetAzStorageShare{}         Gets $StorageShareObject 
                    GetAzStorageAccount{}       Gets $StorageAccObject
                        GetAzResourceGroup{}        Gets $RGObject
        RemoveAzStorageDirectory{}  Removes $StorageShareFolderObject
            NavAzStorageShare{}         Gets $StorageShareFolderObject
                GetAzStorageShare{}         Gets $StorageShareObject 
                    GetAzStorageAccount{}       Gets $StorageAccObject
                        GetAzResourceGroup{}        Gets $RGObject
    ManageAzStorageFileContent{}Manages $StorageShareFileObject 
        GetAzStorageFileContent{}   Downloads $StorageShareFileObject
            NavAzStorageShare{}         Gets $StorageShareFileObject
                GetAzStorageShare{}         Gets $StorageShareObject 
                    GetAzStorageAccount{}       Gets $StorageAccObject
                        GetAzResourceGroup{}        Gets $RGObject
        RemoveAzStorageFile{}       Removes $StorageShareFileObject  
            NavAzStorageShare{}         Gets $StorageShareFileObject
                GetAzStorageShare{}         Gets $StorageShareObject 
                    GetAzStorageAccount{}       Gets $StorageAccObject
                        GetAzResourceGroup{}        Gets $RGObject
} #>
<# Process Flow {
    function
        Call ManageAzStorageShare > Get $null
            Call NewAzStorageShare > Get $StorageShareObject
                Call GetAzStorageAccount > Get $StorageAccObject
                    Call GetAzResourceGroup > Get $RGObject
                    End GetAzResourceGroup
                        Return GetAzStorageAccount > Send $RGObject
                End GetAzStorageAccount
                    Return NewAzStorageShare > Send $StorageAccObject
            End NewAzStorageShare      
                Return ManageAzStorageShare > Send $StorageShareObject
            Call GetAzStorageShare > Get $StorageShareObject
                Call GetAzStorageAccount > Get $StorageAccObject
                    Call GetAzResourceGroup > Get $RGObject
                    End GetAzResourceGroup
                        Return GetAzStorageAccount > Send $RGObject
                End GetAzStorageAccount
                    Return NewAzStorageShare > Send $StorageAccObject
            End GetAzStorageShare      
                Return ManageAzStorageShare > Send $StorageShareObject
            Call ListAzStorageShare > Get $null
            End ListAzStorageShare 
                Return ManageAzStorageShare > Send $null
            Call RemoveAzStorageShare > Get $null
                Call GetAzStorageShare > Get $StorageShareObject
                    Call GetAzStorageAccount > Get $StorageAccObject
                        Call GetAzResourceGroup > Get $RGObject
                        End GetAzResourceGroup
                            Return GetAzStorageAccount > Send $RGObject
                    End GetAzStorageAccount
                        Return NewAzStorageShare > Send $StorageAccObject
                End GetAzStorageShare
            End RemoveAzStorageShare      
                Return ManageAzStorageShare > Send $null            
            Call ManageAzStorageDirectory > Get $null
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
                    Return ManageAzStorageDirectory > Send $null 
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
                    Return ManageAzStorageDirectory > Send $null
            End ManageAzStorageDirectory
                Return ManageAzStorageShare > Send $null 
            Call ManageAzStorageFile > Get $null
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
                    Return ManageAzStorageFile > Send $null 
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
                    Return ManageAzStorageFile > Send $null 
            End ManageAzStorageFile
                Return ManageAzStorageShare > Send $null
        End ManageAzStorageShare
            Return function > Send $null
}#>
function ManageAzStorageShare {                                                             # Function to manage azure storage shares
    Begin {                                                                                 # Begin function
        :ManageAzureStorageShares while ($true) {                                           # Outer loop for managing function
            Write-Host 'Azure Storage Share Management'                                     # Write message to screen
            Write-Host '[0] Exit'                                                           # Write message to screen
            Write-Host '[1] New Storage Share'                                              # Write message to screen
            Write-Host '[2] List Storage Shares'                                            # Write message to screen
            Write-Host '[3] Remove Storage Share'                                           # Write message to screen
            Write-Host '[4] Manage Storage Share Folders'                                   # Write message to screen
            Write-Host '[5] Manage Storage Share Files'                                     # Write message to screen
            $OpSelect = Read-Host 'Option [#]'                                              # Operator input for selecting the management function
            if ($OpSelect -eq '0') {                                                        # If $OpSelect equals '0'
                Break ManageAzureStorageShares                                              # Breaks :ManageAzureStorageShares
            }                                                                               # End if ($OpSelect -eq '0')
            elseif ($OpSelect -eq '1') {                                                    # Else if $OpSelect equals '1'
                Write-Host 'New Storage Share'                                              # Write message to screen
                NewAzStorageShare                                                           # Calls function
            }                                                                               # End elseif ($OpSelect -eq '1')
            elseif ($OpSelect -eq '2') {                                                    # Else if $OpSelect equals '2'
                Write-Host 'List Storage Shares'                                            # Write message to screen
                ListAzStorageShares                                                         # Calls function
            }                                                                               # End elseif ($OpSelect -eq '2')
            elseif ($OpSelect -eq '3') {                                                    # Else if $OpSelect equals '3'
                Write-Host 'Remove Storage Share'                                           # Write message to screen
                RemoveAzStorageShare                                                        # Calls function
            }                                                                               # End elseif ($OpSelect -eq '3')
            elseif ($OpSelect -eq '4') {                                                    # Else if $OpSelect equals '4'
                Write-Host 'Manage Storage Share Folders'                                   # Write message to screen
                ManageAzStorageDirectory                                                    # Calls function
            }                                                                               # End elseif ($OpSelect -eq '4')
            elseif ($OpSelect -eq '4') {                                                    # Else if $OpSelect equals '5'
                Write-Host 'Manage Storage Share Files'                                     # Write message to screen
                ManageAzStorageFile                                                         # Calls function
            }                                                                               # End elseif ($OpSelect -eq '5')
            else {                                                                          # All other inputs for $OpSelect
                Write-Host 'That was not a valid input'                                     # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Clear-Host                                                                  # Clears screen
            }                                                                               # End else (if ($OpSelect -eq '0'))
        }                                                                                   # End :ManageAzureStorageShares while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End begin
}                                                                                           # End function ManageAzStorageShare
function NewAzStorageShare {                                                                # Function to create a new storage share
    Begin {                                                                                 # Begin function
        if (!$CallingFunction) {                                                            # If $CallingFunction is $null
            $CallingFunction = 'NewAzStorageShare'                                          # Creates $CallingFunction
        }                                                                                   # End if (!$CallingFunction)
        :NewAzureStorageShare while ($true) {                                               # Outer loop for managing function
            $StorageAccObject = GetAzStorageAccount ($CallingFunction)                      # Calls function and assigns output to $var
            if (!$StorageAccObject) {                                                       # If $StorageAccObject is $null
                Break NewAzureStorageShare                                                  # Breaks :NewAzureStorageShare
            }                                                                               # End if (!$StorageAccObject)
            :SetAzureShareName while ($true) {                                              # Inner loop for setting the name of the new share
                $ValidArray = 'abcdefghijklmnopqrstuvwxyz0123456789'                        # Creates a string of valid characters
                $ValidArray = $ValidArray.ToCharArray()                                     # Loads all valid characters into array
                Write-Host 'Storage share name must be atleast 3 characters'                # Write message to screen
                Write-Host 'and made up of letters and numbers only'                        # Write message to screen
                $ShareNameArray = $null                                                     # Clears $ShareNameArray
                $ShareNameInput = Read-Host 'Share name'                                    # Operator input for the share name
                $ShareNameInput = $ShareNameInput.ToLower()                                 # Recreates $ShareNameInput in lower
                $ShareNameArray = $ShareNameInput.ToCharArray()                             # Creates $ShareNameInput
                foreach ($_ in $ShareNameArray) {                                           # For each item in $ShareNameArray
                    if ($_ -notin $ValidArray) {                                            # If current item is not in $ValidArray
                        if ($_ -eq ' ') {                                                   # If current item equals 'space'
                            Write-Host ''                                                   # Write message to screen    
                            Write-Host 'Share name cannot include any spaces'               # Write message to screen
                        }                                                                   # End if ($_ -eq ' ')
                        else {                                                              # If current item is not equal to 'space'
                            Write-Host ''                                                   # Write message to screen    
                            Write-Host $_' is not a valid character'                        # Write message to screen
                        }                                                                   # End else (if ($_ -eq ' '))
                        $ShareNameInput = $null                                             # Clears $ShareNameInput
                    }                                                                       # End if ($_ -notin $ValidArray)
                }                                                                           # End foreach ($_ in $ShareNameArray)
                if (!$ShareNameInput) {                                                     # If $ShareNameInput is $null
                    Pause                                                                   # Pauses for operator input
                    Clear-Host                                                              # Clears screen
                }                                                                           # End if ($ShareNameInput -eq '0')
                else {                                                                      # If $ShareNameInput not equal to '0'
                    Write-Host $ShareNameInput 'is correct'                                 # Write message to screen
                    $OpConfirm = Read-Host '[Y] Yes [N] No [E] Exit'                        # Operator confirmation of share name input
                    if ($OpConfirm -eq 'e') {                                               # If $OpConfirm equals 'e'
                        Break NewAzureStorageShare                                          # Breaks NewAzureStorageShare
                    }                                                                       # End if ($OpConfirm -eq 'e')
                    if ($OpConfirm -eq 'y') {                                               # If $OpConfirm is equal to 'y'
                        Clear-Host                                                          # Clears screen
                        Break SetAzureShareName                                             # Breaks :SetAzureShareName
                    }                                                                       # End if ($OpConfirm -eq 'y')
                }                                                                           # End else (if (!$ShareNameInput))
            }                                                                               # End :SetAzureShareName while ($true)
            Try {                                                                           # Try the following
                New-AzStorageShare -Name $ShareNameInput -Context `
                    $StorageAccObject.Context -ErrorAction 'Stop'                           # Creates the storage share
            }                                                                               # End try
            catch {                                                                         # If try fails
                Write-Host 'An error has occured'                                           # Write message to screen
                Write-Host 'Check you permissions'                                          # Write message to screen
                Pause                                                                       # Pauses for operator input
                Break NewAzureStorageShare                                                  # Breaks NewAzureStorageShare
            }                                                                               # End catch
            Write-Host 'The share has been created'                                         # Write message to screen
            Pause                                                                           # Pauses for operator input
            Break NewAzureStorageShare                                                      # Breaks NewAzureStorageShare
        }                                                                                   # End :NewAzureStorageShare while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function NewAzStorageShare
Function ListAzStorageShare {                                                               # Function to list storage shares
    Begin {                                                                                 # Begin function
        :ListAzureStorageShare while ($true) {                                              # Outer loop for managing function
            Write-Host 'Getting shares list, this may take a moment'                        # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            $RGList = Get-AzResourceGroup                                                   # Gets a list of all resource groups
            foreach ($_ in $RGList) {                                                       # For each item in $RGList
                $RGObject = $_.ResourceGroupName                                            # $RGObject is equal to current item .ResourceGroupName
                $StorageAccList = Get-AzStorageAccount -ResourceGroupName $RGObject         # Gets a list of all storage accounts on $RGObject
                if (!$StorageAccList) {                                                     # If $StorageAccList is $null
                    Write-Host 'Resource Group: ' $RGObject                                 # Write message to screen
                    Write-Host 'StorageAccount:  None'                                      # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                }                                                                           # End if ($StorageAccList)
                else {                                                                      # If $StorageAccList has a value
                    foreach ($_ in $StorageAccList) {                                       # For each item in $StorageAccList
                        $StorageAccObject = Get-AzStorageAccount -Name `
                            $_.StorageAccountName -ResourceGroupName $RGObject              # Pulls the full storage account context
                        $StorageShareList = Get-AzStorageShare -Context `
                            $StorageAccObject.Context                                       # Pulls a list for storage shares on $StorageAccObject
                        if (!$StorageShareList) {                                           # If $StorageShareList is $null
                            Write-Host 'Resource Group: ' $RGObject                         # Write message to screen
                            Write-Host 'Storage Account:' `
                                $StorageAccObject.StorageAccountName                        # Write message to screen
                            Write-Host 'Storage Share:   None'                              # Write message to screen
                            Write-Host ''                                                   # Write message to screen
                        }                                                                   # End if (!$StorageShareList)
                        else {                                                              # If $StorageShareList is not $null
                            [System.Collections.ArrayList]$ObjectArray=@()                  # Creates $ObjectArray
                            foreach ($_ in $StorageShareList) {                             # For each item in $ObjectList
                                $ObjectInput = [PSCustomObject]@{'Name'=$_.Name;`
                                    'QU'=$_.Quota;'LM'=$_.LastModified;`
                                    'IsSnap'=$_.IsSnapshot;'SST'=$_.SnapShotTime}           # Creates $ObjectInput
                                $ObjectArray.Add($ObjectInput) | Out-Null                   # Loads content of $ObjectInput into $ObjectArray
                            }                                                               # End foreach ($_ in $OpSelect)
                            foreach ($_ in $ObjectArray) {                                  # For each item in $ObjectArray
                                Write-Host 'Resource Group: ' $RGObject                     # Write message to screen
                                Write-Host 'Storage Account:' `
                                $StorageAccObject.StorageAccountName                        # Write message to screen
                                Write-Host 'Share Name:     '  $_.Name                      # Write message to screen
                                Write-Host 'QuotaGiB:       '$_.QU                          # Write message to screen
                                Write-Host 'Last Mod:       '$_.LM                          # Write message to screen
                                if ($_.IsSnap -eq 'True') {                                 # If current item .IsSnap is equal to true
                                    Write-Host 'SnapshotTime:   '$_.SST                     # Write message to screen
                                }                                                           # End if ($_.IsSnap -eq 'True')
                                Write-Host ''                                               # Write message to screen
                            }                                                               # End foreach ($_ in $ObjectArray)
                        }                                                                   # End else (if (!$StorageShareList))
                    }                                                                       # End foreach ($_ in $StorageAccList)
                }                                                                           # End else (if ($StorageAccList))
            }                                                                               # End foreach ($_ in $RGList)
            Pause                                                                           # Pauses for operator input
            Break ListAzureStorageShare                                                     # Breaks :ListAzureStorageShare
        }                                                                                   # End :ListAzureStorageShare while ($true)
        Clear-Host                                                                          # Clears Screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End Function ListAzStorageShare
Function GetAzStorageShare {                                                                # Function to get a storage share
    Begin {                                                                                 # Begin function
        :GetAzureStorageShare while ($true) {                                               # Outer loop for managing function
            $StorageAccObject = GetAzStorageAccount ($CallingFunction)                      # Calls function and assigns output to $var
            if (!$StorageAccObject) {                                                       # If $StorageAccObject is $null
                Break GetAzureStorageShare                                                  # Breaks :GetAzureStorageShare
            }                                                                               # End if (!$StorageAccObject) 
            $ObjectList = Get-AzStorageShare -Context $StorageAccObject.Context             # Collects all shares in selected storage account
            if (!$ObjectList) {                                                             # If $ObjectList returns empty
                Write-Host 'No storage shares found'                                        # Message write to screen
                Write-Host 'on storage account'$StorageAccObject.StorageAccountName         # Message write to screen
                Pause                                                                       # Pauses all action for operator input
                Break GetAzureStorageShare                                                  # Breaks :GetAzureStorageShare
            }                                                                               # End if (!$ObjectList)
            $ObjectNumber = 1                                                               # Sets $ObjectNumber
            [System.Collections.ArrayList]$ObjectArray=@()                                  # Creates $ObjectArray
            foreach ($_ in $ObjectList) {                                                   # For each item in $ObjectList
                $ObjectInput = [PSCustomObject]@{'Number'=$ObjectNumber;'Name'=$_.Name;`
                    'QU'=$_.Quota;'LM'=$_.LastModified;'IsSnap'=$_.IsSnapshot;`
                    'SST'=$_.SnapShotTime}                                                  # Creates $ObjectInput
                $ObjectArray.Add($ObjectInput) | Out-Null                                   # Loads content of $ObjectInput into $ObjectArray
                $ObjectNumber = $ObjectNumber + 1                                           # Increments $ObjectNumber up by 1
            }                                                                               # End foreach ($_ in $OpSelect)
            Write-Host '[0] Exit'                                                           # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            foreach ($_ in $ObjectArray) {                                                  # For each item in $ObjectArray
                $Number = $_.Number                                                         # $Number is equal to current item .Number
                if ($Number -le 9) {                                                        # If $Number is 9 or less
                    Write-Host "[$Number]:         " $_.Name                                # Write message to screen
                }                                                                           # End if ($Number -le 9)
                else {                                                                      # If $Number is 10 or more
                    Write-Host "[$Number]:        " $_.Name                                 # Write message to screen
                }                                                                           # End else (if ($Number -le 9))
                Write-Host 'QuotaGiB:    '$_.QU                                             # Write message to screen
                Write-Host 'Last Mod:    '$_.LM                                             # Write message to screen
                if ($_.IsSnap -eq 'True') {                                                 # If current item .IsSnap is equal to true
                    Write-Host 'SnapshotTime:'$_.SST                                        # Write message to screen
                }                                                                           # End if ($_.IsSnap -eq 'True')
                Write-Host ''                                                               # Write message to screen
            }                                                                               # End foreach ($_ in $ObjectArray)
            :SelectAzureStorageShare while ($true) {                                        # Inner loop for selecting the storage share
                if ($CallingFunction) {                                                     # If $Calling function has a value
                    Write-Host 'You are selecting the storage share for:'$CallingFunction   # Write message to screen
                }                                                                           # End if ($CallingFunction)
                $OpSelect = Read-Host 'Enter the storage share [#]'                         # Operator input for the storage share selection
                if ($OpSelect -eq '0') {                                                    # If $OpSelect is equal to '0'
                    Break GetAzureStorageShare                                              # Breaks :GetAzureStorageShare
                }                                                                           # End if ($OpSelect -eq '0')
                elseif ($OpSelect -in $ObjectArray.Number) {                                # If $OpSelect in $ObjectArray.Number
                    $OpSelect = $ObjectArray | Where-Object {$_.Number -eq $OpSelect}       # $OpSelect is equal to $ObjectArray where $ObjectArray.Number equals $OpSelect
                    $StorageShareObject = Get-AzStorageShare -Name $OpSelect.Name -Context `
                    $StorageAccObject.Context                                               # Collects the full storage share object
                    if ($StorageShareObject) {                                              # If $StorageShareObject has a value
                        Clear-Host                                                          # Clears screen
                        Return $StorageShareObject, $StorageAccObject                       # Returns to $CallingFunction with $vars
                    }                                                                       # End if ($StorageShareObject)
                    else {                                                                  # If $StorageShareObject does not have a value
                        Write-Host 'An error has occured'                                   # Write message to screen
                        Pause                                                               # Pauses for operator input
                        Break GetAzureStorageShare                                          # End Break GetAzureStorageShare
                    }                                                                       # End else (if ($StorageShareObject))
                }                                                                           # End elseif ($OpSelect -in $ObjectArray.Number)
                else {                                                                      # All other inputs for $OpSelect
                    Write-Host 'That was not a valid option'                                # Write message to screen
                }                                                                           # End if ($OpSelect -eq '0')
            }                                                                               # End :SelectAzureStorageShare while ($true) 
        }                                                                                   # End :GetAzureStorageShare while ($true)
        Clear-Host                                                                          # Clears Screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End Function GetAzStorageShare
function RemoveAzStorageShare {                                                             # Function to remove a storage share
    Begin {                                                                                 # Begin function
        $ErrorActionPreference='silentlyContinue'                                           # Disables error reporting
        if (!$CallingFunction) {                                                            # If $CallingFunction does not have a value
            $CallingFunction = 'RemoveAzStorageShare'                                       # Creates $CallingFunction
        }                                                                                   # End if (!$CallingFunction)
        :RemoveAzureStorageShare while ($true) {                                            # Outer loop for managing function
            $StorageShareObject, $StorageAccObject = GetAzStorageShare ($CallingFunction)   # Calls function and assigns output to $vars
            if (!$StorageShareObject) {                                                     # If $StorageShareObject is $null
                Break RemoveAzureStorageShare                                               # Breaks :RemoveAzureStorageShare
            }                                                                               # End if (!$StorageShareObject)
            Write-Host 'Remove the share:    '$StorageShareObject.Name                      # Write message to screen
            Write-Host 'From storage account:'$StorageAccObject.StorageAccountName          # Write message to screen
            $OpConfirm = Read-Host '[Y] Yes [N] No'                                         # Operator confirmation to remove the share
            if ($OpConfirm -eq 'y') {                                                       # If OpConfirm equals 'y'
                Try {                                                                       # Try the following
                    Remove-AzStorageShare -Name $StorageShareObject.Name -Context `
                        $StorageAccObject.Context -ErrorAction 'Stop'                       # Removes the share
                }                                                                           # End try
                Catch {                                                                     # If try fails
                    Write-Host 'An error has occured'                                       # Write message to screen
                    Write-Host 'Check you permissions'                                      # Write message to screen
                    Write-Host 'A lock or policy may'                                       # Write message to screen
                    Write-Host 'have prevented this action'                                 # Write message to screen
                    Pause                                                                   # Pauses action for operator input
                    Break RemoveAzureStorageShare                                           # Breaks :RemoveAzureStorageShare
                }                                                                           # End catch
                Write-Host 'The selected share has been removed'                            # Write message to screen
                Pause                                                                       # Pauses action for operator input
                Break RemoveAzureStorageShare                                               # Breaks :RemoveAzureStorageShare
            }                                                                               # End if ($OpConfirm -eq 'y')
            else {                                                                          # All other inputs for $OpConfirm
                Break RemoveAzureStorageShare                                               # Breaks :RemoveAzureStorageShare
            }                                                                               # End else (if ($OpConfirm -eq 'y'))
        }                                                                                   # End :RemoveAzureStorageShare while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function RemoveAzStorageShare
function ManageAzStorageDirectory {                                                         # Function to manage folders in storage share
    Begin {                                                                                 # Begin function
        :ManageAzureSFolder while ($true) {                                                 # Outer loop for managing function
            Write-Host '[0] Exit'                                                           # Write message to screen
            Write-Host '[1] Create new folder'                                              # Write message to screen
            Write-Host '[2] Remove folder'                                                  # Write message to screen               
            $OpSelect = Read-Host 'Option [#]'                                              # Operator input for selecting the management function
            Clear-Host                                                                      # Clears screen
            if ($OpSelect -eq '0') {                                                        # If $OpSelect equals '0'
                Break ManageAzureSFolder                                                    # Breaks :ManageAzureSFolder
            }                                                                               # End if ($OpSelect -eq '0')
            elseif ($OpSelect -eq '1') {                                                    # Else if $OpSelect equals '1'
                Clear-Host                                                                  # Clears screen
                NewAzStorageDirectory                                                       # Calls function
            }                                                                               # End elseif ($OpSelect -eq '1')
            elseif ($OpSelect -eq '1') {                                                    # Else if $OpSelect equals '2'
                Clear-Host                                                                  # Clears screen
                RemoveAzStorageDirectory                                                    # Calls function
            }                                                                               # End elseif ($OpSelect -eq '2')
            else {                                                                          # All other inputs for $OpSelect
                Write-Host 'That was not a valid input'                                     # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Clear-Host                                                                  # Clears screen
            }                                                                               # End else (if ($OpSelect -eq '0'))
        }                                                                                   # End :ManageAzureSFolder while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function ManageAzStorageDirectory
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
function ManageAzStorageFile {                                                              # Function to manage files in storage share
    Begin {                                                                                 # Begin function
        :ManageAzureSFile while ($true) {                                                   # Outer loop for managing function
            Write-Host '[0] Exit'                                                           # Write message to screen
            Write-Host '[1] Download file'                                                  # Write message to screen
            Write-Host '[2] Remove file'                                                    # Write message to screen               
            $OpSelect = Read-Host 'Option [#]'                                              # Operator input for selecting the management function
            Clear-Host                                                                      # Clears screen
            if ($OpSelect -eq '0') {                                                        # If $OpSelect equals '0'
                Break ManageAzureSFile                                                      # Breaks :ManageAzureSFile
            }                                                                               # End if ($OpSelect -eq '0')
            elseif ($OpSelect -eq '1') {                                                    # Else if $OpSelect equals '1'
                Clear-Host                                                                  # Clears screen
                GetAzStorageFileContent                                                     # Calls function
            }                                                                               # End elseif ($OpSelect -eq '1')
            elseif ($OpSelect -eq '1') {                                                    # Else if $OpSelect equals '2'
                Clear-Host                                                                  # Clears screen
                RemoveAzStorageFile                                                         # Calls function
            }                                                                               # End elseif ($OpSelect -eq '2')
            else {                                                                          # All other inputs for $OpSelect
                Write-Host 'That was not a valid input'                                     # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Clear-Host                                                                  # Clears screen
            }                                                                               # End else (if ($OpSelect -eq '0'))
        }                                                                                   # End :ManageAzureSFolder while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function ManageAzStorageFile
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
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End begin
}                                                                                           # End function GetAzStorageFileContent
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
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End begin
}                                                                                           # End function RemoveAzStorageFile
Function NavAzStorageShare {                                                                # Function get a storage share file path
    Begin {                                                                                 # Begin function
        $StorageShareObject, $StorageAccObject = GetAzStorageShare                          # Calls function and assigns output to $vars
        :SelectAzureShareFolder while ($true) {                                             # Outer loop for managing function
            if (!$StorageShareObject) {                                                     # If $StorageShareObject is $null
                Break SelectAzureShareFolder                                                # Breaks :SelectAzureStorageShareFolder
            }                                                                               # End if (!$StorageShareObject)                                                       
            :GetShareRoot while ($true) {                                                   # Inner loop for selecting the share root folder
                [System.Collections.ArrayList]$ObjectArray=@()                              # Creates $ObjectArray
                $RootFolders = Get-AzStorageFile -ShareName $StorageShareObject.Name `
                    -Context $StorageAccObject.Context | Where-Object `
                    {$_.GetType().Name -eq "AzureStorageFileDirectory"}                     # Collects all folders in root of share
                $ObjectNumber = 1                                                           # Creates $ObjectNumber
                foreach ($_ in $RootFolders) {                                              # For each item in $RootFolders
                    $ObjectInput = [PSCustomObject]@{'Name'=$_.Name;'Number'=$ObjectNumber} # Creates $ObjectInputs
                    $ObjectArray.Add($ObjectInput) | Out-Null                               # Loads $ObjectInput into $ObjectArray
                    $ObjectNumber = $ObjectNumber + 1                                       # Increments $ObjectNumber up by 1
                }                                                                           # End foreach ($_ in $RootFolders)
                :SelectShareRoot while ($true) {                                            # Inner loop to select root folder
                    Write-Host '[0]  Exit'                                                  # Write message to screen
                    foreach ($_ in $ObjectArray) {                                          # For each item in $ObjectArray
                        $Number = $_.Number                                                 # $Number is equal to current item .Number
                        if ($Number -le 9) {                                                # If $Number is less than 10 
                            Write-Host "[$Number] "$_.Name                                  # Write message to screen
                        }                                                                   # End if ($Number -le 9)                                                  
                        else {                                                              # If $Number is greater than 9
                            Write-Host "[$Number]"$_.Name                                   # Write message to screen
                        }                                                                   # End else (if ($Number -le 9))
                    }                                                                       # End foreach ($_ in $ObjectArray)
                    $OpSelect = Read-Host 'Select folder [#]'                               # Operator input for selecting the root folder
                    if ($OpSelect -eq '0') {                                                # If $OpSelect equals '0'
                        Break SelectAzureShareFolder
                    }                                                                       # End if ($OpSelect -eq '0')
                    elseif ($OpSelect -in $ObjectArray.Number) {                            # Else if $OpSelect in $ObjectArray.Number
                        $Path = $ObjectArray | Where-Object {$_.Number -eq $OpSelect}       # $Path is equal $ObjectArray where $ObjectArray.Number equals $OpSelect
                        $Path = $Path.name                                                  # $Path is equal to $Path.
                        Clear-Host                                                          # Clears screen
                        Break GetShareRoot                                                  # Breaks :GetShareRoot
                    }                                                                       # End elseif ($OpSelect -in $ObjectArray.Number)
                    else {                                                                  # All other inputs for $OpSelect
                        Write-Host 'That was not a valid option'                            # Write message to screen
                    }                                                                       # End else (if ($OpSelect -eq '0'))
                }                                                                           # End :SelectShareRoot while ($true)
            }                                                                               # End :GetShareRoot while ($true) {
            :SelectSubFolder while ($true) {                                                # Inner loop for selecting subfolder
                $ObjectNumber = 1                                                           # Recreates $ObjectNumber
                [System.Collections.ArrayList]$ObjectArray2=@()                             # Creates $ObjectArray2
                [System.Collections.ArrayList]$ObjectArray3=@()                             # Creates $ObjectArray3
                $SubFolders = Get-AzStorageFile -Path $Path -ShareName `
                    $StorageShareObject.Name -Context $StorageAccObject.Context | `
                    Get-AzStorageFile | Where-Object `
                    {$_.GetType().Name -eq "AzureStorageFileDirectory"}                     # Gets a list of all folders in $Path
                $SubFiles = Get-AzStorageFile -Path $Path -ShareName `
                    $StorageShareObject.Name -Context $StorageAccObject.Context | `
                    Get-AzStorageFile | Where-Object `
                    {$_.GetType().Name -ne "AzureStorageFileDirectory"}                     # Gets a list of all files in $Path
                foreach ($_ in $SubFolders) {                                               # For each item in $SubFolders
                    $ObjectInput = [PSCustomObject]@{'Name'=$_.Name;'Number'=$ObjectNumber} # Recreats $ObjectInput
                    $ObjectArray2.Add($ObjectInput) | Out-Null                              # Loads $ObjectInput into $ObjectArray2
                    $ObjectNumber = $ObjectNumber + 1                                       # Increments $ObjectNumber up by 1
                }                                                                           # End foreach ($_ in $SubFolders)
                $ObjectNumber = 1                                                           # Recreates $ObjectNumber
                foreach ($_ in $SubFiles) {                                                 # For each item in $SubFiles
                    $ObjectInput = [PSCustomObject]@{'Name'=$_.Name;'Number'=$ObjectNumber} # Recreats $ObjectInput
                    $ObjectArray3.Add($ObjectInput) | Out-Null                              # Loads $ObjectInput into $ObjectArray3
                    $ObjectNumber = $ObjectNumber + 1                                       # Increments $ObjectNumber up by 1
                }                                                                           # End foreach ($_ in $RootFolders)
                Write-Host ''                                                               # Write message to screen
                Write-Host 'Current folders in'$Path                                        # Write message to screen
                Write-Host ''                                                               # Write message to screen
                if ($ObjectArray2) {                                                        # If $ObjectArray2 has a valid
                    foreach ($_ in $ObjectArray2) {                                         # For each item in $ObjectArray2
                        Write-Host $_.Name                                                  # Write message to screen
                    }                                                                       # End foreach ($_ in $ObjectArray2)
                }                                                                           # End if ($ObjectArray2)
                else {                                                                      # If $ObjectArray2 does not have a value
                    Write-Host 'No folders exist'                                           # Write message to screen
                }                                                                           # End else (if ($ObjectArray2))
                Write-Host ''                                                               # Write message to screen
                Write-Host 'Current files in'$Path                                          # Write message to screen
                Write-Host ''                                                               # Write message to screen
                if ($ObjectArray3) {                                                        # If $ObjectArray3 has a value
                    foreach ($_ in $ObjectArray3) {                                         # Foreach item in $ObjectArray3
                        Write-Host $_.Name                                                  # Write message to screen
                    }                                                                       # End foreach ($_ in $ObjectArray3)
                }                                                                           # End if ($ObjectArray3)
                else {                                                                      # If $ObjectArray3 does not have a value
                    Write-Host 'No files exist'                                             # Write message to screen
                }                                                                           # End else (if ($ObjectArray3))
                Write-Host ''                                                               # Write message to screen
                Write-Host '[0]  Exit'                                                      # Write message to screen
                Write-Host '[1]  Go down a folder'                                          # Write message to screen
                Write-Host '[2]  Go up a folder'                                            # Write message to screen
                Write-Host '[3]  Select current folder for action'                          # Write message to screen
                Write-Host '[4]  Select a file in folder for action'                        # Write message to screen
                Write-Host '[5]  Select new root folder'                                    # Write message to screen
                $OpSelect = Read-Host 'Select option [#]'                                   # Operator input to select action
                Clear-Host                                                                  # Clears screen
                if ($OpSelect -eq '0') {                                                    # If $OpSelect equals '0'
                    Break SelectAzureShareFolder                                            # Breaks :SelectAzureShareFolder
                }                                                                           # End if ($OpSelect -eq '0')
                elseif ($OpSelect -eq '1') {                                                # Else if $OpSelect equals '1'
                    :SelectShareSub while ($true) {                                         # Inner loop for selecting the sub folder 
                        Write-Host '[0]  Exit'                                              # Write message to screen
                        foreach ($_ in $ObjectArray2) {                                     # For each item in $ObjectArray2
                            $Number = $_.Number                                             # $Number is equal to current item .number
                            if ($Number -le 9) {                                            # If $Number is less than 10
                                Write-Host "[$Number] "$_.Name                              # Write message to screen
                            }                                                               # End if ($Number -le 9) 
                            else {                                                          # If $Number is greater than 9
                                Write-Host "[$Number]"$_.Name                               # Write message to screen
                            }                                                               # End else (if ($Number -le 9))
                        }                                                                   # End foreach ($_ in $ObjectArray2)
                        $OpSelect = Read-Host 'Select folder [#]'                           # Operator input to select folder
                        if ($OpSelect -eq '0') {                                            # If $OpSelect equals '0'
                            Break SelectAzureShareFolder                                    # Breaks :SelectAzureShareFolder    
                        }                                                                   # End if ($OpSelect -eq '0')
                        elseif ($OpSelect -in $ObjectArray2.Number) {                       # Else if $OpSelect in $ObjectArray2.Number
                            $UpdatedPath = $ObjectArray2 | Where-Object `
                                {$_.Number -eq $OpSelect}                                   # UpdatedPath is equal to $ObjectArray2 where $ObjectArray2.Number equals $OpSelect
                            $Path = $Path+'\'+$UpdatedPath.name                             # $Path is equal to $Path + '\' + $UpdatedPath.Name
                            Clear-Host                                                      # Clears screen
                            Break SelectShareSub                                            # Breaks :SelectShareSub
                        }                                                                   # End elseif ($OpSelect -in $ObjectArray.Number)
                        else {                                                              # All other inputs for $OpSelect
                            Write-Host 'That was not a valid option'                        # Write message to screen
                        }                                                                   # End else (if ($OpSelect -eq '0'))
                    }                                                                       # End :SelectShareSub while ($true) 
                }                                                                           # End elseif ($OpSelect -eq '1')
                elseif ($OpSelect -eq '2') {                                                # If $OpSelect equals '2'
                    if ($Path -in $ObjectArray.Name) {                                      # If $Path in $ObjectArray.Name
                        Break SelectSubFolder                                               # Breaks :SelectSubFolder
                    }                                                                       # End if ($Path -in $ObjectArray.Name)
                    else {                                                                  # If $Path not in $ObjectArray.Name
                        $Path = Split-Path $Path                                            # Updates the path by removing the last item
                    }                                                                       # End else (if ($Path -in $ObjectArray.Name))
                }                                                                           # End elseif ($OpSelect -eq '2')
                elseif ($OpSelect -eq '3') {                                                # If $OpSelect equals '4'
                    Write-Host 'Take action on:'$Path                                       # Write message to screen
                    $OpConfirm = Read-Host '[Y] Yes [N] No'                                 # Operator input to return to calling function
                    if ($OpConfirm -eq 'y') {                                               # If $OpConfirm equals 'y'
                        $StorageShareFolderObject = $Path                                   # $StorageShareFolderObject equals $Path                                   
                        Clear-Host                                                          # Clears screen
                            Return $StorageShareFolderObject, $StorageShareObject, `
                                $StorageAccObject                                           # Returns to $CallingFunction with $vars
                    }                                                                       # End if ($OpConfirm -eq 'y')
                }                                                                           # End elseif ($OpSelect -eq '3')
                elseif ($OpSelect -eq '4') {                                                # If $OpSelect equals '4'
                    :SelectShareFile while ($true) {                                        # Inner loop for selecting the file
                        Write-Host '[0]  Exit'                                              # Write message to screen
                        foreach ($_ in $ObjectArray3) {                                     # For each item in $ObjectArray3
                            $Number = $_.Number                                             # $Number is equal to current item .number
                            if ($Number -le 9) {                                            # If $Number is less than 10
                                Write-Host "[$Number] "$_.Name                              # Write message to screen
                            }                                                               # End if ($Number -le 9)
                            else {                                                          # If $Number is greater than 9
                                Write-Host "[$Number]"$_.Name                               # Write message to screen
                            }                                                               # End else (if ($Number -le 9))
                        }                                                                   # End foreach ($_ in $ObjectArray3)
                        if ($CallingFunction) {                                             # If $CallingFunction has a value
                            Write-Host 'You are selecting the file for:'$CallingFunction    # Write message to screen
                        }                                                                   # End if ($CallingFunction)
                        $OpSelect = Read-Host 'Select file [#]'                             # Operator input for selecting the file                           
                        if ($OpSelect -eq '0') {                                            # If $OpSelect equals '0'
                            Break SelectAzureShareFolder                                    # Breaks :SelectAzureShareFolder
                        }                                                                   # End if ($OpSelect -eq '0')
                        elseif ($OpSelect -in $ObjectArray3.Number) {                       # Else if $OpSelect in $ObjectArray3.Number
                            $FileName = $ObjectArray3 | Where-Object `
                                {$_.Number -eq $OpSelect}                                   # $FileName is equal to $ObjectArray3 where $ObjectArray3.Number equals $OpSelect
                            $FileName = $FileName.name                                      # $FileName is equal to $FileName.Name
                            $StorageShareFileObject = $Path+'\'+$FileName                   # Adds full path to filename
                            Clear-Host                                                      # Clears screen
                            Return $StorageShareFileObject, $StorageShareObject, `
                                $StorageAccObject                                           # Returns to $CallingFunction with $vars
                        }                                                                   # End elseif ($OpSelect -in $ObjectArray.Number)
                        else {                                                              # All other inputs for $OpSelect
                            Write-Host 'That was not a valid option'                        # Write message to screen
                        }                                                                   # End else (if ($OpSelect -eq '0'))
                    }                                                                       # End :SelectShareRoot while ($true)
                }                                                                           # End elseif ($OpSelect -eq '4')
                elseif ($OpSelect -eq '5') {                                                # If $OpSelect equals '5'
                    Break SelectSubFolder                                                   # Breaks :SelectSubFolder
                }                                                                           # End elseif ($OpSelect -eq '5')
                
                else {                                                                      # All other inputs for $OpSelect
                    Write-Host 'That was not a valid option'                                # Write message to screen
                }                                                                           # End else (if ($OpSelect -eq '0'))
            }                                                                               # End :SelectSubFolder while ($true)
        }                                                                                   # End :SelectAzureShareFolder while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function NavAzStorageShare
# Additional functions for ManageAzStorageShare
function GetAzResourceGroup {                                                               # Function to get a resource group
    Begin {                                                                                 # Begin function
        $ErrorActionPreference = 'silentlyContinue'                                         # Disables error reporting
        :GetAzureResourceGroup while ($true) {                                              # Outer loop for managing function
            $ObjectList = Get-AzResourceGroup                                               # Gets all resource groups and assigns to $ObjectList
            $ObjectNumber = 1                                                               # Sets $ObjectNumber to 1
            [System.Collections.ArrayList]$ObjectArray = @()                                # Creates the RG list array
            foreach ($_ in $ObjectList) {                                                   # For each $_ in $ObjectListList
                $ObjectInput = [PSCustomObject]@{'Name' = $_.ResourceGroupName; `
                    'Number' = $ObjectNumber; 'Location' = $_.Location}                     # Creates the item to loaded into array
                $ObjectArray.Add($ObjectInput) | Out-Null                                   # Loads item into array, out-null removes write to screen
                $ObjectNumber = $ObjectNumber + 1                                           # Increments $ObjectNumber by 1
            }                                                                               # End foreach ($_ in $ObjectList)
            Write-Host "[0]  Exit"                                                          # Write message to screen
            foreach ($_ in $ObjectArray) {                                                  # For each $_ in $ObjectArray
                $Number = $_.Number                                                         # Sets $Number to current item .number
                if ($_.Number -le 9) {                                                      # If current item .number is 9 or less
                    Write-Host "[$Number] "$_.Name "|" $_.Location                          # Write message to screen
                }                                                                           # End if ($_.Number -le 9) 
                else {                                                                      # If current item .number is greater then 9
                    Write-Host "[$Number]"$_.Name "|" $_.Location                           # Write message to screen
                }                                                                           # End else (if ($_.Number -le 9) )
            }                                                                               # End foreach ($_ in $ObjectArray)
            :SelectAzureObjectList while ($true) {                                          # Inner loop to select the resource group
                if ($CallingFunction) {                                                     # If $CallingFunction exists
                    Write-Host "You are selecting the resource group for"$CallingFunction   # Write message to screen
                }                                                                           # End if ($CallingFunction)
                $RGSelect = Read-Host "Enter the resource group number"                     # Operator input for the RG selection
                if ($RGSelect -eq '0') {                                                    # If $RGSelect equals 0
                    Break GetAzureResourceGroup                                             # Breaks :GetAzureResourceGroup
                }                                                                           # End if ($RGSelect -eq '0')
                elseif ($RGSelect -in $ObjectArray.Number) {                                # If $RGSelect in $ObjectArray.Number
                    $RGSelect = $ObjectArray | Where-Object {$_.Number -eq $RGSelect}       # $RGSelect is equal to $ObjectArray where $ObjectArray.Number is equal to $RGSelect                                  
                    $RGObject = Get-AzResourceGroup | Where-Object `
                        {$_.ResourceGroupName -eq $RGSelect.Name}                           # Pulls the full resource group object
                    Clear-Host                                                              # Clears screen
                    Return $RGObject                                                        # Returns to calling function with $RGObject
                }                                                                           # End elseif ($RGSelect -in $ListArray.Number)
                else {                                                                      # If $RGObject does not have a value
                    Write-Host "That was not a valid option"                                # Write message to screen
                }                                                                           # End else (if ($RGObject))
            }                                                                               # End :SelectAzureObjectList while ($true)
        }                                                                                   # End :GetAzureResourceGroup while ($true)
        Clear-Host                                                                          # Clears screen
        Return                                                                              # Returns to calling function with $null
    }                                                                                       # End begin statement
}                                                                                           # End function GetAzResourceGroup
function GetAzStorageAccount {                                                              # Function to get a storage account
    Begin {                                                                                 # Begin function
        $ErrorActionPreference = 'silentlyContinue'                                         # Disables errors
        if (!$CallingFunction) {                                                            # If $CallingFunction is $null
            $CallingFunction = 'GetAzStorageAccount'                                        # Creates $CallingFunction
        }                                                                                   # End if (!$CallingFunction)
        :GetAzureStorageAcc while ($true) {                                                 # Outer loop for managing function
            if (!$RGObject) {                                                               # If $RGObject is $null
                $RGObject = GetAzResourceGroup ($CallingFunction)                           # Calls function and assigns output to $var
                if (!$RGObject) {                                                           # If $RGObject is $null
                    Break GetAzureStorageACC                                                # Ends :GetAzureStorageAcc
                }                                                                           # End if (!$RGObject) | Inner
            }                                                                               # End if (!$RGObject) | Outer
            $ObjectList = Get-AzStorageAccount -ResourceGroupName `
                $RGObject.ResourceGroupName                                                 # Collects all storage accounts in $RGObject and assigns to $StorageAccList
            if (!$ObjectList) {                                                             # If $ObjectList is $null   
                Write-Host 'No storage accounts found on RG:'$RGObject.ResourceGroupName    # Write message to screen
                Start-Sleep(5)                                                              # Pauses all actions for 5 seconds
                Break GetAzureStorageACC                                                    # Ends :GetAzureStorageAcc
            }                                                                               # End if (!$StorageAccList)
            $ObjectNumber = 1                                                               # Sets $ObjectNumber to 1
            [System.Collections.ArrayList]$ObjectArray = @()                                # Creates the object array
            foreach ($_ in $ObjectList) {                                                   # For each $_ in $ObjectListList
                $ObjectInput = [PSCustomObject]@{'Name' = $_.StorageAccountName; `
                    'Number' = $ObjectNumber;'Sku'=$_.Sku.Name;'AccTier'=$_.AccessTier;`
                    'Location'=$_.PrimaryLocation}                                          # Creates the item to loaded into array
                $ObjectArray.Add($ObjectInput) | Out-Null                                   # Loads item into array, out-null removes write to screen
                $ObjectNumber = $ObjectNumber + 1                                           # Increments $ObjectNumber by 1
            }                                                                               # End foreach ($_ in $ObjectList)
            Write-Host "[0]  Exit"                                                          # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            foreach ($_ in $ObjectArray) {                                                  # For each $_ in $ObjectArray
                $Number = $_.Number                                                         # Sets $Number to current item .number
                if ($_.Number -le 9) {                                                      # If current item .number is 9 or less
                    Write-Host "[$Number] "$_.Name
                }                                                                           # End if ($_.Number -le 9) 
                else {                                                                      # If current item .number is greater then 9
                    Write-Host "[$Number]"$_.Name                                           # Write message to screen
                }                                                                           # End else (if ($_.Number -le 9) 
                Write-Host 'Primary Loc:'$_.Location                                        # Write message to screen
                Write-Host 'Sku Name:   '$_.Sku                                             # Write message to screen
                Write-Host 'Access Tier:'$_.AccTier                                         # Write message to screen
                Write-Host ''                                                               # Write message to screen
            }                                                                               # End foreach ($_ in $ObjectArray)
            :SelectAzureObjectList while ($true) {                                          # Inner loop to select the resource group
                if ($CallingFunction -and $CallingFunction -ne 'GetAzStorageAccount') {     # If $CallingFunction exists and not equal 'GetAzStorageAccount'
                    Write-Host "You are selecting the storage account for"$CallingFunction  # Write message to screen
                }                                                                           # End if ($CallingFunction -and $CallingFunction -ne 'GetAzStorageAccount')
                $ObjectSelect = Read-Host "Enter the storage account [#]"                   # Operator input for the storage account selection
                if ($ObjectSelect -eq '0') {                                                # If $ObjectSelect equals 0
                    Break GetAzureStorageAcc                                                # Breaks :GetAzureStorageAcc
                }                                                                           # End if ($ObjectSelect -eq '0')
                elseif ($ObjectSelect -in $ObjectArray.Number) {                            # If $ObjectSelect in $ObjectArray.Number
                    $ObjectSelect = $ObjectArray | Where-Object `
                        {$_.Number -eq $ObjectSelect}                                       # $ObjectSelect is equal to $ObjectArray where $ObjectArray.Number is equal to $ObjectSelect                                  
                    $StorageAccObject = Get-AzStorageAccount | Where-Object `
                        {$_.StorageAccountName -eq $ObjectSelect.Name}                      # Pulls the full storage account object
                    Clear-Host                                                              # Clears screen
                    Return $StorageAccObject                                                # Returns to calling function with $var
                }                                                                           # End elseif ($ObjectSelect -in $ListArray.Number)
                else {                                                                      # All other inputs for $ObjectSelect
                    Write-Host "That was not a valid option"                                # Write message to screen
                }                                                                           # End else (if ($ObjectSelect -eq '0'))
            }                                                                               # End :SelectAzureObjectList while ($true)
            if ($CallingFunction -and $CallingFunction -ne 'GetAzStorageAccount') {         # If $CallingFunction exists and not equal 'GetAzStorageAccount'
                Clear-Host                                                                  # Clears screen
                Return $StorageAccObject                                                    # Returns to calling function with $StorageAccObject
            }                                                                               # End if ($CallingFunction -and $CallingFunction -ne 'GetAzStorageAccount')
            else {                                                                          # If $Calling function does not exist or is equal to 'GetAzStorageAccount'
                Break GetAzureStorageAcc                                                    # Breaks :GetAzureStorageAcc  
            }                                                                               # End  else (if ($CallingFunction -and $CallingFunction -ne 'GetAzStorageAccount'))
        }                                                                                   # End :GetAzureStorageAcc while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End begin 
}                                                                                           # End function GetAzStorageAccount