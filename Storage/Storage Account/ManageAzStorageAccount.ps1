# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Mircosoft docs links
    New-AzStorageAccount:       https://docs.microsoft.com/en-us/powershell/module/az.storage/new-azstorageaccount?view=azps-5.2.0
    Get-AzStorageAccount:       https://docs.microsoft.com/en-us/powershell/module/az.storage/get-azstorageaccount?view=azps-5.2.0
    Remove-AzStorageAccount:    https://docs.microsoft.com/en-us/powershell/module/az.storage/remove-azstorageaccount?view=azps-5.2.0
    Get-AzResourceGroup:        https://docs.microsoft.com/en-us/powershell/module/az.resources/get-azresourcegroup?view=azps-5.1.0
    Get-AzResourceLock:         https://docs.microsoft.com/en-us/powershell/module/az.resources/get-azresourcelock?view=azps-5.0.0
    Remove-AzResourceLock:      https://docs.microsoft.com/en-us/powershell/module/az.resources/remove-azresourcelock?view=azps-5.0.0
} #>
<# Required Functions Links: {
    NewAzStorageAccount:        https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Storage/Storage%20Account/NewAzStorageAccount.ps1
    GetAzStorageAccount:        https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Storage/Storage%20Account/GetAzStorageAccount.ps1
    RemoveAzStorageAccount:     https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Storage/Storage%20Account/RemoveAzStorageAccount.ps1
    GetAzResourceGroup:         https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/GetAzResourceGroup.ps1
    GetAzResourceLocksAll:      https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Locks/GetAzResourceLocksAll.ps1
    RemoveAzResourceLocks:      https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Locks/RemoveAzResourceLocks.ps1 
} #>
<# Functions Description: {
    ManageAzStorageAccount:     Management function for storage accounts
    NewAzStorageAccount:        Creates new storage account object
    GetAzStorageAccount:        Collects the storage account object
    RemoveAzStorageAccount:     Removes the selected storage account
    GetAzStorageAccount:        Collects the storage account object
    GetAzResourceGroup:         Collects resource group object
    RemoveAzResourceLocks:      Removes locks
    GetAzResourceLocksAll:      Collects all locks on a resource
} #>
<# Variables: {
    ManageAzStorageAccount {
        :ManageAzureStorageAcc      Outer loop for function
        $ManageAzStorageAcc:        Operator input for choosing sub function
        NewAzStorageAccount{
            :NewAzureStorageAcc         Outer loop for function
            :SetAzureStorageAccName     Inner loop for setting name
            :SetAzureStorageAccSku      Inner loop for setting sku
            :SetAzureStorageAccLoc      Inner loop for setting location
            $OperatorConfirm:           Operator input to confirm previous inputs
            $RGObject:                  Resource group object
            $StorageAccNameInput:       Operator input for name
            $ValidSku:                  List of valid skus for storage accounts
            $StorageAccSkuInput:        Operator input for sku
            $ValidLocation:             List of valid azure locations
            $StorageAccLocInput:        Operator input for location
            $StorageAccObject:          New storage account object
            GetAzResourceGroup {
                $RGObject:                  Resource group object
                $RGObjectInput:             Operator input for the resource group name
                $RGList:                    Variable used for printing all resource groups to screen if needed
            } End GetAzResourceGroup
        } End NewAzStorageAccount
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
        RemoveAzStorageAccount{
            :RemoveAzureStorageAcc      Outer loop for managing function
            $StorageAccObject:          Storage account object 
            $StoreAccName:              Storage account object name
            $OperatorConfirm:           Operator confirmation to remove the storage account
            $RSObject:                  Resource object
            $RGObject:                  Resource group object
            $Locks:                     Locks on the storage account   
            GetAzResourceGroup {
                $RGObject:                  Resource group object
                $RGObjectInput:             Operator input for the resource group name
                $RGList:                    Variable used for printing all resource groups to screen if needed
            } End GetAzResourceGroup
            GetAzResourceLocksAll {
                $RGObject:              Resource group object
                $RSObject:              Resource object
                $Locks:                 Locks object
            } End GetAzResourceLocksAll
            RemoveAzResourceLocks {
                $Locks:                 Lock or locks object
            } End RemoveAzResourceLocks    
        } End RemoveAzStorageAccount
    } End ManageAzStorageAccount
} #>
<# Process Flow {
    function
        Call ManageAzStorageAccount > Get $null
            Call NewAzStorageAccount > Get $StorageAccObject
                Call GetAzResourceGroup > Get $RGObject
                End GetAzResourceGroup
                    Return NewAzStorageAccount > Send $RGObject
            End NewAzStorageAccount 
                Return Function > Send $StorageAccObject
            Call GetAzStorageAccount > Get $StorageAccObject
                Call GetAzResourceGroup > Get $RGObject
                End GetAzResourceGroup
                    Return GetAzStorageAccount > Send $RGObject
            End GetAzStorageAccount 
                Return Function > Send $StorageAccObject
}#>
function ManageAzStorageAccount {
    Begin {
        :ManageAzureStorageAcc while ($true) { # :ManageAzureStorageAcc named loop to select search function
            Write-Host "Azure Storage Account Management" # Write message to screen
            Write-Host "1 New Storage Account" # Write message to screen
            Write-Host "2 Get Storage Account" # Write message to screen
            Write-Host "3 Remove Storage Account" # Write message to screen
            Write-Host '0 Clear "$StorageAccObject, $RSObject, $RGObject"' # Write message to screen
            Write-Host "'Exit to return'" # Write message to screen
            $ManageAzStorageACC = Read-Host "Option?" # Collects operator input on $ManageAzStorageACC option
            if ($ManageAzStorageACC -eq 'exit') { # Exit if statement for this function
                Break ManageAzureStorageAcc # Ends :ManageAzureStorageAcc loop, leading to return statement
            } # End if ($ManageAzStorageACC -eq 'exit')
            elseif ($ManageAzStorageACC -eq '1') { # Elseif statement for creating storage accounts
                Write-Host "New Storage Account" # Write message to screen
                $StorageAccObject = NewAzStorageAccount ($RSObject, $RGObject) # Calls function and assigns to $var
                Write-Host $StorageAccObject.StorageAccountName $StorageAccObject.PrimaryLocation $StorageAccObject.Kind #Writes message to screen
            } # End elseif ($ManageAzStorageACC -eq '1')
            elseif ($ManageAzStorageACC -eq '2') { # Elseif statement for getting storage accounts
                Write-Host "Get Storage Account" # Write message to screen
                $StorageAccObject = GetAzStorageAccount ($RSObject, $RGObject)  # Calls function and assigns to $var
                Write-Host $StorageAccObject.StorageAccountName $StorageAccObject.PrimaryLocation $StorageAccObject.Kind  #Writes message to screen
            } # End elseif ($ManageAzStorageACC -eq '2')
            elseif ($ManageAzStorageACC -eq '3') { # Elseif statement for removing storage accounts
                Write-Host "Remove Storage Accounts" # Write message to screen
                RemoveAzStorageAccount  # Calls function
            } # End elseif ($ManageAzStorageACC -eq '3')
            elseif ($ManageAzStorageACC -eq '0') { # Elseif statement for clearing $vars
                Write-Host 'Clearing "$StorageAccObject, $RSObject, $RGObject"' # Write message to screen
                $StorageAccObject = $null # Clears $var
                $RSObject = $null # Clears $var
                $RGObject = $null # Clears $var
            } # End elseif ($ManageAzStorageACC -eq '0')
            else { # All other inputs for $ManageAzStorageAcc
                Write-Host "That was not a valid option" # Write message to screen
            } # End else (if ($ManageAzStorageACC -eq 'exit'))
        } # End ManageAzureStorageAcc while ($true)
        Return # Returns to calling function 
    } # End begin
} # End function ManageAzStorageAccount
function NewAzStorageAccount { # Creates a new storage account
    Begin {
        $ErrorActionPreference='silentlyContinue' # Turns off error reporting
        :NewAzureStorageAcc while ($true) { # Outer loop for managing function
            if (!$RGObject) { # If $RGObject is $null
                $RGObject = GetAzResourceGroup  # Calls GetAzResourceGroup and assigns to $RGObject
                if (!$RGObject) { # If $RGObject is still $null
                    Break NewAzureStorageAcc # Breaks NewAzureStorageAcc loop
                } # End if (!$RGObject)
            } # End if (!$RGObject)
            :SetAzureStorageAccName while ($true) { # Inner loop for setting the storage account name
                $StorageAccNameInput = '000100000000001000000' # Assigns a value for elseif statement if operator input is invalid
                try { # Try statement for operator input of account name
                    [ValidatePattern('^[a-z,0-9]+$')][ValidateLength (3, 24)]$StorageAccNameInput = [string](Read-Host "New storage account name").ToLower() # Operator input for the account name, only allows letters and numbers. All letters converted to lowercase
                } # End try
                catch {Write-Host "The provided name was not valid characters in length and use numbers and lower-case letters only"} # Error message for failed try
                if ($StorageAccNameInput -eq 'exit') { # $StorageAccNameInput is equal to exit
                    Break NewAzureStorageAcc # Breaks NewAzureStorageAcc loop
                } # if ($StorageAccNameInput -eq 'exit')
                elseif ($StorageAccNameInput -eq '000100000000001000000') {}# Elseif when Try statement fails
                else { # If Try statement input has value not equal to exit
                    Write-Host $StorageAccNameInput # Writes $var to screen
                    $OperatorConfirm = Read-Host "Is this name correct" # Operator confirmation
                    if ($OperatorConfirm -eq 'y' -or $OperatorConfirm -eq 'yes') { # If $OperatorConfirm is equal to 'y' or 'yes'
                        Break SetAzureStorageAccName # Breaks SetAzureStorageAccName
                    } # End If ($OperatorConfirm -eq 'y' -or $OperatorConfirm -eq 'yes')
                    else {} # If $OperatorConfirm is not -eq 'y' or 'yes;
                } # End else (if ($StorageAccNameInput -eq 'exit'))
            } # :SetAzureStorageAccName while ($true)
            $ValidSku = 'Standard_LRS', 'Standard_GRS', 'Standard_RAGRS', 'Standard_ZRS', 'Premium_LRS', 'Premium_ZRS', 'Standard_GZRS', 'Standard_RAGZRS' # Current list of all skus
            :SetAzureStorageAccSku while ($true) { # Inner loop for setting the sku
                $StorageAccSkuInput = Read-Host "New storage account sku" # Operator input for the sku
                if ($StorageAccSkuInput -eq 'exit') { # If $StorageAccSkuInput -eq 'exit'
                    Break NewAzureStorageAcc # Breaks :NewAzureStorageACC loop
                } # if ($StorageAccNameInput -eq 'exit')
                if ($StorageAccSkuInput -cin $ValidSku) { # If $StorageAccSkuInput is in $ValidSku (Case sensitive)
                    Write-Host $StorageAccSkuInput # Writes $StorageAccSkuInput to screen
                    $OperatorConfirm = Read-Host "Is the Sku correct" # Operator confirmation
                    if ($OperatorConfirm -eq 'y' -or $OperatorConfirm -eq 'yes') { # If $OperatorConfirm is equal to 'y' or 'yes'
                        Break SetAzureStorageAccSku # Breaks :SetAzureStorageAccSku
                    } # End if ($OperatorConfirm -eq 'y' -or $OperatorConfirm -eq 'yes')
                } # End if ($StorageAccNameInput -iin $ValidSku)
                else { # Else for all other inputs 
                    Write-Host "The Sku name provided is not valid" # Write message to screen
                    Write-Host "Select from the following" # Write message to screen
                    Write-Host "" # Write message to screen
                    Write-Host $ValidSku -Separator `n # Write $ValidSku list to screen
                } # End else (if ($StorageAccNameInput -iin $ValidSku))
            } # End :SetAzureStorageAccSku while
            $ValidLocation = Get-AzLocation # Collects the list of all valid Azure locations
            :SetAzureStorageAccLoc while ($true) { # Inner loop for setting the account location
                $StorageAccLocInput = Read-Host "New storage account location" # Operator input for the account location
                if ($StorageAccLocInput -eq 'exit') { # If $StorageAccLocInput is 'exit'
                    Break NewAzureStorageAcc # Breaks :NewAzureStorageAcc
                } # if ($StorageAccNameInput -eq 'exit')
                if ($StorageAccLocInput -iin $ValidLocation.Location) { # if $StorageAccLocInput is in $ValidLocation.Location (Case insensitive)
                    Write-Host $StorageAccLocInput # Write $StorageAccLocInput to screen
                    $OperatorConfirm = Read-Host "Is the location correct" # Operator confirmation
                    if ($OperatorConfirm -eq 'y' -or $OperatorConfirm -eq 'yes') { # If $OperatorConfirm is equal to 'y' or 'yes'
                        Break SetAzureStorageAccLoc # Breaks :SetAzureStorageAccLoc
                    } # End if ($OperatorConfirm -eq 'y' -or $OperatorConfirm -eq 'yes')
                } # End if ($StorageAccLocInput -iin $ValidLocation)
                else { # All other inputs for $StorageAccLocInput
                    Write-Host "The location provided is not valid" # Write message to screen
                    Write-Host "Select from the following" # Write message to screen
                    Write-Host "" # Write message to screen
                    Write-Host $ValidLocation.Location -Separator `n # Writes $ValidLocation.Location to screen
                } # End else (if ($StorageAccLocInput -iin $ValidLocation))
            } # End :SetAzStorageAccLoc while ($true)
            $StorageAccObject = New-AzStorageAccount -ResourceGroupName $RGObject.ResourceGroupName -Location $StorageAccLocInput -Name $StorageAccNameInput -SkuName $StorageAccSkuInput # Creates the new storage account and assigns to $StorageAccObject
            Return $StorageAccObject # Returns $var to calling function
        } # End :NewAzureStorageAcc while ($true)
        Break # Returns to calling function empty
    } # End Begin
} # End function NewAzStorageAccount
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


function RemoveAzStorageAccount { # Function to get a storage account, can pipe $StorageAccObject to another function
    Begin {
        :RemoveAzureStorageAcc while ($true) { # Outer loop for function
            $ErrorActionPreference ='silentlyContinue' # Disables errors
            if (!$StorageAccObject) { # If $StorageAccObject is $null
                $StorageAccObject = GetAzStorageAccount # Calls function and assigns to $var
                    if (!$StorageAccObject) { # If $StorageAccObject is still $null after calling function
                        Break RemoveAzureStorageAcc # Breaks RemoveAzureStorageAcc
                    } # End if (!$StorageAccObject)
            } # End if (!$StorageAccObject)
            else { # Else for when $StorageAccObject is assigned
                $StoreAccName = $StorageAccObject.StorageAccountName # Collects the name of the storage account and assigns to own $var
                $OperatorConfirm = Read-Host "Remove the following storage account" $StorageAccObject.StorageAccountName "in" $StorageAccObject.ResourceGroupName # Operator confimation to remove the storage account
                if (!($OperatorConfirm -eq 'y' -or $OperatorConfirm -eq 'yes')) { # If Operator confirm is not (equal 'y' or 'yes')
                    Break RemoveAzureStorageAcc # Breaks RemoveAzureStorageAcc
                } # End if (!($OperatorConfirm -eq 'y' -or $OperatorConfirm -eq 'yes'))
                Write-Host "Checking for resource locks" # Write message to screen
                $RSObject = Get-AzResource -Name $StorageAccObject.StorageAccountName -ResourceGroupName $StorageAccObject.ResourceGroupName # Collects the $RSObject 
                $RGObject = Get-AzResourceGroup -Name $StorageAccObject.ResourceGroupName # Collects the $RGObject
                $Locks = GetAzResourceLocksAll ($RSObject, $RGObject) #Calls function and assigns to $var
                if ($Locks) { # If $Locks is not $null
                    RemoveAzResourceLocks ($Locks) # Calls function assigns $null
                } # End if ($Locks)
                else { # If $Locks is $null
                    Write-Host "No locks present on this storage account" # Write message to screen
                } # End else (if ($Locks))
                Try { # Try to execute Remove-AzStorageAccount
                    Remove-AzStorageAccount -ResourceGroupName $StorageAccObject.ResourceGroupName -AccountName $StorageAccObject.StorageAccountName -Force -ErrorAction Stop # Removes storage account, -ErrorAction Stop used for catch statement
                } # End Try
                catch { # Try fails
                    Write-Host "The storage account was not deleted" # Write message to screen
                    if (Get-AzResourceLock -ResourceGroupName $StorageAccObject.ResourceGroupName -AtScope) { # If a lock exists on the resource group
                        Write-Host "There are locks on the resource group that must be removed before this storage account can be removed" # Write message to screen
                    } # End if (Get-AzResourceLock -ResourceGroupName $StorageAccObject.ResourceGroupName -AtScope)
                    else { # All other results for failing to remove the storage account
                        Write-Host "You may not have the permissions to remove this storage account" # Write message to screen
                    } # End else (if (Get-AzResourceLock -ResourceGroupName $StorageAccObject.ResourceGroupName -AtScope))
                    Break RemoveAzureStorageAcc # Breaks RemoveAzureStorageAcc
                } # End Catch
                Write-Host $StoreAccName" has been removed" # Write message to screen
                Return # Returns to calling function
            } # End else ((!$StorageAccObject))
        } # End :RemoveAzureStorageAcc while ($true)
        Write-Host "No changes made"
        Return # Returns to calling function with $null
    } # End begin 
} # End function GetAzStorageAccount
function RemoveAzResourceLocks { # Function to remove resource locks, No input validation is done
    Begin {
        if (!$Locks) { # If statement if $Locks is $null
            $Locks = GetAzResourceLocks # Calls GetAzResourceLocks and assigns to $Locks
            if(!$Locks) { # If statement if $Locks is $null after calling function to assign
                Write-Host "RemoveAzResourceLocks function was terminated, no changes made" # Message write to screen
                Return $Locks # Returns to calling function
            } # End if statement
        } # End if statement
        $Locks.Name # Writes all names contained in $Locks
        $OperatorConfirm = Read-Host "Type 'Y' or 'Yes' to remove these locks" # Operator confirmation to remove the listed locks
        if (!($OperatorConfirm -ceq 'Y' -or $OperatorConfirm -ceq 'Yes')) { # If $Operatorconfirm is not (Equal to 'Y' or 'Yes') statement
            $Locks = $null # $Locks is set to $null
            Write-Host "RemoveAzResourceLocks function was terminated, no changes made" # Message write to screen
            Return $Locks # Return to calling function
        } # End if statement
        else { # Else statement if $Operatorconfirm is (Equal to 'Y' or 'Yes')
            $ErrorActionPreference='silentlyContinue' # Disables Errors
            foreach ($LockId in $Locks) { # Completes the command in a loop untill performed on all LockIds within $Locks
                $LockId.name # Prints the LockId for each lock as the cycle goes
                Remove-AzResourceLock -LockId $LockId.LockId -force # Removes the lock by targeting the LockID, -force removes operator confirmation
            } # End foreach loop
            $Locks = $null # Clears $Locks prior to returning to calling function
            Return $Locks # Returns to calling function
        } # End else statement
    } # End begin statement
} # End function
function GetAzResourceLocksAll { # Function to get all locks assigned to a resource, can pipe $Locks to another function
    Begin {
        if (!$RSObject) {
            $RGObject = GetAzResourceGroup # Calls function GetAzResourceGroup and assigns to $RGObject
            if (!$RGObject) { # If statement if $RGObject is $null after calling GetAzResourceObject
                Write-Host "GetAzResourceLocksAll function was terminated" # Message write to screen
                Return # Returns to calling function
            } # End if (!$RGObject)
            $RSObject = GetAzResource # Calls function GetAzResourceGroup and assigns to $RGObject
            if (!$RSObject) { # If statement if $RGObject is $null after calling GetAzResourceObject
                Write-Host "GetAzResourceLocksAll function was terminated" # Message write to screen
                Return # Returns to calling function
            } # End if if (!$RSObject)
        } # End if (!$RSObject)
        $Locks = Get-AzResourceLock -ResourceGroupName $RSObject.ResourceGroupName -ResourceName $RSObject.Name -ResourceType $RSObject.ResourceType | Where-Object {$_.ResourceName -eq $RSObject.Name} # Collects all locks and assigns to $Locks
        if (!$Locks) { # If statement for no object assigned to $Locks
            Write-Host "No locks are on this resource" # Write message to screen
            Write-Host "The GetAzResourceLocksAll function was terminated" # Message write to screen
            Return # Returns to calling function
        } # End if statement
        else { # Else statement for an object being assigned to $Locks
            Write-Host $Locks.Name -Separator `n # Write-host used so list is written to screen when function is used as $Locks = GetAzResourceLocksAll
            Return $Locks # Returns $Locks to the calling function
        } # End else statement
    } # End begin statement
} # End function   
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