# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Mircosoft docs links
    New-AzStorageAccount:       https://docs.microsoft.com/en-us/powershell/module/az.storage/new-azstorageaccount?view=azps-5.2.0
    Get-AzStorageAccount:       https://docs.microsoft.com/en-us/powershell/module/az.storage/get-azstorageaccount?view=azps-5.2.0
    Remove-AzStorageAccount:    https://docs.microsoft.com/en-us/powershell/module/az.storage/remove-azstorageaccount?view=azps-5.2.0
    Get-AzResourceGroup:        https://docs.microsoft.com/en-us/powershell/module/az.resources/get-azresourcegroup?view=azps-5.1.0
    Get-AzResourceLock:         https://docs.microsoft.com/en-us/powershell/module/az.resources/get-azresourcelock?view=azps-5.0.0       
    Get-AzLocation:             https://docs.microsoft.com/en-us/powershell/module/az.resources/get-azlocation?view=azps-5.2.0
} #>
<# Required Functions Links: {
    NewAzStorageAccount:        https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Storage/Storage%20Account/NewAzStorageAccount.ps1
    ListAzStorageAccount:       https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Storage/Storage%20Account/ListAzStorageAccount.ps1
    GetAzStorageAccount:        https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Storage/Storage%20Account/GetAzStorageAccount.ps1
    RemoveAzStorageAccount:     https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Storage/Storage%20Account/RemoveAzStorageAccount.ps1
    GetAzResourceGroup:         https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/GetAzResourceGroup.ps1
    GetAzLocation:              https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/Locations/GetAzLocation.ps1
} #>
<# Functions Description: {
    ManageAzStorageAccount:     Management function for storage accounts
    NewAzStorageAccount:        Creates new storage account object
    GetAzStorageAccount:        Collects the storage account object
    RemoveAzStorageAccount:     Removes the selected storage account
    GetAzResourceGroup:         Collects resource group object
    GetAzLocation:              Gets an AzureLocation
} #>
<# Variables: {
    :ManageAzureStorageAcc      Outer loop for managing function
    $OpSelect:                  Operator input for selecting management function
    NewAzStorageAccount{}       Creates $StorageAccObject
    ListAzStorageAccount{}      Lists $StorageAccObject
    GetAzStorgeAccount{}        Gets $StorageAccObject
    RemoveAzStorageAccount{}    Gets $StorageAccObject
}#>
<# Process Flow {
    function
        Call ManageAzStorageAccount > Get $null
            Call NewAzStorageAccount > Get $null
                Call GetAzResourceGroup > Get $RGObject
                End GetAzResourceGroup
                    Return NewAzStorageAccount > Send $RGObject
                Call GetAzLocation > Get $LocationObject
                End GetAzLocation
                    Return NewAzStorageAccount > Send $LocationObject
            End NewAzStorageAccount 
                Return ManageAzStorageAccount > Send $null
            Call ListAzStorageAccount > Get $null
            End ListAzStorageAccount 
                Return ManageAzStorageAccount > Send $null
            Call GetAzStorageAccount > Get $null
                Call GetAzResourceGroup > Get $RGObject
                End GetAzResourceGroup
                    Return GetAzStorageAccount > Send $RGObject
            End GetAzStorageAccount 
                Return ManageAzStorageAccount > Send $null
            Call RemoveAzStorageAccount > Get $null
                Call GetAzStorageAccount > Get $StorageAccObject
                    Call GetAzResourceGroup > Get $RGObject
                    End GetAzResourceGroup
                        Return GetAzStorageAccount > Send $RGObject 
                End GetAzStorageAccount    
                    Return RemoveAzStorageAccount > Send $StorageAccObject
            End RemoveAzStorageAccount
                Return ManageAzStorageAccount > Send $null
        End ManageAzStorageAccount
            Return function > Send $null
}#>
function ManageAzStorageAccount {                                                           # Management function for storage accounts
    Begin {                                                                                 # Begin function
        :ManageAzureStorageAcc while ($true) {                                              # Outer loop for managing function
            Write-Host 'Azure Storage Account Management'                                   # Write message to screen
            Write-Host '[0] Exit'                                                           # Write message to screen
            Write-Host '[1] New Storage Account'                                            # Write message to screen
            Write-Host '[2] List Storage Accounts'                                          # Write message to screen
            Write-Host '[3] Get Storage Account'                                            # Write message to screen
            Write-Host '[4] Remove Storage Account'                                         # Write message to screen
            $OpSelect = Read-Host 'Option [#]'                                              # Operator input for management function selection
            Clear-Host                                                                      # Clears screen
            if ($OpSelect -eq '0') {                                                        # If $OpSelect equals '0'
                Break ManageAzureStorageAcc                                                 # Breaks :ManageAzureStorageAcc
            }                                                                               # End if ($OpSelect -eq '0')
            elseif ($OpSelect -eq '1') {                                                    # Else if $OpSelect equals '1'
                Write-Host 'New Storage Account'                                            # Write message to screen
                NewAzStorageAccount                                                         # Calls function
            }                                                                               # End elseif ($OpSelect -eq '1')
            elseif ($OpSelect -eq '2') {                                                    # Else if $OpSelect equals '2'
                Write-Host 'List Storage Accounts'                                          # Write message to screen
                ListAzStorageAccount                                                        # Calls function
            }                                                                               # End elseif ($OpSelect -eq '2')
            elseif ($OpSelect -eq '3') {                                                    # Else if $OpSelect equals '3'
                Write-Host 'Get Storage Account'                                            # Write message to screen
                GetAzStorageAccount                                                         # Calls function and assigns to $var
            }                                                                               # End elseif ($OpSelect -eq '3')
            elseif ($OpSelect -eq '4') {                                                    # Else if $OpSelect equals '4'
                Write-Host 'Remove Storage Accounts'                                        # Write message to screen
                RemoveAzStorageAccount                                                      # Calls function
            }                                                                               # End elseif ($OpSelect -eq '4')
            else {                                                                          # All other inputs for $OpSelect
                Write-Host 'That was not a valid input'                                     # Write message to screen
                Write-Host ''                                                               # Write message to screen
                Pause                                                                       # Pauses all actions for operator input
                Clear-Host                                                                  # Clears screen
            }                                                                               # End else (if ($OpSelect -eq '0'))
        }                                                                                   # End ManageAzureStorageAcc while ($true)
        Return $null                                                                        # Returns to calling function 
    }                                                                                       # End begin
}                                                                                           # End function ManageAzStorageAccount
function NewAzStorageAccount {                                                              # Creates a new storage account
    Begin {                                                                                 # Begin function
        $ErrorActionPreference='silentlyContinue'                                           # Turns off error reporting
        $CallingFunction = 'NewAzStorageAccount'                                            # Creates $CallingFunction
        :NewAzureStorageAcc while ($true) {                                                 # Outer loop for managing function
            $RGObject = GetAzResourceGroup ($CallingFunction)                               # Calls function and assigns output to $var
            if (!$RGObject) {                                                               # If $RGObject is $null
                Break NewAzureStorageAcc                                                    # Breaks :NewAzureStorageAcc 
            }                                                                               # End if (!$RGObject)
            :SetAzureStorageAccName while ($true) {                                         # Inner loop for setting the storage account name
                $StorageAccNameInput = '0'                                                  # Sets a fail value for $StorageAccNameInput
                try {                                                                       # Try the following
                    Write-Host 'Storage account name must be between 3-24 characters'       # Write message to screen
                    Write-Host 'May only use letters and numbers'
                    [ValidatePattern('^[a-z,0-9]+$')]$StorageAccNameInput = `
                        [string](Read-Host 'New storage account name').ToLower()            # Operator input for the account name
                }                                                                           # End try
                catch {                                                                     # If try fails
                    Write-Host "The account name must only include letters and numbers"     # Write message to screen
                }                                                                           # End catch
                if ($StorageAccNameInput -eq 'exit') {                                      # $StorageAccNameInput is equal to 'exit'
                    Break NewAzureStorageAcc                                                # Breaks :NewAzureStorageAcc
                }                                                                           # if ($StorageAccNameInput -eq 'exit')
                elseif ($StorageAccNameInput.Length -le 2 `
                    -or $StorageAccNameInput.Length -ge 25) {                               # Else if $StorageAccNameInput is not between 3 and 24 characters
                    Write-Host `
                        "The account name must be between 3 and 24 characters in length"    # Write message to screen
                        Start-Sleep(5)                                                      # Pauses all actions for 5 seconds
                        Clear-Host                                                          # Clears the screen
                }                                                                           # End elseif ($StorageAccNameInput.Length -le 2 -or $StorageAccNameInput.Length -ge 25)
                else {                                                                      # All other inputs for $StorageAccNameInput
                    Write-Host 'Use'$StorageAccNameInput' as the name'                      # Writes $var to screen
                    $OpConfirm = Read-Host '[Y] or [N]'                                     # Operator confirmation
                    if ($OpConfirm -eq 'y') {                                               # If $OpConfirm is equal to 'y'
                        Clear-Host                                                          # Clears the screen
                        Break SetAzureStorageAccName                                        # Breaks :SetAzureStorageAccName
                    }                                                                       # End If ($OpConfirm -eq 'y')
                }                                                                           # End else (if ($StorageAccNameInput -eq 'exit'))
            }                                                                               # :SetAzureStorageAccName while ($true)
            $ValidSkuList = @('Standard_LRS', 'Standard_GRS', 'Standard_RAGRS', `
                'Standard_ZRS','Premium_LRS', 'Premium_ZRS', 'Standard_GZRS', `
                'Standard_RAGZRS')                                                          # Current list of all skus
                $ObjectNumber = 1                                                           # Sets $ObjectNumber to 1
                [System.Collections.ArrayList]$ObjectArray = @()                            # Creates the RG list array
                foreach ($_ in $ValidSkuList) {                                             # For each $_ in $ValidSkuList
                    $ObjectInput = [PSCustomObject]@{'Name' = $_; `
                        'Number' = $ObjectNumber}                                           # Creates the item to loaded into array
                    $ObjectArray.Add($ObjectInput) | Out-Null                               # Loads item into array, out-null removes write to screen
                    $ObjectNumber = $ObjectNumber + 1                                       # Increments $ObjectNumber by 1
                }                                                                           # End foreach ($_ in $ObjectList)
                Write-Host "[0]  Exit"                                                      # Write message to screen
                foreach ($_ in $ObjectArray) {                                              # For each $_ in $ObjectArray
                    $Number = $_.Number                                                     # Sets $Number to current item .number
                    if ($_.Number -le 9) {                                                  # If current item .number is 9 or less
                        Write-Host "[$Number] "$_.Name                                      # Write message to screen
                    }                                                                       # End if ($_.Number -le 9) 
                    else {                                                                  # If current item .number is greater then 9
                        Write-Host "[$Number]"$_.Name                                       # Write message to screen
                    }                                                                       # End else (if ($_.Number -le 9) )
                }                                                                           # End foreach ($_ in $ObjectArray)
            :SetAzureStorageAccSku while ($true) {                                          # Inner loop for setting the sku
                $StorageAccSkuInput = Read-Host 'Enter option [#]'                          # Operator input for the storage account sku
                if ($StorageAccSkuInput -eq '0') {                                          # If $StorageAccSkuInput equals '0'
                    Break NewAzureStorageAcc                                                # Breaks :NewAzureStorageACC
                }                                                                           # if ($StorageAccNameInput -eq '0')
                if ($StorageAccSkuInput -in $ObjectArray.Number) {                          # If $StorageAccSkuInput is in $ObjectArray.Number
                    $StorageAccSkuInput = $ObjectArray | Where-Object `
                        {$_.Number -eq $StorageAccSkuInput}                                 # $StorageAccSkuInput equals $ObjectArray where $ObjectArray.Number equals $StorageAccSkuInput
                    $StorageAccSkuInput = $StorageAccSkuInput.name                          # Isolates the sku name
                    Clear-Host                                                              # Clears the screen
                    Break SetAzureStorageAccSku                                             # Breaks :SetAzureStorageAccSku
                }                                                                           # End if ($StorageAccNameInput -in $ObjectArray.Number)
                else {                                                                      # Else for all other inputs 
                    Write-Host "That was not a valid input"                                 # Write message to screen
                }                                                                           # End else (if ($StorageAccNameInput -in $ObjectArray.Number))
            }                                                                               # End :SetAzureStorageAccSku while ($true)
            $LocationObject = GetAzLocation                                                 # Calls function and assigns output to $var
            Clear-Host                                                                      # Clears the screen
            if (!$LocationObject) {                                                         # If $LocationObject is $null
                Break NewAzureStorageAcc                                                    # Breaks :NewAzureStorageAcc
            }                                                                               # End if (!$LocationObject)
            try {                                                                           # Try the following
                Write-Host 'Creating the storage account'                                   # Write message to screen
                Write-Host 'This may take a minute'                                         # Write message to screen
                New-AzStorageAccount -ResourceGroupName $RGObject.ResourceGroupName `
                    -Location $LocationObject.location -Name $StorageAccNameInput `
                    -SkuName $StorageAccSkuInput -ErrorAction 'Stop'                        # Creates the new storage account
            }                                                                               # End try
            catch {                                                                         # If try fails
                Write-Host 'An error has occured'                                           # Write message to screen
                Start-Sleep(5)                                                              # Pauses all actions for 5 seconds
                Break NewAzureStorageAcc                                                    # Breaks :NewAzureStorageAcc
            }                                                                               # End catch
            Write-Host 'The storage account has been made'                                  # Write message to screen
            Start-Sleep(5)                                                                  # Pause all actions for 5 seconds
            Break NewAzureStorageAcc                                                        # Breaks :NewAzureStorageAcc
        }                                                                                   # End :NewAzureStorageAcc while ($true)
        Clear-Host                                                                          # Clears the screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End Begin
}                                                                                           # End function NewAzStorageAccount
function ListAzStorageAccount {                                                             # Function to list storage accounts
    Begin {                                                                                 # Begin function
        :ListAzureStorageAcc while ($true) {                                                # Outer loop for managing function
            Write-Host 'Getting storage account info'                                       # Write message to screen
            Write-Host 'This may take a moment'                                             # Write message to screen
            [System.Collections.ArrayList]$ObjectArray = @()                                # Creates the object array
            $RGObject = Get-AzResourceGroup                                                 # List of all resource groups
            foreach ($_ in $RGObject) {                                                     # For each item in $RGObject
                $CurrentRG = $_.ResourceGroupName                                           # Isolates the current item .ResourceGroupName
                $ObjectList = Get-AzStorageAccount -ResourceGroupName `
                    $CurrentRG                                                              # Collects all storage accounts in $CurrentRG and assigns to $ObjectList
                foreach ($_ in $ObjectList) {                                               # For each $_ in $ObjectListList
                    $ObjectInput = [PSCustomObject]@{'Name' = $_.StorageAccountName; `
                        'Number' = $ObjectNumber;'Sku'=$_.Sku.Name;`
                        'AccTier'=$_.AccessTier;'Location'=$_.PrimaryLocation;`
                        'RG'=$CurrentRG}                                                    # Creates the item to loaded into array
                    $ObjectArray.Add($ObjectInput) | Out-Null                               # Loads item into array, out-null removes write to screen
                }                                                                           # End foreach ($_ in $ObjectList)
            }                                                                               # End foreach ($_ in $RGObject)
            Write-Host ''                                                                   # Write message to screen
            foreach ($_ in $ObjectArray) {                                                  # For each $_ in $ObjectArray
                Write-Host 'Store Acc Name:'$_.Name                                         # Write message to screen
                Write-Host 'Resource Group:'$_.RG                                           # Write message to screen
                Write-Host 'Primary Loc:   '$_.Location                                     # Write message to screen
                Write-Host 'Sku Name:      '$_.Sku                                          # Write message to screen
                Write-Host 'Access Tier:   '$_.AccTier                                      # Write message to screen
                Write-Host ''                                                               # Write message to screen
            }                                                                               # End foreach ($_ in $ObjectArray)
            Pause                                                                           # Pauses for operator
            Break ListAzureStorageAcc                                                       # Breaks :ListAzureStorageAcc  
        }                                                                                   # End :ListAzureStorageAcc while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End begin 
}                                                                                           # End function GetAzStorageAccount
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
function RemoveAzStorageAccount {                                                           # Function to remove a storage account
    Begin {                                                                                 # Begin function
        if (!$CallingFunction) {                                                            # If $CallingFunction does not exist
            $CallingFunction = 'RemoveAzStorageAccount'                                     # Creates $CallingFunction
        }                                                                                   # End if (!$CallingFunction)
        :RemoveAzureStorageAcc while ($true) {                                              # Outer loop for managing function
            $StorageAccObject = GetAzStorageAccount ($CallingFunction)                      # Calls function and assigns to $var
            if (!$StorageAccObject) {                                                       # If $StorageAccObject is $null
                Break RemoveAzureStorageAcc                                                 # Breaks RemoveAzureStorageAcc
            }                                                                               # End if (!$StorageAccObject)
            Write-Host 'Remove storage account:'$StorageAccObject.StorageAccountName        # Write message to screen
            Write-Host 'From resource group:'$StorageAccObject.ResourceGroupName            # Write message to screen
            $OpConfirm = Read-Host '[Y] or [N]'                                             # Operator confimation to remove the storage account
            if ($OpConfirm -ne 'y') {                                                       # If $OpConfirm is not equal to 'y'
                Break RemoveAzureStorageAcc                                                 # Breaks RemoveAzureStorageAcc
            }                                                                               # End if ($OpConfirm -ne 'y')
            Clear-Host                                                                      # Clears screen
            Write-Host "Checking for resource locks"                                        # Write message to screen
            $RSLocks = Get-AzResourceLock | Where-Object `
                {$_.ResourceName -eq $StorageAccObject.StorageAccountName}                  # Collects all locks on the storage account
            $RGLocks = Get-AzResourceLock -ResourceGroupName `
                $StorageAccObject.ResourceGroupName -AtScope                                # Collects all locks on the resource group holding the storage account
            if ($RSLocks -or $RGLocks) {      
                if ($RSLocks) {                                                             # If $RSLocks is not $null
                    Write-Host ''                                                           # Write message to screen
                    Write-Host 'There are locks on this this resource'                      # Write message to screen
                    Start-Sleep(2)                                                          # Pauses all actions for 2 seconds
                }                                                                           # End if ($RSLocks)
                if ($RGLocks) {                                                             # If $RGLocks is not $null
                    Write-Host ''                                                           # Write message to screen
                    Write-Host 'There are locks on the storage'                             # Write message to screen
                    Write-Host "accounts's resource group"                                  # Write message to screen
                    Start-Sleep(2)                                                          # Pauses all actions for 2 seconds
                }                                                                           # End if ($RGLocks)
                Write-Host ''                                                               # Write message to screen
                Write-Host 'All locks will need to be removed'                              # Write message to screen
                Write-Host 'prior to removing this storage account'                         # Write message to screen
                Start-Sleep(5)                                                              # Pauses all actions for 5 seconds
                Break RemoveAzureStorageAcc                                                 # Breaks :RemoveAzureStorageAcc
            }                                                                               # End if ($RSLocks -or $RGLocks)
            else {                                                                          # If $RSLocks and $RGLocks are $null
                Write-Host "No locks present on this storage account"                       # Write message to screen
            }                                                                               # End else (if ($RSLocks -or $RGLocks) )
            Try {                                                                           # Try the following
                Remove-AzStorageAccount -ResourceGroupName `
                    $StorageAccObject.ResourceGroupName -AccountName `
                    $StorageAccObject.StorageAccountName -Force -ErrorAction 'Stop'         # Removes storage account
            }                                                                               # End Try
            catch {                                                                         # Try fails
                Write-Host 'The storage account was not deleted'                            # Write message to screen
                Write-Host 'You may not have the permissions'                               # Write message to screen
                Write-host 'to remove this storage account'                                 # Write message to screen
                Start-Sleep(10)                                                             # Pauses all actions for 10 seconds
                Break RemoveAzureStorageAcc                                                 # Breaks RemoveAzureStorageAcc
            }                                                                               # End Catch
            Write-Host 'The selected storage account has been removed'                      # Write message to screen
            Start-Sleep(5)                                                                  # Pauses all actions for 5 seconds
            Break RemoveAzureStorageAcc                                                     # Breaks :RemoveAzureStorageAcc
        }                                                                                   # End :RemoveAzureStorageAcc while ($true)
        Clear-Host                                                                          # Clears screen
        Return $null                                                                        # Returns to calling function with $null
    }                                                                                       # End begin 
}                                                                                           # End function GetAzStorageAccount 
# Additional functions required for ManageAzStorageAccount
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
function GetAzLocation {                                                                    # Function to get azure location
    Begin {                                                                                 # Begin function
        :GetAzureLocation while ($true) {                                                   # Outer loop for managing function
            $ListObject = Get-AzLocation                                                    # Gets a list of all Azure locations
            $ListNumber = 1                                                                 # $Var for selecting the location
            [System.Collections.ArrayList]$ListArray = @()                                  # Creates the list array
            foreach ($_ in $ListObject) {                                                   # For each $_ in $ListObject
                $ListInput = [PSCustomObject]@{'Number' = $ListNumber; 'Location' `
                = $_.DisplayName}                                                           # Creates the item to load into array
                $ListArray.Add($ListInput) | Out-Null                                       # Loads item into array, out-null removes write to screen
                $ListNumber = $ListNumber + 1                                               # Increments $ListNumber by 1
            }                                                                               # End foreach ($_ in $ListObject)
            Write-Host "[ 0 ] Exit"                                                         # Write message to screen
            foreach ($_ in $ListArray) {                                                    # For each $_ in $ListArray
                Write-Host '['$_.Number']' $_.Location                                      # Writes number and location to screen
            }                                                                               # End foreach ($_ in $ListArray)
            :SelectAzureLocation while ($true) {                                            # Inner loop for selecting location from list
                if ($CallingFunction) {                                                     # If $CallingFunction exists
                    Write-Host "You are selecting the location for"$CallingFunction         # Write message to screen
                }                                                                           # End if ($CallingFunction)
                $LocationSelect = Read-Host "Please enter [#] of the location"              # Operator input for the selection
                if ($LocationSelect -eq '0') {                                              # If $LocationSelect is 0
                    Break GetAzureLocation                                                  # Breaks :GetAzureLocation
                }                                                                           # End if ($LocationSelect -eq '0')
                elseif ($LocationSelect -in $ListArray.Number) {                            # If $LocationSelect in $ListArray.Number
                    $LocationSelect = $ListArray | Where-Object {$_.Number -eq `
                        $LocationSelect}                                                    # LocationSelect is equal to $ListArray where $LocationSelect equals $ListArray.Number
                    Try {                                                                   # Try the following
                        $LocationObject = Get-AzLocation | Where-Object {$_.DisplayName `
                            -eq $LocationSelect.Location} -ErrorAction 'Stop'               # Pulls the full $LocationObject
                    }                                                                       # End try
                    catch {                                                                 # If try fails
                        Write-Host 'An error has occured'                                   # Write message to screen
                        Write-Host 'Please try again later'                                 # Write message to screen
                        Break GetAzureLocation                                              # Breaks :GetAzureLocation 
                    }                                                                       # End catch
                    Clear-Host                                                              # Clears screen
                    Return $LocationObject                                                  # Returns $LocationObject to calling function
                }                                                                           # End elseif ($LocationSelect -in $ListArray.Number) 
                else {                                                                      # All other inputs for $LocationSelect
                    Write-Host "That was not a valid selection"                             # Write message to screen   
                }                                                                           # End else (if ($LocationSelect -eq '0'))
            }                                                                               # End :SelectAzureLocation while ($true)
        }                                                                                   # End :GetAzureLocation while ($true)
        Clear-Host                                                                          # Clears screen
        Return                                                                              # Returns with $null 
    }                                                                                       # End Begin
}                                                                                           # End function GetAzLocation