function ManageAzStorageBlob {
    Begin {
        :ManageAzureStorageBlob while ($true) { # :ManageAzureStorageBlob named loop to select search function
            Write-Host "Azure Storage Blob Management" # Write message to screen
            Write-Host "1 Add Storage Blob" # Write message to screen
            Write-Host "2 Get Storage Blobs" # Write message to screen
            Write-Host "3 Download Storage Blobs" # Write message to screen
            Write-Host "4 Remove Storage Blobs" # Write message to screen
            Write-Host "'Exit to return'" # Write message to screen
            $ManageAzStorageBlob = Read-Host "Option?" # Collects operator input on $ManageAzStorageBlob option
            if ($ManageAzStorageBlob -eq 'exit') { # Exit if statement for this function
                Break ManageAzureStorageBlob # Ends :ManageAzureStorageBlob loop, leading to return statement
            } # End if ($ManageAzStorageBlob -eq 'exit')
            elseif ($ManageAzStorageBlob -eq '1') { # Elseif statement for managing storage accounts
                Write-Host "Add Storage Blob" # Write message to screen
                $StorageBlobObject = SetAzStorageBlobContent ($StorageAccObject, $StorageConObject) 
            } # End elseif ($ManageAzStorageBlob -eq '1')
            elseif ($ManageAzStorageBlob -eq '2') { # Elseif statement for managing storage containers
                Write-Host "Get Storage Blobs" # Write message to screen
                $StorageBlobObject = GetAzStorageBlob ($StorageAccObject, $StorageConObject) 
                Write-Host $StorageBlobObject
            } # End elseif ($ManageAzStorageBlob -eq '2')
            elseif ($ManageAzStorageBlob -eq '3') { # Elseif statement for managing Blobs
                Write-Host "Download Storage Blobs" # Write message to screen
                $StorageBlobObject = GetAzStorageBlobContent ($StorageAccObject, $StorageConObject) 
            } # End elseif ($ManageAzStorageBlob -eq '3')
            elseif ($ManageAzStorageBlob -eq '4') { # Elseif statement for managing file shares
                Write-Host "Remove Storage Blobs" # Write message to screen
                Remove-AzStorageBlob ($StorageAccObject, $StorageConObject) 
            } # End elseif ($ManageAzStorageBlob -eq '4')
            elseif ($ManageAzStorageBlob -eq '0') { # Elseif statement for managing disks
                Write-Host "Clearing" $StorageAccObject "and" $StorageConObject
            } # End elseif ($ManageAzStorageBlob -eq '6')
            Write-Host $RGObject.ResourceGroupName
            Write-Host $RSObject.Name
            Write-Host $StorageAccObject.StorageAccountName
            Write-Host $StorageConObject.Name
        } # End ManageAzureStorageBlob while ($true)
        Return # Returns to calling function if no search option is used
    } # End begin
} # End function ManageAzStorage
function SetAzStorageBlobContent {
    Begin {
        :SetAzureBlobContent while ($true) {
            if (!$StorageConObject) {
                $StorageConObject, $StorageAccObject = GetAzStorageContainer
                if (!$StorageConObject) {
                    Break SetAzureBlobContent
                } # End if (!$StorageConObject)
            } # End if (!$StorageConObject)
            :SetAzureBlobTier while($true) {
                $BlobTierInput = Read-Host "Hot or Cool" # Operator input for $BlobTierInput
                if ($BlobTierInput -eq 'hot' -or $BlobTierInput -eq 'cool') {
                    Break SetAzureBlobTier
                } # End if ($BlobTierInput -eq 'hot' -or $BlobTierInput -eq 'cool')
                elseif ($BlobTierInput -eq 'exit') {
                    Break SetAzureBlobContent
                } # End elseif ($BlobTierInput -eq 'exit')
                else {
                    Write-Host "Please enter hot or cool"
                } # End else (if ($BlobTierInput -eq 'hot' -or $BlobTierInput -eq 'cool'))
            } # End :SetAzureBlobTier while($true)
            :SetLocalFileName while ($true) {
                $LocalFileNameInput = Read-Host "Full path and filename" # Collects the path to file, example: C:\users\Admin\Documents\Blobupload.txt
                if ($LocalFileNameInput -eq 'exit') {
                    Break SetAzureBlobContent
                } # End if ($LocalFileNameInput -eq 'exit')
                Write-Host "This is the file to be uploaded"
                Write-Host $LocalFileNameInput
                $OperatorConfirm = Read-Host "[Y] or [N]"
                if ($OperatorConfirm -eq 'y' -or $OperatorConfirm -eq 'yes') {
                    Break SetLocalFileName
                } # End if ($OperatorConfirm -eq 'y' -or $OperatorConfirm -eq 'yes')
            } # End :SetLocalFileName while ($true)
            :SetAzureBlobName while ($true) {
                $BlobFileNameInput = Read-Host "New name and ext for this file" # Collects the new name and ext for the file that will be used in the storage account, example: SuperAwesomeBlob.jpg
                if ($BlobFileNameInput -eq 'exit') {
                    Break SetAzureBlobContent
                } # End if ($BlobFileNameInput -eq 'exit')
                Write-Host "This will be the file name in the container"
                Write-Host $BlobFileNameInput
                $OperatorConfirm = Read-Host "[Y] or [N]"
                if ($OperatorConfirm -eq 'y' -or $OperatorConfirm -eq 'yes') {
                    Break SetAzureBlobName
                } # End if ($OperatorConfirm -eq 'y' -or $OperatorConfirm -eq 'yes')
            } # End :SetAzureBlobName while ($true)
            $StorageBlobObject = Set-AzStorageBlobContent -File $LocalFileNameInput -Blob $BlobFileNameInput -Container $StorageConObject.Name -Context $StorageAccObject.Context -StandardBlobTier $BlobTierInput
            Return $StorageBlobObject 
        } # End  :SetAzureBlobContent while ($true)
        Return # Returns to calling function with $null
    } # End Begin
} # End function SetAzStorageBlobContent
function GetAzStorageBlob {
    Begin {

    } # End Begin
} # End function GetAzStorageBlob
function GetAzStorageBlobContent {
    Begin {

    } # End Begin
} # End function GetAzStorageBlobContent
function RemoveAzStorageBlob {
    Begin {
        
    } # End Begin
} # End function RemoveAzStorageBlob
function GetAzStorageAccount { # Function to get a storage account, can pipe $StorageAccObject to another function
    Begin {
        :GetAzureStorageAccByName while ($true) { # Outer loop for function
            $ErrorActionPreference ='silentlyContinue' # Disables errors
            if (!$RGObject) { # If $RGObject is $null
                $RGObject = GetAzResourceGroup # Calls (Function) GetAzResourceGroup to get $RGObject
                if (!$RGObject) { # If $RGObject is $null
                    Break GetAzureStorageACCByName # Ends :GetAzureStorageAccByName
                } # End if (!$RGObject) 
            } # End if (!$RGObject)
            :GetAzureStorageAcc while ($true) { # Loop to continue getting a storage account until the operator provided name matches an existing account
                $StorageAccObjectInput = Read-Host "Storage account name" # Operator input of the storage account name
                if ($StorageAccObjectInput -eq 'exit') { # If $StorageAccObjectInput is 'exit
                    Break GetAzureStorageAccByName # Break :GetAzureStorageAccByName
                } # Endif ($StorageAccObjectInput -eq 'exit')
                $StorageAccObject = Get-AzStorageAccount -ResourceGroupName $RGObject.ResourceGroupName -Name $StorageAccObjectInput # Collection of the storage account from the operator input
                if (!$StorageAccObject) { # Error reporting if input does not match and existing account
                    Write-Host "The name provided does not match an existing storage account" # Error reporting
                    $SAList = Get-AzStorageAccount -ResourceGroupName $RGObject.ResourceGroupName # Collects all storage accounts within $RGObject and assigns to $SAList
                    Write-Host "" # Error reporting
                    Write-Host $SAList.Storageaccountname -Separator `n # Write-host used so list is written to screen when function is used as $StorageAccObject = GetAzStorageAccount
                    Write-Host "" # Error reporting
                } # End (!$StorageAccObject)
                else { # Else for when $StorageAccObject is assigned
                    Write-Host $StorageAccObject.StorageAccountName 'Has been assigned to "$StorageAccObject"' # Writes the storage account name to the screen before ending function
                    Return $StorageAccObject # Returns $var to calling function
                } #End else ((!$StorageAccObject))
            } # End :GetAzureStorageAcc while ($true)
        } # End :GetAzureStorageAccByName while ($true)
        Return # Returns to calling function with $null
    } # End begin 
} # End function GetAzStorageAccount
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
                    Return $StorageConObject, $StorageAccObject # Returns $StorageConObject to calling function
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
function GetAzResourceGroup { # Function to get a resource group, can pipe $RGObject to another function
    Begin {
        $ErrorActionPreference='silentlyContinue' # Disables Errors
        $RGObject = $null # Clears $RGObject from all previous use
        :GetAzureResourceGroup while ($true) { # Loop to continue getting a resource group until the operator provided name matches an existing group
            $RGObjectInput = Read-Host "Resource group name" # Operator input of the resource group name
            if ($RGObjectInput -eq 'exit') { # Operator input for exit
                Write-Host "GetAzResourceGroup function was terminated"
                Break GetAzureResourceGroup # Ends :GetAzureResourceGroup loop
            } # End if statement
            $RGObject = Get-AzResourceGroup -Name $RGObjectInput # Collection of the resource group from the operator input
            if (!$RGObject) { # Error reporting if input does not match an existing group
                Write-Host "The name provided does not match an existing resource group" # Error note
                Write-Host "This is the list of available resource groups" # Error note
                $RGList = Get-AzResourceGroup # Collects all resource group objects and assigns to a variable
                Write-Host "" # Error reporting
                Write-Host $RGList.ResourceGroupName -Separator `n # Write-host used so list is written to screen when function is used as $RGObject = GetAzResourceGroup
                Write-Host "" # Error reporting
            } # End of if statement
            else { # Else for when $RGObject is assigned
                Write-Host $RGObject.ResourceGroupName 'Has been assigned to "$RGObject"' # Writes the resource group name to the screen before ending function
                Return $RGObject
            } # End of else statement
        } # End of while statement
        Return # Returns to calling function
    } # End of begin statement
} # End of function
function GetAzStorageBlobOLD () { # Gets blob info within a storage container
    Begin {
        if (!$StorageContainer) { # Check to see if container needs to be assigned to $StorageContainer
            $RGObject = GetAzResourceGroup # Calls function GetAzResourceGroup and assigns to $RGObject
            $StorageAccount = GetAzStorageAccount ($RGObject) # Calls function GetAzStorageAccount and assigns to $StorageAccount
            $StorageContainer = GetAzStorageContainer ($RGObject, $StorageAccount) # Calls function GetAzStorageContainer and assigns to $StorageContainer
        } # End if statement
        $SCBloblist = Get-AzStorageBlob -Context $StorageAccount.context -Container $StorageContainer.Name # Object containing the blob info objects
        $SCBloblist # Prints blob list to screen
    } # End begin statement
} # End function
function GetAzStorageBlobContentOLD { # Downloads a selected blob to a operator specified path
    Begin {
        if (!$StorageContainer) { # Check to see if container needs to be assigned to $StorageContainer
            $RGObject = GetAzResourceGroup # Calls function GetAzResourceGroup and assigns to $RGObject
            $StorageAccount = GetAzStorageAccount ($RGObject) # Calls function GetAzStorageAccount and assigns to $StorageAccount
            $StorageContainer = GetAzStorageContainer ($RGObject, $StorageAccount) # Calls function GetAzStorageContainer and assigns to $StorageContainer
        } # End if statement
        $LocalFileDownloadPath = Read-Host "Path to download file to" # Operator input for the destination folder
        $BlobFileName = $null # Clears $BlobFileName from all previous uses
        while (!$BlobFileName) { # Loop to continue getting a storage blob until the operator provided name matches an existing blob
            $BlobFileNameInput = Read-Host "Name of the file" # Operator input for the name of the blob
            $BlobFileName = Get-AzStorageBlob -Context $StorageAccount.context -Container $StorageContainer.Name -Blob $BlobFileNameInput
            if (!$BlobFileName) { # Error reporting if input does not match and existing blob
                $SCBloblist = Get-AzStorageBlob -Context $StorageAccount.context -Container $StorageContainer.Name # Object containing the blob info objects
                $SCBloblist # Prints blob list to screen
            } # End if statement
            else {
                Get-AzStorageBlobContent -Context $StorageAccount.context -Container $StorageContainer.Name -Blob $BlobFileNameInput -Destination $LocalFileDownloadPath
                $OperatorSelectAnotherBlob = Read-Host "Download another file" # Operator input to download a file to the same location from the current container
                if ($OperatorSelectAnotherBlob -eq 'y' -or $OperatorSelectAnotherBlob -eq 'yes') { # Confirmation from $OperatorSelectAnotherBlob
                    $BlobFileName = $null # Clears $BlobFileName from all previous uses, restarts current while loop once completed
                } # End if statement
            } # End else statement
        } # End while statement
    } # End begin statement
} # End function
Function RemoveAzStorageBlobOLD { # Function to remove a blob (File) from an existing storage container
    Begin {
        $ErrorActionPreference='silentlyContinue' # Disables errors
        if (!$StorageContainer) {  # Check to see if container needs to be assigned to $StorageContainer
            $RGObject = GetAzResourceGroup # Calls function GetAzResourceGroup and assigns to $RGObject
            $StorageAccount = GetAzStorageAccount ($RGObject) # Calls function GetAzStorageAccount and assigns to $StorageAccount
            $StorageContainer = GetAzStorageContainer ($RGObject, $StorageAccount) # Calls function GetAzStorageContainer and assigns to $StorageContainer
        } # End if statement
        $BlobFileName = $null # Clears $BlobFileName from all previous use
        while (!$BlobFileName) { # Loop to continue getting a storage blob until the operator provided name matches an existing blob
            $BlobFileNameInput = Read-Host "Name and ext of the blob to be deleted"  # Operator input of the storage blob name
            $BlobFileName = Get-AzStorageBlob -Blob $BlobFileNameInput -Container $StorageContainer.name -Context $StorageAccount.Context # Collects the blob object using $BlobFileNameInput
            if (!$BlobFileName) { # Error reporting if input does not match and existing blob
                Write-Host "The name provided does not match an existing storage blob" # Error reporting
                Write-Host "This is the list of available storage blobs" # Error reporting
                $SCBloblist = Get-AzStorageBlob -Context $StorageAccount.context -Container $StorageContainer.Name  # Collects all storage blobs within $StorageContainer and assigns them to $SCBloblist
                Write-Host "" # Error reporting
                Write-Host $SCBlobList.Name -Separator `n # Write-host used so list is written to screen when function is used as a called function
                Write-Host "" # Error reporting
            } # End if statement
        } # End while statement
        $ConfirmDelete = Read-Host "Do you want to delete"$BlobFileName.Name # Operator input to confirm delete
        if ($ConfirmDelete -eq 'y' -or $ConfirmDelete -eq 'yes') { # Check that operator input is 'y' or 'yes'
            Remove-AzStorageBlob -Blob $BlobFileName.Name -Container $StorageContainer.Name -Context $StorageAccount.Context # Removes the selected blob
            Write-Host $BlobFileName.Name"has been deleted" # Confirmation message
        } # End if statement
        else { # If $ConfirmDelete is not 'y' or 'yes'
            Write-Host "No changes were made" # Confirmation message
            Break # Terminates script
        } # End else statement
    } # End begin statement
} # End function