# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Mircosoft docs links
    Get-AzStorageFile:          https://docs.microsoft.com/en-us/powershell/module/az.storage/get-azstoragefile?view=azps-5.9.0
    Get-AzStorageAccount:       https://docs.microsoft.com/en-us/powershell/module/az.storage/get-azstorageaccount?view=azps-5.2.0
    Get-AzResourceGroup:        https://docs.microsoft.com/en-us/powershell/module/az.resources/get-azresourcegroup?view=azps-5.1.0
} #>
<# Required Functions Links: {
    GetAzStorageShare:          https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Storage/Storage%20Account/Shares/GetAzStorageShare.ps1
    GetAzStorageAccount:        https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Storage/Storage%20Account/GetAzStorageAccount.ps1
    GetAzResourceGroup:         https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/GetAzResourceGroup.ps1
} #>
<# Functions Description: {
    NavAzStorageShare:          Gets a storage share file/folder path
    GetAzStorageShare:          Gets a storage share object
    GetAzStorageAccount:        Gets the storage account object
    GetAzResourceGroup:         Gets resource group object
} #>
<# Variables: {
    :SelectAzureShareFolder     Outer loop for managing function
    :GetShareRoot               Inner loop for getting the root folders of share
    :SelectShareRoot            Inner loop for selecting the root folder of share
    :SelectSubFolder            Inner loop for selecting an action in $Path
    :SelectShareSub             Inner loop for selecting a folder in $Path
    :SelectShareFile            Inner loop for selecting a file in $Path
    $StorageShareObject:        Storage share object
    $StorageAccObject:          Storage account object
    $ObjectArray:               Array used to select the root folder
    $RootFolders:               All folders in the root of $StorageShareObject
    $ObjectNumber:              $var used for listing and selecting items from $ObjectArray(1, 2, and 3)
    $ObjectInput:               $var used to load items into $ObjectArray(1, 2, and 3)
    $Number:                    Current item .Number, used for formatting
    $OpSelect:                  Operator input for all selections
    $Path:                      Current path in $StorageShareObject
    $ObjectArray2:              Array used to select a sub folder
    $ObjectArray3:              Array used to select a sub file
    $SubFolders:                List of all folders in $Path
    $SubFiles:                  List of all files in $path
    $FileName:                  Selected file name
    $StorageShareFileObject:    Combined path and file name
    GetAzStorageShare{}         Gets $StorageShareObject 
        GetAzStorageAccount{}       Gets $StorageAccObject
            GetAzResourceGroup{}        Gets $RGObject
} #>
<# Process Flow {
    function
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
            Return function > Send StorageShareFileObjectStorageShareFolderObject/, $StorageShareObject, $StorageAccObject
}#>
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
                Write-Host '[4]  Select a file in folded for action'                        # Write message to screen
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