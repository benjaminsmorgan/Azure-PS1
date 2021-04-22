# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Mircosoft docs links
    New-AzStorageContainer:     https://docs.microsoft.com/en-us/powershell/module/az.storage/new-azstoragecontainer?view=azps-5.2.0
    Get-AzStorageContainer:     https://docs.microsoft.com/en-us/powershell/module/az.storage/get-azstoragecontainer?view=azps-5.2.0
    Remove-AzStorageContainer:  https://docs.microsoft.com/en-us/powershell/module/az.storage/remove-azstoragecontainer?view=azps-5.2.0
    Get-AzStorageAccount:       https://docs.microsoft.com/en-us/powershell/module/az.storage/get-azstorageContainer?view=azps-5.2.0
    Get-AzResourceGroup:        https://docs.microsoft.com/en-us/powershell/module/az.resources/get-azresourcegroup?view=azps-5.1.0
    Get-AzResourceLock:         https://docs.microsoft.com/en-us/powershell/module/az.resources/get-azresourcelock?view=azps-5.0.0
    Remove-AzResourceLock:      https://docs.microsoft.com/en-us/powershell/module/az.resources/remove-azresourcelock?view=azps-5.0.0
} #>
<# Required Functions Links: {
    NewAzStorageContainer:      https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Storage/Storage%20Account/Containers/NewAzStorageContainer.ps1
    ListAzStorageContainer:     https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Storage/Storage%20Account/Containers/ListAzStorageContainer.ps1
    GetAzStorageContainer:      https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Storage/Storage%20Account/Containers/GetAzStorageContainer.ps1
    RemoveAzStorageContainer:   https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Storage/Storage%20Account/Containers/RemoveAzStorageContainer.ps1
    GetAzStorageAccount:        https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Storage/Storage%20Container/GetAzStorageContainer.ps1
    GetAzResourceGroup:         https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/GetAzResourceGroup.ps1
    GetAzResourceLocksAll:      https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Locks/GetAzResourceLocksAll.ps1
    RemoveAzResourceLocks:      https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Locks/RemoveAzResourceLocks.ps1 
} #>
<# Functions Description: {
    ManageAzStorageContainer:   Management function for storage containers
    NewAzStorageContainer:      Creates new storage container(s) in a storage account
    ListAzStorageContainer:     Lists all storage containers by storage account 
    GetAzStorageContainer:      Collects storage container in a storage account  
    RemoveAzStorageContainer:   Removes existing storage container
    GetAzStorageAccount:        Collects the storage Container object
    GetAzResourceGroup:         Collects resource group object
    RemoveAzResourceLocks:      Removes locks
    GetAzResourceLocksAll:      Collects all locks on a resource
} #>
<# Variables: {
    :ManageAzureStorageCon      Outer loop for function
    $OpSelect:        Operator input for choosing sub function
    NewAzStorageContainer{}     Function for creating new storage containers
        GetAzStorageAccount{}       Gets $StorageAccObject
            GetAzResourceGroup{}        Gets $RGObject
    ListAzStorageContainer{}    Lists all storage container by accounts
    GetAzStorageContainer{}     Gets $StorageConObject
        GetAzStorageAccount{}       Gets $StorageAccObject
            GetAzResourceGroup{}        Gets $RGObject
    RemoveAzStorageContainer{}  Removes $StorageConObject
        GetAzStorageContainer{}     Gets $StorageConObject
            GetAzStorageAccount{}       Gets $StorageAccObject
                GetAzResourceGroup{}        Gets $RGObject
} #>
<# Process Flow {
    function
        Call ManageAzStorageContainer > Get $null
            Call NewAzStorageContainer > Get $StorageConObject
                Call GetAzStorageAccount > Get $StorageAccObject
                    Call GetAzResourceGroup > Get $RGObject
                    End GetAzResourceGroup
                        Return GetAzStorageAccount > Send $RGObject
                End GetAzStorageAccount 
                    Return Function > Send $StorageAccObject
                End NewAzStorageContainer 
                    Return ManageStorageContainer > Send $StorageConObject
            Call ListAzStorageContainer > Get $null
            End ListAzStorageContainer
                Return ManageStorageContainer > Send $null
            Call GetAzStorageContainer > Get $StorageConObject
                Call GetAzStorageAccount > Get $StorageAccObject
                    Call GetAzResourceGroup > Get $RGObject
                    End GetAzResourceGroup
                        Return GetAzStorageAccount > Send $RGObject
                    End GetAzStorageAccount 
                        Return GetAzStorageContainer > Send $StorageAccObject
                End GetAzStorageContainer 
                    Return ManageAzStorageContainer > Send $StorageConObject, $StorageAccObject
            Call RemoveAzStorageContainer > Get $null
                Call GetAzStorageContainer > Get $StorageConObject
                    Call GetAzStorageAccount > Get $StorageAccObject
                        Call GetAzResourceGroup > Get $RGObject
                        End GetAzResourceGroup
                            Return GetAzStorageAccount > Send $RGObject
                End RemoveAzStorageContainer      
                    Return ManageAzStorageContainer > Send $null
            End ManageAzStorageContainer > Send $null
}#>
function ManageAzStorageContainer {                                                         # Function to manage storage containers
    Begin {                                                                                 # Begin function
        :ManageAzureStorageCon while ($true) {                                              # Outer loop for managing function
            Write-Host 'Azure Storage Container Management'                                 # Write message to screen
            Write-Host '[1] New Storage Container'                                          # Write message to screen
            Write-Host '[2] List All Storage Containers'                                    # Write message to screen
            Write-Host '[3] Get Storage Container'                                          # Write message to screen
            Write-Host '[4] Remove Storage Container'                                       # Write message to screen
            Write-Host '[Exit] to return'                                                   # Write message to screen
            $OpSelect = Read-Host 'Option [#]'                                              # Operator input to select management function
            if ($OpSelect -eq 'exit') {                                                     # If $OpSelect equals '0'
                Break ManageAzureStorageCon                                                 # Breaks :ManageAzureStorageCon 
            }                                                                               # End if ($OpSelect -eq 'exit')
            elseif ($OpSelect -eq '1') {                                                    # Else if $OpSelect equals '1'
                Write-Host "New Storage Container"                                          # Write message to screen
                NewAzStorageContainer                                                       # Calls function
            }                                                                               # End elseif ($OpSelect -eq '1')
            elseif ($OpSelect -eq '2') {                                                    # Else if $OpSelect equals '2'
                Write-Host 'List All Storage Containers'                                    # Write message to screen
                ListAzStorageContainer                                                      # Calls function    
            }                                                                               # End elseif ($OpSelect -eq '2')
            elseif ($OpSelect -eq '3') {                                                    # Else if $OpSelect equals '3'
                Write-Host 'Get Storage Container'                                          # Write message to screen
                GetAzStorageContainer                                                       # Calls function 
            }                                                                               # End elseif ($OpSelect -eq '3')
            elseif ($OpSelect -eq '4') {                                                    # Else if $OpSelect equals '4'
                Write-Host 'Remove Storage Container'                                       # Write message to screen
                RemoveAzStorageContainer                                                    # Calls function
            }                                                                               # End elseif ($OpSelect -eq '4')
            else {                                                                          # All other inputs for $OpSelect
                Write-Host "That was not a valid option"                                    # Write message to screen
            }                                                                               # End else (if ($OpSelect -eq 'exit'))
        }                                                                                   # End ManageAzureStorageCon while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End begin
}                                                                                           # End function ManageAzStorageContainer
function NewAzStorageContainer {                                                            # Creates new storage container(s) in a storage account
    Begin {                                                                                 # Begin function
        :NewAzureStorageCon while ($true) {                                                 # Outer loop for managing function
            $StorageAccObject = GetAzStorageAccount                                         # Calls function and assigns output to $var
            if (!$StorageAccObject) {                                                       # If $StorageAccObject is $null
                Break NewAzureStorageCon                                                    # Breaks :NewAzureStorageCon
            }                                                                               # End if (!$StorageAccObject)
            :SetAzureStorageConName while ($true) {                                         # Inner loop for setting storage account name
                Try {                                                                       # First validation of the storage container name or names
                    $StorageConNameInput = '0'                                              # Sets $StorageConNameInput to '0'
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
                    Clear-Screen                                                            # Clears screen
                }                                                                           # End if ($StorageConNameInput -eq '0')
                elseif ($StorageConNameInput.Length -le 2) {                                # Else if $StorageConNameInput.Length is less than 3
                    Write-Host ''                                                           # Write message to screen
                    Write-Host 'The name entered is invalid, the minimum'                   # Write message to screen
                    Write-Host 'length of a name is 3 characters'                           # Write message to screen
                    Start-Sleep(3)                                                          # Pauses all actions for 3 seconds
                    Clear-Screen                                                            # Clears the screen
                } # End elseif ($StorageConNameInput.Length -le 2)
                else { # Inital validation checks passed, performing secondary validation
                    $StorageConName = $StorageConNameInput # Creats $StorageConName $Var
                    if ($StorageConName -eq 'exit') { # If $StorageConName equals exit
                        Break NewAzStorageAccount # Breaks :NewAzStorageAccount
                    } # End if ($StorageConNameInput -eq 'exit')
                    $StorageConNameSplit = $StorageConName.split() # Creates $StorageConNameSplit, a list of names for each space in $StoreConName
                    foreach ($_ in $StorageConNameSplit) { # Performs length check on all names in list
                        if ($_.length -le 2) { # If $StoreConNameSplit.listitem is 2 or less charaters
                            Write-Host "***Error***" # Write message to screen
                            Write-Host $_ "is not a valid name" # Write message to screen
                            Write-Host "***Error***" # Write message to screen
                            $StorageConNameInput = '0'# Sets $StorageConNameInput value to a failed check to reset loop
                            $StorageConNameSplit = $null # Sets $StorageConNameSplit to $null
                        } # End if ($_.length -le 2)
                    } # End foreach ($_ in $StorageConNameSplit) 
                    if ($StorageConNameInput -eq '0') { # If $StorageConNamInput is 0 (failed check)
                        Write-Host " " # Writes a message to screen, last action before restarting loop
                    } # End if ($StorageConNameInput -eq '0')
                    else { # All validation passed
                        if ($StorageConNameSplit.count -gt 1) { # If $StorageConNameSplit has more than one value
                            Write-Host "Create multiple storage containers with the following names" # Write message to screen
                            Write-Host $StorageConNameSplit -Separator `n # Writes all names to screen
                        } # End if ($StorageConNameSplit.count -gt 1)
                        else { # If $StorageConNameSplit has 1 value
                            Write-Host "Create a single storage account named"$StorageConName # Write message to screen
                            $StorageConNameSplit = $null  # Sets $StorageConNameSplit to $null
                        } # End else (if ($StorageConNameSplit.count -gt 1))
                        $OperatorConfirm = Read-Host "Yes or No" # Operator input for approving the name
                        if ($OperatorConfirm -eq 'y' -or $OperatorConfirm -eq 'yes') { # If $OperatorConfirm is equal to 'y' or 'yes'
                            Break SetAzureStorageConName # Breaks :SetAzureStorageConName
                        } # End if ($OperatorConfirm -eq 'y' -or $OperatorConfirm -eq 'yes')
                    } # End else (if ($StorageConNameInput -eq '0'))
                } # End else (if ($StorageConNameInput -eq '0'))
            } # End :SetAzureStorageConName while ($true)
            Write-Host "Container - Provides full read access to a container and its blobs." # Write message to screen
            Write-Host "Blob      - Provides read access to blob data throughout a container through" # Write message to screen
            Write-Host "            anonymous request, but does not provide access to container data." # Write message to screen
            Write-Host "Off       - Which restricts access to only the storage account owner." # Write message to screen
            $ValidRights = 'Container', 'Blob', 'Off' # List of valid rights input
            :SetAzureStorageConRights while ($true) { # Inner loop for setting the rights level
                $StorageConRightsInput = Read-Host "Container rights level" # Operator input for the rights level
                if ($StorageConRightsInput -eq 'exit') { # If $StorageConRightsInput is equal to 'exit'
                    Break NewAzureStorageCon # Breaks :NewAzureStorageCon
                } # End if ($StorageConRightsInput -eq 'exit')
                elseif ($StorageConRightsInput -iin $ValidRights) { # If $StorageConRightsInput is in $ValidRights list
                    Break SetAzureStorageConRights # Breaks :SetAzureStorageConRights
                } # End elseif ($StorageConRightsInput -iin $ValidRights)
                else { # All other inputs for $StorageConRightsInput
                    Write-Host 'That was not a valid input'# Write message to screen
                    Write-Host 'please select from the following'# Write message to screen
                    Write-Host $ValidRights -Separator `n # Writes $ValidRights list to screen
                } # End else (if ($StorageConRightsInput -eq 'exit'))
            } # End :SetAzureStorageConRights while ($true)
            if ($StorageConNameSplit) { # If StorageConNameSplit is not $null
                Write-Host "Creating storage containers, this may take a minute"# Write message to screen
                $StorageConNameSplit | New-AzStorageContainer -context $StorageAccObject.Context -Permission $StorageConRightsInput # Creates the storage containers
            } # End if ($StorageConNameSplit) 
            else { # If $StorageConNameSplit is $null
                New-AzStorageContainer -Name $StorageConName -context $StorageAccObject.Context -Permission $StorageConRightsInput # Creates to storage container
            } # End else (if ($StorageConNameSplit) )
            Return # Returns to calling function empty
        } # End :NewAzureStorageCon while ($true)
    } # End begin
} # End NewAzStorageContainer
function ListAzStorageContainer {
    Begin {
        $RGList = Get-AzResourceGroup # creates list of all resource groups
        foreach ($_ in $RGList) { # For each object in $RGList
            Write-Host "------------------------------------------" # Write message to screen
            Write-Host $_.ResourceGroupName # Write message to screen
            $StorageAccList = Get-AzStorageAccount -ResourceGroupName $_.ResourceGroupName # Creates a list of all storage accounts in current resource group
            if ($StorageAccList) { # If storage accounts exist in this group
                foreach ($StorageAccountName in $StorageAccList) { # For each object in $StorageAccList
                    Write-Host "------------------------------------------" # Write message to screen
                    Write-Host "StorageAccount: " $StorageAccountName.StorageAccountName # Write message to screen
                    Try { # Try the following command
                        $StorageConList = Get-AzStorageContainer -Context $StorageAccountName.Context # Creates a list of all containers in current $StorageAccount
                    } # End Try
                    catch { # If try fails
                        Write-Host "You may not have the permissions to view this acount" # Write message to screen
                        Write-Host "The account maybe locked which prevents listing containers" # Write message to screen
                    } # End catch
                    if ($StorageConList) { # If storage containers exist in the current account
                        Write-Host "" # Write message to screen
                        foreach ($Name in $StorageConList) { # For each object in $StorageConList
                            Write-Host "Container Name:   " $Name.Name # Write message to screen
                        } # End foreach ($Name in $StorageConList)
                    } # End if ($StorageConList)
                    else { # If no storage containers exist in the current account
                        Write-Host "No containers exist in this storage account" # Write message to screen
                    } # End if ($StorageConList)
                } # End foreach ($_ in $StorageAccList)
            } # End if ($StorageAccList)
            else { # If no storage accounts exist in current group
                Write-Host "No Storage Accounts in this resource group" # Write message to screen
            } # End else(if ($StorageAccList))
        } # End foreach ($_ in $RGList)
        Write-Host "------------------------------------------" # Write message to screen
        Return # Returns to calling function
    } # End Begin
} # End function ListAzStorageContainer
function GetAzStorageContainer {
    Begin {
        $ErrorActionPreference='silentlyContinue'
        :GetAzureStorageContainer while ($true) { # Outer loop for managing function
            if (!$StorageAccObject) { # If $StorageAccObject is $null
                $StorageAccObject = GetAzStorageAccount # Call function and assigns to $var
                if (!$StorageAccObject) { # If $StorageAccObject is $null after returning from function
                    Break GetAzureStorageContainer # Breaks :GetAzureStorageContainer
                } # End if (!$StorageAccObject)
            } # End if (!$StorageAccObject)
            $SCList = Get-AzStorageContainer -Context $StorageAccObject.Context
            $SCListNumber = 1 # Sets the base value of the list
            Write-Host "0. Exit" # Adds exit option to beginning of list
            foreach ($_ in $SCList) { # For each item in list
                Write-Host $SCListNumber"." $_.Name # Writes the option number and storage container name
                $SCListNumber = $SCListNumber+1 # Adds 1 to $SCListNumber
            } # End foreach ($_ in $SCList)
            :GetAzureStorageConName while ($true) { # Loop for selecting the storage container object
                $SCListNumber = 1 # Resets list number to 1
                $SCListSelect = Read-Host "Please enter the number of the storage container" # Operator input for selecting which storage container
                if ($SCListSelect -eq '0') { # If $SCListSelect is equal to 0
                    Break GetAzureStorageContainer # Breaks :GetAzureStorageContainer
                } # End if ($SCListSelect -eq '0')
                foreach ($_ in $SCList) { # For each item in list
                    if ($SCListSelect -eq $SCListNumber) { # If the operator input matches the current $SCListNumber
                        $StorageConObject = Get-AzStorageContainer -Context $StorageAccObject.Context -Name $_.Name # collects the full storage container object
                        Break GetAzureStorageConName # Breaks :GetAzureStorageConName 
                    } # End if ($SCListSelect -eq $SCListNumber)
                    else { # If user input does not match the current $SCListNumber
                        $SCListNumber = $SCListNumber+1 # Adds 1 to $SCListNumber
                    } # End else (if ($SCListSelect -eq $SCListNumber))
                } # End foreach ($_ in $SCList)
                Write-Host "That was not a valid selection, please try again" # Write message to screen
            } # End :GetAzureStorageConName while ($true)
            Return $StorageConObject
        } # End GetAzureStorageContainer
        Return # Returns to calling function with #null
    } # End Begin
} # End GetAzStorageContainer
function RemoveAzStorageContainer { # Removes existing storage container
    Begin {
        :RemoveAzureStorageCon while ($true) { # Outer loop for function
            <#if (!$StorageAccObject) { # If $StorageAccObject is $null
                $StorageAccObject = GetAzStorageAccount ($RGObject) # Calls function and assigns to $var
                    if (!$StorageAccObject) { # If $StorageAccObject is still $null after calling function
                        Break RemoveAzureStorageCon # Breaks :RemoveAzureStorageCon
                    } # End if (!$StorageAccObject)
            } # End if (!$StorageAccObject) #>
            if (!$StorageConObject) { # If $StorageConObject is $null
                $StorageConObject = GetAzStorageContainer ($StorageAccObject) # Calls function and assigns to $var
                    if (!$StorageConObject) { # If $StorageConObject is still $null after calling function
                        Break RemoveAzureStorageCon # Breaks :RemoveAzureStorageCon
                    } # End if (!$StorageAccObject)
            } # End if (!$StorageAccObject)
            Write-Host "***WARNING RESOURCELOCKS WILL NOT PROTECT THIS STORAGECONTAINER FROM BEING DELETED***"
            $OperatorConfirm = Read-Host "Remove the following storage container" $StorageConObject.Name "in" $StorageAccObject.StorageAccountName # Operator confimation to remove the storage container
                if (!($OperatorConfirm -eq 'y' -or $OperatorConfirm -eq 'yes')) { # If Operator confirm is not (equal 'y' or 'yes')
                    Break RemoveAzureStorageCon # Breaks RemoveAzureStorageCon
                } # End if (!($OperatorConfirm -eq 'y' -or $OperatorConfirm -eq 'yes'))
                $StoreConName = $StorageConObject.Name
                Try { # Try to execute Remove-AzStorageAccount
                    Remove-AzStorageContainer -Context $StorageAccObject.Context -Name $StorageConObject.Name -Force -ErrorAction Stop # Removes storage container, -ErrorAction Stop used for catch statement
                } # End Try
                catch { # Try fails
                    Write-Host "You may not have the permissions to remove this storage account" # Write message to screen
                    Break RemoveAzureStorageCon # Breaks RemoveAzureStorageAcc
                } # End Catch
                Write-Host $StoreConName" has been removed" # Write message to screen
                Return # Returns to calling function
        } # End :RemoveAzureStorageCon while ($true)
        Return # Returns to calling function
    } # End Begin
} # End function RemoveAzStorageContainer
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