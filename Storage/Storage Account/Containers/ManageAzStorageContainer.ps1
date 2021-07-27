# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Microsoft docs links
    New-AzStorageContainer:     https://docs.microsoft.com/en-us/powershell/module/az.storage/new-azstoragecontainer?view=azps-5.2.0
    Get-AzStorageContainer:     https://docs.microsoft.com/en-us/powershell/module/az.storage/get-azstoragecontainer?view=azps-5.2.0
    Remove-AzStorageContainer:  https://docs.microsoft.com/en-us/powershell/module/az.storage/remove-azstoragecontainer?view=azps-5.2.0
    Get-AzStorageAccount:       https://docs.microsoft.com/en-us/powershell/module/az.storage/get-azstorageContainer?view=azps-5.2.0
    Get-AzResourceGroup:        https://docs.microsoft.com/en-us/powershell/module/az.resources/get-azresourcegroup?view=azps-5.1.0
} #>
<# Required Functions Links: {
    NewAzStorageContainer:      https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Storage/Storage%20Account/Containers/NewAzStorageContainer.ps1
    ListAzStorageContainer:     https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Storage/Storage%20Account/Containers/ListAzStorageContainer.ps1
    GetAzStorageContainer:      https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Storage/Storage%20Account/Containers/GetAzStorageContainer.ps1
    RemoveAzStorageContainer:   https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Storage/Storage%20Account/Containers/RemoveAzStorageContainer.ps1
    GetAzStorageAccount:        https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Storage/Storage%20Container/GetAzStorageContainer.ps1
    GetAzResourceGroup:         https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/GetAzResourceGroup.ps1
} #>
<# Functions Description: {
    ManageAzStorageContainer:   Management function for storage containers
    NewAzStorageContainer:      Creates new storage container(s) in a storage account
    ListAzStorageContainer:     Lists all storage containers by storage account 
    GetAzStorageContainer:      Collects storage container in a storage account  
    RemoveAzStorageContainer:   Removes existing storage container
    GetAzStorageAccount:        Collects the storage Container object
    GetAzResourceGroup:         Collects resource group object
} #>
<# Variables: {
    :ManageAzureStorageCon      Outer loop for function
    $OpSelect:        Operator input for choosing sub function
    NewAzStorageContainer{}     Function for creating new storage containers
        GetAzStorageAccount{}       Gets $StorageAccObject
            GetAzResourceGroup{}        Gets $RGObject
    ListAzStorageContainer{}    Lists all storage container by accounts
    RemoveAzStorageContainer{}  Removes $StorageConObject
        GetAzStorageContainer{}     Gets $StorageConObject
            GetAzStorageAccount{}       Gets $StorageAccObject
                GetAzResourceGroup{}        Gets $RGObject
} #>
<# Process Flow {
    function
        Call ManageAzStorageContainer > Get $null
            Call NewAzStorageContainer > Get $null
                Call GetAzStorageAccount > Get $StorageAccObject
                    Call GetAzResourceGroup > Get $RGObject
                    End GetAzResourceGroup
                        Return GetAzStorageAccount > Send $RGObject
                End GetAzStorageAccount 
                    Return NewAzStorageContainer > Send $StorageAccObject
            End NewAzStorageContainer 
                Return ManageAzStorageContainer > Send $null
            Call ListAzStorageContainer > Get $null
            End ListAzStorageContainer
                Return ManageAzStorageContainer > Send $null
            Call RemoveAzStorageContainer > Get $null
                Call GetAzStorageContainer > Get $StorageConObject
                    Call GetAzStorageAccount > Get $StorageAccObject
                        Call GetAzResourceGroup > Get $RGObject
                        End GetAzResourceGroup
                            Return GetAzStorageAccount > Send $RGObject
                    End GetAzStorageAccount
                        Return GetAzStorageContainer > Send $StorageAccObject
                End GetAzStorageContainer
                    Return RemoveAzStorageContainer > Send $StorageConObject, $StorageAccObject
            End RemoveAzStorageContainer 
                Return ManageAzStorageContainer > Send $null
        End ManageAzStorageContainer 
            Return function > Send $null
}#>
function ManageAzStorageContainer {                                                         # Function to manage storage containers
    Begin {                                                                                 # Begin function
        :ManageAzureStorageCon while ($true) {                                              # Outer loop for managing function
            Write-Host 'Azure Storage Container Management'                                 # Write message to screen
            Write-Host '[0] Exit'                                                           # Write message to screen
            Write-Host '[1] New Storage Container'                                          # Write message to screen
            Write-Host '[2] List All Storage Containers'                                    # Write message to screen
            Write-Host '[3] Remove Storage Container'                                       # Write message to screen
            $OpSelect = Read-Host 'Option [#]'                                              # Operator input to select management function
            Clear-Host                                                                      # Clears screen
            if ($OpSelect -eq '0') {                                                        # If $OpSelect equals '0'
                Break ManageAzureStorageCon                                                 # Breaks :ManageAzureStorageCon 
            }                                                                               # End if ($OpSelect -eq '0')
            elseif ($OpSelect -eq '1') {                                                    # Else if $OpSelect equals '1'
                Write-Host "New Storage Container"                                          # Write message to screen
                NewAzStorageContainer                                                       # Calls function
            }                                                                               # End elseif ($OpSelect -eq '1')
            elseif ($OpSelect -eq '2') {                                                    # Else if $OpSelect equals '2'
                Write-Host 'List All Storage Containers'                                    # Write message to screen
                ListAzStorageContainer                                                      # Calls function    
            }                                                                               # End elseif ($OpSelect -eq '2')
            elseif ($OpSelect -eq '3') {                                                    # Else if $OpSelect equals '3'
                Write-Host 'Remove Storage Container'                                       # Write message to screen
                RemoveAzStorageContainer                                                    # Calls function
            }                                                                               # End elseif ($OpSelect -eq '3')
            else {                                                                          # All other inputs for $OpSelect
                Write-Host 'That was not a valid input'                                     # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Clear-Host                                                                  # Clears screen
            }                                                                               # End else (if ($OpSelect -eq '0'))
        }                                                                                   # End ManageAzureStorageCon while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End begin
}                                                                                           # End function ManageAzStorageContainer
function NewAzStorageContainer {                                                            # Creates new storage container(s) in a storage account
    Begin {                                                                                 # Begin function
        if (!$CallingFunction) {                                                            # If $CallingFunction does not have a value
            $CallingFunction = 'NewAzStorageContainer'                                      # Creates $CallingFunction
        }                                                                                   # End if (!$CallingFunction)
        :NewAzureStorageCon while ($true) {                                                 # Outer loop for managing function
            $StorageAccObject = GetAzStorageAccount ($CallingFunction)                      # Calls function and assigns output to $var
            if (!$StorageAccObject) {                                                       # If $StorageAccObject is $null
                Break NewAzureStorageCon                                                    # Breaks :NewAzureStorageCon
            }                                                                               # End if (!$StorageAccObject)
            :SetAzureStorageConName while ($true) {                                         # Inner loop for setting storage account name
                Try {                                                                       # First validation of the storage container name or names
                    $StorageConNameInput = '0'                                              # Sets $StorageConNameInput to '0'
                    $StorageConNameSplit = $null                                            # Clears $StorageConNameSplit
                    Write-Host 'Storage container names must be atleast 3 characters'       # Write message to screen
                    Write-Host 'and made up of letters and numbers only'                    # Write message to screen
                    Write-Host ''                                                           # Write message to screen    
                    Write-Host 'To create multiple containers in this storage account,'     # Write message to screen
                    Write-Host 'enter each name seperated by a [Space]'                     # Write message to screen
                    [ValidatePattern('^[a-z,0-9,\s]+$')]$StorageConNameInput = `
                        [string](Read-Host "Storage account name or names").ToLower()       # Operator input for the container names
                }                                                                           # End Try 
                catch {                                                                     # If try fails
                    Write-Host ''                                                           # Write message to screen
                    Write-Host 'The provided name(s) were not valid,'                       # Write message to screen
                    Write-Host 'accepted inputs are letters and numbers only'               # Write message to screen
                    Start-Sleep(3)                                                          # Pauses all actions for 3 seconds
                }                                                                           # End Catch
                if ($StorageConNameInput -eq '0') {                                         # If $StorageConNamInput is 0 (failed check)
                    Clear-Host                                                              # Clears screen
                }                                                                           # End if ($StorageConNameInput -eq '0')
                else {                                                                      # If $StorageConNameInput has pass validation
                    :CheckAzureStorageConName while ($true) {                               # Inner loop for verifing each name
                        if ($StorageConNameInput -eq 'exit') {                              # If $StorageConName equals exit
                            Break NewAzStorageAccount                                       # Breaks :NewAzStorageAccount
                        }                                                                   # End if ($StorageConNameInput -eq 'exit')
                        $StorageConNameSplit = $StorageConNameInput.split()                 # $StorageConSplit equals $StorageConNameInput.Split()
                        foreach ($_ in $StorageConNameSplit) {                              # For each item in $StorageConNameSplit
                            if ($_.length -le 2) {                                          # If current item is 2 or less charaters
                                Write-Host ''                                               # Write message to screen
                                Write-Host 'The name'$_' is invalid, the minimum'           # Write message to screen
                                Write-Host 'length of a name is 3 characters'               # Write message to screen
                                Write-Host ''                                               # Write message to screen
                                Start-Sleep(3)                                              # Pauses all action for 3 seconds
                                Clear-Host                                                  # Clears screen
                                Break CheckAzureStorageConName                              # End Break CheckAzureStorageConName
                            }                                                               # End if ($_.length -le 2)
                            elseif ($_.Length -ge 64) {                                     # If current item is 64 or more charaters
                                Write-Host ''                                               # Write message to screen
                                Write-Host 'The name'$_' is invalid, the maximium'          # Write message to screen
                                Write-Host 'length of a name is 63 characters'              # Write message to screen
                                Write-Host ''                                               # Write message to screen
                                Start-Sleep(5)                                              # Pauses all action for 5 seconds
                                Clear-Host                                                  # Clears screen
                                Break CheckAzureStorageConName                              # End Break CheckAzureStorageConName
                            }                                                               # End elseif ($_.Length -ge 64)
                            else {                                                          # All other inputs for $_
                                Write-Host ''                                               # Write message to screen
                                Write-Host $_ 'is a valid name'                             # Write message to screen
                                Start-Sleep(1)                                              # Pauses all actions for 1 second
                            }                                                               # End else (if ($_.length -le 2))
                        }                                                                   # End foreach ($_ in $StorageConNameSplit) 
                        if ($StorageConNameSplit.count -gt 1) {                             # If $StorageConNameSplit has more than one value
                            Write-Host 'Create multiple storage containers '                # Write message to screen
                            Write-Host 'with the following names:'                          # Write message to screen
                            Write-Host ''                                                   # Write message to screen
                            Write-Host $StorageConNameSplit -Separator `n                   # Writes all names to screen
                            Write-Host ''                                                   # Write message to screen
                        }                                                                   # End if ($StorageConNameSplit.count -gt 1)
                        else {                                                              # If $StorageConNameSplit has 1 value
                            Write-Host 'Create a storage account named:' `
                                $StorageConNameInput                                        # Write message to screen
                        }                                                                   # End else (if ($StorageConNameSplit.count -gt 1))
                        $OpConfirm = Read-Host '[Y] or [N]'                                 # Operator input for approving the name
                        if ($OpConfirm -eq 'y') {                                           # If $OpConfirm equals 'y'
                            Clear-Host                                                      # Clears screen 
                            Break SetAzureStorageConName                                    # Breaks :SetAzureStorageConName
                        }                                                                   # End if ($OpConfirm -eq 'y')
                        else {                                                              # All other inputs for $OpConfirm
                            Clear-Host                                                      # Clears screen 
                            Break CheckAzureStorageConName                                  # Breaks :CheckAzureStorageConName
                        }                                                                   # End else (if ($OpConfirm -eq 'y'))
                    }                                                                       # End :CheckAzureStorageConName while ($true)
                }                                                                           # End else (if ($StorageConNameInput -eq '0'))
            }                                                                               # End :SetAzureStorageConName while ($true)
            Write-Host 'Please review the following permissions'
            Write-Host ''                                                                   # Write message to screen
            Write-Host 'Container: Provides full read'                                      # Write message to screen
            Write-Host 'access to a container and its blobs.'                               # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            Write-Host 'Blob:      Provides read access to'                                 # Write message to screen
            Write-Host 'blob data throughout a container through'                           # Write message to screen
            Write-Host 'anonymous request, but does not provide'                            # Write message to screen
            Write-Host 'access to container data.'                                          # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            Write-Host 'Off:       Restricts access to only'                                # Write message to screen
            Write-Host 'the storage account owner.'                                         # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            $ObjectList = @('Container';'Blob';'Off')                                       # List of valid rights input
            $ObjectNumber = 1                                                               # Creates ObjectNumber
            [System.Collections.ArrayList]$ObjectArray=@()                                  # Creates ObjectArray
            foreach ($_ in $ObjectList) {                                                   # For each item in $ObjectList
                $ObjectInput=[PSCustomObject]@{'Number'=$ObjectNumber;'Name'=$_}            # Combines $ObjectNumber and current item
                $ObjectArray.Add($ObjectInput) | Out-Null                                   # Adds $ObjectInput to $ObjectArray
                $ObjectNumber = $ObjectNumber + 1                                           # ObjectNumber is $ObjectNumber + 1
            }                                                                               # End foreach ($_ in $ObjectList)
            :SetAzureStorageConRights while ($true) {                                       # Inner loop for setting the rights level
                Write-Host '[0] Exit'                                                       # Write message to screen
                foreach ($_ in $ObjectArray) {                                              # For each item in $ObjectArray 
                    $Number = $_.Number                                                     # $Number equals current item .Number
                    Write-Host "[$Number]"$_.Name                                           # Write message to screen
                }                                                                           # End foreach ($_ in $ObjectArray)
                $OpSelect = Read-Host 'Select rights level [#]'                             # Operator input for the rights level
                if ($OpSelect -eq '0') {                                                    # If $OpSelect is equal to '0'
                    Break NewAzureStorageCon                                                # Breaks :NewAzureStorageCon
                }                                                                           # End if ($OpSelect -eq '0')
                elseif ($OpSelect -in $ObjectArray.Number) {                                # If $OpSelect in $ObjectArray.number
                    $OpSelect = $ObjectArray | Where-Object {$_.Number -eq $OpSelect}       # $OpSelect equals $ObjectArray where $OpSelect equals $ObjectArray.Number
                    $StorageConRights = $OpSelect.Name                                      # $StorageConRights equals $OpSelect.Name
                    Break SetAzureStorageConRights                                          # Breaks :SetAzureStorageConRights
                }                                                                           # End elseif ($OpSelect -in $ObjectArray.Number)
                else {                                                                      # All other inputs for $OpSelect
                    Write-Host 'That was not a valid input'                                 # Write message to screen
                }                                                                           # End else (if ($OpSelect -eq '0'))
            }                                                                               # End :SetAzureStorageConRights while ($true)
            if ($StorageConNameSplit.Count -gt 1) {                                         # If StorageConNameSplit is not $null
                Write-Host 'Creating storage containers, this may take a minute'            # Write message to screen
                Try {                                                                       # Try the following
                    $StorageConNameSplit | New-AzStorageContainer -context `
                        $StorageAccObject.Context -Permission $StorageConRights `
                        -ErrorAction 'Stop'                                                 # Creates the storage containers
                }                                                                           # End try
                catch {                                                                     # If Try fails
                    Write-Host 'An error has occured'                                       # Write message to screen
                    Write-Host  ''                                                          # Write message to screen
                    Write-Host 'The container name may'                                     # Write message to screen
                    Write-Host 'already exist in this account'                              # Write message to screen
                    Pause                                                                   # Pauses for operator input
                    Break NewAzureStorageCon                                                # Breaks :NewAzureStorageCon
                }                                                                           # End catch
                Write-Host 'The storage containers have been made'                          # Write message to screen
                Pause                                                                       # Pauses for operator input
                Break NewAzureStorageCon                                                    # Breaks :NewAzureStorageCon
            }                                                                               # End if ($StorageConNameSplit.Count -gt 1) 
            else {                                                                          # If $StorageConNameSplit.count is 1
                Try {                                                                       # Try the following
                    Write-Host 'Creating the storage container, this may take a minute'     # Write message to screen
                    $StorageConNameSplit | New-AzStorageContainer -context `
                        $StorageAccObject.Context -Permission $StorageConRights `
                        -ErrorAction 'Stop'                                                 # Creates the storage container
                }                                                                           # End try
                catch {                                                                     # If try fails
                    Write-Host 'An error has occured'                                       # Write message to screen
                    Write-Host  ''                                                          # Write message to screen
                    Write-Host 'The container name may'                                     # Write message to screen
                    Write-Host 'already exist in this account'                              # Write message to screen
                    Pause                                                                   # Pauses for operator input
                    Break NewAzureStorageCon                                                # Breaks :NewAzureStorageCon
                }                                                                           # End catch
                Write-Host 'The storage container has been made'                            # Write message to screen
                Pause                                                                       # Pauses for operator input
                Break NewAzureStorageCon                                                    # Breaks :NewAzureStorageCon
            }                                                                               # End else (if ($StorageConNameSplit.Count -gt 1))
        }                                                                                   # End :NewAzureStorageCon while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End begin
}                                                                                           # End function NewAzStorageContainer
function ListAzStorageContainer {                                                           # Function for listing storage containers
    Begin {                                                                                 # Begin function
        :ListAzStorageCon while ($true) {                                                   # Outer loop for managing function
            $RGList = Get-AzResourceGroup                                                   # creates list of all resource groups
            foreach ($_ in $RGList) {                                                       # For each object in $RGList
                $StorageAccList = Get-AzStorageAccount -ResourceGroupName `
                    $_.ResourceGroupName                                                    # Creates a list of all storage accounts in current resource group
                if ($StorageAccList) {                                                      # If $StorageAccList has a value
                    foreach ($_ in $StorageAccList) {                                       # For each item in $StorageAccList
                        Write-Host '------------------------------------------'             # Write message to screen
                        Write-Host ''                                                       # Write message to screen
                        Write-Host 'Resource group:   '$_.ResourceGroupName                 # Write message to screen
                        Write-Host 'Storage account:  '$_.StorageAccountName                # Write message to screen
                        Try {                                                               # Try the following 
                            $StorageConList = Get-AzStorageContainer -Context $_.Context    # Creates a list of all containers in current $StorageAccount
                        }                                                                   # End Try
                        catch {                                                             # If try fails
                            Write-Host `
                                'You may not have the permissions to view this acount'      # Write message to screen
                            Write-Host 'The account may have a lock on it'                  # Write message to screen
                        }                                                                   # End catch
                        if ($StorageConList) {                                              # If $StorageConList has a value
                            foreach ($_ in $StorageConList) {                               # For each item in $StorageConList
                                Write-Host 'Storage container:'$_.Name 
                            }                                                               # End foreach ($_ in $StorageConList)
                            Write-Host ''                                                   # Write message to screen
                        }                                                                   # End if ($StorageConList)
                        else {                                                              # If $StorageConList does not have a value
                            Write-Host 'Storage container: None'                            # Write message to screen
                            Write-Host ''                                                   # Write message to screen
                        }                                                                   # End else  (if ($StorageConList))
                    }                                                                       # End foreach ($_ in $StorageAccList)
                }                                                                           # End if ($StorageAccList)
                else {                                                                      # If $StorageAccList does not have a value
                    Write-Host '------------------------------------------'                 # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                    Write-Host 'Resource group:   '$_.ResourceGroupName                     # Write message to screen
                    Write-Host 'Storage account:   None'                                    # Write message to screen
                    Write-Host ''                                                           # Write message to screen
                }                                                                           # End else(if ($StorageAccList))
            }                                                                               # End foreach ($_ in $RGList)
            Write-Host '------------------------------------------'                         # Write message to screen
            Write-Host ''                                                                   # Write message to screen 
            Pause                                                                           # Pauses for operator input
            Break ListAzStorageCon                                                          # Breaks :ListAzStorageCon
        }                                                                                   # End :ListAzStorageCon while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function ListAzStorageContainer
function GetAzStorageContainer {                                                            # Function to get a storage container
    Begin {                                                                                 # Begin function
        $ErrorActionPreference='silentlyContinue'                                           # Disables error reporting
        if (!$CallingFunction) {                                                            # If $CallingFunction does not have a value
            $CallingFunction = 'GetAzStorageContainer'                                      # Creates $CallingFunction
        }                                                                                   # End if (!$CallingFunction)                                                              
        :GetAzureStorageContainer while ($true) {                                           # Outer loop for managing function
            $StorageAccObject = GetAzStorageAccount ($CallingFunction)                      # Call function and assigns output to $var
            if (!$StorageAccObject) {                                                       # If $StorageAccObject is $null
                Break GetAzureStorageContainer                                              # Breaks :GetAzureStorageContainer
            }                                                                               # End if (!$StorageAccObject)
            $ObjectList = Get-AzStorageContainer -Context $StorageAccObject.Context         # Gets a list of all storage containers in $StorageAccObject
            if (!$ObjectList) {                                                             # If $ObjectList is $null   
                Write-Host 'No storage containers found on account:'`
                    $StorageAccObject.StorageAccountName                                    # Write message to screen
                Start-Sleep(5)                                                              # Pauses all actions for 5 seconds
                Break GetAzureStorageContainer                                              # Ends :GetAzureStorageContainer
            }                                                                               # End if (!$StorageAccList)
            $ObjectNumber = 1                                                               # Sets $ObjectNumber to 1
            [System.Collections.ArrayList]$ObjectArray = @()                                # Creates the object array
            foreach ($_ in $ObjectList) {                                                   # For each $_ in $ObjectListList
                $ObjectInput = [PSCustomObject]@{'Name' = $_.Name; `
                    'Number' = $ObjectNumber;'PA'=$_.PublicAccess;'LM'=$_.LastModified}     # Creates the item to loaded into array
                $ObjectArray.Add($ObjectInput) | Out-Null                                   # Loads item into array, out-null removes write to screen
                $ObjectNumber = $ObjectNumber + 1                                           # Increments $ObjectNumber by 1
            }                                                                               # End foreach ($_ in $ObjectList)
            Write-Host "[0]  Exit"                                                          # Write message to screen
            Write-Host ''                                                                   # Write message to screen
            foreach ($_ in $ObjectArray) {                                                  # For each $_ in $ObjectArray
                $Number = $_.Number                                                         # Sets $Number to current item .number
                if ($_.Number -le 9) {                                                      # If current item .number is 9 or less
                    Write-Host "[$Number]   "$_.Name                                        # Write message to screen
                }                                                                           # End if ($_.Number -le 9) 
                else {                                                                      # If current item .number is greater then 9
                    Write-Host "[$Number]  "$_.Name                                         # Write message to screen
                }                                                                           # End else (if ($_.Number -le 9) 
                Write-Host 'Public Access:'$_.PA                                            # Write message to screen
                Write-Host 'Last Modified:'$_.LM                                            # Write message to screen
                Write-Host ''                                                               # Write message to screen
            }                                                                               # End foreach ($_ in $ObjectArray)
            :SelectAzureObjectList while ($true) {                                          # Inner loop to select the resource group
                if ($CallingFunction -and $CallingFunction -ne 'GetAzStorageAccount' `
                    -and $CallingFunction -ne 'GetAzStorageContainer') {                    # If $CallingFunction exists and not equal 'GetAzStorageAccount' or 'GetAzStorageContainer'
                    Write-Host `
                        'You are selecting the storage container for:'$CallingFunction      # Write message to screen
                }                                                                           # End if ($CallingFunction -and ($CallingFunction -ne 'GetAzStorageAccount' -or $CallingFunction -ne 'GetAzStorageContainer'))
                $ObjectSelect = Read-Host "Enter the storage container [#]"                 # Operator input for the storage container selection
                if ($ObjectSelect -eq '0') {                                                # If $ObjectSelect equals 0
                    Break GetAzureStorageContainer                                          # Breaks :GetAzureStorageContainer
                }                                                                           # End if ($ObjectSelect -eq '0')
                elseif ($ObjectSelect -in $ObjectArray.Number) {                            # If $ObjectSelect in $ObjectArray.Number
                    $ObjectSelect = $ObjectArray | Where-Object `
                        {$_.Number -eq $ObjectSelect}                                       # $ObjectSelect is equal to $ObjectArray where $ObjectArray.Number is equal to $ObjectSelect                                  
                    $StorageConObject = Get-AzStorageContainer -Context `
                        $StorageAccObject.Context | Where-Object `
                        {$_.Name -eq $ObjectSelect.Name}                                    # Pulls the full storage container object
                    Break SelectAzureObjectList                                             # Breaks :SelectAzureObjectList
                }                                                                           # End elseif ($ObjectSelect -in $ListArray.Number)
                else {                                                                      # All other inputs for $ObjectSelect
                    Write-Host "That was not a valid option"                                # Write message to screen
                }                                                                           # End else (if ($ObjectSelect -eq '0'))
            }                                                                               # End :SelectAzureObjectList while ($true)
            if ($CallingFunction -and $CallingFunction -ne 'GetAzStorageAccount' `
                -and $CallingFunction -ne 'GetAzStorageContainer') {                        # If $CallingFunction exists and not equal 'GetAzStorageAccount' or 'GetAzStorageContainer'
                Clear-Host                                                                  # Clears screen
                Return $StorageConObject, $StorageAccObject                                 # Returns to calling function with $vars
            }                                                                               # End if ($CallingFunction -and $CallingFunction -ne 'GetAzStorageAccount')
            else {                                                                          # If $Calling function does not exist or is equal to 'GetAzStorageAccount' or 'GetAzStorageContainer'
                Break GetAzureStorageContainer                                              # Breaks :GetAzureStorageContainer  
            }                                                                               # End  else (if ($CallingFunction -and $CallingFunction -ne 'GetAzStorageAccount'))
        }                                                                                   # End GetAzureStorageContainer
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function GetAzStorageContainer
function RemoveAzStorageContainer {                                                         # Function to removes existing storage container
    Begin {                                                                                 # Begin function
        $CallingFunction = 'RemoveAzStorageContainer'                                       # Creates $CallingFunction
        :RemoveAzureStorageCon while ($true) {                                              # Outer loop for managing function
            $StorageConObject, $StorageAccObject = GetAzStorageContainer ($CallingFunction) # Calls function and assigns output to $var
            if (!$StorageConObject) {                                                       # If $StorageConObject is $null
                Break RemoveAzureStorageCon                                                 # Breaks :RemoveAzureStorageCon
            }                                                                               # End if (!$StorageAccObject)
            Write-Host 'Remove storage container:' $StorageConObject.Name                   # Write message to screen
            Write-Host 'from storage account:    ' $StorageAccObject.StorageAccountName     # Write message to screen
            $OpConfirm = Read-Host '[Y] Yes [N] No'                                         # Operator confimation to remove the storage container
            if ($OpConfirm -eq 'y') {                                                       # If $OpConfirm equals 'y'
                Try {                                                                       # Try the following
                    Remove-AzStorageContainer -Context $StorageAccObject.Context -Name `
                        $StorageConObject.Name -Force -ErrorAction 'Stop'                   # Removes storage container
                }                                                                           # End Try
                catch {                                                                     # Try fails
                    Write-Host 'An error has occured'                                       # Write message to screen
                    Write-Host 'You may not have the'                                       # Write message to screen
                    Write-Host 'permissions required'                                       # Write message to screen
                    Write-Host 'to complete this action'                                    # Write message to screen
                    Pause                                                                   # Pauses for operator input
                    Break RemoveAzureStorageCon                                             # Breaks RemoveAzureStorageAcc
                }                                                                           # End Catch
                Write-Host $StorageConObject.Name'has been removed'                         # Write message to screen
                Start-Sleep(3)                                                              # Pauses all action for 3 seconds
                Break RemoveAzureStorageCon                                                 # Breaks :RemoveAzureStorageCon
            }                                                                               # End if ($OpConfirm -eq 'y')
            else {                                                                          # All other inputs for $OpConfirm
                Write-Host 'No changes made'                                                # Write message to screen
                Start-Sleep(2)                                                              # Pauses all action for 2 seconds
                Break RemoveAzureStorageCon                                                 # Breaks :RemoveAzureStorageCon
            }                                                                               # End else (if ($OpConfirm -eq 'y'))
        }                                                                                   # End :RemoveAzureStorageCon while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function RemoveAzStorageContainer
#Addition functions required for ManageAzStorageContainer
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