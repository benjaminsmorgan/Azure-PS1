# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Mircosoft docs links
    New-AzStorageAccount:       https://docs.microsoft.com/en-us/powershell/module/az.storage/new-azstorageaccount?view=azps-5.2.0
    Get-AzStorageAccount:       https://docs.microsoft.com/en-us/powershell/module/az.storage/get-azstorageaccount?view=azps-5.2.0
    Get-AzResourceGroup:        https://docs.microsoft.com/en-us/powershell/module/az.resources/get-azresourcegroup?view=azps-5.1.0
} #>
<# Required Functions Links: {
    NewAzStorageAccount:        https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Storage/Storage%20Account/NewAzStorageAccount.ps1
    GetAzStorageAccount:        https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Storage/Storage%20Account/GetAzStorageAccount.ps1
    RemoveAzStorageAccount:     TBD
    GetAzResourceGroup:         https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/GetAzResourceGroup.ps1
} #>
<# Functions Description: {
    ManageAzStorageAccount:     Management function for storage accounts
    NewAzStorageAccount:        Creates new storage account object
    GetAzStorageAccount:        Collects the storage account object
    GetAzResourceGroup:         Collects resource group object
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
            Write-Host "'Exit to return'" # Write message to screen
            $ManageAzStorageACC = Read-Host "Option?" # Collects operator input on $ManageAzStorageACC option
            if ($ManageAzStorageACC -eq 'exit') { # Exit if statement for this function
                Break ManageAzureStorageAcc # Ends :ManageAzureStorageAcc loop, leading to return statement
            } # End if ($ManageAzStorageACC -eq 'exit')
            elseif ($ManageAzStorageACC -eq '1') { # Elseif statement for creating storage accounts
                Write-Host "New Storage Account" # Write message to screen
                $StorageAccObject = NewAzStorageAccount
                Write-Host $StorageAccObject.StorageAccountName $StorageAccObject.PrimaryLocation $StorageAccObject.Kind 
            } # End elseif ($ManageAzStorageACC -eq '1')
            elseif ($ManageAzStorageACC -eq '2') { # Elseif statement for getting storage accounts
                Write-Host "Get Storage Account" # Write message to screen
                $StorageAccObject = GetAzStorageAccount ($RGObject)
                Write-Host $StorageAccObject.StorageAccountName $StorageAccObject.PrimaryLocation $StorageAccObject.Kind 
            } # End elseif ($ManageAzStorageACC -eq '2')
            elseif ($ManageAzStorageACC -eq '3') { # Elseif statement for removing storage accounts
                Write-Host "Remove Storage Accounts" # Write message to screen
                
            } # End elseif ($ManageAzStorageACC -eq '3')
        } # End ManageAzureStorageAcc while ($true)
        Return # Returns to calling function if no search option is used
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
    } # End of begin statement
} # End of function
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