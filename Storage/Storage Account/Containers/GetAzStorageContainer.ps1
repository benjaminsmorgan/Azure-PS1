# Benjamin Morgan benjamin.s.morgan@outlook.com 
<# Ref: { Microsoft docs links
    Get-AzStorageContainer:     https://docs.microsoft.com/en-us/powershell/module/az.storage/get-azstoragecontainer?view=azps-5.2.0
    Get-AzStorageAccount:       https://docs.microsoft.com/en-us/powershell/module/az.storage/get-azstorageaccount?view=azps-5.2.0
    Get-AzResourceGroup:        https://docs.microsoft.com/en-us/powershell/module/az.resources/get-azresourcegroup?view=azps-5.1.0
} #>
<# Required Functions Links: {
    GetAzStorageAccount:        https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Storage/Storage%20Account/GetAzStorageAccount.ps1
    GetAzResourceGroup:         https://github.com/benjaminsmorgan/Azure-Powershell/blob/main/Resource%20Groups/GetAzResourceGroup.ps1
} #>
<# Functions Description: {
    GetAzStorageContainer:      Collects storage container in a storage account    
    GetAzStorageAccount:        Collects the storage account object
    GetAzResourceGroup:         Collects storage container object
} #>
<# Variables: {
    :GetAzureStorageContainer   Outer loop for managing function
    :SelectAzureObjectList      Inner loop to select the storage container
    $CallingFunction:           Name of this function or the one that called it
    $StorageAccObject:          Storage account object
    $ObjectList:                List of all containers in $StorageAccObject
    $ObjectNumber:              $var used for listing and selecting container
    $ObjectArray:               Array holding the storage containers info
    $ObjectInput:               $var used to load items into $ObjectArray
    $Number:                    Current item .Number, used for formatting
    $ObjectSelect:              Operator input for selecting the container
    $StorageConObject:          Storage container object
    GetAzStorageAccount{}       Gets $StorageAccObject    
        GetAzResourceGroup{}        Gets $RGObject
} #>
<# Process Flow {
    function
        Call GetAzStorageContainer > Get $StorageConObject
            Call GetAzStorageAccount > Get $StorageAccObject
                Call GetAzResourceGroup > Get $RGObject
                End GetAzResourceGroup
                    Return GetAzStorageAccount > Send $RGObject
            End GetAzStorageAccount 
                Return GetAzStorageContainer > Send $StorageAccObject
        End GetAzStorageContainer 
            Return Function > Send $StorageConObject, $StorageAccObject
}#>
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