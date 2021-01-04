# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Mircosoft docs links
    New-AzStorageContainer:     https://docs.microsoft.com/en-us/powershell/module/az.storage/new-azstoragecontainer?view=azps-5.2.0
    Get-AzStorageContainer:     https://docs.microsoft.com/en-us/powershell/module/az.storage/get-azstoragecontainer?view=azps-5.2.0
    Remove-AzStorageContainer:  TBD
    Get-AzStorageAccount:       https://docs.microsoft.com/en-us/powershell/module/az.storage/get-azstorageContainer?view=azps-5.2.0
    Get-AzResourceGroup:        https://docs.microsoft.com/en-us/powershell/module/az.resources/get-azresourcegroup?view=azps-5.1.0
    Get-AzResourceLock:         https://docs.microsoft.com/en-us/powershell/module/az.resources/get-azresourcelock?view=azps-5.0.0
    Remove-AzResourceLock:      https://docs.microsoft.com/en-us/powershell/module/az.resources/remove-azresourcelock?view=azps-5.0.0
} #>
<# Required Functions Links: {
    NewAzStorageContainer:      https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Storage/Storage%20Account/Containers/NewAzStorageContainer.ps1
    GetAzStorageContainer:      https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Storage/Storage%20Account/Containers/GetAzStorageContainer.ps1
    RemoveAzStorageContainer:   TBD
    GetAzStorageAccount:        https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Storage/Storage%20Container/GetAzStorageContainer.ps1
    GetAzResourceGroup:         https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/GetAzResourceGroup.ps1
    GetAzResourceLocksAll:      https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Locks/GetAzResourceLocksAll.ps1
    RemoveAzResourceLocks:      https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Locks/RemoveAzResourceLocks.ps1 
} #>
<# Functions Description: {
    ManageAzStorageContainer:   Management function for storage containers
    NewAzStorageContainer:      Creates new storage container(s) in a storage account 
    GetAzStorageContainer:      Collects storage container in a storage account  
    RemoveAzStorageContainer:   TBD
    GetAzStorageAccount:        Collects the storage Container object
    GetAzResourceGroup:         Collects resource group object
    RemoveAzResourceLocks:      Removes locks
    GetAzResourceLocksAll:      Collects all locks on a resource
} #>
<# Variables: {
    ManageAzStorageContainer {
        :ManageAzureStorageCon      Outer loop for function
        $ManageAzStorageCon:        Operator input for choosing sub function
        NewAzStorageContainer {
            :NewAzureStorageCon         Outer loop for function
            :SetAzureStorageConName     Inner loop for setting storage account name
            :SetAzureStorageConRights   Inner loop for setting the rights level
            $StorageAccObject:          Storage account object for new containers
            $StorageConNameInput:       Operator input for the container names
            $StorageConName:            Non-string $Var of $StorageConNameInput
            $StorageConNameSplit:       List of $StorageConName seperated by [Space]
            $ValidRights:               List of valid rights input
            $StorageConRightsInput:     Operator input for the rights level
            GetAzStorageAccount{
                :GetAzureStorageAccByName   Outer loop for managing funciton
                :GetAzureStorageAcc         Inner loop for getting the storage account
                $RGObject:                  Resource group object
                $StorageAccObjectInput:     Operator input for the name of the storage account
                $SAList:                    List of all storage accounts within $RGObject
                $StorageAccObject:          Storage account object    
                GetAzResourceGroup {
                    $RGObject:                  Resource group object
                    $RGObjectInput:             Operator input for the resource group name
                    $RGList:                    Variable used for printing all resource groups to screen if needed
                } End GetAzResourceGroup
            } End GetAzStorageAccount
        } End NewAzStorageContainer
        GetAzStorageContainer{
            :GetAzureStorageContainer   Outer loop for managing function
            :GetAzureStorageConName     Inner loop for getting the storage container
            $StorageAccObject:          Storage account object    
            $StorageConNameInput:       Operator input for the storage container name
            $StorageConObject:          Storage container object
            $StorageConList:            List of all containers in storage account
            GetAzStorageAccount{
                :GetAzureStorageAccByName   Outer loop for managing funciton
                :GetAzureStorageAcc         Inner loop for getting the storage account
                $RGObject:                  Resource group object
                $StorageAccObjectInput:     Operator input for the name of the storage account
                $SAList:                    List of all storage accounts within $RGObject
                $StorageAccObject:          Storage account object    
                GetAzResourceGroup {
                    $RGObject:                  Resource group object
                    $RGObjectInput:             Operator input for the resource group name
                    $RGList:                    Variable used for printing all resource groups to screen if needed
                } End GetAzResourceGroup
            } End GetAzStorageAccount
        } End GetAzStorageContainer
        RemoveAzStorageContainer{
            $    
        } End RemoveAzStorageContainer
    } End ManageAzStorageContainer
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
                    Return Function > Send $StorageAccObject
                End NewAzStorageContainer 
                    Return ManageStorageContainer > Send $null
            Call GetAzStorageContainer > Get $StorageConObject
                Call GetAzStorageAccount > Get $StorageAccObject
                    Call GetAzResourceGroup > Get $RGObject
                    End GetAzResourceGroup
                        Return GetAzStorageAccount > Send $RGObject
                    End GetAzStorageAccount 
                        Return GetAzStorageContainer > Send $StorageAccObject
                End GetAzStorageContainer 
                    Return ManageAzStorageContainer > Send $StorageConObject      
}#>
function ManageAzStorageContainer {
    Begin {
        :ManageAzureStorageCon while ($true) { # :ManageAzureStorageCon named loop to select search function
            Write-Host "Azure Storage Container Management" # Write message to screen
            Write-Host "1 New Storage Container" # Write message to screen
            Write-Host "2 Get Storage Container" # Write message to screen
            Write-Host "3 Remove Storage Container" # Write message to screen
            Write-Host '0 Clear "$StorageAccObject, $RSObject, $RGObject"' # Write message to screen
            Write-Host "'Exit to return'" # Write message to screen
            $ManageAzStorageCon = Read-Host "Option?" # Collects operator input on $ManageAzStorageCon option
            if ($ManageAzStorageCon -eq 'exit') { # Exit if statement for this function
                Break ManageAzureStorageCon # Ends :ManageAzureStorageCon loop, leading to return statement
            } # End if ($ManageAzStorageCon -eq 'exit')
            elseif ($ManageAzStorageCon -eq '1') { # Elseif statement for creating storage Containers
                Write-Host "New Storage Container" # Write message to screen
                NewAzStorageContainer ($RSObject, $RGObject, $StorageAccObject) # Calls function and assigns to $var
            } # End elseif ($ManageAzStorageCon -eq '1')
            elseif ($ManageAzStorageCon -eq '2') { # Elseif statement for getting storage Containers
                Write-Host "Get Storage Container" # Write message to screen
                $StorageAccObject = GetAzStorageContainer ($RSObject, $RGObject, $StorageAccObject)  # Calls function and assigns to $var
                Write-Host $StorageAccObject.StorageContainerName $StorageAccObject.PrimaryLocation $StorageAccObject.Kind  #Writes message to screen
            } # End elseif ($ManageAzStorageCon -eq '2')
            elseif ($ManageAzStorageCon -eq '3') { # Elseif statement for removing storage Containers
                Write-Host "Remove Storage Containers" # Write message to screen
                RemoveAzStorageContainer  # Calls function
            } # End elseif ($ManageAzStorageCon -eq '3')
            elseif ($ManageAzStorageCon -eq '0') { # Elseif statement for clearing $vars
                Write-Host 'Clearing "$StorageAccObject, $RSObject, $RGObject"' # Write message to screen
                $StorageAccObject = $null # Clears $var
                $RSObject = $null # Clears $var
                $RGObject = $null # Clears $var
            } # End elseif ($ManageAzStorageCon -eq '0')
            else { # All other inputs for $ManageAzStorageCon
                Write-Host "That was not a valid option" # Write message to screen
            } # End else (if ($ManageAzStorageCon -eq 'exit'))
        } # End ManageAzureStorageCon while ($true)
        Return # Returns to calling function 
    } # End begin
} # End function ManageAzStorageContainer
function NewAzStorageContainer { # Creates new storage container(s) in a storage account
    Begin {
        :NewAzureStorageCon while ($true) { # Outer loop for function
            if (!$StorageAccObject) { # If $StorageAccObject is $null
                $StorageAccObject = GetAzStorageAccount # Calls function and assigns to $var
                    if (!$StorageAccObject) { # If $StorageAccObject is still $null after calling function
                        Break NewAzureStorageCon # Breaks :NewAzureStorageCon
                    } # End if (!$StorageAccObject)
            } # End if (!$StorageAccObject)
            :SetAzureStorageConName while ($true) { # Inner loop for setting storage account name
                Try { # First validation of the storage container name or names
                    Write-Host "Storage container names must be atleast 3 characters and made up of letters and numbers only" # Write message to screen
                    Write-Host "To create multiple containers in this storage account, enter each name seperated by a [Space]" # Write message to screen
                    [ValidatePattern('^[a-z,0-9,\s]+$')]$StorageConNameInput = [string](Read-Host "Storage account name or names").ToLower() # Operator input for the container names
                } # End Try 
                catch { # Catch for failing to meet character validation of the container names
                    Write-Host "***Error***"  # Write message to screen
                    Write-Host "The provided name(s) were not valid, accepted inputs are letters and numbers only" # Write message to screen
                    Write-Host "***Error***" # Write message to screen
                    $StorageConNameInput = '0' # Sets $StorageConNameInput value to a failed check to reset loop
                } # End Catch
                if ($StorageConNameInput -eq '0') { # If $StorageConNamInput is 0 (failed check)
                    Write-Host " " # Writes a message to screen, last action before restarting loop
                } # End if ($StorageConNameInput -eq '0')
                elseif ($StorageConNameInput.Length -le 2) { # If unsplit $StorageConNameInput is 2 or less characters
                    Write-Host "***Error***" # Write message to screen
                    Write-Host "The name entered is invalid, the minimum length of a name is 3 characters" # Write message to screen
                    Write-Host "***Error***" # Write message to screen
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
function GetAzStorageContainer { # Collects storage container in a storage accoun
    Begin {
        $ErrorActionPreference='silentlyContinue'
        $StorageConObject = $null # Clears $StorageConObject from all previous use
        :GetAzureStorageContainer while ($true) { # Outer loop for managing function
            if (!$StorageAccObject) { # If $StorageAccObject is $null
                $StorageAccObject = GetAzStorageAccount # Call function and assigns to $var
                if (!$StorageAccObject) { # If $StorageAccObject is $null after returning from function
                    Break GetAzureStorageContainer # Breaks :GetAzureStorageContainer
                } # End if (!$StorageAccObject)
            } # End if (!$StorageAccObject)
            :GetAzureStorageConName while ($true) { # Inner loop for getting the storage container
                if (Get-AzResourceLock -AtScope -ResourceGroupName $StorageAccObject.ResourceGroupName | Where-Object {$_.Properties -like "@{Level=Read*"}) { # Checks for a ReadOnly lock on the owning resource group
                    Write-Host "There is a ReadOnly lock on"$StorageAccObject.ResourceGroupName"that is preventing the search of the storage container" # Write message to screen
                    Write-Host "This will need to be removed or converted to a CanNotDeleteLock" # Write message to screen
                    Break GetAzureStorageContainer # Break :GetAzureStorageContainer
                } # End if (Get-AzResourceLock -AtScope -ResourceGroupName $StorageAccObject.ResourceGroupName | Where-Object {$_.Properties -like "@{Level=Read*"}) 
                $StorageConNameInput = Read-Host "Storage container name" # Operator input for the storage container name
                if ($StorageConNameInput -eq 'exit') { # If $StorageConNameInput is 'exit'
                    Break GetAzureStorageContainer # Breaks :GetAzureStorageContainer
                } # End if ($StorageConNameInput -eq 'exit')
                if (!$StorageConNameInput) { # If $StorageConNameInput is $null
                    $StorageConNameInput = '0' # Sets a value that cannot be an existing storage container name
                } # End if (!$StorageConNameInput)
                $StorageConObject = Get-AzStorageContainer -Name $StorageConNameInput -Context $StorageAccObject.Context # Gets the storage container and assigns to $StorageConObject
                if ($StorageConObject) { # If $StorageConObject has a value
                    Return $StorageConObject # Returns $StorageConObject to calling function
                } # End if ($StorageConObject)
                else { # If $StorageConObject is empty
                    Write-Host "The name provided does not match and existing storage container" # Write message to screen
                    $StorageConList = Get-AzStorageContainer -Context $StorageAccObject.Context # Gets list of all containers in storage account
                    Write-Host $StorageConList.Name -Separator `n # Writes $StorageConList list to screen
                    Write-Host " " # Write message to screen
                    Write-Host "Please re-enter the storage container name" # Write message to screen
                } # End else (if ($StorageConObject))
            } # End :GetAzureStorageConName while ($true)
        } # End :GetAzureStorageContainer while ($true)
        Return # Returns to calling function with $null
    } # End Begin
} # End function GetAzStorageContainer