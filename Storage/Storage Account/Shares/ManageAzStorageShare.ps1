# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Mircosoft docs links
    New-AzStorageShare:         https://docs.microsoft.com/en-us/powershell/module/az.storage/new-azstorageshare?view=azps-5.3.0
    Get-AzStorageShare:         https://docs.microsoft.com/en-us/powershell/module/az.storage/get-azstorageshare?view=azps-5.3.0
    Remove-AzStorageShare:      https://docs.microsoft.com/en-us/powershell/module/az.storage/remove-azstorageshare?view=azps-5.3.0
    Get-AzStorageAccount:       https://docs.microsoft.com/en-us/powershell/module/az.storage/get-azstorageaccount?view=azps-5.2.0
    Get-AzResourceGroup:        https://docs.microsoft.com/en-us/powershell/module/az.resources/get-azresourcegroup?view=azps-5.1.0
} #>
<# Required Functions Links: {
    NewAzStorageShare:          https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Storage/Storage%20Account/Shares/NewAzStorageShare.ps1
    GetAzStorageShare:          https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Storage/Storage%20Account/Shares/GetAzStorageShare.ps1
    GetAzStorageShareAll:       https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Storage/Storage%20Account/Shares/GetAzStorageShareAll.ps1
    RemoveAzStorageShare:       https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Storage/Storage%20Account/Shares/RemoveAzStorageShare.ps1
    ManageAzStorageShareItems:  TBD
    GetAzStorageAccObject:      https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Storage/Storage%20Account/GetAzStorageAccount.ps1
    GetAzResourceGroup:         https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/GetAzResourceGroup.ps1
} #>
<# Functions Description: {
    ManageAzStorageShare:       Manages all functions for storage shares
    NewAzStorageShare:          Creates a new storage share
    GetAzStorageShare:          Gets a storage share
    GetAzStorageShareAll:       Lists all storage shares in a subscription
    RemoveAzStorageShare:       Removes a storage share
    ManageAzStoreShareItems:    Management function for storage share items
    GetAzStorageAccount:        Collects the storage account object
    GetAzResourceGroup:         Collects resource group object
} #>
<# Variables: {
    ManageAzStorageShare{
        :ManageAzureStorageShare    Outer loop for managing function
        $ManageAzStorageShare:      Operator input for selecting function
        $RGObject:                  Resource group object
        $StorageAccObject:          Storage account object
        $StorageShareObject:        Storage share object
        NewAzStorageShare {
            :NewAzureStorageShare       Outer loop for managing function
            :SetAzureShareName          Inner loop for setting the name of the new share
            $StorageAccObject:          Storage account object
            $ShareNameInput:            Operator input for the share name
            $ShareNameSplit:            List of names for each space in $ShareNameInput
            $OperatorConfirm:           Operator confirmation on provided values
            $StorageShareObject:        Storage share object 
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
        } End NewAzStorageShare
        GetAzStorageShare               
            :GetAzureStorageShare       Outer loop for managing function
            :GetAzureStorageShareName   Inner loop for getting the named Storage share
            $StorageAccObject:          Storage account object
            $ShareNameInput:            Operator input for the share name
            $StorageShareObject:        Storage share object
            $StorageShareList:          List of all storage shares in storage account
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
        } End GetAzStorageShare
        GetAzStorageShareAll{
            $StorageAccObject:          All storage accounts in subscription
            $StorageShareObject:        All storage shares in a storage account
        } End GetAzStorageShareAll
        RemoveAzStorageShare {
            $StorageAccObject:          Storage account object
            $StorageShareObject:        Storage share object
            $OperatorConfirm:           Operator confirmation
            GetAzStorageShare {               
                :GetAzureStorageShare       Outer loop for managing function
                :GetAzureStorageShareName   Inner loop for getting the named storage share
                $StorageAccObject:          Storage account object
                $ShareNameInput:            Operator input for the share name
                $StorageShareObject:        Storage share object
                $StorageShareList:          List of all storage shares in storage account
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
            } End GetAzStorageShare
        } End RemoveAzStorageShare
    } End ManageAzStorageShare
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
                Return Function > Send $StorageShareObject
            Call GetAzStorageShare > Get $StorageShareObject
                Call GetAzStorageAccount > Get $StorageAccObject
                    Call GetAzResourceGroup > Get $RGObject
                    End GetAzResourceGroup
                        Return GetAzStorageAccount > Send $RGObject
                End GetAzStorageAccount
                    Return NewAzStorageShare > Send $StorageAccObject
            End GetAzStorageShare      
                Return Function > Send $StorageShareObject
            Call GetAzStorageShareAll > Get $null
            End GetAzStorageShareAll 
                Return Function > Send $null
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
        End ManageAzStorageShare
            Return function > Send $null
}#>
function ManageAzStorageShare { # Manages storage blob functions
    Begin {
        :ManageAzureStorageShares while ($true) { # :ManageAzureStorageShares named loop to select search function
            Write-Host "Azure Storage Share Management" # Write message to screen
            Write-Host "1 New Storage Share" # Write message to screen
            Write-Host "2 Get Storage Share" # Write message to screen
            Write-Host "3 List All Storage Shares" # Write message to screen
            Write-Host "4 Remove Storage Share" # Write message to screen
            Write-Host "5 Manage Storage Share Contents" # Write message to screen
            Write-Host "0 Unselect currently selected resources" # Write message to screen
            Write-Host "'Exit to return'" # Write message to screen
            $ManageAzStorageShare = Read-Host "Option?" # Collects operator input on $ManageAzStorageShare option
            if ($ManageAzStorageShare -eq 'exit') { # Exit if statement for this function
                Break ManageAzureStorageShares # Ends :ManageAzureStorageShares loop, leading to return statement
            } # End if ($ManageAzStorageShare -eq 'exit')
            elseif ($ManageAzStorageShare -eq '1') { # Elseif statement for managing storage accounts
                Write-Host "New Storage Share" # Write message to screen
                $StorageShareObject = NewAzStorageShare ($StorageAccObject, $RGObject) # Calls function and assigns to $var 
                Write-Host $StorageShareObject.Name
            } # End elseif ($ManageAzStorageShare -eq '1')
            elseif ($ManageAzStorageShare -eq '2') { # Elseif statement for managing storage containers
                Write-Host "Get Storage Share" # Write message to screen
                $StorageShareObject, $StorageAccObject = GetAzStorageShare ($StorageAccObject, $RGObject) # Calls function and assigns to $var 
            } # End elseif ($ManageAzStorageShare -eq '2')
            elseif ($ManageAzStorageShare -eq '3') { # Elseif statement for managing Blobs
                Write-Host "List All Storage Shares" # Write message to screen
                GetAzStorageShareAll # Calls function 
            } # End elseif ($ManageAzStorageShare -eq '3')
            elseif ($ManageAzStorageShare -eq '4') { # Elseif statement for managing Storage shares
                Write-Host "Remove Storage Share" # Write message to screen
                RemoveAzStorageShare ($StorageAccObject, $StorageShareObject) # Calls function and assigns to $var
            } # End elseif ($ManageAzStorageShare -eq '4')
            elseif ($ManageAzStorageShare -eq '0') { # Elseif statement for managing disks
                if ($RGObject) { # If $var is not $null
                Write-Host "Clearing" $RGObject.ResourceGroupName # Write message to screen
                $RGObject = $null # Sets $var to $null
                } # End if ($RGObject)
                if ($StorageAccObject) { # If $var is not $null
                Write-Host "Clearing" $StorageAccObject.StorageAccountName # Write message to screen
                $StorageAccObject = $null # Sets $var to $null
                } # End if ($StorageAccObject)
                if ($StorageShareObject) { # If $var is not $null
                Write-Host "Clearing" $StorageShareObject.Name # Write message to screen
                $StorageShareObject = $null # Sets $var to $null
                } # End if ($StorageBlobObject)
                Write-Host "All objects have been cleared" # Write message to screen
            } # End elseif ($ManageAzStorageShare -eq '0')
            Write-Host "" # Write message to screen
            if ($RGObject) { # If $var is not $null
                Write-Host "Current Resource Group:    " $RGObject.ResourceGroupName # Write message to screen
            } # End if ($RGObject)
            if ($StorageAccObject) { # If $var is not $null
                Write-Host "Current Storage Account:   " $StorageAccObject.StorageAccountName # Write message to screen
            } # End if ($StorageAccObject)
            if ($StorageShareObject) { # If $var is not $null
                Write-Host "Current Storage Share:   " $StorageShareObject.Name # Write message to screen
            } # End if ($StorageBlobObject)
            Write-Host "" # Write message to screen
        } # End :ManageAzureStorageShares while ($true)
        Return # Returns to calling function if no search option is used
    } # End begin
} # End function ManageAzStorage
function NewAzStorageShare { # Creates a new storage share
    Begin {
        :NewAzureStorageShare while ($true) { # Outer loop for managing function
            if (!$StorageAccObject) { # If $var is $null
                $StorageAccObject = GetAzStorageAccount ($RGObject) # Calls function and assigns to $var
                if (!$StorageAccObject) { # If $var is $null
                    Break NewAzureStorageShare # Breaks :NewAzureStorageShare
                } # End if (!$StorageAccObject)
            } # End if (!$StorageAccObject)
            :SetAzureShareName while ($true) { # Inner loop for setting the name of the new share
                Try { # First validation of the storage share name
                    Write-Host "Storage share name must be atleast 3 characters and made up of letters and numbers only" # Write message to screen
                    [ValidatePattern('^[a-z,0-9,\s]+$')]$ShareNameInput = [string](Read-Host "New Storage share name").ToLower() # Operator input for the share name
                } # End Try 
                catch { # Catch for failing to meet character validation of the share name
                    Write-Host "***Error***"  # Write message to screen
                    Write-Host "The provided name was not valid, accepted inputs are letters and numbers only" # Write message to screen
                    Write-Host "***Error***" # Write message to screen
                    $ShareNameInput = '0' # Sets $ShareNameInput value to a failed check to reset loop
                } # End Catch
                if ($ShareNameInput.Length -le 2) { # If $ShareNameInput is less than 3 charaters
                    Write-Host "***Error***" # Write message to screen
                    Write-Host "The name entered is invalid, the minimum length of a name is 3 characters" # Write message to screen
                    Write-Host "***Error***" # Write message to screen
                    $ShareNameInput = '0' # Sets $ShareNameInput value to a failed check to reset loop
                } # End if ($ShareNameInput.Length -le 2)
                $ShareNameSplit = $ShareNameInput.split() # Creates $ShareNameSplit, a list of entries for each space in $ShareNameInput
                if ($ShareNameSplit.Count -gt 1) { # If $ShareNameSplit is greater than 1 value
                    Write-Host "***Error***" # Write message to screen
                    Write-Host "The name entered is invalid, no spaces are allowed in the name" # Write message to screen
                    Write-Host "***Error***" # Write message to screen
                    $ShareNameInput = '0' # Sets $ShareNameInput value to a failed check to reset loop
                } # End if ($ShareNameSplit.Count -gt 1)
                $ShareNameSplit = $null  # Sets $StorageConNameSplit to $null
                if ($ShareNameInput -eq '0') { # If $ShareNameInput is 0 (failed check)
                    Write-Host " " # Writes a message to screen, last action before restarting loop
                } # End if ($ShareNameInput -eq '0')
                else { # All checks on $ShareNameInput passed
                    Write-Host "This will be the share name" # Write message to screen
                    Write-Host $ShareNameInput # Write message to screen
                    $OperatorConfirm = Read-Host "[Y] or [N]" # Operator confirmation on using this name
                    if ($OperatorConfirm -eq 'y' -or $OperatorConfirm -eq 'yes') { # If $OperatorConfrim is equal to 'y' or 'yes'
                        Break SetAzureShareName # Breaks :SetAzureShareName
                    } # End if ($OperatorConfirm -eq 'y' -or $OperatorConfirm -eq 'yes')
                } # End else (if ($ShareNameInput.Length -le 2))
            } # End :SetAzureShareName while ($true)
            $StorageShareObject = New-AzStorageShare -Name $ShareNameInput -Context $StorageAccObject.Context # Creates the storage share and assigns to $StorageShareObject
            Return $StorageShareObject # Returns to calling function with $StorageShareObject
        } # End :NewAzureStorageShare while ($true)
        Return # Returns to calling function with $null
    } # End Begin
} # End function NewAzStorageShare
Function GetAzStorageShare { # Gets a storage share
    Begin {
        :GetAzureStorageShare while ($true) { # Outer loop for managing function
            if (!$StorageAccObject) { # If $var is $null
                $StorageAccObject = GetAzStorageAccount ($RGObject) # Calls function and assigns to $var
                if (!$StorageAccObject) { # If $var is $null
                    Break GetAzureStorageShare # Breaks :GetAzureStorageShare
                } # End if (!$StorageAccObject) 
            } # End if (!$StorageAccObject) {
            $StorageShareList = Get-AzStorageShare -Context $StorageAccObject.Context # Collects all shares in selected storage account
            :GetAzureStorageShareName while ($true) { # Inner loop for getting the named storage share
                $StorageShareObject = $null # Clears from previous use
                $ShareNameInput = Read-Host "Storage share name" # Operator input for the share name
                if ($ShareNameInput -eq 'exit') { # If $ShareNameInput is 'exit'
                    Break GetAzureStorageShare # Breaks :GetAzureStorageShare
                } # End if ($ShareNameInput -eq 'exit')
                if ($ShareNameInput -notin $StorageShareList.Name) {
                    Write-Host "The name provided does not match an existing share" # Write message to screen
                    Write-Host "Please select from the following" # Write message to screen
                    Write-Host "" # Write message to screen
                    Write-Host $StorageShareList.Name -Separator `n # Writes $StorageShareList to screen
                    Write-Host "" # Write message to screen
                } # End if ($ShareNameInput -notin $StorageShareList)
                else {
                    Try { # Try to get $StorageShareObject
                        $StorageShareObject = Get-AzStorageShare -Context $StorageAccObject.Context -Name $ShareNameInput # Collects the Storage share and assigns to $StorageShareObject
                    } # End Try
                    Catch { # If Try fails
                        Write-Host "The share was not collected, you may not have the permissions" # Write message to screen
                    } # End catch
                    if ($StorageShareObject) { # If $StorageShareObject is not $null
                        Return $StorageShareObject, $StorageAccObject # Returns $StorageShareObject to calling function
                    } # End if ($StorageShareObject)
                } # End else (if ($ShareNameInput -notin $StorageShareList)) 
            } # End :GetAzureStorageShareName while ($true)
        } # End :GetAzureStorageShare while ($true)
        Return # Returns nothing
    } # End Begin
} # End Function GetAzStorageShare
Function GetAzStorageShareAll { # Lists all storage shares in a subscription
    Begin {
        $StorageAccObject = Get-AzStorageAccount # Collects all storage accounts in the subscription
        foreach ($Name in $StorageAccObject) { # For each name in $StorageAccObject
            Write-Host "Resource Group:"$Name.ResourceGroupName # Write message to screen
            Write-Host "Storage Account:"$Name.StorageAccountName # Write message to screen
            Try { # Try to get storage shares within a storage account
                $StorageShareObject = Get-AzStorageShare -Context $Name.Context # Collects all storage shares in a storage account
            } # End Try
            Catch { # If Try fails
                Write-Host "Permissions or locks prevent a search in this storage account" # Write message to screen
                $StorageShareObject = $null # Clears $StorageShareObject
            } # End Catch
            foreach ($Name in $StorageShareObject) { # For each name in $StorageShareObject
                Write-Host "Storage Share:"$Name.Name # Write message to screen
            } # End foreach ($Name in $StorageShareObject)
            Write-Host "" # Write message to screen
        } # End foreach ($Name in $StorageAccObject) 
        Return # Returns nothing
    } # End Begin
} # End Function GetAzStorageShareAll
function RemoveAzStorageShare { # Removes a storage share
    Begin {
        if (!$StorageAccObject) { # If $StorageAccObject is $null
            $StorageAccObject = GetAzStorageAccount # Call function and assign result to $var
            if (!$StorageAccObject) { # If $StorageAccObject is $null
                Return # Returns to calling function with $null
            } # End if (!$StorageAccObject)
        } # End if (!$StorageShareObject)
        if (!$StorageShareObject) { # If $StorageShareObject is $null 
            $StorageShareObject = GetAzStorageShare ($StorageAccObject) # Call function and assign result to $var
            if (!$StorageShareObject) { # If $StorageShareObject is $null 
                Return # Returns to calling function with $null
            } # End if (!$StorageShareObject)
        } # End if (!$StorageShareObject)
        Write-Host "Remove the storage share:"$StorageShareObject.Name"in storage account:"$StorageAccObject.StorageAccountName # Write message to screen
        $OperatorConfirm = Read-Host "[Y] or [N]" # Operator confirmation to remove storage share
        if ($OperatorConfirm -eq 'y' -or $OperatorConfirm -eq 'yes') { # If $OperatorConfirm is equal to 'y' or 'yes'
            Try { # Try to do the following
                Remove-AzStorageShare -Name $StorageShareObject.Name -Context $StorageAccObject.Context # Remove the selected share
            } # End Try
            Catch { # If try fails
                Write-Host "" # Write message to screen
                Write-Host "The storage share was not removed, you may not have the permissions to do so" # Write message to screen
                Write-Host "" # Write message to screen
                Return # Returns to calling function with $null
            } # End Catch
            Write-Host "" # Write message to screen
            Write-Host "The storage share was removed" # Write message to screen
            Write-Host "" # Write message to screen
            Return # Returns to calling function with $null
        } # End if ($OperatorConfirm -eq 'y' -or $OperatorConfirm -eq 'yes')
        else { # Returns to calling function with $null
            Write-Host "No action taken, returning to menu" # Write message to screen
            Return # Returns to calling function with $null
        } # End else (if ($OperatorConfirm -eq 'y' -or $OperatorConfirm -eq 'yes'))
    } # End Begin
} # End function RemoveAzStorageShare
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