# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Mircosoft docs links
    New-AzStorageAccount:       https://docs.microsoft.com/en-us/powershell/module/az.storage/new-azstorageaccount?view=azps-5.2.0
    Get-AzResourceGroup:        https://docs.microsoft.com/en-us/powershell/module/az.resources/get-azresourcegroup?view=azps-5.1.0
    Get-AzLocation:             https://docs.microsoft.com/en-us/powershell/module/az.resources/get-azlocation?view=azps-5.2.0             
} #>
<# Required Functions Links: {
    GetAzResourceGroup:         https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/Resource%20Groups/GetAzResourceGroup.ps1
    GetAzLocation:              https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/Locations/GetAzLocation.ps1
} #>
<# Functions Description: {
    NewAzStorageAccount:        Creates new storage account object
    GetAzResourceGroup:         Collects resource group object
    GetAzLocation:              Gets an Azure location
} #>
<# Variables: {
    :NewAzureStorageAcc         Outer loop for function
    :SetAzureStorageAccName     Inner loop for setting name
    :SetAzureStorageAccSku      Inner loop for setting sku
    $OpConfirm:                 Operator input to confirm previous inputs
    $RGObject:                  Resource group object
    $StorageAccNameInput:       Operator input for name
    $StorageAccSkuInput:        Operator input for sku
    $ValidSkuList:              List of valid storage account skus
    $ObjectNumber:              $var used for selecting the sku
    $ObjectArray:               Array of skus
    $ObjectInput:               $var used to load items into $ObjectArray
    $Number:                    Current item .Number, used for formatting
    $LocationObject:            Azure location
    GetAzResourceGroup{}        Gets $RGObject
    GetAzLocation{}             Gets $LocationObject
} #>
<# Process Flow {
    function
        Call NewAzStorageAccount > Get $null
            Call GetAzResourceGroup > Get $RGObject
            End GetAzResourceGroup
                Return NewAzStorageAccount > Send $RGObject
            Call GetAzLocation > Get $LocationObject
            End GetAzLocation
                Return NewAzStorageAccount > Send $LocationObject
        End NewAzStorageAccount 
            Return Function > Send $null
}#>
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